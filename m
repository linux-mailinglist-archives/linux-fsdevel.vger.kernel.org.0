Return-Path: <linux-fsdevel+bounces-72379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 942B1CF1949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 02:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 846A8300F19D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 01:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8D2F7AD6;
	Mon,  5 Jan 2026 01:48:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACA1F2B8D;
	Mon,  5 Jan 2026 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767577732; cv=none; b=A7r2CjKe9nxihhbjFbzcQxNEyhru0PUSTFsilGwVupvdd5W2RN07JB2kfp+TO5kAtB6K6qzMJuqXt9bKQ4MhvKgnmDKOtY7GritsoZkN2BxuRruCPmAH6wotqi6ByJL/K4JB9gVWYXPJamCTUzrJeQyX6wdwtY6ywav7DB8Brgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767577732; c=relaxed/simple;
	bh=BD38+k0fiy4RF7enyeK/M1BHor8U/dKefAoMRUC0P+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/SuF2w7FJB5Iww9bHsbkA84/N3pIIKepM3cgW+ZNPwuO5TuaAsJb+K561BohmHybFxUKK+u9mMt1jWJ02AYI8vFxOrF5lm0EaVTKW9Vb5J0crEJFiIVG6wORhqs6OURamlwtpN3NqDzPNVLNlMrD+bF0jlDcnJqhutGnl+A9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dkxyY4C3BzKHMb2;
	Mon,  5 Jan 2026 09:48:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DD88140575;
	Mon,  5 Jan 2026 09:48:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgBHp_dpGFtppFisCg--.42376S9;
	Mon, 05 Jan 2026 09:48:42 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next v3 5/7] ext4: remove unused unwritten parameter in ext4_dio_write_iter()
Date: Mon,  5 Jan 2026 09:45:20 +0800
Message-ID: <20260105014522.1937690-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105014522.1937690-1-yi.zhang@huaweicloud.com>
References: <20260105014522.1937690-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHp_dpGFtppFisCg--.42376S9
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4rXF43trykGFyrtFyDGFg_yoW5Wr4rpF
	13Ka4UXFZ7W39rWrW8tay8uryYga1kC3yxWrW5W3W5Zry8AryfKF1xtFyYy3WrJrZ7J3W2
	gFsYkryDZw17KrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The parameter unwritten in ext4_dio_write_iter() is no longer needed,
simply remove it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6b4b68f830d5..fa22fc0e45f3 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -424,14 +424,14 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
  */
 static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 				     bool *ilock_shared, bool *extend,
-				     bool *unwritten, int *dio_flags)
+				     int *dio_flags)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	loff_t offset;
 	size_t count;
 	ssize_t ret;
-	bool overwrite, unaligned_io;
+	bool overwrite, unaligned_io, unwritten;
 
 restart:
 	ret = ext4_generic_write_checks(iocb, from);
@@ -443,7 +443,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 
 	unaligned_io = ext4_unaligned_io(inode, from, offset);
 	*extend = ext4_extending_io(inode, offset, count);
-	overwrite = ext4_overwrite_io(inode, offset, count, unwritten);
+	overwrite = ext4_overwrite_io(inode, offset, count, &unwritten);
 
 	/*
 	 * Determine whether we need to upgrade to an exclusive lock. This is
@@ -458,7 +458,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	 */
 	if (*ilock_shared &&
 	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
-	     (unaligned_io && *unwritten)))) {
+	     (unaligned_io && unwritten)))) {
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			goto out;
@@ -481,7 +481,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 			ret = -EAGAIN;
 			goto out;
 		}
-		if (unaligned_io && (!overwrite || *unwritten))
+		if (unaligned_io && (!overwrite || unwritten))
 			inode_dio_wait(inode);
 		*dio_flags = IOMAP_DIO_FORCE_WAIT;
 	}
@@ -506,7 +506,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(from);
-	bool extend = false, unwritten = false;
+	bool extend = false;
 	bool ilock_shared = true;
 	int dio_flags = 0;
 
@@ -552,7 +552,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 
 	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend,
-				    &unwritten, &dio_flags);
+				    &dio_flags);
 	if (ret <= 0)
 		return ret;
 
-- 
2.52.0


