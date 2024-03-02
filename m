Return-Path: <linux-fsdevel+bounces-13380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4609086F2A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 23:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B4A1C20A09
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 22:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857D45941;
	Sat,  2 Mar 2024 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mJf2tL9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD844C7C
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709416938; cv=none; b=u7MY5Nn+URnkMNuVTbCGwA4fLyfcu6hj28pK75VpKoIzZGy+3xOC2OzFsUzUjjEWT2G6t1ykO0hfagWyHZG4gcEyb6WnQGYYEindPVcKrihOfaf4lS8AIr51JlpjZxLi6NVF18UaF2lJpx3gkpQ+itX06Lf4ZSonwD7sGotXWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709416938; c=relaxed/simple;
	bh=D3XN16M6Y57uWxVwLnlF9xADST6YeevavrFwllCfXWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EawjLdOeNW554ZUBhT4zMDGIy6n6IYf5uwKYYO1YLwJvUZ4L6k/QskkilCoKyWAM6J+AgWqlm5P1YP2j6cjwsRNRGqcPMFECPVUgLYKTPWp95xOJzKVbkuKTgyoUNbykXp77hwm052YFp/zt/PYZOWz0s7SCAu5KEINSe1yTUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mJf2tL9q; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709416934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aqe1bsXqpWMOsaSaAwaBLUQoehzaMA/zwKYXylUSUEI=;
	b=mJf2tL9qJVNFMI5UHcD3vg9GZUQH6OCyFLF9wtJHzwJPuNkRtKo5Pz4nagtiMAa6kNdzMy
	hHC7/Teu0KO0RxPW0Yo9pwdNixmvQmt9Xs3KeGDhSZ44q7Da5CZMNbgBHmM3S36Vt5V27V
	C29Oodz0kJ7tlOMG9Bq3eu8FoWPmQBw=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH] statx: stx_vol
Date: Sat,  2 Mar 2024 17:02:03 -0500
Message-ID: <20240302220203.623614-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a new statx field for (sub)volume identifiers.

This includes bcachefs support; we'll definitely want btrfs support as
well.

Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>
---
 fs/bcachefs/fs.c          | 3 +++
 fs/stat.c                 | 1 +
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 4 +++-
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 3f073845bbd7..d82f7f3f0670 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -840,6 +840,9 @@ static int bch2_getattr(struct mnt_idmap *idmap,
 	stat->blksize	= block_bytes(c);
 	stat->blocks	= inode->v.i_blocks;
 
+	stat->vol	= inode->ei_subvol;
+	stat->result_mask |= STATX_VOL;
+
 	if (request_mask & STATX_BTIME) {
 		stat->result_mask |= STATX_BTIME;
 		stat->btime = bch2_time_to_timespec(c, inode->ei_inode.bi_otime);
diff --git a/fs/stat.c b/fs/stat.c
index 77cdc69eb422..80d5f7502d99 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -658,6 +658,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_vol = stat->vol;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 52150570d37a..9dc1b493ef1f 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -53,6 +53,7 @@ struct kstat {
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u64		change_cookie;
+	u64		vol;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 2f2ee82d5517..ae090d67946d 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -126,8 +126,9 @@ struct statx {
 	__u64	stx_mnt_id;
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	__u64	stx_vol;	/* Subvolume identifier */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -155,6 +156,7 @@ struct statx {
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+#define STATX_VOL		0x00008000U	/* Want/got stx_vol */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.43.0


