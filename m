Return-Path: <linux-fsdevel+bounces-78202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HDyMDTonGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:52:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF8A1800E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33AC31ADC51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B323803C8;
	Mon, 23 Feb 2026 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeXvX6w7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427665695;
	Mon, 23 Feb 2026 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890531; cv=none; b=ImtFy5XUzzcebbfjI1csOkJIx8plCMPJWh0m6ibOdeZsPm/6x1Sad/bXrCEVrtN9smrxtvD+DoAGUfTKzUvrWE2VOFaglFvSagC1jv3BiiY88U3T5f6CsWXj0rhwgNKwU4jc7W14IMiptoLEj8LzLO5QRBfvNIRMqNR6G5NJtj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890531; c=relaxed/simple;
	bh=sH1WmzhCNoLyRI4hRD0ULs4oASV5KhXVDoPUdXd7ah4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AME0Sgd6Skn2aWaHAjRjE7O3njiU/LqqZsN8nyafPC3tcIU0midIkupfNWZ0bluk/orJXCqmgyHH5DYoAYrFn0NWrinybnZQ6WweXqpHWAO3h7+iT1uPukUHb0kJpEz2QzRSbnO9/kCgeJCAbIAXAeS78N+AyiCHQ7ENf8VvbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeXvX6w7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19484C116C6;
	Mon, 23 Feb 2026 23:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890531;
	bh=sH1WmzhCNoLyRI4hRD0ULs4oASV5KhXVDoPUdXd7ah4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XeXvX6w7du+mkMSHMkmTpkrn28ENpRGfTAGjbNUVVTDm8KWvCx3q6Ztv30weyKHyU
	 vpA9s+lYnQwP0ItBS35qBfbWQjlNUzrUq3lE86urbmYyzOIn+F6OWEMHBEvuDfpftz
	 1HPmZJ0QCoRFz9mvfLWeNLG6DoLjahmuawoXr/XtSCzElRRENoiaumwQhOltSj3vnm
	 IDpVgEWRyHYGEm6xOKNCGcYacWfKl+36DR4vi7FW5tb0VbRngeu8Gt5v/iEiIz11A8
	 eNzU+TlOutm71qC7EYqL3Y3YZMDTbWt5WN5l061+J3o5hYVXGeykAYHivttTNkSbS5
	 29te1Gz5YrXcg==
Date: Mon, 23 Feb 2026 15:48:50 -0800
Subject: [PATCH 2/4] fuse2fs: only reclaim buffer cache when there is memory
 pressure
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746271.3945260.15563480512654513408.stgit@frogsfrogsfrogs>
In-Reply-To: <177188746221.3945260.11225620337508354203.stgit@frogsfrogsfrogs>
References: <177188746221.3945260.11225620337508354203.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78202-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AF8A1800E8
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Use the pressure stall indicator library that we added in the previous
patch to make it so that we only shrink the cache when there's memory
pressure.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/Makefile.in |    2 +
 fuse4fs/fuse4fs.c   |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/Makefile.in    |    2 +
 misc/fuse2fs.c      |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index f6473ad0027e51..0600485b074158 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -180,7 +180,7 @@ fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
  $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
- $(top_srcdir)/lib/support/iocache.h
+ $(top_srcdir)/lib/support/iocache.h $(top_srcdir)/lib/support/psi.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
  $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index b12bd926931a69..87b17491beae13 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -64,6 +64,7 @@
 #include "support/list.h"
 #include "support/cache.h"
 #include "support/iocache.h"
+#include "support/psi.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -327,6 +328,8 @@ struct fuse4fs {
 	int bdev_fd;
 	int fusedev_fd;
 #endif
+	struct psi *mem_psi;
+	struct psi_handler *mem_psi_handler;
 };
 
 #ifdef HAVE_FUSE_SERVICE
@@ -908,6 +911,74 @@ static void fuse4fs_mmp_destroy(struct fuse4fs *ff)
 # define fuse4fs_mmp_destroy(...)	((void)0)
 #endif
 
