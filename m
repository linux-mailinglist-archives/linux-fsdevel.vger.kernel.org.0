Return-Path: <linux-fsdevel+bounces-24666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F7F942A18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6CC1C21885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767711AD3E9;
	Wed, 31 Jul 2024 09:16:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045611AC436;
	Wed, 31 Jul 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417399; cv=none; b=uyzBmSxUJmOazTbzO18Y4WcMdyLuYw2twaGycKNLxfmJOrPPYsXeGTTjTvSChLeStDIhJeBuaI/5bMJU70LDRxOfKAzDhR4/eQl4APH+UtxGQwYxUpgs7L20w75BBh5OeJGIJgJUoKG4nFXPv0feoXIctQx5cwo34TAszqtgwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417399; c=relaxed/simple;
	bh=5rAxUpsa29U7VXnhdoJeM35hvhpCE5o97sMMKKKSa8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhHq/yTbFpcVaPBiFGETo8udJZTgBP25yrblTNuNFEn2lMZm+0ewYv2MZzwr8mpjnOndghlkTV0wiGRhUK6iJh7etuamXTCyqpJbUmsyUYoAovFW+EsOQ+/Ho2Mx6WNMNjYaIxQBxWwLIFT6OvGmFT9/kL9IB0GDCifMXTSh3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYmg91LnLz4f3jrw;
	Wed, 31 Jul 2024 17:16:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 183931A0568;
	Wed, 31 Jul 2024 17:16:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILpAKpmm6FzAQ--.49647S7;
	Wed, 31 Jul 2024 17:16:33 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 3/6] iomap: advance the ifs allocation if we have more than one blocks per folio
Date: Wed, 31 Jul 2024 17:13:02 +0800
Message-Id: <20240731091305.2896873-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB37ILpAKpmm6FzAQ--.49647S7
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrWF1DCFyDCrW3AF1UWrg_yoW8uryrpF
	Z8KFWqkFWxJw17urnFqa4DZrWj93y5XrWfCay3W3ZxZF1DJr1UKw4vgayYyF4fXr9rAF4S
	qFsYvFy8WF15Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUgo7NUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now we allocate ifs if i_blocks_per_folio is larger than one when
writing back dirty folios in iomap_writepage_map(), so we don't attach
an ifs after buffer write to an entire folio until it starts writing
back, if we partial truncate that folio, iomap_invalidate_folio() can't
clear counterpart block's dirty bit as expected. Fix this by advance the
ifs allocation to __iomap_write_begin().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 64c4808fab31..ec17bf8d62e9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -686,6 +686,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	size_t from = offset_in_folio(folio, pos), to = from + len;
 	size_t poff, plen;
 
+	if (nr_blocks > 1) {
+		ifs = ifs_alloc(iter->inode, folio, iter->flags);
+		if ((iter->flags & IOMAP_NOWAIT) && !ifs)
+			return -EAGAIN;
+	}
+
 	/*
 	 * If the write or zeroing completely overlaps the current folio, then
 	 * entire folio will be dirtied so there is no need for
@@ -697,10 +703,6 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	    pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;
 
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	if ((iter->flags & IOMAP_NOWAIT) && !ifs && nr_blocks > 1)
-		return -EAGAIN;
-
 	if (folio_test_uptodate(folio))
 		return 0;
 	folio_clear_error(folio);
@@ -1913,7 +1915,12 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (i_blocks_per_folio(inode, folio) > 1) {
-		if (!ifs) {
+		/*
+		 * This should not happen since we always allocate ifs in
+		 * iomap_folio_mkwrite_iter() and there is more than one
+		 * blocks per folio in __iomap_write_begin().
+		 */
+		if (WARN_ON_ONCE(!ifs)) {
 			ifs = ifs_alloc(inode, folio, 0);
 			iomap_set_range_dirty(folio, 0, end_pos - pos);
 		}
-- 
2.39.2


