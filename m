Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E5AD127
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 01:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfIHXTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 19:19:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38619 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731260AbfIHXTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:19:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id d10so6704934pgo.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2019 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gx5XXdzXQF7G+1VrbudI1A9EwDDJ+tyVBcppt9K0Szs=;
        b=F01PsGlpkKUdf7ARLGoLElKXYgoOD/rlV0S5n7k8NS7EP45gvPuJjctcl+F0L4k9bt
         pDQXERm5AzCRpD3dA1v0uoQIDzBWCX1AGcdXTMQ2swDhFSRUaF8LIthjXc+fZIig+zLQ
         s/7z5bNVbrZwqKM7RAAQG1VijKSr88f27jHgnsbY0tUZfcsG5/SBvOqpzcNzXQsn8XB/
         J0MXTuCwsEmPEBxptasCFIhg26bDPdRLBq4eFmmB8B0TL4o7ap7flYLw3uwnqls7GuxD
         RgtfGkyD0IuiBJ/B8ZSqxJlUlH9WpzpR5SxzDVfsxeA6+rArw29HoA72JuYPlezWpxCG
         +EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gx5XXdzXQF7G+1VrbudI1A9EwDDJ+tyVBcppt9K0Szs=;
        b=Pt9ULKZZk9fxc9u+6WsC8dAVTHx+ejFxCbUthMMQjJZjkUp+oGAf2pzWLIGxd2opfD
         /wQDDo3jKnmjVhhhlupi3L0HHmllBBoQwqKVjoCdiKt0FYwrXrYAVUdfpGaTZwzsKe3I
         m9dvr/CC3MvJrwnbnYIpp0/WHQZggqKDC6/4ku/agKFzmvAAN5Ex4t+PFalyJdePEfAi
         pWu7db4YG/w6oPlHnqGuHzRUlsUJxrXRLAZprRDXQNavojg4fw23fFE5gi7mUKxt1k5C
         L9y/AdRMQ9rhozsMHXspxSpmCyf7SAQu39va1xUhChv60FnAorBIi2snWlyrG/S12NVf
         ES9w==
X-Gm-Message-State: APjAAAVI5OYM3RYRt9O6/UM1ZYefK+aLT/zsyTQbTLcPuNtqDU6SjNW6
        gWMIx0sDSucvg+OxXqsANsBZ
X-Google-Smtp-Source: APXvYqz7aWiON36Pum31Iaiaxq6K6qf3NBcQmcHZejX3zQ68ZdEeugxZEoHLn+LUsyAMIyFjFw0/qg==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr19318386pgt.365.1567984777787;
        Sun, 08 Sep 2019 16:19:37 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id u5sm12572075pfl.25.2019.09.08.16.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 16:19:37 -0700 (PDT)
Date:   Mon, 9 Sep 2019 09:19:31 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v2 3/6] iomap: modify ->end_io() calling convention
Message-ID: <8368d2ea5f2e80fed7fbba3685b0d3c1e5ff742a.1567978633.git.mbobrowski@mbobrowski.org>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567978633.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch modifies the calling convention for the iomap ->end_io()
callback. Rather than passing either dio->error or dio->size as the
'size' argument, we instead pass both dio->error and dio->size values
separately.

In the instance that an error occurred during a write, we currently
cannot determine whether any blocks have been allocated beyond the
current EOF and data has subsequently been written to these blocks
within the ->end_io() callback. As a result, we cannot judge whether
we should take the truncate failed write path. Having both dio->error
and dio->size will allow us to perform such checks within this
callback.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/iomap/direct-io.c  | 9 +++------
 fs/xfs/xfs_file.c     | 8 +++++---
 include/linux/iomap.h | 4 ++--
 3 files changed, 10 insertions(+), 11 deletions(-)

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
index 28101bbc0b78..d49759008c54 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -369,21 +369,23 @@ static int
 xfs_dio_write_end_io(
 	struct kiocb		*iocb,
 	ssize_t			size,
+	int                     error,
 	unsigned		flags)
 {
 	struct inode		*inode = file_inode(iocb->ki_filp);
 	struct xfs_inode	*ip = XFS_I(inode);
 	loff_t			offset = iocb->ki_pos;
 	unsigned int		nofs_flag;
-	int			error = 0;
 
 	trace_xfs_end_io_direct_write(ip, offset, size);
 
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
 		return -EIO;
 
-	if (size <= 0)
-		return size;
+	if (error)
+		return error;
+	if (!size)
+		return 0;
 
 	/*
 	 * Capture amount written on completion as we can't reliably account
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..d983cdcf2e72 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -188,8 +188,8 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
  */
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
-typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
-		unsigned flags);
+typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size,
+				 int error, unsigned int flags);
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
-- 
2.20.1

