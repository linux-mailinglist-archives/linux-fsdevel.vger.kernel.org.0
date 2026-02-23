Return-Path: <linux-fsdevel+bounces-78135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDDUALDjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6317F8C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9054430216D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD6E37F8D4;
	Mon, 23 Feb 2026 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+qAF9uh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3337F8C6;
	Mon, 23 Feb 2026 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889497; cv=none; b=tP8knfSyifavTO69c7olbsv95OruAM0094O4bw5DWfJAeofpInhQbrKKwGbRY6tlPDsHqb5hPvo56TdIys2fIxd8aNEx6RcbemnLw/v7m7VPQkGtLXhW4rXoWVxqxokTj4qsCK8a1/CBsqUleY1EUaIV5ozLFNPVk1UWqENiFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889497; c=relaxed/simple;
	bh=4UaVdUNlHZgAxWEV/ASUbB0qW7VYozTUpdFZoYFxsgs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Am2pumfsfwFImQEw2Qm0trJlujG5FwWNDsGapIrro8136ssFURVpL92wiUhGKI23m/p5vMaiTLxTgi4JisoIyVMhYF+Xn6r8bZn+eCXEVC01bhnVQQKzXCRf1RUgywo8X0ffMNaOQfbaKcfnnmOWGiSIXpmkTSGuOu794wIDa3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+qAF9uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EA8C116C6;
	Mon, 23 Feb 2026 23:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889497;
	bh=4UaVdUNlHZgAxWEV/ASUbB0qW7VYozTUpdFZoYFxsgs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=m+qAF9uh3C9zW3/6+sqHBsQx88BrkzAeBqW/F75UEq96ONau+LhAkmLrDevPzeKeE
	 PAX4JapvPBlkY9M6ws/JBz9G3ySRRTtD/8UqDrN3r999cPdNinmlGzmzcp7xARS2Zv
	 pV5d2dj/xydYZEuC6TMk4B4zK/2guRCNR98cS0fYkIf9OjhEOoGldh97sGFD6RHoQE
	 1XhsLJ65e+bSWOHatTb4uRzappIUr75/CRTwZU224ixHsKWFwAcT+Y7Y8Fzw5OOKbe
	 /g55yqxpQDG6NP5EypXvGvZFpkjqumHetTFPR13+PEkeG0WUesyd7GEi3ukhtcMVsN
	 0revZ0xkOFZaQ==
Date: Mon, 23 Feb 2026 15:31:36 -0800
Subject: [PATCH 24/25] libfuse: add lower-level filesystem freeze, thaw,
 and shutdown requests
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740362.3940670.17142611826291475491.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78135-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24C6317F8C5
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Pass the kernel's filesystem freeze, thaw, and shutdown requests through
to low level fuse servers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |   12 +++++++++
 include/fuse_lowlevel.h |   35 +++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   60 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 0779e3917a1e8f..ff21973e1c88f7 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -682,6 +682,10 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_FREEZE_FS		= 4089,
+	FUSE_UNFREEZE_FS	= 4090,
+	FUSE_SHUTDOWN_FS	= 4091,
+
 	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
@@ -1238,6 +1242,14 @@ struct fuse_syncfs_in {
 	uint64_t	padding;
 };
 
+struct fuse_freezefs_in {
+	uint64_t	unlinked;
+};
+
+struct fuse_shutdownfs_in {
+	uint64_t	flags;
+};
+
 /*
  * For each security context, send fuse_secctx with size of security context
  * fuse_secctx will be followed by security context name and this in turn
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index e2127c40940640..0d7577718490ba 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1439,6 +1439,41 @@ struct fuse_lowlevel_ops {
 	 */
 	void (*iomap_config) (fuse_req_t req, uint64_t flags,
 			      uint64_t maxbytes);
+
+	/**
+	 * Freeze the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 * @param unlinked count of open unlinked inodes
+	 */
+	void (*freezefs) (fuse_req_t req, fuse_ino_t ino, uint64_t unlinked);
+
+	/**
+	 * Thaw the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 */
+	void (*unfreezefs) (fuse_req_t req, fuse_ino_t ino);
+
+	/**
+	 * Shut down the filesystem
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the root inode number
+	 * @param flags zero, currently
+	 */
+	void (*shutdownfs) (fuse_req_t req, fuse_ino_t ino, uint64_t flags);
 };
 
 /**
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index a6b65ccf9fe1df..18503a1fa64d88 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2917,6 +2917,60 @@ static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_config(req, nodeid, inarg, NULL);
 }
 
+static void _do_freezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	const struct fuse_freezefs_in *inarg = op_in;
+	(void)in_payload;
+
+	if (req->se->op.freezefs)
+		req->se->op.freezefs(req, nodeid, inarg->unlinked);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_freezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_freezefs(req, nodeid, inarg, NULL);
+}
+
+static void _do_unfreezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	(void)op_in;
+	(void)in_payload;
+
+	if (req->se->op.unfreezefs)
+		req->se->op.unfreezefs(req, nodeid);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_unfreezefs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_unfreezefs(req, nodeid, inarg, NULL);
+}
+
+static void _do_shutdownfs(fuse_req_t req, const fuse_ino_t nodeid,
+			 const void *op_in, const void *in_payload)
+{
+	const struct fuse_shutdownfs_in *inarg = op_in;
+	(void)in_payload;
+
+	if (req->se->op.shutdownfs)
+		req->se->op.shutdownfs(req, nodeid, inarg->flags);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_shutdownfs(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *inarg)
+{
+	_do_shutdownfs(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3925,6 +3979,9 @@ static struct {
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_SYNCFS]	   = { do_syncfs,      "SYNCFS"      },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_FREEZE_FS]   = { do_freezefs,	"FREEZE"     },
+	[FUSE_UNFREEZE_FS] = { do_unfreezefs,	"UNFREEZE"   },
+	[FUSE_SHUTDOWN_FS] = { do_shutdownfs,	"SHUTDOWN"   },
 	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
@@ -3986,6 +4043,9 @@ static struct {
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_FREEZE_FS]	= { _do_freezefs,	"FREEZE" },
+	[FUSE_UNFREEZE_FS]	= { _do_unfreezefs,	"UNFREEZE" },
+	[FUSE_SHUTDOWN_FS]	= { _do_shutdownfs,	"SHUTDOWN" },
 	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },


