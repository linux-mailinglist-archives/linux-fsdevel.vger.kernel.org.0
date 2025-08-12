Return-Path: <linux-fsdevel+bounces-57450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FAAB21A63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 03:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A53E6827D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 01:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C62D7812;
	Tue, 12 Aug 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQAmYCrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613ED212B05
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963392; cv=none; b=jdj/Ah5ugxVkRTwbbhyLwhNmICmeX6u4kqWCl2fFOxr9nWsmZHeEAaWfppgXpU4SRi/4ZuHycpZpt/BmwpCjGorSiF23yZtUV6IGO8QLulLI43yFpeX1bRwpuySFdrB1s/VvaSdlhOzELLdvKF5SydQJR7dRcKncVNk81VrPGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963392; c=relaxed/simple;
	bh=CNVd6KHMTpJunoixp5bbow0Q1lSSKmphpF55Xmug7jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geTiYlCECEcctCSQ3Iuu8o1G6/2M4UdrO5K00EQ2UAs0YyNzfYkLI3ciKmQzsTRMSxu6rr0tQH40cfxs7jFbAb5A34exwzKIDl7j6H4P270jv0PImVnPKavKM8uBL3cyttiUeYLMD17HNux2i8TsMfi8ymDQIeksOKVitmr/Aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQAmYCrx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-240763b322fso51310105ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754963391; x=1755568191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFRS+alSWbXNedwoOC+rNo9fO5lAZqVpFvc5Qr4f5+w=;
        b=fQAmYCrxEnhPa8tZZpMkkPYRox3wxqWq1Z+nKrpFg2g9JId1Ztgqu1mf3go9J0WyKV
         mgZyd29K+WGqCXReW8Q/j7np1H7odZURqKObqvvRP+Px428jQtOw08QZX15Zz8nEsRFq
         jnpAs3n75PaY9T+S/o3tCA8NBeozLV9UAd2nZveGDx+NSogTFB+4sRWINMtqt2SRTofE
         GjLLNcZhcaZIge5/jzODSJpibCwvwM19cFHNW59c7lmvMxdmxE41HGK9d1Ymm6P/Eh9e
         rmPpMnWb9nRB8NE9RNscHLT3sbemAJYRyahawo1ERyDm9TYeLp37SOexCIVQAcb06BeD
         Y67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754963391; x=1755568191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFRS+alSWbXNedwoOC+rNo9fO5lAZqVpFvc5Qr4f5+w=;
        b=hhzhsl91wS20k6AP7WjH75XBP7aLdPTYIJRYQUv2B4jf6UgKrh5Gl1PRxuHSldCzUo
         LVfAGqYj9vf4I/E8hvKGjdrVpqwHI4algB50mivZyjA77K6h/J3Jng81UBZGM2imo79t
         Qj/Nq0nJBsAM3gtp8UI/vGGmv79NhTC6e4jagoNmvuqXgozrn2goWvD0Ysenuc5lIwJN
         XrRsAZB7rZU+plGJfzoP5jm8uJjvlEm4ww0Go9XW0ObZLAhdga0Sv7BbhNlfj6blNfIY
         mQkFyQYEPTrxlGT+2QJ7Dp6NASiK08sFtSlyaH5qm8rCAndPLOZDdB4wfMT9yXNGz7/+
         GScQ==
X-Forwarded-Encrypted: i=1; AJvYcCW88m6M72C6VNTTwLgtjqK6x/7pNynTDh6dBzFGozV0ke3QcpzWJ05zDa7tbSqJ+wJdCLb2dTv5lqgwPb1w@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzCnUj2qXdSWFOfbk+2BuudI5njF8hwE2Q99JROE8YJW0Xhlr
	VcI+FwZV//HrP2y0UN/W+jFKUz3FBnSlb0K1kxAA3KOQ4RhrNjx5siKK
X-Gm-Gg: ASbGncvAEdTekw1OizaAQCOuFvoMRpZfqKxoJcSgs0NuTXeYTZkRWbvtz+uR74gV4Ub
	YXZ23sCKVZ6NB/SKlvcJmBAfrf9/CDBwE9ziMGIPP0kcTnTEN7kEzQn5Vl1/2Wxzbw+HjKWKir+
	6Oe55P4s/zkz7e2bDbN9qkQmChJHN3RKy3ErI88s6j0RxN4Ywe2SSZr72DU8Cd79DwlgtVz5Efl
	LWYJSsFPSMWSK+jsJy3VJomt1QApRSoNdEXZ4xAUjVez60NaMpnH/blRpkc9Ou4XgtduK3XTw3r
	lNlLXVU6qXOlu4oX9c2DKF2pxTEbJc5YhopKZwQV0gBkD8UAPCDzLUzMkl19xGcthZvBF0MwtI6
	Q/oGnW9aukEOOmszN3Q==
X-Google-Smtp-Source: AGHT+IFNeihSX5nfoczoiYS6aoSbFuIRcMfuhNet3GNnKPdJ8exzV/BeI+HO9O5ryXN1I3+W8YtKfw==
X-Received: by 2002:a17:903:2ad0:b0:237:d734:5642 with SMTP id d9443c01a7336-242fc390ec9mr21645585ad.41.1754963390455;
        Mon, 11 Aug 2025 18:49:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aac2a3sm284140265ad.165.2025.08.11.18.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 18:49:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] fuse: fix fuseblk i_blkbits for iomap partial writes
Date: Mon, 11 Aug 2025 18:46:23 -0700
Message-ID: <20250812014623.2408476-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
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
workaround is to use the page size for fuseblk's internal kernel
blksize/blkbits values while maintaining current behavior for stat().

This was verified using ntfs-3g:
$ sudo mkfs.ntfs -f -c 512 /dev/vdd1
$ sudo ntfs-3g /dev/vdd1 ~/fuseblk
$ stat ~/fuseblk/hi.txt
IO Block: 512

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: a4c9ab1d4975 ("fuse: use iomap for buffered writes")
---
 fs/fuse/dir.c    | 2 +-
 fs/fuse/fuse_i.h | 3 +++
 fs/fuse/inode.c  | 9 +++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab26..18900fa6d5da 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (attr->blksize != 0)
 		blkbits = ilog2(attr->blksize);
 	else
-		blkbits = inode->i_sb->s_blocksize_bits;
+		blkbits = fc->inode_blkbits;
 
 	stat->blksize = 1 << blkbits;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ec248d13c8bf..3be86056f4ff 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -969,6 +969,9 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
+
+	/** This is a workaround until fuse uses iomap for reads */
+	unsigned inode_blkbits;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 67c2318bfc42..681167117edf 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1805,10 +1805,19 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
+		/*
+		 * This is a workaround until fuse hooks into iomap for reads.
+		 * Else if ctx->blksize < PAGE_SIZE and the writeback cache is
+		 * enabled, a read may overwrite partially written data.
+		 */
+		fc->inode_blkbits = sb->s_blocksize_bits;
+		if (!sb_set_blocksize(sb, PAGE_SIZE))
+			goto err;
 #endif
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
+		fc->inode_blkbits = sb->s_blocksize_bits;
 	}
 
 	sb->s_subtype = ctx->subtype;
-- 
2.47.3


