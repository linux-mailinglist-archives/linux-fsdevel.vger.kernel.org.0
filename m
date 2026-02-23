Return-Path: <linux-fsdevel+bounces-78166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHyhJBLmnGlxMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB7917FD2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4BB130913E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7067E37FF48;
	Mon, 23 Feb 2026 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2K2o32N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09FD37BE9E;
	Mon, 23 Feb 2026 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889984; cv=none; b=JYfKep7p7lI0YeCYPaP6leubAE3xb1qvQXphSVZuIhAaMnx40HZl2WTEzVpSUZAQ+8BfENBhH9JpYqGs+8V19yJVcL8Wca1usl6B/XZystB/6WBwQV7HybB+MJ7FXI168/c0uIMfQ6xgaBV0ErpScIX2h4NtTYKxUaO2iE45uAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889984; c=relaxed/simple;
	bh=vkOQW4WaZCsbUo8rzWkwvNdedqU9nOvJz2mIw4vcttI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itf4nDTfXVvJ7g2DNdEblR5y7DCtL/EbgPKmM32vBlq2GkZnE5MdZr5Deepa05BVVtpm9h30hv4gE8bODU3htBj6P3PnW+lHFmPMEWRhH8RhJ6B3MXCGn82RIevIx4Esav4cS45EcdgYug8Y7Q7FjhF2bqzY36zZLYj+5NRvYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2K2o32N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95842C116C6;
	Mon, 23 Feb 2026 23:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889983;
	bh=vkOQW4WaZCsbUo8rzWkwvNdedqU9nOvJz2mIw4vcttI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=E2K2o32NXS5ISa/OGP7q46QqpZiE0NbecUuuvp5b+GRZgVSWHRTIHTh5+4fk93kHj
	 fuDcGwdTufpHlUVpKq4n4N80C4KQ6KSrRzCbVnzstGgfYAG3u2Oy7Rei+FwHZzRopR
	 POZqmpk0KHmZlpRGnhOto+TV+C+Dmu+kTK2u1wO7UwXrxZAoGhTcGTyz3OJ7KeSZoT
	 VB2KXeiWisV7CPCxZoY3s4X5fP5jctToavp+/gAZ+o9SLz3jzav8zz9loQyOSKXVxR
	 IzgGxG24VZx/zaX88Y0q4yjJ9qUb9D1GMqcVguB4rY6lquyXKRok5/IZl4drq/+/Zz
	 pLBaUaze1Wr3g==
Date: Mon, 23 Feb 2026 15:39:43 -0800
Subject: [PATCH 14/19] fuse2fs: configure block device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744733.3943178.2911587084583489746.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78166-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 3BB7917FD2F
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Set the blocksize of the block device to the filesystem blocksize.
This prevents the bdev pagecache from caching file data blocks that
iomap will read and write directly.  Cache duplication is dangerous.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 395f2fcd067633..9dd694be943255 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6669,6 +6669,45 @@ static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
 	return res;
 }
 
+/*
+ * Set the block device's blocksize to the fs blocksize.
+ *
+ * This is required to avoid creating uptodate bdev pagecache that aliases file
+ * data blocks because iomap reads and writes directly to file data blocks.
+ */
+static int fuse4fs_set_bdev_blocksize(struct fuse4fs *ff, int fd)
+{
+	int blocksize = ff->fs->blocksize;
+	int set_error;
+	int ret;
+
+	ret = ioctl(fd, BLKBSZSET, &blocksize);
+	if (!ret)
+		return 0;
+
+	/*
+	 * Save the original errno so we can report that if the block device
+	 * blocksize isn't set in an agreeable way.
+	 */
+	set_error = errno;
+
+	ret = ioctl(fd, BLKBSZGET, &blocksize);
+	if (ret)
+		goto out_bad;
+
+	/* Pretend that BLKBSZSET rejected our proposed block size */
+	if (blocksize > ff->fs->blocksize) {
+		set_error = EINVAL;
+		goto out_bad;
+	}
+
+	return 0;
+out_bad:
+	err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+		   blocksize, strerror(set_error));
+	return -EIO;
+}
+
 static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 {
 	errcode_t err;
@@ -6679,6 +6718,10 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	ret = fuse4fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
 	ret = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
 	if (ret < 0) {
 		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ed1b3068f22931..b270c51e82cd4a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -6202,6 +6202,45 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
 	return res;
 }
 
+/*
+ * Set the block device's blocksize to the fs blocksize.
+ *
+ * This is required to avoid creating uptodate bdev pagecache that aliases file
+ * data blocks because iomap reads and writes directly to file data blocks.
+ */
+static int fuse2fs_set_bdev_blocksize(struct fuse2fs *ff, int fd)
+{
+	int blocksize = ff->fs->blocksize;
+	int set_error;
+	int ret;
+
+	ret = ioctl(fd, BLKBSZSET, &blocksize);
+	if (!ret)
+		return 0;
+
+	/*
+	 * Save the original errno so we can report that if the block device
+	 * blocksize isn't set in an agreeable way.
+	 */
+	set_error = errno;
+
+	ret = ioctl(fd, BLKBSZGET, &blocksize);
+	if (ret)
+		goto out_bad;
+
+	/* Pretend that BLKBSZSET rejected our proposed block size */
+	if (blocksize > ff->fs->blocksize) {
+		set_error = EINVAL;
+		goto out_bad;
+	}
+
+	return 0;
+out_bad:
+	err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+		   blocksize, strerror(set_error));
+	return -EIO;
+}
+
 static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 {
 	errcode_t err;
@@ -6212,6 +6251,10 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	ret = fuse2fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
 	ret = fuse_fs_iomap_device_add(fd, 0);
 	if (ret < 0) {
 		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",


