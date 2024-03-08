Return-Path: <linux-fsdevel+bounces-13963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2903D875C5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868762830E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 02:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BCA24A08;
	Fri,  8 Mar 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sd1Lmp61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD5291E
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864968; cv=none; b=ekAOZaeByZA0/b5YYhV3g0iUM1Sv7CEAMpVDC/zIuJ9jOMoVGVswIAxlkUy87VB+VjraqDyCkBVCd+JB90liwXx6cNOD4dsc7SAm4zZa5ph7sX3rdLRotgPG5YJeOt0dAKs0P8laV7qQoZdxs3k1aOsfw43Z4ZEgQHQv/FlZoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864968; c=relaxed/simple;
	bh=duRSN3TaPjNn+KjXCQlU87+ksRGL7u0yBrkBxCW39Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4hN6eIxhgOWQnQzEfbRN3m53nARONQke8uzU9TNSoLDwQgtkSrXs+d+zHU7kWsPukPkvawGwY9LSU7ldmfmyZSjXbIGqAQRcD1q5UOCBiCmMZ5T/gDMEKRSdeJgO2mXJMnl95E0xWNnymmKO2BbmCD74h1LLxNaAA2uhb+2KUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sd1Lmp61; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709864964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G5i/vJIJMCUtMZCyLr/3KzDshYesTXRY7gpXnOJ9PWg=;
	b=sd1Lmp61w01alOwcbQYwZBNP4+/A9BPUOHbrEKwNDmZ8l4Xf2kOXZZooZHVeceGplwV0ZY
	w0g38MGHk1toMhnkDrraHPIMw8iPsAMuOZRPbwEplW47cPoEyYm0IgZKPQ/JgGddIDi4Ay
	iXRJOcaNEsiqIzOnYOCycsA+CK5xgqk=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: 
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2] statx: stx_subvol
Date: Thu,  7 Mar 2024 21:29:12 -0500
Message-ID: <20240308022914.196982-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a new statx field for (sub)volume identifiers, as implemented by
btrfs and bcachefs.

This includes bcachefs support; we'll definitely want btrfs support as
well.

Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/fs.c          | 3 +++
 fs/stat.c                 | 1 +
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 4 +++-
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 3f073845bbd7..6a542ed43e2c 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -840,6 +840,9 @@ static int bch2_getattr(struct mnt_idmap *idmap,
 	stat->blksize	= block_bytes(c);
 	stat->blocks	= inode->v.i_blocks;
 
+	stat->subvol	= inode->ei_subvol;
+	stat->result_mask |= STATX_SUBVOL;
+
 	if (request_mask & STATX_BTIME) {
 		stat->result_mask |= STATX_BTIME;
 		stat->btime = bch2_time_to_timespec(c, inode->ei_inode.bi_otime);
diff --git a/fs/stat.c b/fs/stat.c
index 77cdc69eb422..70bd3e888cfa 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -658,6 +658,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_subvol = stat->subvol;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 52150570d37a..bf92441dbad2 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -53,6 +53,7 @@ struct kstat {
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u64		change_cookie;
+	u64		subvol;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 2f2ee82d5517..67626d535316 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -126,8 +126,9 @@ struct statx {
 	__u64	stx_mnt_id;
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	__u64	stx_subvol;	/* Subvolume identifier */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -155,6 +156,7 @@ struct statx {
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+#define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.43.0


