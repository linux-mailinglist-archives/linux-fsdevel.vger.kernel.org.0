Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CC8110390
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 18:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLCRdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 12:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfLCRdK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:33:10 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9C32073B;
        Tue,  3 Dec 2019 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575394389;
        bh=L6bfw+QYF4n6bm/yWyEeXWAiOWxcna6+5qT5/wHY2DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yzWRAuQslIzLXKtM0DWjbL1bui0cXnluPqReXwPUqAk1GL45OjwJPNKmti06o+0/c
         M5LU7MK4qmIA4vJM2f8BiIFu1M2az8x4Q6Hh3YsTr8oOdRhnsDNg/MxHGdhpYxc52C
         bKLWVu+r2C9eJYEMb0lLhIoqakXpV6kCxQB/9E80=
Date:   Tue, 3 Dec 2019 09:33:08 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Javier Gonzalez <javier@javigon.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] f2fs: Fix direct IO handling
Message-ID: <20191203173308.GA41093@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
 <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for checking the patch.
I found some regressions in xfstests, so want to follow the Damien's one
like below.

Thanks,

===
From 9df6f09e3a09ed804aba4b56ff7cd9524c002e69 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 26 Nov 2019 15:01:42 -0800
Subject: [PATCH] f2fs: preallocate DIO blocks when forcing buffered_io

The previous preallocation and DIO decision like below.

                         allow_outplace_dio              !allow_outplace_dio
f2fs_force_buffered_io   (*) No_Prealloc / Buffered_IO   Prealloc / Buffered_IO
!f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO

But, Javier reported Case (*) where zoned device bypassed preallocation but
fell back to buffered writes in f2fs_direct_IO(), resulting in stale data
being read.

In order to fix the issue, actually we need to preallocate blocks whenever
we fall back to buffered IO like this. No change is made in the other cases.

                         allow_outplace_dio              !allow_outplace_dio
f2fs_force_buffered_io   (*) Prealloc / Buffered_IO      Prealloc / Buffered_IO
!f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO

Reported-and-tested-by: Javier Gonzalez <javier@javigon.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 13 -------------
 fs/f2fs/file.c | 43 +++++++++++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a034cd0ce021..fc40a72f7827 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1180,19 +1180,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	int err = 0;
 	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
 
-	/* convert inline data for Direct I/O*/
-	if (direct_io) {
-		err = f2fs_convert_inline_inode(inode);
-		if (err)
-			return err;
-	}
-
-	if (direct_io && allow_outplace_dio(inode, iocb, from))
-		return 0;
-
-	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
-		return 0;
-
 	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
 	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
 	if (map.m_len > map.m_lblk)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c0560d62dbee..0e1b12a4a4d6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3386,18 +3386,41 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 				ret = -EAGAIN;
 				goto out;
 			}
-		} else {
-			preallocated = true;
-			target_size = iocb->ki_pos + iov_iter_count(from);
+			goto write;
+		}
 
-			err = f2fs_preallocate_blocks(iocb, from);
-			if (err) {
-				clear_inode_flag(inode, FI_NO_PREALLOC);
-				inode_unlock(inode);
-				ret = err;
-				goto out;
-			}
+		if (is_inode_flag_set(inode, FI_NO_PREALLOC))
+			goto write;
+
+		if (iocb->ki_flags & IOCB_DIRECT) {
+			/*
+			 * Convert inline data for Direct I/O before entering
+			 * f2fs_direct_IO().
+			 */
+			err = f2fs_convert_inline_inode(inode);
+			if (err)
+				goto out_err;
+			/*
+			 * If force_buffere_io() is true, we have to allocate
+			 * blocks all the time, since f2fs_direct_IO will fall
+			 * back to buffered IO.
+			 */
+			if (!f2fs_force_buffered_io(inode, iocb, from) &&
+					allow_outplace_dio(inode, iocb, from))
+				goto write;
+		}
+		preallocated = true;
+		target_size = iocb->ki_pos + iov_iter_count(from);
+
+		err = f2fs_preallocate_blocks(iocb, from);
+		if (err) {
+out_err:
+			clear_inode_flag(inode, FI_NO_PREALLOC);
+			inode_unlock(inode);
+			ret = err;
+			goto out;
 		}
+write:
 		ret = __generic_file_write_iter(iocb, from);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
-- 
2.19.0.605.g01d371f741-goog


