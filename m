Return-Path: <linux-fsdevel+bounces-62836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A85BA218C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BBD7BAFA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874601DC985;
	Fri, 26 Sep 2025 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGx+iQR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C11E7C23
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846588; cv=none; b=qumE8uAAl5yO6gN1GF385f27gquNyZQzE5dtbKTaJKV+axWv9rl0G3dTRm2pZj5R7c2G4paDhfu5QPlyBc9N6Li99GoSlkYIZ/k+ywvXPF+SyfdjhTn16HRef6dS3aLV9Rn7yA2kljxRTuUYGbsszLxS51KyI8pjkI1r7OZ6QHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846588; c=relaxed/simple;
	bh=douu/OH3JOBJbcNCPjglBlefsScRwWQQRJejY8Y8034=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnLWb8iQnw7eAPVyryMTwvAD5YdRsdciFM7jSDMgBNXXguCgJM00v+18lzp2+I2qbqWPZMZpyWwrr81V+gQxY0GtYEdxVWsLDF9ZpIVH7o7vwDIkcadkiUa70Qxq1vIfCTm0/SuOHiX/3Kv+WOvX7qCk1UTbVPy+zrnnTEYWRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGx+iQR+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27edcbbe7bfso13927765ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846587; x=1759451387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mZBfvjKH+a+qnWQMQA8rEgrcPJHuMhz3ff1QpWHtCw=;
        b=nGx+iQR+qyqgjlVxNjOWNBRQBARpkHQDu8nvzKY8sI4/iGRIysq+WxDBaiUtcCRVZQ
         sn/jmfQK3uI3YTQNhlEi1C6qxr6rIeQBi6HZcldgaGdDp95lKGda90OXEUEtKsy9u9sw
         jg2FoVq4NIM4qt4JsV7zE7hdEC59+KQWnoZdKunCOHLnwaeDB1xzVAuFjVeNruq/3Woc
         zBzEtY50E5UCd3GgxxOnlyhduMwhrZJI5Bx9HrhWkz/sLecZg0hGQ9dGryc8w32QRLqo
         e4dpF89L6vwq3Qdafy1FyNFRCIC5QtK/EuGNkYeSs3A5YhEJFefmSwE1wJlGS5/iBvLY
         MivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846587; x=1759451387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mZBfvjKH+a+qnWQMQA8rEgrcPJHuMhz3ff1QpWHtCw=;
        b=NgW73BrINUzRKjYmSOd0GUqpANpotc6o3hhardclIxhph79uLcRyv/tf+Eon88Uzgg
         H9CefhlhCL5oJbZj3jjspdaFnSpnm/oI0mWL7dn/gO5/sWxr0JeO8i4ZE45QtuKepkj1
         UZLbzTGV7voIGmYB061kWyo0zMnZLhZVngdoyxvGaou27oaL1b8iGo8/2lZWM5xTAqob
         7iXyJJgwfcQRkSam/pBAQ/539joUP7z/6Rn6rl4nxoc0j4OrIsgIr2psgQMzZLTgIVas
         D85nRTdForyK8lFeWVfA1uSeGEUAS4t09fraHfYvJNpa8FTgybjv1LvprtFY67y1RfcA
         dR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4yjexiNIHKhZvDFTfphft8xVtDcw/vwAyAOYHIDbb0MTVSLAoj76KvwqFc99IvYTZB7DhCKAiCxm263CP@vger.kernel.org
X-Gm-Message-State: AOJu0YwArV0fxxFztFHqY9RWjS/301JZfNsPq5NlrcKa4++VupGJYu1z
	zSKjkhoMTy2inEYRYMIP4VRUvFpLe8Sbvz37DLz6sda+NF/I5vnYMEZf
X-Gm-Gg: ASbGncv7Gj2bWyzA2sa9MW6Te0EExhDGN1f1ue2AznXABPC7cLqYkDryYAYq01ZZfhS
	WunoY39Z3BRYedYRfJfcCH2vY4lNsGIGuGNQ6jbxCNn9ahJHUv5QKheWgOwyKslg2lHVZqQeApP
	PtSLyGk/laWns0drCQzkoIemUgUXJVu0Noj5CAdvBoCMtlICdCoNnWpI+eK737sBCAh1AlyVp43
	2I3hoaDzVq2gW4m72o3SIDtxZ71+i76O232sFhxUaq9t+XQfjjoh8KH9JdrNLuzUO28HO9CXe2u
	ZQBCe6WGRXGSHhj7IvBy6dzo9N9XtVqmB4NMfg7SB3Lo3S6H25VPAljJlf8uv7kKjMuiEkTYzya
	waVkVLGVnqr4U29T4kp8Xmbyao5sdrymVq0h+Sl+9izbzTw7jOIaJPE2bQZU=
X-Google-Smtp-Source: AGHT+IEMH5lJf7DHsnuKCyqZaYo7vRM2tcWdcLIid+23yMPPfujKM5L9NhzST+ddt/eFTEXbRRQDiA==
X-Received: by 2002:a17:903:32c2:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-27ed49dd7d2mr60037595ad.16.1758846586702;
        Thu, 25 Sep 2025 17:29:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6716081sm36552055ad.53.2025.09.25.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 14/14] fuse: remove fc->blkbits workaround for partial writes
Date: Thu, 25 Sep 2025 17:26:09 -0700
Message-ID: <20250926002609.1302233-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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
index 7485a41af892..a1b9e8587155 100644
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


