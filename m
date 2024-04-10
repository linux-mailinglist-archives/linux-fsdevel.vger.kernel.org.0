Return-Path: <linux-fsdevel+bounces-16544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B389F83F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5D283C15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970B16131C;
	Wed, 10 Apr 2024 13:37:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3F015F3F1;
	Wed, 10 Apr 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756220; cv=none; b=Oby5xe4QGfeJoO16yRDP9KADrgmChTC4TCNoG7BRjU3njHn2YXs5JOYiHAkzFAjmMsiB4eaoZ3vorbrbAlzEC3pL4GkZZz+BeB/mEBjitgAnySgYETJfGnSmdfEKwMovpyQcIlxtlN/I0O0Ba0CEGphjVNKWi6YoUUFUxchKXYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756220; c=relaxed/simple;
	bh=TM4qDKZK35Fc/9JvO5v33Rd+SvYcQ16DuJ+M8p2vB+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtJNE0XH/Yc2K/78dhzTihMzSSNc31KLz53TaDB8mD2zbJRShVqTMnOqP05zUid2BvAWxL1ZansnBvuE55hxLRZB0fWjrib+ILm1oD7P4FRFLHgS/pBEZEqs2uJt5THRKTSUeP5m8vCTRJ8AVdR1KwxTgjr+jSJpDvQcW5w+SBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF3lL5KVvz4f3mHL;
	Wed, 10 Apr 2024 21:36:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 66B571A0DEA;
	Wed, 10 Apr 2024 21:36:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S16;
	Wed, 10 Apr 2024 21:36:55 +0800 (CST)
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
Subject: [RFC PATCH v4 12/34] ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
Date: Wed, 10 Apr 2024 21:27:56 +0800
Message-Id: <20240410132818.2812377-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
References: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S16
X-Coremail-Antispam: 1UD129KBjvJXoW7ury7tw17uryDWrW3uFWUCFg_yoW8KF48p3
	sxAr1rWF4UWw1UuayI9r48ur15GayjkrWDur4rur1rWayfCrySkF1qyFW0gF9FqrW8Z3WY
	qFWru34DCayfGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since we always set EXT4_GET_BLOCKS_DELALLOC_RESERVE when allocating
delalloc blocks, no matter whether allocating delayed or non-delayed
allocated blocks. There is no need to keep delayed flag on unwritten
extent status entry, so just drop it after blocks have been allocated.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c |  9 +--------
 fs/ext4/inode.c          | 11 -----------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 2320b0d71001..952a38eaea0f 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -867,14 +867,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		return;
 
 	BUG_ON(end < lblk);
-
-	if ((status & EXTENT_STATUS_DELAYED) &&
-	    (status & EXTENT_STATUS_WRITTEN)) {
-		ext4_warning(inode->i_sb, "Inserting extent [%u/%u] as "
-				" delayed and written which can potentially "
-				" cause data loss.", lblk, len);
-		WARN_ON(1);
-	}
+	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
 
 	newes.es_lblk = lblk;
 	newes.es_len = len;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fd5a27db62c0..752fc0555dc0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -558,12 +558,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 
 	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-	if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
-	    !(status & EXTENT_STATUS_WRITTEN) &&
-	    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
-			       map->m_lblk + map->m_len - 1))
-		status |= EXTENT_STATUS_DELAYED;
-
 	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 			      map->m_pblk, status);
 
@@ -682,11 +676,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
-		    !(status & EXTENT_STATUS_WRITTEN) &&
-		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
-				       map->m_lblk + map->m_len - 1))
-			status |= EXTENT_STATUS_DELAYED;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
 	}
-- 
2.39.2


