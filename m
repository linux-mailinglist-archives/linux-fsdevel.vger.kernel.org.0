Return-Path: <linux-fsdevel+bounces-61106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468DCB55389
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B241D681BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC86F3168EA;
	Fri, 12 Sep 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irljk7+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD3306490
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690896; cv=none; b=QuUvzhQPGaIi7xMpBij/R1+eBLv1r0gCZHIA72dNOi1XoKmxqWdZQMY1s0FL8XfCR+II0hnlKyUovR+3lRcoa8lTK5PtBHiEPd+JbTS1a82gFH2NK0v/JSTf+ruTQYAR1QHWmHxvQGkSN97n665nCItCtlm8kzIOFq+IohHKM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690896; c=relaxed/simple;
	bh=CgyNEahm5gOOpEEykICG0JY6xqFEbeq32tKyTBTcXas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCb/4UKt2n7gwM63CUT23p1kknoF8vv8xhHronwlIoiRMnq4O/WqP1o1Q+R+UenqyNrBWs+a8AYxPJzGmb3UbCGxFHZl95X90bu9+qjYAU4W7VRhADiLukOaAmLFPFYCmawqdPm1JWpP32RdYBSJ7B4Ve1rwO5bztQEsqeNmpZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irljk7+v; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77264a94031so1618634b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690894; x=1758295694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qddzG88P0MDINuI3ttRfHIuZNQHYMA6MDyCfUKvDRo8=;
        b=Irljk7+vDXy/JeNOFoyMtzEjf1+GXyhS/GhnvZCuT5RQkU0ZPM9f05VzEknXVh8DqL
         Xp72IENBjSht0uXzdssiS6yXGy3wsQf6i0ygA5J5yp+5A3fByuP3pVpN4VTpAK8SplV3
         47I5Q2WVZXwLqCu3Svc8zzlrMRHsdjJiaFRz8z88QFCayW1+b2Z9YKremvvnTda3BB/b
         Nq3xuBaKwofmLvounCEzFFYS+frnVVe1uCbIFoIdTw+Y0amBqReYmNoqgYrRnJhZ2fsS
         h3X9L2C7PEVGOaZeP8X71y4/KCZCpcm6XRoWafb8onZW0F8lXZSu7F3WkfZsM+hFAup3
         PtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690894; x=1758295694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qddzG88P0MDINuI3ttRfHIuZNQHYMA6MDyCfUKvDRo8=;
        b=KSvl4asbmBZuVIXy4ma/adUYZir3FVyy8TQMLaIqsQm+GOUEIX0sAYyYNGtmFFBLSZ
         u2Ltjh1flm+fC1roqhSgBFHIxdDubOHF1i9KWsE1hsPZnSlW2KUz8eF+Wm++6uPsj87r
         KrRZllt9/OAbUhGTyTtmIR5pKiO5zUf1z1lmfLPH4EUwfFLgyVWl1XoS7kikYNwXCdVn
         jv/OdMdv9NdmsVvrUvHV0d8shq0e0h0tc812lrsmp5kFRAKj3HHw1hjQtfhdUKfVhm/a
         fvbIVvEGnXc6R682jxQxxWoTm0kbyzcy03+Y8yrQeEdunszRWcNeJHSUCEl03952bgcU
         1A7A==
X-Forwarded-Encrypted: i=1; AJvYcCXMkLeuqPOpIL9hNSJhX3YloUQrOhAOr9vHAJhrHCVjFp42CsLW6mugF355JM3pNTjlgGsfvxxjU0+Q/CzL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Hx7Tk5asgT0a2TrYg9qG+5mRjKA9TsAEP/czf5oA9vQoyWgh
	8KzAml4JdGwuNjW5CpnqHYG5yqLVAi52fDJarJ4lJRj5PZSFIEqr4Gav
