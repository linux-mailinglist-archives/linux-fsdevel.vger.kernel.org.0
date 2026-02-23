Return-Path: <linux-fsdevel+bounces-78204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICwdClHonGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:52:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB5A1800FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9714031B58E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A53803CD;
	Mon, 23 Feb 2026 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekgjl32C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D631F09B3;
	Mon, 23 Feb 2026 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890562; cv=none; b=Uo9ydduI4ZZsVjzhaPJX5SL9i+7PutT7a8SuDkGRbjRmnb6rkULr0K2qLuPpBIWkfkuPSl5529eSslztpgouvQgZrsTDgG3wgpcaQjylBKAB2sG5oZ9a9ma49sLSepIeWyyV/b6CAiDJax3t/0nGN4tcpybWghUGZ5W3DIyapms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890562; c=relaxed/simple;
	bh=6YOVE+L1nMiDMzqQCRPBLr4aMqgc7xOYiJTiFvvWzpw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACWpW0RooEE0IUllVI08ty1nN86uJ11N5JiEsEgwyeZ2PBM/SC2GltZ3wJeYXLNnS16lTaQO/fC1oqIk+mj0eHrJAK1rjSoz3EujVguHWdQyITAoQ1l0887nWvhVBgj2MbCH0XvRD4RJE0MhCuncYtXKeRelAqCK5khrzRdGgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekgjl32C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AA8C116C6;
	Mon, 23 Feb 2026 23:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890562;
	bh=6YOVE+L1nMiDMzqQCRPBLr4aMqgc7xOYiJTiFvvWzpw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ekgjl32CwylAWIIg0Sxr+ifAE6X9hCEdn80BptONW0i8LMs7fjKlzjixKGE5bVJv3
	 evLzIQl0ZZR8NwzKBAH5qOAJSFkr621GCTeldTmKgXldA9ZKthjif+nNCk2jrpzouJ
	 u5CmOeP1G5yD3RyWJBOHXkCpiYFXYgC82Gh13a+NX95e3KzHdKHY9eKlqdsjOYN16i
	 Gq4EUSrU3bCrUdCJDnGXRRrbIHFcszTxq2P5O21HczmKfOuYjDR1H52O3VgKTxBEyc
	 qXm8+LuTiFAJl3TUwvvpzi+lpK8+E7t0W1R83Wc7ztlgil6G5hziZgwJQ5rgW35+xc
	 QITzXcgClKIiw==
Date: Mon, 23 Feb 2026 15:49:21 -0800
Subject: [PATCH 4/4] fuse2fs: flush dirty metadata periodically
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746307.3945260.15568333253665196839.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78204-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 7EB5A1800FE
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Flush dirty metadata out to disk periodically like the kernel, to reduce
the potential for data loss if userspace doesn't explicitly fsync.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++++----
 misc/fuse2fs.c    |  112 +++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 206 insertions(+), 18 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 4d48521fa8f763..1fbf5e48af8724 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <assert.h>
+#include <limits.h>
 #ifdef HAVE_FUSE_LOOPDEV
 # include <fuse_loopdev.h>
 #endif
@@ -332,6 +333,10 @@ struct fuse4fs {
 #endif
 	struct psi *mem_psi;
 	struct psi_handler *mem_psi_handler;
+
+	struct bthread *flush_thread;
+	unsigned int flush_interval;
+	double last_flush;
 };
 
 #ifdef HAVE_FUSE_SERVICE
@@ -1007,6 +1012,71 @@ fuse4fs_set_handle(struct fuse_file_info *fp, struct fuse4fs_file_handle *fh)
 	fp->keep_cache = 1;
 }
 
