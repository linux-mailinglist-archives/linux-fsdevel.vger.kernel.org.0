Return-Path: <linux-fsdevel+bounces-58544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A0AB2EA6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA5188F640
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5A1FAC42;
	Thu, 21 Aug 2025 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3qxypDm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A061A9FAD;
	Thu, 21 Aug 2025 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739162; cv=none; b=OJzC79c2xGL+vpC3E0QagrxlhZR3lNnEepcF7uhhemaw73xvx3SYOrgrpxeGc4lwSIM8deKj2RA0yYQhgrFGxKKCDWJBoCeoZQhh+kN/PLS3rfjncFcM1yZqjynC7dPqDXVyc9l8WXoBAkDNEbtwSvKLomeI3ytTVmI5noVxOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739162; c=relaxed/simple;
	bh=C/3sL888C+MT8u0pmA4uk6NgS1fAWLDrjntEQw3ococ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOVRJtkJH8HEwg/cjDdr2g0T6I6OtWyThcIyM17W07ABHlcktTLKvZsGyJk1g1PYChlPcSpxEvccFOJms5APckDo7fkBSGjevRwobsHvEi+T0QTdZZhmtZUgq0dtF9FlFCzxX0E70Fxr7gdM0x3wMcrPEbHAfGANzETiipI5gLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3qxypDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6378C4CEEB;
	Thu, 21 Aug 2025 01:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739161;
	bh=C/3sL888C+MT8u0pmA4uk6NgS1fAWLDrjntEQw3ococ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F3qxypDm293vjrheQ22YyWNtScZXZxav6ki0jX+oImxykCXtSm5aOW17eJK2TsJjM
	 ggTVToNnEQsOYPAwPfYJwRHE+b7Oaq8y42w6a59S3FHxB781v4vkjSBo5Th9ssDd7i
	 Kjs1OwG2jENqyjnF3fqPRfYphixBFZD5vv0uFwS+GINGZFwhmdL8ilZPZQg62eMGrz
	 o/7C4eZB4DUcM1m363+OUX2LhqdtSMW0eHXqfFY10bJRmKUVvcagcVQhiq8KtTuWO8
	 f9fc6KShWVaEZouS0bugwV27GCtKDFWyvHmznZZ2AtZubVfvIHxkBT330lYYOoyjW+
	 +KleENTMn06Rg==
Date: Wed, 20 Aug 2025 18:19:21 -0700
Subject: [PATCH 14/19] fuse2fs: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713983.21970.4758569141368563754.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, we can support the strictatime/lazytime mount options.
Add them to fuse2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   28 ++++++++++++++++++++++++++++
 misc/fuse4fs.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 291416afb93d6c..9ac9077f3508f7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -267,6 +267,7 @@ struct fuse2fs {
 	uint8_t dirsync;
 	uint8_t unmount_in_destroy;
 	uint8_t noblkdev;
+	uint8_t iomap_passthrough_options;
 
 	enum fuse2fs_opstate opstate;
 	int logfd;
@@ -1422,6 +1423,8 @@ static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 	if (!fuse2fs_iomap_enabled(ff)) {
 		if (ff->iomap_want == FT_ENABLE)
 			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		if (ff->iomap_passthrough_options)
+			err_printf(ff, "%s\n", _("Some mount options require iomap."));
 		return;
 	}
 }
