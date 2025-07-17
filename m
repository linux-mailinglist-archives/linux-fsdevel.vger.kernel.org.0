Return-Path: <linux-fsdevel+bounces-55366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D6AB0983C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8A67BC66D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1C2417E0;
	Thu, 17 Jul 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lye/6OKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565B1FCFF8;
	Thu, 17 Jul 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795594; cv=none; b=iXIsM2edFzAV8oKeb2VyPNpioCPehPOGphpgTQUtVfptgL3+b9Jc1XW3vz3UfqaznCG1Iu/jyJYQS5oGHFiuLElbHIir6gyXVpWvLtCoAFV+ZxERtMHIbT3QPwz6GxjxAs8wv/UFonBBhYhCMPWpxg1NxJSoBDDikQEI5OrBeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795594; c=relaxed/simple;
	bh=IA0+whUanfNor07uQvaNYOaeo4BuOHyQcMbo7hBV8Eg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mafB7hcUbhTrUVOjBnZJm4Uy6NURT1ieBHa0s6CUZ4FBxM8A/SrVEUCZaWSddb1pumU/XIkMtbmtz4vXriijGcG2RkekomInUhhK6pwdttcUdIoYehvp0IkmffmWJW2pB2UHciqto2MexxRlDNj31RMTezl1FzJPqnCH32Oyx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lye/6OKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA942C4CEF0;
	Thu, 17 Jul 2025 23:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795593;
	bh=IA0+whUanfNor07uQvaNYOaeo4BuOHyQcMbo7hBV8Eg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Lye/6OKMea8QPCzHmsWCllIej9BgvvlfyyVVCb8yVhPNoSkUehROrxiEFYUEd78X2
	 G2iP5h15mTxcLUbhj9ZW+ZWRGLUsJGef72gxKFb2kd6UrpJp81CFEaniJVHFBts//p
	 bKQoozQ8y6ythisb5bhLxswCIrEkFS2GEyZHrwIE3Ft2J2J/8BVVEZoELHA2xUmVn9
	 FODH7aHXDUqvC83/iVTjHqHrDNubGVAqHs4L13c7Y/bJc7fSsDRZDWzQH0WmCCY26P
	 WnRekStr+CAKFsYjIeuL156EmNqUWCVfLTvxY5Ql1Axi/sxqRoe+WRd/iH8NIga0+y
	 Pemw4/2Nmb7WQ==
Date: Thu, 17 Jul 2025 16:39:53 -0700
Subject: [PATCH 02/22] fuse2fs: add iomap= mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461068.715479.1965500036520390920.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e688772ddd8b60..d4912dee08d43f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -219,6 +219,12 @@ enum fuse2fs_opstate {
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
 	enum fuse2fs_opstate opstate;
 	int blocklog;
 #ifdef HAVE_FUSE_IOMAP
+	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
 #endif
 	unsigned int blockmask;
@@ -1235,6 +1242,13 @@ static void *op_init(struct fuse_conn_info *conn
 		fuse2fs_iomap_confirm(conn, ff);
 	}
 
+#if defined(HAVE_FUSE_IOMAP)
+	if (ff->iomap_want == FT_ENABLE && !fuse2fs_iomap_enabled(ff)) {
+		err_printf(ff, "%s\n", _("could not enable iomap."));
+		goto mount_fail;
+	}
+#endif
+
 	/*
 	 * If we're mounting in iomap mode, we need to unmount in op_destroy
 	 * so that the block device will be released before umount(2) returns.
@@ -5307,6 +5321,9 @@ enum {
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
 	FUSE2FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_IOMAP,
+#endif
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -5335,6 +5352,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE2FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE2FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -5386,6 +5407,23 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 
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
@@ -5413,6 +5451,9 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -5500,6 +5541,7 @@ int main(int argc, char *argv[])
 		.magic = FUSE2FS_MAGIC,
 		.opstate = F2OP_WRITABLE,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -5518,6 +5560,11 @@ int main(int argc, char *argv[])
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


