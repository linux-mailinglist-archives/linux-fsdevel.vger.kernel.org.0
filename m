Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198EE6A32AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjBZQEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjBZQEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:04:01 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E2125A7;
        Sun, 26 Feb 2023 08:03:49 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 08155831B7;
        Sun, 26 Feb 2023 16:03:44 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677427429;
        bh=Yo1+jDAmCINsAVjB6QZIr6c2SpALyJNJSdY2CPV6JsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgtuJhCTdxodogoH8lRiLcqjlFTtteVvB/jjKwArR69BaLharsOanmHPiZ3ArTXmh
         QzwuZWzCOGdEo6E+nuEfed+KHxc3/P2CeFWPZ9Ietfu2xSSG2bzOlW5aJ1A5A7XbUw
         C5mhDR+kI4p9WNy914pLnJL9fwK4rM7HadEa+x/V27VQjYjWcy7m+RDNoz436YZel1
         y5r7CMRTvlxLKHjNkHNUCr+vG6eW22W3TLJU54wjg7tCkXWmZoDXVaD4PmT95w/7cD
         o7xAJ1U2YKYS0CHOCe+JK9uvIAg3zTZtWAxNKTH1e3klc2wNK7faplAATa14fJly8p
         oGq+GVZUXmNKw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v1 6/6] btrfs: Add `BTRFS_DEFAULT_MAX_THREAD_POOL_SIZE` macro
Date:   Sun, 26 Feb 2023 23:02:59 +0700
Message-Id: <20230226160259.18354-7-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the default max thread pool size is hardcoded as 8. This
number is not only used in one place. Keep the default max thread pool
size in sync by introducing a new macro.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 fs/btrfs/async-thread.h | 2 ++
 fs/btrfs/disk-io.c      | 3 ++-
 fs/btrfs/super.c        | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index 2b8a76fa75ef9e69..f11c3b36568053be 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -9,6 +9,8 @@
 
 #include <linux/workqueue.h>
 
+#define BTRFS_DEFAULT_MAX_THREAD_POOL_SIZE 8
+
 struct btrfs_fs_info;
 struct btrfs_workqueue;
 struct btrfs_work;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1bb1db461a30fa71..4f4ddc8e088b08ec 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2957,7 +2957,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_init_ref_verify(fs_info);
 
 	fs_info->thread_pool_size = min_t(unsigned long,
-					  num_online_cpus() + 2, 8);
+					  num_online_cpus() + 2,
+					  BTRFS_DEFAULT_MAX_THREAD_POOL_SIZE);
 
 	INIT_LIST_HEAD(&fs_info->ordered_roots);
 	spin_lock_init(&fs_info->ordered_root_lock);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 34b7c5810d34d624..bf4be383e289ef6c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -333,7 +333,8 @@ static void adjust_default_thread_pool_size(struct btrfs_fs_info *info)
 	}
 
 	old_thread_pool_size = info->thread_pool_size;
-	new_thread_pool_size = min_t(unsigned long, total_usable_cpu + 2, 8);
+	new_thread_pool_size = min_t(unsigned long, total_usable_cpu + 2,
+				     BTRFS_DEFAULT_MAX_THREAD_POOL_SIZE);
 
 	if (old_thread_pool_size == new_thread_pool_size)
 		return;
-- 
Ammar Faizi

