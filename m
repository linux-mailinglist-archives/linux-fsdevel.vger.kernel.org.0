Return-Path: <linux-fsdevel+bounces-71929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A0CD7A21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F2C1300460D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE24323C8C7;
	Tue, 23 Dec 2025 01:20:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386E1F4615;
	Tue, 23 Dec 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452848; cv=none; b=iHishLqkro5ehYePt/bqJYz55z7NRbNdl1gOUvr0Pp8FDYyIIi1sxZGRWbzHbeYP2o98NppxBlEqgKZ6V5nLeR9DgyMFh+4BQNRCcibp22BrCpWP2UyHGUgPrpL4lt2MLqkSfUwUOIWhiqJYE9fh/Y2MruF10PNQjaPnxgcy++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452848; c=relaxed/simple;
	bh=wTGAjbP+ZPWTJsSVnVKvbFkqaRRbXnR+qYXVurGyTxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjOufVbQn8xgp6uKge88cShkML30WFfdMfcHinHfOpSyryUkHshG8eyLj6gOYVt36f8sFshxoVXDp2IjwxQHGn+7dn4nH8dCf7ZPX8JoMy5nrh934wAMHAI7q2XIZmBjbdYgqfT/cCz/nEzMDNkSK0hzAaSfPCkxOW9qY6zDPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZxyg078dzKHMNj;
	Tue, 23 Dec 2025 09:20:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8E6F84058D;
	Tue, 23 Dec 2025 09:20:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_dY7klpHOeZBA--.61342S10;
	Tue, 23 Dec 2025 09:20:44 +0800 (CST)
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
Subject: [PATCH -next v2 6/7] ext4: simply the mapping query logic in ext4_iomap_begin()
Date: Tue, 23 Dec 2025 09:18:01 +0800
Message-ID: <20251223011802.31238-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXd_dY7klpHOeZBA--.61342S10
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUCFW7Cw1fWFW8tFWrXwb_yoW8Xw45pF
	Z3Ka95GFn5XF1UurZayrn3XrWUta1ftw4UZF4fWry5Xr90gr10qr4YgF1Yvr48JrWxArWF
	gFW0yr18u3WUZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In the write path mapping check of ext4_iomap_begin(), the return value
'ret' should never greater than orig_mlen. If 'ret' equals 'orig_mlen',
it can be returned directly without checking IOMAP_ATOMIC.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b84a2a10dfb8..67fe7d0f47e3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3816,17 +3816,19 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		if (offset + length <= i_size_read(inode)) {
 			ret = ext4_map_blocks(NULL, inode, &map, 0);
 			/*
-			 * For atomic writes the entire requested length should
-			 * be mapped. For DAX we convert extents to initialized
-			 * ones before copying the data, otherwise we do it
-			 * after I/O so there's no need to call into
-			 * ext4_iomap_alloc().
+			 * For DAX we convert extents to initialized ones before
+			 * copying the data, otherwise we do it after I/O so
+			 * there's no need to call into ext4_iomap_alloc().
 			 */
 			if ((map.m_flags & EXT4_MAP_MAPPED) ||
 			    (!(flags & IOMAP_DAX) &&
 			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
-				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
-				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
+				/*
+				 * For atomic writes the entire requested
+				 * length should be mapped.
+				 */
+				if (ret == orig_mlen ||
+				    (!(flags & IOMAP_ATOMIC) && ret > 0))
 					goto out;
 			}
 			map.m_len = orig_mlen;
-- 
2.52.0


