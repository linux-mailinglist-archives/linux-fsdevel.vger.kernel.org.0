Return-Path: <linux-fsdevel+bounces-17773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1130D8B2288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433941C210DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C214A638;
	Thu, 25 Apr 2024 13:23:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A2149DFF;
	Thu, 25 Apr 2024 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051390; cv=none; b=eVLt7mv3jaNAykTXyJaCjeeRhjZ/2x8rs9VnL2KIUw9BCeQHMTmtDZ8UF5NdqWNmO22vQrF0ymc4YcQWHPBM7Y02mdF3cA2MqmiyGxoHRl71LFA0ygUg1SaNZEyVnnUfn6sPuO2mZ5w/z4KHzaki+cy0rk6cj9J8npLlwvPj0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051390; c=relaxed/simple;
	bh=T9CB/14h22Jxeiypil76GtHJ5Ts5DCRktacasBHU42o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMIqQYwZevvgWCOtuCpLYz0amXu0DVyEwSNwUVQf6PNQ3uAJUOUoTbK16WYviJVyDBeIC/CZMIuiIPaBQVraaEB/xnrN7EqWetHTv8ZGpICf8aJq6Y2EDXjHF3Q4wOhOeZ2StXnLK4ISiwllxIRBKcAp5nY0YTmhaNYvaEiE6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQGkS4bvxz4f3nJd;
	Thu, 25 Apr 2024 21:22:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DD7791A016E;
	Thu, 25 Apr 2024 21:23:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEqWSpmHu+2Kw--.61462S9;
	Thu, 25 Apr 2024 21:23:05 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 5/9] iomap: drop the write failure handles when unsharing and zeroing
Date: Thu, 25 Apr 2024 21:13:31 +0800
Message-Id: <20240425131335.878454-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBEqWSpmHu+2Kw--.61462S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43GryfJw13AF1DKw1DGFg_yoW8Cw43pr
	9xKaykCFWxJF47uF1kJFy5uFyYyFZ7KrW7CrWUGw43uFsFyrWYgF10gayYvF1DJ3s7AryS
	qF4vyryrX3W5Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Unsharing and zeroing can only happen within EOF, so there is never a
need to perform posteof pagecache truncation if write begin fails, also
partial write could never theoretically happened from iomap_write_end(),
so remove both of them.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0..433eaae39966 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -824,7 +824,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 
 out_unlock:
 	__iomap_put_folio(iter, pos, 0, folio);
-	iomap_write_failed(iter->inode, pos, len);
 
 	return status;
 }
@@ -901,8 +900,6 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 
 	if (old_size < pos)
 		pagecache_isize_extended(iter->inode, old_size, pos);
-	if (ret < len)
-		iomap_write_failed(iter->inode, pos + ret, len - ret);
 	return ret;
 }
 
@@ -950,8 +947,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		}
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (unlikely(status))
+		if (unlikely(status)) {
+			iomap_write_failed(iter->inode, pos, bytes);
 			break;
+		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
@@ -965,6 +964,9 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
 
+		if (status < bytes)
+			iomap_write_failed(iter->inode, pos + status,
+					   bytes - status);
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
 
-- 
2.39.2


