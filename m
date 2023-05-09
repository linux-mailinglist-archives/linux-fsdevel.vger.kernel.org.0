Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF296FCBEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjEIQ5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjEIQ50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:26 -0400
Received: from out-9.mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6694ED6
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5i0UV4XUiq/O8euXN5wZ8WzR/MP84BiMxFHt/1Czt4=;
        b=iW5mq41x5yiJn7gfvLTGaqQQdNpqEW8JmuzeTOK8Sfw4u+jcMap56jXivpM0QqNJ8IMBqF
        3re0jfAERex9kaSEuHDeD0891yfxuIr+YxKFkBDI5xLP7ONOmVUqy+vtWc7eEx3mg/+NBS
        BLTetoZLlSSytF0SvKiLN6RhTyaI7o8=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
Date:   Tue,  9 May 2023 12:56:31 -0400
Message-Id: <20230509165657.1735798-7-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This is used by bcachefs to fix a page cache coherency issue with
O_DIRECT writes.

Also relevant: mapping->invalidate_lock, see below.

O_DIRECT writes (and other filesystem operations that modify file data
while bypassing the page cache) need to shoot down ranges of the page
cache - and additionally, need locking to prevent those pages from
pulled back in.

But O_DIRECT writes invoke the page fault handler (via get_user_pages),
and the page fault handler will need to take that same lock - this is a
classic recursive deadlock if userspace has mmaped the file they're DIO
writing to and uses those pages for the buffer to write from, and it's a
lock ordering deadlock in general.

Thus we need a way to signal from the dio code to the page fault handler
when we already are holding the pagecache add lock on an address space -
this patch just adds a member to task_struct for this purpose. For now
only bcachefs is implementing this locking, though it may be moved out
of bcachefs and made available to other filesystems in the future.

---------------------------------

The closest current VFS equivalent is mapping->invalidate_lock, which
comes from XFS. However, it's not used by direct IO.  Instead, direct IO
paths shoot down the page cache twice - before starting the IO and at
the end, and they're still technically racy w.r.t. page cache coherency.

This is a more complete approach: in the future we might consider
replacing mapping->invalidate_lock with the bcachefs code.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
---
 include/linux/sched.h | 1 +
 init/init_task.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b..f2a56f64f7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -869,6 +869,7 @@ struct task_struct {
 
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

