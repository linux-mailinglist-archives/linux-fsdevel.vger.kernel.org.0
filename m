Return-Path: <linux-fsdevel+bounces-18283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ACD8B6903
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D06CB231D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CEC10A35;
	Tue, 30 Apr 2024 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePupY1Y5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A596511187;
	Tue, 30 Apr 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448276; cv=none; b=abXyMDyV5NzoafB1fZOF0tPHJ2pMgRGr1YG0njbsf7oc4cMA4lPL5JH322kwyj8yPlo/t+xjA1kGB4sZo0d7wxbae3/FrLsQcIGlmRkan+KE2dEddpV/dzVPLsRNYOkqjVe86iu41GsypVyqVI/AVnJN323bbyCYDR2b6lmDiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448276; c=relaxed/simple;
	bh=GHgtj/1UbymAOfvPd+HjIlt0SEHUsLn/bLHqYWdt7AE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uc6y4n7c7wtIlrkAv6WgvAFc46V4QgQBBupJEsQjBEvvVoXW5W42H4Oaa8XnRRRa0FC6v/s8COJscw5mJKzOeJia2+Iy3yPdTig7jqfdJZLD09l9VV+XEyVnIkXId3Phlk0sxeL8R+TcI9SFSs5m9fjKQX7iclPgxrX8NNLnNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePupY1Y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372E2C116B1;
	Tue, 30 Apr 2024 03:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448276;
	bh=GHgtj/1UbymAOfvPd+HjIlt0SEHUsLn/bLHqYWdt7AE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ePupY1Y5CtKAhTqFLRhI6IqYgzkhyPYTWCHrXd1nRzVvvhiMFHy+bdDvOGaK10Uod
	 ZgJoNk/8CPVF04sZpRZUfx/9kIKzqPaJe1vbcY5sFR2ygXI9R94QM01mgkoUm/l3LJ
	 Bx98lESCkUoUYaGsfybiDY35ic27bXkYPPTZbJ99cobKvOQB12x+HjhywPOpKQIkiS
	 Ro6aNejMEs9gE1b7yXcDKEjq+kMDGQ8LAzRMPDGm4pEeP/4Tzhh62EzHeloWuFPLL6
	 wgfzPb1xj1SZQDmdKqzf/NtmZk1XcH3+4/TaQxiKhSF5M9G+1zBpdy4cxCurJSHQqZ
	 FZkjowCx1s0eg==
Date: Mon, 29 Apr 2024 20:37:55 -0700
Subject: [PATCH 27/38] xfs_db: compute hashes of merkle tree blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683526.960383.14370813739332837103.stgit@frogsfrogsfrogs>
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

Compute the hash of verity merkle tree blocks.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/hash.c                |   21 +++++++++++++++++++--
 include/libxfs.h         |    1 +
 libxfs/libxfs_api_defs.h |    1 +
 man/man8/xfs_db.8        |    5 +++++
 4 files changed, 26 insertions(+), 2 deletions(-)


diff --git a/db/hash.c b/db/hash.c
index ab9c435b545f..e88d7d326bb5 100644
--- a/db/hash.c
+++ b/db/hash.c
@@ -36,7 +36,7 @@ hash_help(void)
 " 'hash' prints out the calculated hash value for a string using the\n"
 "directory/attribute code hash function.\n"
 "\n"
-" Usage:  \"hash [-d|-p parent_ino] <string>\"\n"
+" Usage:  \"hash [-d|-p parent_ino|-m merkle_blkno] <string>\"\n"
 "\n"
 ));
 
@@ -46,6 +46,7 @@ enum hash_what {
 	ATTR,
 	DIRECTORY,
 	PPTR,
+	MERKLE,
 };
 
 /* ARGSUSED */
@@ -54,16 +55,28 @@ hash_f(
 	int		argc,
 	char		**argv)
 {
+	struct xfs_merkle_key mk = { };
 	xfs_ino_t	p_ino = 0;
 	xfs_dahash_t	hashval;
+	unsigned long long mk_pos;
 	enum hash_what	what = ATTR;
 	int		c;
 
-	while ((c = getopt(argc, argv, "dp:")) != EOF) {
+	while ((c = getopt(argc, argv, "dm:p:")) != EOF) {
 		switch (c) {
 		case 'd':
 			what = DIRECTORY;
 			break;
+		case 'm':
+			errno = 0;
+			mk_pos = strtoull(optarg, NULL, 0);
+			if (errno) {
+				perror(optarg);
+				return 1;
+			}
+			mk.mk_pos = cpu_to_be64(mk_pos << XFS_VERITY_HASH_SHIFT);
+			what = MERKLE;
+			break;
 		case 'p':
 			errno = 0;
 			p_ino = strtoull(optarg, NULL, 0);
@@ -97,6 +110,10 @@ hash_f(
 		case ATTR:
 			hashval = libxfs_attr_hashname(xname.name, xname.len);
 			break;
+		case MERKLE:
+			hashval = libxfs_verity_hashname((void *)&mk, sizeof(mk));
+			break;
+
 		}
 		dbprintf("0x%x\n", hashval);
 	}
diff --git a/include/libxfs.h b/include/libxfs.h
index b4c6a2882aa3..0c3f0be85565 100644
--- a/include/libxfs.h
+++ b/include/libxfs.h
@@ -100,6 +100,7 @@ struct iomap;
 #include "xfs_rtgroup.h"
 #include "xfs_rtrmap_btree.h"
 #include "xfs_ag_resv.h"
+#include "xfs_verity.h"
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
diff --git a/libxfs/libxfs_api_defs.h b/libxfs/libxfs_api_defs.h
index 6ad728af2e0a..d125e2679348 100644
--- a/libxfs/libxfs_api_defs.h
+++ b/libxfs/libxfs_api_defs.h
@@ -394,6 +394,7 @@
 #define xfs_verify_fsbno		libxfs_verify_fsbno
 #define xfs_verify_ino			libxfs_verify_ino
 #define xfs_verify_rtbno		libxfs_verify_rtbno
+#define xfs_verity_hashname		libxfs_verity_hashname
 #define xfs_zero_extent			libxfs_zero_extent
 
 /* Please keep this list alphabetized. */
diff --git a/man/man8/xfs_db.8 b/man/man8/xfs_db.8
index 2c5aed2cf38c..deba4a6354aa 100644
--- a/man/man8/xfs_db.8
+++ b/man/man8/xfs_db.8
@@ -902,6 +902,11 @@ option is specified, the directory-specific hash function is used.
 This only makes a difference on filesystems with ascii case-insensitive
 lookups enabled.
 
+If the
+.B \-m
+option is specified, the merkle tree-specific hash function is used.
+The merkle tree block offset must be specified as an argument.
+
 If the
 .B \-p
 option is specified, the parent pointer-specific hash function is used.


