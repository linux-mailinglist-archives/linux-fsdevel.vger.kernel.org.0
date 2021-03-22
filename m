Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E947234375D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 04:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVDZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 23:25:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14121 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCVDYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:24:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F3fvK66n1z19GVm;
        Mon, 22 Mar 2021 11:22:37 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Mon, 22 Mar 2021
 11:24:26 +0800
From:   Jack Qiu <jack.qiu@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <jack.qiu@huawei.com>
Subject: [PATCH] fs: direct-io: fix missing sdio->boundary
Date:   Mon, 22 Mar 2021 12:22:53 +0800
Message-ID: <20210322042253.38312-1-jack.qiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function dio_send_cur_page may clear sdio->boundary,
so save it to avoid boundary missing.

Fixes: b1058b981272 ("direct-io: submit bio after boundary buffer is
added to it")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
---
 fs/direct-io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 9fe721dc04e0..c9023f0bb20a 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -812,6 +812,7 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 		    struct buffer_head *map_bh)
 {
 	int ret = 0;
+	int boundary = sdio->boundary;	/* dio_send_cur_page may clear it */

 	if (dio->op == REQ_OP_WRITE) {
 		/*
@@ -850,10 +851,10 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 	sdio->cur_page_fs_offset = sdio->block_in_file << sdio->blkbits;
 out:
 	/*
-	 * If sdio->boundary then we want to schedule the IO now to
+	 * If boundary then we want to schedule the IO now to
 	 * avoid metadata seeks.
 	 */
-	if (sdio->boundary) {
+	if (boundary) {
 		ret = dio_send_cur_page(dio, sdio, map_bh);
 		if (sdio->bio)
 			dio_bio_submit(dio, sdio);
--
2.17.1

