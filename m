Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819D781307
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 09:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHEHUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 03:20:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbfHEHUf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:20:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9479E04882FA6FD9799;
        Mon,  5 Aug 2019 15:20:31 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 15:20:25 +0800
From:   Lihong Kou <koulihong@huawei.com>
To:     <yuchao0@huawei.com>, <jaegeuk@kernel.org>
CC:     <fangwei1@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <koulihong@huawei.com>
Subject: [f2fs-dev] [PATCH] fsck.f2fs: fix the bug in reserve_new_block
Date:   Mon, 5 Aug 2019 15:26:21 +0800
Message-ID: <1564989981-104324-1-git-send-email-koulihong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

if we new node block in fsck flow, we need to update
the valid_node_cnt at the same time.

Signed-off-by: Lihong Kou <koulihong@huawei.com>
---
 fsck/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fsck/segment.c b/fsck/segment.c
index 98c836e..c16fb3a 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -51,8 +51,11 @@ void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 
 	if (old_blkaddr == NULL_ADDR) {
 		sbi->total_valid_block_count++;
-		if (c.func == FSCK)
+		if (c.func == FSCK) {
 			fsck->chk.valid_blk_cnt++;
+			if (IS_NODESEG(type))
+				fsck->chk.valid_node_cnt++;
+		}
 	}
 	se->dirty = 1;
 
-- 
2.7.4

