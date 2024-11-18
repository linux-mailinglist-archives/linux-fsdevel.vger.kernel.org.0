Return-Path: <linux-fsdevel+bounces-35084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5B9D102D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E925DB287D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D759199EB4;
	Mon, 18 Nov 2024 11:45:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4B176AA9;
	Mon, 18 Nov 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930316; cv=none; b=jzJE9l+zfJPIDZFPZlB5SbEEic7IKhEyqNwCoyBchyX2TvcrM8n6rUESYcYXrO9mcUxdVCAW2UOPQL2pJMhrtpusnSzcYOkaQUgR+ZzLJnf3a9Yk4a2YHGZ6eYFh1fNLHGyjdNZXOMdDBoaFcnPz2xPyng0kBCNNF1XXzC9XbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930316; c=relaxed/simple;
	bh=Fmpzr+4VilJEIsxQkky2Ak7IZhFT54pKHZH1FgLJg8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnhd8IpH59KE0rzSoZdJfE2qsQuP5F967FNcmn3+6oNOHATw+D++l2tF4crNSHnAASMsVprAGRsaoR7s/Ao61qFF8rpL8mmtpBhr+O0Kqco9CFq9I0LixtOjYhAVMdq9Y/85V1XpRWj6Y3MNPu67D4WGSS1Z1MDAWOIzzCbLjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsQlm2Q5wz4f3nV2;
	Mon, 18 Nov 2024 19:44:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A542B1A0568;
	Mon, 18 Nov 2024 19:45:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLEKDtn3fCKCA--.48005S5;
	Mon, 18 Nov 2024 19:45:11 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	agruenba@redhat.com,
	gfs2@lists.linux.dev,
	amir73il@gmail.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Cc: yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 01/11] fs: introduce I_CURSOR flag for inode
Date: Mon, 18 Nov 2024 19:44:58 +0800
Message-Id: <20241118114508.1405494-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118114508.1405494-1-yebin@huaweicloud.com>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoLEKDtn3fCKCA--.48005S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uryfWr1fuw48JFyrAw1xAFb_yoW8tF15pF
	W2kry5tw4DXFW7Cayftanxua1fKF1xCrW5t34xWws5Xr17tw10q3Wvqr1Yyr93JFWkGrWY
	qrs0k34qgFWxJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTm
	DUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

This patch introduce I_CURSOR flag for inode and introduce
sb_for_each_inodes_safe/sb_for_each_inodes/sb_for_each_inodes_continue_safe
API for foreach super_block->s_inodes.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 include/linux/fs.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0a152c31d1bf..cf2734e0b2cd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2473,6 +2473,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DONTCACHE		(1 << 15)
 #define I_SYNC_QUEUED		(1 << 16)
 #define I_PINNING_NETFS_WB	(1 << 17)
+#define I_CURSOR		(1 << 18)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
@@ -3809,4 +3810,48 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
+static inline bool inode_is_cursor(struct inode *inode)
+{
+	return inode->i_state & I_CURSOR;
+}
+
+static inline struct inode *next_sb_inode(struct inode *pos,
+					  struct list_head *head)
+{
+	struct inode *inode;
+	struct list_head *start;
+
+	if (!pos)
+		return NULL;
+
+	start = &pos->i_sb_list;
+
+	list_for_each_continue(start, head) {
+		inode = list_entry(start, typeof(*inode), i_sb_list);
+		if (likely(!inode_is_cursor(inode)))
+			return inode;
+	}
+
+	return NULL;
+}
+
+#define sb_for_each_inodes_safe(pos, n, head)                 \
+	for (pos = list_entry(head, typeof(*pos), i_sb_list), \
+		pos = next_sb_inode(pos, head),               \
+		n = next_sb_inode(pos, head);                 \
+	     pos != NULL;                                     \
+	     pos = n, n = next_sb_inode(n, head))
+
+#define sb_for_each_inodes(pos, head)                          \
+	for (pos = list_entry(head, typeof(*pos), i_sb_list), \
+		pos = next_sb_inode(pos, head);                \
+	     pos != NULL;                                     \
+	     pos = next_sb_inode(pos, head))
+
+#define sb_for_each_inodes_continue_safe(pos, n, head)        \
+	for (pos = next_sb_inode(pos, head),                  \
+		n = next_sb_inode(pos, head);                 \
+	     pos != NULL;                                     \
+	     pos = n, n = next_sb_inode(n, head))
+
 #endif /* _LINUX_FS_H */
-- 
2.34.1


