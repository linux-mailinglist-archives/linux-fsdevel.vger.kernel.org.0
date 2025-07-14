Return-Path: <linux-fsdevel+bounces-54799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75EB035B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A25189392D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062C2116F6;
	Mon, 14 Jul 2025 05:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k1T9ik+d";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QMy6jbHe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB221FCF7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470810; cv=none; b=btCZnvlJJGsxiV2CkiEX7/FUOcYeJP0Nf6vBWVHyF6NpVYy2E2wx0K4W7QVqjYdxejSAp4Ja9S9aTX/x8SK5YsD40gGeOodPnbAplZgV2GLuYqi+jY9+wMyCHPImO7QmGFCT7IE74CAkc8A8PT/JxZHDgjgUyRNZIAhyjl6QLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470810; c=relaxed/simple;
	bh=rFbzwUgm8vGW4nvFPjFW6QAdK09pA/Kib19ok4ir7b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYXAjByIZc1ZKBv9R5R5F1JbxG8aILF6gL2rd/uf9yrVqYKJk5n6zWa3Ynyk5E2hZfqozKZgJgqe94RUsySVtd84nsyV2pHY2cL02r21nfxQTFFXWwMY/ops9JXDnK107g2ej2gy6JWnvDI6hQvISwAEsvOd5slF+I2ju/xQfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k1T9ik+d; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QMy6jbHe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA1D71F38D;
	Mon, 14 Jul 2025 05:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SqO7sQ/enmAv3X0Ouh2PdaRw8X5eoKrwx4tEU416gM=;
	b=k1T9ik+dpWx9QNt+boySy+Z1CZVeMX9lM+fnbETOOGXDsxdwecvCpovM0z55JChForInzu
	JMabIaJI5wTmaPvmxxRAnPqP+MO+nrzl6pD6hpSrTVppp6fRZ2Eh+/OdVlW1CNdjuHKLnE
	zZ9mSp7bM6FlzylQNJ42RdXzy14hqBE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SqO7sQ/enmAv3X0Ouh2PdaRw8X5eoKrwx4tEU416gM=;
	b=QMy6jbHeJJ/DrKlRA96nTY78eXVMdnevHjXBEFFRsQy+Do+hrIPICfQWnhNZdYADPZKCUL
	bhpr/MAJPasPRDdbNMXH/T+kqpnUTfp8mQx3U6h5yE4XtVYQabYvhVdhl0AtqoIUkVNbbx
	qZSAlEDApjJcxwa2AqQGdt2DlA1G0go=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA27D138A1;
	Mon, 14 Jul 2025 05:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QBvnJgmVdGhadQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 14 Jul 2025 05:26:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v5 5/6] btrfs: implement shutdown ioctl
Date: Mon, 14 Jul 2025 14:56:01 +0930
Message-ID: <f278d2106f52dadcb0bfcd0478ef558e8c23bcfc.1752470276.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752470276.git.wqu@suse.com>
References: <cover.1752470276.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

The shutdown ioctl should follow the XFS one, which use magic number 'X',
and ioctl number 125, with a uint32 as flags.

For now btrfs don't distinguish DEFAULT and LOGFLUSH flags (just like
f2fs), both will freeze the fs first (implies committing the current
transaction), setting the SHUTDOWN flag and finally thaw the fs.

For NOLOGFLUSH flag, the freeze/thaw part is skipped thus the current
transaction is aborted.

The new shutdown ioctl is hidden behind experimental features for more
testing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c           | 41 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  9 +++++++++
 2 files changed, 50 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 01d27f093eeb..54bb9e5f9892 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5186,6 +5186,43 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
 	return 0;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_ioctl_shutdown(struct btrfs_fs_info *fs_info, unsigned long arg)
+{
+	int ret = 0;
+	uint32_t flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(flags, (uint32_t __user *)arg))
+		return -EFAULT;
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
@@ -5341,6 +5378,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 #endif
 	case BTRFS_IOC_SUBVOL_SYNC_WAIT:
 		return btrfs_ioctl_subvol_sync(fs_info, argp);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	case BTRFS_IOC_SHUTDOWN:
+		return btrfs_ioctl_shutdown(fs_info, arg);
+#endif
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dd02160015b2..4d8201f3b4a4 100644
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
+#define BTRFS_IOC_SHUTDOWN	_IOR('X', 125, uint32_t)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.50.0


