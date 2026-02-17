Return-Path: <linux-fsdevel+bounces-77470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPDXAUX4lGk8JgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F32151DD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF015306BE26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D302F5A06;
	Tue, 17 Feb 2026 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkBBdxfa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F529E114;
	Tue, 17 Feb 2026 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370503; cv=none; b=Efocnv3JIeuc/cLJDiRJtyWLhMEUd2Waf/u1kOPVvUuSIEriB5R0MqsXpMLhpahILIPasRJm12b4cDz05bPnQigRGCxVHXY5379b52iQ8+s5yXnSaKyLevNiO7l6vgDwzAu8p1PLk35atBrjq2etR9WglIw4SSrLGItxGdlvwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370503; c=relaxed/simple;
	bh=oHvPYoitnKtGSiL95UFeks/M80dV23uzLYcY9LernTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnU8PsGsq0dopQsA4KrnyWTVe1ey7oBAA7FyVLPUhQBBGQkqnPZhSwekXXIZf2ZwZ1GOB/vKtb3QpuHDEBtLYbgFCMiE/8tEyeoHintnWFY0E0ekWPOrDxPxF+GB1sU2ZOTDToC//Z62jEVC+4dtcEcvq2URdWkvF1Cd4WAWbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkBBdxfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CD0C4CEF7;
	Tue, 17 Feb 2026 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370503;
	bh=oHvPYoitnKtGSiL95UFeks/M80dV23uzLYcY9LernTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MkBBdxfah6BbxXSUegslOS7pK4nDePz8FzClAMo496DBS/UIOqIrSdMZjxMhyQEu2
	 AUngl+aBQS9VBk3YsExLAUjMklX74uJv6PqcBxifw/w2aHHN9Hzs6EnE9h5aZdYxlY
	 uGlZh8cvAGQzLKvgQqpPi6t8fMqH9V4BZwav5xgJR6n139AQkNGCC3IdzTECVQNt2W
	 OM0w2R4Ejgsiszz7PAe2JB/fh55l8LQ+yBP9Q4lQCrbpnye1U84xYe4JsqbeCJv4Yi
	 bmGaHNTCblEp8VM3BKEnCIiuwAmtVm+byIviMCr8lFe5aw7RPPPfkU/hNiij3waH+2
	 CMmzR4f71q8xw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 33/35] xfs: introduce health state for corrupted fsverity metadata
Date: Wed, 18 Feb 2026 00:19:33 +0100
Message-ID: <20260217231937.1183679-34-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260217231937.1183679-1-aalbersh@kernel.org>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77470-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3F32151DD0
X-Rspamd-Action: no action

Report corrupted fsverity descriptor through health system.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h     |  1 +
 fs/xfs/libxfs/xfs_health.h |  4 +++-
 fs/xfs/xfs_fsverity.c      | 13 ++++++++++---
 fs/xfs/xfs_health.c        |  1 +
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 36a87276f0b7..d8be7fe93382 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -423,6 +423,7 @@ struct xfs_bulkstat {
 #define XFS_BS_SICK_PARENT	(1 << 7)  /* parent pointers */
 #define XFS_BS_SICK_DIRTREE	(1 << 8)  /* directory tree structure */
 #define XFS_BS_SICK_DATA	(1 << 9)  /* file data */
+#define XFS_BS_SICK_FSVERITY	(1 << 10) /* fsverity metadata */
 
 /*
  * Project quota id helpers (previously projid was 16bit only
diff --git a/fs/xfs/libxfs/xfs_health.h b/fs/xfs/libxfs/xfs_health.h
index fa91916ad072..c534aacf3199 100644
--- a/fs/xfs/libxfs/xfs_health.h
+++ b/fs/xfs/libxfs/xfs_health.h
@@ -105,6 +105,7 @@ struct xfs_rtgroup;
 #define XFS_SICK_INO_FORGET	(1 << 12)
 #define XFS_SICK_INO_DIRTREE	(1 << 13)  /* directory tree structure */
 #define XFS_SICK_INO_DATA	(1 << 14)  /* file data */
+#define XFS_SICK_INO_FSVERITY	(1 << 15)  /* fsverity metadata */
 
 /* Primary evidence of health problems in a given group. */
 #define XFS_SICK_FS_PRIMARY	(XFS_SICK_FS_COUNTERS | \
@@ -142,7 +143,8 @@ struct xfs_rtgroup;
 				 XFS_SICK_INO_SYMLINK | \
 				 XFS_SICK_INO_PARENT | \
 				 XFS_SICK_INO_DIRTREE | \
-				 XFS_SICK_INO_DATA)
+				 XFS_SICK_INO_DATA | \
+				 XFS_SICK_INO_FSVERITY)
 
 #define XFS_SICK_INO_ZAPPED	(XFS_SICK_INO_BMBTD_ZAPPED | \
 				 XFS_SICK_INO_BMBTA_ZAPPED | \
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 5a2874236c3c..d89512d59328 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -197,16 +197,23 @@ xfs_fsverity_get_descriptor(
 		return error;
 
 	desc_size = be32_to_cpu(d_desc_size);
-	if (XFS_IS_CORRUPT(mp, desc_size > FS_VERITY_MAX_DESCRIPTOR_SIZE))
+	if (XFS_IS_CORRUPT(mp, desc_size > FS_VERITY_MAX_DESCRIPTOR_SIZE)) {
+		xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_FSVERITY);
 		return -ERANGE;
-	if (XFS_IS_CORRUPT(mp, desc_size > desc_size_pos))
+	}
+
+	if (XFS_IS_CORRUPT(mp, desc_size > desc_size_pos)) {
+		xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_FSVERITY);
 		return -ERANGE;
+	}
 
 	if (!buf_size)
 		return desc_size;
 
-	if (XFS_IS_CORRUPT(mp, desc_size > buf_size))
+	if (XFS_IS_CORRUPT(mp, desc_size > buf_size)) {
+		xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_FSVERITY);
 		return -ERANGE;
+	}
 
 	desc_pos = round_down(desc_size_pos - desc_size, blocksize);
 	error = xfs_fsverity_read(inode, buf, desc_size, desc_pos);
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index b851651c02b2..e52ee02f7d7c 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -488,6 +488,7 @@ static const struct ioctl_sick_map ino_map[] = {
 	{ XFS_SICK_INO_SYMLINK_ZAPPED,	XFS_BS_SICK_SYMLINK },
 	{ XFS_SICK_INO_DIRTREE,	XFS_BS_SICK_DIRTREE },
 	{ XFS_SICK_INO_DATA,	XFS_BS_SICK_DATA },
+	{ XFS_SICK_INO_FSVERITY,	XFS_BS_SICK_FSVERITY },
 };
 
 /* Fill out bulkstat health info. */
-- 
2.51.2


