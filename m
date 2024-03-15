Return-Path: <linux-fsdevel+bounces-14446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A57C87CD9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1631C2249A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4333BBD0;
	Fri, 15 Mar 2024 13:01:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46924B52;
	Fri, 15 Mar 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507671; cv=none; b=Nb21CW/RLA2Uj5mHmFgh5qZ1fi+6jAr3P8ooRdQDetWRW+8d0s2CKxvtimTnB2LO3JEh2h7VUUH5NEHnpyJV95mCvtANciBWYWjS6JVZ2Y/fpjvqRqRE+/vIYe0MHDIC0Irmons4U8PoqsPjzwABPM90wJN6x4tG+U5L3664Tvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507671; c=relaxed/simple;
	bh=JfovSRICGTZ9ZriaIuolViU7gmL3XgHTj4nvWZySKmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTKpQnZBAm0IbXZCTceVKhJWjvaP8bWllg6avMRHCtQaoiF3tx1ENd2cagGwkojE6BPVIxwuQGNpxhp5HNC1n4qe8okQel7q1/HoMebbVbjAcF+zLA+U+fV/qtD4RI7U5bXp8t1x57VEhC5aAJ/wvAUX8QtY2s+jUN8V78swigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tx4B040XZz4f3m7Y;
	Fri, 15 Mar 2024 21:00:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 531751A0172;
	Fri, 15 Mar 2024 21:01:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBF9RvRldVMfHA--.12032S10;
	Fri, 15 Mar 2024 21:01:04 +0800 (CST)
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
Subject: [PATCH v2 06/10] iomap: drop the write failure handles when unsharing and zeroing
Date: Fri, 15 Mar 2024 20:53:50 +0800
Message-Id: <20240315125354.2480344-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBF9RvRldVMfHA--.12032S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43GryfJw13AF1DKw1DGFg_yoW8Cr45pr
	98K3ykCFWxJF47uF1kJFyDuFyYyFZ7KrW7CrWUGw43ZF4DAr42gF18KayYvF1kJ3s7ArWS
	qF4vya4rX3WUAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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
---
 fs/iomap/buffered-io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 093c4515b22a..7e32a204650b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -786,7 +786,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 
 out_unlock:
 	__iomap_put_folio(iter, pos, 0, folio);
-	iomap_write_failed(iter->inode, pos, len);
 
 	return status;
 }
@@ -863,8 +862,6 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 
 	if (old_size < pos)
 		pagecache_isize_extended(iter->inode, old_size, pos);
-	if (ret < len)
-		iomap_write_failed(iter->inode, pos + ret, len - ret);
 	return ret;
 }
 
@@ -912,8 +909,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		}
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (unlikely(status))
+		if (unlikely(status)) {
+			iomap_write_failed(iter->inode, pos, bytes);
 			break;
+		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
@@ -927,6 +926,9 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
 
+		if (status < bytes)
+			iomap_write_failed(iter->inode, pos + status,
+					   bytes - status);
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
 
-- 
2.39.2


