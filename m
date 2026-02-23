Return-Path: <linux-fsdevel+bounces-78071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEWsE4vgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:19:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DA17F29D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0FE3169A94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0693A37E316;
	Mon, 23 Feb 2026 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvJiPmGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C73227B8E;
	Mon, 23 Feb 2026 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888497; cv=none; b=DaHYDZt+nyvmQ7xrycDakgZCh9f1N3qJTgypycnReHZBSRGEwwN4LzTdvtKS5eSyMd5/XdKJi937IYZdg71D7UBzoa3MsUT6oEymWJcXT9u4jg+xXV4GT3BCVfC/drdr67umxTsI6f4IqsWSK6PB5hqGue/aznAzNynpDTXxdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888497; c=relaxed/simple;
	bh=UwSi/AGH5sqwtT80/Nuj8IPwUHY5J6IIbnKyze3n9gg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9GyyPX82Ky1cHuo/DRByIJAmDEhK4OKdw6K3QqGlvJNEy0Nksqu9WZ/sRNqmwNHBByVwG0pKbeDJqAUJyAgoTl75XVkMULTEzPNW2hRVva7q6pVq0U0orz6ifX5t7xQsRTfHRlWItZmhmZlonUQNWKE3BEv26AOk85UAddeQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvJiPmGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E743C116C6;
	Mon, 23 Feb 2026 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888497;
	bh=UwSi/AGH5sqwtT80/Nuj8IPwUHY5J6IIbnKyze3n9gg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cvJiPmGjMs4AqFwwhg7Xwev4QMGMilNA8EJ8FCJkCTC44hay3HJOwy4x+yY3j87y3
	 MxhMD7F6EAVgKTMmWs8tyWo6tFNy1cSa5KktMCpEhC7dGpiUx1EE8gGU+44g/OBM76
	 1SU3651ox+u0Iyr5aIwMaYjV5HPLBt/zuYpmnW/NWFZbDfuMXAYMoo7ZITqk9wsRzB
	 Twk4HKXBr/HUhg+kwjWtSa0QRd89p9Wa+OaJn1XcZ1uXIOtoVAgmeL38Yphb/uLco2
	 o6OgqxV3y2b8+Iod9HIvhAWh00SCVCSXlqzSrobUXzwj+2YLgQlxcNkINMB1B8T4Yb
	 Tzm4RCMhPSA+g==
Date: Mon, 23 Feb 2026 15:14:56 -0800
Subject: [PATCH 24/33] fuse: invalidate ranges of block devices being used for
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734759.3935739.15349026233739925073.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78071-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: AD5DA17F29D
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Make it easier to invalidate the page cache for a block device that is
being used in conjunction with iomap.  This allows a fuse server to kill
all cached data for a block that is being freed, so that block reuse
doesn't result in file corruption.  Right now, the only way to do this
is with fadvise, which ignores and doesn't wait for pages undergoing
writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    3 +++
 include/uapi/linux/fuse.h |   16 ++++++++++++++++
 fs/fuse/dev.c             |   27 +++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c      |   41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 3e5df67db2a1fe..d4a4d9f0313edf 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -64,6 +64,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_iomap_dev_inval(struct fuse_conn *fc,
+			 const struct fuse_iomap_dev_inval_out *arg);
 
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
@@ -91,6 +93,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 #endif /* CONFIG_FUSE_IOMAP */
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 33668d66e9c4b4..1ef7152306a24f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -247,6 +247,7 @@
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -701,6 +702,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
+	FUSE_NOTIFY_CODE_MAX,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1491,4 +1494,17 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+struct fuse_range {
+	uint64_t offset;
+	uint64_t length;
+};
+
+struct fuse_iomap_dev_inval_out {
+	uint32_t dev;		/* device cookie */
+	uint32_t reserved;	/* zero */
+
+	/* range of bdev pagecache to invalidate, in bytes */
+	struct fuse_range range;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 39d3c36774de55..9a814a0d222fe6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1849,6 +1849,30 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	return err;
 }
 
+static int fuse_notify_iomap_dev_inval(struct fuse_conn *fc, unsigned int size,
+				       struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_dev_inval_out outarg;
+	int err = -EINVAL;
+
+	if (size != sizeof(outarg))
+		goto err;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		goto err;
+	if (outarg.reserved) {
+		err = -EINVAL;
+		goto err;
+	}
+	fuse_copy_finish(cs);
+
+	return fuse_iomap_dev_inval(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
 struct fuse_retrieve_args {
 	struct fuse_args_pages ap;
 	struct fuse_notify_retrieve_in inarg;
@@ -2133,6 +2157,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_PRUNE:
 		return fuse_notify_prune(fc, size, cs);
 
+	case FUSE_NOTIFY_IOMAP_DEV_INVAL:
+		return fuse_notify_iomap_dev_inval(fc, size, cs);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index df92740f1e781b..21c286c285a59d 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1998,3 +1998,44 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
 		inode_unlock_shared(inode);
 	return ret;
 }
+
+int fuse_iomap_dev_inval(struct fuse_conn *fc,
+			 const struct fuse_iomap_dev_inval_out *arg)
+{
+	struct fuse_backing *fb;
+	struct block_device *bdev;
+	loff_t end;
+	int ret = 0;
+
+	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
+		return -EINVAL;
+
+	down_read(&fc->killsb);
+	fb = fuse_backing_lookup(fc, &fuse_iomap_backing_ops, arg->dev);
+	if (!fb) {
+		ret = -ENODEV;
+		goto out_killsb;
+	}
+	bdev = fb->bdev;
+
+	inode_lock(bdev->bd_mapping->host);
+	filemap_invalidate_lock(bdev->bd_mapping);
+
+	if (check_add_overflow(arg->range.offset, arg->range.length, &end) ||
+	    arg->range.offset >= bdev_nr_bytes(bdev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	end = min(end, bdev_nr_bytes(bdev));
+	truncate_inode_pages_range(bdev->bd_mapping, arg->range.offset,
+				   end - 1);
+
+out_unlock:
+	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
+	fuse_backing_put(fb);
+out_killsb:
+	up_read(&fc->killsb);
+	return ret;
+}


