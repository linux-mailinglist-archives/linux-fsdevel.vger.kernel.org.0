Return-Path: <linux-fsdevel+bounces-58050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D140B285CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 20:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F8CBA0767
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FC2304BA2;
	Fri, 15 Aug 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrItYes6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F829D28A
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282352; cv=none; b=Ag4UcukTCsfAXl2E/GylxYbF3dg7H8KIkNyGMlKcufTAhmFKVgQj7CGtyeG3uTT1W2RteR8gVi0DKnTczlfon5YJPWF3pzELrUuZhe0tpbhDYtcbPZdkJcAM8ikMHc24g1EDfKrGi+VCY3nL7V1RQNom98Mzigzn/eahTXZqxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282352; c=relaxed/simple;
	bh=TkToxQU9PJv5WpLz1RQXgkRnm7HlJXFcqT4WoYpb+a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwRRo/p5dzesjwyaHHiR/gE6YIdNZE1oYDOrxdHPUmQWPQxqNHnmp6hYmWQOJgcukVRvLyQ7ecXYJl1OuLnI5buH9BuIz07DU5zu81xE91nW4CAv04YRzmKt+kftRd9DdDTbEiU4gtf459PTL3YN2Quu91mwjmq9ZqnBlrXeQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrItYes6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so2176049b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755282350; x=1755887150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHIaGN001FDijBOokncr5YcXp9MWQzQJy1iRizk/Y2g=;
        b=JrItYes6OofhjnpdmO/FsL7DuSmhxSzYkujqXvyLAupBgJsubNvi559+R5PDLQ/Lo9
         OOJz7JhI2rq0h4gNF8c50M600B+ionBu2TWf2wU26VIV0fETVevqXKCLe41Iyng+3vOu
         sz6U97ObSSNShq+pf46s9BrOhJBtyoZgLQ2MBledKyrKgoecnlhCZPC0gaU/npZKtfrt
         oEH5CyUcCLHyHH8374mEm2+4MZgFmp5wXwWUoB3yhC/bYWQ5+U9kSLBeKkx07ADKZ0/n
         iLw7rJA71AHQiklikP46Py7+29OJzmjIm6f8NiENtADTYbS8S+6r4tSlH6te6OPUr4md
         pxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755282350; x=1755887150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHIaGN001FDijBOokncr5YcXp9MWQzQJy1iRizk/Y2g=;
        b=F7FQGEz1cJZ+6l5H3gUIi4+ToHTioLY8UGPt4g1n57Oaw5W8b1mj6mjpfjcE79JmYT
         x+Yw/QnoqJFaY6/02RGF51Lj27w65QF4osoOlnDSx9j/HpFoCOKi7GmVUhhVe+dGCMsA
         lJ5OvxWBm1BEbB1wfAwli2yYeWfOJnEdGnPYtC31TruNmHECie71suTq1OlVV3qLGpMS
         iDZ/ZE5TxXCYtXT2vPRtRKLfld06tblZUPbcrlXHbKa7vmOv93VPAOv147VckWnm/g5p
         iMgTJ3OI+1NlVesAqBCv8ZEEqgnjoCx6Pvk7WmS43Q63rOWkDKqWsea02Y2ieo8go0AI
         AKDw==
X-Forwarded-Encrypted: i=1; AJvYcCUD5y1tLI5CgvwkIZdG4BpDlDaJmpc5/OsskszNvovBqsxTrHD28P54FKB/5APQAuBLgOSZKqtPJ2N5+c3Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjjgGcwq7h0FHRQRBk2Nj6QT/MeMhn444klYa5pochdkWEAQj
	OzzG3C/F155XLBSTDsT8Hak9hp+TQDe49VhOHi5Xh4rrHdM992M8G33f
