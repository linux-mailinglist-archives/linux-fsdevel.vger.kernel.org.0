Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803F4CFD45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfJHPMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:12:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfJHPMm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:12:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B55E3B194;
        Tue,  8 Oct 2019 15:12:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 152111E4827; Tue,  8 Oct 2019 17:12:38 +0200 (CEST)
Date:   Tue, 8 Oct 2019 17:12:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 8/8] ext4: introduce direct I/O write path using iomap
 infrastructure
Message-ID: <20191008151238.GK5078@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <9ef408b4079d438c0e6071b862c56fc8b65c3451.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <9ef408b4079d438c0e6071b862c56fc8b65c3451.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 03-10-19 21:35:05, Matthew Bobrowski wrote:
> This patch introduces a new direct I/O write code path implementation
> that makes use of the iomap infrastructure.
> 
> All direct I/O write operations are now passed from the ->write_iter()
> callback to the new function ext4_dio_write_iter(). This function is
> responsible for calling into iomap infrastructure via
> iomap_dio_rw(). Snippets of the direct I/O code from within
> ext4_file_write_iter(), such as checking whether the IO request is
> unaligned asynchronous I/O, or whether it will ber overwriting
> allocated and initialized blocks has been moved out and into
> ext4_dio_write_iter().
> 
> The block mapping flags that are passed to ext4_map_blocks() from
> within ext4_dio_get_block() and friends have effectively been taken
> out and introduced within the ext4_iomap_alloc().
> 
> For inode extension cases, the ->end_io() callback
> ext4_dio_write_end_io() is responsible for calling into
> ext4_handle_inode_extension() and performing the necessary metadata
> updates. Failed writes that we're intended to be extend the inode will
> have blocks truncated accordingly. The ->end_io() handler is also
> responsible for converting allocated unwritten extents to written
> extents.
> 
> In the instance of a short write, we fallback to buffered I/O and use
> that method to complete whatever is left over in 'iter'.

> Any blocks
> that have been allocated in preparation for direct I/O write will be
> reused by buffered I/O, so there's no issue with leaving allocated
> blocks beyond EOF.

This actually is not true as ext4_truncate_failed_write() will trim blocks
beyond EOF. Also this would not be 100% reliable as if we crash between DIO
short write succeeding and buffered write happening, we would leave inode
with blocks beyond EOF. So I'd just remove this sentence.

> Existing direct I/O write buffer_head code has been removed as it's
> now redundant.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

...

> +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> +                                int error, unsigned int flags)
> +{
> +       loff_t offset = iocb->ki_pos;
> +       struct inode *inode = file_inode(iocb->ki_filp);
> +
> +       if (!error && (flags & IOMAP_DIO_UNWRITTEN))
> +               error = ext4_convert_unwritten_extents(NULL, inode, offset,
> +                                                      size);
> +       return ext4_handle_inode_extension(inode, offset, error ? : size,
> +                                          size);
> +}

I was pondering about this and I don't think we have it quite correct.
Still :-|. The problem is that iomap_dio_complete() will pass dio->size as
'size', which is the amount of submitted IO but not necessarily the amount
of blocks that were mapped (that can be larger). Thus
ext4_handle_inode_extension() can miss the fact that there are blocks
beyond EOF that need to be trimmed. And we have no way of finding that out
inside our ->end_io handler. Even iomap_dio_complete() doesn't have that
information so we'd need to add 'original length' to struct iomap_dio and
then pass it do ->end_io.

Seeing how difficult it is when a filesystem wants to complete the iocb
synchronously (regardless whether it is async or sync) and have all the
information in one place for further processing, I think it would be the
easiest to provide iomap_dio_rw_wait() that forces waiting for the iocb to
complete *and* returns the appropriate return value instead of pretty
useless EIOCBQUEUED. It is actually pretty trivial (patch attached). With
this we can then just call iomap_dio_rw_sync() for the inode extension case
with ->end_io doing just the unwritten extent processing and then call
ext4_handle_inode_extension() from ext4_direct_write_iter() where we would
have all the information we need.

Christoph, Darrick, what do you think about extending iomap like in the
attached patch (plus sample use in XFS)?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--/04w6evG8XlLl3ft
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-iomap-Allow-forcing-of-waiting-for-running-DIO-in-io.patch"

From 240d0f2c96d81d9ef68c640b53f0b987d9e0333e Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 8 Oct 2019 15:57:11 +0200
Subject: [PATCH 1/2] iomap: Allow forcing of waiting for running DIO in
 iomap_dio_rw()

Filesystems do not support doing IO and asynchronous in some cases. For
example in case of unaligned writes or in case file size needs to be
extended (e.g. for ext4). Instead of forcing filesystem to wait for AIO
in such cases, provide iomap_dio_rw_wait() which does the waiting for IO
and also executes iomap_dio_complete() inline providing its return value
to the caller.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/iomap/direct-io.c  |  8 ++++----
 include/linux/iomap.h | 16 ++++++++++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2da279..12a806ed61fa 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -391,8 +391,9 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
  * completion.
  */
 ssize_t
-iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
+__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
+		bool wait_for_completion)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -400,7 +401,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos, start = pos;
 	loff_t end = iocb->ki_pos + count - 1, ret = 0;
 	unsigned int flags = IOMAP_DIRECT;
-	bool wait_for_completion = is_sync_kiocb(iocb);
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
@@ -555,4 +555,4 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	kfree(dio);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iomap_dio_rw);
+EXPORT_SYMBOL_GPL(__iomap_dio_rw);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7aa5d6117936..5c2d3afbd9b3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -194,8 +194,20 @@ struct iomap_dio_ops {
 		      unsigned flags);
 };
 
-ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
+ssize_t __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
+		bool wait_for_completion);
+static inline ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
+{
+	return __iomap_dio_rw(iocb, iter, ops, dops, is_sync_kiocb(iocb));
+}
+static inline ssize_t iomap_dio_rw_wait(struct kiocb *iocb,
+		struct iov_iter *iter, const struct iomap_ops *ops,
+		const struct iomap_dio_ops *dops)
+{
+	return __iomap_dio_rw(iocb, iter, ops, dops, true);
+}
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.16.4


--/04w6evG8XlLl3ft
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-xfs-Use-iomap_dio_rw_wait.patch"

From 26163692c3e01f5c51e895197e4f7ae0b674ae5d Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 8 Oct 2019 16:35:41 +0200
Subject: [PATCH 2/2] xfs: Use iomap_dio_rw_wait()

Use iomap_dio_rw_wait() instead of opencoding the wait.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_file.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1ffb179f35d2..c079a64b9e75 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -547,15 +547,17 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
-
 	/*
-	 * If unaligned, this is the only IO in-flight. If it has not yet
-	 * completed, wait on it before we release the iolock to prevent
-	 * subsequent overlapping IO.
+	 * If unaligned, this is the only IO in-flight. Wait on it before we
+	 * release the iolock to prevent subsequent overlapping IO.
 	 */
-	if (ret == -EIOCBQUEUED && unaligned_io)
-		inode_dio_wait(inode);
+	if (unaligned_io) {
+		ret = iomap_dio_rw_wait(iocb, from, &xfs_iomap_ops,
+					&xfs_dio_write_ops);
+	} else {
+		ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops,
+				   &xfs_dio_write_ops);
+	}
 out:
 	xfs_iunlock(ip, iolock);
 
-- 
2.16.4


--/04w6evG8XlLl3ft--
