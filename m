Return-Path: <linux-fsdevel+bounces-13533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402FD870A50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB88A2814F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2597CF26;
	Mon,  4 Mar 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEWv/xvF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBA7A738
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579548; cv=none; b=GWyETED9yi+YUQ36EGO9B5YOnIHwIqKdXvskxmRhAUQx7SY/HISJn+PPM8NfKjwjIAdve/4hUkF0xYc9sspNL9VQCdU4NMPBpFdh++FlzYqGXPjE+O1/q3ZLDpU/gbmwoG+4Qe2dOJpav6/iQ24vfZ62XeBy59OGUmxcQOibWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579548; c=relaxed/simple;
	bh=9uF/gGYjOQ5Ye08pQkNJ3SDKEd0FLQXNLEu3pluKIXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbRDJzC4R19NjD/PQJb5BO7XO8mbn4t0yoc7emhgRQZojZIis5rDhSwRRyfsDwxMvqMUiPQNLFV8fVqUisdP7IFDocVN6xR6PoJ3B72nNsIQjhOKjvuARsXPpI2D34ItxqsrVrKhpSgVaCVk/eTCsXBrGZ/v4ylDZSAvpZy5TZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEWv/xvF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmDanQiWXuoYzgvi/CRZldtSQVaE9CKTrb+6HTaNdLk=;
	b=AEWv/xvFBgVrZFXqIrm4oyFlqaj/OYtru4uZcYChQbclfO8zT3DAmcRQoC/nczWaNtI/4d
	AjC01FOLK8/DtBb+gW7wcL8SPsKkQsYeTWow9MzihlmdOhktopZqwMQ5irH9dU9+XKtqtU
	Y6F3Y6R60/xCR763eblVzUE7kORHO0g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-t5oyOBZBOBS-qsPPlR4ihQ-1; Mon, 04 Mar 2024 14:12:23 -0500
X-MC-Unique: t5oyOBZBOBS-qsPPlR4ihQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4585db429bso37602066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579542; x=1710184342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmDanQiWXuoYzgvi/CRZldtSQVaE9CKTrb+6HTaNdLk=;
        b=r3o6Y0ztvygff6QipNdfuTPyCxDUGCO7H2Z8J4b5vuNy53iAQodAKCj73Ssd8tWZ1V
         Gt/GQfVVmDkj6hv0AXF1VkuLzf1Qli3jyHddDpTv1IQVmuaUM8qYwMd7jxJBklv3Mq4Q
         JlqZspud+Ypq309KLIv5PhJgjubBA/idrWBHZrXrc5oC2CFTRlM0pm6fQhB76rihNSzW
         ygQVsXJPE8d8jYv3dvjMbHc4IamogeDp8LCQBDbvptKmIg8aubAWQXOElmuJdPFN5Mqa
         fHzVijCYBL7GjoY4DWuim6bBdKPHtkIRpcStTOfHtzoxwzbKiAe8I10IBIQO7cWjCCEx
         Povg==
X-Forwarded-Encrypted: i=1; AJvYcCVjT5KJDiq/DRt11LXNQa7LitYgGmXjwIxHlbPCd7kukXVDeXH12dt/YuBlm50kqdugkQFcgqg9UhuaZfE6Tuyb2+OrDWm/1mGbS2uddg==
X-Gm-Message-State: AOJu0Yy9TvN2Q7T+923fm5V1hC4g/eSjqBF4fC5+08I/D7GcYEEToiMb
	CYFkzcMeaN1/fQmr9C+aj4qevtwRe4D9d0xlQ3EPZLXfu9+pH/KcMflGrPEMxPH23gZU+tQh6zt
	P4Y9wNu+1B9V7TDLre7TxjNYohI0lo+/c46FcsRCr6GZoIQ+tVOBU/yzUs6FUpJOr93du0g==
X-Received: by 2002:a17:906:594d:b0:a43:67c9:8c99 with SMTP id g13-20020a170906594d00b00a4367c98c99mr6545385ejr.40.1709579542540;
        Mon, 04 Mar 2024 11:12:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3TyDPXFshe/zEpv5TCj6l9Hs6J3ED58Rj/plqx/9h46KPxC8C0wHuAc9JrQgCu1bY774XWQ==
X-Received: by 2002:a17:906:594d:b0:a43:67c9:8c99 with SMTP id g13-20020a170906594d00b00a4367c98c99mr6545364ejr.40.1709579541932;
        Mon, 04 Mar 2024 11:12:21 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:21 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 12/24] xfs: add XFS_DA_OP_BUFFER to make xfs_attr_get() return buffer
Date: Mon,  4 Mar 2024 20:10:35 +0100
Message-ID: <20240304191046.157464-14-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
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
index f0b625d45aa4..ca515e8bd2ed 100644
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
index ac904cc1a97b..b51f439e4aed 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -2453,6 +2453,13 @@ xfs_attr3_leaf_getvalue(
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
index ff0412828772..4b44866479dc 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -429,9 +429,18 @@ xfs_attr_rmtval_get(
 			error = xfs_attr_rmtval_copyout(mp, bp, args->dp,
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


