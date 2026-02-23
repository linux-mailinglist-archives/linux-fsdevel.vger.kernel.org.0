Return-Path: <linux-fsdevel+bounces-78106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KATcM8jhnGnjLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:24:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AAD17F510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50C9F3096DB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835537F8A3;
	Mon, 23 Feb 2026 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g17jh0UQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255337F754;
	Mon, 23 Feb 2026 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889044; cv=none; b=X1A+fxGc0LWOWbsAxlMhXpKyodSJ0ZyE7ZmuasZ7Uw/kVXgyftO+ZQKPkfZZu/CE8NQrkoHTppdN44S0r/3E66yA06I06HaBKW1GrlS2/vveDpfMwHPNYoG9LhdHtH8/uM4Lp/4MLhr6bjCLkcDRSLZ52SK+d2aTLfDdHRMViO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889044; c=relaxed/simple;
	bh=y5UIssW3pmFoxSD37j5keakEDphQMvgV5aYQjjmoWq8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mh5N5x1ppwebCQNbG7valjcE3HxTaxZzHCyn8ujhuKGO08mS8fsZidAds1o+SvFvy++A49G0l7FukT3XQ0YSyrrLrToBsvF3XnZ59OkbfxXC0QCXUDWt5PNQwfB08wxhRdnV723TF9686io/NmEKXYPZku9vhynCVZLUeUiYhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g17jh0UQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAE1C19421;
	Mon, 23 Feb 2026 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889044;
	bh=y5UIssW3pmFoxSD37j5keakEDphQMvgV5aYQjjmoWq8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g17jh0UQYUTrGbt8YJ/yqcuAFpM3vxJ4FRxDAbkSO3l3gmlg4FsOXTGP+4Qf+lUMu
	 7CyoZ7exmX9RU4JuY1UX0tQcyfFKxck1/K562K+l4uRNG6QVArHgABfxZr0ZVMn4fg
	 fTDcgu1BjCOCthbUE6hdXzF5atBBcmrBHu3oNrpNTwl4BBJzRr1j2g/K7fWzQBI55O
	 ltdhbErkAmnkAWv9DHVapyey7z3P7Y05+6r+/oOl7CFuPD+4gJRGwx99PcljHJBgGx
	 FFcBs/z+bEZCeFOEq60VaYn3NEmAosL5PLAo906yQsgZO0mdp8Crb1zJG/A/4KpqdR
	 spphIVAFKTU1w==
Date: Mon, 23 Feb 2026 15:24:03 -0800
Subject: [PATCH 2/2] fuse: set iomap backing device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736545.3938056.4515255222432170935.stgit@frogsfrogsfrogs>
In-Reply-To: <177188736492.3938056.12632921710724088507.stgit@frogsfrogsfrogs>
References: <177188736492.3938056.12632921710724088507.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78106-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 87AAD17F510
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add a new ioctl so that an unprivileged fuse server can set the block
size of a bdev that's opened for iomap usage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    3 +++
 include/uapi/linux/fuse.h |    7 +++++++
 fs/fuse/dev.c             |    2 ++
 fs/fuse/fuse_iomap.c      |   27 +++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 6afc916e31a4fa..f61e99941e94cb 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -74,6 +74,8 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_dev_ioctl_iomap_set_blocksize(struct file *file,
+				struct fuse_iomap_backing_info __user *argp);
 int fuse_iomap_dev_inval(struct fuse_conn *fc,
 			 const struct fuse_iomap_dev_inval_out *arg);
 
@@ -111,6 +113,7 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 # define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_dev_ioctl_iomap_set_blocksize(...) (-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 # define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1132493c66d266..94e99a01af5da7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1202,6 +1202,11 @@ struct fuse_iomap_support {
 	uint64_t	padding;
 };
 
+struct fuse_iomap_backing_info {
+	uint32_t	backing_id;
+	uint32_t	blocksize;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1213,6 +1218,8 @@ struct fuse_iomap_support {
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
 #define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
+#define FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE _IOW(FUSE_DEV_IOC_MAGIC, 102, \
+					      struct fuse_iomap_backing_info)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f4ca408653cf61..60327b5609fe74 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2789,6 +2789,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
 	case FUSE_DEV_IOC_ADD_IOMAP:
 		return fuse_dev_ioctl_add_iomap(file);
+	case FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE:
+		return fuse_dev_ioctl_iomap_set_blocksize(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index ca37eb93d71a43..7bc938cd859fae 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2935,3 +2935,30 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 	up_read(&fc->killsb);
 	return ret;
 }
+
+int fuse_dev_ioctl_iomap_set_blocksize(struct file *file,
+				struct fuse_iomap_backing_info __user *argp)
+{
+	struct fuse_iomap_backing_info fbi;
+	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_backing *fb;
+	int ret;
+
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
+
+	if (!fud->fc->iomap)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&fbi, argp, sizeof(fbi)))
+		return -EFAULT;
+
+	fb = fuse_backing_lookup(fud->fc, &fuse_iomap_backing_ops,
+				 fbi.backing_id);
+	if (!fb)
+		return -ENOENT;
+
+	ret = set_blocksize(fb->file, fbi.blocksize);
+	fuse_backing_put(fb);
+	return ret;
+}


