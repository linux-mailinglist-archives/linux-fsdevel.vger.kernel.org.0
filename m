Return-Path: <linux-fsdevel+bounces-18287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FC8B690D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F2F1F2166C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6710A1F;
	Tue, 30 Apr 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEtC4pPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC111187;
	Tue, 30 Apr 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448339; cv=none; b=nuCTvf+Z6zvn+5G+8ruJHN1gcj5Mvw++2y5g0TUsni8fiWup5Wnl8enJULB/+rap/O1swm31bKMJ/GVpV/QaPkN2eOwktLtgKTCRbW8L6RwzGokrgOSmxMba7yjxIK1CZfjYbNtwbBmT85had02FYETPM4r6z7X1mNbwmVNuqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448339; c=relaxed/simple;
	bh=v92rfR54wuzZpBFS9rrFKms+Qe2OPaKb2Wh/i6ldAww=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/QqIuTs75p+UFSdnUEotVfHzI5s3mM7zsLX3Rl7B0Q5NmqVeGADB4AZFWwp1KUrH1w0NHFPrx5cwb5eQK/GWHvV0fInp+vNCqMTo3fJaPCoQ/54K+7+fBxE0ppHv2HlUGq1RqOk+qmx3nzEVly/7+Tj+mBBs6mnt28IJUEHUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEtC4pPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CF8C116B1;
	Tue, 30 Apr 2024 03:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448338;
	bh=v92rfR54wuzZpBFS9rrFKms+Qe2OPaKb2Wh/i6ldAww=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cEtC4pPge+WmzeAWCobfLUrLC7zYvcH1TLgOjJtYUMxlpRatN1lmw01YrOBaWkbMV
	 +ZKswEAacbbuvWIfmPnvoBWJtiYKsKWUE5XUA10BSN2lHhhpBJNdRQMZmzCaVCtjRH
	 +hUQJpCvJkWnQjEmslbv+/8YCdFbftElSfQVXjy4LDT3oqlXfrN7rCjVJN8B7M5x1A
	 Ho0QexhtEwBSt7nfISTzZoP6K8kT0JiNPGdu4uSqUsQoFcmtv7RnpG74skdpHTpdQ4
	 BNSd3xTPxIS+E98hfKp/kLqH9mz4qEMQXWI+d9F26EoQculeYhfM5Ru0oeydlKMKsG
	 YRUnRHZ7BByYw==
Date: Mon, 29 Apr 2024 20:38:58 -0700
Subject: [PATCH 31/38] xfs_repair: allow upgrading filesystems with verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683584.960383.11515585204799823025.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow upgrading of filesystems to support verity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 man/man8/xfs_admin.8 |    6 ++++++
 repair/globals.c     |    1 +
 repair/globals.h     |    1 +
 repair/phase2.c      |   24 ++++++++++++++++++++++++
 repair/xfs_repair.c  |   11 +++++++++++
 5 files changed, 43 insertions(+)


diff --git a/man/man8/xfs_admin.8 b/man/man8/xfs_admin.8
index 83f8fe88ff18..cd18c18fd1b5 100644
--- a/man/man8/xfs_admin.8
+++ b/man/man8/xfs_admin.8
@@ -209,6 +209,12 @@ The filesystem cannot be downgraded after this feature is enabled.
 This upgrade is not possible if a realtime volume has already been added to the
 filesystem.
 This feature is not upstream yet.
+.TP 0.4i
+.B verity
+Enable fs-verity on the filesystem, which allows for sealing of regular file
+data with signed hashes.
+The filesystem cannot be downgraded after this feature is enabled.
+This feature is not upstream yet.
 .RE
 .TP
 .BI \-U " uuid"
diff --git a/repair/globals.c b/repair/globals.c
index a50e4959cbc1..410c3cd39d05 100644
--- a/repair/globals.c
+++ b/repair/globals.c
@@ -59,6 +59,7 @@ bool	add_rmapbt;		/* add reverse mapping btrees */
 bool	add_parent;		/* add parent pointers */
 bool	add_metadir;		/* add metadata directory tree */
 bool	add_rtgroups;		/* add realtime allocation groups */
+bool	add_verity;		/* add fs-verity support */
 
 /* misc status variables */
 
diff --git a/repair/globals.h b/repair/globals.h
index 4f9683bda949..994ea2b4e946 100644
--- a/repair/globals.h
+++ b/repair/globals.h
@@ -100,6 +100,7 @@ extern bool	add_rmapbt;		/* add reverse mapping btrees */
 extern bool	add_parent;		/* add parent pointers */
 extern bool	add_metadir;		/* add metadata directory tree */
 extern bool	add_rtgroups;		/* add realtime allocation groups */
+extern bool	add_verity;		/* add fs-verity support */
 
 /* misc status variables */
 
diff --git a/repair/phase2.c b/repair/phase2.c
index d1b2824caace..f8b0fefe3bc0 100644
--- a/repair/phase2.c
+++ b/repair/phase2.c
@@ -429,6 +429,28 @@ set_rtgroups(
 	return true;
 }
 
+static bool
+set_verity(
+	struct xfs_mount	*mp,
+	struct xfs_sb		*new_sb)
+{
+	if (xfs_has_verity(mp)) {
+		printf(_("Filesystem already supports verity.\n"));
+		exit(0);
+	}
+
+	if (!xfs_has_crc(mp)) {
+		printf(
+	_("Verity feature only supported on V5 filesystems.\n"));
+		exit(0);
+	}
+
+	printf(_("Adding verity to filesystem.\n"));
+	new_sb->sb_features_ro_compat |= XFS_SB_FEAT_RO_COMPAT_VERITY;
+	new_sb->sb_features_incompat |= XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR;
+	return true;
+}
+
 struct check_state {
 	struct xfs_sb		sb;
 	uint64_t		features;
@@ -868,6 +890,8 @@ upgrade_filesystem(
 		dirty |= set_metadir(mp, &new_sb);
 	if (add_rtgroups)
 		dirty |= set_rtgroups(mp, &new_sb);
+	if (add_verity)
+		dirty |= set_verity(mp, &new_sb);
 	if (!dirty)
 		return;
 
diff --git a/repair/xfs_repair.c b/repair/xfs_repair.c
index faaea4d45224..ab6f97157f1b 100644
--- a/repair/xfs_repair.c
+++ b/repair/xfs_repair.c
@@ -77,6 +77,7 @@ enum c_opt_nums {
 	CONVERT_PARENT,
 	CONVERT_METADIR,
 	CONVERT_RTGROUPS,
+	CONVERT_VERITY,
 	C_MAX_OPTS,
 };
 
@@ -92,6 +93,7 @@ static char *c_opts[] = {
 	[CONVERT_PARENT]	= "parent",
 	[CONVERT_METADIR]	= "metadir",
 	[CONVERT_RTGROUPS]	= "rtgroups",
+	[CONVERT_VERITY]	= "verity",
 	[C_MAX_OPTS]		= NULL,
 };
 
@@ -438,6 +440,15 @@ process_args(int argc, char **argv)
 		_("-c rtgroups only supports upgrades\n"));
 					add_rtgroups = true;
 					break;
+				case CONVERT_VERITY:
+					if (!val)
+						do_abort(
+		_("-c verity requires a parameter\n"));
+					if (strtol(val, NULL, 0) != 1)
+						do_abort(
+		_("-c verity only supports upgrades\n"));
+					add_verity = true;
+					break;
 				default:
 					unknown('c', val);
 					break;


