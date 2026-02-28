Return-Path: <linux-fsdevel+bounces-78818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLV0AmyromlF4wQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:46:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3391C17CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FB1630432E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3774326ED59;
	Sat, 28 Feb 2026 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="kQV5o49X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783782874E0
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268386; cv=none; b=Tn7UIW5VVuiFtSaY5m/1kgGN5Jtr3tH8JDasgNWm9NAmIr3pDkIWXBvIe7+5dwmww167+MuCNQxdr2zleXRP1I+K5Qe8RAN7RfGskiYAqhpK/1lXFAIooqxRWVreffah9jOVfJ15hcUwl3fod3nQ0PuP5SoYetP3aLkLr4ksqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268386; c=relaxed/simple;
	bh=dXF/CFMfjYY05nlbgntr0rvtfPBzQ2xDMe5UrHDjC58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3MbPJs4b0S2mJ88isbtEHqkLJKd3O/iV/yLiymdP8V0eu+8VBytGy7ycwR8cpxMMwiHwTAImhRntESPZAGlfUF9PMyN5WDnvKa8XzC6brB+9s7IusCd8fMfSu9HAVQ/Up3W8b11McV0sEWkwzmoVr/1r6+GKrwRFjwGZ8fQB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=kQV5o49X; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 915DB1D4A7;
	Sat, 28 Feb 2026 08:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 915DB1D4A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772268384; bh=dXF/CFMfjYY05nlbgntr0rvtfPBzQ2xDMe5UrHDjC58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQV5o49XZBpYwVoxlOHzNY5Pz1IP4+Ugnsycc7+vpdHk3HT3L3vlyZ03jl1MRTAUT
	 fY8Fi8x4X209K48q1KeScdW2Qe2fONG8C+COJdgL+XSnfQvcgiwmDU8GVqIts3SGz/
	 ivOkQv7z6c91CyXkLz3mmWFS3+H+0zjb19njvsQE=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id mmLrFF2romnWyQUA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Sat, 28 Feb 2026 08:46:23 +0000
From: David Timber <dxdt@dev.snart.me>
To: linux-fsdevel@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 1/1] exfat: Valid Data Length(VDL) ioctl
Date: Sat, 28 Feb 2026 17:46:07 +0900
Message-ID: <20260228084610.487048-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260228084610.487048-1-dxdt@dev.snart.me>
References: <20260228084610.487048-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[dev.snart.me,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dev.snart.me:s=00];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78818-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dxdt@dev.snart.me,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dev.snart.me:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev.snart.me:mid,dev.snart.me:dkim,snart.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A3391C17CB
X-Rspamd-Action: no action

Currently, when a file gets truncated written past the VDL, significant
IO delay can occur as the skipped range [VDL, offset) has to be zeroed
out. Some users may find this unacceptible.

Some niche applications(especially embedded systems) may want to
eliminate the delay by manipulating the VDL with the trade-off of
increased risk from garbage data left on the device.

To tackle the IO delay issue, the commit introduces two ioctl,

	#define EXFAT_IOC_GET_VALID_DATA	_IOR('r', 0x14, __u64)
	#define EXFAT_IOC_SET_VALID_DATA	_IOW('r', 0x15, __u64)

which correspond to

	`fsutil file queryvaliddata` command
	SetValidData() WinAPI

respectively. With EXFAT_IOC_GET_VALID_DATA, applications could assess
the delay that may incur and make decisions before seeking past the
VDL to write. With EXFAT_IOC_SET_VALID_DATA, privileged applications
may choose to eliminate the delay and deal with garbage data
themselves.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/file.c            | 93 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/exfat.h | 10 +++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 90cd540afeaa..f3b6eca9b1e6 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -449,6 +449,91 @@ static int exfat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 	return err;
 }
 
