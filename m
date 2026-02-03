Return-Path: <linux-fsdevel+bounces-76135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEpgHoSWgWlsHgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:32:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC539D5476
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 069F730599E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811537D130;
	Tue,  3 Feb 2026 06:30:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326312561A2;
	Tue,  3 Feb 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100218; cv=none; b=gVLd0O51o+PE+SAqjwAws6IsZHn0ybKndFORL6A1F01CyuwooFsd+j9+VmwO90uQvZMcdhitXtfE9qwlvsBoPQGvCU9wxBACELGyXF/jNm4RwiIQFaH5dWVX7x+xPEkXlM7rG/JYuFzE35g8Qaq7OblLCz/y7kskQ8jrpd5Wziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100218; c=relaxed/simple;
	bh=S2JHZ9z2ebAASrluuxrESw3zqucOOxCysAALmIGrhV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM1Au2MTynbCbuEN7DRvksPA6TJJYtPxXTw7yf/a/ZJtVLkwBveDCH1vLeWxlPqY8wZNVw6jWEtkkBbjkg/bnQImhXU3SLnp2fPTH54e8AtzfwdOwciDe7FhkDEt2pQlL/YjhA2Dmh/YXYelFS2S/CUX8+YUi9wLtoCOWybycKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f4trJ5zWzzKHMbB;
	Tue,  3 Feb 2026 14:29:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2A8304058F;
	Tue,  3 Feb 2026 14:30:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S10;
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
Subject: [PATCH -next v2 06/22] ext4: don't zero partial block under an active handle when truncating down
Date: Tue,  3 Feb 2026 14:25:06 +0800
Message-ID: <20260203062523.3869120-7-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyUXw47Ar1UGw43JFWDJwb_yoW5Gr1xpF
	9xG3y5Jr48W34q9ayIqFsrZF15K3WfCayjgFWxGrs5tr98X34FvF13KrWIkFWYyrZ5W3yj
	qF1UAryUWF1DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyC
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76135-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: EC539D5476
X-Rspamd-Action: no action

When truncating down, move the call to ext4_block_truncate_page() before
starting the handle. This change has no effect in non-journal data mode
because it doesn't require an active handle. However, in journal data
mode, it may cause the zeroing of partial blocks and the release of
subsequent full blocks to be distributed across different transactions.
This is safe as well because the transaction that zeroes the blocks will
always be committed first, and the entire truncate operation does not
require atomicity guarantee.

This change prepares for converting the block zero range to the iomap
infrastructure, which does not use ordered data mode and requires active
writeback to prevent exposing stale data. The writeback must be
completed before the transaction to remove the orphan is committed, and
it cannot be performed within an active handle.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c05b1c0a1b45..e67c750866a5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4570,7 +4570,7 @@ int ext4_inode_attach_jinode(struct inode *inode)
 int ext4_truncate(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	unsigned int credits;
+	unsigned int credits, zero_len = 0;
 	int err = 0, err2;
 	handle_t *handle;
 	struct address_space *mapping = inode->i_mapping;
@@ -4603,6 +4603,12 @@ int ext4_truncate(struct inode *inode)
 		err = ext4_inode_attach_jinode(inode);
 		if (err)
 			goto out_trace;
+
+		zero_len = ext4_block_truncate_page(mapping, inode->i_size);
+		if (zero_len < 0) {
+			err = zero_len;
+			goto out_trace;
+		}
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
@@ -4616,21 +4622,12 @@ int ext4_truncate(struct inode *inode)
 		goto out_trace;
 	}
 
-	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
-		unsigned int zero_len;
-
-		zero_len = ext4_block_truncate_page(mapping, inode->i_size);
-		if (zero_len < 0) {
-			err = zero_len;
+	/* Ordered zeroed data to prevent exposure of stale data. */
+	if (zero_len && !IS_DAX(inode) && ext4_should_order_data(inode)) {
+		err = ext4_jbd2_inode_add_write(handle, inode, inode->i_size,
+						zero_len);
+		if (err)
 			goto out_stop;
-		}
-		if (zero_len && !IS_DAX(inode) &&
-		    ext4_should_order_data(inode)) {
-			err = ext4_jbd2_inode_add_write(handle, inode,
-					inode->i_size, zero_len);
-			if (err)
-				goto out_stop;
-		}
 	}
 
 	/*
-- 
2.52.0


