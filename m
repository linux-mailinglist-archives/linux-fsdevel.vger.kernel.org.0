Return-Path: <linux-fsdevel+bounces-11143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B48B851A5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51903285A23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0003E462;
	Mon, 12 Feb 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3GI5FRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58413D568
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757198; cv=none; b=W9440JEoAqmBhEfs1obUI1j1bgKOJAHaQLTVRqBN8/WPBp7SmJX8fDig3bvzA5I57n3D9Qbdzr5BpW0aado9/HkCE72KEFxjjkPCzNb5OkyCQDw7k3TnjUFPjZFfH4vNlntYqnPpZZVpexWavuCtRoTfLsC6bQieBQnoU3/CGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757198; c=relaxed/simple;
	bh=87EPGtfLnNyrrHm7LdrhSWDHeKqbwuyh0xK6FyLRPoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTrm1NzmGBfnSHARL1HVJ2IywkKWhf7KkCbXR/mFGwIKYOmmsevVqnU0rSmECRhFnCs2Rp87nyCbm6pnZcmqIPApGxSQ62vkAprVn9wUaIik3Sp3o/lx5HhKHWgJCdoycaZ3Ytv/AoPO+0OVCI6dQ4UM4UE1GFevzUs6U1fNnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3GI5FRx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwoEMzof6tyueQTnUsTnW4349H23j9VoC/QRGqyWkKM=;
	b=X3GI5FRxvdZDu3YXBXmSqIJw24+p+YoVIQ3IGtJ+QibzcWYT/8xY8M1yOlNFo++mTLVpy/
	RIfS5Cq8JoXt3DLM+bsdgqoJ0lDl3hjRsX7hBlKLrB6ecFjFLGox3gjaGjc/oJCey1gFof
	M4iP4FGXhfMYRJKjkOCtIXE2qHvC6D4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-3dDUdy4pO8ODnrcHbM2-JQ-1; Mon, 12 Feb 2024 11:59:53 -0500
X-MC-Unique: 3dDUdy4pO8ODnrcHbM2-JQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55ffcfed2ffso4899037a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 08:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757192; x=1708361992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwoEMzof6tyueQTnUsTnW4349H23j9VoC/QRGqyWkKM=;
        b=b+Ukhx1rNiPEwnZAfNlLkR9SbudH5sEtgBi0fp5y87mDGaKI+AYz/ck8tWKNviOQOa
         DySmV+7UvhKxb7LKQSRhWKskd7WDYANdA/9ANC1V9U7Y474h4VY+PBbV7pGGzYUjFBXh
         lPRGNgcuw+NWh9THYqwrKz4sk460OHtmcCVq+7VCv2UvELeGr2USz4IyXo29/OTGfGOZ
         BUVk6Z1OFe9pCE57EiWqGGBqHKFcGI9jw1FumF5jmwtZJlmmUvwwMxVZ0/pzT8s58kqH
         /XTp1V6dkAgi04moU1yioQFvv6ioX4CG0ZkStdT1rVNu57cSpy/7QhIkxD7OBxZG+5zD
         uLdg==
X-Forwarded-Encrypted: i=1; AJvYcCUh4SSQPD7+9i4P9OjpFIUiv1VTlI+pK+CKaF/mscHpsiAZ9ldMhUUlm7QEc1NLFuX8lEilRbjjexbQzXPw5mWmUvhkBpi10BDxDsB3+A==
X-Gm-Message-State: AOJu0Yxk1cVEZxQY/ufh5zRkWiOqHhqkutIfRa+MyvR9M2A6n3cxPv2L
	Goe1r+gqltKT/qskv5wGBGe3swLr8tWoDjwGonRUY4vrbadJOm5Pt8ppitzVNMNKZdD6XoG+lHK
	SyXgG39obTmkaoV+39SHMS9Rb5qNQVXUn80q4EagQXqkpNFilhYpcrsjl7Cx+5w==
X-Received: by 2002:aa7:d981:0:b0:560:f90e:4da3 with SMTP id u1-20020aa7d981000000b00560f90e4da3mr98348eds.0.1707757192131;
        Mon, 12 Feb 2024 08:59:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfoUglQy6VQsrJO7Bagpl3UpwVFuud3MHrG+CNzln++dGXQv+WdUFa5OXovBNIauYyQ9cb3w==
