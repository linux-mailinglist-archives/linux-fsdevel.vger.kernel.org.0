Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B94112441
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfLDIQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:16:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45505 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDIQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:16:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so7308166wrj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 00:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A3EjttU8t1DCaxtv3QmwTcUqJUdcBQEbi7gg5HzyUUg=;
        b=XC4SD8Nm/CJsVX2cNdH7LMWWN1jdVbSSfwd5CoVNQMApFZ+METGkcdcOx2Hm/HnLn7
         p5o53EPcTISnscB7YQ3Y9dglaKVNaQnve9q4h2ZwxJQR/MdFfdC7o6AjnJqXsi6eElZb
         ejtUwfloOEdNVnXzKDxOgjYzLHhO7l8WMX0SUBahb/mhtCnl7eci/+AVJn47kzjbCiU1
         0fQJ7xnwFY8h0qKjFkKbjGbtsPtZdZVX/M6S6QuBjuls6n7ouePAkdN4MP43579p06dk
         9gEW0OmWqbL+XeR8HcAhI4UJJo3BdbQW3STwibFTMTinesHQFa0m1amtrRRmaOOo2Cs5
         LJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A3EjttU8t1DCaxtv3QmwTcUqJUdcBQEbi7gg5HzyUUg=;
        b=VX3NRu7mmc5jV0n7+Fe+qwuK5j9hx8dAKftrqTbcY+XzzJmE4D/HfdcIMkYPvZRtYW
         GEuaSwg9qZLuW212ccU9Ux40sxFhGyrOEKwtlpP0Nr7c85TJr7bA67LAL5op6/oBb8XH
         cwVna65hyhpxrMsnx7D84fTaMNAjR2HVP5djCxBaW2tHIx5PArBSKoRMQjrQC1/gmz7R
         IiGzJK1bTYQbHTt2FEfpcNybrTxdOpQkqmX5G3hEeMObakN1IY00xT0R11sAxZmax8EB
         /k5Ts4xKe1LbaZyMsxY8BdIQhJjl0thD1hkVEdCtOldSxDGCT5vKM8ibex/z9P1f8Bfy
         qo2Q==
X-Gm-Message-State: APjAAAXP2y+PXo/jNiP4V8K/v+6U+QEZSdTHKBiVP0dxHJK+UMgQLCZj
        yB4xUSAilkmdBXB0jDGOMRM/Yw==
X-Google-Smtp-Source: APXvYqxhYn0nwnicejVfpeVuMHpPYxIZfRC6Yv6j4V8Gy/5U1lyQHKa9KaXdhFUr/j++Rc1R50CEyg==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr2599078wrm.13.1575447404312;
        Wed, 04 Dec 2019 00:16:44 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id g21sm8286034wrb.48.2019.12.04.00.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 00:16:43 -0800 (PST)
Date:   Wed, 4 Dec 2019 09:16:42 +0100
From:   Javier Gonzalez <javier@javigon.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] f2fs: Fix direct IO handling
Message-ID: <20191204081642.gnd55byogedrhfoz@MacBook-Pro.gnusmas>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
 <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
 <20191203173308.GA41093@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203173308.GA41093@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.12.2019 09:33, Jaegeuk Kim wrote:
>Thank you for checking the patch.
>I found some regressions in xfstests, so want to follow the Damien's one
>like below.
>
>Thanks,
>
>===
>From 9df6f09e3a09ed804aba4b56ff7cd9524c002e69 Mon Sep 17 00:00:00 2001
>From: Jaegeuk Kim <jaegeuk@kernel.org>
>Date: Tue, 26 Nov 2019 15:01:42 -0800
>Subject: [PATCH] f2fs: preallocate DIO blocks when forcing buffered_io
>
>The previous preallocation and DIO decision like below.
>
>                         allow_outplace_dio              !allow_outplace_dio
>f2fs_force_buffered_io   (*) No_Prealloc / Buffered_IO   Prealloc / Buffered_IO
>!f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO
>
>But, Javier reported Case (*) where zoned device bypassed preallocation but
>fell back to buffered writes in f2fs_direct_IO(), resulting in stale data
>being read.
>
>In order to fix the issue, actually we need to preallocate blocks whenever
>we fall back to buffered IO like this. No change is made in the other cases.
>
>                         allow_outplace_dio              !allow_outplace_dio
>f2fs_force_buffered_io   (*) Prealloc / Buffered_IO      Prealloc / Buffered_IO
>!f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO
>
>Reported-and-tested-by: Javier Gonzalez <javier@javigon.com>
>Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>---
> fs/f2fs/data.c | 13 -------------
> fs/f2fs/file.c | 43 +++++++++++++++++++++++++++++++++----------
> 2 files changed, 33 insertions(+), 23 deletions(-)
>
>diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>index a034cd0ce021..fc40a72f7827 100644
>--- a/fs/f2fs/data.c
>+++ b/fs/f2fs/data.c
>@@ -1180,19 +1180,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
> 	int err = 0;
> 	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>
>-	/* convert inline data for Direct I/O*/
>-	if (direct_io) {
>-		err = f2fs_convert_inline_inode(inode);
>-		if (err)
>-			return err;
>-	}
>-
>-	if (direct_io && allow_outplace_dio(inode, iocb, from))
>-		return 0;
>-
>-	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>-		return 0;
>-
> 	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
> 	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
> 	if (map.m_len > map.m_lblk)
>diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>index c0560d62dbee..0e1b12a4a4d6 100644
>--- a/fs/f2fs/file.c
>+++ b/fs/f2fs/file.c
>@@ -3386,18 +3386,41 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 				ret = -EAGAIN;
> 				goto out;
> 			}
>-		} else {
>-			preallocated = true;
>-			target_size = iocb->ki_pos + iov_iter_count(from);
>+			goto write;
>+		}
>
>-			err = f2fs_preallocate_blocks(iocb, from);
>-			if (err) {
>-				clear_inode_flag(inode, FI_NO_PREALLOC);
>-				inode_unlock(inode);
>-				ret = err;
>-				goto out;
>-			}
>+		if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>+			goto write;
>+
>+		if (iocb->ki_flags & IOCB_DIRECT) {
>+			/*
>+			 * Convert inline data for Direct I/O before entering
>+			 * f2fs_direct_IO().
>+			 */
>+			err = f2fs_convert_inline_inode(inode);
>+			if (err)
>+				goto out_err;
>+			/*
>+			 * If force_buffere_io() is true, we have to allocate
>+			 * blocks all the time, since f2fs_direct_IO will fall
>+			 * back to buffered IO.
>+			 */
>+			if (!f2fs_force_buffered_io(inode, iocb, from) &&
>+					allow_outplace_dio(inode, iocb, from))
>+				goto write;
>+		}
>+		preallocated = true;
>+		target_size = iocb->ki_pos + iov_iter_count(from);
>+
>+		err = f2fs_preallocate_blocks(iocb, from);
>+		if (err) {
>+out_err:
>+			clear_inode_flag(inode, FI_NO_PREALLOC);
>+			inode_unlock(inode);
>+			ret = err;
>+			goto out;
> 		}
>+write:
> 		ret = __generic_file_write_iter(iocb, from);
> 		clear_inode_flag(inode, FI_NO_PREALLOC);
>
>-- 
>2.19.0.605.g01d371f741-goog
>
>

Looks good to me. It also fixes the problem we see in our end.

Reviewed-by: Javier González <javier@javigon.com>
