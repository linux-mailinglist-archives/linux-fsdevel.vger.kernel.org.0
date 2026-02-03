Return-Path: <linux-fsdevel+bounces-76133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KafKgiWgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:30:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B310BD53F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A337300981E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F4E37C0E3;
	Tue,  3 Feb 2026 06:30:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180DE29ACCD;
	Tue,  3 Feb 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100218; cv=none; b=oDvGFJQArxTdIfknMSzN203ywc5FjZ4YGw+vOCw54gzuWIf7Tdbm4q8BlgrW0t+i5C2DsQb/GGKdKByWiI8jDUKBLeZ9Ce5X2ygLbaACSJ/VpkPDkYh9XISDZrI3YufdoOQksOotUNgVoxlz+mdMNkMAa3iW/PgGr5ofDkuuQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100218; c=relaxed/simple;
	bh=AgnJHZvpuhGhhEC/wxrYKwfc53/ALq3B5sdYyj9G4lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLDyMTZt6CAEs/WqdJZQt0NY5qOYJbDIi/meGLf1RExJipc4slWa2TPTN8GaZOuiMoWyuxGKs3w/t3dhtzOu0CZ+U5XkHTQob2DXUcjcczWZM3Ci4wwSG8BkmP3pPpwqrxOgp3ddcZ1wzDAV0GNdhwy8p+1Mqt1lqkJHJOnKeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f4trJ4VhQzKHMZj;
	Tue,  3 Feb 2026 14:29:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E8C194056B;
	Tue,  3 Feb 2026 14:30:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S7;
	Tue, 03 Feb 2026 14:30:13 +0800 (CST)
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
Subject: [PATCH -next v2 03/22] ext4: only order data when partially block truncating down
Date: Tue,  3 Feb 2026 14:25:03 +0800
Message-ID: <20260203062523.3869120-4-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUZF1UtF13Wr45Aw4kXrb_yoW5tw4rpF
	W3Kw4xJrn7G34Du3WS93W7Xr1Yk3WrCF48KFyxWw4kZ3s8Xry2yF15KFy0kay7trW3G3Wj
	vFWUtry7u3ZrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k2
	0xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
	0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFzVbDUUUU
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76133-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B310BD53F2
X-Rspamd-Action: no action

Currently, __ext4_block_zero_page_range() is called in the following
four cases to zero out the data in partial blocks:

1. Truncate down.
2. Truncate up.
3. Perform block allocation (e.g., fallocate) or append writes across a
   range extending beyond the end of the file (EOF).
4. Partial block punch hole.

If the default ordered data mode is used, __ext4_block_zero_page_range()
will write back the zeroed data to the disk through the order mode after
zeroing out.

Among the cases 1,2 and 3 described above, only case 1 actually requires
this ordered write. Assuming no one intentionally bypasses the file
system to write directly to the disk. When performing a truncate down
operation, ensuring that the data beyond the EOF is zeroed out before
updating i_disksize is sufficient to prevent old data from being exposed
when the file is later extended. In other words, as long as the on-disk
data in case 1 can be properly zeroed out, only the data in memory needs
to be zeroed out in cases 2 and 3, without requiring ordered data.

Case 4 does not require ordered data because the entire punch hole
operation does not provide atomicity guarantees. Therefore, it's safe to
move the ordered data operation from __ext4_block_zero_page_range() to
ext4_truncate().

It should be noted that after this change, we can only determine whether
to perform ordered data operations based on whether the target block has
been zeroed, rather than on the state of the buffer head. Consequently,
unnecessary ordered data operations may occur when truncating an
unwritten dirty block. However, this scenario is relatively rare, so the
overall impact is minimal.

This is prepared for the conversion to the iomap infrastructure since it
doesn't use ordered data mode and requires active writeback, which
reduces the complexity of the conversion.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f856ea015263..20b60abcf777 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4106,19 +4106,10 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	folio_zero_range(folio, offset, length);
 	BUFFER_TRACE(bh, "zeroed end of block");
 
-	if (ext4_should_journal_data(inode)) {
+	if (ext4_should_journal_data(inode))
 		err = ext4_dirty_journalled_data(handle, bh);
-	} else {
+	else
 		mark_buffer_dirty(bh);
-		/*
-		 * Only the written block requires ordered data to prevent
-		 * exposing stale data.
-		 */
-		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
-		    ext4_should_order_data(inode))
-			err = ext4_jbd2_inode_add_write(handle, inode, from,
-					length);
-	}
 	if (!err && did_zero)
 		*did_zero = true;
 
@@ -4578,8 +4569,23 @@ int ext4_truncate(struct inode *inode)
 		goto out_trace;
 	}
 
-	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
-		ext4_block_truncate_page(handle, mapping, inode->i_size);
+	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
+		unsigned int zero_len;
+
+		zero_len = ext4_block_truncate_page(handle, mapping,
+						    inode->i_size);
+		if (zero_len < 0) {
+			err = zero_len;
+			goto out_stop;
+		}
+		if (zero_len && !IS_DAX(inode) &&
+		    ext4_should_order_data(inode)) {
+			err = ext4_jbd2_inode_add_write(handle, inode,
+					inode->i_size, zero_len);
+			if (err)
+				goto out_stop;
+		}
+	}
 
 	/*
 	 * We add the inode to the orphan list, so that if this
-- 
2.52.0


