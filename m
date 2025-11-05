Return-Path: <linux-fsdevel+bounces-67072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92DC345A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 08:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE5A4643C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CA2D738F;
	Wed,  5 Nov 2025 07:51:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96A2D3EEE;
	Wed,  5 Nov 2025 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329076; cv=none; b=jLLqOIPshANm+ntOiQlmq81jH7AkVyMD+QGpt1HsK1JB82Ydz2NkHyIesuXJTJz9yshcYgg0Z49Vnii3zxSPa0a9qRk4X1wLlZaJLpEpWQ1H/KSwRM8En6OQYKZOFP5i8BmMZ8l1xvGnvh034pgNQWLP1agMmzoZ64RfpkFM3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329076; c=relaxed/simple;
	bh=Mi3SLcKWF/I2VhLI6qip2Pj6X1BLedYbH+puqE7h/sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6tyly+0MbsrL+tlGo5t1wCZi1dUK5Q7dUOdrk7n91OtqqYyDOS/OOBIHud6Xn7JC8YQCMiZPEU6rHX1ioKCHkzv3x3ENOEcW0PKXdZdDJpb68e9adHeZyPnvhsaWSa4FFZSnNcdZk5PDxOTveJs9S+aawa7aXbrRfzh4AQGx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1cvL5L5hzYQvKB;
	Wed,  5 Nov 2025 15:50:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1C3D41A10E5;
	Wed,  5 Nov 2025 15:51:11 +0800 (CST)
Received: from huawei.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UXuAQtpwcIVCw--.9854S5;
	Wed, 05 Nov 2025 15:51:11 +0800 (CST)
From: Yongjian Sun <sunyongjian@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	jack@suse.cz,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	libaokun1@huawei.com,
	chengzhihao1@huawei.com,
	sunyongjian1@huawei.com
Subject: [PATCH 1/2] ext4: fix incorrect group number assertion in mb_check_buddy for exhausted preallocations
Date: Wed,  5 Nov 2025 15:42:49 +0800
Message-Id: <20251105074250.3517687-2-sunyongjian@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
References: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
Reply-To: sunyongjian1@huawei.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UXuAQtpwcIVCw--.9854S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AryUWr47Aw1rZFWrGF4kZwb_yoW8uF1DpF
	s8G3WUKr9agr1xuanFg34qg340kw40gr15Jry2gr1jqry3Grn3K398ta4j9Fn5AFWfX3W3
	ZFyavry7Wr17ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwI
	xGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UNdbbUUUUU=
X-CM-SenderInfo: 5vxq505qjmxt3q6k3tpzhluzxrxghudrp/

From: Yongjian Sun <sunyongjian1@huawei.com>

When the MB_CHECK_ASSERT macro is enabled, an assertion failure can
occur in __mb_check_buddy when checking preallocated blocks (pa) in
a block group:

Assertion failure in mb_free_blocks() : "groupnr == e4b->bd_group"

This happens when a pa at the very end of a block group (e.g.,
pa_pstart=32765, pa_len=3 in a group of 32768 blocks) becomes
exhausted - its pa_pstart is advanced by pa_len to 32768, which
lies in the next block group. If this exhausted pa (with pa_len == 0)
is still in the bb_prealloc_list during the buddy check, the assertion
incorrectly flags it as belonging to the wrong group. A possible
sequence is as follows:

ext4_mb_new_blocks
  ext4_mb_release_context
    pa->pa_pstart += EXT4_C2B(sbi, ac->ac_b_ex.fe_len)
    pa->pa_len -= ac->ac_b_ex.fe_len

	                 __mb_check_buddy
                           for each pa in group
                             ext4_get_group_no_and_offset
                             MB_CHECK_ASSERT(groupnr == e4b->bd_group)

To fix this, we modify the check to skip block group validation for
exhausted preallocations (where pa_len == 0). Such entries are in a
transitional state and will be removed from the list soon, so they
should not trigger an assertion. This change prevents the false
positive while maintaining the integrity of the checks for active
allocations.

Fixes: c9de560ded61f ("ext4: Add multi block allocator for ext4")
Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9087183602e4..194a9f995c36 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -768,6 +768,8 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 		ext4_group_t groupnr;
 		struct ext4_prealloc_space *pa;
 		pa = list_entry(cur, struct ext4_prealloc_space, pa_group_list);
+		if (!pa->pa_len)
+			continue;
 		ext4_get_group_no_and_offset(sb, pa->pa_pstart, &groupnr, &k);
 		MB_CHECK_ASSERT(groupnr == e4b->bd_group);
 		for (i = 0; i < pa->pa_len; i++)
-- 
2.39.2


