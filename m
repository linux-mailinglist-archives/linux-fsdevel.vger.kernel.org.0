Return-Path: <linux-fsdevel+bounces-11158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C05851A78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB70C1C221D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7923FB22;
	Mon, 12 Feb 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRGOlrf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3A3DB91
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757219; cv=none; b=kDKC98cFULCb9Q3mbYa9vdht2qm4HbaPmDaAilFLv5ysf25LAbOUKBR6ZlV2rGv7wxxYvSddKirSFbCfua4R4XesaWeDCy6EsI3VCFZ0LQ44AiTtPVpSHKz/W4D9hUrAgyvgpQRsdo/1NDIMR1PEDfuhs3yEY9z3kgYzZ6K884A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757219; c=relaxed/simple;
	bh=pVmlSRKI77dHrm8r3OHykDJVeVPxd3lIODzreg53UVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhu9VpGVvfkzAQcCuC+f1SvI1nybI1tXMgF+1kS93Genf18sfscUzxh9s5jQBbJ6soo3O43sYZIJ3VeEDavLYVGGdYp8tt0QGCg2XRsJQBEh3EmRLs1Z7ZuuTGkCIqHxnZvHkviky5+pvasSyV6Uq9zo3zjufXOPQsRmChJZJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRGOlrf/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fphYrB6sUkyfpqUcwfmVchz36DNELZ1YDE/WUi+9F/o=;
	b=ZRGOlrf/I679Ns/kvv1wwtq3L1Ibm/jN8q15BlcQvbTRXa8GdxL0wL8kweF0DLOc9x4kqK
	Y52DzI+VlNIH5jbezzLVZcSwvqhcfqAm78YHynWPvXmHt6DE+GThxq2qKkZQ6ePlTOeHZ4
	6L2opcJC7rJ0XtljrzKoPrLYyPkG8uo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-b0bowLilO7iEjk2vfcraqg-1; Mon, 12 Feb 2024 12:00:15 -0500
X-MC-Unique: b0bowLilO7iEjk2vfcraqg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-558b04cb660so2645382a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757215; x=1708362015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fphYrB6sUkyfpqUcwfmVchz36DNELZ1YDE/WUi+9F/o=;
        b=JZQ+IrDdy357oqYkJG0hQOVs0tQJYHVGAM5aN/e7HV3vdOYw1QI65jx201HpFK3sqv
         X/2bIAX9CvY8k2axG+HDJdjifPZB/CLKSmWtD/BoG8hHezHFiryhLSGVCIDCWXZK0ywU
         GyAeBogHWenwlksfztJno5C2ykMEIq9CqgNHmFvg8I9EM4NjtfhEL1m4attsDZespwib
         C5J4vKzzsJdqvzbLw5IvH0WoW1FZnzfQCXssS/ob5/zlHDJj34dm96NlDKYBChMiH6pr
         M/PzGmU5JKJ/Fer96FQSjkZcFxe6++6gXYWlMWHj9al83qf3rQThNzRLSVW3Ps7Kgoyl
         K98Q==
X-Gm-Message-State: AOJu0YzDYL7rZgRHSx/qsEhnxGW84RRlAoNU5BiaS9bbFIluSzJAYhXP
	rMhuUuSNqkGfWd3MBE80KG1ZxbG/jJc4PJGZhVV7qIg7Ib4fJweQX1NipKn4San8cDNiyxJjUjb
	yYVlxTFQuDpLy3T9NSnsogh+eGcn9EKlT83AOpp+hH/30pyg67Wb+wQl/AQJ35Q==
X-Received: by 2002:a05:6402:3182:b0:561:9653:339b with SMTP id di2-20020a056402318200b005619653339bmr3101056edb.6.1707757214747;
        Mon, 12 Feb 2024 09:00:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwXyTc1WDID6ZK3dghl3ZVDvmLmjzfMuJagmfzU9Q45OSVgWpX4Xn14kp782bIiAYg+O5YzQ==
X-Received: by 2002:a05:6402:3182:b0:561:9653:339b with SMTP id di2-20020a056402318200b005619653339bmr3101050edb.6.1707757214474;
        Mon, 12 Feb 2024 09:00:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWr/msPaoxmdV6je+9fjRcJyx0FORnDgMNTVsrKDBO77lk7qytfj7mACy32Wl5c1ILnbEJUGH70jkuuGtrgPTPFmH97wlyoLBwoUYry2j/rOtyJJkiPAHDWtAdQHX3SGTTZjk4fe0n+nH0SNee1OfRhzqnoBPcVAKkUUtlvn1LThhagniTPFQUxltPDo73CsbJsqbvP59ndRbiCO3y/FNlMUtbBk5L2Blyq
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:13 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 17/25] xfs: add fs-verity ro-compat flag
Date: Mon, 12 Feb 2024 17:58:14 +0100
Message-Id: <20240212165821.1901300-18-aalbersh@redhat.com>
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

To mark inodes with fs-verity enabled the new XFS_DIFLAG2_VERITY flag
will be added in further patch. This requires ro-compat flag to let
older kernels know that fs with fs-verity can not be modified.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h | 1 +
 fs/xfs/libxfs/xfs_sb.c     | 2 ++
 fs/xfs/xfs_mount.h         | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 382ab1e71c0b..e36718c93539 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index f08108c9a297..dcb6b15714b1 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -163,6 +163,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index f64bf75f50d6..5de007989b71 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -290,6 +290,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_VERITY		(1ULL << 27)	/* fs-verity */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -353,6 +354,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(verity, VERITY)
 
 /*
  * Mount features
-- 
2.42.0


