Return-Path: <linux-fsdevel+bounces-57590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95843B23B25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AAC6E61B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D922E54AB;
	Tue, 12 Aug 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUvs2NUT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5CB2E541C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035261; cv=none; b=Tzv/QsfnGBh2Bj0GdO4avjuss3OuVti95tCx3ky3LkfrChYknYHOQP5fieoHKY3DMWogWmejaa8EhN8wGD2CYmC8TtJ9HU/7U/Dmet9jW/M2R4sLwhm7tQ3Jx1rEFNgjaPxzR+9vgiuoa3/hFkC3weJwYcERKSkNPqsw3gqfcVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035261; c=relaxed/simple;
	bh=VueitJscIKRWicbYQMXqZCMMYSJWZaN88KY7EOeeZkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlVFCI3rHWPYclCvkOSOr15RLCMOLLrbu/B9WYzJMjVkPEO3VhacDVPQdNWbo2lidONbP0/szObQzmH52GO4k5a5vjaqMD3In2r7dU0UfqyiFM4rnjcIrWbSmZwSHa6LIWPY1uDikdOJECkHKiOV6j0M5lMdhWRR2bCjQyd4C4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUvs2NUT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso5212469b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 14:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035257; x=1755640057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4y0QjImL352dlk74SIXhCOdb9IBBUQ2v3/hGWoBzVQ=;
        b=LUvs2NUTKhQMkbQEzTqVc5aUxFcLyk10nT/bjLekDm8Gx7i9jtNWqxUi8gmfA1AE9e
         w8zCqjDRZ407hvEXBb9iR10qkN8ZEUdIctmc/NkylcCHTzYUEsnPunSy45jOyXg9MWjX
         1nNbpy7ZN2Yeyz20LXh2EWdO+Zjke78D3uYf7jkUHEyHLFiBKgnE3NQUbWcGGrCr/PIO
         mJNUAAOWVYXWq7T0fSX5nOaJbWVwJwasvJtZPwnb/VxbVoH6o2I/Q2WwpQcDKfvdp2XW
         BRjgm5BUm6XDk31BRjMonNOOItl6ylORi5o8umjaWxur0rR32RvLfWzTv2sK+JJchc7G
         hkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035257; x=1755640057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4y0QjImL352dlk74SIXhCOdb9IBBUQ2v3/hGWoBzVQ=;
        b=FpDkKhdKxhaFMxbZIJm+ql1r5GN0PJqcmF2pYj+G+KZNwIJem6W1mHcm6LY/Rb4s6E
         4TvC8ukensI2ZM2/qwF5Kll+9BT7kbffDx8v0gaq/qiAK/yvb+oTgKbTxyCrK4DnrCQk
         TptZjtu4vlawvoZkthw83iNA25wjpb3BMjtj7FSoSKAvZgVAHepEzYpYpjVNsi+HyVq1
         S8z5NJgQy67N25QlHQZarWRAL0SOm4OtxDFEd1F/8dO1tMvvyPR4nLXHxL7HVHoEZihm
         BJhWyw23kCkAeqxSqjy3No44dR4Fn/xxrvTsSp7bRiYGLrolaa/ErHMgtC6ujzD4BbUo
         ibVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlkVPt8GXKwU0REe6PykmoEGeVymQGyDTigdW06Ss6hx4nIYSK/uhQiQRRJk1hNZwwuj8tXhaWHLhMLhhM@vger.kernel.org
X-Gm-Message-State: AOJu0YxfP9XK68ndrB00fU0p+D9yTqkrvJg2MG3tnamo9yL7rwNXEI4O
	ztW74ADF6RhIEGfRWPbSHqTd19N3PeoP+sC7ZAmhxwi83j1zgHunk/kv
X-Gm-Gg: ASbGncvjKqAvLleZUr208aUsEQwW5WK0RHHn50dYeJl56/jk1Xs45EzHdknul/mKOIY
	2ntgIlbqxmslKAaQPgUq1efRf8oiH2jKVWc6Rlx1Bri7SDRP7Z8NdV083Nz9WEg0kVB4qaqgoQ5
	LC2C7+i/rjE097bWAwk+a8TSqiKSYEWHQJPMCT+DDvT/99M+2k8+EoS/Af0htKp/DhGQvA0eKVB
	8Ca4eU2xdhBWWDqePk6fdOHSqGAqadONr5iYlcysyKB6dH2ETqMRDhpNqGv3HWH+9vcX+nFGVYu
	fHm51j4pbV3Tja2ari+RIIlroS8dkrMFKSpR/eo6ON0+AQOVYb9VJS5Zup91HBpNueAvmU4eSXB
	KcC4qJ9lYC1Ic72SY
X-Google-Smtp-Source: AGHT+IEb+rqqS+LUHg5gDMrga5JcqxV6HioAAG5LK09wD2Pe9ez6x/JYFhR6dcU1bZAH+NRf8DjdCA==
X-Received: by 2002:a05:6a00:2d23:b0:76b:d7e7:f1de with SMTP id d2e1a72fcca58-76e20fbc777mr853152b3a.17.1755035256503;
        Tue, 12 Aug 2025 14:47:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf8f12c95sm23767499b3a.2.2025.08.12.14.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:47:36 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/2] fuse: reflect cached blocksize if blocksize was changed
Date: Tue, 12 Aug 2025 14:46:13 -0700
Message-ID: <20250812214614.2674485-2-joannelkoong@gmail.com>
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


