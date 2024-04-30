Return-Path: <linux-fsdevel+bounces-18275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E18B68F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB96B21A97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB551118C;
	Tue, 30 Apr 2024 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDMhU8MA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3810A1F;
	Tue, 30 Apr 2024 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448151; cv=none; b=TZPvj2UYIDbyGXn/HQCj1NjMyHWgDGXQDwppVfOenPDN/0dfvR+CITiCeg+YsoUzypd4eu0enJeyZomr/Sqp4zEFaGLLVkgkohj3Ul/xb3XoAgKhoXK5qBg6+NOabJGrhBubUtEepcRe9ry6g1ZauvQXkUybp0gpgtiZ4+iHFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448151; c=relaxed/simple;
	bh=KjAnYmfQQCRO0FHnz123YxO2xEYbrbD9UzXzSpOxFjU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxfD7Ko3XCEx3qVlTz0eJzGM78v/cSkqtnXzQVwl7eDqgQUB6Qu3SNGU/lWQiq7eX3mGWHg/OieKDoUCivogdfMigTw9fj1j5ltXQRvXfaYHuJzz2rZ9b6P2IRIv3EHMKIkvtRdvzMbF5ZwTwMmZlnYZE/k6ppDnMUjvuuM+i08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDMhU8MA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B082C116B1;
	Tue, 30 Apr 2024 03:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448151;
	bh=KjAnYmfQQCRO0FHnz123YxO2xEYbrbD9UzXzSpOxFjU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GDMhU8MAQP5cQ3QQrjz+yDD13h3+scZHhCBRI4V7z0xaHg0/k2xkAKFz+PpnB9/f0
	 GlCJC05PevgU3bEYOaEnk5W9bQjxJAxJHOcVntXAtsXyZgiMhl+7eUj+MYP+bPHBSW
	 e91vowbCeF42evk7A3h3OV8yxhfDSCQZf2EijK6IVejlzgL+0gVkzfhKzMJB9r+fIe
	 A7rKoKX0xYmdMEHZZD4bctzqLFKhkxFQORrNsVxVAZQGUb7mTf0n8kPYTEeHFyvBlP
	 D+5WeWFPQbcCFYIE1RKVQBEUC7I2kAX0C6pVxIMqhKDxX8wC7hnb65xaD7wQzfxlff
	 1QCn+1ry0b61Q==
Date: Mon, 29 Apr 2024 20:35:50 -0700
Subject: [PATCH 19/38] xfs_db: make attr_set/remove/modify be able to handle
 fs-verity attrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683404.960383.1311017460455777404.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 db/attrset.c             |   28 +++++++++++++++++++++-------
 libxfs/libxfs_api_defs.h |    1 +
 2 files changed, 22 insertions(+), 7 deletions(-)


diff --git a/db/attrset.c b/db/attrset.c
index 915c20f8beb8..477ea7cb29c1 100644
--- a/db/attrset.c
+++ b/db/attrset.c
@@ -26,15 +26,15 @@ static void		attrset_help(void);
 
 static const cmdinfo_t	attr_set_cmd =
 	{ "attr_set", "aset", attr_set_f, 1, -1, 0,
-	  N_("[-r|-s|-u|-p] [-n] [-R|-C] [-v n] name"),
+	  N_("[-r|-s|-u|-p|-f] [-n] [-R|-C] [-v n] name"),
 	  N_("set the named attribute on the current inode"), attrset_help };
 static const cmdinfo_t	attr_remove_cmd =
 	{ "attr_remove", "aremove", attr_remove_f, 1, -1, 0,
-	  N_("[-r|-s|-u|-p] [-n] name"),
+	  N_("[-r|-s|-u|-p|-f] [-n] name"),
 	  N_("remove the named attribute from the current inode"), attrset_help };
 static const cmdinfo_t	attr_modify_cmd =
 	{ "attr_modify", "amodify", attr_modify_f, 1, -1, 0,
-	  N_("[-r|-s|-u] [-o n] [-v n] [-m n] name value"),
+	  N_("[-r|-s|-u|-f] [-o n] [-v n] [-m n] name value"),
 	  N_("modify value of the named attribute of the current inode"),
 		attrset_help };
 
