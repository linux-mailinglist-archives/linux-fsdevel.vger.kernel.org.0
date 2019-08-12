Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A334B89EDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfHLMxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 08:53:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43380 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfHLMxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:53:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so40838452pld.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jlm68OvjvwxectZJjO7YyqQBIqDzQa/8Tu7Xy7csYWM=;
        b=mdafEdS87TvCMdOCuqx01fbZ3ZkvvIZLle8Nrcg0codWVMdxEn1nxpDUJZp4+yAauh
         7WAq293WPp9W4+DJ4IaLcVQXHDLCzhZV1BPy/Y24XF6+nIe+ap/JEmvIiMf/uEzqGLgB
         jvJ2uOuv1E0RviVmGgj6VYwZjjM9sbkQkaq0X2zcYS01CBP0dWVIT1qYrQRvIEPWu8mp
         1oRp5JmZt6zXJ7nRYkSa0uj6J6OeELgzLUkM2unbt9Lqi8FdgjPpVvVdVrDCYsv8pxKx
         n+/xfvek+y1xaz9TUasoUKbdCzAiKOfaSMrYRNnsLbEAxlbcZQt8RF0WwH6SgVEoujZs
         JNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlm68OvjvwxectZJjO7YyqQBIqDzQa/8Tu7Xy7csYWM=;
        b=VN7FzlAx728DRoFj4d24E/7EaQ2GD2bKoamT37Ix1TDNWCKu+U+fAmRi4ieutws0jA
         i2RtvN41qiSaRzncIixeC+4qMdo51nE5es69oCPMQr9+cMmCpj9x226Tlk0PG+fCtNV7
         k4/R8G741Y2QTyuPNTCKtm6oliRaaI+8PW2LA4sILJQ+r+PWvc46xVA3/Z/EKJEiXLJ9
         IlNXXh9JlwLjfShyQTXnsaDwY6fqACzpG3YkEec/equhpF9tdwPNsWbLa+Qag4cgSx65
         CtCkvqyDbIk/Y2mow62UK1yZNdvs1/VZcWgVm3NqvPdRvS455LC+dSNoakzXOyqUlIAh
         GVbA==
X-Gm-Message-State: APjAAAXM5os6OMzsNf2erI1wcKJdn7qDtrMaRngFpWampovkO+Q91j0Q
        bXjOfrmZF6ZSASny2ttgFJZq
X-Google-Smtp-Source: APXvYqz6JBHGguomENzcCepSMT5uqMDfdav9e5qqiCUUOG5Oi+un3ppRpAiOY1F0RIMptoiNOGyJJA==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr33440442plp.281.1565614398017;
        Mon, 12 Aug 2019 05:53:18 -0700 (PDT)
Received: from neo.home (n1-42-37-191.mas1.nsw.optusnet.com.au. [1.42.37.191])
        by smtp.gmail.com with ESMTPSA id p10sm2783709pff.132.2019.08.12.05.53.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:53:17 -0700 (PDT)
Date:   Mon, 12 Aug 2019 22:53:11 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        riteshh@linux.ibm.com
Subject: [PATCH 3/5] iomap: modify ->end_io() calling convention
Message-ID: <f4abda9c0c835d9a50b644fdbec8d43269f6b0f7.1565609891.git.mbobrowski@mbobrowski.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565609891.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch modifies the calling convention for the iomap ->end_io()
callback. Rather than passing either dio->error or dio->size as the 'size'
argument, we instead pass both dio->error and dio->size values separately.

In the instance that an error occurred during a write, we currently cannot
determine whether any blocks have been allocated beyond the current EOF and
data has subsequently been written to these blocks within the ->end_io()
callback. As a result, we cannot judge whether we should take the truncate
failed write path. Having both dio->error and dio->size will allow us to
perform such checks within this callback.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/iomap/direct-io.c  |  9 +++------
 fs/xfs/xfs_file.c     | 17 +++++++++--------
 include/linux/iomap.h |  4 ++--
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 10517cea9682..2ccf1c6460d4 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -77,13 +77,10 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
-	if (dio->end_io) {
-		ret = dio->end_io(iocb,
-				dio->error ? dio->error : dio->size,
-				dio->flags);
-	} else {
+	if (dio->end_io)
+		ret = dio->end_io(iocb, dio->size, dio->error, dio->flags);
+	else
 		ret = dio->error;
-	}
 
 	if (likely(!ret)) {
 		ret = dio->size;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 28101bbc0b78..f2bc3ac4a60e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -369,21 +369,22 @@ static int
 xfs_dio_write_end_io(
 	struct kiocb		*iocb,
 	ssize_t			size,
+	ssize_t                 error,
 	unsigned		flags)
 {
 	struct inode		*inode = file_inode(iocb->ki_filp);
 	struct xfs_inode	*ip = XFS_I(inode);
 	loff_t			offset = iocb->ki_pos;
 	unsigned int		nofs_flag;
-	int			error = 0;
+	int			ret = 0;
 
 	trace_xfs_end_io_direct_write(ip, offset, size);
 
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
 		return -EIO;
 
-	if (size <= 0)
-		return size;
+	if (error || !size)
+		return error ? error : size;
 
 	/*
 	 * Capture amount written on completion as we can't reliably account
@@ -399,8 +400,8 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
-		if (error)
+		ret = xfs_reflink_end_cow(ip, offset, size);
+		if (ret)
 			goto out;
 	}
 
@@ -411,7 +412,7 @@ xfs_dio_write_end_io(
 	 * they are converted.
 	 */
 	if (flags & IOMAP_DIO_UNWRITTEN) {
-		error = xfs_iomap_write_unwritten(ip, offset, size, true);
+		ret = xfs_iomap_write_unwritten(ip, offset, size, true);
 		goto out;
 	}
 
@@ -430,14 +431,14 @@ xfs_dio_write_end_io(
 	if (offset + size > i_size_read(inode)) {
 		i_size_write(inode, offset + size);
 		spin_unlock(&ip->i_flags_lock);
-		error = xfs_setfilesize(ip, offset, size);
+		ret = xfs_setfilesize(ip, offset, size);
 	} else {
 		spin_unlock(&ip->i_flags_lock);
 	}
 
 out:
 	memalloc_nofs_restore(nofs_flag);
-	return error;
+	return ret;
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..900284e5c06c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -188,8 +188,8 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
  */
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
-typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
-		unsigned flags);
+typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size,
+				 ssize_t error, unsigned int flags);
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
-- 
2.16.4


-- 
Matthew Bobrowski
