Return-Path: <linux-fsdevel+bounces-61641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84664B58A90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4083C3B1EBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C7A1C5F23;
	Tue, 16 Sep 2025 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPFy9Msd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8B199920;
	Tue, 16 Sep 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984622; cv=none; b=KeVz9JRHF3VoZv/zXspc1LjWZ8zSdY/l7YSaAysHRYTTPjgqElbQobwnDGT8KYnyad6f96RTeev9EPuhEynwUyEgR2noA8Yuv/C83s830+qBfidK8GgfW9pnPhFS5uH2g4YqXQ5VEvbx0EWrRJGobm80PpFTXFvMXDeaHXQTScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984622; c=relaxed/simple;
	bh=2qrWsDc1aug7wfBfvVI8fMnLUh4U92nglHbogtYlGD4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDaCTGD8OEHzx108aQbQnp+kTkvAicPQegCY1R4fItcyLxDer6LcrY6nhfx+KjN66HdIGFco5dUJv7GjQ/2aVkwJ9OkiiOaekxYdmONGY0UL+cyQWf1DqOmqIQTUlUq6R4LGJQpbgTGt+N2c0YqzhA+tafNQUn8XR2QEQrFVjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPFy9Msd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD37C4CEF1;
	Tue, 16 Sep 2025 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984622;
	bh=2qrWsDc1aug7wfBfvVI8fMnLUh4U92nglHbogtYlGD4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VPFy9MsdGx8vNjlPAR55wCajduVK7DreHIVgikEG/EbCN7qInoADvX1Yj3jKS4qpO
	 6Mmq5zHLYKat4/Gi3C2V+A3P9oyhcT0no9aqX+8bozb0XRuFFOHtqxpkbdXtp++jGH
	 eZp/qz2j+RTIWNlP18tIJs6CVZwBDG+aShVG3pf3M/dadqHfEP6hG8r+Zbl2FlprGO
	 4clsRBeXiTGmkfCaDVkLgVRD9zLC5iNG39H+KTOqRhghYH3SQ49RHUzPMpGMBU9Dcm
	 giFQyhmtPivmrGrwf1YZJmJQPUcUx/TAVtIovGk0BgC0JlXIRCA9sZ4bc45UmQkrql
	 T8a1Mc7qyW9KQ==
Date: Mon, 15 Sep 2025 18:03:42 -0700
Subject: [PATCH 01/10] fuse2fs: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162357.391272.10469632486663151563.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
References: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c    |   28 ++++++++++++++++++++++++++++
 misc/fuse2fs.1.in    |    6 ++++++
 misc/fuse2fs.c       |   28 ++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)


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
index 3be19f59fc3976..bc2cf41085695f 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -267,6 +267,7 @@ struct fuse4fs {
 	int unmount_in_destroy;
 	int noblkdev;
 	int translate_inums;
+	int iomap_passthrough_options;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -1648,6 +1649,8 @@ static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 	if (!fuse4fs_iomap_enabled(ff)) {
 		if (ff->iomap_want == FT_ENABLE)
 			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		if (ff->iomap_passthrough_options)
+			err_printf(ff, "%s\n", _("Some mount options require iomap."));
 		return;
 	}
 }
@@ -7070,6 +7073,7 @@ enum {
 	FUSE4FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE4FS_IOMAP,
+	FUSE4FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -7096,6 +7100,17 @@ static struct fuse_opt fuse4fs_opts[] = {
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
@@ -7122,6 +7137,12 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
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
@@ -7515,6 +7536,13 @@ int main(int argc, char *argv[])
 		fctx.unmount_in_destroy = 1;
 	}
 
+	if (fctx.iomap_passthrough_options && !iomap_detected) {
+		err_printf(&fctx, "%s\n",
+			   _("Some mount options require iomap."));
+		ret |= 1;
+		goto out;
+	}
+
 	if (iomap_detected) {
 		/*
 		 * The root_nodeid mount option was added when iomap support
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
index 0832a758bdad79..8f7194f4f815ee 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -260,6 +260,7 @@ struct fuse2fs {
 	int dirsync;
 	int unmount_in_destroy;
 	int noblkdev;
+	int iomap_passthrough_options;
 
 	enum fuse2fs_opstate opstate;
 	int logfd;
@@ -1453,6 +1454,8 @@ static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 	if (!fuse2fs_iomap_enabled(ff)) {
 		if (ff->iomap_want == FT_ENABLE)
 			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		if (ff->iomap_passthrough_options)
+			err_printf(ff, "%s\n", _("Some mount options require iomap."));
 		return;
 	}
 }
@@ -6590,6 +6593,7 @@ enum {
 	FUSE2FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE2FS_IOMAP,
+	FUSE2FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -6616,6 +6620,17 @@ static struct fuse_opt fuse2fs_opts[] = {
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
@@ -6642,6 +6657,12 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
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
@@ -6934,6 +6955,13 @@ int main(int argc, char *argv[])
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