X-Gm-Gg: ASbGncvo89zEmKsU1uByCJKBsrHn9CPgpAL2pJGjb7xvY8mq+fnJ2c4EdOMji6ZEpSd
	lQd9pRC+C6cqmlKcCyMjLOQWosTgQinJrEbT/altZDya3ogjVaoa6uUa0ERqZ7fTvtD7L9jrMYv
	VKDHWbm9qbNjLaF+RMh7r8HFgjtZX4pGL1z5oVix1jua7NpQsu/eR/jet/DxVd8ns5/AGPDTaRN
	H70YL8nzIRIqjj+MqWeZqOs1aLjgACIuezJ35uEHxflibcQqJifQAP8Bw22dbqu49xg44rs+Ac6
	WTmeoSW+8DqCbd32NUyhqSREDNQxYLsDJ5OSU8ZdKGxnrkRCycCILTrypFlqvcV0rIdJOwUZF0p
	E7yXDSdPtWzmOZZUYPQEf+CLgY/iB
X-Google-Smtp-Source: AGHT+IG2VSYnyZcZ3SDH8d5eknHGDCUbKwZO9z32FTWW1vldoQ8KrvMeevgS/bDqkZIkUgEX14iugw==
X-Received: by 2002:a05:6a00:2e25:b0:76b:dcc6:8138 with SMTP id d2e1a72fcca58-76e4483708emr4280939b3a.22.1755282350311;
        Fri, 15 Aug 2025 11:25:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e455b6febsm1580145b3a.110.2025.08.15.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 11:25:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 2/2] fuse: fix fuseblk i_blkbits for iomap partial writes
Date: Fri, 15 Aug 2025 11:25:39 -0700
Message-ID: <20250815182539.556868-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250815182539.556868-1-joannelkoong@gmail.com>
References: <20250815182539.556868-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On regular fuse filesystems, i_blkbits is set to PAGE_SHIFT which means
any iomap partial writes will mark the entire folio as uptodate. However
fuseblk filesystems work differently and allow the blocksize to be less
than the page size. As such, this may lead to data corruption if fuseblk
sets its blocksize to less than the page size, uses the writeback cache,
and does a partial write, then a read and the read happens before the
write has undergone writeback, since the folio will not be marked
uptodate from the partial write so the read will read in the entire
folio from disk, which will overwrite the partial write.

The long-term solution for this, which will also be needed for fuse to
enable large folios with the writeback cache on, is to have fuse also
use iomap for folio reads, but until that is done, the cleanest
workaround is to use the page size for fuseblk's internal kernel inode
blksize/blkbits values while maintaining current behavior for stat().

This was verified using ntfs-3g:
$ sudo mkfs.ntfs -f -c 512 /dev/vdd1
$ sudo ntfs-3g /dev/vdd1 ~/fuseblk
$ stat ~/fuseblk/hi.txt
IO Block: 512

Fixes: a4c9ab1d4975 ("fuse: use iomap for buffered writes")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h |  8 ++++++++
 fs/fuse/inode.c  | 13 ++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ebee7e0b1cd3..5c569c3cb53f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (attr->blksize != 0)
 		blkbits = ilog2(attr->blksize);
 	else
-		blkbits = inode->i_sb->s_blocksize_bits;
+		blkbits = fc->blkbits;
 
 	stat->blksize = 1 << blkbits;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1647eb7ca6fa..cc428d04be3e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -975,6 +975,14 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
+
+	/*
+	 * This is a workaround until fuse uses iomap for reads.
+	 * For fuseblk servers, this represents the blocksize passed in at
+	 * mount time and for regular fuse servers, this is equivalent to
+	 * inode->i_blkbits.
+	 */
+	u8 blkbits;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3bfd83469d9f..7ddfd2b3cc9c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	if (attr->blksize)
 		fi->cached_i_blkbits = ilog2(attr->blksize);
 	else
-		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
+		fi->cached_i_blkbits = fc->blkbits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
@@ -1810,10 +1810,21 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
+		/*
+		 * This is a workaround until fuse hooks into iomap for reads.
+		 * Use PAGE_SIZE for the blocksize else if the writeback cache
+		 * is enabled, buffered writes go through iomap and a read may
+		 * overwrite partially written data if blocksize < PAGE_SIZE
+		 */
+		fc->blkbits = sb->s_blocksize_bits;
+		if (ctx->blksize != PAGE_SIZE &&
+		    !sb_set_blocksize(sb, PAGE_SIZE))
+			goto err;
 #endif
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
+		fc->blkbits = sb->s_blocksize_bits;
 	}
 
 	sb->s_subtype = ctx->subtype;
-- 
2.47.3


