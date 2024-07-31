Return-Path: <linux-fsdevel+bounces-24668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998D3942A21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504BB1F256A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE81AD9DE;
	Wed, 31 Jul 2024 09:16:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C361AC43B;
	Wed, 31 Jul 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417400; cv=none; b=BAfJkQFyBqRx8cniHqO7SbpTPg2lEHS58fZNHYC1iNi8l5dM0AV/tz+NefFIFJzhRNuc7us4yfydaH8OgJBfiJrqTbqxRD41oop/T5CaqUI/Zk0FzIff1qNmR0urQlgeo1XdiQphTga9ftESpRB8Tza183A/imCGDEEF7ypa4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417400; c=relaxed/simple;
	bh=fQDfzoX+dvqOFd2X9B/BIJrb0UaomEvkb1IM0Myel1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDqrtWwO+vrGvMdipGqunAWuFWse1e0tOyP+dpZGXhO3ULnEYYOxElYq9rOOgn+kQBnfFIDWN6wCgoNaLqaGB0WiAKxXXuicO+TPjpqnSxBAzlucAaF1kOvwoUEaD6HnjQjTv5er3KYJbna74v8XgVvKQ3MrozzsC8uMFJWO2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYmgB1N9zz4f3jHc;
	Wed, 31 Jul 2024 17:16:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1A6C31A0568;
	Wed, 31 Jul 2024 17:16:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILpAKpmm6FzAQ--.49647S9;
	Wed, 31 Jul 2024 17:16:34 +0800 (CST)
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
Subject: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs uptodate bits
Date: Wed, 31 Jul 2024 17:13:04 +0800
Message-Id: <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgB37ILpAKpmm6FzAQ--.49647S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tr47WFyUuw4ruryxKF13twb_yoW8ZFW7pF
	Z0kFZ8Kr48Xa17ur17AFn7AF1jy395uw4rCFZxGw1rZFs8JFW3Wrn2kay5ZFW8XFy3CFZa
	qr4vgFyrWFWUZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfU5YFCUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Commit '1cea335d1db1 ("iomap: fix sub-page uptodate handling")' fix a
race issue when submitting multiple read bios for a page spans more than
one file system block by adding a spinlock(which names state_lock now)
to make the page uptodate synchronous. However, the race condition only
happened between the read I/O submitting and completeing threads, it's
sufficient to use page lock to protect other paths, e.g. buffered write
path. After large folio is supported, the spinlock could affect more
about the buffered write performance, so drop it could reduce some
unnecessary locking overhead.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f5668895df66..248f4a586f8f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -73,14 +73,10 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
-	unsigned long flags;
 	bool uptodate = true;
 
-	if (ifs) {
-		spin_lock_irqsave(&ifs->state_lock, flags);
+	if (ifs)
 		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
-		spin_unlock_irqrestore(&ifs->state_lock, flags);
-	}
 
 	if (uptodate)
 		folio_mark_uptodate(folio);
@@ -395,7 +391,18 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
+		if (ifs) {
+			/*
+			 * Hold state_lock to protect from submitting multiple
+			 * bios for the same locked folio and then get multiple
+			 * callbacks in parallel.
+			 */
+			spin_lock_irq(&ifs->state_lock);
+			iomap_set_range_uptodate(folio, poff, plen);
+			spin_unlock_irq(&ifs->state_lock);
+		} else {
+			folio_mark_uptodate(folio);
+		}
 		goto done;
 	}
 
-- 
2.39.2


