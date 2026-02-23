Return-Path: <linux-fsdevel+bounces-78070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOUUHkHgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:18:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E1217F221
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CA1319E6FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605C37E310;
	Mon, 23 Feb 2026 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzSu9eZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B5328B69;
	Mon, 23 Feb 2026 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888481; cv=none; b=Ug/ho8jYYLwqHRC4NMkxdc/gDy1PagsOK+i6y5bf4okLvVyhpjbPivXwol86kmiyroXXzKy+/aK00T7ZdiKknqkM75upeobgqYE35KaWryKrY39/1eZutV3njbpEVY5uTiihZ30FkHkqqlLBdIQTH3OF3U+LFfy5bcS9iIOUOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888481; c=relaxed/simple;
	bh=VLlpT9LmLHoUXa9pTwB69WT6vXuSuSah0RfJuRY9c6o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLQiIfl5Ihh6Erb79TRXxyYRNhJPZb6zejKL5ekiiKnI3onNhVQMrQTLWpBFOyghTSn2uUNQfL+fMypMoI7l1ISNRwiBYwqda9178esFcQd+bdlLkK8eocrA+//OXyxh1j6qoCoj2yPiwvdiSQNYOlbljPQjSf2ziCSKVpcp5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzSu9eZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81047C116C6;
	Mon, 23 Feb 2026 23:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888481;
	bh=VLlpT9LmLHoUXa9pTwB69WT6vXuSuSah0RfJuRY9c6o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CzSu9eZctVJxn1mG9g0uzSXtHeOWNULCXURhhHgfkR3AmKDc97nQwsLVenQqJ93UF
	 Qd3IlaAeswu70GwLRP4CV4+FmKz4DbB/Od66f5p10ezEaWz57ntHYzRP7ao8rV/n3p
	 ZmoQInqelzUL/Qx8Y/BKNzIZW6RV3bkbqqPOPOUGfbPAHMYvTvykXFFtoxWQi76vX6
	 EqzYbWfU60YRBbg5reRqNuPUg3qOUr32CM+9JmrKcUoZK0p77l/i/o+kCDMGSlcZuN
	 QZxnTlA/oC/DPvX5MGCoDlBMYQW3kLrnxiHihbOcKNftVoOShX81JSvZdngpYX6KdR
	 8Anupb1XU9Fcg==
Date: Mon, 23 Feb 2026 15:14:40 -0800
Subject: [PATCH 23/33] fuse: implement fadvise for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734738.3935739.9418702523771938984.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78070-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: D0E1217F221
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

If userspace asks us to perform readahead on a file, take i_rwsem so
that it can't race with hole punching or writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h |    3 +++
 fs/fuse/file.c       |    1 +
 fs/fuse/fuse_iomap.c |   20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index f80c1eae098af3..3e5df67db2a1fe 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -64,6 +64,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -89,6 +91,7 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_fadvise			NULL
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0828ecb20a828c..1243d0eea22a37 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3252,6 +3252,7 @@ static const struct file_operations fuse_file_operations = {
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
 	.setlease	= generic_setlease,
+	.fadvise	= fuse_iomap_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index b7614674fae9e5..df92740f1e781b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -7,6 +7,7 @@
 #include <linux/fiemap.h>
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
@@ -1978,3 +1979,22 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 		return -EFAULT;
 	return 0;
 }
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
+{
+	struct inode *inode = file_inode(file);
+	bool needlock = advice == POSIX_FADV_WILLNEED &&
+			fuse_inode_has_iomap(inode);
+	int ret;
+
+	/*
+	 * Operations creating pages in page cache need protection from hole
+	 * punching and similar ops
+	 */
+	if (needlock)
+		inode_lock_shared(inode);
+	ret = generic_fadvise(file, start, end, advice);
+	if (needlock)
+		inode_unlock_shared(inode);
+	return ret;
+}


