Return-Path: <linux-fsdevel+bounces-11152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE28851A6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42808286599
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078323F9C3;
	Mon, 12 Feb 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXrPjITo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52F3D96C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757211; cv=none; b=PzY/9lQY8sMNNVHo31NSVmqwjfxXDDtyr1TYfsnfE8Dozw0t7PV9HVL0+Aw6Nr5iRtDxVOGUHCbZl3CrGqiSXgXoe01YnEGlxNNhJjnxKa5K8jLu1vuepUmTnKGV3+eW0zVeZQSpwvKJI5wPZTsLEAjSL5zsrYP0txor7VS0WA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757211; c=relaxed/simple;
	bh=7l53g4r9uK3eL4SXXr6ZAW/3PpM1Ss0BM47wmOGH+oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYkL1UzTGahGauBk6xnwekdiTytJt22NDMUTp/CbzH/qE1dckTABLJFLn+bdE/rIBxjkIknjqd3tCRnQFjgTBl1o6bLFWJHBIMPecIh2UhlcaMKR4CqXspmZTAOnuijX/rta/Fe7Fp9nqnKTsAsqyCjai55iKM2XDtIJoDfQvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXrPjITo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RflzGF+DQN60/OpUvC96cyl+K5968zvCI4MfQmmPzEc=;
	b=OXrPjIToLRwSaAFCrfJ7XB7/4KtqiPSjRYQ2EkJzXxWcBEhfUWckuUuSS3KcOnvhiYv2Mg
	I9P4KJ6rTn90psfH/NGAZh5ogsyk2346Q/DynxliizlEb2+4cPRdFMZY9hHrdGxNZHkqbc
	sts74rj7gMk5f0pFx6eDyxLMg71+AwA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-oNsRe1yDNU-laTq6rdi49Q-1; Mon, 12 Feb 2024 12:00:07 -0500
X-MC-Unique: oNsRe1yDNU-laTq6rdi49Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d101f2e09fso5535861fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757206; x=1708362006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RflzGF+DQN60/OpUvC96cyl+K5968zvCI4MfQmmPzEc=;
        b=U8j0jGe6bcXop13CDrzcCTkW8rxZMMNFdVLciXCgK+L9Zsczpd3sKEAmVZvYZo0MB7
         dqkmmIFwQwqJwSaBR0kLw4Bp+pmgdLAYKZlkJLHNf9s3RKc2CKm659ebR5oHLQN5CTqT
         qisDf/cQQ1LmeWBs7FxHDOIyTNa+L5dVaMYwUDyPYiqUzMYWpq2Ji/GO9XG1mafqOS92
         FDG1hcVILSF1Nc+toYr3fSxGPrwiplqhZCrDEIDAHDKK1UBkyNaL+qODyNzWSFS6NRD2
         giVf59EYt+JvUkLh/VgrwLHygn8VX1DpaCIwdbJtWUn51Cws7LPYMnEs6RCApOpZJbt/
         /kUA==
X-Forwarded-Encrypted: i=1; AJvYcCUY9xNDhNgRbLh7bH0F+0esYmA1b660qbTHt+tbx3ahoNU8OJmCB1rkOpMvisskt6OaW8dvYWfrD29mYjqicNBLUGPoSBDewLfSST2gNA==
X-Gm-Message-State: AOJu0YyEjlwm4cTWbm0BlLdkhl1kjmagzNLMZVu1WGE2uhEUmAZneZV8
	1XRj/iy8cBEkAjsbhvhn6tFI/UpZ2hkub3OtbduLKDSQ+nWrT3MPoQ7T0hf3+dIErPmipQ2wW+m
	HATym1n0CbJKZzPVr+wkiK+zFeYTjqV5qVwCIAcbdCpzKIUCo6XKjmXtFAL93KiXRbzaEeQ==
X-Received: by 2002:a2e:a714:0:b0:2d0:c3f8:d3b7 with SMTP id s20-20020a2ea714000000b002d0c3f8d3b7mr4320303lje.8.1707757205864;
        Mon, 12 Feb 2024 09:00:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG72MY/zWOPQ2v6XwG+yAyFluuh1CkAYjSjeHPHCrF1ln3wDLd477OAaxYVkHR1fVJIi26RWQ==
X-Received: by 2002:a2e:a714:0:b0:2d0:c3f8:d3b7 with SMTP id s20-20020a2ea714000000b002d0c3f8d3b7mr4320288lje.8.1707757205588;
        Mon, 12 Feb 2024 09:00:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCI5xWx6JvLyWfSAJ6Q4WFI2AndwXEgkjcWOi3n7UScazaiXlJQ3F+5O3ZEeLnF3mMvZUMM0Kqk2f6Elig3wKaA0R4H3TluAWPPO6pG3SjLSFg5pBrn8aRmVycUWixqOVOv+k7yfAnsc5xBH+B9zh0oK5WbAWxOLh7Eq3i2nz9PR12zhEnwLMV2j69+GVLpDZbKGuppdns9JNzBj4DslocMxNUPuwqDyFW
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:03 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 12/25] xfs: add XFS_DA_OP_BUFFER to make xfs_attr_get() return buffer
Date: Mon, 12 Feb 2024 17:58:09 +0100
Message-Id: <20240212165821.1901300-13-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With XBF_VERITY_SEEN flag on xfs_buf XFS can track which buffers
contain verified Merkle tree blocks. However, we also need to expose
the buffer to pass a reference of underlying page to fs-verity.

