Return-Path: <linux-fsdevel+bounces-36623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566029E6D28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 12:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F328618847B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7514200114;
	Fri,  6 Dec 2024 11:16:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690221FCD1D;
	Fri,  6 Dec 2024 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483774; cv=none; b=bXo3hv5N3oOvBkjpOKsimk9ZJUcV0s5+god4L9v8+kWsNT22YHEy/2P1Ape8twPi0a9EZeBvCSd4AQR1Ni1UHnorwSm8HvgcjFGraAc/Helz2Cl1v1dKDqfAz0n0STvBh29oyyK1g9Wbq+QHG6ldnZKfUdpLjmYnBzyYGX62pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483774; c=relaxed/simple;
	bh=iPF1dj3x0BDkShjWp5qNspvK+7h0fULDyUhS353q+i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTna3OZf272CqgcISRWr1scSIh+MfL5I9K6Q7iZqTh4sPIDL1IbafPqSs8PNwaOnrCBs/K6DfeXDldu8+yMAQx/IdVtLcU48LXFmWeSNkEzgOLaUPg+3HwS6mo001VyjsMnX5fTkcRpAYXilhkAOgVEcU6KoZSEKMHMwj9CYBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y4TFw3mLfz4f3jdK;
	Fri,  6 Dec 2024 19:15:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 943351A0197;
	Fri,  6 Dec 2024 19:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHYobu3FJnzUVKDw--.25327S4;
	Fri, 06 Dec 2024 19:16:07 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] jbd2: add a missing data flush during file and fs synchronization
Date: Fri,  6 Dec 2024 19:13:27 +0800
Message-ID: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYobu3FJnzUVKDw--.25327S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1ruryrWF4kArW3KrWUCFg_yoW8KFW8pr
	W8Ca1YkFWqvFy2yr18XFs7JFWFvF4jyayUWrWv9Fn8tw45Xw1IkrWftryaya4qyFs5Ww45
	XryUCw1DW34qk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When the filesystem performs file or filesystem synchronization (e.g.,
ext4_sync_file()), it queries the journal to determine whether to flush
the file device through jbd2_trans_will_send_data_barrier(). If the
target transaction has not started committing, it assumes that the
journal will submit the flush command, allowing the filesystem to bypass
a redundant flush command. However, this assumption is not always valid.
If the journal is not located on the filesystem device, the journal
commit thread will not submit the flush command unless the variable
->t_need_data_flush is set to 1. Consequently, the flush may be missed,
and data may be lost following a power failure or system crash, even if
the synchronization appears to succeed.

Unfortunately, we cannot determine with certainty whether the target
transaction will flush to the filesystem device before it commits.
However, if it has not started committing, it must be the running
transaction. Therefore, fix it by always set its t_need_data_flush to 1,
ensuring that the committing thread will flush the filesystem device.

Fixes: bbd2be369107 ("jbd2: Add function jbd2_trans_will_send_data_barrier()")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 97f487c3d8fc..37632ae18a4e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -609,7 +609,7 @@ int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid)
 int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid)
 {
 	int ret = 0;
-	transaction_t *commit_trans;
+	transaction_t *commit_trans, *running_trans;
 
 	if (!(journal->j_flags & JBD2_BARRIER))
 		return 0;
@@ -619,6 +619,16 @@ int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid)
 		goto out;
 	commit_trans = journal->j_committing_transaction;
 	if (!commit_trans || commit_trans->t_tid != tid) {
+		running_trans = journal->j_running_transaction;
+		/*
+		 * The query transaction hasn't started committing,
+		 * it must still be running.
+		 */
+		if (WARN_ON_ONCE(!running_trans ||
+				 running_trans->t_tid != tid))
+			goto out;
+
+		running_trans->t_need_data_flush = 1;
 		ret = 1;
 		goto out;
 	}
-- 
2.46.1