X-Gm-Gg: ASbGnctc6uIJh26fHQCnurkGq2dzuHJ1GJIcm8fuBqI0n5PZhKCgHRvdDxq75Z0yCKX
	f0yD4qckxTYp/z9AzQD4aPyuf2ia3vavf5bQJFplTu2NSIQFDPjrrd7E4bzFXu2WVsRRFE8vrf/
	+TdFIUwiEvkqkk8G+11cqUqERyC0rM+shUffVbq4+DByKLD+ZIhveMKY0fS5JXBpr69/a3YUD5W
	80o2W17WlmSt4SbLmTGSVrYUUJ/R6TDnh/YY5QbIcsI/I93QERa4+E8TmqyMGX5ulQexGXgk+P+
	G1k+DalMxc5QKMnFnXwhVkgjSohZMugTrER4XMObBRU+rugRoPlsvfrX4TWH1K54Z/pCeYBHtI9
	Y2W7wtJMaP1U7lQ2lRFgmcszsMw==
X-Google-Smtp-Source: AGHT+IHSzv32UvYk1/EENIG2Gkyl/RiUekw8QXYbvFQu5Nyt93BDAZEn7q5Lm/tAAdYqDnZf6JgTdA==
X-Received: by 2002:a05:6a20:3c8e:b0:24c:2fa1:fddb with SMTP id adf61e73a8af0-2602cd2779cmr4539525637.53.1757690893744;
        Fri, 12 Sep 2025 08:28:13 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:28:13 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 10/10] xfs: add support for non-blocking fh_to_dentry()
Date: Fri, 12 Sep 2025 09:28:55 -0600
Message-ID: <20250912152855.689917-11-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912152855.689917-1-tahbertschinger@gmail.com>
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to support using open_by_handle_at(2) via io_uring. It is useful
for io_uring to request that opening a file via handle be completed
using only cached data, or fail with -EAGAIN if that is not possible.

The signature of xfs_nfs_get_inode() is extended with a new flags
argument that allows callers to specify XFS_IGET_INCORE.

