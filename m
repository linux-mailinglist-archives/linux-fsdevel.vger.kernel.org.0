Return-Path: <linux-fsdevel+bounces-57589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A116B23B0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6791AA833A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223E2E5436;
	Tue, 12 Aug 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuyvzHUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FC2D481A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035260; cv=none; b=DSPXzjOBa5IQaKPd80GcY5JAsSt5xxLAKHx+HTc/fb3ORgBGo1660fSN6tOQ+HJ5M+zNYz+AW1poQcBx+VuGRum8dmbezH6/98BGbUqVj7Vh6D017rSLzpN/N/5tjxeiJ0SZWjH6Gpu+zkfDYEOVgVyVwM366jVI/qNTLvtn0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035260; c=relaxed/simple;
	bh=a87rvxbYA4aM0K1jDnSUPGBb/1xeURvyvwqFJaljx7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIWv1rmvHFsHrmUExG7zvEpul15hjAxss2YbMy55DI+5o8hMU4hl8AIya1r3n4FekQnDgbUUm45uN3Rwg8/chu1yuThBlpcUZH57qyy3mURK8IWOKLrZOqr6RyEqGRMt6QzK+Z8WVUkUHA/2pMMzmfth7F7+DeGpqLHJt5PxmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuyvzHUL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4239091facso4461646a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035258; x=1755640058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLalanHEdbtTP1XCrsUnEVqVVk6ieGK4dJKY+hzUU34=;
        b=EuyvzHULusN4tvOcFrlZZtOu4tlO4ZlYsf0F+2Ajg0BLXsd1mRwi6QokiefgTRaTuW
         L3Ej128E7LhlqNv+/rSyEcIMMrrRQkc/C60qwr165olm5PjYFWAJ0IrzK+vlm4Jaa4XT
         amXoreUFHi0tdxhwAgzjXgMuVvRKN6nmbxDyUjA6aggVJqI4Q7jKIPzJ/fES/9WXij4Z
         lanzuzDBbRwophh+4eNNy4W6S+HJyIzOfqjD1PX/sLUo1Y+6FkVmoRrhNMhPAjUCQAG3
         EfSMXQu3WJjxTgWZMOXafM0m4Z5YUZD1CdlCLXpSNaTYiKgY7UFkvo/tB6mf8mviC9Z+
         7lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035258; x=1755640058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLalanHEdbtTP1XCrsUnEVqVVk6ieGK4dJKY+hzUU34=;
        b=Y838lSqDEqf7yYPH+IndYzOVLzk0/OqueDYtpr79wB1UG9IZswgbU9eNwdgdS0jCTi
         ktO9o5gYCt7y5+j3uWuQfmZoWSUbWu+1wLr2Khevh8LKyb2gfQ03rXt93PJhYmrrh4jA
         ahodK1H75g2OfAtNM6bL4R7131ppOpDe90kr4MeBmeyyJM5K0F/K5mmULaMQoOR0D/Ho
         OsZRH5LfkghZQJ/veWF6N8O1Qqqs3UaEJT027jT+pEmHWMMZChrsNDIWF+iOBSGuUlh8
         RNIUntkSvg7xC7LiJ/3FXhCfsa5jXetBO4LdYUSb7tXh2wQQQA+JursmsqEQHD6VqGFD
         uV4w==
X-Forwarded-Encrypted: i=1; AJvYcCVKl2sBs6EcL4EHvpCZzvq4MSvb4Tf+oOnrsHRS3ryQ4OWPIqMVpJdDRTMwXFmGHZkGnKLRzy6ew5acguiz@vger.kernel.org
X-Gm-Message-State: AOJu0YzOIx3FGKdbSAL57A/kOXwuKdSOiMgp+xljh/Y3yMGtvDquF6nn
	IDlQyd575RkNo25GKoU59Msd+YM0YUCYdLYBkgs5SlLVMWJmpUFOiqXqHBYTPQ==
X-Gm-Gg: ASbGnctlc3oGmNAPFZptqtYKn9xjQH4D72lSJLnpNQ6xWg1P2Q5b84SXf5MkSEEbERT
	ar8v4tJ4veY8Mi3JNc3wqncTc71sOPeCSWPifK8TD0Vh4jIDziOEZH4OJB/8ujFMyBJChOiWjin
	rnoazkJwZWCf9+pIrdG8ctzgPr6/pbEWleQPlhmaU7Ecaw67V9/RyGd+ofqRdVQET5uKiNVTsMg
	+ZuMngXkoM09AOntr+caEpHWwaNPx+jRsTYCh+GuxdIZz2CLnxSq13xN9YN7T7u1VNIEiRCYbb5
	jXdj/sCePo048W9+3nS2sxgdWCXMO7YGyMb5Mhd5tIHu/nZxwnSo9ppQaMZdC1ho5feLr+BOsQc
	psd6CH9mDDNu8qHYm
X-Google-Smtp-Source: AGHT+IFWJjJjmI2EKsdOT03ULxCRVKXco6HplpPHjqSrTHVp3+7Aq+5c6KlZXo9Qe4lBJyWGYYFvKA==
X-Received: by 2002:a17:903:3c2c:b0:243:597:a2f0 with SMTP id d9443c01a7336-2430d108278mr10248695ad.23.1755035258055;
        Tue, 12 Aug 2025 14:47:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7ccsm307568295ad.57.2025.08.12.14.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:47:37 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/2] fuse: fix fuseblk i_blkbits for iomap partial writes
Date: Tue, 12 Aug 2025 14:46:14 -0700
Message-ID: <20250812214614.2674485-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812214614.2674485-1-joannelkoong@gmail.com>
References: <20250812214614.2674485-1-joannelkoong@gmail.com>
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

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: a4c9ab1d4975 ("fuse: use iomap for buffered writes")
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h |  8 ++++++++
 fs/fuse/inode.c  | 12 +++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

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
index db44d05c8d02..a6aa16422c30 100644
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
+	unsigned char blkbits;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3bfd83469d9f..7e66419f4556 100644
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
@@ -1810,10 +1810,20 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
+		/*
+		 * This is a workaround until fuse hooks into iomap for reads.
+		 * Use PAGE_SIZE for the blocksize else if the writeback cache
+		 * is enabled, buffered writes go through iomap and a read
+		 * may overwrite partially written data if blocksize < PAGE_SIZE
+		 */
+		fc->blkbits = sb->s_blocksize_bits;
+		if (!sb_set_blocksize(sb, PAGE_SIZE))
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


