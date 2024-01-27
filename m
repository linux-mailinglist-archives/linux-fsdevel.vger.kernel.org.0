Return-Path: <linux-fsdevel+bounces-9174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E25283E97A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10951C23C36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B32E62A;
	Sat, 27 Jan 2024 02:02:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8522C1AA;
	Sat, 27 Jan 2024 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320978; cv=none; b=A8Do/fywSXoxGbVeOmJRu0Czi+yli8e0variyQfK2SwNKAq6eg3qtepVUin4oLfOtEysYMpGwvGsO0IFel0h1ickGuZ2FOXdMw7zxIjjA+juYry3VOndbgAvlvlr1iTJqzLX0MM0oMtixhs93bagaGeWfse88KixQ2OD6YWU7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320978; c=relaxed/simple;
	bh=qnozGopNA5hG8ncuNOESDVQDe7q5XhLZfrk9mEKTilg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fntXBMErxhnnhaKOg2qahxUan5wIIyla5Pl5C6ohCslwyD8a8OX+EWmdy9CI2LWvtVQQeSNiNmctZIiP4P4rdBpJW5dHzXNOYvb5hv1HIULtQM3Y+iyQqmJgj6AX0ujU26SvL1bP5GGWMI6gQOa+cw6b2X4l83ex1OyXI06SVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMHrl4HqXz4f3lgL;
	Sat, 27 Jan 2024 10:02:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ED5C21A017A;
	Sat, 27 Jan 2024 10:02:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S26;
	Sat, 27 Jan 2024 10:02:53 +0800 (CST)
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
Subject: [RFC PATCH v3 22/26] ext4: writeback partial blocks before zero range
Date: Sat, 27 Jan 2024 09:58:21 +0800
Message-Id: <20240127015825.1608160-23-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S26
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5Aw4UCw1kWw45Jr1fZwb_yoWktFX_Za
	4rJrn5JrWftrn7Was7AFy3ZrZ2yw4vkr1xWFy0vr98ZFy2gws2kwnYyr1xurZ8WF429ry3
	Cr4qqF4xWFy7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_Gc
	Wl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoxhL
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

If we zero partial blocks, iomap_zero_iter() will skip zeroing out if
the srcmap is IOMAP_UNWRITTEN, it works fine in xfs because this type
means the block is pure unwritten, doesn't contain any delayed data,
but in ext4, IOMAP_UNWRITTEN may contain delayed data. For now we cannot
simply change the meaning of this flag in ext4, so just writeback
partial blocks from the beginning, make sure it becomes IOMAP_MAPPED
before zeroing out.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 46805b8e7bdc..cb80c57ccc3d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4616,6 +4616,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		if (ret)
 			goto out_mutex;
 
+		ret = filemap_write_and_wait_range(mapping,
+				round_down(offset, 1 << blkbits), offset);
+		if (ret)
+			goto out_mutex;
+
+		ret = filemap_write_and_wait_range(mapping, offset + len,
+				round_up((offset + len), 1 << blkbits));
+		if (ret)
+			goto out_mutex;
 	}
 
 	/* Zero range excluding the unaligned edges */
-- 
2.39.2


