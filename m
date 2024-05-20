Return-Path: <linux-fsdevel+bounces-19806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C8B8C9E2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16B51C20309
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FA013664C;
	Mon, 20 May 2024 13:29:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D443AB2;
	Mon, 20 May 2024 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211779; cv=none; b=Lc369pdizeX0EEMy6G9E8c9w58YM6mzIblpABFNNjX7us9pXw/XvoQ3gCvLNU1PgOi/vlAAHA+azpgsk4WtAgb3S5Xe4wIQvmwG+M2fiVnVyJvxSs4O4DPgu5tHFfWbauO+4RMHybEVfdv03ujw38Ck5ol/q6sLlMOVK8z5vi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211779; c=relaxed/simple;
	bh=dfQ2mFPkIfsAxlVTyO4uk0ANvRgUl3qUB4NCcxQVKBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H9muJ2xhzjNnEWH3ejFLTM/IHJb+KcoCrLvj/QasQuRzyNrzpge9+6OCVAFj/4ESoOucfZhiJsaer0W7SAVqfP9G0MGnULnKtIKzPWZUwXT/AxzFEb/ylVYORA+XDt68Xz1uZGAodII5b9JPvSVc8aDo+6wWt9OJcDY7S0CATK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VjdhM516Tz4f3jMH;
	Mon, 20 May 2024 21:29:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8E5871A0BCA;
	Mon, 20 May 2024 21:29:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REpUEtmHanDNA--.33390S4;
	Mon, 20 May 2024 21:29:30 +0800 (CST)
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
Subject: [PATCH v2] jbd2: speed up jbd2_transaction_committed()
Date: Mon, 20 May 2024 21:18:31 +0800
Message-Id: <20240520131831.2910790-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REpUEtmHanDNA--.33390S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4fur4kJry8ZF47Cw47CFg_yoW5ZF4xpr
	yxCw17trykZ34xurn7Xr4kXFWjvanYya4UXrZF93Z3Za1Utw1xK3y2qryavryqyFs5Ww48
	XF15ur1DKw1j9a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UdHUDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

jbd2_transaction_committed() is used to check whether a transaction with
the given tid has already committed, it holds j_state_lock in read mode
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
  overwrite       IOPS=105k, BW=410MiB/s
  read            IOPS=112k, BW=436MiB/s
  rand overwrite  IOPS=104k, BW=404MiB/s
  randread        IOPS=111k, BW=432MiB/s

CC: Dave Chinner <david@fromorbit.com>
Suggested-by: Dave Chinner <david@fromorbit.com>
Link: https://lore.kernel.org/linux-ext4/ZjILCPNZRHeazSqV@dread.disaster.area/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v1->v2:
 - Add READ_ONCE and WRITE_ONCE to access ->j_commit_sequence
   concurrently.
 - Keep the jbd2_transaction_committed() helper.

 fs/jbd2/commit.c  |  2 +-
 fs/jbd2/journal.c | 12 +-----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5e122586e06e..8244cab17688 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1108,7 +1108,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	commit_transaction->t_state = T_COMMIT_CALLBACK;
 	J_ASSERT(commit_transaction == journal->j_committing_transaction);
-	journal->j_commit_sequence = commit_transaction->t_tid;
+	WRITE_ONCE(journal->j_commit_sequence, commit_transaction->t_tid);
 	journal->j_committing_transaction = NULL;
 	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b6c114c11b97..cc586e3c4ee1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -789,17 +789,7 @@ EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
 /* Return 1 when transaction with given tid has already committed. */
 int jbd2_transaction_committed(journal_t *journal, tid_t tid)
 {
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
+	return tid_geq(READ_ONCE(journal->j_commit_sequence), tid);
 }
 EXPORT_SYMBOL(jbd2_transaction_committed);
 
-- 
2.39.2


