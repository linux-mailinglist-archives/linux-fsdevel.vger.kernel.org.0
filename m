Return-Path: <linux-fsdevel+bounces-77451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OqWEHf4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:23:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E3151E33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C2E53086053
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525752DB7BA;
	Tue, 17 Feb 2026 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKbnba16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD02BD030;
	Tue, 17 Feb 2026 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370463; cv=none; b=fh9ycMbVyaSFPk5nK8V779HiDqZG04PEw24WP8gfSpn2kmdItUEvvns0FvRguUAXJo1pZTKCKisXHyQebm9W8SUIfwEds6JURBUSMR4jZH5dk2iGzSe13n9nSt2CWGZ+55zIUZrD+ncwEnAG415Hioved3WRJTTW212sUuzU6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370463; c=relaxed/simple;
	bh=SZnPTJRgaA0p6Gh+6RGbuYmFTgEbOO9bayU6vRahrXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShswOMgbDcZ4KFJGwLbW1zcDCOXhYcA0aAuHLrrcyuJmSzRR4RG1s5wO/P80fOZsoU7LvRg7v1Ni6OhdyKWAAnmxoiy5zb1FQq0SiQ33WzoHfom5syCBTO6/vU48Yncm+6itLS/FGeLPGXtr8siIgSPkxFcT1BxZp0smpdasd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKbnba16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F17C4CEF7;
	Tue, 17 Feb 2026 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370463;
	bh=SZnPTJRgaA0p6Gh+6RGbuYmFTgEbOO9bayU6vRahrXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKbnba16qLPo0wENuoiP7+RdqdLSDMtkIAb4Qds7Y/DW1teEDcgy+F53X1B9CMbe7
	 e3ij2GR7+l/3rFUU2oHj6c+Xef5b6MQNAbnB4WTlml/MB1CUSqJaI9r1XKhkXIeTOG
	 ENa0mNFosHkRpJ/NNoYYRGIdMPloeyapYw2JsgJwA+5ZQUoMEk90JCKQ9RpouvFxYB
	 Vx0YAVFGuKRN+tDqubO7d5k9EemaTo8EtwjgxupqMUXpwNBP9A6E+3cIrOWVIq9qfp
	 OO8UzIZOC5kndJZJF+iPE7vJn0li5kGOyhQIRFtaSe9NadQAxdX5OH8jXWeIh5hrpu
	 RGTdd4w3dS7lQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 14/35] xfs: add fs-verity ro-compat flag
Date: Wed, 18 Feb 2026 00:19:14 +0100
Message-ID: <20260217231937.1183679-15-aalbersh@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77451-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B8E3151E33
X-Rspamd-Action: no action

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
 3 files changed, 5 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 779dac59b1f3..64c2acd1cfca 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -374,6 +374,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 94c272a2ae26..744bd8480ba6 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -165,6 +165,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index b871dfde372b..8ef7fea8b325 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -381,6 +381,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
 #define XFS_FEAT_METADIR	(1ULL << 28)	/* metadata directory tree */
 #define XFS_FEAT_ZONED		(1ULL << 29)	/* zoned RT device */
+#define XFS_FEAT_VERITY		(1ULL << 30)	/* fs-verity */
 
 /* Mount features */
 #define XFS_FEAT_NOLIFETIME	(1ULL << 47)	/* disable lifetime hints */
@@ -438,6 +439,7 @@ __XFS_HAS_FEAT(exchange_range, EXCHANGE_RANGE)
 __XFS_HAS_FEAT(metadir, METADIR)
 __XFS_HAS_FEAT(zoned, ZONED)
 __XFS_HAS_FEAT(nolifetime, NOLIFETIME)
+__XFS_HAS_FEAT(verity, VERITY)
 
 static inline bool xfs_has_rtgroups(const struct xfs_mount *mp)
 {
-- 
2.51.2


