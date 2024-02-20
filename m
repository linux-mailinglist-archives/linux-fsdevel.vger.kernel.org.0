Return-Path: <linux-fsdevel+bounces-12153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E385BB57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4841C23D2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23B67C61;
	Tue, 20 Feb 2024 12:03:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED939664D1;
	Tue, 20 Feb 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430626; cv=none; b=m5uffgGZnUxavSyoMDQoogunnuB/P8PdcYDUiuaRwHWCuqlurauYD6u7fN3RN71AX3DM2rEJZ2JbcfrRih8V7NYCCU+5v0/OdY6Ul2/mEBkuIaTnxc78JxG3zt/Oc0gh/xYNBlbAqiCv5A2M6LPV2vKXoEucLA0wdq4/mgaJjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430626; c=relaxed/simple;
	bh=bqSHcYdUOo83IiYutNNf7E+8lC2T8puCRxlGGfLZAmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fOV9KU33aMI2RLiYhYXh5xjnlp71gTMYYtmC+84jfPC3Jz5GS67YY9/ErOCS2DZ3owf52xOaCWcKJ73/xJCmHJACsyWbKPoOMtriiMeReCK+lTUE//8kau8McAwah9/CYapBGcBgX/hdsZ29kgcGI7+sZ/DrtPU2oeP+lbjqNQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TfJ2x2S3zz4f3jqs;
	Tue, 20 Feb 2024 20:03:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7A3681A0D50;
	Tue, 20 Feb 2024 20:03:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4PldRlJQxlEg--.17612S4;
	Tue, 20 Feb 2024 20:03:40 +0800 (CST)
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
Subject: [PATCH -next] iomap: add pos and dirty_len into trace_iomap_writepage_map
Date: Tue, 20 Feb 2024 19:57:59 +0800
Message-Id: <20240220115759.3445025-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g4PldRlJQxlEg--.17612S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF43AFy3XF45WFWkWw17Wrg_yoW5Aw18pF
	9FyFZ8Cr4kJr429w1fZa4rArZ0vF95ur4Utr13u3y5Zr4vyr17KF4vkFWjvF95ArnIyF13
	XF4F9rykG3WUCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UZa9-UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since commit fd07e0aa23c4 ("iomap: map multiple blocks at a time"), we
could map multi-blocks once a time, and the dirty_len indicates the
expected map length, map_len won't large than it. The pos and dirty_len
means the dirty range that should be mapped to write, add them into
trace_iomap_writepage_map() could be more useful for debug.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c |  2 +-
 fs/iomap/trace.h       | 43 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2ad0e287c704..ae4e2026e59e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1776,7 +1776,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
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