+static void fuse4fs_psi_memory(const struct psi *psi, unsigned int reasons,
+			       void *data)
+{
+	struct fuse4fs *ff = data;
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	fs = fuse4fs_start(ff);
+	dbg_printf(ff, "%s:\n", __func__);
+	if (fs && !psi_thread_cancelled(ff->mem_psi)) {
+		err = io_channel_set_options(fs->io, "cache_shrink");
+		if (err)
+			ret = translate_error(fs, 0, err);
+	} else {
+		psi_cancel_handler(ff->mem_psi, &ff->mem_psi_handler);
+	}
+	fuse4fs_finish(ff, ret);
+}
+
+static int fuse4fs_psi_config(struct fuse4fs *ff)
+{
+	errcode_t err;
+
+	/*
+	 * Activate when there are memory stalls for 200ms every 2s; or
+	 * 5min goes by.  Unprivileged processes can only use 2s windows.
+	 */
+	err = psi_create(PSI_MEMORY, PSI_TRIM_HEAP, 20100, 2000000,
+			 5 * 60 * 1000000, &ff->mem_psi);
+	if (err) {
+		switch (errno) {
+		case ENOENT:
+		case EINVAL:
+		case EACCES:
+		case EPERM:
+			break;
+		default:
+			err_printf(ff, "PSI: %s.\n", error_message(errno));
+			return -1;
+		}
+	}
+
+	err = psi_add_handler(ff->mem_psi, fuse4fs_psi_memory, ff,
+			      &ff->mem_psi_handler);
+	if (err) {
+		err_printf(ff, "PSI: %s.\n", error_message(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static void fuse4fs_psi_start(struct fuse4fs *ff)
+{
+	if (psi_active(ff->mem_psi))
+		psi_start_thread(ff->mem_psi);
+}
+
+static void fuse4fs_psi_destroy(struct fuse4fs *ff)
+{
+	if (!psi_active(ff->mem_psi))
+		return;
+
+	psi_del_handler(ff->mem_psi, &ff->mem_psi_handler);
+	psi_destroy(&ff->mem_psi);
+}
+
 static inline struct fuse4fs *fuse4fs_get(fuse_req_t req)
 {
 	return (struct fuse4fs *)fuse_req_userdata(req);
@@ -2020,6 +2091,11 @@ static errcode_t fuse4fs_config_cache(struct fuse4fs *ff)
 		return err;
 	}
 
+	if (psi_active(ff->mem_psi)) {
+		snprintf(buf, sizeof(buf), "cache_auto_shrink=off");
+		io_channel_set_options(ff->fs->io, buf);
+	}
+
 	return 0;
 }
 
@@ -2365,6 +2441,7 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 	 * conveyed to the new child process.
 	 */
 	fuse4fs_mmp_start(ff);
+	fuse4fs_psi_start(ff);
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
 	/*
@@ -8590,6 +8667,12 @@ int main(int argc, char *argv[])
 
 	try_adjust_oom_score(&fctx);
 
+	err = fuse4fs_psi_config(&fctx);
+	if (err) {
+		ret |= 32;
+		goto out;
+	}
+
 	/* Will we allow users to allocate every last block? */
 	if (getenv("FUSE4FS_ALLOC_ALL_BLOCKS")) {
 		log_printf(&fctx, "%s\n",
@@ -8679,6 +8762,7 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
+	fuse4fs_psi_destroy(&fctx);
 	fuse4fs_mmp_destroy(&fctx);
 	fuse4fs_unmount(&fctx);
 	reset_com_err_hook();
diff --git a/misc/Makefile.in b/misc/Makefile.in
index 5b19cdc96bf4f7..5a37c942188ddc 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -882,7 +882,7 @@ fuse2fs.o: $(srcdir)/fuse2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
  $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
- $(top_srcdir)/lib/support/iocache.h
+ $(top_srcdir)/lib/support/iocache.h $(top_srcdir)/lib/support/psi.h
 e2fuzz.o: $(srcdir)/e2fuzz.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4d62b5d44279f9..f2929ae0045bc9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -56,6 +56,7 @@
 #include "support/list.h"
 #include "support/cache.h"
 #include "support/iocache.h"
+#include "support/psi.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -306,6 +307,8 @@ struct fuse2fs {
 	/* options set by fuse_opt_parse must be of type int */
 	int timing;
 #endif
+	struct psi *mem_psi;
+	struct psi_handler *mem_psi_handler;
 };
 
 #define FUSE2FS_CHECK_HANDLE(ff, fh) \
@@ -722,6 +725,74 @@ static void fuse2fs_mmp_destroy(struct fuse2fs *ff)
 # define fuse2fs_mmp_destroy(...)	((void)0)
 #endif
 
+static void fuse2fs_psi_memory(const struct psi *psi, unsigned int reasons,
+			       void *data)
+{
+	struct fuse2fs *ff = data;
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	fs = fuse2fs_start(ff);
+	dbg_printf(ff, "%s:\n", __func__);
+	if (fs && !psi_thread_cancelled(ff->mem_psi)) {
+		err = io_channel_set_options(fs->io, "cache_shrink");
+		if (err)
+			ret = translate_error(fs, 0, err);
+	} else {
+		psi_cancel_handler(ff->mem_psi, &ff->mem_psi_handler);
+	}
+	fuse2fs_finish(ff, ret);
+}
+
+static int fuse2fs_psi_config(struct fuse2fs *ff)
+{
+	errcode_t err;
+
+	/*
+	 * Activate when there are memory stalls for 200ms every 2s; or
+	 * 5min goes by.  Unprivileged processes can only use 2s windows.
+	 */
+	err = psi_create(PSI_MEMORY, PSI_TRIM_HEAP, 20100, 2000000,
+			 5 * 60 * 1000000, &ff->mem_psi);
+	if (err) {
+		switch (errno) {
+		case ENOENT:
+		case EINVAL:
+		case EACCES:
+		case EPERM:
+			break;
+		default:
+			err_printf(ff, "PSI: %s.\n", error_message(errno));
+			return -1;
+		}
+	}
+
+	err = psi_add_handler(ff->mem_psi, fuse2fs_psi_memory, ff,
+			      &ff->mem_psi_handler);
+	if (err) {
+		err_printf(ff, "PSI: %s.\n", error_message(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static void fuse2fs_psi_start(struct fuse2fs *ff)
+{
+	if (psi_active(ff->mem_psi))
+		psi_start_thread(ff->mem_psi);
+}
+
+static void fuse2fs_psi_destroy(struct fuse2fs *ff)
+{
+	if (!psi_active(ff->mem_psi))
+		return;
+
+	psi_del_handler(ff->mem_psi, &ff->mem_psi_handler);
+	psi_destroy(&ff->mem_psi);
+}
+
 static inline struct fuse2fs *fuse2fs_get(void)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -1569,6 +1640,11 @@ static errcode_t fuse2fs_config_cache(struct fuse2fs *ff)
 		return err;
 	}
 
+	if (psi_active(ff->mem_psi)) {
+		snprintf(buf, sizeof(buf), "cache_auto_shrink=off");
+		err = io_channel_set_options(ff->fs->io, buf);
+	}
+
 	return 0;
 }
 
@@ -1935,6 +2011,7 @@ static void *op_init(struct fuse_conn_info *conn,
 	 * conveyed to the new child process.
 	 */
 	fuse2fs_mmp_start(ff);
+	fuse2fs_psi_start(ff);
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
 	/*
@@ -7619,6 +7696,12 @@ int main(int argc, char *argv[])
 	try_set_io_flusher(&fctx);
 	try_adjust_oom_score(&fctx);
 
+	err = fuse2fs_psi_config(&fctx);
+	if (err) {
+		ret |= 32;
+		goto out;
+	}
+
 	/* Will we allow users to allocate every last block? */
 	if (getenv("FUSE2FS_ALLOC_ALL_BLOCKS")) {
 		log_printf(&fctx, "%s\n",
@@ -7708,6 +7791,7 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
+	fuse2fs_psi_destroy(&fctx);
 	fuse2fs_mmp_destroy(&fctx);
 	fuse2fs_unmount(&fctx);
 	reset_com_err_hook();


