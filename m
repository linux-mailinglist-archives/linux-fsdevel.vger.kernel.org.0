Return-Path: <linux-fsdevel+bounces-60597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B36B49913
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6FC7ABFD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF6D31E0F0;
	Mon,  8 Sep 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFu6T21v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8031E0E2;
	Mon,  8 Sep 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357563; cv=none; b=XZIwyGzmFnXMYs/fENxxpBFdc6+g1chnmKmwX5RvtikeAgIbjwjjZdTTbow/j+SVeD392ZuJYsTdDuTCj/A2gIURtFg/hwMBmwra9qNKFrmS8xY+ccdB1ejEMRvOx7R2n5Ph9LCwVfwsc8BLrJEmIjALFBEGlUFHcL2L1SUJ9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357563; c=relaxed/simple;
	bh=+CTN5B7SeqTNFS9JipDKq8pNDlO61mP9PFkpU1qk1bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIGDjZ+WOBU8GNHnQxG3WKjniY99NAyOeeI+Wa6RortyhjsJbPFoF+Lx9I9NfeyfDlQahC5gWxjdG9nI02Vt7ZY7VqOFNohCMY8SqdjAfav63e08VZ4aZhLbFp0ndcN+LDCXxKLWYGTlSaVlie05HnvVqMYo4XNUXptEP4FOwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFu6T21v; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so3154943a12.3;
        Mon, 08 Sep 2025 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357561; x=1757962361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J114gh6ByMwTjUeA+rsO/Z2owIHbEpPQYJvbk/lVNzo=;
        b=GFu6T21vHr4bLz6tsYTiNY5VhU7c0M9dYqMdAT8IuJOOTRwkV22f+abxmESH0KrRrv
         cwPzxTVt9eBg6fvuOMjjyJw1gqUb5VApE9+5lEagIG7NSHxQ7Vvtzk+0UJjIumHjJgKZ
         KIWb3VWPVjWDQ4NWRvfZCL/e19oAgXvIJcfUop1ncX4655805VbP01v0G6KfyYZCPubR
         XSAlRbAOnnh1JNzhQCUHQjDvP0x1gbXDAnvn5OPqXxCCGa5ISfl85StS3d7xRTKj3VYa
         Ts5ylmMheICyC+k0/XUfUnnFT7dw/QDzlcbUftnyEpXJ5I3hUAAxtnBzO+XfB+wUjCID
         QBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357561; x=1757962361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J114gh6ByMwTjUeA+rsO/Z2owIHbEpPQYJvbk/lVNzo=;
        b=EaBKxAzJ0QAe/3zZQuWTxx/WGGiHplhs1lVs34Iqi91HsJsbrPIG4L6xppeGYAazeq
         TLFMOk27Or2yC+XN/R8aiPzM8kXeQba2fPoCI2KIv2dEhXTRSTOE9Rs2aYbj+EQtGjxh
         uMkx3krit3gu0OYrqqYQSNtCGTXQn0qDeI2vFpWln8EgazQBLWmD94hort22ktEukTVn
         IAbnrn0TSOScM+EEMctXuqYa2wXLU0WtIBFI0y6j0re6kCp17Y1pve9R/zwffVp/LJjP
         H1gyi+hMkRmYdk9nxRiPZyGr+fixoRvFKGIi8PqRmYRMN59bBc4VNmjMz5syyEqLrN0o
         lFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCULRnGZRWXfocoSvwxkLueB+CXJnJgtiTjEh2DVZuroz6zZEztqRlsjvVchIMIWd1hg0fICLf9Ntbq++g==@vger.kernel.org, AJvYcCVL69ykzfIsYuvpMZ7PEYFpSOZlsFRsiZQs6qOefpDqCBRyPUqjTb7vRc9V9AQJXuRU6XLVT/aXv0s4@vger.kernel.org, AJvYcCVTJCBLJ+IgIgZaIkKeNuexXqIHW8B5K8xFBVg4bZVOfjj/iDzdWB3ETaU1gW9NHo8GrAcu7dHaXwbq@vger.kernel.org, AJvYcCWfpRGoeX24/e4q1mTq2G+aD3HDv0+o5vnDOMRxrhMZ8a0gJy8mhSB8x3kPFItHHHJhnN3HEGvkgLJR5A5dGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fjCh2zyznZbi2f2PT49SLmgC3kE8cTjXt/B+X1fI34SmlvS2
	68TLv0C1psD9UPoHezLT1haK9m4kYox/FQxcyhGGAo0vBIrQZ+p5gfWP