+static int exfat_ioctl_get_valid_data(struct inode *inode, unsigned long arg)
+{
+	u64 valid_size;
+
+	/*
+	 * Tt doesn't really make sense to acquire lock for a getter op but we
+	 * have to stay consistent with the grandfather clause -
+	 * ioctl_get_attributes().
+	 */
+	inode_lock(inode);
+	valid_size = EXFAT_I(inode)->valid_size;
+	inode_unlock(inode);
+
+	return put_user(valid_size, (__u64 __user *)arg);
+}
+
+static int exfat_ioctl_set_valid_data(struct file *file, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	int err = 0;
+	u64 new_valid_size;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* No support for dir */
+	if (!S_ISREG(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	err = get_user(new_valid_size, (__u64 __user *)arg);
+	if (err)
+		return err;
+
+	err = mnt_want_write_file(file);
+	if (err)
+		return err;
+
+	inode_lock(inode);
+
+	/* No security check - this is already a privileged op. */
+
+	if (ei->valid_size > new_valid_size || i_size_read(inode) < new_valid_size) {
+		/*
+		 * No change requested. The actual up/down truncation of isize
+		 * is not the scope of the ioctl. SetFileValidData() WinAPI
+		 * treats this case as an error, so we do the same here as well.
+		 */
+		err = -EINVAL;
+		goto out_unlock_inode;
+	}
+	if (ei->valid_size == new_valid_size)
+		/* No op. Don't change mtime. */
+		goto out_unlock_inode;
+
+	ei->valid_size = new_valid_size;
+	/*
+	 * DO NOT invalidate cache here!
+	 *
+	 * The cache incoherency in range [ei->valid_size, new_valid_size) after
+	 * this point is intentional. The point of this ioctl is minimising I/O
+	 * from the shortcoming of FAT/NTFS, not correctness. Neither we nor the
+	 * userspace should care about the garbage data.
+	 */
+
+	/*
+	 * Windows kernel does not update mtime of the file upon successful
+	 * SetFileValidData() call. We think we should - garbage data is still
+	 * data that's part of the contents of the file, so...
+	 */
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	/*
+	 * Notify the size change although isize didn't actually change. This is
+	 * not conformant but a good measure for any userspace process that
+	 * wishes to get VDL change notification through the standard inotify.
+	 */
+	fsnotify_change(file->f_path.dentry, ATTR_SIZE | ATTR_MTIME);
+	mark_inode_dirty(inode);
+
+out_unlock_inode:
+	inode_unlock(inode);
+	mnt_drop_write_file(file);
+	return err;
+}
+
 static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 {
 	struct fstrim_range range;
@@ -544,10 +629,17 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	u32 __user *user_attr = (u32 __user *)arg;
 
 	switch (cmd) {
+	/* inode-specific ops */
 	case FAT_IOCTL_GET_ATTRIBUTES:
 		return exfat_ioctl_get_attributes(inode, user_attr);
 	case FAT_IOCTL_SET_ATTRIBUTES:
 		return exfat_ioctl_set_attributes(filp, user_attr);
+	case EXFAT_IOC_GET_VALID_DATA:
+		return exfat_ioctl_get_valid_data(inode, arg);
+	case EXFAT_IOC_SET_VALID_DATA:
+		return exfat_ioctl_set_valid_data(filp, arg);
+
+	/* fs-wide ops */
 	case EXFAT_IOC_SHUTDOWN:
 		return exfat_ioctl_shutdown(inode->i_sb, arg);
 	case FITRIM:
@@ -556,6 +648,7 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
 	case FS_IOC_SETFSLABEL:
 		return exfat_ioctl_set_volume_label(inode->i_sb, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/exfat.h b/include/uapi/linux/exfat.h
index 46d95b16fc4b..557785417a2f 100644
--- a/include/uapi/linux/exfat.h
+++ b/include/uapi/linux/exfat.h
@@ -12,7 +12,15 @@
  * exfat-specific ioctl commands
  */
 
-#define EXFAT_IOC_SHUTDOWN _IOR('X', 125, __u32)
+#define EXFAT_IOC_SHUTDOWN		_IOR('X', 125, __u32)
+/* Get the current valid data length(VDL) of a file */
+#define EXFAT_IOC_GET_VALID_DATA	_IOR('r', 0x14, __u64)
+/*
+ * Set the valid data length(VDL) of a file. This is equivalent to
+ * SetValidData() in WinAPI. Due to security implications, CAP_SYS_ADMIN is
+ * required(see capabilities(7)).
+ */
+#define EXFAT_IOC_SET_VALID_DATA	_IOW('r', 0x15, __u64)
 
 /*
  * Flags used by EXFAT_IOC_SHUTDOWN
-- 
2.53.0.1.ga224b40d3f.dirty


