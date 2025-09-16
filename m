Return-Path: <linux-fsdevel+bounces-61624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E8B58A64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366742A3DC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5AD1DF26A;
	Tue, 16 Sep 2025 00:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwspP6kh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9F2BB13;
	Tue, 16 Sep 2025 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984355; cv=none; b=t/AxCykhSyAJL229XS/O5BLNNqgau9O5RryiWSgdsrA0aXLZvyXWaVC6GPms9NvLZZsjU/2Jtge6qBScz+jSu+hJQmnCOdzWMsWnAEcGiITYh3m21yeBRVqNoHbOFXMtnyY0Ysg2OszE2lnMmTAxe/e21AsKfEXvVeiuyb63zkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984355; c=relaxed/simple;
	bh=AYztex2FCIEqpMFhIcLhaTXI335/mxEUZridtP1N8H4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQFV3QXzLW3olEHP8VuRkuI3DEnQJ/B3LzobjVp5MyuiqVAwnIcVAP3aYPBo1i1Mw1vugss9Kg0eJyih7X2/smnpbw65LLra2qlrPj9xvVHmsJRMJfuvfvEROnebAY13YD75u2M6SayOPRyew+qclH5LWcri9hmO+B94L1uBsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwspP6kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628F9C4CEF1;
	Tue, 16 Sep 2025 00:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984355;
	bh=AYztex2FCIEqpMFhIcLhaTXI335/mxEUZridtP1N8H4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uwspP6khxCFoVxDewfKrZaNzdqKAAz/uu2WdpchielZred0Q2U1/hOxMGXwWcodkv
	 waWcRhhZkAUBuHyqGWSwFTZbQFQkKw+rFkVpLIspaS22uC5BuPOXrtTPbYDzUJU+PI
	 GubZe7hSIg/urAzw6TjdX9ZEOHSKSIMRSHwXwJtM8leqECTbNZMUV/usV1SE6wf69g
	 YZ9oKUWDaXURyt7kNZE18UP3dmtSFCUoHCVHaFhfNMHZzZxxorIuRyqby0Qjyz58S5
	 ork9yEMd9i9Qto4ZkuaZL7fW1I3eoU/oupSGNIHNyIuKRDKMmmI9Siw/e52OTPsOYZ
	 if8agJj9Vur1g==
Date: Mon, 15 Sep 2025 17:59:14 -0700
Subject: [PATCH 02/17] fuse2fs: add iomap= mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161755.390496.2262879936741291311.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a mount option to control iomap usage so that we can test before and
after scenarios.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.1.in |    6 ++++++
 fuse4fs/fuse4fs.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.1.in    |    6 ++++++
 misc/fuse2fs.c       |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+)


diff --git a/fuse4fs/fuse4fs.1.in b/fuse4fs/fuse4fs.1.in
index 8bef5f48802385..8855867d27101d 100644
--- a/fuse4fs/fuse4fs.1.in
+++ b/fuse4fs/fuse4fs.1.in
@@ -75,6 +75,12 @@ .SS "fuse4fs options:"
 \fB-o\fR fuse4fs_debug
 enable fuse4fs debugging
 .TP
+\fB-o\fR iomap=
+If set to \fI1\fR, requires iomap to be enabled.
+If set to \fI0\fR, forbids use of iomap.
+If set to \fIdefault\fR (or not set), enables iomap if present.
+This substantially improves the performance of the fuse4fs server.
+.TP
 \fB-o\fR kernel
 Behave more like the kernel ext4 driver in the following ways:
 Allows processes owned by other users to access the filesystem.
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index bf9c2081702132..2d7b40911ce0f7 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -223,6 +223,12 @@ enum fuse4fs_opstate {
 	F4OP_SHUTDOWN,
 };
 
+enum fuse4fs_feature_toggle {
+	FT_DISABLE,
+	FT_ENABLE,
+	FT_DEFAULT,
+};
+
 #ifdef HAVE_FUSE_IOMAP
 enum fuse4fs_iomap_state {
 	IOMAP_DISABLED,
@@ -260,6 +266,7 @@ struct fuse4fs {
 	int logfd;
 	int blocklog;
 #ifdef HAVE_FUSE_IOMAP
+	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
 #endif
 	unsigned int blockmask;
@@ -1539,6 +1546,12 @@ static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 
 	if (ff->iomap_state == IOMAP_UNKNOWN)
 		ff->iomap_state = IOMAP_DISABLED;
+
+	if (!fuse4fs_iomap_enabled(ff)) {
+		if (ff->iomap_want == FT_ENABLE)
+			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		return;
+	}
 }
 #else
 # define fuse4fs_iomap_enable(...)	((void)0)
@@ -5981,6 +5994,9 @@ enum {
 	FUSE4FS_CACHE_SIZE,
 	FUSE4FS_DIRSYNC,
 	FUSE4FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE4FS_IOMAP,
+#endif
 };
 
 #define FUSE4FS_OPT(t, p, v) { t, offsetof(struct fuse4fs, p), v }
@@ -6012,6 +6028,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE4FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE4FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE4FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE4FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE4FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE4FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE4FS_VERSION),
@@ -6063,6 +6083,23 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 
 		/* do not pass through to libfuse */
 		return 0;