X-Received: by 2002:aa7:d981:0:b0:560:f90e:4da3 with SMTP id u1-20020aa7d981000000b00560f90e4da3mr98331eds.0.1707757191771;
        Mon, 12 Feb 2024 08:59:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhqGB6LbMhOcQTOQgMj83RdGTEaY3whGVGA8PGqFvwppxAzy8CpFHJkl6rYQf2kAItMH8HOxTUL6AGyf+3FSY2zvJsR/pI04kLc506uc4/aJwM48k67gNBX62vrEnp4WvkoJxC7o6d+vBiHtYj0hTnoc5ObmWXKh4xKDS8jI5CkjTcQvGZk8kwP+thsw+hRdRPVWZSlSpcD56gF6LDBDXIw4kTlNenUcMBMLN++ug0Xu4lNlSPOI2gA0xs9/NG9dVt9+p1cKx9JUmsoeI31hAT
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:59:51 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>,
	Mark Tinguely <tinguely@sgi.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v4 02/25] xfs: add parent pointer support to attribute code
Date: Mon, 12 Feb 2024 17:57:59 +0100
Message-Id: <20240212165821.1901300-3-aalbersh@redhat.com>
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

From: Allison Henderson <allison.henderson@oracle.com>

Add the new parent attribute type. XFS_ATTR_PARENT is used only for parent pointer
entries; it uses reserved blocks like XFS_ATTR_ROOT.

Signed-off-by: Mark Tinguely <tinguely@sgi.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c       | 3 ++-
 fs/xfs/libxfs/xfs_da_format.h  | 5 ++++-
 fs/xfs/libxfs/xfs_log_format.h | 1 +
 fs/xfs/scrub/attr.c            | 2 +-
 fs/xfs/xfs_trace.h             | 3 ++-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index e965a48e7db9..1292ab043b4f 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -924,7 +924,8 @@ xfs_attr_set(
 	struct xfs_inode	*dp = args->dp;
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_trans_res	tres;
-	bool			rsvd = (args->attr_filter & XFS_ATTR_ROOT);
+	bool			rsvd = (args->attr_filter & (XFS_ATTR_ROOT |
+							     XFS_ATTR_PARENT));
 	int			error, local;
 	int			rmt_blks = 0;
 	unsigned int		total;
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 24f9d1461f9a..18e8c7d44ab8 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -703,12 +703,15 @@ struct xfs_attr3_leafblock {
 #define	XFS_ATTR_LOCAL_BIT	0	/* attr is stored locally */
 #define	XFS_ATTR_ROOT_BIT	1	/* limit access to trusted attrs */
 #define	XFS_ATTR_SECURE_BIT	2	/* limit access to secure attrs */
+#define	XFS_ATTR_PARENT_BIT	3	/* parent pointer attrs */
 #define	XFS_ATTR_INCOMPLETE_BIT	7	/* attr in middle of create/delete */
 #define XFS_ATTR_LOCAL		(1u << XFS_ATTR_LOCAL_BIT)
 #define XFS_ATTR_ROOT		(1u << XFS_ATTR_ROOT_BIT)
 #define XFS_ATTR_SECURE		(1u << XFS_ATTR_SECURE_BIT)
+#define XFS_ATTR_PARENT		(1u << XFS_ATTR_PARENT_BIT)
 #define XFS_ATTR_INCOMPLETE	(1u << XFS_ATTR_INCOMPLETE_BIT)
-#define XFS_ATTR_NSP_ONDISK_MASK	(XFS_ATTR_ROOT | XFS_ATTR_SECURE)
+#define XFS_ATTR_NSP_ONDISK_MASK \
+			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT)
 
 /*
  * Alignment for namelist and valuelist entries (since they are mixed
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 269573c82808..eb7406c6ea41 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -972,6 +972,7 @@ struct xfs_icreate_log {
  */
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
+					 XFS_ATTR_PARENT | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 83c7feb38714..49f91cc85a65 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -494,7 +494,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE);
+			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
 	if ((ent->flags & badflags) != 0)
 		xchk_da_set_corrupt(ds, level);
 	if (ent->flags & XFS_ATTR_LOCAL) {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 0984a1c884c7..07e8a69f8e56 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -83,7 +83,8 @@ struct xfs_perag;
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
 	{ XFS_ATTR_SECURE,	"SECURE" }, \
-	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }
+	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }, \
+	{ XFS_ATTR_PARENT,	"PARENT" }
 
 DECLARE_EVENT_CLASS(xfs_attr_list_class,
 	TP_PROTO(struct xfs_attr_list_context *ctx),
-- 
2.42.0


