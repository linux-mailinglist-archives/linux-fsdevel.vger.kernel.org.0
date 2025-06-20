Return-Path: <linux-fsdevel+bounces-52294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD46AE1354
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1214D4A346E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8AC21C19C;
	Fri, 20 Jun 2025 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SD1UrnbZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SD1UrnbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2E21B8EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398483; cv=none; b=SiJNunc3CeIND3k9s7bsHY6iPSA2Ml22nuifYUQob6StEbQHZGmzRVdhDY9MTTnRYEQuXlaoJ9nkI8H2g6MF2Da4hiRwE/Q0ixRWU6x5mmGBdbUe8OEw42WKO3KbplDdX2gr+VH8y/5oAgrFZ5OogNCbxuTJ7YtKcMIakSKzyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398483; c=relaxed/simple;
	bh=rtvJy1UsN/wRdI2TPdAxKVLgJrzRkK1Hr5HpmaBYKA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1UPWb+GXVLiQc2Cctqvzmv+mHIqNMTk+3aGTc8e1QMwvjH+Ku6zAfQOWwnhkVRntNBohasbVOjY0FNzjZXrtosdBF2eOnCPf1v8B/AKUKCZK3+eMQaWfjmiPymyCSSh2jLzXKwaZLArAX3jARlu77lGIy2JzskQldTKyqiNGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SD1UrnbZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SD1UrnbZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D113E1F38D;
	Fri, 20 Jun 2025 05:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgDUSTqxtKUC+i7JL8W72UsA9fheGqsknOwuX8Wu0Yw=;
	b=SD1UrnbZP+/SQ1JwndNjKSUbs24Q3HAIHqMhtIVQ4i0xS1mdX5FUc09ut3S6yX7bR9SbOF
	qaXSmyzFe+t0ndVxl53C933gVDXt2+NCQuYOKFnOVmALKr/zV8CJGPE4YHSJLRRdmiSFnP
	NCIzHhuLrb+QBPeV/1ed44QoATFYQcY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgDUSTqxtKUC+i7JL8W72UsA9fheGqsknOwuX8Wu0Yw=;
	b=SD1UrnbZP+/SQ1JwndNjKSUbs24Q3HAIHqMhtIVQ4i0xS1mdX5FUc09ut3S6yX7bR9SbOF
	qaXSmyzFe+t0ndVxl53C933gVDXt2+NCQuYOKFnOVmALKr/zV8CJGPE4YHSJLRRdmiSFnP
	NCIzHhuLrb+QBPeV/1ed44QoATFYQcY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E73C13318;
	Fri, 20 Jun 2025 05:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oOKENAv2VGi2NAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 20 Jun 2025 05:47:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH RFC 4/6] btrfs: implement shutdown ioctl
Date: Fri, 20 Jun 2025 15:17:27 +0930
Message-ID: <33a2119f23fd6ced841c619d5467e2e2e4d96cdc.1750397889.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750397889.git.wqu@suse.com>
References: <cover.1750397889.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

The shutdown interface should all follow the XFS one, which use magic
'X', and ioctl number 125, with a u32 as flags.

For now btrfs doesn't follow the flags, as there is no traditional
journal in btrfs (the log tree is to mostly speed up fsync).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c           | 18 ++++++++++++++++++
 include/uapi/linux/btrfs.h |  9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 84a516053a8e..1fd7486af851 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5213,6 +5213,16 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
 	return 0;
 }
 
+static int btrfs_emergency_shutdown(struct btrfs_fs_info *fs_info, u32 flags)
+{
+	if (flags >= BTRFS_SHUTDOWN_FLAGS_LAST)
+		return -EINVAL;
+
+	/* For now, btrfs do not distinguish the different flags. */
+	btrfs_shutdown(fs_info);
+	return 0;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5368,6 +5378,14 @@ long btrfs_ioctl(struct file *file, unsigned int
 #endif
 	case BTRFS_IOC_SUBVOL_SYNC_WAIT:
 		return btrfs_ioctl_subvol_sync(fs_info, argp);
+	case BTRFS_IOC_SHUTDOWN:
+		u32 flags;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(flags, (__u32 __user *)arg))
+			return -EFAULT;
+		return btrfs_emergency_shutdown(fs_info, flags);
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
2.49.0