+static errcode_t fuse4fs_flush(struct fuse4fs *ff, int flags)
+{
+	double last_flush = gettime_monotonic();
+	errcode_t err;
+
+	err = ext2fs_flush2(ff->fs, flags);
+	if (err)
+		return err;
+
+	ff->last_flush = last_flush;
+	return 0;
+}
+
+static inline int fuse4fs_flush_wanted(struct fuse4fs *ff)
+{
+	return ff->fs != NULL && ff->opstate == F4OP_WRITABLE &&
+	       ff->last_flush + ff->flush_interval <= gettime_monotonic();
+}
+
+static void fuse4fs_flush_bthread(void *data)
+{
+	struct fuse4fs *ff = data;
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	fs = fuse4fs_start(ff);
+	if (fuse4fs_flush_wanted(ff) && !bthread_cancelled(ff->flush_thread)) {
+		err = fuse4fs_flush(ff, 0);
+		if (err)
+			ret = translate_error(fs, 0, err);
+	}
+	fuse4fs_finish(ff, ret);
+}
+
+static void fuse4fs_flush_start(struct fuse4fs *ff)
+{
+	int ret;
+
+	if (!ff->flush_interval)
+		return;
+
+	ret = bthread_create("fuse4fs_flush", fuse4fs_flush_bthread, ff,
+			     ff->flush_interval, &ff->flush_thread);
+	if (ret) {
+		err_printf(ff, "flusher: %s.\n", error_message(ret));
+		return;
+	}
+
+	ret = bthread_start(ff->flush_thread);
+	if (ret)
+		err_printf(ff, "flusher: %s.\n", error_message(ret));
+}
+
+static void fuse4fs_flush_cancel(struct fuse4fs *ff)
+{
+	if (ff->flush_thread)
+		bthread_cancel(ff->flush_thread);
+}
+
+static void fuse4fs_flush_destroy(struct fuse4fs *ff)
+{
+	bthread_destroy(&ff->flush_thread);
+}
+
 #ifdef HAVE_FUSE_IOMAP
 static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
 {
@@ -2240,7 +2310,7 @@ static int fuse4fs_mount(struct fuse4fs *ff)
 		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
 		fs->super->s_state &= ~EXT2_VALID_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_flush2(fs, 0);
+		err = fuse4fs_flush(ff, 0);
 		if (err)
 			return translate_error(fs, 0, err);
 	}
@@ -2268,7 +2338,7 @@ static void op_destroy(void *userdata)
 		if (err)
 			translate_error(fs, 0, err);
 
-		err = ext2fs_flush2(fs, 0);
+		err = fuse4fs_flush(ff, 0);
 		if (err)
 			translate_error(fs, 0, err);
 	}
@@ -2291,6 +2361,7 @@ static void op_destroy(void *userdata)
 	 * that the block device will be released before umount(2) returns.
 	 */
 	if (ff->iomap_state == IOMAP_ENABLED) {
+		fuse4fs_flush_cancel(ff);
 		fuse4fs_mmp_cancel(ff);
 		fuse4fs_unmount(ff);
 	}
@@ -2507,6 +2578,7 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 	 */
 	fuse4fs_mmp_start(ff);
 	fuse4fs_psi_start(ff);
