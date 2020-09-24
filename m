Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171D62776E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgIXQjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:39:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:35914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgIXQjr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:39:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9937B289;
        Thu, 24 Sep 2020 16:39:44 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 03/14] iomap: Allow filesystem to call iomap_dio_complete without i_rwsem
Date:   Thu, 24 Sep 2020 11:39:10 -0500
Message-Id: <20200924163922.2547-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924163922.2547-1-rgoldwyn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This is to avoid the deadlock caused in btrfs because of O_DIRECT |
O_DSYNC.

Filesystems such as btrfs require i_rwsem while performing sync on a
file. iomap_dio_rw() is called under i_rw_sem. This leads to a
deadlock because of:

iomap_dio_complete()
  generic_write_sync()
    btrfs_sync_file()

Separate out iomap_dio_complete() from iomap_dio_rw(), so filesystems
can call iomap_dio_complete() after unlocking i_rwsem.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/direct-io.c  | 35 ++++++++++++++++++++++++++---------
 include/linux/iomap.h |  5 +++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..b88dbfe15118 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -76,7 +76,7 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 		dio->submit.cookie = submit_bio(bio);
 }
 
-static ssize_t iomap_dio_complete(struct iomap_dio *dio)
+ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
 	const struct iomap_dio_ops *dops = dio->dops;
 	struct kiocb *iocb = dio->iocb;
@@ -130,6 +130,7 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iomap_dio_complete);
 
 static void iomap_dio_complete_work(struct work_struct *work)
 {
@@ -406,8 +407,8 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
  * Returns -ENOTBLK In case of a page invalidation invalidation failure for
  * writes.  The callers needs to fall back to buffered I/O in this case.
  */
-ssize_t
-iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+struct iomap_dio *
+__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		bool wait_for_completion)
 {
@@ -421,14 +422,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct iomap_dio *dio;
 
 	if (!count)
-		return 0;
+		return NULL;
 
 	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
-		return -EIO;
+		return ERR_PTR(-EIO);
 
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dio->iocb = iocb;
 	atomic_set(&dio->ref, 1);
@@ -558,7 +559,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->wait_for_completion = wait_for_completion;
 	if (!atomic_dec_and_test(&dio->ref)) {
 		if (!wait_for_completion)
-			return -EIOCBQUEUED;
+			return ERR_PTR(-EIOCBQUEUED);
 
 		for (;;) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
@@ -574,10 +575,26 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		__set_current_state(TASK_RUNNING);
 	}
 
-	return iomap_dio_complete(dio);
+	return dio;
 
 out_free_dio:
 	kfree(dio);
-	return ret;
+	if (ret)
+		return ERR_PTR(ret);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(__iomap_dio_rw);
+
+ssize_t
+iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
+		bool wait_for_completion)
+{
+	struct iomap_dio *dio;
+
+	dio = __iomap_dio_rw(iocb, iter, ops, dops, wait_for_completion);
+	if (IS_ERR_OR_NULL(dio))
+		return PTR_ERR_OR_ZERO(dio);
+	return iomap_dio_complete(dio);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..172b3397a1a3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -13,6 +13,7 @@
 struct address_space;
 struct fiemap_extent_info;
 struct inode;
+struct iomap_dio;
 struct iomap_writepage_ctx;
 struct iov_iter;
 struct kiocb;
@@ -258,6 +259,10 @@ struct iomap_dio_ops {
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		bool wait_for_completion);
+struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
+		bool wait_for_completion);
+ssize_t iomap_dio_complete(struct iomap_dio *dio);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.26.2

