Return-Path: <linux-fsdevel+bounces-66094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC3C17C56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9FC1A234E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABB22D8DDD;
	Wed, 29 Oct 2025 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgFlA8Ph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEE3A1CD;
	Wed, 29 Oct 2025 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700137; cv=none; b=hJW3CDzKTXKJPKqY5iRoZ8UaYkGdu0a0b4wVjdnAKEM9TXL7NsTshnie6Q1PCr5SXrg3oqMCPd2OFP+bzK3FTYMvg5vKP/NKmOVFtjuhKqTPDo+WDDRyqMnYVbkDTnMDPWkXTtpWj4jUY2HlPrdv83iliCk6O4Pumryy4p5ii2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700137; c=relaxed/simple;
	bh=zgror8aoiy3BymGgBAdSbYxjd2ivYOnJu4y43pHiFR0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izwaUkbWs119OxlhC+dN7+DovovSPQdCfKFcEdNS9TSIJ2UURDvfUYItiVRJcsGlvWVkgdiKozWUbRLFjl7YU4Vd2EhfFKc5rxXeWTTCG67uO8F9dmfb/Lk+ls1f6JiRA5IC57tlsvXnkKr2x+Qfglh3xEF2Mqu9R4Lz5Slj8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgFlA8Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D72C4CEE7;
	Wed, 29 Oct 2025 01:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700137;
	bh=zgror8aoiy3BymGgBAdSbYxjd2ivYOnJu4y43pHiFR0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NgFlA8PhMmLJjIxjcsYUJb/hVhYw/3erxGJul+66FCEL4/vst4ntYapnMVyLmUZNH
	 IxkkAi4UYtSnSaU0X5gjwK7sIxjwXLq3XO/V7vU+V8Zja4fKhX5deV95HXZb9hw1mU
	 kMdWD0QPVuTv2GiIWjf07LRrGtuI7+MlqeIqQKpECSquduUiBg1Y5w7GLDEJswhsN4
	 Za+PDPg6l1UkzBA1H4vsMwqWCH1pPbWOyoSUavtUmlfoL+Zt7PMuqunzDnG6l1W0B0
	 9cWeozVjoVJHtChgitGIHOnu5RM0WrHgo/5jPmqMQTF7oikHA077oRVE2S44bFm2u7
	 gI0Mb40PjNl/A==
Date: Tue, 28 Oct 2025 18:08:56 -0700
Subject: [PATCH 02/17] fuse2fs: add iomap= mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817597.1429568.13724934700834320941.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
References: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
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
index 9b07efae79c7da..a03a74ee19c1a8 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -224,6 +224,12 @@ enum fuse4fs_opstate {
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
 	int blocklog;
 	int oom_score_adj;
 #ifdef HAVE_FUSE_IOMAP
+	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
 #endif
 	unsigned int blockmask;
@@ -1788,6 +1795,12 @@ static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 
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
@@ -6284,6 +6297,9 @@ enum {
 	FUSE4FS_CACHE_SIZE,
 	FUSE4FS_DIRSYNC,
 	FUSE4FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE4FS_IOMAP,
+#endif
 };
 
 #define FUSE4FS_OPT(t, p, v) { t, offsetof(struct fuse4fs, p), v }
@@ -6315,6 +6331,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE4FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE4FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE4FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE4FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE4FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE4FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE4FS_VERSION),
@@ -6366,6 +6386,23 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 
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
@@ -6393,6 +6430,9 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE4FS_HELPFULL) {
@@ -6635,6 +6675,7 @@ int main(int argc, char *argv[])
 		.oom_score_adj = -500,
 		.opstate = F4OP_WRITABLE,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -6651,6 +6692,11 @@ int main(int argc, char *argv[])
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
index 2a61610571760b..a368c3a8d5eac9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -217,6 +217,12 @@ enum fuse2fs_opstate {
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
 	int blocklog;
 	int oom_score_adj;
 #ifdef HAVE_FUSE_IOMAP
+	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
 #endif
 	unsigned int blockmask;
@@ -1596,6 +1603,12 @@ static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 
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
@@ -5726,6 +5739,9 @@ enum {
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
 	FUSE2FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_IOMAP,
+#endif
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -5757,6 +5773,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE2FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE2FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -5808,6 +5828,23 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 
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
@@ -5835,6 +5872,9 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -5986,6 +6026,7 @@ int main(int argc, char *argv[])
 		.oom_score_adj = -500,
 		.opstate = F2OP_WRITABLE,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -6002,6 +6043,11 @@ int main(int argc, char *argv[])
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


