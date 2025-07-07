Return-Path: <linux-fsdevel+bounces-54123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC9AFB5E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955B97A8797
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF72D2D9EE2;
	Mon,  7 Jul 2025 14:23:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6572DA75A;
	Mon,  7 Jul 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898185; cv=none; b=aFvmOxpMnq2uNSEu9wE5im9QzpWmAEkLr3h8GziHtvVbw93ueQeEvLud/LQcF0x99//EDdoO2zXKnPkwGbKdmFNo1GmGG3iQa5vEiRf+vQVxBOR7UwrktYG4FDzczH0OPQdwntXZO5b2+mBuQZJPecCk3jznp9+GkRWwCNkFZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898185; c=relaxed/simple;
	bh=FZKwy07XvmKoMENra/1jCtoEiCc4x782o8p/B/1DuME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssx5MvXKgjtGCZjzcfdKbP56FHFZH4LJdVrUK0DhTWopyI5FfK2/UodGSDCxtuWrV+f7gjX1+Asb4QBRuauWNbi8rEK3dFUyG5MPz+9rQ3+lUX9aJABLp4B0KRinewQiWh35qPLx7Oje8kgxune9ifaIpPMk05RoxqUUKMPD3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbRKf5vr1zKHMbB;
	Mon,  7 Jul 2025 22:23:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 46A991A12FE;
	Mon,  7 Jul 2025 22:23:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyQ22GtoNazLAw--.46745S14;
	Mon, 07 Jul 2025 22:23:01 +0800 (CST)
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
Subject: [PATCH v4 10/11] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
Date: Mon,  7 Jul 2025 22:08:13 +0800
Message-ID: <20250707140814.542883-11-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBnxyQ22GtoNazLAw--.46745S14
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7Zw48KrW5GFWrCF1fCrg_yoW8Xw4fp3
	Z5Ca48Gry8Ww409a18Wa12qr48Ka1kGa17WFWfJw15XFZxZryfKrnFq348Aa45tFWSkw1q
	qF4ayry3Gw1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The calculation of journal credits in ext4_meta_trans_blocks() should
include pextents, as each extent separately may be allocated from a
different group and thus need to update different bitmap and group
descriptor block.

Fixes: 0e32d8617012 ("ext4: correct the journal credits calculations of allocating blocks")
Reported-by: Jan Kara <jack@suse.cz>
Closes: https://lore.kernel.org/linux-ext4/nhxfuu53wyacsrq7xqgxvgzcggyscu2tbabginahcygvmc45hy@t4fvmyeky33e/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 85ad14451b26..4b679cb6c8bd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6214,7 +6214,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 	int ret;
 
 	/*
-	 * How many index and lead blocks need to touch to map @lblocks
+	 * How many index and leaf blocks need to touch to map @lblocks
 	 * logical blocks to @pextents physical extents?
 	 */
 	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
@@ -6223,7 +6223,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 	 * Now let's see how many group bitmaps and group descriptors need
 	 * to account
 	 */
-	groups = idxblocks;
+	groups = idxblocks + pextents;
 	gdpblocks = groups;
 	if (groups > ngroups)
 		groups = ngroups;
-- 
2.46.1


