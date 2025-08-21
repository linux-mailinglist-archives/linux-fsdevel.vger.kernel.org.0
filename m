Return-Path: <linux-fsdevel+bounces-58532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEBBB2EA5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235611CC1EF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B1211A35;
	Thu, 21 Aug 2025 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUzEr0oh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072A211A11;
	Thu, 21 Aug 2025 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738974; cv=none; b=Fd7kwyPoMkC1qu50i1L1O4L4zB9VJyAluVf1WZzK8x/HNUFNw4EDP+KcPINdaOd5l0O/yx92kKghDXLPJ+tok7Yzcl0Ld34zNESYLz+7m38dO4qelTZKNk7F2/kmZzn8UJFGOZxzmtiTFf5EpwGCCW+c8VkjxV1g8PtYqpfa/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738974; c=relaxed/simple;
	bh=b2zii1sQ0mqs9toCwSMDRtze/wP1yyTlkyPNcxHyDv8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cw5IN4XB9bjA4RO27JqCZ45JCi/63EjfP2ku0kujuABGWnzODzRZsOgo1+Umn0UcoP+1SYTM9MLR5qZKXLZ4DD7RNd+LGRhuCKFh3lZQDfec5f6gbrUZj4lYg6VSq9YSX83VxF2JhrD1reneYK5ZFVONldVCR1JCX/vDOV4RlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUzEr0oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31444C4CEE7;
	Thu, 21 Aug 2025 01:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738974;
	bh=b2zii1sQ0mqs9toCwSMDRtze/wP1yyTlkyPNcxHyDv8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UUzEr0ohzJoq97NlIGKnSQ7qkDxva3EnAfavL1DNtlrPDdD57eBs7pEQlo6Az9Ocx
	 ANHvaMiS9KtF4MJ3cdQqTZcV9gnVgdkJAUZXJGrkiHQ2QOFSQ1KCYhkfzhFFKQ0XE3
	 lGEuxh+qSpLIGgLybCJ4hlAihnHcjGbyrEjEC4pOB7OFjaKCHr48UrsACo/bw7CyjF
	 obvD4zNmSNongQDs3S6RTETnzO128lX60bdgJp2fc6sP+72YcjYweJbQMfm5TNx5yx
	 Sysug9aVyAkLrfohrtRziH8+ErypmXE9OtoXc9De/lk0QqP3WPCk/Uu7mqvOCWvOsu
	 TjeNn2nwjcamA==
Date: Wed, 20 Aug 2025 18:16:13 -0700
Subject: [PATCH 02/19] fuse2fs: add iomap= mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713765.21970.14182968277376678245.stgit@frogsfrogsfrogs>
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

Add a mount option to control iomap usage so that we can test before and
after scenarios.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse4fs.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7c87573677e172..c63acd7a0ed155 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -226,6 +226,12 @@ enum fuse2fs_opstate {
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
@@ -261,6 +267,7 @@ struct fuse2fs {
 	int logfd;
 	int blocklog;
 #ifdef HAVE_FUSE_IOMAP
+	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
 #endif
 	unsigned int blockmask;
@@ -1333,6 +1340,12 @@ static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 
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
@@ -5520,6 +5533,9 @@ enum {
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
 	FUSE2FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_IOMAP,
+#endif
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -5551,6 +5567,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE2FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE2FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -5602,6 +5622,23 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 
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
@@ -5629,6 +5666,9 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -5721,6 +5761,7 @@ int main(int argc, char *argv[])
 		.opstate = F2OP_WRITABLE,
 		.logfd = -1,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -5738,6 +5779,11 @@ int main(int argc, char *argv[])
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
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 93570d25e91d5c..2bc25ff37055d5 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -222,6 +222,12 @@ enum fuse4fs_opstate {
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
@@ -257,6 +263,7 @@ struct fuse4fs {
 	int logfd;
 	int blocklog;
 #ifdef HAVE_FUSE_IOMAP
+	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
 #endif
 	unsigned int blockmask;
@@ -1516,6 +1523,12 @@ static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 
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
@@ -5913,6 +5926,9 @@ enum {
 	FUSE4FS_CACHE_SIZE,
 	FUSE4FS_DIRSYNC,
 	FUSE4FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE4FS_IOMAP,
+#endif
 };
 
 #define FUSE4FS_OPT(t, p, v) { t, offsetof(struct fuse4fs, p), v }
@@ -5944,6 +5960,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE4FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE4FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE4FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE4FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE4FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE4FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE4FS_VERSION),
@@ -5995,6 +6015,23 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 
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
@@ -6022,6 +6059,9 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE4FS_HELPFULL) {
@@ -6213,6 +6253,7 @@ int main(int argc, char *argv[])
 		.opstate = F4OP_WRITABLE,
 		.logfd = -1,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -6230,6 +6271,11 @@ int main(int argc, char *argv[])
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


