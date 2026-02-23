Return-Path: <linux-fsdevel+bounces-78170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKfUGk/mnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E817FDB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AFA230B7754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B6037FF4D;
	Mon, 23 Feb 2026 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH1q2z7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7411E9906;
	Mon, 23 Feb 2026 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890046; cv=none; b=U7QHgKuYb0/BTCp1/Em0tH+8euHEQ1OxLKsd2mWzUAgwZikx1oKKWelx6expw8jxaYvcvHPz+bml8AeZt+X+GGBD1cH8GsUCVyPhhGO6qfn81WlDeFL5Py0sTuYOZ7LfhhP82X/eyvZGaDrvAp0N3YiISRk+fzdcr4G2lUR5dJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890046; c=relaxed/simple;
	bh=/9YrKbT1Yll5lu37hT9MwYJOVGra563eoWxULLsgGW4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoZ46/IGBQlFsQ7T1mWaOCP71gEqoH7GAQuYJiE2DJdbWgfAGFNM0WvqjfVgqRQxYOJJ+oV7KuK6SsK/lvuLmcEbE0+Y1eoYRSXL0xPiw+sjLjdXV0EBr4ZAnhnFGenXBs3YD1ZSRQxFhngKiWcaY2GkxxIVwCONzOAH+ZeVNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH1q2z7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21255C19421;
	Mon, 23 Feb 2026 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890046;
	bh=/9YrKbT1Yll5lu37hT9MwYJOVGra563eoWxULLsgGW4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FH1q2z7Sx5HpENT1Ie4/STOJ1hSDOF9l/0vIdiqDws+fT1IsY7iQtSskouKV4+sOX
	 f/855jljKXccEaF/y6VGzgsgbQnf6mft7k2jKLEk+3OdZv1LuWAlpC+9m+U8JatizR
	 OPg5hmDS33bT7TpjUl8LPvm2i40f4bHMmysB5m0c/ECKxtBWrRw539cLopwj8b5SvL
	 z5C4cbq9iajqk1YchD/d6NpBRSwDmrWjEEZC4tJjKnjG7SVgmKMblTy7UWxV0wgP3a
	 c5duPIrFlPE0Re1QyUghVEwmKkxSLflNG/4qXDR5v2N+UtSFTmPob8IxykWUYZVseE
	 pOtIFaD7TRk+Q==
Date: Mon, 23 Feb 2026 15:40:45 -0800
Subject: [PATCH 18/19] fuse4fs: disable fs reclaim and write throttling
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744804.3943178.14306714883633979460.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78170-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 086E817FDB8
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Ask the kernel if we can disable fs reclaim and write throttling.

Disabling fs reclaim prevents livelocks where the fuse server can
allocate memory, fault into the kernel, and then the allocation tries to
initiate writeback by calling back into the same fuse server.

Disabling BDI write throttling means that writeback won't be throttled
by metadata writes to the filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 77207bae19e544..4499f4083f85dd 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -7737,6 +7737,19 @@ static void try_set_io_flusher(struct fuse4fs *ff)
 #endif
 }
 
+/* Undo try_set_io_flusher */
+static void try_clear_io_flusher(struct fuse4fs *ff)
+{
+#ifdef HAVE_PR_SET_IO_FLUSHER
+	/*
+	 * zero ret means it's already set, negative means we can't even
+	 * look at the value so don't bother clearing it
+	 */
+	if (prctl(PR_GET_IO_FLUSHER, 0, 0, 0, 0) > 0)
+		prctl(PR_SET_IO_FLUSHER, 0, 0, 0, 0);
+#endif
+}
+
 /* Try to adjust the OOM score so that we don't get killed */
 static void try_adjust_oom_score(struct fuse4fs *ff)
 {
@@ -7842,12 +7855,27 @@ static int fuse4fs_main(struct fuse_args *args, struct fuse4fs *ff)
 	fuse_loop_cfg_set_idle_threads(loop_config, opts.max_idle_threads);
 	fuse_loop_cfg_set_max_threads(loop_config, 4);
 
+	/*
+	 * Try to set ourselves up with fs reclaim disabled to prevent
+	 * recursive reclaim and throttling.  This must be done before starting
+	 * the worker threads so that they inherit the process flags.
+	 */
+	ret = fuse_lowlevel_disable_fsreclaim(ff->fuse, 1);
+	if (ret) {
+		err_printf(ff, "%s: %s.\n",
+ _("Could not register as FS flusher thread"),
+			   strerror(errno));
+		try_set_io_flusher(ff);
+		ret = 0;
+	}
+
 	if (fuse_session_loop_mt(se, loop_config) != 0) {
 		ret = 8;
-		goto out_loopcfg;
+		goto out_flusher;
 	}
 
-out_loopcfg:
+out_flusher:
+	try_clear_io_flusher(ff);
 	fuse_loop_cfg_destroy(loop_config);
 out_remove_signal_handlers:
 	fuse_remove_signal_handlers(se);
@@ -7925,7 +7953,6 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	try_set_io_flusher(&fctx);
 	try_adjust_oom_score(&fctx);
 
 	/* Will we allow users to allocate every last block? */


