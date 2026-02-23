Return-Path: <linux-fsdevel+bounces-78156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGo2KULlnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:39:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4213917FB5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56A40307D80F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAEA37F8DF;
	Mon, 23 Feb 2026 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmnXxtpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE037E313;
	Mon, 23 Feb 2026 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889825; cv=none; b=gdm/BcNmmA0navnDi5HMF5fAidqpteAcgo1NWsKaTB6WrYiLyg+D/48a5DOlNGOFaETw76vQApBKnHac584ZS0pwmU57P89+MEHuoIRJWjwXXiRETRdj8k/DSNdt4Sj4geQR/0vPJIijIXEB6lOHpfl5PK6sfcJzh1UOGCYZl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889825; c=relaxed/simple;
	bh=stpRekqxl11J4aRHWVdfCW7w25TGvDBWihAjp7EU4EE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwkJohqsdoA5Z2SERgED9hdDtcorzr7wRB6E/eoXhWBgwl0BW20OzuGfZ2Efc472b8dg6PaHOHWVk5Aj0ZR/OBXST/nsywYiuTnR2gR88s29aOICNeI+zRwhnsLLEjE+pxbeZmsos5TPFEvZp1fhurpsvZShDqufSxLDeHVmMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmnXxtpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523A9C116C6;
	Mon, 23 Feb 2026 23:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889825;
	bh=stpRekqxl11J4aRHWVdfCW7w25TGvDBWihAjp7EU4EE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KmnXxtpQaNfV49agtzphjrzxJOTJFqOmHg8Oyj+y9kryCngYS29g/WCOC18YIivFX
	 sZP2sHroOun7kE+YLwp7EpjL9PS85IRzRuRYhcJjd4lUh8N7KPoIrXQJmVhWuurM/b
	 P9/U3ze/j00qEKrfroWmD6XcyJkH00vOPrmLAl+0MUg8I21CmxFuGcwUJC7x89RchM
	 +V0OdARY/MJ8A2PdAQyroR++1xbVeP59HUC3Vd8REHltoyOLitiMF6qVVig/QjU5qo
	 cbMr4UnWsNot5uSPePG5rHQrJCKRgzpivsMFzy9qnx924LG1QfQXIJ3gYImEAHWUbq
	 W00qBuKu7y/Xg==
Date: Mon, 23 Feb 2026 15:37:04 -0800
Subject: [PATCH 04/19] fuse2fs: register block devices for use with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744553.3943178.8263507587023975221.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78156-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 4213917FB5B
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Register the ext4 block device with the kernel for use with iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 misc/fuse2fs.c    |   42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 78 insertions(+), 8 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 617ef259133cba..e6a60f4ea637f3 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -272,6 +272,7 @@ struct fuse4fs {
 #ifdef HAVE_FUSE_IOMAP
 	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
+	uint32_t iomap_dev;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6028,7 +6029,7 @@ static errcode_t fuse4fs_iomap_begin_extent(struct fuse4fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE4FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE4FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE4FS_FSB_TO_B(ff, extent.e_len);
@@ -6061,13 +6062,14 @@ static int fuse4fs_iomap_begin_indirect(struct fuse4fs *ff, uint64_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
 	iomap->offset = FUSE4FS_FSB_TO_B(ff, startoff);
 	iomap->flags |= FUSE_IOMAP_F_MERGED;
 	if (startblock) {
+		iomap->dev = ff->iomap_dev;
 		iomap->addr = FUSE4FS_FSB_TO_B(ff, startblock);
 		iomap->type = FUSE_IOMAP_TYPE_MAPPED;
 	} else {
+		iomap->dev = FUSE_IOMAP_DEV_NULL;
 		iomap->addr = FUSE_IOMAP_NULL_ADDR;
 		iomap->type = FUSE_IOMAP_TYPE_HOLE;
 	}
@@ -6287,11 +6289,36 @@ static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
 	return res;
 }
 
+static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
+{
+	errcode_t err;
+	int fd;
+	int ret;
+
+	err = io_channel_get_fd(ff->fs->io, &fd);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
+	ret = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
+	if (ret < 0) {
+		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
+			   __func__, fd, -ret);
+		return translate_error(ff->fs, 0, -ret);
+	}
+
+	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
+		   __func__, fd, ff->iomap_dev);
+
+	ff->iomap_dev = ret;
+	return 0;
+}
+
 static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 {
 	struct fuse_iomap_config cfg = { };
 	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
+	int ret = 0;
 
 	FUSE4FS_CHECK_CONTEXT(req);
 
@@ -6326,8 +6353,16 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 	cfg.flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
 	cfg.s_maxbytes = fuse4fs_max_size(ff, maxbytes);
 
-	fuse4fs_finish(ff, 0);
-	fuse_reply_iomap_config(req, &cfg);
+	ret = fuse4fs_iomap_config_devices(ff);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_iomap_config(req, &cfg);
 }
 #endif /* HAVE_FUSE_IOMAP */
 
@@ -6786,6 +6821,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 45ac61ff02957b..70ded520cd318a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -40,6 +40,7 @@
 # define _FILE_OFFSET_BITS 64
 #endif /* _FILE_OFFSET_BITS */
 #include <fuse.h>
+#include <fuse_lowlevel.h>
 #ifdef __SET_FOB_FOR_FUSE
 # undef _FILE_OFFSET_BITS
 #endif /* __SET_FOB_FOR_FUSE */
@@ -265,6 +266,7 @@ struct fuse2fs {
 #ifdef HAVE_FUSE_IOMAP
 	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
+	uint32_t iomap_dev;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5473,7 +5475,7 @@ static errcode_t fuse2fs_iomap_begin_extent(struct fuse2fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE2FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE2FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE2FS_FSB_TO_B(ff, extent.e_len);
@@ -5506,13 +5508,14 @@ static int fuse2fs_iomap_begin_indirect(struct fuse2fs *ff, uint64_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
 	iomap->offset = FUSE2FS_FSB_TO_B(ff, startoff);
 	iomap->flags |= FUSE_IOMAP_F_MERGED;
 	if (startblock) {
+		iomap->dev = ff->iomap_dev;
 		iomap->addr = FUSE2FS_FSB_TO_B(ff, startblock);
 		iomap->type = FUSE_IOMAP_TYPE_MAPPED;
 	} else {
+		iomap->dev = FUSE_IOMAP_DEV_NULL;
 		iomap->addr = FUSE_IOMAP_NULL_ADDR;
 		iomap->type = FUSE_IOMAP_TYPE_HOLE;
 	}
@@ -5731,11 +5734,36 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
 	return res;
 }
 
+static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
+{
+	errcode_t err;
+	int fd;
+	int ret;
+
+	err = io_channel_get_fd(ff->fs->io, &fd);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
+	ret = fuse_fs_iomap_device_add(fd, 0);
+	if (ret < 0) {
+		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
+			   __func__, fd, -ret);
+		return translate_error(ff->fs, 0, -ret);
+	}
+
+	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
+		   __func__, fd, ff->iomap_dev);
+
+	ff->iomap_dev = ret;
+	return 0;
+}
+
 static int op_iomap_config(uint64_t flags, off_t maxbytes,
 			   struct fuse_iomap_config *cfg)
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
+	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 
@@ -5770,8 +5798,13 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
 	cfg->flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
 	cfg->s_maxbytes = fuse2fs_max_size(ff, maxbytes);
 
-	fuse2fs_finish(ff, 0);
-	return 0;
+	ret = fuse2fs_iomap_config_devices(ff);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
 }
 #endif /* HAVE_FUSE_IOMAP */
 
@@ -6137,6 +6170,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;


