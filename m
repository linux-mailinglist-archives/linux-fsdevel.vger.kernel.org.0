Return-Path: <linux-fsdevel+bounces-76139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH3NDjWWgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:31:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24494D5416
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CF303015CBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801D3815C4;
	Tue,  3 Feb 2026 06:30:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD723FC41;
	Tue,  3 Feb 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100220; cv=none; b=HP0VKHxGyaW8HZCx+YRB/rrjY3gT2GvXSCX3zIUClQDJSdr07UCah0UbWKCAHwC7kW7YiyjHMpOvnAr0lh0XWePT9OyuXnpvNk1xl2rmcwBSDkMMdD40N/Lun/A1OFi/ofCEhFeeozXW4FuUGzAU6wAC08FWzUnDvCi+dEN7RTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100220; c=relaxed/simple;
	bh=SDzKcbZvhkkzWPKHGZlcKBfdQ1Ey6Gz96qtbAlPSZfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVvxjCP6G2tZa3YNFlD+rSiK9bR4ax3hTDQSfUM/+IxhIHnWEP6G3K5hNCT7FkbUDdgGcP5ZV7rZkPnZCqO7ITZFCEjZX+L4nWY8PoBROF5Pod85QlhkI0MQdAMMvZleJ0P5/y8KSSU4OPooLTig6J79n/kUxPoDbM1avT6ZeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4tqq0KJdzYQtxj;
	Tue,  3 Feb 2026 14:29:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F39984056F;
	Tue,  3 Feb 2026 14:30:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S8;
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
Subject: [PATCH -next v2 04/22] ext4: factor out journalled block zeroing range
Date: Tue,  3 Feb 2026 14:25:04 +0800
Message-ID: <20260203062523.3869120-5-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15AF43Aw45AFyfuF1ftFb_yoWrWF4fpr
	y5K34DurW7ur9FgF4Sq3ZFqr1a934rWrW8WFyxGr93Za4YqF17KFyUK3WFqF45Kr47Ga40
	qF4Yy347u3WUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFPETDU
	UUU
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76139-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24494D5416
X-Rspamd-Action: no action

Refactor __ext4_block_zero_page_range() by separating the block zeroing
operations for ordered data mode and journal data mode into two distinct
functions. Additionally, extract a common helper,
ext4_block_get_zero_range(), to identify the buffer that requires
zeroing.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 84 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 20b60abcf777..7990ad566e10 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4029,13 +4029,12 @@ void ext4_set_aops(struct inode *inode)
  * ext4_punch_hole, etc) which needs to be properly zeroed out. Otherwise a
  * racing writeback can come later and flush the stale pagecache to disk.
  */
-static int __ext4_block_zero_page_range(handle_t *handle,
-		struct address_space *mapping, loff_t from, loff_t length,
-		bool *did_zero)
+static struct buffer_head *ext4_block_get_zero_range(struct inode *inode,
+				      loff_t from, loff_t length)
 {
 	unsigned int offset, blocksize, pos;
 	ext4_lblk_t iblock;
-	struct inode *inode = mapping->host;
+	struct address_space *mapping = inode->i_mapping;
 	struct buffer_head *bh;
 	struct folio *folio;
 	int err = 0;
@@ -4044,7 +4043,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				    mapping_gfp_constraint(mapping, ~__GFP_FS));
 	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+		return ERR_CAST(folio);
 
 	blocksize = inode->i_sb->s_blocksize;
 
@@ -4096,24 +4095,65 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 			}
 		}
 	}
-	if (ext4_should_journal_data(inode)) {
-		BUFFER_TRACE(bh, "get write access");
-		err = ext4_journal_get_write_access(handle, inode->i_sb, bh,
-						    EXT4_JTR_NONE);
-		if (err)
-			goto unlock;
-	}
-	folio_zero_range(folio, offset, length);
+	return bh;
+
+unlock:
+	folio_unlock(folio);
+	folio_put(folio);
+	return err ? ERR_PTR(err) : NULL;
+}
+
+static int ext4_block_zero_range(struct inode *inode, loff_t from,
+				 loff_t length, bool *did_zero)
+{
+	struct buffer_head *bh;
+	struct folio *folio;
+
+	bh = ext4_block_get_zero_range(inode, from, length);
+	if (IS_ERR_OR_NULL(bh))
+		return PTR_ERR_OR_ZERO(bh);
+
+	folio = bh->b_folio;
+	folio_zero_range(folio, offset_in_folio(folio, from), length);
 	BUFFER_TRACE(bh, "zeroed end of block");
 
-	if (ext4_should_journal_data(inode))
-		err = ext4_dirty_journalled_data(handle, bh);
-	else
-		mark_buffer_dirty(bh);
-	if (!err && did_zero)
+	mark_buffer_dirty(bh);
+	if (did_zero)
 		*did_zero = true;
 
-unlock:
+	folio_unlock(folio);
+	folio_put(folio);
+	return 0;
+}
+
+static int ext4_journalled_block_zero_range(handle_t *handle,
+		struct inode *inode, loff_t from, loff_t length, bool *did_zero)
+{
+	struct buffer_head *bh;
+	struct folio *folio;
+	int err;
+
+	bh = ext4_block_get_zero_range(inode, from, length);
+	if (IS_ERR_OR_NULL(bh))
+		return PTR_ERR_OR_ZERO(bh);
+	folio = bh->b_folio;
+
+	BUFFER_TRACE(bh, "get write access");
+	err = ext4_journal_get_write_access(handle, inode->i_sb, bh,
+					    EXT4_JTR_NONE);
+	if (err)
+		goto out;
+
+	folio_zero_range(folio, offset_in_folio(folio, from), length);
+	BUFFER_TRACE(bh, "zeroed end of block");
+
+	err = ext4_dirty_journalled_data(handle, bh);
+	if (err)
+		goto out;
+
+	if (did_zero)
+		*did_zero = true;
+out:
 	folio_unlock(folio);
 	folio_put(folio);
 	return err;
@@ -4144,9 +4184,11 @@ static int ext4_block_zero_page_range(handle_t *handle,
 	if (IS_DAX(inode)) {
 		return dax_zero_range(inode, from, length, did_zero,
 				      &ext4_iomap_ops);
+	} else if (ext4_should_journal_data(inode)) {
+		return ext4_journalled_block_zero_range(handle, inode, from,
+							length, did_zero);
 	}
-	return __ext4_block_zero_page_range(handle, mapping, from, length,
-					    did_zero);
+	return ext4_block_zero_range(inode, from, length, did_zero);
 }
 
 /*
-- 
2.52.0