+	fuse4fs_flush_start(ff);
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
 	/*
@@ -3064,7 +3136,7 @@ static inline int fuse4fs_dirsync_flush(struct fuse4fs *ff, ext2_ino_t ino,
 		*flushed = 0;
 	return 0;
 flush:
-	err = ext2fs_flush2(fs, 0);
+	err = fuse4fs_flush(ff, 0);
 	if (err)
 		return translate_error(fs, 0, err);
 
@@ -4936,7 +5008,7 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 	if ((fp->flags & O_SYNC) &&
 	    fuse4fs_is_writeable(ff) &&
 	    (fh->open_flags & EXT2_FILE_WRITE)) {
-		err = ext2fs_flush2(fs, EXT2_FLAG_FLUSH_NO_SYNC);
+		err = fuse4fs_flush(ff, EXT2_FLAG_FLUSH_NO_SYNC);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
@@ -4967,7 +5039,7 @@ static void op_fsync(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 	fs = fuse4fs_start(ff);
 	/* For now, flush everything, even if it's slow */
 	if (fuse4fs_is_writeable(ff) && fh->open_flags & EXT2_FILE_WRITE) {
-		err = ext2fs_flush2(fs, 0);
+		err = fuse4fs_flush(ff, 0);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
@@ -6294,6 +6366,7 @@ static int ioctl_shutdown(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	err_printf(ff, "%s.\n", _("shut down requested"));
 
+	fuse4fs_flush_cancel(ff);
 	fuse4fs_mmp_cancel(ff);
 
 	/*
@@ -6302,7 +6375,7 @@ static int ioctl_shutdown(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	 * any of the flags.  Flush whatever is dirty and shut down.
 	 */
 	if (ff->opstate == F4OP_WRITABLE)
-		ext2fs_flush2(fs, 0);
+		fuse4fs_flush(ff, 0);
 	ff->opstate = F4OP_SHUTDOWN;
 	fs->flags &= ~EXT2_FLAG_RW;
 
@@ -6717,7 +6790,7 @@ static void op_freezefs(fuse_req_t req, fuse_ino_t ino, uint64_t unlinked)
 			goto out_unlock;
 		}
 
-		err = ext2fs_flush2(fs, 0);
+		err = fuse4fs_flush(ff, 0);
 		if (err) {
 			ret = translate_error(fs, 0, err);
 			goto out_unlock;
@@ -6753,7 +6826,7 @@ static void op_unfreezefs(fuse_req_t req, fuse_ino_t ino)
 			goto out_unlock;
 		}
 
-		err = ext2fs_flush2(fs, 0);
+		err = fuse4fs_flush(ff, 0);
 		if (err) {
 			ret = translate_error(fs, 0, err);
 			goto out_unlock;
@@ -6797,7 +6870,7 @@ static void op_syncfs(fuse_req_t req, fuse_ino_t ino)
 			goto out_unlock;
 		}
 
-		err = ext2fs_flush2(fs, 0);
+		err = fuse4fs_flush(ff, 0);
 		if (err) {
 			ret = translate_error(fs, 0, err);
 			goto out_unlock;
@@ -8176,6 +8249,7 @@ enum {
 	FUSE4FS_CACHE_SIZE,
 	FUSE4FS_DIRSYNC,
 	FUSE4FS_ERRORS_BEHAVIOR,
+	FUSE4FS_FLUSH_INTERVAL,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE4FS_IOMAP,
 	FUSE4FS_IOMAP_PASSTHROUGH,
@@ -8204,6 +8278,7 @@ static struct fuse_opt fuse4fs_opts[] = {
 #ifdef HAVE_CLOCK_MONOTONIC
 	FUSE4FS_OPT("timing",		timing,			1),
 #endif
+	FUSE_OPT_KEY("flush_interval=%s", FUSE4FS_FLUSH_INTERVAL),
 #ifdef HAVE_FUSE_IOMAP
 	FUSE4FS_OPT("iomap_cache",	iomap_cache,		1),
 	FUSE4FS_OPT("noiomap_cache",	iomap_cache,		0),
@@ -8287,6 +8362,21 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 
 		/* do not pass through to libfuse */
 		return 0;
+	case FUSE4FS_FLUSH_INTERVAL:
+		char *p;
+		unsigned long val;
+
+		errno = 0;
+		val = strtoul(arg + 15, &p, 0);
+		if (p != arg + strlen(arg) || errno || val > UINT_MAX) {
+			fprintf(stderr, "%s: %s.\n", arg,
+				_("Unrecognized flush interval"));
+			return -1;
+		}
+
+		/* do not pass through to libfuse */
+		ff->flush_interval = val;
+		return 0;
 #ifdef HAVE_FUSE_IOMAP
 	case FUSE4FS_IOMAP:
 		if (strcmp(arg, "iomap") == 0 || strcmp(arg + 6, "1") == 0)
@@ -8334,6 +8424,7 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 #ifdef HAVE_FUSE_IOMAP
 	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
 #endif
+	"    -o flush=<time>        flush dirty metadata on this interval\n"
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE4FS_HELPFULL) {
@@ -8643,6 +8734,7 @@ int main(int argc, char *argv[])
 		.loop_fd = -1,
 #endif
 		.translate_inums = 1,
+		.flush_interval = 30,
 #ifdef HAVE_FUSE_SERVICE
 		.bdev_fd = -1,
 		.fusedev_fd = -1,
@@ -8829,6 +8921,7 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
+	fuse4fs_flush_destroy(&fctx);
 	fuse4fs_psi_destroy(&fctx);
 	fuse4fs_mmp_destroy(&fctx);
 	fuse4fs_unmount(&fctx);
@@ -9007,6 +9100,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
  _("Remounting read-only due to errors."));
 			ff->opstate = F4OP_READONLY;
 		}
+		fuse4fs_flush_cancel(ff);
 		fuse4fs_mmp_cancel(ff);
 		fs->flags &= ~EXT2_FLAG_RW;
 		break;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f2929ae0045bc9..ac6de48b008433 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -26,6 +26,7 @@
 #include <sys/sysmacros.h>
 #include <unistd.h>
 #include <ctype.h>
+#include <limits.h>
 #ifdef HAVE_FUSE_LOOPDEV
 # include <fuse_loopdev.h>
 #endif
@@ -309,6 +310,10 @@ struct fuse2fs {
 #endif
 	struct psi *mem_psi;
 	struct psi_handler *mem_psi_handler;
+
+	struct bthread *flush_thread;
+	unsigned int flush_interval;
+	double last_flush;
 };
 
 #define FUSE2FS_CHECK_HANDLE(ff, fh) \
@@ -812,6 +817,71 @@ fuse2fs_set_handle(struct fuse_file_info *fp, struct fuse2fs_file_handle *fh)
 	fp->fh = (uintptr_t)fh;
 }
 
+static errcode_t fuse2fs_flush(struct fuse2fs *ff, int flags)
+{
+	double last_flush = gettime_monotonic();
+	errcode_t err;
+
+	err = ext2fs_flush2(ff->fs, flags);
+	if (err)
+		return err;
+
+	ff->last_flush = last_flush;
+	return 0;
+}
+
+static inline int fuse2fs_flush_wanted(struct fuse2fs *ff)
+{
+	return ff->fs != NULL && ff->opstate == F2OP_WRITABLE &&
+	       ff->last_flush + ff->flush_interval <= gettime_monotonic();
+}
+
+static void fuse2fs_flush_bthread(void *data)
+{
+	struct fuse2fs *ff = data;
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	fs = fuse2fs_start(ff);
+	if (fuse2fs_flush_wanted(ff) && !bthread_cancelled(ff->flush_thread)) {
+		err = fuse2fs_flush(ff, 0);
+		if (err)
+			ret = translate_error(fs, 0, err);
+	}
+	fuse2fs_finish(ff, ret);
+}
+
+static void fuse2fs_flush_start(struct fuse2fs *ff)
+{
+	int ret;
+
+	if (!ff->flush_interval)
+		return;
+
+	ret = bthread_create("fuse2fs_flush", fuse2fs_flush_bthread, ff,
+			     ff->flush_interval, &ff->flush_thread);
+	if (ret) {
+		err_printf(ff, "flusher: %s.\n", error_message(ret));
+		return;
+	}
+
+	ret = bthread_start(ff->flush_thread);
+	if (ret)
+		err_printf(ff, "flusher: %s.\n", error_message(ret));
+}
+
+static void fuse2fs_flush_cancel(struct fuse2fs *ff)
+{
+	if (ff->flush_thread)
+		bthread_cancel(ff->flush_thread);
+}
+
+static void fuse2fs_flush_destroy(struct fuse2fs *ff)
+{
+	bthread_destroy(&ff->flush_thread);
+}
+
 #ifdef HAVE_FUSE_IOMAP
 static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 {
@@ -1724,7 +1794,7 @@ static int fuse2fs_mount(struct fuse2fs *ff)
 		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
 		fs->super->s_state &= ~EXT2_VALID_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_flush2(fs, 0);
+		err = fuse2fs_flush(ff, 0);
 		if (err)
 			return translate_error(fs, 0, err);
 	}
@@ -1752,7 +1822,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		if (err)
 			translate_error(fs, 0, err);
 
-		err = ext2fs_flush2(fs, 0);
+		err = fuse2fs_flush(ff, 0);
 		if (err)
 			translate_error(fs, 0, err);
 	}
