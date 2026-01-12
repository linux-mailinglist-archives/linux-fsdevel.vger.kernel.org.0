Return-Path: <linux-fsdevel+bounces-73248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA91D136AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50BFD309AD80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065252DECB2;
	Mon, 12 Jan 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awRhHrGr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaCeT2vj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159352DF3CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229439; cv=none; b=BYCnnVqli8pLJ74xZqVtpaMgkm+Xpt+tzkGqQLzZ75D4XZhJHww8CoOV4kbunvWYIaORe2JTdmKrS4U2Lik69jIRcz6WfFL6tj9mJhUudZfT53L7y6KIDZ545Blop/zgH1EycMIRCXYd1FXq2wAEo1vP1s/Ymk5eg+ThELezC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229439; c=relaxed/simple;
	bh=XXRH7b/0i4ueWjWQWLdmXozm6ynpX7HcGCIutMaFY1A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERZJtNXqR/RQuaBDzqNAFs3WA5pqUpRoDd4DMTe2ij1j9u8Pq0QPn0jxEaoJC9RcF9z3rWavq9XOX8+J8I9xkbQzKrCFCWpha0RSWUemp+N4+2k7+jGufrlfqNwFmtksq2dFvoTZJbHj1kXAX48J5XCMHIO59xFliAreTIqudV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awRhHrGr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaCeT2vj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nb5UIQxqvdSkHiFjYiKVV8nmw/xrhaJumJsBcf3A06Q=;
	b=awRhHrGrS0Drx1vGt3cY08i+jsFr1U0xVJSw8gN1wtVjwF7hq+1OfiuKKqSe8HEDAKLh+/
	TpAhjAYmvWoybc8q3RiSlTYDjaQIw/Potv20O0l/SrL1kKgG/jFbp97jKqqc7LPy11dP9d
	lHcb+j6DB57n9Yf+pPbZf16XIr/vgF8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-_OfTzV15N5y5sxgId5V8cw-1; Mon, 12 Jan 2026 09:50:35 -0500
X-MC-Unique: _OfTzV15N5y5sxgId5V8cw-1
X-Mimecast-MFC-AGG-ID: _OfTzV15N5y5sxgId5V8cw_1768229435
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b844098869cso663205766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229434; x=1768834234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb5UIQxqvdSkHiFjYiKVV8nmw/xrhaJumJsBcf3A06Q=;
        b=GaCeT2vjAvVxt1ckfhbUROC/NtHxbPoxPN23MCYPFqnwyD2QZuNmlzrz/qJhWZfbNm
         rHdfv/56CaEV8ciithZOUjyotTj/Eh8CO2cPncqaiuLxCviCzeZHBDQVuYsWJ1XpWWke
         2jhzZan3Fnfb0ltvQeRzbR6CyouVlBePvFWDCySI1kPjsDq+Sb/B1qAXRO4vKv/GY/W7
         0iZEwTTnKqrukAXcbtYa/xSLzQfabpLfRNdQwLxAgWEtL7uvSrXs9cOjG0gDPP+vUmu9
         YG7FCVYfr+791TaDAAcjVZdjRT0QF0qAz8PHDekbaXx051xFGTcGANRUlWaZzxZpEOPM
         X5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229434; x=1768834234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb5UIQxqvdSkHiFjYiKVV8nmw/xrhaJumJsBcf3A06Q=;
        b=WJ1NqrIQgwmZpYTX/HhPSiMZdr1G6OhJdnk2AIE9stDcprcKZylJfE4xT9Z4cnBQBA
         udUBXnsWBnVWFKcKe+ZDCDfJsy14vRxhZ3furtJmLRLgqjuapFBKWJefGWtvHA3LGD4u
         IbL5lrvmkbvwC0gczHIYeN+y+i66/vaYq0AM+Uvj+RMwLGwzqr0/L2/G6+UI1/N9TlLR
         qUZgZMAA4qVPh7R/V9cdjmXg8OwF2ce7Q9enL11HZYD/uQWiM421io5KPeKS25gCBW1u
         EKCBcQFkNd+RVrTTyETQlYUlZqAwsnjA9NKwfI+r4U3ocUNlJLGN6Yr9LC61WoYg9g4d
         uO5g==
