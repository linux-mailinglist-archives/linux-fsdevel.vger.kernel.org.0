Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D88DE7D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfJUJS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:18:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42313 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfJUJS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:18:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so8025889pff.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IZ1eV4tdvyQNIWQCC8BJlj33GnHxYxtMtymw7aWl7nY=;
        b=l6cdgYxsjfHSvq2+2nn8WrBB4DpnUGEkVC1BfvMdS5CV7at3LoB88ajpbd0IpKQj5y
         iH1h7ChOFj/aBlPoKtDFjj7uvvy3P3kR/t02fXcH3MWJxoHQS8G44yH0NrOZ6plL6wI3
         8JvLrxZOgMId54HHTQ6JqbIwNuPs3hB2us9g4vKFKZrOej7tkGOjin59H1UInvDd6Prg
         5pGD/VjHRZ4K6nzmYmklq8z1RfUShVtzqxqQYd+4t4bVsS0YW/fxFbLT0vC5gSwATMGi
         O7TLHSX1TiBZe9AlZj+POOVv5T+cjjE8K8Kros+RzAroH4e15Xm86dmzNxLyUsdDfRr2
         AFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZ1eV4tdvyQNIWQCC8BJlj33GnHxYxtMtymw7aWl7nY=;
        b=Uivb3tpB/rxcEzPYHX+tjyMrg48QQUqNq8P6Pd8DFsf/5QEJH+VJwTizUeIJyJ67NH
         BMcY3eLvnCGyF90EYBNYf7GIvHO7JEfy5UCbdCHI2z2FF7DcamSPchNJVTQE9gX0PdZv
         v/aOIzPLrjSlE8q1csLw3hGz5Q9F5q3jYqyM7xTjcTUCxnb8PKMHm8wH7COIonx/1maL
         gA5/fqkshwEJ1O33MpdxkbJnPTxfPYT8i4eD7ht8VtHsTOQZUBhmJL7PwF4282Wo/+TQ
         usZdUXFpGc7+EYO/gWkqtBpx7WSX86yC8/H9XWW71I6TmAanxLL/Q48dxHzfXluMCHGj
         FJgg==
X-Gm-Message-State: APjAAAUdFIEZPDz68z7OLWEzWxSVl80U2wVeYBrzOC1PhmKD/gJyno9M
        LdUx51lgaKLxIv+n11V7tMmN
X-Google-Smtp-Source: APXvYqwwOA7J2Gvx0HJApNwrVPy7umjdX6xWj+PQ+3b5DVmMM2Q38Xd52xlC6JseGvAZr4tHKKGCwA==
X-Received: by 2002:a63:33c9:: with SMTP id z192mr24279623pgz.77.1571649504935;
        Mon, 21 Oct 2019 02:18:24 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id d4sm13726161pjs.9.2019.10.21.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:18:24 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:18:18 +1100
From:   mbobrowski@mbobrowski.org
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 05/12] iomap: Allow forcing of waiting for running DIO in
 iomap_dio_rw()
Message-ID: <5dc3085af89a3e7c20db22e9e7012b4676b440a9.1571647179.git.mbobrowski@mbobrowski.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571647178.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Filesystems do not support doing IO as asynchronous in some cases. For
example in case of unaligned writes or in case file size needs to be
extended (e.g. for ext4). Instead of forcing filesystem to wait for AIO
in such cases, add argument to iomap_dio_rw() which makes the function
wait for IO completion. This also results in executing
iomap_dio_complete() inline in iomap_dio_rw() providing its return value
to the caller as for ordinary sync IO.

Signed-off-by: Jan Kara <jack@suse.cz>
---

This patch has already been posted through by Jan, but I've just
included it within this patch series to mark that it's a clear
dependency.

 fs/gfs2/file.c        | 6 ++++--
 fs/iomap/direct-io.c  | 7 +++++--
 fs/xfs/xfs_file.c     | 5 +++--
 include/linux/iomap.h | 3 ++-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 997b326247e2..f0caee2b7c00 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -732,7 +732,8 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (ret)
 		goto out_uninit;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL);
+	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
+			   is_sync_kiocb(iocb));
 
 	gfs2_glock_dq(&gh);
 out_uninit:
@@ -767,7 +768,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL);
+	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
+			   is_sync_kiocb(iocb));
 
 out:
 	gfs2_glock_dq(&gh);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2da279..da124cee1783 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -392,7 +392,8 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
  */
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
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
 
@@ -409,6 +409,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!count)
 		return 0;
 
+	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
+		return -EIO;
+
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
 		return -ENOMEM;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1ffb179f35d2..0739ba72a82e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -188,7 +188,7 @@ xfs_file_dio_aio_read(
 	file_accessed(iocb->ki_filp);
 
 	xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL);
+	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL, is_sync_kiocb(iocb));
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -547,7 +547,8 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
+	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
+			   is_sync_kiocb(iocb));
 
 	/*
 	 * If unaligned, this is the only IO in-flight. If it has not yet
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7aa5d6117936..76b14cb729dc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -195,7 +195,8 @@ struct iomap_dio_ops {
 };
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
+		bool wait_for_completion);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.20.1

--<M>--
