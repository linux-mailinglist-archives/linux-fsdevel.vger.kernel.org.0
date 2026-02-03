Return-Path: <linux-fsdevel+bounces-76148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEcjEqyXgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:37:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70084D5569
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CE19300BE87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BCE38E5FA;
	Tue,  3 Feb 2026 06:30:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639F387598;
	Tue,  3 Feb 2026 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100224; cv=none; b=e2IpeC6CIploSigJ2Ty+j2IEPENeYpF87CELZ0VBqIQIUvcSqniiCElkGVFvjTUdv2Y4TuoI8oVgY14xPdfKCf79w2Tlk5HIiVozxqg1Gz2+DvnIpaZQkVLeFgG3ZCGyZKip77Nfe5atoajn9h01cBhJf847xViAPl/sb2QN4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100224; c=relaxed/simple;
	bh=gqkcO0uUZ+Eq+shjRmDg5PzjBHQRmoKJo8G4i9A8gEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxa7ACX5G7JLou+ZJ2IVbCYucHN5UGcFVfgz9rYsKTSy0G5RTidsHwpROI+I/wBdamBKHEtK5ZZprq/GnXR+JtBEGhcsrrS6XGypg6VSWu2OvdFPCwz3SdIfiM7nq+RZ1LNOKcTIlBzes5INy3Lypy6ZjOLaeh9ZVid8RyAOGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f4trK5m7ZzKHMcM;
	Tue,  3 Feb 2026 14:29:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1F0AF4056B;
	Tue,  3 Feb 2026 14:30:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S21;
	Tue, 03 Feb 2026 14:30:14 +0800 (CST)
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
Subject: [PATCH -next v2 17/22] ext4: implement partial block zero range iomap path
Date: Tue,  3 Feb 2026 14:25:17 +0800
Message-ID: <20260203062523.3869120-18-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S21
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1xAr1rZryUArWfWw48WFg_yoWrtw43pr
	WDKrW5Gr47Xr9Igr4ftFsrXr1Yk3WxKrW8Wry3Grn8Z3s0q34xKa18KFyak3W5tw47Cw4j
	qF4jyr1xKF1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyC
	LUUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76148-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70084D5569
X-Rspamd-Action: no action

Introduce a new iomap_ops instance, ext4_iomap_zero_ops, along with
ext4_iomap_block_zero_range() to implement the iomap block zeroing range
for ext4. ext4_iomap_block_zero_range() invokes iomap_zero_range() and
passes ext4_iomap_zero_begin() to locate and zero out a mapped partial
block or a dirty, unwritten partial block.

Note that zeroing out under an active handle can cause deadlock since
the order of acquiring the folio lock and starting a handle is
inconsistent with the iomap iteration procedure. Therefore,
ext4_iomap_block_zero_range() cannot be called under an active handle.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0d2852159fa3..c59f3adba0f3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4107,6 +4107,50 @@ static int ext4_iomap_buffered_da_write_end(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static int ext4_iomap_zero_begin(struct inode *inode,
+		loff_t offset, loff_t length, unsigned int flags,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct ext4_map_blocks map;
+	u8 blkbits = inode->i_blkbits;
+	unsigned int iomap_flags = 0;
+	int ret;
+
+	ret = ext4_emergency_state(inode->i_sb);
+	if (unlikely(ret))
+		return ret;
+
+	if (WARN_ON_ONCE(!(flags & IOMAP_ZERO)))
+		return -EINVAL;
+
+	ret = ext4_iomap_map_blocks(inode, offset, length, NULL, &map);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Look up dirty folios for unwritten mappings within EOF. Providing
+	 * this bypasses the flush iomap uses to trigger extent conversion
+	 * when unwritten mappings have dirty pagecache in need of zeroing.
+	 */
+	if (map.m_flags & EXT4_MAP_UNWRITTEN) {
+		loff_t offset = ((loff_t)map.m_lblk) << blkbits;
+		loff_t end = ((loff_t)map.m_lblk + map.m_len) << blkbits;
+
+		iomap_fill_dirty_folios(iter, &offset, end, &iomap_flags);
+		if ((offset >> blkbits) < map.m_lblk + map.m_len)
+			map.m_len = (offset >> blkbits) - map.m_lblk;
+	}
+
+	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
+	iomap->flags |= iomap_flags;
+
+	return 0;
+}
+
+const struct iomap_ops ext4_iomap_zero_ops = {
+	.iomap_begin = ext4_iomap_zero_begin,
+};
 
 const struct iomap_ops ext4_iomap_buffered_write_ops = {
 	.iomap_begin = ext4_iomap_buffered_write_begin,
@@ -4622,6 +4666,32 @@ static int ext4_journalled_block_zero_range(struct inode *inode, loff_t from,
 	return err;
 }
 
+static int ext4_iomap_block_zero_range(struct inode *inode, loff_t from,
+				       loff_t length, bool *did_zero)
+{
+	/*
+	 * Zeroing out under an active handle can cause deadlock since
+	 * the order of acquiring the folio lock and starting a handle is
+	 * inconsistent with the iomap writeback procedure.
+	 */
+	if (WARN_ON_ONCE(ext4_handle_valid(journal_current_handle())))
+		return -EINVAL;
+
+	/* The zeroing scope should not extend across a block. */
+	if (WARN_ON_ONCE((from >> inode->i_blkbits) !=
+			 ((from + length - 1) >> inode->i_blkbits)))
+		return -EINVAL;
+
+	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ORPHAN_FS) &&
+	    !(inode_state_read_once(inode) & (I_NEW | I_FREEING)))
+		WARN_ON_ONCE(!inode_is_locked(inode) &&
+			!rwsem_is_locked(&inode->i_mapping->invalidate_lock));
+
+	return iomap_zero_range(inode, from, length, did_zero,
+				&ext4_iomap_zero_ops,
+				&ext4_iomap_write_ops, NULL);
+}
+
 /*
  * ext4_block_zero_page_range() zeros out a mapping of length 'length'
  * starting from file offset 'from'.  The range to be zero'd must
@@ -4650,6 +4720,9 @@ static int ext4_block_zero_page_range(struct address_space *mapping,
 	} else if (ext4_should_journal_data(inode)) {
 		return ext4_journalled_block_zero_range(inode, from,
 							length, did_zero);
+	} else if (ext4_inode_buffered_iomap(inode)) {
+		return ext4_iomap_block_zero_range(inode, from, length,
+						   did_zero);
 	}
 	return ext4_block_zero_range(inode, from, length, did_zero);
 }
@@ -5063,6 +5136,18 @@ int ext4_truncate(struct inode *inode)
 			err = zero_len;
 			goto out_trace;
 		}
+		/*
+		 * inodes using the iomap buffered I/O path do not use the
+		 * ordered data mode, it is necessary to write out zeroed data
+		 * before the updating i_disksize transaction is committed.
+		 */
+		if (zero_len > 0 && ext4_inode_buffered_iomap(inode)) {
+			err = filemap_write_and_wait_range(mapping,
+					inode->i_size,
+					inode->i_size + zero_len - 1);
+			if (err)
+				return err;
+		}
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-- 
2.52.0


