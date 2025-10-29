Return-Path: <linux-fsdevel+bounces-66112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8CFC17CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7636501782
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499572DF158;
	Wed, 29 Oct 2025 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuCpK3DQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FD2DA77E;
	Wed, 29 Oct 2025 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700419; cv=none; b=kC90bZOwKneK9NwYK82K/0INSkcKtKy8XJ2NNnJq6rnvsYgSgQToUa/w9QGna4Z7i4gsE9MH2LyZJxenkDLRW2HuWcOlli9MDpA0PrDuJ/Lx5hg0lLB95zHJ9dQD9+1wgHwbrYedwlzL6rAfr8EkagRo5F87Z/81WOFnGQqoNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700419; c=relaxed/simple;
	bh=kOUNxf+lkgdqt3WjYuU+BVlkzekvHrQet5cUDknH4tQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIPPXtuKxso8MZUYW354/iIjfF4BOr8wt0epmHpBHBDzkwPpIvipCHclJfdcZOvFoocQBqTHraCUMmxRL71s0W+H5eGzxgvf/S3OwV3YNAlSLzgYJg5bkQLSdel6hNEOapvytNa9aHcN2Y+RP/kLWUJHA3TWhp2oabcY2B82JXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuCpK3DQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7B1C113D0;
	Wed, 29 Oct 2025 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700419;
	bh=kOUNxf+lkgdqt3WjYuU+BVlkzekvHrQet5cUDknH4tQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XuCpK3DQDN7gYRoEXOugB9euaerzOvezAxY/VJj3MYFQieqb9V567rj5A8b6Fltyu
	 jg6QeJmju14rqQUd9leyyk9SLf9LHY75SFLgVA+5OCxZzLpN4uVyZmk9jG3Y5I5gvQ
	 /m02sQoZ4t6aZrSOG+Q88KEGgZ6c8lrHIWhvqMWEtJ1KajOuNPH0gfB+JpCN1EIdgu
	 Q3TH8tdNPNLSG/jmoLkGIqoBsKKnkjA3upql5p2XBB4uuKyOs8fUWDmUVP9phaeWjn
	 LSfejMi50zxVMRzhO+oMtEHJ39xActpWHNb03Iw9dAcaEITNEwGxdgtgszDin9NXUR
	 +0f6qMPrFUkZg==
Date: Tue, 28 Oct 2025 18:13:38 -0700
Subject: [PATCH 01/11] fuse2fs: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818237.1430380.3714821901988932467.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.1.in |    6 ++++++
 fuse4fs/fuse4fs.c    |   28 +++++++++++++++++++++++++++-
 misc/fuse2fs.1.in    |    6 ++++++
 misc/fuse2fs.c       |   27 +++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)


diff --git a/fuse4fs/fuse4fs.1.in b/fuse4fs/fuse4fs.1.in
index 8855867d27101d..119cbcc903d8af 100644
--- a/fuse4fs/fuse4fs.1.in
+++ b/fuse4fs/fuse4fs.1.in
@@ -90,6 +90,9 @@ .SS "fuse4fs options:"
 .I nosuid
 ) later.
 .TP
+\fB-o\fR lazytime
+if iomap is enabled, enable lazy updates of timestamps
+.TP
 \fB-o\fR lockfile=path
 use this file to control access to the filesystem
 .TP
@@ -98,6 +101,9 @@ .SS "fuse4fs options:"
 .TP
 \fB-o\fR norecovery
 do not replay the journal and mount the file system read-only
+.TP
+\fB-o\fR strictatime
+if iomap is enabled, update atime on every access
 .SS "FUSE options:"
 .TP
 \fB-d -o\fR debug
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index d45163e3295168..641fa0648b7a29 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -274,6 +274,7 @@ struct fuse4fs {
 	int acl;
 	int dirsync;
 	int translate_inums;
+	int iomap_passthrough_options;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -1376,6 +1377,12 @@ static errcode_t fuse4fs_check_support(struct fuse4fs *ff)
 		return EXT2_ET_FILESYSTEM_CORRUPTED;
 	}
 
+	if (ff->iomap_passthrough_options && !fuse4fs_can_iomap(ff)) {
+		err_printf(ff, "%s\n",
+			   _("Some mount options require iomap."));
+		return EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1999,6 +2006,8 @@ static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 	if (!fuse4fs_iomap_enabled(ff)) {
 		if (ff->iomap_want == FT_ENABLE)
 			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		if (ff->iomap_passthrough_options)
+			err_printf(ff, "%s\n", _("Some mount options require iomap."));
 		return;
 	}
 }
@@ -7570,6 +7579,7 @@ enum {
 	FUSE4FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE4FS_IOMAP,
+	FUSE4FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -7596,6 +7606,17 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE4FS_OPT("timing",		timing,			1),
 #endif
 
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
@@ -7622,6 +7643,12 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
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
@@ -7789,7 +7816,6 @@ static void fuse4fs_compute_libfuse_args(struct fuse4fs *ff,
 		ff->translate_inums = 0;
 	}
 
-
 	if (ff->debug) {
 		int	i;
 
diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index 2b55fa0e723966..0c0934f03c9543 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -90,6 +90,9 @@ .SS "fuse2fs options:"
 .I nosuid
 ) later.
 .TP
+\fB-o\fR lazytime
+if iomap is enabled, enable lazy updates of timestamps
+.TP
 \fB-o\fR lockfile=path
 use this file to control access to the filesystem
 .TP
@@ -98,6 +101,9 @@ .SS "fuse2fs options:"
 .TP
 \fB-o\fR norecovery
 do not replay the journal and mount the file system read-only
+.TP
+\fB-o\fR strictatime
+if iomap is enabled, update atime on every access
 .SS "FUSE options:"
 .TP
 \fB-d -o\fR debug
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 763e1386bb54c8..9fda7663583f71 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -267,6 +267,7 @@ struct fuse2fs {
 	int directio;
 	int acl;
 	int dirsync;
+	int iomap_passthrough_options;
 
 	enum fuse2fs_opstate opstate;
 	int logfd;
@@ -1191,6 +1192,12 @@ static errcode_t fuse2fs_check_support(struct fuse2fs *ff)
 		return EXT2_ET_FILESYSTEM_CORRUPTED;
 	}
 
+	if (ff->iomap_passthrough_options && !fuse2fs_can_iomap(ff)) {
+		err_printf(ff, "%s\n",
+			   _("Some mount options require iomap."));
+		return EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1805,6 +1812,8 @@ static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 	if (!fuse2fs_iomap_enabled(ff)) {
 		if (ff->iomap_want == FT_ENABLE)
 			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		if (ff->iomap_passthrough_options)
+			err_printf(ff, "%s\n", _("Some mount options require iomap."));
 		return;
 	}
 }
@@ -7087,6 +7096,7 @@ enum {
 	FUSE2FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE2FS_IOMAP,
+	FUSE2FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -7113,6 +7123,17 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("timing",		timing,			1),
 #endif
 
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
@@ -7139,6 +7160,12 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
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


