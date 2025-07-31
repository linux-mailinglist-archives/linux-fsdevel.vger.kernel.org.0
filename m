Return-Path: <linux-fsdevel+bounces-56415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DDB172EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1731887BE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629852D238C;
	Thu, 31 Jul 2025 14:12:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AC2C1594;
	Thu, 31 Jul 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971163; cv=none; b=slMblf5O+brCdDretXkugfyiYsc59jnb3Mei8+Fo1NJ7tN74ihOhJD5rq0J/xyrRiI9qbkYPKNYDuzegmofCzWpK4NpsAPnQS4UyuCcPAz2ewpHQz70WXH2nspdXZD5sxQfTm1Jzp3rflfQzk1I9XiMDuxjI4F4pwOJszKakbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971163; c=relaxed/simple;
	bh=N+mvX9ou1vvZCytYXuof8XXOllsC5htU6j309tbQTAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Q2+m1pvopF0BMsqdcQ9Ek3VXgB/W1nl0G3Vdcfm9UwLwNHkMdq5fEFhEsJuBbxQ/Bs2jKTl0RfryQqGLpzq4BsojYu7V7Xzf0jLdBJdfdPDvgYLxx8D5ZoayCoCEiUFiBZuXBgNPHb3iwdf7pKIcy05o+8xMWTB6Y4d97BmrZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bt9yP1JgszKHMZm;
	Thu, 31 Jul 2025 22:12:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1B21F1A058E;
	Thu, 31 Jul 2025 22:12:28 +0800 (CST)
Received: from huawei.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3chPFeYtowwJwCA--.44078S4;
	Thu, 31 Jul 2025 22:12:28 +0800 (CST)
From: sunyongjian@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	libaokun1@huawei.com,
	chengzhihao1@huawei.com,
	sunyongjian1@huawei.com
Subject: [PATCH -next] ext4: add an update to i_disksize in ext4_block_page_mkwrite
Date: Thu, 31 Jul 2025 22:05:28 +0800
Message-Id: <20250731140528.1554917-1-sunyongjian@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chPFeYtowwJwCA--.44078S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFykCFWkKr17WF43Wr4Durg_yoW8Kw1Up3
	yYkFyvgr1vg3s5uws7XF1UXFyjkayrKr4xJFy7Gr42vFy5uw1IgF18t3sxWa4UtrWfJFWq
	qFWFqrWDWay8u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwSdgDUUUU
X-CM-SenderInfo: 5vxq505qjmxt3q6k3tpzhluzxrxghudrp/

From: Yongjian Sun <sunyongjian1@huawei.com>

After running a stress test combined with fault injection,
we performed fsck -a followed by fsck -fn on the filesystem
image. During the second pass, fsck -fn reported:

Inode 131512, end of extent exceeds allowed value
	(logical block 405, physical block 1180540, len 2)

This inode was not in the orphan list. Analysis revealed the
following call chain that leads to the inconsistency:

                             ext4_da_write_end()
                              //does not update i_disksize
                             ext4_punch_hole()
                              //truncate folio, keep size
ext4_page_mkwrite()
 ext4_block_page_mkwrite()
  ext4_block_write_begin()
    ext4_get_block()
     //insert written extent without update i_disksize
journal commit
echo 1 > /sys/block/xxx/device/delete

da-write path updates i_size but does not update i_disksize. Then
ext4_punch_hole truncates the da-folio yet still leaves i_disksize
unchanged. Then ext4_page_mkwrite sees ext4_nonda_switch return 1
and takes the nodioread_nolock path, the folio about to be written
has just been punched out, and it’s offset sits beyond the current
i_disksize. This may result in a written extent being inserted, but
again does not update i_disksize. If the journal gets committed and
then the block device is yanked, we might run into this.

To fix this, we now check in ext4_block_page_mkwrite whether
i_disksize needs to be updated to cover the newly allocated blocks.

Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
---
 fs/ext4/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ed54c4d0f2f9..050270b265ae 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6666,8 +6666,18 @@ static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
 		goto out_error;
 
 	if (!ext4_should_journal_data(inode)) {
+		loff_t disksize = folio_pos(folio) + len;
 		block_commit_write(folio, 0, len);
 		folio_mark_dirty(folio);
+		if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
+			down_write(&EXT4_I(inode)->i_data_sem);
+			if (disksize > EXT4_I(inode)->i_disksize)
+				EXT4_I(inode)->i_disksize = disksize;
+			up_write(&EXT4_I(inode)->i_data_sem);
+			ret = ext4_mark_inode_dirty(handle, inode);
+			if (ret)
+				goto out_error;
+		}
 	} else {
 		ret = ext4_journal_folio_buffers(handle, folio, len);
 		if (ret)
-- 
2.39.2


