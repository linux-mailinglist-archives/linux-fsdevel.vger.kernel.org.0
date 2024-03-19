Return-Path: <linux-fsdevel+bounces-14786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77F87F4E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 02:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70DE1F21ACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 01:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FCE1B7FD;
	Tue, 19 Mar 2024 01:18:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC3847C;
	Tue, 19 Mar 2024 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710811127; cv=none; b=BwfDUMle8XgolXM1+WhoJjuMm0CYc7OhPj3qBp+dIjZ4GPzUPaiAb2QUCMZPsCiCLsMGUAfBeOWZduRMI2gDfKHLqCzStX3bybhAbMx5651+hhue99DE1zga5Y7a2SLUyRnT8tpm0DUHdz+ex7nlXRRRqi9hD4SmzBjaPtvrVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710811127; c=relaxed/simple;
	bh=MMrbMRAxlRdrfAR82H7F/UOhyfZI3AaGwXVLWaHdmc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DyTha109+1a2DR+TBoH0adNZYIFhfrczAtlaUNmDmp3SKg0Hj0Z2hsxOed/esWf3K2KwFq4LAQkGEk8HDj1yR+H0t2+BfHqcGl+LYoIA3e51u48Rer+5FV6FsGW9e80TNZhbXkjXdk0sChQTncFVHaYB42G/xvXc30N4PEHhJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TzDPf6qNKz4f3kFp;
	Tue, 19 Mar 2024 09:18:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DC0C91A017A;
	Tue, 19 Mar 2024 09:18:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7O5_hlUIGNHQ--.34497S13;
	Tue, 19 Mar 2024 09:18:36 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 9/9] iomap: do some small logical cleanup in buffered write
Date: Tue, 19 Mar 2024 09:11:02 +0800
Message-Id: <20240319011102.2929635-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7O5_hlUIGNHQ--.34497S13
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykWry8urWrArWUZr4xJFb_yoW8Jw43pr
	nxKay8CrW0qwsruF1kAF9ruFyjya97Gry7GrWUGw45urs8ArWYgFy0gayjv3W8XrZ3C34S
	vr4vy348Jw15ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since iomap_write_end() can never return a partial write length, the
comperation between written, copied and bytes becomes useless, just
merge them with the unwritten branch.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 004673ea8bc1..f2fb89056259 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -937,11 +937,6 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 		if (old_size < pos)
 			pagecache_isize_extended(iter->inode, old_size, pos);
-		if (written < bytes)
-			iomap_write_failed(iter->inode, pos + written,
-					   bytes - written);
-		if (unlikely(copied != written))
-			iov_iter_revert(i, copied - written);
 
 		cond_resched();
 		if (unlikely(written == 0)) {
@@ -951,6 +946,9 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
+			iomap_write_failed(iter->inode, pos, bytes);
+			iov_iter_revert(i, copied);
+
 			if (chunk > PAGE_SIZE)
 				chunk /= 2;
 			if (copied) {
-- 
2.39.2


