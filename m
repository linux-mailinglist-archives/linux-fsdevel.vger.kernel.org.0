Return-Path: <linux-fsdevel+bounces-76151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIgkEuCWgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:34:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB106D54AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4FFC30369D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEC438F24C;
	Tue,  3 Feb 2026 06:30:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA8388873;
	Tue,  3 Feb 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100225; cv=none; b=fr5l4DJWF5ArtruslxlfvZEjQXzLt40Yt+lDvEHvcUw6Db2hMSgMD6fQLfD6m9pnrimvetcUsd3Eg7RnaUMnxTs1sfdAMY23WfkzCaaoKXy6+2DIv7+EjEB0PxACSK0ApOiwCMwSHDGxC9xwif346i6TL7Raqb1bzB68Bnl46Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100225; c=relaxed/simple;
	bh=YCpvPDEa2v8A4k0A4a3t6qIctYRGO4EpHlhJMUoxfiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HevkDG2tZJJrTdNGz3f1EONbM+pY0w+/hGIbUadbaf8kL841olxwXREaIHs3OJxDmy0Ed21R68Oio1+b14drGtHB3xR5O405VqtkM4a/6pQkH86yHWRuhrc2JaqYRZ7Cl74RN5vZY8kyhzxsuVV74OpKz4c+G5z6bqDlcEeFui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4tqr3dMzzYQv0D;
	Tue,  3 Feb 2026 14:29:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 712C040570;
	Tue,  3 Feb 2026 14:30:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S25;
	Tue, 03 Feb 2026 14:30:15 +0800 (CST)
From: Zhang Yi <yi.zhang@huawei.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next v2 21/22] ext4: partially enable iomap for the buffered I/O path of regular files
Date: Tue,  3 Feb 2026 14:25:21 +0800
Message-ID: <20260203062523.3869120-22-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203062523.3869120-1-yi.zhang@huawei.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S25
X-Coremail-Antispam: 1UD129KBjvJXoWxAryUXw4fuF1fCF18AFyrJFb_yoWrur4Upr
	9xKryrGw4DXas29w4ftr4UZr1Yv3WxG3yUW3yS9rs8ZFyDJw1IqF1UtF1rAF15JrWrWw4a
	qF40kr1UursxCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjsIEF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI
	8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAI
	w28IcVAKzI0EY4vE52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1-zst
	UUUUU==
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76151-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: EB106D54AA
X-Rspamd-Action: no action

Partially enable iomap for the buffered I/O path of regular files. We
now support default filesystem features, mount options, and the bigalloc
feature. However, inline data, fs_verity, fs_crypt, online
defragmentation, and data=journal mode are not yet supported. Some of
these features are expected to be gradually supported in the future. The
filesystem will automatically fall back to the original buffered_head
path if these mount options or features are enabled.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h      |  1 +
 fs/ext4/ext4_jbd2.c |  1 +
 fs/ext4/ialloc.c    |  1 +
 fs/ext4/inode.c     | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 520f6d5dcdab..259c6e780e65 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3064,6 +3064,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
 void ext4_set_inode_mapping_order(struct inode *inode);
+void ext4_enable_buffered_iomap(struct inode *inode);
 int ext4_nonda_switch(struct super_block *sb);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 05e5946ed9b3..f587bfbe8423 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -16,6 +16,7 @@ int ext4_inode_journal_mode(struct inode *inode)
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
+	    !ext4_inode_buffered_iomap(inode) &&
 	    !test_opt(inode->i_sb, DELALLOC))) {
 		/* We do not support data journalling for encrypted data */
 		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b20a1bf866ab..dfa6f60f67b3 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1334,6 +1334,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
+	ext4_enable_buffered_iomap(inode);
 	ext4_set_inode_mapping_order(inode);
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 77dcca584153..bbdd0bb3bc8b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -903,6 +903,9 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 
 	if (ext4_has_inline_data(inode))
 		return -ERANGE;
+	/* inodes using the iomap buffered I/O path should not go here. */
+	if (WARN_ON_ONCE(ext4_inode_buffered_iomap(inode)))
+		return -EINVAL;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
@@ -2771,6 +2774,12 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	if (!mapping->nrpages || !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		goto out_writepages;
 
+	/* inodes using the iomap buffered I/O path should not go here. */
+	if (WARN_ON_ONCE(ext4_inode_buffered_iomap(inode))) {
+		ret = -EINVAL;
+		goto out_writepages;
+	}
+
 	/*
 	 * If the filesystem has aborted, it is read-only, so return
 	 * right away instead of dumping stack traces later on that
@@ -5730,6 +5739,31 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
 	return -EFSCORRUPTED;
 }
 
+void ext4_enable_buffered_iomap(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE))
+		return;
+
+	/* Unsupported Features */
+	if (ext4_has_feature_inline_data(sb))
+		return;
+	if (ext4_has_feature_verity(sb))
+		return;
+	if (ext4_has_feature_encrypt(sb))
+		return;
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
+	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
+		return;
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+		return;
+
+	ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+}
+
 void ext4_set_inode_mapping_order(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
@@ -6015,6 +6049,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 
+	ext4_enable_buffered_iomap(inode);
+
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
-- 
2.52.0


