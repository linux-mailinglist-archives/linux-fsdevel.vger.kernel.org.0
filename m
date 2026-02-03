Return-Path: <linux-fsdevel+bounces-76140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMoaNDOXgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:35:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438BED54DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D49BE30B1672
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B292385511;
	Tue,  3 Feb 2026 06:30:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0925A640;
	Tue,  3 Feb 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100220; cv=none; b=DB7fbaclG9+UQAD5A6KnZq6zYb3Vlxjy5tVXNYbBVpJdfQnEhpvLrPSJ/e9Th9eaJaJRzaQoqXGseswDzQbaaZUEmsOjJZLVC6Rju366+798tkFwGwFK9MISZ+rOEgzY3RWPe9XURxz5Ii5ME3b9VF9oU5jTywR5+m/1OqT3IcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100220; c=relaxed/simple;
	bh=/NaDFenwVQi21L1j17CQX/ddh2aX70Zgs+yP1ob/gsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVoHiDQwC4nkMPcJIaYDdx5ucUp8v1KelZKcD8TgoMjd6Fnw060UQoHqXziyAtjgmYm7cJozFz88TrijSkItWok9K2ijXq53HymalH9IB0JbI+Yju09I+9N8t8s4KY3DPRiVKuuKECcwXmC9C/usimPXtF1q7ZkWZZPlQRoTQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f4trJ39kMzKHMYY;
	Tue,  3 Feb 2026 14:29:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BB65A40570;
	Tue,  3 Feb 2026 14:30:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S5;
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
Subject: [PATCH -next v2 01/22] ext4: make ext4_block_zero_page_range() pass out did_zero
Date: Tue,  3 Feb 2026 14:25:01 +0800
Message-ID: <20260203062523.3869120-2-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW7GrW7Gw4DXr4kXrWDArb_yoW5tr1Upr
	y5tw45ur47u34q9F4xWF12qr1Skwn3GFW8W343G3s0v34IqF1xtF95K3ZYvF4jg3y7Xay0
	qF4Yy3y2gr1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k2
	0xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnWrAUUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76140-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 438BED54DC
X-Rspamd-Action: no action

Modify ext4_block_zero_page_range() to pass out the did_zero parameter.
This parameter is set to true once a partial block has been zeroed out.
This change prepares for moving ordered data handling out of
__ext4_block_zero_page_range(), which is being adapted for the
conversion of the block zero range to the iomap infrastructure.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index da96db5f2345..759a2a031a9d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4030,7 +4030,8 @@ void ext4_set_aops(struct inode *inode)
  * racing writeback can come later and flush the stale pagecache to disk.
  */
 static int __ext4_block_zero_page_range(handle_t *handle,
-		struct address_space *mapping, loff_t from, loff_t length)
+		struct address_space *mapping, loff_t from, loff_t length,
+		bool *did_zero)
 {
 	unsigned int offset, blocksize, pos;
 	ext4_lblk_t iblock;
@@ -4118,6 +4119,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 			err = ext4_jbd2_inode_add_write(handle, inode, from,
 					length);
 	}
+	if (!err && did_zero)
+		*did_zero = true;
 
 unlock:
 	folio_unlock(folio);
@@ -4133,7 +4136,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
  * that corresponds to 'from'
  */
 static int ext4_block_zero_page_range(handle_t *handle,
-		struct address_space *mapping, loff_t from, loff_t length)
+		struct address_space *mapping, loff_t from, loff_t length,
+		bool *did_zero)
 {
 	struct inode *inode = mapping->host;
 	unsigned blocksize = inode->i_sb->s_blocksize;
@@ -4147,10 +4151,11 @@ static int ext4_block_zero_page_range(handle_t *handle,
 		length = max;
 
 	if (IS_DAX(inode)) {
-		return dax_zero_range(inode, from, length, NULL,
+		return dax_zero_range(inode, from, length, did_zero,
 				      &ext4_iomap_ops);
 	}
-	return __ext4_block_zero_page_range(handle, mapping, from, length);
+	return __ext4_block_zero_page_range(handle, mapping, from, length,
+					    did_zero);
 }
 
 /*
@@ -4173,7 +4178,7 @@ static int ext4_block_truncate_page(handle_t *handle,
 	blocksize = i_blocksize(inode);
 	length = blocksize - (from & (blocksize - 1));
 
-	return ext4_block_zero_page_range(handle, mapping, from, length);
+	return ext4_block_zero_page_range(handle, mapping, from, length, NULL);
 }
 
 int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
@@ -4196,13 +4201,13 @@ int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 	if (start == end &&
 	    (partial_start || (partial_end != sb->s_blocksize - 1))) {
 		err = ext4_block_zero_page_range(handle, mapping,
-						 lstart, length);
+						 lstart, length, NULL);
 		return err;
 	}
 	/* Handle partial zero out on the start of the range */
 	if (partial_start) {
-		err = ext4_block_zero_page_range(handle, mapping,
-						 lstart, sb->s_blocksize);
+		err = ext4_block_zero_page_range(handle, mapping, lstart,
+						 sb->s_blocksize, NULL);
 		if (err)
 			return err;
 	}
@@ -4210,7 +4215,7 @@ int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 	if (partial_end != sb->s_blocksize - 1)
 		err = ext4_block_zero_page_range(handle, mapping,
 						 byte_end - partial_end,
-						 partial_end + 1);
+						 partial_end + 1, NULL);
 	return err;
 }
 
-- 
2.52.0