+#ifdef HAVE_FUSE_IOMAP
+	case FUSE4FS_IOMAP:
+		if (strcmp(arg, "iomap") == 0 || strcmp(arg + 6, "1") == 0)
+			ff->iomap_want = FT_ENABLE;
+		else if (strcmp(arg + 6, "0") == 0)
+			ff->iomap_want = FT_DISABLE;
+		else if (strcmp(arg + 6, "default") == 0)
+			ff->iomap_want = FT_DEFAULT;
+		else {
+			fprintf(stderr, "%s: %s\n", arg,
+ _("unknown iomap= behavior."));
+			return -1;
+		}
+
+		/* do not pass through to libfuse */
+		return 0;
+#endif
 	case FUSE4FS_IGNORED:
 		return 0;
 	case FUSE4FS_HELP:
@@ -6090,6 +6127,9 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE4FS_HELPFULL) {
@@ -6282,6 +6322,7 @@ int main(int argc, char *argv[])
 		.opstate = F4OP_WRITABLE,
 		.logfd = -1,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -6299,6 +6340,11 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+#ifdef HAVE_FUSE_IOMAP
+	if (fctx.iomap_want == FT_DISABLE)
+		fctx.iomap_state = IOMAP_DISABLED;
+#endif
+
 	/* /dev/sda -> sda for reporting */
 	fctx.shortdev = strrchr(fctx.device, '/');
 	if (fctx.shortdev)
diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index 6acfa092851292..2b55fa0e723966 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -75,6 +75,12 @@ .SS "fuse2fs options:"
 \fB-o\fR fuse2fs_debug
 enable fuse2fs debugging
 .TP
+\fB-o\fR iomap=
+If set to \fI1\fR, requires iomap to be enabled.
+If set to \fI0\fR, forbids use of iomap.
+If set to \fIdefault\fR (or not set), enables iomap if present.
+This substantially improves the performance of the fuse2fs server.
+.TP
 \fB-o\fR kernel
 Behave more like the kernel ext4 driver in the following ways:
 Allows processes owned by other users to access the filesystem.
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ca61fbc89f5fda..95d3dedbdb8b80 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -216,6 +216,12 @@ enum fuse2fs_opstate {
 	F2OP_SHUTDOWN,
 };
 
+enum fuse2fs_feature_toggle {
+	FT_DISABLE,
+	FT_ENABLE,
+	FT_DEFAULT,
+};
+
 #ifdef HAVE_FUSE_IOMAP
 enum fuse2fs_iomap_state {
 	IOMAP_DISABLED,
@@ -253,6 +259,7 @@ struct fuse2fs {
 	int logfd;
 	int blocklog;
 #ifdef HAVE_FUSE_IOMAP
+	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
 #endif
 	unsigned int blockmask;
@@ -1345,6 +1352,12 @@ static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 
 	if (ff->iomap_state == IOMAP_UNKNOWN)
 		ff->iomap_state = IOMAP_DISABLED;
+
+	if (!fuse2fs_iomap_enabled(ff)) {
+		if (ff->iomap_want == FT_ENABLE)
+			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		return;
+	}
 }
 #else
 # define fuse2fs_iomap_enable(...)	((void)0)
@@ -5419,6 +5432,9 @@ enum {
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
 	FUSE2FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_IOMAP,
+#endif
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -5450,6 +5466,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE2FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE2FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -5501,6 +5521,23 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 
 		/* do not pass through to libfuse */
 		return 0;
+#ifdef HAVE_FUSE_IOMAP
+	case FUSE2FS_IOMAP:
+		if (strcmp(arg, "iomap") == 0 || strcmp(arg + 6, "1") == 0)
+			ff->iomap_want = FT_ENABLE;
+		else if (strcmp(arg + 6, "0") == 0)
+			ff->iomap_want = FT_DISABLE;
+		else if (strcmp(arg + 6, "default") == 0)
+			ff->iomap_want = FT_DEFAULT;
+		else {
+			fprintf(stderr, "%s: %s\n", arg,
+ _("unknown iomap= behavior."));
+			return -1;
+		}
+
+		/* do not pass through to libfuse */
+		return 0;
+#endif
 	case FUSE2FS_IGNORED:
 		return 0;
 	case FUSE2FS_HELP:
@@ -5528,6 +5565,9 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -5620,6 +5660,7 @@ int main(int argc, char *argv[])
 		.opstate = F2OP_WRITABLE,
 		.logfd = -1,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -5637,6 +5678,11 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+#ifdef HAVE_FUSE_IOMAP
+	if (fctx.iomap_want == FT_DISABLE)
+		fctx.iomap_state = IOMAP_DISABLED;
+#endif
+
 	/* /dev/sda -> sda for reporting */
 	fctx.shortdev = strrchr(fctx.device, '/');
 	if (fctx.shortdev)