@@ -53,6 +53,7 @@ attrset_help(void)
 "  -u -- 'user'		(default)\n"
 "  -s -- 'secure'\n"
 "  -p -- 'parent'\n"
+"  -f -- 'fs-verity'\n"
 "\n"
 " For attr_set, these options further define the type of set operation:\n"
 "  -C -- 'create'    - create attribute, fail if it already exists\n"
@@ -116,7 +117,8 @@ get_buf_from_file(
 
 #define LIBXFS_ATTR_NS		(LIBXFS_ATTR_SECURE | \
 				 LIBXFS_ATTR_ROOT | \
-				 LIBXFS_ATTR_PARENT)
+				 LIBXFS_ATTR_PARENT | \
+				 LIBXFS_ATTR_VERITY)
 
 static int
 attr_set_f(
@@ -144,7 +146,7 @@ attr_set_f(
 		return 0;
 	}
 
-	while ((c = getopt(argc, argv, "ruspCRnN:v:V:")) != EOF) {
+	while ((c = getopt(argc, argv, "fruspCRnN:v:V:")) != EOF) {
 		switch (c) {
 		/* namespaces */
 		case 'r':
@@ -162,6 +164,10 @@ attr_set_f(
 			args.attr_filter &= ~LIBXFS_ATTR_NS;
 			args.attr_filter |= XFS_ATTR_PARENT;
 			break;
+		case 'f':
+			args.attr_filter &= ~LIBXFS_ATTR_NS;
+			args.attr_filter |= LIBXFS_ATTR_VERITY;
+			break;
 
 		/* modifiers */
 		case 'C':
@@ -317,7 +323,7 @@ attr_remove_f(
 		return 0;
 	}
 
-	while ((c = getopt(argc, argv, "ruspnN:")) != EOF) {
+	while ((c = getopt(argc, argv, "fruspnN:")) != EOF) {
 		switch (c) {
 		/* namespaces */
 		case 'r':
@@ -335,6 +341,10 @@ attr_remove_f(
 			args.attr_filter &= ~LIBXFS_ATTR_NS;
 			args.attr_filter |= XFS_ATTR_PARENT;
 			break;
+		case 'f':
+			args.attr_filter &= ~LIBXFS_ATTR_NS;
+			args.attr_filter |= LIBXFS_ATTR_VERITY;
+			break;
 
 		case 'N':
 			name_from_file = optarg;
@@ -445,7 +455,7 @@ attr_modify_f(
 		return 0;
 	}
 
-	while ((c = getopt(argc, argv, "ruspnv:o:m:")) != EOF) {
+	while ((c = getopt(argc, argv, "fruspnv:o:m:")) != EOF) {
 		switch (c) {
 		/* namespaces */
 		case 'r':
@@ -463,6 +473,10 @@ attr_modify_f(
 			args.attr_filter &= ~LIBXFS_ATTR_NS;
 			args.attr_filter |= XFS_ATTR_PARENT;
 			break;
+		case 'f':
+			args.attr_filter &= ~LIBXFS_ATTR_NS;
+			args.attr_filter |= LIBXFS_ATTR_VERITY;
+			break;
 
 		case 'n':
 			/*
diff --git a/libxfs/libxfs_api_defs.h b/libxfs/libxfs_api_defs.h
index 1b6efac9290d..6ad728af2e0a 100644
--- a/libxfs/libxfs_api_defs.h
+++ b/libxfs/libxfs_api_defs.h
@@ -16,6 +16,7 @@
 #define LIBXFS_ATTR_ROOT		XFS_ATTR_ROOT
 #define LIBXFS_ATTR_SECURE		XFS_ATTR_SECURE
 #define LIBXFS_ATTR_PARENT		XFS_ATTR_PARENT
+#define LIBXFS_ATTR_VERITY		XFS_ATTR_VERITY
 
 #define xfs_agfl_size			libxfs_agfl_size
 #define xfs_agfl_walk			libxfs_agfl_walk


