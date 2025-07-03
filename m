Return-Path: <linux-fsdevel+bounces-53859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B21AAF846C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025B81C873A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 23:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104672DCF44;
	Thu,  3 Jul 2025 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sUg3QCuQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sUg3QCuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97442DAFC0
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586189; cv=none; b=UpiEV47Pe9r8QIXCXILfp005VC6GmHfwLzbUxZnjz5s9EeP1wWtu9z8dMlMiNPt1Qe+3UiZ5LdboZv4p911aDZC0V5MxMNEpGNB3UbNWsvp0URfx4UfY9Yo5yVLcfT3OEp9FLoEzsIpdkifLD9wEYMYqftYWdMlnJqNWVpOFlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586189; c=relaxed/simple;
	bh=75y3Px05Z2SCP0QTSvJJlzyXREDkvXMUk4f3xDf5Jow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ibb820jyYcdMfg6Qaf3j+tweYbal6n0sx+SYR05i5L8fOBiWhJd6apaaE1NcTEq6Wo4JvT9RPb5fmpbnBWPN9q/tWwtAWjGrX4wl4xNyMjwKK9xYSRhsVPA9p2mGBFk+wF+GXjr6b+02c5tdAEDvGb9gzudZuGcpnkuYl6bNGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sUg3QCuQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sUg3QCuQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44A8D21197;
	Thu,  3 Jul 2025 23:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SypzCC3/FitH1i1ErP5vtb8ti6b7l4kfRplJHH5n3P8=;
	b=sUg3QCuQtEqEvGU3d067y5fqbu9WTRGeYt3VgmgJ4sPBU8ZHHXV7CM55KE4vhXpRd1q/xf
	96pqhk171KdVVjOT5BsoihmMCSus8JkLMqWDF4G9l/AjcyCNURINVY3smMiqwciGMFTtbR
	3B4A/pDGgubkfSxMnmUUVbyV8+dWa/k=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SypzCC3/FitH1i1ErP5vtb8ti6b7l4kfRplJHH5n3P8=;
	b=sUg3QCuQtEqEvGU3d067y5fqbu9WTRGeYt3VgmgJ4sPBU8ZHHXV7CM55KE4vhXpRd1q/xf
	96pqhk171KdVVjOT5BsoihmMCSus8JkLMqWDF4G9l/AjcyCNURINVY3smMiqwciGMFTtbR
	3B4A/pDGgubkfSxMnmUUVbyV8+dWa/k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8303613983;
	Thu,  3 Jul 2025 23:42:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id APt/EXkVZ2j7AQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 03 Jul 2025 23:42:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v3 5/6] btrfs: implement shutdown ioctl
Date: Fri,  4 Jul 2025 09:12:18 +0930
Message-ID: <b2e79c1e16e498b9eb99447499a0d8a353ff6d21.1751577459.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751577459.git.wqu@suse.com>
References: <cover.1751577459.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
index 2f3b7be13bea..94eb7a8499db 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5194,6 +5194,36 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
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
@@ -5201,6 +5231,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	void __user *argp = (void __user *)arg;
+	/* If @arg is just an unsigned long value. */
+	unsigned long flags;
 
 	switch (cmd) {
 	case FS_IOC_GETVERSION:
@@ -5349,6 +5381,14 @@ long btrfs_ioctl(struct file *file, unsigned int
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


