Return-Path: <linux-fsdevel+bounces-53514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603AAEFA49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5FF3ABECD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B0277030;
	Tue,  1 Jul 2025 13:21:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285727466D;
	Tue,  1 Jul 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376064; cv=none; b=U4Cpq+MjTJ2dLuHqlzv7vel468+cbPfXIdLyrHBQuUNIQHaKBQ5A0UsJF5nOBrm+ZE4fNf+ghsRuB4UgZiFibmQAgkKubjLfwzOs/AeDUEaQdS+ZKmvTNMSgBjz90CEwOJdSyCly8BEauX0WEYP9p7R8pogdDkMxnTe3SMCt4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376064; c=relaxed/simple;
	bh=O/9yJgfVsUMKzk6FZTjdJTcxHULZ6m2zNoifI7cVn7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcWxTa0y7KvJDTCWB6GuvqNjay7W5iAUcWn7CW8fDQiNqIzHpxmwBH01CdrYE6JpvF5eq5Y7i3PoVQZ3rVQ3YgtPiYbqV2OsFKxEbHsZjyrp+DCNgLZO+scCjbUzsHdivqVoAQpR8nUzXZUCyN/cPrcjK7Rv3fq6RnlfTFSORCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bWkDs1wHZzYQvKS;
	Tue,  1 Jul 2025 21:21:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 246291A0E2D;
	Tue,  1 Jul 2025 21:21:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXeCWu4GNoXmJGAQ--.26904S10;
	Tue, 01 Jul 2025 21:20:59 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 06/10] ext4: enhance tracepoints during the folios writeback
Date: Tue,  1 Jul 2025 21:06:31 +0800
Message-ID: <20250701130635.4079595-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXeCWu4GNoXmJGAQ--.26904S10
X-Coremail-Antispam: 1UD129KBjvJXoWxuF17Aw4UJw4DXFyDWrW8Crg_yoWrWw48pF
	WqkF95Wrs7Zw4Y93WfZa1UZr4FvFykur47tr13WFyDJw1xAr1kKa17KryqyFyjyrZ2yryI
	qF4qk3sxC3WxWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After mpage_map_and_submit_extent() supports restarting handle if
credits are insufficient during allocating blocks, it is more likely to
exit the current mapping iteration and continue to process the current
processing partially mapped folio again. The existing tracepoints are
not sufficient to track this situation, so enhance the tracepoints to
track the writeback position and the return value before and after
submitting the folios.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c             |  5 ++++-
 include/trace/events/ext4.h | 42 ++++++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index efe778aaf74b..79389874d35f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2934,7 +2934,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		}
 		mpd->do_map = 1;
 
-		trace_ext4_da_write_pages(inode, mpd->start_pos, wbc);
+		trace_ext4_da_write_folios_start(inode, mpd->start_pos,
+				mpd->next_pos, wbc);
 		ret = mpage_prepare_extent_to_map(mpd);
 		if (!ret && mpd->map.m_len)
 			ret = mpage_map_and_submit_extent(handle, mpd,
@@ -2972,6 +2973,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		} else
 			ext4_put_io_end(mpd->io_submit.io_end);
 		mpd->io_submit.io_end = NULL;
+		trace_ext4_da_write_folios_end(inode, mpd->start_pos,
+				mpd->next_pos, wbc, ret);
 
 		if (ret == -ENOSPC && sbi->s_journal) {
 			/*
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 62d52997b5c6..845451077c41 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -482,16 +482,17 @@ TRACE_EVENT(ext4_writepages,
 		  (unsigned long) __entry->writeback_index)
 );
 
-TRACE_EVENT(ext4_da_write_pages,
-	TP_PROTO(struct inode *inode, loff_t start_pos,
+TRACE_EVENT(ext4_da_write_folios_start,
+	TP_PROTO(struct inode *inode, loff_t start_pos, loff_t next_pos,
 		 struct writeback_control *wbc),
 
-	TP_ARGS(inode, start_pos, wbc),
+	TP_ARGS(inode, start_pos, next_pos, wbc),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(       loff_t,	start_pos		)
+		__field(       loff_t,	next_pos		)
 		__field(	 long,	nr_to_write		)
 		__field(	  int,	sync_mode		)
 	),
@@ -500,16 +501,47 @@ TRACE_EVENT(ext4_da_write_pages,
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->start_pos	= start_pos;
+		__entry->next_pos	= next_pos;
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->sync_mode	= wbc->sync_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu start_pos 0x%llx nr_to_write %ld sync_mode %d",
+	TP_printk("dev %d,%d ino %lu start_pos 0x%llx next_pos 0x%llx nr_to_write %ld sync_mode %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->start_pos,
+		  (unsigned long) __entry->ino, __entry->start_pos, __entry->next_pos,
 		  __entry->nr_to_write, __entry->sync_mode)
 );
 
+TRACE_EVENT(ext4_da_write_folios_end,
+	TP_PROTO(struct inode *inode, loff_t start_pos, loff_t next_pos,
+		 struct writeback_control *wbc, int ret),
+
+	TP_ARGS(inode, start_pos, next_pos, wbc, ret),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	ino_t,	ino			)
+		__field(       loff_t,	start_pos		)
+		__field(       loff_t,	next_pos		)
+		__field(	 long,	nr_to_write		)
+		__field(	  int,	ret			)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->start_pos	= start_pos;
+		__entry->next_pos	= next_pos;
+		__entry->nr_to_write	= wbc->nr_to_write;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("dev %d,%d ino %lu start_pos 0x%llx next_pos 0x%llx nr_to_write %ld ret %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino, __entry->start_pos, __entry->next_pos,
+		  __entry->nr_to_write, __entry->ret)
+);
+
 TRACE_EVENT(ext4_da_write_pages_extent,
 	TP_PROTO(struct inode *inode, struct ext4_map_blocks *map),
 
-- 
2.46.1


