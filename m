Return-Path: <linux-fsdevel+bounces-78167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFxRLifmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 656C717FD5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB8FF30603D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D838037FF51;
	Mon, 23 Feb 2026 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk1qgVTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF81E9B1A;
	Mon, 23 Feb 2026 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889999; cv=none; b=u7Son1fa9lp7otjbLEiejzTK1qxkdLsXs6Y7uzZdNWB6m7//SVWb7iySxhrYGw7CkHrWm1ySPTZKB4NMU5JVvIWlYKLNmIIGlTaU6OjyOSqOJ542z/bn0qlzvqMGRamApDPUvbK7YADrUUwK0RimpQe9YQR2f6u0F0ep0aqgtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889999; c=relaxed/simple;
	bh=D5AYTrMTPLzTmx3DGPH3B0Um/mCMeCHu3eFFTQ6naIA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek9PCY4NeJ2GUIgfX0KebGamEJe+mz9CFAmAke/egs96c12c7Gy/v3qozpo9ZsWKglG8YcAvMM3hSZT1Zyl2YsD5NyWO6YhZGwWjZWMw5eVoNXG7eNmruDt3mlZjWIpFGfCcCOu1UCX0Ph/Zc6FIxM20+rJTREuq0nDvIZi18xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk1qgVTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5FFC116C6;
	Mon, 23 Feb 2026 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889999;
	bh=D5AYTrMTPLzTmx3DGPH3B0Um/mCMeCHu3eFFTQ6naIA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gk1qgVTsvj9imy5SJUWxxcBNJFiAH8bnF+KCklzVG+WBeCtakmUw05h8h1U/5IrSx
	 F/5VclFJzBtOmRs2+u0DYYfGQKaigpLyn1XnDyME3mxXcCuC2k+8IYeZjDdWIefRdE
	 zRsm64Z5VLCuE0rU6xd2ZeiQzzTThxLo3YHolWojRIAm9Jl/MQpHQvFtUmdQHyxbni
	 0H4iGG9b3fqHMzyg0VaXIJwn3h3BH8wwGgCP7Vb2HaKxjggbXs/UpHubMo9n4BUral
	 xVmu0mk/6vY/GiFuZru8+PdDHn5NXaCPX0xiaBvAYNBIxNCD5ad7XBCZGiw77YhRMG
	 fDwxbMZuVL6/g==
Date: Mon, 23 Feb 2026 15:39:58 -0800
Subject: [PATCH 15/19] fuse4fs: separate invalidation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744751.3943178.4837783426304029352.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78167-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 656C717FD5A
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Use the new stuff

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 9dd694be943255..90b365149910c9 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -281,6 +281,9 @@ struct fuse4fs {
 	enum fuse4fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
 	uint64_t iomap_cap;
+	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
+	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse);
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6736,6 +6739,51 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	return 0;
 }
 
