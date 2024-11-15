Return-Path: <linux-fsdevel+bounces-34947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4889CF098
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD503B28B14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4431D5AC0;
	Fri, 15 Nov 2024 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OhbvR0D9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0151D5CC9
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684731; cv=none; b=dCulmvoR7oTVVV2j0P1Lwf8Ra9ggGsjDus4JsEEm5ijANaXQCfma0x/EJnPoCvwmHV7qYLXhae5CAMq9V83Qg1XQXHPOcwR5py7s9cUnwI9b9wEecTsBt6Gk4Odz1uhO4Pf9wlaPNQrF9ROvJgOMR/9ZNu5IIbAAs6/IruWXb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684731; c=relaxed/simple;
	bh=nFXm/L4ae8YekLwpIFurgFERbAtgq26xVgDJzO6g1yM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNS+JjwXbrKgVK4JZ7o/YNprqHd/Mn0pkKck1XNZ9EFUBGrVnePlf65FuGosAqiHLPugU92c6yXC9FRp8vGp4ONd8jJGVq6dq42HEImaS/BWU3HaJokPl1IzWID9A6HU8nFozaPJtTiS20SQwqmpEsHuC77GaUHfRnOpK89HeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OhbvR0D9; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5fa17a79dso1182708b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684729; x=1732289529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gek1GO8SPggpZ3MPgZMTTjA2lPqNZurY73wIWpdWbQQ=;
        b=OhbvR0D9Mpu/eExRINZ6D2YTBSWBQVN4I77aTxH725JB6v1OtP4PbqsiIJcMqulLzD
         PioDrpuYnRgl9mDwb6vPK3upyetHSr+oINmPkdr8QxCWDft025bwE4nU3PV0fKHGOF9Y
         5jOq9a9PK96V3MqsEnD3wir6nk5nC8fc/gqPbhtSXB7le1fxkIAjBC45RlNpGY+45tDU
         XMmI3hV/8/jQl38viODdYYbaJgzz/pYCsFFKRRupoBk31k8KIXEw609yC47pR2cZF7RP
         YsaPDpH3DUsL3DttGA4nSsC4i3av1T7si5+F8NTv0l4/R6xLtQeB6iMtfXeb3MKT/OGg
         brEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684729; x=1732289529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gek1GO8SPggpZ3MPgZMTTjA2lPqNZurY73wIWpdWbQQ=;
        b=CL1uO73wfkh5NNoVcKymWmQ7OTNeIdP0GsP5aWHsHfTmgaf7WPaV5Itpb7IwJiFJ1d
         VGVj3MaOaYX9y6wt6iBO+RAlN6Rsn4DsvZGWsb4bSisQs302jzWX2/wQ5FcMe6pf4Olz
         YorNa/Jzm1pczXdj7li4bwHnMakl05+LjEMycCtVuieSALZuHRU8gFruyM7VHjRAIMsg
         guaz0wQ85wVtOraKRaBYwzo7x5O7/L95xxVeSLOkAVUiBKp9o2fpZ4FApDQcnySoXK9V
         U99jw/TCKqVjehUX1mLtFK0zkaSBOIRGI3XD+v9+xUCWXsk/c74w1HNYtemWVnzrurKI
         WStg==
X-Forwarded-Encrypted: i=1; AJvYcCWkiTMNVRNUhnXBUPYmXMkYfkh4jBSISywa7++mrN/bRv41gTgplkHOvgUjrhhHgMSHs/fhpzR80mmZcmw2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VveXhSSZ+sNG2rRFG0FBqkc9LS1vxb9YN/WVHqePj9RyrByX
	k8cL93xzvJSf2IT3nUB8AeloruElclctKZd4bL08mk5cHqXe5vulUOwf6rclG1nW7cAU9GWoOUr
	C
X-Google-Smtp-Source: AGHT+IEUcKBXNGC+FquadsfHiR9BI4UoMJrmZkBZaObeXyKm9EGd5wreVNWR6wH/jakvp0EFNSF0lA==
X-Received: by 2002:a05:6902:1209:b0:e30:c977:a360 with SMTP id 3f1490d57ef6-e38261291fdmr3157574276.5.1731684719039;
        Fri, 15 Nov 2024 07:31:59 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e384121a605sm296041276.52.2024.11.15.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 19/19] fs: enable pre-content events on supported file systems
Date: Fri, 15 Nov 2024 10:30:32 -0500
Message-ID: <46960dcb2725fa0317895ed66a8409ba1c306a82.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all the code has been added for pre-content events, and the
various file systems that need the page fault hooks for fsnotify have
been updated, add SB_I_ALLOW_HSM to the supported file systems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c   | 2 +-
 fs/ext4/super.c    | 3 +++
 fs/xfs/xfs_super.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 97a85d180b61..fe6ecc3f1cab 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -961,7 +961,7 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
 
 	err = super_setup_bdi(sb);
 	if (err) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b3512d78b55c..13b9d67a4eec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5306,6 +5306,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	/* i_version is always enabled now */
 	sb->s_flags |= SB_I_VERSION;
 
+	/* HSM events are allowed by default. */
+	sb->s_iflags |= SB_I_ALLOW_HSM;
+
 	err = ext4_check_feature_compatibility(sb, es, silent);
 	if (err)
 		goto failed_mount;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fda75db739b1..2d1e9db8548d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1713,7 +1713,7 @@ xfs_fs_fill_super(
 		sb->s_time_max = XFS_LEGACY_TIME_MAX;
 	}
 	trace_xfs_inode_timestamp_range(mp, sb->s_time_min, sb->s_time_max);
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
 
 	set_posix_acl_flag(sb);
 
-- 
2.43.0


