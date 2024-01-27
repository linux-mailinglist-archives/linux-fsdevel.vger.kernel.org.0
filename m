Return-Path: <linux-fsdevel+bounces-9161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733783E94F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D311F29796
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0E0208A1;
	Sat, 27 Jan 2024 02:02:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA614AAD;
	Sat, 27 Jan 2024 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320969; cv=none; b=mHX0Qz1I2joFxI28DKLYmZwUisNmM8ODDy61kpEWZ9JA8RpSxN/1GemORveL6Nb4tlJa3xk8Cy7LFG6D/13PxPQKN++npCdCmJewQJw7KTPLEQAEC4SJPeioQ69aDnt2cw5917MuMwvei4Cghhftiwi9l+aFRVWOdmJzOSF+rSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320969; c=relaxed/simple;
	bh=5htVoT5yAcADrznHX69BozU0tvv0yd+Udq8Ttbk3Z7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWvatbb3oRejKfT5+97sNEzEenXCwhGaNfSZE2wE1C0OWIsWwiylkv5gfWyc4rhnBP7OazkqdrlkSHc0z7bkXssCIfdW+CpHvThokiTwc6SXpQJHGYnfxgCGtjahjGDvA6cd0BswpzIfhtm5lDQTxEdRBLOVbG6W7MQC64q+37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TMHrc4sr7z4f3lwf;
	Sat, 27 Jan 2024 10:02:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A87281A0172;
	Sat, 27 Jan 2024 10:02:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S12;
	Sat, 27 Jan 2024 10:02:44 +0800 (CST)
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
Subject: [RFC PATCH v3 08/26] iomap: add pos and dirty_len into trace_iomap_writepage_map
Date: Sat, 27 Jan 2024 09:58:07 +0800
Message-Id: <20240127015825.1608160-9-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S12
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4xZF18Cw4Utw48CrWUXFb_yoW5AryfpF
	9FyFZ8Cr4kJr429w1fZ34rArs0vF95ur4Utr13u3y5Zw4vyr17GF4vkFWjvF95ArnIyr13
	XF4F934kG3WUCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since commit "iomap: map multiple blocks at a time", we could map
multi-blocks once a time, and the dirty_len indicates the expected map
length, map_len won't large than it. The pos and dirty_len means the
dirty range that should be mapped to write, add them into
trace_iomap_writepage_map() could be more useful for debug.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c |  2 +-
 fs/iomap/trace.h       | 43 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2ae936e5af74..9a9f1bfe80b4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1806,7 +1806,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		error = wpc->ops->map_blocks(wpc, inode, pos, dirty_len);
 		if (error)
 			break;
-		trace_iomap_writepage_map(inode, &wpc->iomap);
+		trace_iomap_writepage_map(inode, pos, dirty_len, &wpc->iomap);
 
 		map_len = min_t(u64, dirty_len,
 			wpc->iomap.offset + wpc->iomap.length - pos);
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index c16fd55f5595..3ef694f9489f 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -154,7 +154,48 @@ DEFINE_EVENT(iomap_class, name,	\
 	TP_ARGS(inode, iomap))
 DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
 DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
-DEFINE_IOMAP_EVENT(iomap_writepage_map);
+
+TRACE_EVENT(iomap_writepage_map,
+	TP_PROTO(struct inode *inode, u64 pos, unsigned int dirty_len,
+		 struct iomap *iomap),
+	TP_ARGS(inode, pos, dirty_len, iomap),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, ino)
+		__field(u64, pos)
+		__field(u64, dirty_len)
+		__field(u64, addr)
+		__field(loff_t, offset)
+		__field(u64, length)
+		__field(u16, type)
+		__field(u16, flags)
+		__field(dev_t, bdev)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pos = pos;
+		__entry->dirty_len = dirty_len;
+		__entry->addr = iomap->addr;
+		__entry->offset = iomap->offset;
+		__entry->length = iomap->length;
+		__entry->type = iomap->type;
+		__entry->flags = iomap->flags;
+		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
+	),
+	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d pos 0x%llx dirty len 0x%llx "
+		  "addr 0x%llx offset 0x%llx length 0x%llx type %s flags %s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
+		  __entry->pos,
+		  __entry->dirty_len,
+		  __entry->addr,
+		  __entry->offset,
+		  __entry->length,
+		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
+);
 
 TRACE_EVENT(iomap_iter,
 	TP_PROTO(struct iomap_iter *iter, const void *ops,
-- 
2.39.2


