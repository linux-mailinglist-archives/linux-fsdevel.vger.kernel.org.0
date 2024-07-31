Return-Path: <linux-fsdevel+bounces-24669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C36942A26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE071C23DDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4621AC433;
	Wed, 31 Jul 2024 09:16:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35181AC43F;
	Wed, 31 Jul 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417400; cv=none; b=tOmk8ig7ILq3RwDpW4FDykU2iAms1eKO0GfqnV05maUf7fnBvoT9KEYk7pz+1cs7wUp8Veo6THkggfaWp1+K8G2u5EB4bC/BgBfClsO8tfhKJfHcpSxLJ8+B/KYyFi/USR2XmuJgs6JtkzBs4IVjRfGI/VJBPBK2Z+SeeA0IgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417400; c=relaxed/simple;
	bh=t7fdWK/Ay9juS5kXI8eBeWil8SHXhzTLA3CH4pADQ+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ToimN412HZKOx0lWBtcFpOld8Rvm1Gcq7fzLGkMaIVPFy6x782wWecn96SALegETwEhIpX3YYg7aCNQmtdCj5mPbzk+vQEvjkmMnYMgSi4AIXarU+T96YLvZ5uZebAuNmYaedypl2q1Dh6zHSTuqjsB7ld5id5T890VVqbW4IWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYmgG6h4fz4f3jtD;
	Wed, 31 Jul 2024 17:16:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 948A81A018D;
	Wed, 31 Jul 2024 17:16:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILpAKpmm6FzAQ--.49647S10;
	Wed, 31 Jul 2024 17:16:35 +0800 (CST)
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
Subject: [PATCH 6/6] iomap: drop unnecessary state_lock when changing ifs dirty bits
Date: Wed, 31 Jul 2024 17:13:05 +0800
Message-Id: <20240731091305.2896873-7-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgB37ILpAKpmm6FzAQ--.49647S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13tFyxuF47AF48KrW7urg_yoW8Ar4DpF
	s3KFs8Kr4DZryDu3yUXFy8XrnYka9Fq3y8ArWxC3sxGa15ZryYgrn7uay3ZrW0gr9xCFnY
	vrnrGr18GrZ8C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbb4S7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hold the state_lock when set and clear ifs dirty bits is unnecessary
since both paths are protected under folio lock, so it's safe to drop
the state_lock, which could reduce some unnecessary locking overhead and
improve the buffer write performance a bit.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 248f4a586f8f..22ce6062cfd1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -137,14 +137,8 @@ static void ifs_clear_range_dirty(struct folio *folio,
 	unsigned int first_blk = DIV_ROUND_UP(off, i_blocksize(inode));
 	unsigned int last_blk = (off + len) >> inode->i_blkbits;
 	unsigned int nr_blks = last_blk - first_blk;
-	unsigned long flags;
 
-	if (!nr_blks)
-		return;
-
-	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_clear(ifs->state, first_blk + blks_per_folio, nr_blks);
-	spin_unlock_irqrestore(&ifs->state_lock, flags);
 }
 
 static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
@@ -163,11 +157,8 @@ static void ifs_set_range_dirty(struct folio *folio,
 	unsigned int first_blk = (off >> inode->i_blkbits);
 	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
 	unsigned int nr_blks = last_blk - first_blk + 1;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_set(ifs->state, first_blk + blks_per_folio, nr_blks);
-	spin_unlock_irqrestore(&ifs->state_lock, flags);
 }
 
 static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
-- 
2.39.2


