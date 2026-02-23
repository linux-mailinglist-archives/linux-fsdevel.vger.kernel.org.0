Return-Path: <linux-fsdevel+bounces-78186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UANDDx3nnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:47:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505017FF6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE239309D95B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AED837FF60;
	Mon, 23 Feb 2026 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6SPIo9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AC36B054;
	Mon, 23 Feb 2026 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890281; cv=none; b=b9y1wWckEuXeuhTtFLwBMvbujRe+mM2Aes4T+cqvvSRdZsL0QgOggfLtgd9O5Es/umXRxgEwcwKqdpVNYwihhiMPILCx00nJffZinkgqSTi/eo7QzKa2h0hlovhqV5OT793ckpCeCJl/gwceIPk9/EyYOkeX9a2MXCVCKkTJOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890281; c=relaxed/simple;
	bh=RegXoLJ2cV1dX0TCmMwJAOxwTWoUTBtWlsXQK0cWPEA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqE+aQ9UlOcXDH2WT7WSyLvPhOU/ncJtZV7bWNI148sW8pqG7f/t50v2ObzLW7yiYb1P5nrcXyR7DJj9aEwyWn1WHkOZPRwdRpd/K6QIVOkDgckSUkKn3ByeYXE3ZjroGxr0ncD2CLx83cZHkytZXeDfImGL/MieLlk8v7zygH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6SPIo9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B0FC116C6;
	Mon, 23 Feb 2026 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890281;
	bh=RegXoLJ2cV1dX0TCmMwJAOxwTWoUTBtWlsXQK0cWPEA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=I6SPIo9Uqiu7ErWc+BR0DNFtGSSRnMaBYDUZShdDe0y/zWYVSHh0BSYXHI5fxRzLs
	 Sgzdf8oNiMygRmRmebKhT99B7h5MNVFz9XuTrGdpL/xfEMen4DiC9W18pCvHOMBGrW
	 nfhCcRzIteHQLh8OUdIXF2nKU80DTgusU6tm5Fo7nwVn8OHN/m/aB8a6LGMLekcy46
	 BkpLlfVS76Q/EiPNWm1/chm0fwnOkiCQXq8vPGcdkvS78P+SK3jejWBB+csdWZOX/6
	 MH7O7J+QOGDnYOvRya1oROo7yISP7SrxtJZJVVx2RqHr/+hCQG2YJDB7pMTxK0wfZP
	 u8Xd6sxzRQIZw==
Date: Mon, 23 Feb 2026 15:44:40 -0800
Subject: [PATCH 3/3] fuse2fs: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745547.3944453.6383921562493304527.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745484.3944453.12407213942915501693.stgit@frogsfrogsfrogs>
References: <177188745484.3944453.12407213942915501693.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78186-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 6505017FF6D
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Now that iomap functionality is complete, enable this for users.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    4 ----
 misc/fuse2fs.c    |    4 ----
 2 files changed, 8 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index c5cf471d630451..e8edeb8f62e88a 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2021,10 +2021,6 @@ static inline bool fuse4fs_wants_iomap(struct fuse4fs *ff)
 static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 				 struct fuse4fs *ff)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	ff->iomap_state = IOMAP_DISABLED;
-	return;
-
 	if (fuse4fs_wants_iomap(ff) &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
 		ff->iomap_state = IOMAP_ENABLED;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4dab8034ebb317..96118942c324ba 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1847,10 +1847,6 @@ static inline bool fuse2fs_wants_iomap(struct fuse2fs *ff)
 static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 				 struct fuse2fs *ff)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	ff->iomap_state = IOMAP_DISABLED;
-	return;
-
 	if (fuse2fs_wants_iomap(ff) &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
 		ff->iomap_state = IOMAP_ENABLED;


