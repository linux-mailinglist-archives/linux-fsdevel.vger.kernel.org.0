Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E98B8130B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 09:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfHEHVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 03:21:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbfHEHVj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:21:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B85D13046AED64EFE633;
        Mon,  5 Aug 2019 15:21:36 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 15:21:27 +0800
From:   Lihong Kou <koulihong@huawei.com>
To:     <yuchao0@huawei.com>, <jaegeuk@kernel.org>
CC:     <fangwei1@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <koulihong@huawei.com>
Subject: [f2fs-dev] [PATCH] f2fs: remove duplicate code in f2fs_file_write_iter
Date:   Mon, 5 Aug 2019 15:27:24 +0800
Message-ID: <1564990044-107117-1-git-send-email-koulihong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We will do the same check in generic_write_checks.
if (iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)
        return -EINVAL;
just remove the same check in f2fs_file_write_iter.

Signed-off-by: Lihong Kou <koulihong@huawei.com>
---
 fs/f2fs/file.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3e58a6f..50a87cf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3134,11 +3134,6 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
-- 
2.7.4

