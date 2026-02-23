Return-Path: <linux-fsdevel+bounces-78078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBO5N/fgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:21:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733517F350
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66C73055C4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAE537F733;
	Mon, 23 Feb 2026 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCCqopwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD337D10B;
	Mon, 23 Feb 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888606; cv=none; b=eeF+xt83jt7AS1jDAHMDD8okSaoaVT7sW4maLpbQB0tDan/I+ictUB0Yw8/yNvzm2lvwp/wwpYPCmBHImbH0jC4ZmHh10AK3M9VcrGLvM5jYYNKWIp1B75Ju9VRPeUr1VRTKZByCun+0NUhOiKuIhnpVroooRTiKQNUxvfaOp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888606; c=relaxed/simple;
	bh=NtTq4awIQEqJ81kchNvakygIdeRAzD6wKBk0Hlnr3BU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5mCBCmZBEpyNhMJr/VkuuCiKl97tqtfiCDYRIOmKhyw8iSmTzYiQTqd6k87YmnAwkaC6V0dOtN9oSLirfsapoFSxQDqg8H2f9S9eZC/z2iumOkRX3Qbp0cru5BjJRtw74sdAQETHqXibyNELjYO33gkPicFyGdHA9JcUsrS6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCCqopwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B91C116C6;
	Mon, 23 Feb 2026 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888606;
	bh=NtTq4awIQEqJ81kchNvakygIdeRAzD6wKBk0Hlnr3BU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=vCCqopwJrei8NDYzMW2CaxN1zReNFIPFPDO+rQW/NkM4I43IXB3Y/Jcnoe7Gvsc2c
	 ++UzlW4ROlELpL8SvfjlofoJPyIPVcGaeHQfQ9E7rWSx/Irvbl3F9VigDE/ao7+FO1
	 Z0igSBaWH+EL/2W4N/fKzrZDdP9Fa8ntRSwTLFU4Sf5AGex4lksztVJxZs/HeUvt7Z
	 BmoaSGEdSQZjgUUTHO4csXm0WKshWSIJhtOR/FtlJf0fXE664jB+L33pzAPd4NttgP
	 ul2+fqRHQdhTAPhP3gOXQMASYMq0w6pfYx/0Ti52GbqFNLyq2viXL3TWoEiu62YbQf
	 qyb7TwtnMLhZA==
Date: Mon, 23 Feb 2026 15:16:46 -0800
Subject: [PATCH 31/33] fuse: disable direct fs reclaim for any fuse server
 that uses iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734908.3935739.11737668565290719291.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78078-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 4733517F350
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Any fuse server that uses iomap can create a substantial amount of dirty
pages in the pagecache because we don't write dirty stuff until reclaim
or fsync.  Therefore, memory reclaim on any fuse iomap server musn't
ever recurse back into the same filesystem.  We must also never throttle
the fuse server writes to a bdi because that will just slow down
metadata operations.

Add a new ioctl that the fuse server can call on the fuse device to set
PF_MEMALLOC_NOFS and PF_LOCAL_THROTTLE.  Either the fuse connection must
have already enabled iomap, or the caller must have CAP_SYS_RESOURCE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    2 ++
 include/uapi/linux/fuse.h |    1 +
 fs/fuse/dev.c             |    2 ++
 fs/fuse/fuse_iomap.c      |   37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 1d9d39383ca9b2..bf6640c36465e1 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -75,6 +75,7 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 			 const struct fuse_iomap_dev_inval_out *arg);
 
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
+int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -102,6 +103,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
+# define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c454cea83083d3..9e59fba64f48d9 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1195,6 +1195,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
+#define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9a814a0d222fe6..896706c911cf24 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2742,6 +2742,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 
 	case FUSE_DEV_IOC_IOMAP_SUPPORT:
 		return fuse_dev_ioctl_iomap_support(file, argp);
+	case FUSE_DEV_IOC_SET_NOFS:
+		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 84bc8bbd2eeb85..561b0105e6dadc 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -12,6 +12,7 @@
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
 #include "fuse_iomap_i.h"
+#include "fuse_dev_i.h"
 
 static bool __read_mostly enable_iomap =
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
@@ -2280,3 +2281,39 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 	up_read(&fc->killsb);
 	return ret;
 }
+
+static inline bool can_set_nofs(struct fuse_dev *fud)
+{
+	if (fud && fud->fc && fud->fc->iomap)
+	       return true;
+
+	return capable(CAP_SYS_RESOURCE);
+}
+
+int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	uint32_t flags;
+
+	if (!can_set_nofs(fud))
+		return -EPERM;
+
+	if (copy_from_user(&flags, argp, sizeof(flags)))
+		return -EFAULT;
+
+	/*
+	 * The fuse server could be asked to perform a substantial amount of
+	 * writeback, so prohibit reclaim from recursing into fuse or the
+	 * kernel from throttling any bdis that the fuse server might write to.
+	 */
+	switch (flags) {
+	case 1:
+		current->flags |= PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE;
+		return 0;
+	case 0:
+		current->flags &= ~(PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}


