Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42652462E24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 09:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbhK3IFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 03:05:40 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56557 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239367AbhK3IFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:05:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UyrahdV_1638259339;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UyrahdV_1638259339)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Nov 2021 16:02:19 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] fs: remove duplicate permission checks in do_sendfile()
Date:   Tue, 30 Nov 2021 16:02:18 +0800
Message-Id: <20211130080218.22517-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The permission check for out.file is mainly performed in the function
rw_verify_area(), and this check is called twice in the function
do_splice_direct() and before calling do_splice_direct(). This is a
redundant check and it is necessary to remove.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 fs/read_write.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0074afa7ecb3..bc7c3fcc3400 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1238,9 +1238,6 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 #endif
 	opipe = get_pipe_info(out.file, true);
 	if (!opipe) {
-		retval = rw_verify_area(WRITE, out.file, &out_pos, count);
-		if (retval < 0)
-			goto fput_out;
 		file_start_write(out.file);
 		retval = do_splice_direct(in.file, &pos, out.file, &out_pos,
 					  count, fl);
-- 
2.32.0

