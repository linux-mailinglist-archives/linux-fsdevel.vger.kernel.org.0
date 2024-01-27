Return-Path: <linux-fsdevel+bounces-9165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225AF83E95D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CEE1C20ABA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEDE250FB;
	Sat, 27 Jan 2024 02:02:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8FA2110F;
	Sat, 27 Jan 2024 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320972; cv=none; b=gIfB3no91v22l9h5xIRvrLeq39tvj/M/jqG2hfzf80OA7hie6SuDpZalK0NUxpzKHmSyef2+Mtuzwrc7A9R38HHdhPcu/y8bP0HK9O0OaW4DNLTJc6wLqswM+iCeMYqezSjhvXd6pqAAczZaKOjEmVoZtceUJcbZPT7mNxoakT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320972; c=relaxed/simple;
	bh=Djzt3gG9VGFpPyJJtELMB+1UlRsfxWfHCTLPbGz+oKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8xGD4hZnNGfQRewzHOV1c3uqPwqheOjWuBIddA3IlwKMJ/0qywMqZj3nXajyL2hPFWbJ4IyojsabLLfM4n53xn4UwsiU3VNAEDYDEjMhUXkr6ORpLqHEMvzjEsMPixr3htmqEHokibmnrjuK0OR1w/09L5H+Ov1jmLnsCVEc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMHrj47R7z4f3k6D;
	Sat, 27 Jan 2024 10:02:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 01B511A016E;
	Sat, 27 Jan 2024 10:02:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S17;
	Sat, 27 Jan 2024 10:02:47 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v3 13/26] ext4: use reserved metadata blocks when splitting extent in endio
Date: Sat, 27 Jan 2024 09:58:12 +0800
Message-Id: <20240127015825.1608160-14-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S17
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rtw18JFykGr1kKw1xXwb_yoW8CrWUpr
	93Ar18Gr409a409aykZ3WUG34rua43WF47GrZ0q3y29FWUCFyFgr47tFyrZFyrtrWxX3Wj
	vF40v348AwnxAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now ext4 only reserved space for delalloc for data blocks in
ext4_da_reserve_space(), not reserve space for meta blocks when
allocating data blocks. Besides, if we enable dioread_nolock mount
option, it also not reserve meta blocks for the unwritten extents to
written extents conversion. In order to prevent data loss due to failed
to allocate meta blocks when writing data back, we reserve 2% space or
4096 blocks for meta data, and use EXT4_GET_BLOCKS_PRE_IO to do the
potential split in advance. But all these two methods are just best
efforts, if it's really running out of sapce, there is no difference
between splitting extent when writing data back and when I/Os are
completed, both will result in data loss.

The best way is to reserve enough space for metadata. Before that, we
can at least make sure that things will not get worse if we postpone
splitting extent in endio. Plus, after converting regular file's
buffered write path from buffer_head to iomap, splitting extents in
endio becomes mandatory. Now, in preparation for the future conversion,
let's use reserved sapce in endio too.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 6b64319a7df8..48d6d125ec37 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3722,7 +3722,8 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
 		err = ext4_split_convert_extents(handle, inode, map, ppath,
-						 EXT4_GET_BLOCKS_CONVERT);
+					EXT4_GET_BLOCKS_CONVERT |
+					EXT4_GET_BLOCKS_METADATA_NOFAIL);
 		if (err < 0)
 			return err;
 		path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
-- 
2.39.2


