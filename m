Return-Path: <linux-fsdevel+bounces-61709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C60B5924E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65E67ACFE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5759029B775;
	Tue, 16 Sep 2025 09:35:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C6296BB6;
	Tue, 16 Sep 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015316; cv=none; b=j6XEFZaaBwdKwcS/Xz/ycM5ckQldMxi3q51gc4ltG3bi33oynxXp7O2xiVZIwgYYQXR0obCS9mkVQKZ1TqoQQ+XfJffSMRbaGIKFT8lDcas3RAwCjYHkVg83+eU1/OGmofTNXXBNiBDWM+/IDD3cEMar46bTcJ/ueXQm/Y6stm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015316; c=relaxed/simple;
	bh=jCU4xSa9+1LGaPsyL6OfJbFmHOlnj4FeIJVIUBrpyeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSiuIGgT16X6c4xhXfHtbxVn6rrlgrbvEQGiH/H0LyJh/F+jYcML7/aSoJ2tVGFY3gu1zh6YNZGJN6Js176F2h3SADBORHdJPYYHb110c1o96jv3dDvlPwHwAxJhdlrVdjBtKg3evvu1AkLUkmTgW78PB9uslFVfaCSg7py3N5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cQxZl4ZmPzKHN74;
	Tue, 16 Sep 2025 17:35:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4758C1A0E1E;
	Tue, 16 Sep 2025 17:35:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAncIxIL8loVknDCg--.4503S4;
	Tue, 16 Sep 2025 17:35:10 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	hsiangkao@linux.alibaba.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/2] ext4: fix an data corruption issue in nojournal mode
Date: Tue, 16 Sep 2025 17:33:35 +0800
Message-ID: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIxIL8loVknDCg--.4503S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWrCry5Zw17KFWrCFWrGrg_yoWDKwb_uF
	WvyF98JrsYqaySkFW3Krs8WrySkrWIgr18Xan5K3ZxKryUJFnruan3KrZ3ZrnF9F4F93s8
	JFyqvw4xZwnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello!

This series fixes an data corruption issue reported by Gao Xiang in
nojournal mode. The problem is happened after a metadata block is freed,
it can be immediately reallocated as a data block. However, the metadata
on this block may still be in the process of being written back, which
means the new data in this block could potentially be overwritten by the
stale metadata and trigger a data corruption issue. Please see below
discussion with Jan for more details:

  https://lore.kernel.org/linux-ext4/a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com/

Patch 1 strengthens the same case in ordered journal mode, theoretically
preventing the occurrence of stale data issues. 
Patch 2 fix this issue in nojournal mode.

Regards,
Yi.

Zhang Yi (2):
  jbd2: ensure that all ongoing I/O complete before freeing blocks
  ext4: wait for ongoing I/O to complete before freeing blocks

 fs/ext4/ext4_jbd2.c   | 11 +++++++++--
 fs/jbd2/transaction.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.46.1