This patch adds XFS_DA_OP_BUFFER to tell xfs_attr_get() to
xfs_buf_hold() underlying buffer and return it as xfs_da_args->bp.
The caller must then xfs_buf_rele() the buffer. Therefore, XFS will
hold a reference to xfs_buf till fs-verity is verifying xfs_buf's
content.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr.c        |  5 ++++-
 fs/xfs/libxfs/xfs_attr_leaf.c   |  7 +++++++
 fs/xfs/libxfs/xfs_attr_remote.c | 13 +++++++++++--
 fs/xfs/libxfs/xfs_da_btree.h    |  5 ++++-
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index f9846df41669..8e3138af4a5f 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -252,6 +252,8 @@ xfs_attr_get_ilocked(
  * If the attribute is found, but exceeds the size limit set by the caller in
  * args->valuelen, return -ERANGE with the size of the attribute that was found
  * in args->valuelen.
+ *
+ * Using XFS_DA_OP_BUFFER the caller have to release the buffer args->bp.
  */
 int
 xfs_attr_get(
@@ -270,7 +272,8 @@ xfs_attr_get(
 	args->hashval = xfs_da_hashname(args->name, args->namelen);
 
 	/* Entirely possible to look up a name which doesn't exist */
-	args->op_flags = XFS_DA_OP_OKNOENT;
+	args->op_flags = XFS_DA_OP_OKNOENT |
+					(args->op_flags & XFS_DA_OP_BUFFER);
 
 	lock_mode = xfs_ilock_attr_map_shared(args->dp);
 	error = xfs_attr_get_ilocked(args);
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 6374bf107242..51aa5d5df76c 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -2449,6 +2449,13 @@ xfs_attr3_leaf_getvalue(
 		name_loc = xfs_attr3_leaf_name_local(leaf, args->index);
 		ASSERT(name_loc->namelen == args->namelen);
 		ASSERT(memcmp(args->name, name_loc->nameval, args->namelen) == 0);
+
+		/* must be released by the caller */
+		if (args->op_flags & XFS_DA_OP_BUFFER) {
+			xfs_buf_hold(bp);
+			args->bp = bp;
+		}
+
 		return xfs_attr_copy_value(args,
 					&name_loc->nameval[args->namelen],
 					be16_to_cpu(name_loc->valuelen));
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index d440393b40eb..72908e0e1c86 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -424,9 +424,18 @@ xfs_attr_rmtval_get(
 			error = xfs_attr_rmtval_copyout(mp, bp, args->dp->i_ino,
 							&offset, &valuelen,
 							&dst);
-			xfs_buf_relse(bp);
-			if (error)
+			xfs_buf_unlock(bp);
+			/* must be released by the caller */
+			if (args->op_flags & XFS_DA_OP_BUFFER)
+				args->bp = bp;
+			else
+				xfs_buf_rele(bp);
+
+			if (error) {
+				if (args->op_flags & XFS_DA_OP_BUFFER)
+					xfs_buf_rele(args->bp);
 				return error;
+			}
 
 			/* roll attribute extent map forwards */
 			lblkno += map[i].br_blockcount;
diff --git a/fs/xfs/libxfs/xfs_da_btree.h b/fs/xfs/libxfs/xfs_da_btree.h
index 706baf36e175..1534f4102a47 100644
--- a/fs/xfs/libxfs/xfs_da_btree.h
+++ b/fs/xfs/libxfs/xfs_da_btree.h
@@ -59,6 +59,7 @@ typedef struct xfs_da_args {
 	uint8_t		filetype;	/* filetype of inode for directories */
 	void		*value;		/* set of bytes (maybe contain NULLs) */
 	int		valuelen;	/* length of value */
+	struct xfs_buf	*bp;		/* OUT: xfs_buf which contains the attr */
 	unsigned int	attr_filter;	/* XFS_ATTR_{ROOT,SECURE,INCOMPLETE} */
 	unsigned int	attr_flags;	/* XATTR_{CREATE,REPLACE} */
 	xfs_dahash_t	hashval;	/* hash value of name */
@@ -93,6 +94,7 @@ typedef struct xfs_da_args {
 #define XFS_DA_OP_REMOVE	(1u << 6) /* this is a remove operation */
 #define XFS_DA_OP_RECOVERY	(1u << 7) /* Log recovery operation */
 #define XFS_DA_OP_LOGGED	(1u << 8) /* Use intent items to track op */
+#define XFS_DA_OP_BUFFER	(1u << 9) /* Return underlying buffer */
 
 #define XFS_DA_OP_FLAGS \
 	{ XFS_DA_OP_JUSTCHECK,	"JUSTCHECK" }, \
@@ -103,7 +105,8 @@ typedef struct xfs_da_args {
 	{ XFS_DA_OP_NOTIME,	"NOTIME" }, \
 	{ XFS_DA_OP_REMOVE,	"REMOVE" }, \
 	{ XFS_DA_OP_RECOVERY,	"RECOVERY" }, \
-	{ XFS_DA_OP_LOGGED,	"LOGGED" }
+	{ XFS_DA_OP_LOGGED,	"LOGGED" }, \
+	{ XFS_DA_OP_BUFFER,	"BUFFER" }
 
 /*
  * Storage for holding state during Btree searches and split/join ops.
-- 
2.42.0


