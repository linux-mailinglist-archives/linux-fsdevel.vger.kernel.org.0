Return-Path: <linux-fsdevel+bounces-14632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F86A87DEDB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17401C21057
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4421B949;
	Sun, 17 Mar 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtZPEYb0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382451CD11;
	Sun, 17 Mar 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693465; cv=none; b=nZlUHN/mWvWbychDL7v04E2IZE/rUHsih+ZGeF4HL7fxBpmA9p3b22uONWdxZeqcRW04zrdZ0YWo1Qj98Mm0c2IWOigYsGdmICkvSMGNjTtbqcPfpc8om5SX4MPJiKr0wwKkBBIUPUz3f2lKWxgE1g+GVtdebXgo4EkbMCw7t+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693465; c=relaxed/simple;
	bh=7KR5QG05a5iw5iF04hooLILvIXBX0ycR2j/5TnBxR/c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZK9TBadZ44y1TCMn+CTfoV53Q4KZac0fvcuop2Q/CQAzonsOFheb7TAtgNKtyFwoOkCrb8kXAKKuFLnHnXk+LHJX4pXW+Cy68t41+KtbXu3KPgElwyEmEJmrAKIpfe8ktSNSa7/7xZaC/K0nB/W5co/9wVFhSojRhOdIotUCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtZPEYb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C119DC433F1;
	Sun, 17 Mar 2024 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693464;
	bh=7KR5QG05a5iw5iF04hooLILvIXBX0ycR2j/5TnBxR/c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RtZPEYb08qZZtIFaF0HzvLjtRogDYfXRwj/HjAk22yAZHnk2f10uOh7oYF0Vdpavs
	 8OHG2YKZCJ/t5W1QVpQJNSpO7EMcxN+srtoGPme1nDlewucitGYn68mxnv9m3O2Nu7
	 fFHvGD1CPMMfELO5RbjaxDxjD1cE8kINCs2OCHoLb6DPyV9RhdnQ2nTzpS2hnQJ4x+
	 wmcYuzFTNBhAcdVl7g8Hhi6mZVhKIInDcdiuy+ngIlmaYT3vvF/DtlRsVgV08/EkE6
	 mMB1S/37kGezvy5m5I2a4dPMA4F1NIVGiUISld/k5obbjHogZKtqmQBsMKdFAuo6VL
	 FaYauhfT87KLQ==
Date: Sun, 17 Mar 2024 09:37:44 -0700
Subject: [PATCH 15/20] xfs_db: make attr_set/remove/modify be able to handle
 fs-verity attrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247882.2685643.11040631435359813980.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 db/attrset.c             |   28 ++++++++++++++++++++++------
 libxfs/libxfs_api_defs.h |    1 +
 2 files changed, 23 insertions(+), 6 deletions(-)


diff --git a/db/attrset.c b/db/attrset.c
index 7249294a..f64f0cd9 100644
--- a/db/attrset.c
+++ b/db/attrset.c
@@ -26,15 +26,15 @@ static void		attrset_help(void);
 
 static const cmdinfo_t	attr_set_cmd =
 	{ "attr_set", "aset", attr_set_f, 1, -1, 0,
-	  N_("[-r|-s|-u] [-n] [-R|-C] [-v n] name"),
+	  N_("[-r|-s|-u|-f] [-n] [-R|-C] [-v n] name"),
 	  N_("set the named attribute on the current inode"), attrset_help };
 static const cmdinfo_t	attr_remove_cmd =
 	{ "attr_remove", "aremove", attr_remove_f, 1, -1, 0,
-	  N_("[-r|-s|-u] [-n] name"),
+	  N_("[-r|-s|-u|-f] [-n] name"),
 	  N_("remove the named attribute from the current inode"), attrset_help };
 static const cmdinfo_t	attr_modify_cmd =
 	{ "attr_modify", "amodify", attr_modify_f, 1, -1, 0,
-	  N_("[-r|-s|-u] [-o n] [-v n] [-m n] name value"),
+	  N_("[-r|-s|-u|-f] [-o n] [-v n] [-m n] name value"),
 	  N_("modify value of the named attribute of the current inode"),
 		attrset_help };
 
