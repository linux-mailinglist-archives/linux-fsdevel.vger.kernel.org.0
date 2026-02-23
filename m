Return-Path: <linux-fsdevel+bounces-78173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA65OLTlnGlxMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:41:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889C817FC39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 558A53035F75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18A37FF52;
	Mon, 23 Feb 2026 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvmvn3Dp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04034A3C5;
	Mon, 23 Feb 2026 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890093; cv=none; b=NEbHq+TTNVrtzSPffPL7+/ClRFH77AyO1WiAM0yKDZAoCH1I7aWqv8As67H9w5Hp83lSncc3jFvwUc06hMVgznwabCsJgkeLSLdhzjF6XJX893c/02Vm1W0yaFXXHz3/gQn5pjeEbFnL4HambQ4Oaj4rDbHyVuxk9PUaOgVMdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890093; c=relaxed/simple;
	bh=EzH3PMDTAV6KWSm+HNR5KKb/R/tRGemaxQ9ZW2iSXnA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnRlvQYk1Dok2sxuAsaeNW1QI9zzmbIGMdD1WOSbuIx1D5u1UFLZO0NyhvMaRCnTOQKNenZ1vl2z2w70zDYnoH5jLq8tPalaxTADOoRpKWK7e11UAg+V3TpSNKj3AC0gbJOfgE3MQkdF2WbFPxFq/9fYV2qTDY593ZpkVNH+Opo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvmvn3Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25216C116C6;
	Mon, 23 Feb 2026 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890093;
	bh=EzH3PMDTAV6KWSm+HNR5KKb/R/tRGemaxQ9ZW2iSXnA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Dvmvn3DpWl8WQ0CjpvdFXSzC3gwlzN6lbzevj2ZEXxHX43WXnPbV3LNtV1EmeBUfi
	 4YORoLVBseUDS6mUR9BR2T2RoZkrL0/B+JNpPpOSk5pzIxFYJCbTsw8r5r1w0p2B/J
	 XD8YGLDTZ1iRw7I53NfzaHl9UDai1xzCetu+lTHnEeV2oMmIMtBP0jv/v4zaUgmsuY
	 UO5HE27alSePX5fAfhxF7PFIeOQrTOlYLzU7C/LnNOEWYz6jbj29htxuvAljoJzLMR
	 7pMCoCfyYcxDvQHJQ7NKZgAiq/7rA0WNYOKRafmK4nMvVqZlc1jTrEiw4O6KmK8Tf6
	 d6fYT8y0GOncQ==
Date: Mon, 23 Feb 2026 15:41:32 -0800
Subject: [PATCH 01/10] fuse2fs: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745198.3944028.14639957141561126418.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
References: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78173-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 889C817FC39
X-Rspamd-Action: no action

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
index bebc2410af382e..428e4cb404cb45 100644
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
 
@@ -2005,6 +2012,8 @@ static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 	if (!fuse4fs_iomap_enabled(ff)) {
 		if (ff->iomap_want == FT_ENABLE)
 			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		if (ff->iomap_passthrough_options)
+			err_printf(ff, "%s\n", _("Some mount options require iomap."));
 		return;
 	}
 }
@@ -7590,6 +7599,7 @@ enum {
 	FUSE4FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE4FS_IOMAP,
+	FUSE4FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -7616,6 +7626,17 @@ static struct fuse_opt fuse4fs_opts[] = {
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
@@ -7642,6 +7663,12 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
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
@@ -7809,7 +7836,6 @@ static void fuse4fs_compute_libfuse_args(struct fuse4fs *ff,
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
index 4535bb16efd586..3cb875d0d29481 100644
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
 
@@ -1811,6 +1818,8 @@ static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 	if (!fuse2fs_iomap_enabled(ff)) {
 		if (ff->iomap_want == FT_ENABLE)
 			err_printf(ff, "%s\n", _("Could not enable iomap."));
+		if (ff->iomap_passthrough_options)
+			err_printf(ff, "%s\n", _("Some mount options require iomap."));
 		return;
 	}
 }
@@ -7104,6 +7113,7 @@ enum {
 	FUSE2FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE2FS_IOMAP,
+	FUSE2FS_IOMAP_PASSTHROUGH,
 #endif
 };
 
@@ -7130,6 +7140,17 @@ static struct fuse_opt fuse2fs_opts[] = {
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
@@ -7156,6 +7177,12 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
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


