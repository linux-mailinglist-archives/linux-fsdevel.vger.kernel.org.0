Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F112344E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfLQSEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 13:04:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:55584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfLQSEc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:04:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0BFBAAFE0;
        Tue, 17 Dec 2019 18:04:31 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] bdev: reset first_open when looping in __blkget_dev
Date:   Tue, 17 Dec 2019 19:04:28 +0100
Message-Id: <20191217180428.8868-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is not clear that no other thread cannot open the block device when
__blkget_dev drops it and loop to restart label. Reset first_open to
false when looping.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 fs/block_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..17e1231d5246 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1560,7 +1560,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	int ret;
 	int partno;
 	int perm = 0;
-	bool first_open = false;
+	bool first_open;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1580,6 +1580,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
  restart:
 
 	ret = -ENXIO;
+	first_open = false;
 	disk = bdev_get_gendisk(bdev, &partno);
 	if (!disk)
 		goto out;
-- 
2.23.0

