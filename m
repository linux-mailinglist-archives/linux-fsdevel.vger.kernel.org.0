Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98EB3C8B36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbhGNSu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbhGNSu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F99C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:35 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p202so2598649qka.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e0vy2jqlq1xQtqe0Mfyhc5JVDQPE9FbGEnEvInBjRpI=;
        b=FK33z2MNOmGIAP0W2yTG17N8zGFM3orvDognSSjDnJd4xA0k80GgTFu8A8AamfRunK
         f8+JuZDg7lkjYf6+/YJHiraNLBpYyuV4d1PzTFxLVROGa3XGzCdDh+U1JMXBzY5KlthE
         qGj5T7WlVGF8/glqwOTLSFVz2cKiJzdhc2cY2l6HwXgbLTazs5GCDIqGDj3LdfyJCCTe
         pAhW5peF6WTUFqEkpzAdjHmvrZj5G2srNa73X2LPdfYtNixnV0DG3OojPzjMg40eyd2p
         KggEaL91UzmdBP8iRdnJbbnk1UIC9O60O33VBtrvbSKujq6LmBOwkFG/9gyNxps6mwW3
         m4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0vy2jqlq1xQtqe0Mfyhc5JVDQPE9FbGEnEvInBjRpI=;
        b=Rg3GgnNpe94PL03XJIdSrxcRMsOh5aUQSYwxB7nKCyvK/nk156rxniWoVEodjQERm2
         mg3yBnbIpdHiXuGCjDdcrcHFDGeUy+vYlePjtLX5R8B95xMRcmwHcMnOhMIFsASyaFOO
         UFdR+r0srVnUqpQyepa9RoCy7p3uQHqN95WvlsOJ+rjAmpIq9eU98nhI/uKljbYD5HXi
         t99MZXIgA45urK8EcVatcjSgJRP1psBPBx8HvieE5tdH7hIpkLNvVhWWj0+u3VQ60MTi
         bmCCoB43dOBRbH7+GqOcK+wyf5w+N7tCAywtsMlHK915At+eyhLRHECdLTdztwOhxsk3
         q3HQ==
X-Gm-Message-State: AOAM531hmLSS7e6U/LD0bqXGR/oF+JJD7nuAIUiMyBBl05oCz5wr4QxN
        rdZxo2JLT2nQzi1mT0SpDLGOzw==
X-Google-Smtp-Source: ABdhPJxjym0N7bnFOb4MhpUAUvBcDIIew6nOEDqozi/g8J2Ri/vYIi2ctjTCQLSJAIxI0xzH5HzIew==
X-Received: by 2002:a37:7e46:: with SMTP id z67mr11294939qkc.417.1626288454361;
        Wed, 14 Jul 2021 11:47:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m6sm1057089qtx.9.2021.07.14.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 5/9] btrfs: wait on async extents when flushing delalloc
Date:   Wed, 14 Jul 2021 14:47:21 -0400
Message-Id: <30dc1fa25489b1bae3ad44f290249ec9dbb9df6a.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been debugging an early ENOSPC problem in production and finally
root caused it to this problem.  When we switched to the per-inode in
38d715f494f2 ("btrfs: use btrfs_start_delalloc_roots in
shrink_delalloc") I pulled out the async extent handling, because we
were doing the correct thing by calling filemap_flush() if we had async
extents set.  This would properly wait on any async extents by locking
the page in the second flush, thus making sure our ordered extents were
properly set up.

However when I switched us back to page based flushing, I used
sync_inode(), which allows us to pass in our own wbc.  The problem here
is that sync_inode() is smarter than the filemap_* helpers, it tries to
avoid calling writepages at all.  This means that our second call could
skip calling do_writepages altogether, and thus not wait on the pagelock
for the async helpers.  This means we could come back before any ordered
extents were created and then simply continue on in our flushing
mechanisms and ENOSPC out when we have plenty of space to use.

Fix this by putting back the async pages logic in shrink_delalloc.  This
allows us to bulk write out everything that we need to, and then we can
wait in one place for the async helpers to catch up, and then wait on
any ordered extents that are created.

Fixes: e076ab2a2ca7 ("btrfs: shrink delalloc pages instead of full inodes")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c      |  4 ----
 fs/btrfs/space-info.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0f42864d5dd4..e388153c4ae4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9714,10 +9714,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 					 &work->work);
 		} else {
 			ret = sync_inode(inode, wbc);
-			if (!ret &&
-			    test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-				     &BTRFS_I(inode)->runtime_flags))
-				ret = sync_inode(inode, wbc);
 			btrfs_add_delayed_iput(inode);
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1a7e44dd0ba7..9dcde8c97c43 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -533,9 +533,49 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	while ((delalloc_bytes || ordered_bytes) && loops < 3) {
 		u64 temp = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
 		long nr_pages = min_t(u64, temp, LONG_MAX);
+		int async_pages;
 
 		btrfs_start_delalloc_roots(fs_info, nr_pages, true);
 
+		/*
+		 * We need to make sure any outstanding async pages are now
+		 * processed before we continue.  This is because things like
+		 * sync_inode() try to be smart and skip writing if the inode is
+		 * marked clean.  We don't use filemap_fwrite for flushing
+		 * because we want to control how many pages we write out at a
+		 * time, thus this is the only safe way to make sure we've
+		 * waited for outstanding compressed workers to have started
+		 * their jobs and thus have ordered extents set up properly.
+		 *
+		 * This exists because we do not want to wait for each
+		 * individual inode to finish its async work, we simply want to
+		 * start the IO on everybody, and then come back here and wait
+		 * for all of the async work to catch up.  Once we're done with
+		 * that we know we'll have ordered extents for everything and we
+		 * can decide if we wait for that or not.
+		 *
+		 * If we choose to replace this in the future, make absolutely
+		 * sure that the proper waiting is being done in the async case,
+		 * as there have been bugs in that area before.
+		 */
+		async_pages = atomic_read(&fs_info->async_delalloc_pages);
+		if (!async_pages)
+			goto skip_async;
+
+		/*
+		 * We don't want to wait forever, if we wrote less pages in this
+		 * loop than we have outstanding, only wait for that number of
+		 * pages, otherwise we can wait for all async pages to finish
+		 * before continuing.
+		 */
+		if (async_pages > nr_pages)
+			async_pages -= nr_pages;
+		else
+			async_pages = 0;
+		wait_event(fs_info->async_submit_wait,
+			   atomic_read(&fs_info->async_delalloc_pages) <=
+			   async_pages);
+skip_async:
 		loops++;
 		if (wait_ordered && !trans) {
 			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
-- 
2.26.3

