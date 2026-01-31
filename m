Return-Path: <linux-fsdevel+bounces-75990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN7DKJPIfWmZTgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 10:17:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BF5C1565
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 10:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27F94300E63A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6F3148D0;
	Sat, 31 Jan 2026 09:16:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700952FC006;
	Sat, 31 Jan 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769851018; cv=none; b=kox68Twn+nZ5p9zQEiw4n6Tl4523XS/dmIcc1IZ/VdwlxKzpStxFh7yzjthPe6lrn+cIngRYs21xZep+sHL+3n7IKqnEpY0ybwA+ZIUn75PBT08GwVsEvMqnyhoCsM7Nl5vwnHFAudii4XB06BS9S9uyKUtSZxLZXa/+XiMmESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769851018; c=relaxed/simple;
	bh=JRke2uIWfyMs6U644VydKDUn2vQW2N9okzWNSecDPrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=di77d+RRKqZz1olfEU7lEgI65EZGT0jtoMryGRvPwo9sSSWJaEMbe9IQCygLkfMbqyfOYQiq9zRkfcU3hk/CRnFDCk9qxg5c/NwXWrYnc9ZCtwiSLgA7DwySIX48k1r7yZLZnpXQXB9QAT4d8w55l3kXWjZEAqJdYr7Yiy3Bzew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f36gF617DzYQtH1;
	Sat, 31 Jan 2026 17:15:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E32B740594;
	Sat, 31 Jan 2026 17:16:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCX+PhoyH1p9UkDFw--.43433S4;
	Sat, 31 Jan 2026 17:16:35 +0800 (CST)
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
Subject: [PATCH v2] ext4: do not check fast symlink during orphan recovery
Date: Sat, 31 Jan 2026 17:11:56 +0800
Message-ID: <20260131091156.1733648-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX+PhoyH1p9UkDFw--.43433S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXry5XFyrJF48uFW7ZFyDtrb_yoW5Ar1kpF
	W3G3WkJr18JF9agrWftr47Xr1Fq3W8Ar4jyFZ3A3yUZryDJa4xKF1UtF15Zay5trWkA3WY
	qF47Kry7ur15CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-75990-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,huaweicloud.com,fnnas.com];
	DMARC_NA(0.00)[huaweicloud.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 61BF5C1565
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
link when cleaning up orphan inodes. Instead, we should ensure that the
nlink count is zero.

Fixes: 5f920d5d6083 ("ext4: verify fast symlink length")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
Changes since v1:
 - Improve the comment and add nlink check during orphan cleanup as Jan
   suggested.

 fs/ext4/inode.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 129594bf8311..cfb66f7ad3d7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6073,18 +6073,36 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
+			/*
+			 * Orphan cleanup can see inodes with i_size == 0
+			 * and i_data uninitialized. Skip size checks in
+			 * that case. This is safe because the first thing
+			 * ext4_evict_inode() does for fast symlinks is
+			 * clearing of i_data and i_size.
+			 */
+			if ((EXT4_SB(sb)->s_mount_state & EXT4_ORPHAN_FS)) {
+				if (inode->i_nlink != 0) {
+					ext4_error_inode(inode, function, line, 0,
+						"invalid orphan symlink nlink %d",
+						inode->i_nlink);
+					ret = -EFSCORRUPTED;
+					goto bad_inode;
+				}
+			} else {
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


