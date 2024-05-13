Return-Path: <linux-fsdevel+bounces-19362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB97F8C3C17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E52281615
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169A3146A9B;
	Mon, 13 May 2024 07:31:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5E1465A7;
	Mon, 13 May 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585514; cv=none; b=sgk8SZYDtFFUusCza0+dsgLw4mQQgDbdbuyBTOtuuZM7CLe6acjZfqDyruK3HXzgmaXj/DpLYlH4qwngqR32dPXX4SLmW08VZJdPwj1+2LFMDzy9wBmEfxM03CgzjuIEGJ0xZHK41m2wKMDPtgPetCpr0h9NjJj9iWSHDJv3JZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585514; c=relaxed/simple;
	bh=mP89frmnm1S7+Nm2icvcGrXsiMEAppOWG+koyBdlx9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKcl+i02hlq85xGz+0X/n5OhgSmGuOoTHDyd7cy26FOfhI0ZifXJbpWb6AwOF2EM0P39XfsJTB0frfIw/pwVpSGmZqoqNLHI6/fBUr7I0DoQqNzcOgCuOfpff+hElSjGeIEj0RREaNUYjgEP8jxGVY0dHoHgCu1qrCTDgv6c0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VdB4k24Pmz4f3jHV;
	Mon, 13 May 2024 15:31:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D000D1A0C87;
	Mon, 13 May 2024 15:31:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHYwUFm_f0hMg--.51716S4;
	Mon, 13 May 2024 15:31:40 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH] ext4/jbd2: drop jbd2_transaction_committed()
Date: Mon, 13 May 2024 15:21:19 +0800
Message-Id: <20240513072119.2335346-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBHYwUFm_f0hMg--.51716S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UKFW7Ww15Xw45uryDWrg_yoWrWryfpa
	95Cr1xCryDZry8uw18Xr48ZFWjva18KayUWrWDC3Z3ta1UJwn2g3yUtw1avFyDtFZ5uw4U
	XF1ruw4DG34jk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UZa9-UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

jbd2_transaction_committed() is used to check whether a transaction with
the given tid has already committed, it hold j_state_lock in read mode
and check the tid of current running transaction and committing
transaction, but holding the j_state_lock is expensive.

We have already stored the sequence number of the most recently
committed transaction in journal t->j_commit_sequence, we could do this
check by comparing it with the given tid instead. If the given tid isn't
smaller than j_commit_sequence, we can ensure that the given transaction
has been committed. That way we could drop the expensive lock and
achieve about 10% ~ 20% performance gains in concurrent DIOs on may
virtual machine with 100G ramdisk.

fio -filename=/mnt/foo -direct=1 -iodepth=10 -rw=$rw -ioengine=libaio \
    -bs=4k -size=10G -numjobs=10 -runtime=60 -overwrite=1 -name=test \
    -group_reporting

Before:
  overwrite       IOPS=88.2k, BW=344MiB/s
  read            IOPS=95.7k, BW=374MiB/s
  rand overwrite  IOPS=98.7k, BW=386MiB/s
  randread        IOPS=102k, BW=397MiB/s

After:
  verwrite:       IOPS=105k, BW=410MiB/s
  read:           IOPS=112k, BW=436MiB/s
  rand overwrite: IOPS=104k, BW=404MiB/s
  randread:       IOPS=111k, BW=432MiB/s

CC: Dave Chinner <david@fromorbit.com>
Suggested-by: Dave Chinner <david@fromorbit.com>
Link: https://lore.kernel.org/linux-ext4/493ab4c5-505c-a351-eefa-7d2677cdf800@huaweicloud.com/T/#m6a14df5d085527a188c5a151191e87a3252dc4e2
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c      |  4 ++--
 fs/jbd2/journal.c    | 17 -----------------
 include/linux/jbd2.h |  1 -
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 537803250ca9..e8e2865bf9ac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3199,8 +3199,8 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 
 	if (journal) {
-		if (jbd2_transaction_committed(journal,
-			EXT4_I(inode)->i_datasync_tid))
+		if (tid_geq(journal->j_commit_sequence,
+			    EXT4_I(inode)->i_datasync_tid))
 			return false;
 		if (test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
 			return !list_empty(&EXT4_I(inode)->i_fc_list);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b6c114c11b97..73737cd1106f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -786,23 +786,6 @@ int jbd2_fc_end_commit_fallback(journal_t *journal)
 }
 EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
 
-/* Return 1 when transaction with given tid has already committed. */
-int jbd2_transaction_committed(journal_t *journal, tid_t tid)
-{
-	int ret = 1;
-
-	read_lock(&journal->j_state_lock);
-	if (journal->j_running_transaction &&
-	    journal->j_running_transaction->t_tid == tid)
-		ret = 0;
-	if (journal->j_committing_transaction &&
-	    journal->j_committing_transaction->t_tid == tid)
-		ret = 0;
-	read_unlock(&journal->j_state_lock);
-	return ret;
-}
-EXPORT_SYMBOL(jbd2_transaction_committed);
-
 /*
  * When this function returns the transaction corresponding to tid
  * will be completed.  If the transaction has currently running, start
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 971f3e826e15..e15ae324169d 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1643,7 +1643,6 @@ extern void	jbd2_clear_buffer_revoked_flags(journal_t *journal);
 int jbd2_log_start_commit(journal_t *journal, tid_t tid);
 int jbd2_journal_start_commit(journal_t *journal, tid_t *tid);
 int jbd2_log_wait_commit(journal_t *journal, tid_t tid);
-int jbd2_transaction_committed(journal_t *journal, tid_t tid);
 int jbd2_complete_transaction(journal_t *journal, tid_t tid);
 int jbd2_log_do_checkpoint(journal_t *journal);
 int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
-- 
2.39.2