+static void fuse4fs_invalidate_bdev(struct fuse4fs *ff, blk64_t blk, blk_t num)
+{
+	off_t offset = FUSE4FS_FSB_TO_B(ff, blk);
+	off_t length = FUSE4FS_FSB_TO_B(ff, num);
+	int ret;
+
+	ret = fuse_lowlevel_iomap_device_invalidate(ff->fuse, ff->iomap_dev,
+						    offset, length);
+	if (!ret)
+		return;
+
+	if (num == 1)
+		err_printf(ff, "%s %llu: %s\n",
+			   _("error invalidating block"),
+			   (unsigned long long)blk,
+			   strerror(ret));
+	else
+		err_printf(ff, "%s %llu-%llu: %s\n",
+			   _("error invalidating blocks"),
+			   (unsigned long long)blk,
+			   (unsigned long long)blk + num - 1,
+			   strerror(ret));
+}
+
+static void fuse4fs_alloc_stats(ext2_filsys fs, blk64_t blk, int inuse)
+{
+	struct fuse4fs *ff = fs->priv_data;
+
+	if (inuse < 0)
+		fuse4fs_invalidate_bdev(ff, blk, 1);
+	if (ff->old_alloc_stats)
+		ff->old_alloc_stats(fs, blk, inuse);
+}
+
+static void fuse4fs_alloc_stats_range(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse)
+{
+	struct fuse4fs *ff = fs->priv_data;
+
+	if (inuse < 0)
+		fuse4fs_invalidate_bdev(ff, blk, num);
+	if (ff->old_alloc_stats_range)
+		ff->old_alloc_stats_range(fs, blk, num, inuse);
+}
+
 static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 {
 	struct fuse_iomap_config cfg = { };
@@ -6780,6 +6828,19 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * If we let iomap do all file block IO, then we need to watch for
+	 * freed blocks so that we can invalidate any page cache that might
+	 * get written to the block deivce.
+	 */
+	if (fuse4fs_iomap_enabled(ff)) {
+		ext2fs_set_block_alloc_stats_callback(ff->fs,
+				fuse4fs_alloc_stats, &ff->old_alloc_stats);
+		ext2fs_set_block_alloc_stats_range_callback(ff->fs,
+				fuse4fs_alloc_stats_range,
+				&ff->old_alloc_stats_range);
+	}
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b270c51e82cd4a..ffcaf56314bdfd 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -275,6 +275,9 @@ struct fuse2fs {
 	enum fuse2fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
 	uint64_t iomap_cap;
+	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
+	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse);
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6269,6 +6272,50 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	return 0;
 }
 
+static void fuse2fs_invalidate_bdev(struct fuse2fs *ff, blk64_t blk, blk_t num)
+{
+	off_t offset = FUSE2FS_FSB_TO_B(ff, blk);
+	off_t length = FUSE2FS_FSB_TO_B(ff, num);
+	int ret;
+
+	ret = fuse_fs_iomap_device_invalidate(ff->iomap_dev, offset, length);
+	if (!ret)
+		return;
+
+	if (num == 1)
+		err_printf(ff, "%s %llu: %s\n",
+			   _("error invalidating block"),
+			   (unsigned long long)blk,
+			   strerror(ret));
+	else
+		err_printf(ff, "%s %llu-%llu: %s\n",
+			   _("error invalidating blocks"),
+			   (unsigned long long)blk,
+			   (unsigned long long)blk + num - 1,
+			   strerror(ret));
+}
+
+static void fuse2fs_alloc_stats(ext2_filsys fs, blk64_t blk, int inuse)
+{
+	struct fuse2fs *ff = fs->priv_data;
+
+	if (inuse < 0)
+		fuse2fs_invalidate_bdev(ff, blk, 1);
+	if (ff->old_alloc_stats)
+		ff->old_alloc_stats(fs, blk, inuse);
+}
+
+static void fuse2fs_alloc_stats_range(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse)
+{
+	struct fuse2fs *ff = fs->priv_data;
+
+	if (inuse < 0)
+		fuse2fs_invalidate_bdev(ff, blk, num);
+	if (ff->old_alloc_stats_range)
+		ff->old_alloc_stats_range(fs, blk, num, inuse);
+}
+
 static int op_iomap_config(uint64_t flags, off_t maxbytes,
 			   struct fuse_iomap_config *cfg)
 {
@@ -6313,6 +6360,19 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * If we let iomap do all file block IO, then we need to watch for
+	 * freed blocks so that we can invalidate any page cache that might
+	 * get written to the block deivce.
+	 */
+	if (fuse2fs_iomap_enabled(ff)) {
+		ext2fs_set_block_alloc_stats_callback(ff->fs,
+				fuse2fs_alloc_stats, &ff->old_alloc_stats);
+		ext2fs_set_block_alloc_stats_range_callback(ff->fs,
+				fuse2fs_alloc_stats_range,
+				&ff->old_alloc_stats_range);
+	}
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;


