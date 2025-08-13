Return-Path: <linux-fsdevel+bounces-57799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80EEB256A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CFF5C032D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98D2EAB65;
	Wed, 13 Aug 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv3JxNGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2012D375B
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124536; cv=none; b=dJPJx6ov7shK8CM9g7Wg+IGQgsTL2JAK33AevvPnU87wHQyODHAr6VGUYR0rxtTiA62eMbUqwxsUcXqiIWrVCLDyyfRRMgEbAJwll0o2lTjC0vGNgRcnOZVO8TX+Z0cf+iRXXpghEP8I+nUk+NBk4NTJnwR8Tyos14R/GdH0Gn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124536; c=relaxed/simple;
	bh=VueitJscIKRWicbYQMXqZCMMYSJWZaN88KY7EOeeZkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPI7/7p4SZimZx/mm5kfToXCwybHfql6v2aFK/nKM1n0l50nuashQ0N8BST9ymwijor8FqxcHnWZhtnbWv3MGOXVy3eyPt4xLni5IX2aIO0C+qawZj0CdYyH4z82EHY7mlYQPCXqCYxW4SBWO6Lzmu9DIPsJu8WJqh4mWdKmC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv3JxNGh; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4717563599so193129a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755124534; x=1755729334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4y0QjImL352dlk74SIXhCOdb9IBBUQ2v3/hGWoBzVQ=;
        b=Xv3JxNGh4d1MSZ4F04YtkS+honmqt0MRMzQ5FnvsQsTibu9xwnLsFVCG55batmH2Ch
         JVRMs2T6LA/Ymrohgqr0D3JtVaT1JH4VPH2lo/SsxEbnPqhPAfLNi/gSsQCgDlIkILeG
         GoL2HCnLIytLFkeK7T/1RLuHmqipp7FmcAfcUDwmtL4YsLLkUWnTbayOg8cSF+Ui+/Yg
         h0hnRg7zB4li+5iGNjBpc63e9epNEaiCyh8c5ZLjQisBs2Ey300POr6PgY7qvuptWPJl
         x6QRO0LGGSk72C24C51zxpxfS8qLtMqhYllKdb6NLX0QIj2oFc5LHgPqMb3IIfC12PXc
         pxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755124534; x=1755729334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4y0QjImL352dlk74SIXhCOdb9IBBUQ2v3/hGWoBzVQ=;
        b=qplUx9II3oJEAhQOjkuit0lz5NvBgm5EUm1tDnrQj7A0e3pUVT/41W97SV3TMHcuxj
         BS2cwN9qhQaYYNRbH2udmHW5iEQsdRUtPokIuy3/YqHB+ZJy45pnJyGwOUtaSI226a8F
         nFvSfzu7DO+1es8eULspm8qFJbcoY7IZ0GKn4vK/1so8E9anCGB2np34pshq2BAGbG0m
         wX4U3OMFKz1ACU9KTzZolkH2VwqSbij9INE8WNiQ3tsvAl4nEgopSkuLc1CdfiIDrV7f
         AeJVZ3tgjFL8pBOCONqru4T7cPH7Sxz7mYeIrNOMXtTFCmQ+kcoNKwx2jBJ+2ajKtMHM
         VbFg==
X-Forwarded-Encrypted: i=1; AJvYcCUEBX5ccrImsQX3aD+9ltFeFhSt0/69UvdxJ+Xb4H4O4QEq6jIHn3HrYYRTkPq7anfpHisdmD0kJJFoNV7O@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kqcvGzqom4M22pQVT7lXopfDcbFBZzwdVAX9TVUvVVZU8c3v
	cVLlG89icgGqdbhMUPMHXGm3h2cpMK+fvSxMgml9qduhinPEIy+KytWd
X-Gm-Gg: ASbGnctSz8vb8fT5xGcNssx3s9ZnxTw1wNTJCG+dCEnKKLjVzRlBkkJsJQ4fQZM/Fax
	iEypDzVjwHaQK25/MkUULyZ91xvplYGRrOd9IAfxa9MehBn9tFwUXyqtNNbjs7VkboT0O356wmU
	NNpgMAtYcndHT7NBPC6tMBxG57uHQMQzjM/M75XRDSOm2u/Pf3h6H4gXL9xMok6aPVi7r6TWrvw
	ljQocwZVn4vRvGy1PZWuV2grGUhfijouuabplMxvtkvHmGnNAv38sPD9Kzd07hBVq5uLdHqd0DJ
	9I/q+g83sclOjC2xcrgH1txmlSGbjQMgusLBcuu8nWTONisWCGBuJAkNHfSaeIrMx7sfvq7F5dI
	VcPyid3YCzjcYS6QfcQ==
X-Google-Smtp-Source: AGHT+IEIexAyXig0bN62uElxqCZ0BEJdFN8/dBsQFbU0n2Z7fPM1EFHzzEBh1GjyP8F+q2mT/x9a3Q==
X-Received: by 2002:a17:902:ef0f:b0:240:b075:577f with SMTP id d9443c01a7336-244586c4da1mr11869055ad.37.1755124534285;
        Wed, 13 Aug 2025 15:35:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aabda2sm335794335ad.163.2025.08.13.15.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:35:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 1/2] fuse: reflect cached blocksize if blocksize was changed
Date: Wed, 13 Aug 2025 15:35:20 -0700
Message-ID: <20250813223521.734817-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813223521.734817-1-joannelkoong@gmail.com>
References: <20250813223521.734817-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out by Miklos[1], in the fuse_update_get_attr() path, the
attributes returned to stat may be cached values instead of fresh ones
fetched from the server. In the case where the server returned a
modified blocksize value, we need to cache it and reflect it back to
stat if values are not re-fetched since we now no longer directly change
inode->i_blkbits.

Link: https://lore.kernel.org/linux-fsdevel/CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com/ [1]

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 542ede096e48 ("fuse: keep inode->i_blkbits constant)
---
 fs/fuse/dir.c    | 1 +
 fs/fuse/fuse_i.h | 6 ++++++
 fs/fuse/inode.c  | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab26..ebee7e0b1cd3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1377,6 +1377,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 		generic_fillattr(idmap, request_mask, inode, stat);
 		stat->mode = fi->orig_i_mode;
 		stat->ino = fi->orig_ino;
+		stat->blksize = 1 << fi->cached_i_blkbits;
 		if (test_bit(FUSE_I_BTIME, &fi->state)) {
 			stat->btime = fi->i_btime;
 			stat->result_mask |= STATX_BTIME;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ec248d13c8bf..db44d05c8d02 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -210,6 +210,12 @@ struct fuse_inode {
 	/** Reference to backing file in passthrough mode */
 	struct fuse_backing *fb;
 #endif
+
+	/*
+	 * The underlying inode->i_blkbits value will not be modified,
+	 * so preserve the blocksize specified by the server.
+	 */
+	unsigned char cached_i_blkbits;
 };
 
 /** FUSE inode state bits */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 67c2318bfc42..3bfd83469d9f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -289,6 +289,11 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		}
 	}
 
+	if (attr->blksize)
+		fi->cached_i_blkbits = ilog2(attr->blksize);
+	else
+		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
+
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
 	 * to check permissions.  This prevents failures due to the
-- 
2.47.3


