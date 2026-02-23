Return-Path: <linux-fsdevel+bounces-78181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE/gA/rmnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:47:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E017FF30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34B7C3072A50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087537FF61;
	Mon, 23 Feb 2026 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaTHxCpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2BB36B054;
	Mon, 23 Feb 2026 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890203; cv=none; b=WXmFR+2UNcbLTtqooer9kKK9GoWEd0los9wMX6V3kHvKNB2o3yEJ2oe5KhEVVZk6omqxAN91v5pl0Ac7fAT9gVGuX4NEm6P64QzaMYsfVOENJE4gwQiJav6FczM7U+ysWumA+8cY7f4y8v9IVrkHJe0bv6YqxFT5UYanAifJdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890203; c=relaxed/simple;
	bh=PwISGcD74LGtisq2JPGhebPVoV7t7tWQqeQ95xpupPw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6sQFaWQLEd2KG4wD9H7lwxMpBg3SJXui2Fs8diVqAkonHreEyrSHW3xbNcq2S2aaA7yn0MsH/TDAYfOwMI+rgz2NWWvSIaO/CkCcp/N1itv8B+mf34Kjy2zf6VoyNazuL4F1jZ7XWHqzSF3mIQw9visrupEkB2Qq7X4CqxesOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaTHxCpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6183C116C6;
	Mon, 23 Feb 2026 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890202;
	bh=PwISGcD74LGtisq2JPGhebPVoV7t7tWQqeQ95xpupPw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FaTHxCplPYVcTijsOSRdzthcrjThXjpW2GtT3lDv+zcN0hfi0QtcHdrhzGHWXeplM
	 qe26UBjqUHESI3Q68wC5b+oNnhs3fY2gpDdkkqJ2kS5sLbmzUdxzyoxyO1Suyj5vcA
	 VYZaW9Xv2PAvLM026TAb0L2Vx8iIiVJLjLH9mLnB+WWSCxsqR/TdiUll72wq6Y+xbI
	 l98BxyH00hnd/kIpoI0DUyLJ7C9CnSTQlQRq5//WxMkDLTCDHz4mIG7+DvFKMsHQ8x
	 1CACWtQ3a/wS8q1dB0WVCUjdcYecOzCo7C5WsmdYRvfwC36krApdFxl+uTij4eq9cY
	 4ENphopK5YM6A==
Date: Mon, 23 Feb 2026 15:43:22 -0800
Subject: [PATCH 08/10] fuse2fs: enable syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745324.3944028.5382330800711547077.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78181-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 9B4E017FF30
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Enable syncfs calls in fuse2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   32 ++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 6cda267ad5cf40..3d48eb79948ad3 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6284,7 +6284,38 @@ static void op_shutdownfs(fuse_req_t req, fuse_ino_t ino, uint64_t flags)
 	int ret;
 
 	ret = ioctl_shutdown(ff, ctxt, NULL, NULL, 0);
+	fuse_reply_err(req, -ret);
+}
 
+static void op_syncfs(fuse_req_t req, fuse_ino_t ino)
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
+	}
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
 	fuse_reply_err(req, -ret);
 }
 #endif
@@ -7588,6 +7619,7 @@ static struct fuse_lowlevel_ops fs_ops = {
 	.freezefs = op_freezefs,
 	.unfreezefs = op_unfreezefs,
 	.shutdownfs = op_shutdownfs,
+	.syncfs = op_syncfs,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b11ffec3603bf9..f7c759ed86c7fb 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5842,6 +5842,39 @@ static int op_shutdownfs(const char *path, uint64_t flags)
 
 	return ioctl_shutdown(ff, NULL, NULL);
 }
+
+static int op_syncfs(const char *path)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	fs = fuse2fs_start(ff);
+
+	if (ff->opstate == F2OP_WRITABLE) {
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
+	}
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
 #endif
 
 #ifdef HAVE_FUSE_IOMAP
@@ -7131,6 +7164,7 @@ static struct fuse_operations fs_ops = {
 	.freezefs = op_freezefs,
 	.unfreezefs = op_unfreezefs,
 	.shutdownfs = op_shutdownfs,
+	.syncfs = op_syncfs,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,