@@ -1775,6 +1845,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	 * that the block device will be released before umount(2) returns.
 	 */
 	if (ff->iomap_state == IOMAP_ENABLED) {
+		fuse2fs_flush_cancel(ff);
 		fuse2fs_mmp_cancel(ff);
 		fuse2fs_unmount(ff);
 	}
@@ -2012,6 +2083,7 @@ static void *op_init(struct fuse_conn_info *conn,
 	 */
 	fuse2fs_mmp_start(ff);
 	fuse2fs_psi_start(ff);
+	fuse2fs_flush_start(ff);
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
 	/*
@@ -2542,7 +2614,7 @@ static inline int fuse2fs_dirsync_flush(struct fuse2fs *ff, ext2_ino_t ino,
 		*flushed = 0;
 	return 0;
 flush:
-	err = ext2fs_flush2(fs, 0);
+	err = fuse2fs_flush(ff, 0);
 	if (err)
 		return translate_error(fs, 0, err);
 
@@ -4348,7 +4420,7 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	if ((fp->flags & O_SYNC) &&
 	    fuse2fs_is_writeable(ff) &&
 	    (fh->open_flags & EXT2_FILE_WRITE)) {
-		err = ext2fs_flush2(fs, EXT2_FLAG_FLUSH_NO_SYNC);
+		err = fuse2fs_flush(ff, EXT2_FLAG_FLUSH_NO_SYNC);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
@@ -4377,7 +4449,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	fs = fuse2fs_start(ff);
 	/* For now, flush everything, even if it's slow */
 	if (fuse2fs_is_writeable(ff) && fh->open_flags & EXT2_FILE_WRITE) {
-		err = ext2fs_flush2(fs, 0);
+		err = fuse2fs_flush(ff, 0);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
@@ -5487,6 +5559,7 @@ static int ioctl_shutdown(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	err_printf(ff, "%s.\n", _("shut down requested"));
 
+	fuse2fs_flush_cancel(ff);
 	fuse2fs_mmp_cancel(ff);
 
 	/*
@@ -5495,7 +5568,7 @@ static int ioctl_shutdown(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	 * any of the flags.  Flush whatever is dirty and shut down.
 	 */
 	if (ff->opstate == F2OP_WRITABLE)
-		ext2fs_flush2(fs, 0);
+		fuse2fs_flush(ff, 0);
 	ff->opstate = F2OP_SHUTDOWN;
 	fs->flags &= ~EXT2_FLAG_RW;
 
@@ -5893,7 +5966,7 @@ static int op_freezefs(const char *path, uint64_t unlinked)
 			goto out_unlock;
 		}
 
-		err = ext2fs_flush2(fs, 0);
+		err = fuse2fs_flush(ff, 0);
 		if (err) {
 			ret = translate_error(fs, 0, err);
 			goto out_unlock;
@@ -5928,7 +6001,7 @@ static int op_unfreezefs(const char *path)
 			goto out_unlock;
 		}
 
-		err = ext2fs_flush2(fs, 0);
+		err = fuse2fs_flush(ff, 0);
 		if (err) {
 			ret = translate_error(fs, 0, err);
 			goto out_unlock;
@@ -5970,7 +6043,7 @@ static int op_syncfs(const char *path)
 			goto out_unlock;
 		}
 
-		err = ext2fs_flush2(fs, 0);
+		err = fuse2fs_flush(ff, 0);
 		if (err) {
 			ret = translate_error(fs, 0, err);
 			goto out_unlock;
@@ -7330,6 +7403,7 @@ enum {
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
 	FUSE2FS_ERRORS_BEHAVIOR,
+	FUSE2FS_FLUSH_INTERVAL,
 #ifdef HAVE_FUSE_IOMAP
 	FUSE2FS_IOMAP,
 	FUSE2FS_IOMAP_PASSTHROUGH,
@@ -7358,6 +7432,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 #ifdef HAVE_CLOCK_MONOTONIC
 	FUSE2FS_OPT("timing",		timing,			1),
 #endif
+	FUSE_OPT_KEY("flush_interval=%s", FUSE2FS_FLUSH_INTERVAL),
 #ifdef HAVE_FUSE_IOMAP
 	FUSE2FS_OPT("iomap_cache",	iomap_cache,		1),
 	FUSE2FS_OPT("noiomap_cache",	iomap_cache,		0),
@@ -7441,6 +7516,21 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 
 		/* do not pass through to libfuse */
 		return 0;
+	case FUSE2FS_FLUSH_INTERVAL:
+		char *p;
+		unsigned long val;
+
+		errno = 0;
+		val = strtoul(arg + 15, &p, 0);
+		if (p != arg + strlen(arg) || errno || val > UINT_MAX) {
+			fprintf(stderr, "%s: %s.\n", arg,
+				_("Unrecognized flush interval"));
+			return -1;
+		}
+
+		/* do not pass through to libfuse */
+		ff->flush_interval = val;
+		return 0;
 #ifdef HAVE_FUSE_IOMAP
 	case FUSE2FS_IOMAP:
 		if (strcmp(arg, "iomap") == 0 || strcmp(arg + 6, "1") == 0)
@@ -7488,6 +7578,7 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 #ifdef HAVE_FUSE_IOMAP
 	"    -o iomap=              0 to disable iomap, 1 to enable iomap\n"
 #endif
+	"    -o flush=<time>        flush dirty metadata on this interval\n"
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -7647,6 +7738,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_LOOPDEV
 		.loop_fd = -1,
 #endif
+		.flush_interval = 30,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
@@ -7791,6 +7883,7 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
+	fuse2fs_flush_destroy(&fctx);
 	fuse2fs_psi_destroy(&fctx);
 	fuse2fs_mmp_destroy(&fctx);
 	fuse2fs_unmount(&fctx);
@@ -7968,6 +8061,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
  _("Remounting read-only due to errors."));
 			ff->opstate = F2OP_READONLY;
 		}
+		fuse2fs_flush_cancel(ff);
 		fuse2fs_mmp_cancel(ff);
 		fs->flags &= ~EXT2_FLAG_RW;
 		break;