@@ -52,6 +52,7 @@ attrset_help(void)
 "  -r -- 'root'\n"
 "  -u -- 'user'		(default)\n"
 "  -s -- 'secure'\n"
+"  -f -- 'fs-verity'\n"
 "\n"
 " For attr_set, these options further define the type of set operation:\n"
 "  -C -- 'create'    - create attribute, fail if it already exists\n"
@@ -92,7 +93,7 @@ attr_set_f(
 		return 0;
 	}
 
-	while ((c = getopt(argc, argv, "rusCRnv:")) != EOF) {
+	while ((c = getopt(argc, argv, "rusfCRnv:")) != EOF) {
 		switch (c) {
 		/* namespaces */
 		case 'r':
@@ -107,6 +108,11 @@ attr_set_f(
 			args.attr_filter |= LIBXFS_ATTR_SECURE;
 			args.attr_filter &= ~LIBXFS_ATTR_ROOT;
 			break;
+		case 'f':
+			args.attr_filter |= LIBXFS_ATTR_VERITY;
+			args.attr_filter &= ~(LIBXFS_ATTR_ROOT |
+					      LIBXFS_ATTR_SECURE);
+			break;
 
 		/* modifiers */
 		case 'C':
@@ -208,7 +214,7 @@ attr_remove_f(
 		return 0;
 	}
 
-	while ((c = getopt(argc, argv, "rusn")) != EOF) {
+	while ((c = getopt(argc, argv, "rusfn")) != EOF) {
 		switch (c) {
 		/* namespaces */
 		case 'r':
@@ -223,6 +229,11 @@ attr_remove_f(
 			args.attr_filter |= LIBXFS_ATTR_SECURE;
 			args.attr_filter &= ~LIBXFS_ATTR_ROOT;
 			break;
+		case 'f':
+			args.attr_filter |= LIBXFS_ATTR_VERITY;
+			args.attr_filter &= ~(LIBXFS_ATTR_ROOT |
+					      LIBXFS_ATTR_SECURE);
+			break;
 
 		case 'n':
 			/*
@@ -301,7 +312,7 @@ attr_modify_f(
 		return 0;
 	}
 
-	while ((c = getopt(argc, argv, "rusnv:o:m:")) != EOF) {
+	while ((c = getopt(argc, argv, "rusfnv:o:m:")) != EOF) {
 		switch (c) {
 		/* namespaces */
 		case 'r':
@@ -316,6 +327,11 @@ attr_modify_f(
 			args.attr_filter |= LIBXFS_ATTR_SECURE;
 			args.attr_filter &= ~LIBXFS_ATTR_ROOT;
 			break;
+		case 'f':
+			args.attr_filter |= LIBXFS_ATTR_VERITY;
+			args.attr_filter &= ~(LIBXFS_ATTR_ROOT |
+					      LIBXFS_ATTR_SECURE);
+			break;
 
 		case 'n':
 			/*
diff --git a/libxfs/libxfs_api_defs.h b/libxfs/libxfs_api_defs.h
index ccc92a83..04a5dad5 100644
--- a/libxfs/libxfs_api_defs.h
+++ b/libxfs/libxfs_api_defs.h
@@ -15,6 +15,7 @@
  */
 #define LIBXFS_ATTR_ROOT		XFS_ATTR_ROOT
 #define LIBXFS_ATTR_SECURE		XFS_ATTR_SECURE
+#define LIBXFS_ATTR_VERITY		XFS_ATTR_VERITY
 
 #define xfs_agfl_size			libxfs_agfl_size
 #define xfs_agfl_walk			libxfs_agfl_walk