@@ -6394,6 +6397,7 @@ enum {
 	FUSE2FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE2FS_IOMAP,
+	FUSE2FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -6420,6 +6424,17 @@ static struct fuse_opt fuse2fs_opts[] = {
 #endif
 	FUSE2FS_OPT("noblkdev",		noblkdev,		1),
 
+#ifdef HAVE_FUSE_IOMAP
+#ifdef MS_LAZYTIME
+	FUSE_OPT_KEY("lazytime",	FUSE2FS_IOMAP_PASSTHROUGH),
+	FUSE_OPT_KEY("nolazytime",	FUSE2FS_IOMAP_PASSTHROUGH),
+#endif
+#ifdef MS_STRICTATIME
+	FUSE_OPT_KEY("strictatime",	FUSE2FS_IOMAP_PASSTHROUGH),
+	FUSE_OPT_KEY("nostrictatime",	FUSE2FS_IOMAP_PASSTHROUGH),
+#endif
+#endif
+
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
@@ -6446,6 +6461,12 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	struct fuse2fs *ff = data;
 
 	switch (key) {
+#ifdef HAVE_FUSE_IOMAP
+	case FUSE2FS_IOMAP_PASSTHROUGH:
+		ff->iomap_passthrough_options = 1;
+		/* pass through to libfuse */
+		return 1;
+#endif
 	case FUSE2FS_DIRSYNC:
 		ff->dirsync = 1;
 		/* pass through to libfuse */
@@ -6735,6 +6756,13 @@ int main(int argc, char *argv[])
 		fctx.unmount_in_destroy = 1;
 	}
 
+	if (fctx.iomap_passthrough_options && !iomap_detected) {
+		err_printf(&fctx, "%s\n",
+			   _("Some mount options require iomap."));
+		ret |= 1;
+		goto out;
+	}
+
 	if (!fctx.cache_size)
 		fctx.cache_size = default_cache_size();
 	if (fctx.cache_size) {
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 37a7ab3a3718e4..1050238c88632d 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -262,6 +262,7 @@ struct fuse4fs {
 	uint8_t dirsync;
 	uint8_t unmount_in_destroy;
 	uint8_t noblkdev;
+	uint8_t iomap_passthrough_options;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -1603,6 +1604,8 @@ static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 	if (!fuse4fs_iomap_enabled(ff)) {
 		if (ff->iomap_want == FT_ENABLE)
 			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		if (ff->iomap_passthrough_options)
+			err_printf(ff, "%s\n", _("Some mount options require iomap."));
 		return;
 	}
 }
@@ -6697,6 +6700,7 @@ enum {
 	FUSE4FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE4FS_IOMAP,
+	FUSE4FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -6723,6 +6727,17 @@ static struct fuse_opt fuse4fs_opts[] = {
 #endif
 	FUSE4FS_OPT("noblkdev",		noblkdev,		1),
 
+#ifdef HAVE_FUSE_IOMAP
+#ifdef MS_LAZYTIME
+	FUSE_OPT_KEY("lazytime",	FUSE4FS_IOMAP_PASSTHROUGH),
+	FUSE_OPT_KEY("nolazytime",	FUSE4FS_IOMAP_PASSTHROUGH),
+#endif
+#ifdef MS_STRICTATIME
+	FUSE_OPT_KEY("strictatime",	FUSE4FS_IOMAP_PASSTHROUGH),
+	FUSE_OPT_KEY("nostrictatime",	FUSE4FS_IOMAP_PASSTHROUGH),
+#endif
+#endif
+
 	FUSE_OPT_KEY("user_xattr",	FUSE4FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE4FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE4FS_IGNORED),
@@ -6749,6 +6764,12 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	struct fuse4fs *ff = data;
 
 	switch (key) {
+#ifdef HAVE_FUSE_IOMAP
+	case FUSE4FS_IOMAP_PASSTHROUGH:
+		ff->iomap_passthrough_options = 1;
+		/* pass through to libfuse */
+		return 1;
+#endif
 	case FUSE4FS_DIRSYNC:
 		ff->dirsync = 1;
 		/* pass through to libfuse */
@@ -7137,6 +7158,13 @@ int main(int argc, char *argv[])
 		fctx.unmount_in_destroy = 1;
 	}
 
+	if (fctx.iomap_passthrough_options && !iomap_detected) {
+		err_printf(&fctx, "%s\n",
+			   _("Some mount options require iomap."));
+		ret |= 1;
+		goto out;
+	}
+
 	if (!fctx.cache_size)
 		fctx.cache_size = default_cache_size();
 	if (fctx.cache_size) {


