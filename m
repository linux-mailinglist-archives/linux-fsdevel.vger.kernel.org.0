Return-Path: <linux-fsdevel+bounces-78143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCFHNUbknGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:35:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250417F9D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E7430F61E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA837F8CE;
	Mon, 23 Feb 2026 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSSq0vVM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2237D101;
	Mon, 23 Feb 2026 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889622; cv=none; b=ZgPeBomSvRrUXohKm0EHP8LkPEGM95DlytG2E9gdkp5CE0BN+W2xmwvuV45CwljssgHAb549EIuzmxDKdakGdLEwdvkCNI1G4mKOofFe/Y8dFeuKaTwiheeBjmZHMXnXZlVtcPVyyeCzGDgt32/56IvNkH/uQ9EjCghjTNDN/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889622; c=relaxed/simple;
	bh=x6ILiUDb1OTWU9QfmEqPD69suzTR4WmAtNIjNr1eG0I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiCcnCft4Ajbt1g/220KD7+16XIIU+VKmMmVNSGaaDTANbMzxkYQ3lOkmqKBvVwkdsUwNHEuY2duucB24971+GYVmKfbj56hHH2cP38enifYYYRkTQMHlhG6cQrdoFnjnfZTVlIRRq5DN4J3qncsyMbXG7QZx3ria0s/67gvBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSSq0vVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19286C116C6;
	Mon, 23 Feb 2026 23:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889622;
	bh=x6ILiUDb1OTWU9QfmEqPD69suzTR4WmAtNIjNr1eG0I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rSSq0vVMdLSy7p8zfDUhGMjbVn96uoN2iqq5OYN7dXBs4X+T4KVq/+Kpq3F0oWpUp
	 eBToQeqbivYE2qjCFdp4W+sZO7CKDpeYFfGTq0JGSC10ygr13h9o3vv8/XYuP1jwM7
	 NP1Iy7HI3vAxIrsXWAD2qzUbj5ergandJZr6m4Tg66D+W+ZchngY1zOfVRJlUeYl+l
	 cviuaqnnvrSFkdpyYOYWbE+ZVhHFnsVmsr1hHLa0s+tiR598pDUdpFsaSof0CASkms
	 Xm+uSy2wopYZOu2T2FzwL9bW630/gZEhWySdHZrFD7oJgpEZAiR4NNOoUnll5PafOQ
	 X4oGi3EddsjNA==
Date: Mon, 23 Feb 2026 15:33:41 -0800
Subject: [PATCH 4/5] libfuse: add upper-level iomap mapping cache constraint
 code
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741089.3941876.5207933388834894893.stgit@frogsfrogsfrogs>
In-Reply-To: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
References: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78143-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5250417F9D6
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Allow high-level fuse servers to constrain the maximum size of each
iomap mapping cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    1 +
 lib/fuse.c     |   12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index e54aa1368bbb6b..bdc910ad1c2381 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -924,6 +924,7 @@ struct fuse_operations {
 	 * files.
 	 */
 	int (*iomap_config) (uint64_t supported_flags, off_t maxbytes,
+			     uint32_t cache_maxbytes,
 			     struct fuse_iomap_config *cfg);
 
 	/**
diff --git a/lib/fuse.c b/lib/fuse.c
index 04836044e7a25b..15372b23a7aef4 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2964,7 +2964,7 @@ static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
 }
 
 static int fuse_fs_iomap_config(struct fuse_fs *fs, uint64_t flags,
-				uint64_t maxbytes,
+				uint64_t maxbytes, uint32_t cache_maxbytes,
 				struct fuse_iomap_config *cfg)
 {
 	fuse_get_context()->private_data = fs->user_data;
@@ -2973,11 +2973,12 @@ static int fuse_fs_iomap_config(struct fuse_fs *fs, uint64_t flags,
 
 	if (fs->debug) {
 		fuse_log(FUSE_LOG_DEBUG,
-			 "iomap_config flags 0x%llx maxbytes %lld\n",
-			 (unsigned long long)flags, (long long)maxbytes);
+			 "iomap_config flags 0x%llx maxbytes %lld cache_maxbytes %u\n",
+			 (unsigned long long)flags, (long long)maxbytes,
+			 cache_maxbytes);
 	}
 
-	return fs->op.iomap_config(flags, maxbytes, cfg);
+	return fs->op.iomap_config(flags, maxbytes, cache_maxbytes, cfg);
 }
 
 static int fuse_fs_freezefs(struct fuse_fs *fs, const char *path,
@@ -4931,7 +4932,8 @@ static void fuse_lib_iomap_config(fuse_req_t req, uint64_t flags,
 	int err;
 
 	fuse_prepare_interrupt(f, req, &d);
-	err = fuse_fs_iomap_config(f->fs, flags, maxbytes, &cfg);
+	err = fuse_fs_iomap_config(f->fs, flags, maxbytes, cache_maxbytes,
+				   &cfg);
 	fuse_finish_interrupt(f, req, &d);
 	if (err) {
 		reply_err(req, err);