That flag is set when the VFS passes the FILEID_CACHED flag via the
fileid_type argument.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/xfs/xfs_export.c | 34 ++++++++++++++++++++++++++--------
 fs/xfs/xfs_export.h |  3 ++-
 fs/xfs/xfs_handle.c |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index 201489d3de08..6a57ed8fd9b7 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -106,7 +106,8 @@ struct inode *
 xfs_nfs_get_inode(
 	struct super_block	*sb,
 	u64			ino,
-	u32			generation)
+	u32			generation,
+	uint			flags)
 {
  	xfs_mount_t		*mp = XFS_M(sb);
 	xfs_inode_t		*ip;
@@ -123,7 +124,9 @@ xfs_nfs_get_inode(
 	 * fine and not an indication of a corrupted filesystem as clients can
 	 * send invalid file handles and we have to handle it gracefully..
 	 */
-	error = xfs_iget(mp, NULL, ino, XFS_IGET_UNTRUSTED, 0, &ip);
+	flags |= XFS_IGET_UNTRUSTED;
+
+	error = xfs_iget(mp, NULL, ino, flags, 0, &ip);
 	if (error) {
 
 		/*
@@ -140,6 +143,10 @@ xfs_nfs_get_inode(
 		case -EFSCORRUPTED:
 			error = -ESTALE;
 			break;
+		case -ENODATA:
+			if (flags & XFS_IGET_INCORE)
+				error = -EAGAIN;
+			break;
 		default:
 			break;
 		}
@@ -170,10 +177,15 @@ xfs_nfs_get_inode(
 
 STATIC struct dentry *
 xfs_fs_fh_to_dentry(struct super_block *sb, struct fid *fid,
-		 int fh_len, int fileid_type)
+		 int fh_len, int fileid_type_flags)
 {
+	int			fileid_type = FILEID_TYPE(fileid_type_flags);
 	struct xfs_fid64	*fid64 = (struct xfs_fid64 *)fid;
 	struct inode		*inode = NULL;
+	uint			flags = 0;
+
+	if (fileid_type_flags & FILEID_CACHED)
+		flags = XFS_IGET_INCORE;
 
 	if (fh_len < xfs_fileid_length(fileid_type))
 		return NULL;
@@ -181,11 +193,11 @@ xfs_fs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	switch (fileid_type) {
 	case FILEID_INO32_GEN_PARENT:
 	case FILEID_INO32_GEN:
-		inode = xfs_nfs_get_inode(sb, fid->i32.ino, fid->i32.gen);
+		inode = xfs_nfs_get_inode(sb, fid->i32.ino, fid->i32.gen, flags);
 		break;
 	case FILEID_INO32_GEN_PARENT | XFS_FILEID_TYPE_64FLAG:
 	case FILEID_INO32_GEN | XFS_FILEID_TYPE_64FLAG:
-		inode = xfs_nfs_get_inode(sb, fid64->ino, fid64->gen);
+		inode = xfs_nfs_get_inode(sb, fid64->ino, fid64->gen, flags);
 		break;
 	}
 
@@ -194,10 +206,15 @@ xfs_fs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 
 STATIC struct dentry *
 xfs_fs_fh_to_parent(struct super_block *sb, struct fid *fid,
-		 int fh_len, int fileid_type)
+		 int fh_len, int fileid_type_flags)
 {
+	int			fileid_type = FILEID_TYPE(fileid_type_flags);
 	struct xfs_fid64	*fid64 = (struct xfs_fid64 *)fid;
 	struct inode		*inode = NULL;
+	uint			flags = 0;
+
+	if (fileid_type_flags & FILEID_CACHED)
+		flags = XFS_IGET_INCORE;
 
 	if (fh_len < xfs_fileid_length(fileid_type))
 		return NULL;
@@ -205,11 +222,11 @@ xfs_fs_fh_to_parent(struct super_block *sb, struct fid *fid,
 	switch (fileid_type) {
 	case FILEID_INO32_GEN_PARENT:
 		inode = xfs_nfs_get_inode(sb, fid->i32.parent_ino,
-					      fid->i32.parent_gen);
+					      fid->i32.parent_gen, flags);
 		break;
 	case FILEID_INO32_GEN_PARENT | XFS_FILEID_TYPE_64FLAG:
 		inode = xfs_nfs_get_inode(sb, fid64->parent_ino,
-					      fid64->parent_gen);
+					      fid64->parent_gen, flags);
 		break;
 	}
 
@@ -248,4 +265,5 @@ const struct export_operations xfs_export_operations = {
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
 #endif
+	.flags			= EXPORT_OP_NONBLOCK,
 };
diff --git a/fs/xfs/xfs_export.h b/fs/xfs/xfs_export.h
index 3cd85e8901a5..9addfcd5b1e1 100644
--- a/fs/xfs/xfs_export.h
+++ b/fs/xfs/xfs_export.h
@@ -57,6 +57,7 @@ struct xfs_fid64 {
 /* This flag goes on the wire.  Don't play with it. */
 #define XFS_FILEID_TYPE_64FLAG	0x80	/* NFS fileid has 64bit inodes */
 
-struct inode *xfs_nfs_get_inode(struct super_block *sb, u64 ino, u32 gen);
+struct inode *xfs_nfs_get_inode(struct super_block *sb, u64 ino, u32 gen,
+				uint flags);
 
 #endif	/* __XFS_EXPORT_H__ */
diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index f19fce557354..7d877ff504d6 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -193,7 +193,7 @@ xfs_khandle_to_inode(
 		return ERR_PTR(-EINVAL);
 
 	inode = xfs_nfs_get_inode(mp->m_super, handle->ha_fid.fid_ino,
-			handle->ha_fid.fid_gen);
+			handle->ha_fid.fid_gen, 0);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-- 
2.51.0


