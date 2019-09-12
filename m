Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F18B0D84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfILLEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 07:04:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43592 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbfILLEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:04:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id d15so15759436pfo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dbT9Gzja88v34bZ54PPwipztlVvb7Cbzf1uTT2py4ow=;
        b=JK3FoqCSHgOcmM/KEL4cSKXMEXAeIM7R5i16B9X5F1+ca6ZzRMGbluCVpJWZEqWiJi
         l1OQ4Y81CbmmqS0M3kcjd1CcQQtanAkZTrEm09PfMt88clNXzdM3tfZ9mxmUewf+DC46
         OJtwIw5NLxx2qvtr9WKvVy5wBAcewzx33pXKQ6LkKSZ+0T4Ttluns7lLqSyPHIVDDb84
         sTCkB3XiNDJtSmRJuOz6RZol3JhYD9nuzNQlsy/XD6DmZTgsc+3qCzFsi/zAKqRwMFIQ
         Stj1feHcCbkHKtRfir/GdlqPwEiSq+7P1c0tq2Fddf7Eu+b6a6lzOeXjvcvY6XnGybOR
         EenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dbT9Gzja88v34bZ54PPwipztlVvb7Cbzf1uTT2py4ow=;
        b=WDLmu5NAtu4x5jT9bdJCX43swJ5yW1gOCcgnKNJ1+qCFKDk3viE5EQaJwL6F6Dujqi
         EMqy0aVImafiFddf99Jg4SGTw2MQmqxfbFOhH/M7RdI8043STzV8obrfzjq9DWd1WkKO
         RSgS6k11s9I84fqKW+EgPtWojoB4PeOqDAm6Q8Iq3mgbHy0G50tKoJ8vS+3GYaQlokhA
         ujWERMMepRzX2LShgIsoRxpWPgVP3pF/veBKggQM1BaDLQ3cl1ysuT1/hN+l8I/sRBcL
         gGqHLjI5LSoStYvklgqn5UTmyed7tb1S7oSQzEABqB/1md+v+Wy6h/m+CJ76RD+xNyAc
         rjCQ==
X-Gm-Message-State: APjAAAXnm4m9LRZHB6cFAumJYBmR/cAk6UfV1wxI68jatEXdzhPSVYbr
        aNndTOOI9o31ZkjrG/vRp91c
X-Google-Smtp-Source: APXvYqwjiq/8JM0dMTcMGX4OzvWoHNIfIr/xv1kJwkchLLJF2ALKgbn2BU6kj/gYTtEiMOC2sPDysw==
X-Received: by 2002:a63:e610:: with SMTP id g16mr36727746pgh.392.1568286261654;
        Thu, 12 Sep 2019 04:04:21 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id j126sm17563076pfb.186.2019.09.12.04.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 04:04:20 -0700 (PDT)
Date:   Thu, 12 Sep 2019 21:04:14 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v3 3/6] iomap: split size and error for iomap_dio_rw ->end_io
Message-ID: <a9772c8cd3db191c8039c24cb0f3861b55cdc1ca.1568282664.git.mbobrowski@mbobrowski.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modify the calling convention for the iomap_dio_rw ->end_io() callback.
Rather than passing either dio->error or dio->size as the 'size' argument,
instead pass both the dio->error and the dio->size value separately.

In the instance that an error occurred during a write, we currently cannot
determine whether any blocks have been allocated beyond the current EOF and
data has subsequently been written to these blocks within the ->end_io()
callback. As a result, we cannot judge whether we should take the truncate
failed write path. Having both dio->error and dio->size will allow us to
perform such checks within this callback.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
[hch: minor cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

Note, this patch is already queued in the 'iomap-5.4-merge' branch here:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/log/?h=iomap-5.4-merge.

Just adding it within this patch series to highlight that it's a
dependency.

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
index 28101bbc0b78..74411296f6b5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -369,21 +369,23 @@ static int
 xfs_dio_write_end_io(
 	struct kiocb		*iocb,
 	ssize_t			size,
+	int			error,
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
index bc499ceae392..50bb746d2216 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -188,8 +188,8 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
  */
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
-typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
-		unsigned flags);
+typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size, int error,
+				 unsigned int flags);
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
-- 
2.20.1

