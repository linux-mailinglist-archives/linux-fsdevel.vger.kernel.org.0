Return-Path: <linux-fsdevel+bounces-27101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B62695E9D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0D61C20CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91F12CD89;
	Mon, 26 Aug 2024 07:02:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58FC376E6;
	Mon, 26 Aug 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655767; cv=none; b=Bk/oenfDV5VXPxib+E5cIrAWf9zIQcphe5XZNL4NUTwzZx94WWy1oJxXQCIQD4ovQoZwEzgqHwkhIhbUEWYoSqtLF2YQnb1vAhplz+jM8Yle/lfvzYk6QqFFp1ZVtmzmhwis6PaLdn04IARvleIYnZjo/LEHDu90Uc/EHKvXYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655767; c=relaxed/simple;
	bh=RtsuMEmYLvVLNNihKGcq7/xNuJEMDw9RX/dosPOT34I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAYZG/ganwwfwcSWxCf3fgzehCyFnMsRmG7lpsbzyVCJLv/JcKg9Pjpppy7OkyvOkIuUgx8tjmfQhr8LEEvbW8Y2N480FFtu5Qm3ZE2qI7BBHsiWKiRtXaGwiXjCy7pU0HecW+xYdZUbwoX8gw9CPEl7/gA52OZGi2zdlZHR/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WshR33d8NzpTNf;
	Mon, 26 Aug 2024 15:01:03 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E8061401F0;
	Mon, 26 Aug 2024 15:02:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 15:02:41 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>
CC: <lizetao1@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH -next 2/3] buffer: Using scope-based resource instead of folio_lock/unlock
Date: Mon, 26 Aug 2024 15:10:35 +0800
Message-ID: <20240826071036.2445717-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826071036.2445717-1-lizetao1@huawei.com>
References: <20240826071036.2445717-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Use guard() to manage locking and unlocking a folio, thus avoiding the
use of goto unlock code. Remove the unlock_page label, and return
directly when an error occurs, allowing the compiler to release the
folio's lock.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/buffer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 45eb06cb1a4e..77ab93531a33 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1740,11 +1740,11 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 			 * to pin buffers here since we can afford to sleep and
 			 * it scales better than a global spinlock lock.
 			 */
-			folio_lock(folio);
+			guard(folio)(folio);
 			/* Recheck when the folio is locked which pins bhs */
 			head = folio_buffers(folio);
 			if (!head)
-				goto unlock_page;
+				continue;
 			bh = head;
 			do {
 				if (!buffer_mapped(bh) || (bh->b_blocknr < block))
@@ -1757,8 +1757,6 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 next:
 				bh = bh->b_this_page;
 			} while (bh != head);
-unlock_page:
-			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.34.1


