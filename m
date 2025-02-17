Return-Path: <linux-fsdevel+bounces-41823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A0A37BD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 08:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7098188D969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 07:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4609D193409;
	Mon, 17 Feb 2025 07:06:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310F4C70;
	Mon, 17 Feb 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776003; cv=none; b=L2ffj+iaCihDdhmWmbEyvSbe9qVDRqjVNEIGj3nnIaHv3+EkZyEjw0E61K59987ry9oucfIdckZ8gKx1d3YgPNTuj0l2m+RbfFEbzonbNojAIFhniXj/St8PvEL78LzFHkDj/q902G/TkN/xA0FSnurWY8Moee2zKKpfO1Y/3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776003; c=relaxed/simple;
	bh=qJDsd2z/942OOOCUg26TueeBOG1V50FZockYoCDzi5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0CRNkiEIucaGEMnCxSTOCMslakTZh4GX6a1zqvLcNkKNNUT0GOG5ahazoWGkJOd2cK3EJWuPwCoghlXO5vCtB6cEXPzwFhkCbhxeHzQss5Fkj2Cg/BKJ5ZEWF2TkyW334O0ZNp3zyDtLmtWONro6c0kfk3XFPXlFj3K5CED3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YxDGG4fllz4f3lCf;
	Mon, 17 Feb 2025 15:06:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 891AD1A1527;
	Mon, 17 Feb 2025 15:06:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl_137JnjbRXEA--.5607S4;
	Mon, 17 Feb 2025 15:06:37 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	leah.rumancik@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] jbd2: fix off-by-one while erasing journal
Date: Mon, 17 Feb 2025 14:59:55 +0800
Message-ID: <20250217065955.3829229-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl_137JnjbRXEA--.5607S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF43Ar4rtr1DJFW7CFW5trb_yoW5JFWDpr
	W7G3W3GrWku340vFn7WrWkXry5XayqkFWUGr4Duwn3X3yfJr1ak34kK3s8J34jqFyxGay7
	ZF15A3yUGw42q37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

From: Zhang Yi <yi.zhang@huawei.com>

In __jbd2_journal_erase(), the block_stop parameter includes the last
block of a contiguous region; however, the calculation of byte_stop is
incorrect, as it does not account for the bytes in that last block.
Consequently, the page cache is not cleared properly, which occasionally
causes the ext4/050 test to fail.

Since block_stop operates on inclusion semantics, it involves repeated
increments and decrements by 1, significantly increasing the complexity
of the calculations. Optimize the calculation and fix the incorrect
byte_stop by make both block_stop and byte_stop to use exclusion
semantics.

This fixes a failure in fstests ext4/050.

Fixes: 01d5d96542fd ("ext4: add discard/zeroout flags to journal flush")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d8084b31b361..49a9e99cbc03 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1965,17 +1965,15 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 			return err;
 		}
 
-		if (block_start == ~0ULL) {
-			block_start = phys_block;
-			block_stop = block_start - 1;
-		}
+		if (block_start == ~0ULL)
+			block_stop = block_start = phys_block;
 
 		/*
 		 * last block not contiguous with current block,
 		 * process last contiguous region and return to this block on
 		 * next loop
 		 */
-		if (phys_block != block_stop + 1) {
+		if (phys_block != block_stop) {
 			block--;
 		} else {
 			block_stop++;
@@ -1994,11 +1992,10 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 		 */
 		byte_start = block_start * journal->j_blocksize;
 		byte_stop = block_stop * journal->j_blocksize;
-		byte_count = (block_stop - block_start + 1) *
-				journal->j_blocksize;
+		byte_count = (block_stop - block_start) * journal->j_blocksize;
 
 		truncate_inode_pages_range(journal->j_dev->bd_mapping,
-				byte_start, byte_stop);
+				byte_start, byte_stop - 1);
 
 		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
 			err = blkdev_issue_discard(journal->j_dev,
@@ -2013,7 +2010,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 		}
 
 		if (unlikely(err != 0)) {
-			pr_err("JBD2: (error %d) unable to wipe journal at physical blocks %llu - %llu",
+			pr_err("JBD2: (error %d) unable to wipe journal at physical blocks [%llu, %llu)",
 					err, block_start, block_stop);
 			return err;
 		}
-- 
2.46.1


