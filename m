Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC9C25C6DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgICQcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 12:32:42 -0400
Received: from verein.lst.de ([213.95.11.211]:38685 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgICQcl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:32:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 45AD867357; Thu,  3 Sep 2020 18:32:37 +0200 (CEST)
Date:   Thu, 3 Sep 2020 18:32:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap
 context
Message-ID: <20200903163236.GA26043@lst.de>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com> <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We could trivially do something like this to allow the file system
to call iomap_dio_complete without i_rwsem:

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab99072..d970c6bbbe115d 100644
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
@@ -574,10 +575,25 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		__set_current_state(TASK_RUNNING);
 	}
 
-	return iomap_dio_complete(dio);
+	return dio;
 
 out_free_dio:
 	kfree(dio);
-	return ret;
+	return ERR_PTR(ret);
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
+
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9a4..172b3397a1a371 100644
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