X-Forwarded-Encrypted: i=1; AJvYcCW947vwXW7uj3QltW86q+Mm5enNjTxdAK5iuLWRO3uUFWFQhxhRITBgQpt1eMjtzDvBTcqeffS6BcunuUWV@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJvPvDMmk6cTOMlUw1q/pHYJ0xTzSfgbsBxfsuQqZEn2E64Sw
	WEe2IeWPTJ/O1GnUlCv44lEY5DA7tJ4hvK/gU9XaIP8tjqrGU3Yoic8E+/h8BkmTadn/9robeih
	ALAkDUCGoduhRjcyMD4WQDuW40UV8rVmD3yzMJZf+/dq2I779lTsp+axzOouEPb6odg==
X-Gm-Gg: AY/fxX5qETDv//7oiZXZtaOL2OCpz8jHjsMkEb+OyU0BPE+2X32R1TgcjmZKVaLHJr/
	ten2zQkjHyY/G5Gg7hDCEz8W32ohD83yPUWvdABxrJZSg7ZBUtefuDR/lrueoyp3TuYKOYCJprl
	1r04mJloz3+mJqd6gso42G9Z/kImf6bbJErilcxAZcYPbapQlD8V4aH5pQm/4kH6DH7c9R43Wp+
	bI3LCI7OpaMenqphL3ulx69/MZzcZzJwwHJnwwR48IPfqI5I4Lu3j5tWGKvnOxtVV8m3O2PP7Vv
	1fX07tcVJ39aciGdiJBXhJgEjjUJBjcPDmF/sTNU4P6f1/gMEDUKNbLJRnZQUdMpZx/42rykXMQ
	=
X-Received: by 2002:a17:906:7954:b0:b87:2579:b6cf with SMTP id a640c23a62f3a-b872579ba1bmr222391266b.41.1768229434421;
        Mon, 12 Jan 2026 06:50:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8SWwB/AxOY3cZ8kcTpvTO2S7OPJFMdg+l1YvrGvLC8boRfcE7EDzI5F+ztUGlqqU65b2z6g==
X-Received: by 2002:a17:906:7954:b0:b87:2579:b6cf with SMTP id a640c23a62f3a-b872579ba1bmr222386566b.41.1768229433922;
        Mon, 12 Jan 2026 06:50:33 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd08b2sm774184166b.25.2026.01.12.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:50:33 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:50:32 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 6/22] xfs: add fs-verity ro-compat flag
Message-ID: <ra57w2n33ipx73jt5ah6avoa3piadlrhu6spwr6cf3ke7mbwit@a2b3rnvxtu3h>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

To mark inodes with fs-verity enabled the new XFS_DIFLAG2_VERITY flag
will be added in further patch. This requires ro-compat flag to let
older kernels know that fs with fs-verity can not be modified.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h | 1 +
 fs/xfs/libxfs/xfs_sb.c     | 2 ++
 fs/xfs/xfs_mount.h         | 2 ++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 779dac59b1..64c2acd1cf 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -374,6 +374,7 @@
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 94c272a2ae..744bd8480b 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -165,6 +165,8 @@
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index b871dfde37..8ef7fea8b3 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -381,6 +381,7 @@
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
 #define XFS_FEAT_METADIR	(1ULL << 28)	/* metadata directory tree */
 #define XFS_FEAT_ZONED		(1ULL << 29)	/* zoned RT device */
+#define XFS_FEAT_VERITY		(1ULL << 30)	/* fs-verity */
 
 /* Mount features */
 #define XFS_FEAT_NOLIFETIME	(1ULL << 47)	/* disable lifetime hints */
@@ -438,6 +439,7 @@
 __XFS_HAS_FEAT(metadir, METADIR)
 __XFS_HAS_FEAT(zoned, ZONED)
 __XFS_HAS_FEAT(nolifetime, NOLIFETIME)
+__XFS_HAS_FEAT(verity, VERITY)
 
 static inline bool xfs_has_rtgroups(const struct xfs_mount *mp)
 {

-- 
- Andrey


