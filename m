Return-Path: <linux-fsdevel+bounces-53406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB6AEEDA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02DA17E946
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 05:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1A22D7B5;
	Tue,  1 Jul 2025 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tsY9X44J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tsY9X44J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340411E7C32
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348010; cv=none; b=KZzLKEaqVOtgRS0iCUFWfrWRt3V+jHiPg6KIVEn4BMzvgq/HzTuvUFObgr5pXA/WWRD/r8blSpy7dXFW/szV/4r2dZtvRXLBux0YcM4H9e8VUVuozp31m9sdw5/IaaOFN3ZCXK6D6UXitbuTe58QD/eJSZKKPTjywZK3xEl/TXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348010; c=relaxed/simple;
	bh=bgZs6LGSs1zj2rTGuBu/wshFf6O5gh0/DLcj9jfiBzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xng2M5g7i/ejgwMH1W5J+jMNZg4TmgG3jps2kKc9gyFpToewoijvtPz483VAkO/dtM4MrJa/QN0T+RLwp4BlOIXSHQz6HhbitqbJtGrBUtA6nbyRu+ZuVSHK1cZ8CQKiYwLREG10hChIxR2e98SfQ/XOFjwR5+5H51ylARR9pbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tsY9X44J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tsY9X44J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 806291F445;
	Tue,  1 Jul 2025 05:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751347990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNRl3FVJ9e5XLtw95jNS08yR5UQSGrUjDFL8RRQH7ig=;
	b=tsY9X44JpGaF04BcEdZD0S4NfyQwEllgTRsR/s/iez+PVDdtqKABrqH5zp+8V3MTv8f1eD
	NAUoZJCyRw1Y7cQIChn9ZaOkCRHq2xJpiuMkvtfuYoeScZMa0a62LzHKXSy+IgTf5X+adY
	oflPbJ1V0uW9SCIL8MoGSf6g4Xu9KNs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tsY9X44J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751347990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNRl3FVJ9e5XLtw95jNS08yR5UQSGrUjDFL8RRQH7ig=;
	b=tsY9X44JpGaF04BcEdZD0S4NfyQwEllgTRsR/s/iez+PVDdtqKABrqH5zp+8V3MTv8f1eD
	NAUoZJCyRw1Y7cQIChn9ZaOkCRHq2xJpiuMkvtfuYoeScZMa0a62LzHKXSy+IgTf5X+adY
	oflPbJ1V0uW9SCIL8MoGSf6g4Xu9KNs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2F0E13890;
	Tue,  1 Jul 2025 05:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8EohIRRzY2hEYQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 01 Jul 2025 05:33:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v2 5/6] btrfs: implement shutdown ioctl
Date: Tue,  1 Jul 2025 15:02:38 +0930
Message-ID: <7572ae432f4caebf074e0b9db8a88a502aed3217.1751347436.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751347436.git.wqu@suse.com>
References: <cover.1751347436.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 806291F445
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

The shutdown ioctl should follow the XFS one, which use magic number 'X',
and ioctl number 125, with a u32 as flags.

For now btrfs don't distinguish DEFAULT and LOGFLUSH flags (just like
f2fs), both will freeze the fs first (implies committing the current
transaction), setting the SHUTDOWN flag and finally thaw the fs.

For NOLOGFLUSH flag, the freeze/thaw part is skipped thus the current
transaction is aborted.

The new shutdown ioctl is hidden behind experimental features for more
testing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c           | 40 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  9 +++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d86967bd3c9c..05b13d66f0f7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5212,6 +5212,36 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
 	return 0;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_emergency_shutdown(struct btrfs_fs_info *fs_info, u32 flags)
+{
+	int ret = 0;
+
+	if (flags >= BTRFS_SHUTDOWN_FLAGS_LAST)
+		return -EINVAL;
+
+	if (btrfs_is_shutdown(fs_info))
+		return 0;
+
+	switch (flags) {
+	case BTRFS_SHUTDOWN_FLAGS_LOGFLUSH:
+	case BTRFS_SHUTDOWN_FLAGS_DEFAULT:
+		ret = freeze_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
+		if (ret)
+			return ret;
+		btrfs_force_shutdown(fs_info);
+		ret = thaw_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
+		if (ret)
+			return ret;
+		break;
+	case BTRFS_SHUTDOWN_FLAGS_NOLOGFLUSH:
+		btrfs_force_shutdown(fs_info);
+		break;
+	}
+	return ret;
+}
+#endif
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5219,6 +5249,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	void __user *argp = (void __user *)arg;
+	/* If @arg is just an unsigned long value. */
+	unsigned long flags;
 
 	switch (cmd) {
 	case FS_IOC_GETVERSION:
@@ -5367,6 +5399,14 @@ long btrfs_ioctl(struct file *file, unsigned int
 #endif
 	case BTRFS_IOC_SUBVOL_SYNC_WAIT:
 		return btrfs_ioctl_subvol_sync(fs_info, argp);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	case BTRFS_IOC_SHUTDOWN:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(flags, (__u32 __user *)arg))
+			return -EFAULT;
+		return btrfs_emergency_shutdown(fs_info, flags);
+#endif
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dd02160015b2..8f6324cf15d9 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1096,6 +1096,12 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 };
 
+/* Flags for IOC_SHUTDOWN, should match XFS' flags. */
+#define BTRFS_SHUTDOWN_FLAGS_DEFAULT	0x0
+#define BTRFS_SHUTDOWN_FLAGS_LOGFLUSH	0x1
+#define BTRFS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2
+#define BTRFS_SHUTDOWN_FLAGS_LAST	0x3
+
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
 				   struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_DEFRAG _IOW(BTRFS_IOCTL_MAGIC, 2, \
@@ -1217,6 +1223,9 @@ enum btrfs_err_code {
 #define BTRFS_IOC_SUBVOL_SYNC_WAIT _IOW(BTRFS_IOCTL_MAGIC, 65, \
 					struct btrfs_ioctl_subvol_wait)
 
+/* Shutdown ioctl should follow XFS's interfaces, thus not using btrfs magic. */
+#define BTRFS_IOC_SHUTDOWN	_IOR('X', 125, __u32)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.50.0


