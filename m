Return-Path: <linux-fsdevel+bounces-76142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJNVCESXgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:35:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA4BD54F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 408A930B7D71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF5385EE0;
	Tue,  3 Feb 2026 06:30:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEA23C4FF;
	Tue,  3 Feb 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100221; cv=none; b=FLAkL3zK/VWlOd8Q17amsm2C99kZSv6/n7Syg74N5r0Un7qC0fVmgHMxE/nSggqoN+Fw0KjPsOpIPINPQgHVKfJOalBM5grj1+fYFjBsvAsSWTIT07E11LzDX2tD8CPck8r3hBX3gNiWOyO1cqZcchL4tdUB0JianJlYmeek/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100221; c=relaxed/simple;
	bh=S6zZLZA6qQmW24CKxJl46apECpy26rNSYksWDEwOGMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTuJGMG3JZ530qsWJr73hVE3G1zde//E7SCwppEl1lJxdvbiMNDScY4i9NZq/HDcXZ8eZ0n5GDwhiYEYjmca0CgkvEvPMa60vsn0rEnwlxea1f5Ua+d3kRLKIzJqC/o35uTfvduDtqOuZCK7o1IubKiyvLz7rYLwzMvtVxvFTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4tqq36pZzYQty9;
	Tue,  3 Feb 2026 14:29:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5972C40590;
	Tue,  3 Feb 2026 14:30:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S12;
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
Subject: [PATCH -next v2 08/22] ext4: zero post EOF partial block before appending write
Date: Tue,  3 Feb 2026 14:25:08 +0800
Message-ID: <20260203062523.3869120-9-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S12
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8WrWrtryxCFWkCr1fXrb_yoWrWr45pF
	ZIkF1fuw1Igr9rWrWfWFs8Z34Ykas5JrW7GFyfKrWrZFnxZw18KF12qa4YkFW5trZrXw4F
	qF4qgFy8G3WUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76142-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABA4BD54F4
X-Rspamd-Action: no action

In cases of appending write beyond the end of file (EOF),
ext4_zero_partial_blocks() is called within ext4_*_write_end() to zero
out the partial block beyond the EOF. This prevents exposing stale data
that might be written through mmap. However, supporting only the regular
buffered write path is insufficient. It is also necessary to support the
DAX path as well as the upcoming iomap buffered write path. Therefore,
move this operation to ext4_write_checks(). In addition, the zero length
is limited within the EOF block to prevent ext4_zero_partial_blocks()
from attempting to zero out the extra end block (although it would not
do anything anyway).

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/file.c  | 20 ++++++++++++++++++++
 fs/ext4/inode.c | 21 +++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 4320ebff74f3..3ecc09f286e4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -271,6 +271,9 @@ static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
 
 static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct inode *inode = file_inode(iocb->ki_filp);
+	unsigned int blocksize = i_blocksize(inode);
+	loff_t old_size = i_size_read(inode);
 	ssize_t ret, count;
 
 	count = ext4_generic_write_checks(iocb, from);
@@ -280,6 +283,23 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	ret = file_modified(iocb->ki_filp);
 	if (ret)
 		return ret;
+
+	/*
+	 * If the position is beyond the EOF, it is necessary to zero out the
+	 * partial block that beyond the existing EOF, as it may contains
+	 * stale data written through mmap.
+	 */
+	if (iocb->ki_pos > old_size && (old_size & (blocksize - 1))) {
+		loff_t end = round_up(old_size, blocksize);
+
+		if (iocb->ki_pos < end)
+			end = iocb->ki_pos;
+
+		ret = ext4_zero_partial_blocks(inode, old_size, end - old_size);
+		if (ret)
+			return ret;
+	}
+
 	return count;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9c0e70256527..1ac93c39d21e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1456,10 +1456,9 @@ static int ext4_write_end(const struct kiocb *iocb,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity) {
+	if (old_size < pos && !verity)
 		pagecache_isize_extended(inode, old_size, pos);
-		ext4_zero_partial_blocks(inode, old_size, pos - old_size);
-	}
+
 	/*
 	 * Don't mark the inode dirty under folio lock. First, it unnecessarily
 	 * makes the holding time of folio lock longer. Second, it forces lock
@@ -1574,10 +1573,8 @@ static int ext4_journalled_write_end(const struct kiocb *iocb,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity) {
+	if (old_size < pos && !verity)
 		pagecache_isize_extended(inode, old_size, pos);
-		ext4_zero_partial_blocks(inode, old_size, pos - old_size);
-	}
 
 	if (size_changed) {
 		ret2 = ext4_mark_inode_dirty(handle, inode);
@@ -3196,7 +3193,7 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
 	bool disksize_changed = false;
-	loff_t new_i_size, zero_len = 0;
+	loff_t new_i_size;
 	handle_t *handle;
 
 	if (unlikely(!folio_buffers(folio))) {
@@ -3240,19 +3237,15 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (pos > old_size) {
+	if (pos > old_size)
 		pagecache_isize_extended(inode, old_size, pos);
-		zero_len = pos - old_size;
-	}
 
-	if (!disksize_changed && !zero_len)
+	if (!disksize_changed)
 		return copied;
 
-	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	if (zero_len)
-		ext4_zero_partial_blocks(inode, old_size, zero_len);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 
-- 
2.52.0


