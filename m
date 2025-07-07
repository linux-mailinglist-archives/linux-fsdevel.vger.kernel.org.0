Return-Path: <linux-fsdevel+bounces-54121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3C0AFB5E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA014A5985
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0682DAFDF;
	Mon,  7 Jul 2025 14:23:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A082D979B;
	Mon,  7 Jul 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898183; cv=none; b=r/WEJqJqtyDaqaxDV5K1plOTxIIvoaf2cSNrB0Kchl3WTBAQS4XuAGLB2Q/f7t3NVRtKgwQh0kBbITaE/fvBPKCXRgm23K5x/asGpGlOZECavKmORuZg7/Y7T2DNKypPzvT9h5bibSaAG3TK8n1f/WyYnsUxkPHna0t4e/eYKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898183; c=relaxed/simple;
	bh=Tlr4jkPGncwYUzYVHVlanVU+MejPUHbRbaB44ARJM34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvO7Q57TPJp8r7SHlfbox7pCEmLXv5n+UU6QMIHfrSZSL1zJb7WYUEShBp8ZfAdV16n4Jir6XDhxNufD3CDpC0A7+KW3gksqT4BwFn7gWJdOwjhdbK3BI0nI8se8eAwRUZ1kBI8DejiQWTPtN4kDpnWOQPW58KHBXXghTPnVhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbRKd0VX9zKHMkt;
	Mon,  7 Jul 2025 22:23:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8492D1A1A87;
	Mon,  7 Jul 2025 22:22:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyQ22GtoNazLAw--.46745S11;
	Mon, 07 Jul 2025 22:22:59 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	naresh.kamboju@linaro.org,
	jiangqi903@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 07/11] ext4: correct the reserved credits for extent conversion
Date: Mon,  7 Jul 2025 22:08:10 +0800
Message-ID: <20250707140814.542883-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxyQ22GtoNazLAw--.46745S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kAw4fJFyDJFyxZr1fZwb_yoW8Gw45pF
	nxGFykWF18u348uana93W7AF1fCayxC3yUXF4fCw1UXa98GryxKr1qgw1rtF1UJrWxJrWr
	ZF47CryUu3W3Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now, we reserve journal credits for converting extents in only one page
to written state when the I/O operation is complete. This is
insufficient when large folio is enabled.

Fix this by reserving credits for converting up to one extent per block in
the largest 2MB folio, this calculation should only involve extents index
and leaf blocks, so it should not estimate too many credits.

Fixes: 7ac67301e82f ("ext4: enable large folio for regular file")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 51effbad90e5..3ed4bc6c02f8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2849,12 +2849,12 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	mpd->journalled_more_data = 0;
 
 	if (ext4_should_dioread_nolock(inode)) {
+		int bpf = ext4_journal_blocks_per_folio(inode);
 		/*
 		 * We may need to convert up to one extent per block in
-		 * the page and we may dirty the inode.
+		 * the folio and we may dirty the inode.
 		 */
-		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
-						PAGE_SIZE >> inode->i_blkbits);
+		rsv_blocks = 1 + ext4_ext_index_trans_blocks(inode, bpf);
 	}
 
 	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-- 
2.46.1


