Return-Path: <linux-fsdevel+bounces-78154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNhnMDTlnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:39:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D5717FB45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ABE130B62DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33B637FF40;
	Mon, 23 Feb 2026 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egwsf+kY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BF37F8CF;
	Mon, 23 Feb 2026 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889794; cv=none; b=b7bGELeCtWF2HlQBy5B9oJLsTCYq5QFxI7xIIOldCBaaOHKmmABUyhODz72R0RHrgYffdAvAE/ISowi1d05d9ZuNLGmmbUh0WUzHbwSNqBginLlNNiEBEYdm93nrQJldTpESlKdbtZTHHYzfnrIq0ZojT7KHF/M+WOGZF7JU6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889794; c=relaxed/simple;
	bh=UXgHoxr5Wgj/MlpSwsUWfVAZfAiTX2onG5CANwDP2fA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyae4y0Gxk6LqaQqk7SeF251es73vc2qqzNMweZ2H8sPpcqALvfqeh9rG/LbZsMHuRyHntI+x79D3DvAz+G4kVBxP9UGMMhL6TbZqsQwYcmdVY4vUhlsSbPEZ6TksLNBWTbW1QQpXPfaVfkTV1qgYLGYKlwCDt5cR8guDRz2+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egwsf+kY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A8AC116C6;
	Mon, 23 Feb 2026 23:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889794;
	bh=UXgHoxr5Wgj/MlpSwsUWfVAZfAiTX2onG5CANwDP2fA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=egwsf+kYidLXUBmi/qYnPiJ2+ZlU9/SXG0bQeNj8T83xKzN5BQyzBpYE3afSjtaa2
	 IYZIYc7/Nops8KbbWDGWbWAYPdbS0cimONk3T0bc5kTcQimL3zV3KuTHqrE66AJ2T+
	 S6erRFiP0UaamHvfxr0aExxUVYJ/74izPgIpF0rfrdYDS9CX2Al2BTUVGveLKJGvMj
	 pRaD8R+mAniZ/JVnF1NkojkztgMOQIv8Uh+7Yi0JgrFcR60J++Q3xqukn6D/UPW+VT
	 ZoZec80YBK7d0xlJp1QSbCWu3sXZ6+6ueufeneVzIGHKnPOra6EOF6LgWq+z6KH7ef
	 8JVR/PrQCpZhw==
Date: Mon, 23 Feb 2026 15:36:33 -0800
Subject: [PATCH 02/19] fuse2fs: add iomap= mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744518.3943178.13781532280222393134.stgit@frogsfrogsfrogs>
In-Reply-To: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
References: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78154-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42D5717FB45
X-Rspamd-Action: no action

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
index a98cbc5234715d..d5476eb0ab90a4 100644
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
@@ -1794,6 +1801,12 @@ static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 
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
@@ -6303,6 +6316,9 @@ enum {
 	FUSE4FS_CACHE_SIZE,
 	FUSE4FS_DIRSYNC,
 	FUSE4FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE4FS_IOMAP,
+#endif
 };
 
 #define FUSE4FS_OPT(t, p, v) { t, offsetof(struct fuse4fs, p), v }
@@ -6334,6 +6350,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE4FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE4FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE4FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE4FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE4FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE4FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE4FS_VERSION),
@@ -6385,6 +6405,23 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 
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
@@ -6412,6 +6449,9 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE4FS_HELPFULL) {
@@ -6654,6 +6694,7 @@ int main(int argc, char *argv[])
 		.oom_score_adj = -500,
 		.opstate = F4OP_WRITABLE,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -6670,6 +6711,11 @@ int main(int argc, char *argv[])
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
index e92e66dad63b2d..fafd99aa64e911 100644
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
@@ -1602,6 +1609,12 @@ static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 
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
@@ -5745,6 +5758,9 @@ enum {
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
 	FUSE2FS_ERRORS_BEHAVIOR,
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_IOMAP,
+#endif
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -5776,6 +5792,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE_OPT_KEY("iomap=%s",	FUSE2FS_IOMAP),
+	FUSE_OPT_KEY("iomap",		FUSE2FS_IOMAP),
+#endif
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -5827,6 +5847,23 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 
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
@@ -5854,6 +5891,9 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
+#ifdef HAVE_FUSE_IOMAP
+	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
+#endif
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -6005,6 +6045,7 @@ int main(int argc, char *argv[])
 		.oom_score_adj = -500,
 		.opstate = F2OP_WRITABLE,
 #ifdef HAVE_FUSE_IOMAP
+		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 #endif
 	};
@@ -6021,6 +6062,11 @@ int main(int argc, char *argv[])
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


