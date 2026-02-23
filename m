Return-Path: <linux-fsdevel+bounces-78067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB1HFDjfnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:14:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4517F095
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB48302EC9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF537AA81;
	Mon, 23 Feb 2026 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jehYwYs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600E328B69;
	Mon, 23 Feb 2026 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888434; cv=none; b=bUMCTht1rj5wo22haHpjB4EC2StU2x2putRUDTGJQBVYbcZff1N4tVwOfU6KkhFzzRl39AFmHp4UJtuiAz/UAbEp12Ftw3hWJ/lXuUpTTE6xgYcgl7Z+ONKKKSVQ051cdApL0cCDCxB8oy5yDWY9t2ggyjz83eSSz3BD81WG9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888434; c=relaxed/simple;
	bh=zzP89CnP37pp6waCXMToimeiF7cT6HxawpGhiOGfiaU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gejF7wN+rR7BFp3pEbo0tcP5zCFwVt4nBnePpwuLSc3rxNYmIXo8MP18BbBzNGyJz24XrRX3AqzowPEnZpBuqeSTu/O2Gxr71b562ASh7Gys31MJKGepKKQOm+lsu2pJ3BB8Kjr7f2/5PIroAhEqY5EzgFQLSVQKmpGyyQAeK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jehYwYs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A8AC116C6;
	Mon, 23 Feb 2026 23:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888434;
	bh=zzP89CnP37pp6waCXMToimeiF7cT6HxawpGhiOGfiaU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jehYwYs7mikTShD5DVXc4r9Ftjy+KeNU9RG8/bZitMyBoiPbUyw/OP1tVHZE/XwqO
	 UJUPupj7TdycY/1OHfSLYgPmLqNSl8O75Xlo1F1VvUCDwlkpvvJE9lRHAFQCe3IFjX
	 kyWEKf7yslhODweqnPJ4tmFLuO2IEtXRL1Kv0bPlklWDtx4u08L4dMKGTyl1V7vhtH
	 MoB4d4955IdkdtKF1g2oFDV6ktqAm6Zcvspp+omXXZN9xqog90xAfLHQCAbzsHdKhn
	 8A9WkLQXknKPEXUHLMxTZYm78f3xJERwXfOr74XivW9KhM/2tKs+iCaBaJ0OijvgqG
	 F4j7FnKgfgz9g==
Date: Mon, 23 Feb 2026 15:13:54 -0800
Subject: [PATCH 20/33] fuse: advertise support for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734674.3935739.7881475098875460518.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78067-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15B4517F095
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Advertise our new IO paths programmatically by creating an ioctl that
can return the capabilities of the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    4 ++++
 include/uapi/linux/fuse.h |    9 +++++++++
 fs/fuse/dev.c             |    3 +++
 fs/fuse/fuse_iomap.c      |   13 +++++++++++++
 4 files changed, 29 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 4b12af01ff00f5..9a1051638a6ff4 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -60,6 +60,9 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -83,6 +86,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 71b216262c84cb..de9b56e6e8d250 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1156,6 +1156,13 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+/* basic file I/O functionality through iomap */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1163,6 +1170,8 @@ struct fuse_backing_map {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c5593f35dcb675..39d3c36774de55 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2713,6 +2713,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_SYNC_INIT:
 		return fuse_dev_ioctl_sync_init(file);
 
+	case FUSE_DEV_IOC_IOMAP_SUPPORT:
+		return fuse_dev_ioctl_iomap_support(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 70b6fb922fc9ec..3395b1cd907afa 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1818,3 +1818,16 @@ fuse_iomap_fallocate(
 	file_update_time(file);
 	return 0;
 }
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp)
+{
+	struct fuse_iomap_support ios = { };
+
+	if (fuse_iomap_enabled())
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+
+	if (copy_to_user(argp, &ios, sizeof(ios)))
+		return -EFAULT;
+	return 0;
+}


