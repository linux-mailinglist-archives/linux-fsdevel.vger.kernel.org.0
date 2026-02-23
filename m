Return-Path: <linux-fsdevel+bounces-78171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMw+FVzmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD917FDD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2B9A30BF857
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8D37F8DA;
	Mon, 23 Feb 2026 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1ur0U0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B437F8DC;
	Mon, 23 Feb 2026 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890061; cv=none; b=S2G0XxBT73JXs00NwjsR+lhGayeGju3RcS+Q4DLf5pwPT3245gHV7xBNLEbzWQD4aVaQ2U6HaOmL3jlz9yfCRAz1KauvJ3TdRHhs0N7SDJ6wd/7APKo9zPsCb4A3LbWP9MnVaz4w/ueTfFRd4QZ+GjPxuxq9UjoqpLqpQ7MP9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890061; c=relaxed/simple;
	bh=qTFs1CcReAsIhdOCN/88qiDJg4FfrkNzfBuASz5DxPg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMvAjT/ft5Msyz3sz5Q26YqbazMiOwspd+Dke6jv/sZUzhOyokmYRRN3TsVTkgvcaUxhJLBTy7MFTUk02YwqeWT80qEkrNJvd04HFIgQ8Qy2K67Po4VNliK0xlSnZuH/Kd73VF5hrCPVZ0g0iZUtAhM6z18EgrjcDhCL5OQ4OY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1ur0U0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF3C116C6;
	Mon, 23 Feb 2026 23:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890061;
	bh=qTFs1CcReAsIhdOCN/88qiDJg4FfrkNzfBuASz5DxPg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Y1ur0U0UJ9ZOcSSorazhV2U3vBnpYgA/ppTNjAAt7m5wO+sTBfd/uN5PytUhWln3d
	 +fGJ2KzGUMBVkeSk+dygaLHjEHTCYo59bvs7QeOkQ7JoNZlCpyFfbFOpqSsaxc9mBJ
	 xvUHhBfl6g4Ymtfr6qiDlsqaIhbc8tbig8/sH2W8MmMuaYD9/IV0dh39GvO0kFA0fv
	 zxRO4+JPL4TOez2inccTz0Vg4Q9nMDGvQFgxUt1OmJyb8Yk+4pxa/VLFyh9E6aGtrY
	 cHRSbbCyMMnBwcqCoIe9GEOUn+DLpHNU2WTifL/bo1xAt0LiXdPHhPmvsqZOGeCmjR
	 fySJo01AlKQhA==
Date: Mon, 23 Feb 2026 15:41:01 -0800
Subject: [PATCH 19/19] fuse2fs: implement freeze and shutdown requests
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744822.3943178.4419152071339815367.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78171-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 07BD917FDD5
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Handle freezing and shutting down the filesystem if requested.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   84 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 4499f4083f85dd..170accabfd9fd6 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -228,6 +228,7 @@ struct fuse4fs_file_handle {
 
 enum fuse4fs_opstate {
 	F4OP_READONLY,
+	F4OP_WRITABLE_FROZEN,
 	F4OP_WRITABLE,
 	F4OP_SHUTDOWN,
 };
@@ -6166,6 +6167,91 @@ static void op_fallocate(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 }
 #endif /* SUPPORT_FALLOCATE */
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+static void op_freezefs(fuse_req_t req, fuse_ino_t ino, uint64_t unlinked)
+{
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	fs = fuse4fs_start(ff);
+
+	if (ff->opstate == F4OP_WRITABLE) {
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		else if (!unlinked)
+			fs->super->s_state |= EXT2_VALID_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_set_gdt_csum(fs);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		err = ext2fs_flush2(fs, 0);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		ff->opstate = F4OP_WRITABLE_FROZEN;
+	}
+
+out_unlock:
+	fs->super->s_state &= ~EXT2_VALID_FS;
+	fuse4fs_finish(ff, ret);
+	fuse_reply_err(req, -ret);
+}
+
+static void op_unfreezefs(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	fs = fuse4fs_start(ff);
+
+	if (ff->opstate == F4OP_WRITABLE_FROZEN) {
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		fs->super->s_state &= ~EXT2_VALID_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_set_gdt_csum(fs);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		err = ext2fs_flush2(fs, 0);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		ff->opstate = F4OP_WRITABLE;
+	}
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	fuse_reply_err(req, -ret);
+}
+
+static void op_shutdownfs(fuse_req_t req, fuse_ino_t ino, uint64_t flags)
+{
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
+	int ret;
+
+	ret = ioctl_shutdown(ff, ctxt, NULL, NULL, 0);
+
+	fuse_reply_err(req, -ret);
+}
+#endif
+
 #ifdef HAVE_FUSE_IOMAP
 static void fuse4fs_iomap_hole(struct fuse4fs *ff, struct fuse_file_iomap *iomap,
 			       off_t pos, uint64_t count)
@@ -7461,6 +7547,11 @@ static struct fuse_lowlevel_ops fs_ops = {
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
 	.statx = op_statx,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+	.freezefs = op_freezefs,
+	.unfreezefs = op_unfreezefs,
+	.shutdownfs = op_shutdownfs,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6266c1de163694..4535bb16efd586 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -222,6 +222,7 @@ struct fuse2fs_file_handle {
 
 enum fuse2fs_opstate {
 	F2OP_READONLY,
+	F2OP_WRITABLE_FROZEN,
 	F2OP_WRITABLE,
 	F2OP_SHUTDOWN,
 };
@@ -5700,6 +5701,86 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 }
 #endif /* SUPPORT_FALLOCATE */
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+static int op_freezefs(const char *path, uint64_t unlinked)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fs = fuse2fs_start(ff);
+
+	if (ff->opstate == F2OP_WRITABLE) {
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		else if (!unlinked)
+			fs->super->s_state |= EXT2_VALID_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_set_gdt_csum(fs);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		err = ext2fs_flush2(fs, 0);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		ff->opstate = F2OP_WRITABLE_FROZEN;
+	}
+
+out_unlock:
+	fs->super->s_state &= ~EXT2_VALID_FS;
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_unfreezefs(const char *path)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fs = fuse2fs_start(ff);
+
+	if (ff->opstate == F2OP_WRITABLE_FROZEN) {
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_set_gdt_csum(fs);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		err = ext2fs_flush2(fs, 0);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		ff->opstate = F2OP_WRITABLE;
+	}
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_shutdownfs(const char *path, uint64_t flags)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+
+	return ioctl_shutdown(ff, NULL, NULL);
+}
+#endif
+
 #ifdef HAVE_FUSE_IOMAP
 static void fuse2fs_iomap_hole(struct fuse2fs *ff, struct fuse_file_iomap *iomap,
 			       off_t pos, uint64_t count)
@@ -6984,6 +7065,9 @@ static struct fuse_operations fs_ops = {
 #endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
 	.getattr_iflags = op_getattr_iflags,
+	.freezefs = op_freezefs,
+	.unfreezefs = op_unfreezefs,
+	.shutdownfs = op_shutdownfs,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,


