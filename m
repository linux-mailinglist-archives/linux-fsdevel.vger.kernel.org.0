Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2134C751242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjGLVLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjGLVLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:11:39 -0400
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [IPv6:2001:41d0:203:375::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E0E1FE9
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRjSY9kpVwgW2a61i7EdjuyktV0StcLh7oZx6fNGjZ4=;
        b=qgNofqLdr5BBXuH8Eyt7wUXxAF8PRNvIR/SEb1CrJKD54or6HkTiHAUbrs054ayDAGg+t9
        WRkLIGLeI4fHnaEc/atC1J47nVj0bwHMOhVhaky+/ViUJJUo7jAOxPZheDYjiFSv1G1uII
        IIUADGn1prNv6ipJUzXnh9p3V5ddirM=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        =?UTF-8?q?Andreas=20Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Subject: [PATCH 01/20] sched: Add task_struct->faults_disabled_mapping
Date:   Wed, 12 Jul 2023 17:10:56 -0400
Message-Id: <20230712211115.2174650-2-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

There has been a long standing page cache coherence bug with direct IO.
This provides part of a mechanism to fix it, currently just used by
bcachefs but potentially worth promoting to the VFS.

Direct IO evicts the range of the pagecache being read or written to.

For reads, we need dirty pages to be written to disk, so that the read
doesn't return stale data. For writes, we need to evict that range of
the pagecache so that it's not stale after the write completes.

However, without a locking mechanism to prevent those pages from being
re-added to the pagecache - by a buffered read or page fault - page
cache inconsistency is still possible.

This isn't necessarily just an issue for userspace when they're playing
games; filesystems may hang arbitrary state off the pagecache, and so
page cache inconsistency may cause real filesystem bugs, depending on
the filesystem. This is less of an issue for iomap based filesystems,
but e.g. buffer heads caches disk block mappings (!) and attaches them
to the pagecache, and bcachefs attaches disk reservations to pagecache
pages.

This issue has been hard to fix, because
 - we need to add a lock (henceforth calld pagecache_add_lock), which
   would be held for the duration of the direct IO
 - page faults add pages to the page cache, thus need to take the same
   lock
 - dio -> gup -> page fault thus can deadlock

And we cannot enforce a lock ordering with this lock, since userspace
will be controlling the lock ordering (via the fd and buffer arguments
to direct IOs), so we need a different method of deadlock avoidance.

We need to tell the page fault handler that we're already holding a
pagecache_add_lock, and since plumbing it through the entire gup() path
would be highly impractical this adds a field to task_struct.

Then the full method is:
 - in the dio path, when we take first pagecache_add_lock, note the
   mapping in task_struct
 - in the page fault handler, if faults_disabled_mapping is set, we
   check if it's the same mapping as the one taking a page fault for,
   and if so return an error.

   Then we check lock ordering: if there's a lock ordering violation and
   trylock fails, we'll have to cycle the locks and return an error that
   tells the DIO path to retry: faults_disabled_mapping is also used for
   signalling "locks were dropped, please retry".

Also relevant to this patch: mapping->invalidate_lock.
mapping->invalidate_lock provides most of the required semantics - it's
used by truncate/fallocate to block pages being added to the pagecache.
However, since it's a rwsem, direct IOs would need to take the write
side in order to block page cache adds, and would then be exclusive with
each other - we'll need a new type of lock to pair with this approach.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
---
 include/linux/sched.h | 1 +
 init/init_task.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d..bc7b61305c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -871,6 +871,7 @@ struct task_struct {
 
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
+	struct address_space		*faults_disabled_mapping;
 
 	int				exit_state;
 	int				exit_code;
diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe..f703116e05 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -85,6 +85,7 @@ struct task_struct init_task
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
+	.faults_disabled_mapping = NULL,
 	.restart_block	= {
 		.fn = do_no_restart_syscall,
 	},
-- 
2.40.1

