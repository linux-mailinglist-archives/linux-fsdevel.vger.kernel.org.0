Return-Path: <linux-fsdevel+bounces-25670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE56194ECA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62D61F22384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4B817B426;
	Mon, 12 Aug 2024 12:16:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3096816BE3B;
	Mon, 12 Aug 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464984; cv=none; b=p4GbKcxKloDNGq9XsqYMgHEDg9qyxPbqYqWyJKsUwtgxgUhldbovSWlWVsYP+eZgfHgpMjE/9qXsc2FDd+/3ZBW1H/13EMP5e3pEij5z1yLB1kfRF+e6KfvV9DE3sv6Ol6yLx/HydfsPxYFDIU5NrX3cVehadraxGVuCcljrhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464984; c=relaxed/simple;
	bh=b13qTTePhXsovr+tkZ99PLzauYfJFJPIBeRsrYSKIgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b45DLnX2DHiyItgSRMOf1DkMym+q7kW7NfWhAHsuHMk9xMVBXBiGfE2MW5FrBKNfvBCAi+0EuMzDwefVZ56jxZAGqFraRfZIB44K9yvNkQde/n2B4qtVVhsX8AR2vr7LApJgrya7mHfwAqz+/VfOwKuCdeoBuYXwdVdkRbJJ7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjD4t0khnz4f3mHt;
	Mon, 12 Aug 2024 20:15:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AF1911A144C;
	Mon, 12 Aug 2024 20:16:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDHeLcD_blmHhy7BQ--.21435S7;
	Mon, 12 Aug 2024 20:16:12 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 3/6] iomap: advance the ifs allocation if we have more than one blocks per folio
Date: Mon, 12 Aug 2024 20:11:56 +0800
Message-Id: <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHeLcD_blmHhy7BQ--.21435S7
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrWF1DCFyDCrW3AF1UWrg_yoW8Zw4DpF
	WDKFWqkFWxJr17urnrXas8ZrWj93yYqrWfCay3W3ZxZF1Dtr17Kw4kKa4YyFyxXr97Ar4S
	vFs0vFy8WF15Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUF3kuDUUUU
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
index 763deabe8331..79031b7517e5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -699,6 +699,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
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
@@ -710,10 +716,6 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	    pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;
 
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	if ((iter->flags & IOMAP_NOWAIT) && !ifs && nr_blocks > 1)
-		return -EAGAIN;
-
 	if (folio_test_uptodate(folio))
 		return 0;
 
@@ -1928,7 +1930,12 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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


