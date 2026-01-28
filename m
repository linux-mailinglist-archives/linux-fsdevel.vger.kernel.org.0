Return-Path: <linux-fsdevel+bounces-75682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L1aIZFyeWn2xAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:21:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FAF9C31D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1D0D300D47D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 02:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F512877FC;
	Wed, 28 Jan 2026 02:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450C1DC997;
	Wed, 28 Jan 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769566846; cv=none; b=B3LEvOSP8ufhIFMb38evGiaojXXXGt50qC24SNvOKgE42hmkcbQYVEG7uYt+HSmyvMiyoyCppvJpwscxYhtVlvQxaXDPM2ipx/g2j71LpU9dwrmJkOFFRH9n6yOrQmmN81mM+i6/T221rXsFU0d4SpZ1gfAzooWmbBNDPU7w2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769566846; c=relaxed/simple;
	bh=8bPNlRSRv2AZEv8dpGv0opFY2PkUMGBnwl0qOls0MeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0RIS8zTv6rwm/ae50QTqz35nkg1ykxxeaicFkMLSlWF+btaXP1poWDoO+Pf2tjTR9y5F7aUtbjzhHIMPW8IYf/xkVl5+4/v2akSI6yHlOKLncIKxngGAscCS673NADp8AsHy9G+6iqMrpisqBAlWWOWQY08iXHiLcpL8J/H81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f15Zj6305zYQtlf;
	Wed, 28 Jan 2026 10:19:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 61F6340539;
	Wed, 28 Jan 2026 10:20:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgB3JPVqcnlpnzB5FQ--.31477S4;
	Wed, 28 Jan 2026 10:20:34 +0800 (CST)
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
Subject: [PATCH] ext4: do not check fast symlink during orphan recovery
Date: Wed, 28 Jan 2026 10:16:09 +0800
Message-ID: <20260128021609.4061686-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3JPVqcnlpnzB5FQ--.31477S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWkKr4kWrWxWF15KFyrXrb_yoW8KF4kpa
	yaka4kGr48XF9Ygw4IqrW7Xr1Fq3WYyr4UAFZ3Ar4UZr98Ja4xKF1qgF15Zay5trWkAw4F
	qFyxKry3Cwn8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75682-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,huaweicloud.com,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.645];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3FAF9C31D
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

Commit '5f920d5d6083 ("ext4: verify fast symlink length")' causes the
generic/475 test to fail during orphan cleanup of zero-length symlinks.

  generic/475  84s ... _check_generic_filesystem: filesystem on /dev/vde is inconsistent

The fsck reports are provided below:

  Deleted inode 9686 has zero dtime.
  Deleted inode 158230 has zero dtime.
  ...
  Inode bitmap differences:  -9686 -158230
  Orphan file (inode 12) block 13 is not clean.
  Failed to initialize orphan file.

In ext4_symlink(), a newly created symlink can be added to the orphan
list due to ENOSPC. Its data has not been initialized, and its size is
zero. Therefore, we need to disregard the length check of the symbolic
link when cleaning up orphan inodes.

Fixes: 5f920d5d6083 ("ext4: verify fast symlink length")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6fba4948e040..44054a04fc4b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6079,18 +6079,22 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			inode->i_op = &ext4_encrypted_symlink_inode_operations;
 		} else if (ext4_inode_is_fast_symlink(inode)) {
 			inode->i_op = &ext4_fast_symlink_inode_operations;
-			if (inode->i_size == 0 ||
-			    inode->i_size >= sizeof(ei->i_data) ||
-			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
-								inode->i_size) {
-				ext4_error_inode(inode, function, line, 0,
-					"invalid fast symlink length %llu",
-					 (unsigned long long)inode->i_size);
-				ret = -EFSCORRUPTED;
-				goto bad_inode;
+
+			/* Orphan cleanup can get a zero-sized symlink. */
+			if (!(EXT4_SB(sb)->s_mount_state & EXT4_ORPHAN_FS)) {
+				if (inode->i_size == 0 ||
+				    inode->i_size >= sizeof(ei->i_data) ||
+				    strnlen((char *)ei->i_data, inode->i_size + 1) !=
+						inode->i_size) {
+					ext4_error_inode(inode, function, line, 0,
+						"invalid fast symlink length %llu",
+						(unsigned long long)inode->i_size);
+					ret = -EFSCORRUPTED;
+					goto bad_inode;
+				}
+				inode_set_cached_link(inode, (char *)ei->i_data,
+						      inode->i_size);
 			}
-			inode_set_cached_link(inode, (char *)ei->i_data,
-					      inode->i_size);
 		} else {
 			inode->i_op = &ext4_symlink_inode_operations;
 		}
-- 
2.52.0


