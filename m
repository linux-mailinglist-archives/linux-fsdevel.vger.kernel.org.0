Return-Path: <linux-fsdevel+bounces-78816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PVuBViromlF4wQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:46:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802331C17BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA0113048EF4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD453D7D8E;
	Sat, 28 Feb 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="brljaW5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DD3ECBFA
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268371; cv=none; b=qR1gY9/Wm6Wtg+rySKIv3pbWfzCTuMD8WIKN12/SJia0SV3U+5gM8TeXXTfZUjmLmQ+vY6L3EVIyxmWW5g3ZE8SLk8BpwzAYLxhs3p/PWnR4o7PlUOiOpEitjzCwKkQ09IUKbmajCNsiXQkGPkpFfXKaIjXiiMsYua3WmmkxOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268371; c=relaxed/simple;
	bh=wHApf06Jn001JLfUw7iPou2xB11/L2sBzhir9PrfmM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4oKCyllnOdJIoDE3bsyYX01Ny+KbjYcxGd/jgBLOv3aJunX913KF+UBN111UavB1DWilRKayX6CJtp9ht6URbIVzfBjYhquRyl9tPqcmRNVlh6hqVyqXvVddof5e1n3IrTNElKui61WADDJf0CWKu4Hx1y76imj2HxTnXG4RwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=brljaW5B; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id B79191D4A2;
	Sat, 28 Feb 2026 08:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me B79191D4A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772268361; bh=wHApf06Jn001JLfUw7iPou2xB11/L2sBzhir9PrfmM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brljaW5Bul1l3ijI+Lv5L060x+6ilvU4jfsOTb2EJuRXMy6B7UhwAnFCnLgm+ajbp
	 +VZ04QdLf1mSkZHnX+wd5Lfewvk3e9yO/jS5eiDVg/wZgn5qySHF65yvJb3y/INann
	 6FI2v5nDzVO4cpLuVcXAPOb7yJc4CELi4wptPJCs=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id jUCCJ0SrommvyQUA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Sat, 28 Feb 2026 08:46:00 +0000
From: David Timber <dxdt@dev.snart.me>
To: linux-fsdevel@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 1/1] exfat: add fallocate mode 0 support
Date: Sat, 28 Feb 2026 17:44:14 +0900
Message-ID: <20260228084542.485615-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260228084542.485615-1-dxdt@dev.snart.me>
References: <20260228084542.485615-1-dxdt@dev.snart.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dev.snart.me:s=00];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78816-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev.snart.me:mid,dev.snart.me:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,snart.me:email]
X-Rspamd-Queue-Id: 802331C17BD
X-Rspamd-Action: no action

Currently, the Linux (ex)FAT drivers do not employ any cluster
allocation strategy to keep fragmentation at bay. As a result, when
multiple processes are competing for new clusters to expand files in
exfat filesystem on Linux simultaneously, the files end up heavily
fragmented. HDDs are most impacted, but this could also have some
negative impact on various forms of flash memory depending on the
type of underlying technology.

For instance, modern digital cameras produce multiple media files for a
single video stream. If the application does not take the fragmentation
issue into account or the system is under memory pressure, the kernel
end up allocating clusters in said files in a interleaved manner.

Demo script:

	for (( i = 0; i < 4; i += 1 ));
	do
	    dd if=/dev/urandom iflag=fullblock bs=1M count=64 of=frag-$i &
	done
	for (( i = 0; i < 4; i += 1 ));
	do
	    wait
	done

	filefrag frag-*

Result - Linux kernel native exfat, async mount:
	780 extents found
	740 extents found
	809 extents found
	712 extents found

Result - Linux kernel native exfat, sync mount:
	1852 extents found
	1836 extents found
	1846 extents found
	1881 extents found

Result - Windows XP:
	3 extents found
	3 extents found
	3 extents found
	2 extents found

Windows kernel, on the other hand, regardless of the underlying storage
interface or the medium, seems to space out clusters for each file.
Similar strategy has to be employed by Linux fat filesystems for
efficient utilisation of storage backend.

In the meantime, userspace applications like rsync may
use fallocate to to combat this issue.

This patch may introduce a regression-like behaviour to some niche
filesystem-agnostic applications that use fallocate and proceed to
non-sequentially write to the file. Examples:

 - libtorrent's use of posix_fallocate() and the first fragment from a
   peer is near the end of the file
 - "Download accelerators" that do partial content requests(HTTP 206)
   in multiple threads writing to the same file

The delay incurred in such use cases is documented in WinAPI. Patches
that add the ioctl equivalents to the WinAPI function
SetFileValidData() and `fsutil file queryvaliddata ...` will follow.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/file.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 90cd540afeaa..4ab7e7e90ae6 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -13,6 +13,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/writeback.h>
 #include <linux/filelock.h>
+#include <linux/falloc.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -90,6 +91,45 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	return -EIO;
 }
 
+/*
+ * Preallocate space for a file. This implements exfat's fallocate file
+ * operation, which gets called from sys_fallocate system call. User space
+ * requests len bytes at offset. In contrary to fat, we only support "mode 0"
+ * because by leaving the valid data length(VDL) field, it is unnecessary to
+ * zero out the newly allocated clusters.
+ */
+static long exfat_fallocate(struct file *file, int mode,
+			  loff_t offset, loff_t len)
+{
+	struct inode *inode = file->f_mapping->host;
+	loff_t newsize = offset + len;
+	int err = 0;
+
+	/* No support for other modes */
+	if (mode != 0)
+		return -EOPNOTSUPP;
+
+	/* No support for dir */
+	if (!S_ISREG(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	inode_lock(inode);
+
+	if (newsize <= i_size_read(inode))
+		goto error;
+
+	/* This is just an expanding truncate */
+	err = exfat_cont_expand(inode, newsize);
+
+error:
+	inode_unlock(inode);
+
+	return err;
+}
+
 static bool exfat_allow_set_time(struct mnt_idmap *idmap,
 				 struct exfat_sb_info *sbi, struct inode *inode)
 {
@@ -771,6 +811,7 @@ const struct file_operations exfat_file_operations = {
 	.fsync		= exfat_file_fsync,
 	.splice_read	= exfat_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.fallocate	= exfat_fallocate,
 	.setlease	= generic_setlease,
 };
 
-- 
2.53.0.1.ga224b40d3f.dirty