X-Gm-Gg: ASbGncutAFg/M7EKJRSfZRZaa4DIntRVBa84WZNxaV65jeU5DKRxCLTlSZ8xozcI4sX
	O5Wqhf6cehgoKJUqkF2wM+kIlrFM02LeJtJtOOxjRU3KFnNUVWwL/oyhtuLIfSP5DNgOK1m0+FG
	rd/lg5bpByIGqI6Wvex/IuFplZMquLEB7F41lyJr87M43Z+yBokK7tToAbih2ZJBv8Zn0hPGwWa
	BtkqEnrMLHWBaUmKVGyLQeGyqr/LpfzSI4RB9VkziY0PXhFeX5nLMQPyIHOx/Dt+9Z+KURsjr0l
	ivjlRdjdmRtS2QswJ5hr3/pr4iho8ZCRdBYI2WQgtelXwiapCiQhlYQEsNtas1e/m2P8Fd97hgN
	9UIsvWhGNUt4GpPEzMA==
X-Google-Smtp-Source: AGHT+IGaGjLS6C/cbQh6aP5wsaX1LuBLHs6U4eYzV2mo/KlHw7FqzzxriJd7OMiRK7ZMZmkSYnVxwg==
X-Received: by 2002:a17:902:db07:b0:24c:e372:9de4 with SMTP id d9443c01a7336-2516dfcb6acmr132026735ad.18.1757357561355;
        Mon, 08 Sep 2025 11:52:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9a46bcf1sm148251415ad.3.2025.09.08.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:41 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 16/16] fuse: remove fc->blkbits workaround for partial writes
Date: Mon,  8 Sep 2025 11:51:22 -0700
Message-ID: <20250908185122.3199171-17-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fuse is integrated with iomap for read/readahead, we can remove
the workaround that was added in commit bd24d2108e9c ("fuse: fix fuseblk
i_blkbits for iomap partial writes"), which was previously needed to
avoid a race condition where an iomap partial write may be overwritten
by a read if blocksize < PAGE_SIZE. Now that fuse does iomap
read/readahead, this is protected against since there is granular
uptodate tracking of blocks, which means this workaround can be removed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h |  8 --------
 fs/fuse/inode.c  | 13 +------------
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f..ebee7e0b1cd3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (attr->blksize != 0)
 		blkbits = ilog2(attr->blksize);
 	else
-		blkbits = fc->blkbits;
+		blkbits = inode->i_sb->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cc428d04be3e..1647eb7ca6fa 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -975,14 +975,6 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
-
-	/*
-	 * This is a workaround until fuse uses iomap for reads.
-	 * For fuseblk servers, this represents the blocksize passed in at
-	 * mount time and for regular fuse servers, this is equivalent to
-	 * inode->i_blkbits.
-	 */
-	u8 blkbits;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7ddfd2b3cc9c..3bfd83469d9f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	if (attr->blksize)
 		fi->cached_i_blkbits = ilog2(attr->blksize);
 	else
-		fi->cached_i_blkbits = fc->blkbits;
+		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
@@ -1810,21 +1810,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
-		/*
-		 * This is a workaround until fuse hooks into iomap for reads.
-		 * Use PAGE_SIZE for the blocksize else if the writeback cache
-		 * is enabled, buffered writes go through iomap and a read may
-		 * overwrite partially written data if blocksize < PAGE_SIZE
-		 */
-		fc->blkbits = sb->s_blocksize_bits;
-		if (ctx->blksize != PAGE_SIZE &&
-		    !sb_set_blocksize(sb, PAGE_SIZE))
-			goto err;
 #endif
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
-		fc->blkbits = sb->s_blocksize_bits;
 	}
 
 	sb->s_subtype = ctx->subtype;
-- 
2.47.3


