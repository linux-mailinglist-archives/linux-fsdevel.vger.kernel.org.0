Return-Path: <linux-fsdevel+bounces-78197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDuDFdnnnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:50:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19A180070
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B500B31799A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0CC37FF79;
	Mon, 23 Feb 2026 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg/xG9Ur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171EE3803C8;
	Mon, 23 Feb 2026 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890453; cv=none; b=smCLTMkjVthR2i8DMcUsaVV2+8EZyb7+Ziee3W/v99fDVTS8898qPDfPuenvd7GLp6kunuZYOuqhbP1RkK9WoPbcc0dG0Nvx4iHbZAQbX1Zl1UhBAvESVXEVTCFegMTbtz4mGOJ9M+X0QS0Ib849qInpPXTqpyQzxaLmMxvHeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890453; c=relaxed/simple;
	bh=YBXQ+4QrKMfWHXQSHjdR/FiNQmo0HS7RWAbd/6krHY8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr33ry9rhNAhlZqtGN48tb+zgH3KLjEDu0cOcGdFvbtz5WDSOIp8DxiyhjgFgg9kURJDggwdpF4aA1NtjrYTmFZePdgq80Wxnuhfq06YxAY++ekX63IGifhBaTI+1pFWWMEH/IS/NTEFTV/eiAy4uZTOw3Tx8zgqBsZ62Mc3IkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg/xG9Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B2EC116C6;
	Mon, 23 Feb 2026 23:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890453;
	bh=YBXQ+4QrKMfWHXQSHjdR/FiNQmo0HS7RWAbd/6krHY8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hg/xG9UrijXQAuL3Q+aiHJx363zmSOTygOzmGdXGWNN+CRX7HMojqwON5tPmHFdbX
	 gYqYiTXqaZ5h+DslsMnPOIVhvJGihz3Q5D4zXj2I3C89AO8l7b94RqID4WeIqk2RLj
	 gAA7qSGYF4YE6IpEhDKLYAKeg+GZ8sDRgkOB40zS28QN/YJiV62x0QO7orIi4WO5KD
	 EWK1XXWr5xltwrrUVpjFxPvKZrQVaqupEfjJjVw0NZBTR3EyB8/1tN9F+FSG8/arLp
	 INjmOpGsj5ddSJe0MbIL/l+VMG96x0DURL6ziXnNQ75M0s/q0dgaRUlADMkW5rSIPS
	 15j2PnN56EW/Q==
Date: Mon, 23 Feb 2026 15:47:32 -0800
Subject: [PATCH 5/8] fuse4fs: set iomap backing device blocksize
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746045.3944907.5487315784282681821.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
References: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78197-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: EB19A180070
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

If we're running as an unprivileged iomap fuse server, we must ask the
kernel to set the blocksize of the block device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index ad701649886380..9d8dfde95e7256 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1607,6 +1607,21 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 
 	return 0;
 }
+
+int fuse4fs_service_set_bdev_blocksize(struct fuse4fs *ff, int dev_index)
+{
+	int ret;
+
+	ret = fuse_lowlevel_iomap_set_blocksize(ff->fusedev_fd, dev_index,
+						ff->fs->blocksize);
+	if (ret) {
+		err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+			   ff->fs->blocksize, strerror(errno));
+		return -EIO;
+	}
+
+	return 0;
+}
 #else
 # define fuse4fs_service_connect(...)		(0)
 # define fuse4fs_service_set_proc_cmdline(...)	((void)0)
@@ -1618,6 +1633,7 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 # define fuse4fs_service_openfs(...)		(EOPNOTSUPP)
 # define fuse4fs_service_configure_iomap(...)	(EOPNOTSUPP)
 # define fuse4fs_service(...)			(EOPNOTSUPP)
+# define fuse4fs_service_set_bdev_blocksize(...) (EOPNOTSUPP)
 #endif
 
 static errcode_t fuse4fs_acquire_lockfile(struct fuse4fs *ff)
@@ -7376,21 +7392,19 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 {
 	errcode_t err;
 	int fd;
+	int dev_index;
 	int ret;
 
 	err = io_channel_get_fd(ff->fs->io, &fd);
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
-	ret = fuse4fs_set_bdev_blocksize(ff, fd);
-	if (ret)
-		return ret;
-
-	ret = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
-	if (ret < 0) {
-		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
-			   __func__, fd, -ret);
-		return translate_error(ff->fs, 0, -ret);
+	dev_index = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
+	if (dev_index < 0) {
+		ret = -dev_index;
+		dbg_printf(ff, "%s: cannot register iomap dev fd=%d: %s\n",
+			   __func__, fd, strerror(ret));
+		return translate_error(ff->fs, 0, ret);
 	}
 
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
@@ -7398,7 +7412,14 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 
 	fuse4fs_configure_atomic_write(ff, fd);
 
-	ff->iomap_dev = ret;
+	if (fuse4fs_is_service(ff))
+		ret = fuse4fs_service_set_bdev_blocksize(ff, dev_index);
+	else
+		ret = fuse4fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
+	ff->iomap_dev = dev_index;
 	return 0;
 }
 


