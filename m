Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25B33D3E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 13:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhCPMbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 08:31:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13545 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhCPMau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:30:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0CHp4LkLzNndK;
        Tue, 16 Mar 2021 20:28:22 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 20:30:35 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <damien.lemoal@wdc.com>, <naohiro.aota@wdc.com>, <jth@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] zonefs: fix to update .i_wr_refcnt correctly in zonefs_open_zone()
Date:   Tue, 16 Mar 2021 20:30:26 +0800
Message-ID: <20210316123026.115473-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In zonefs_open_zone(), if opened zone count is larger than
.s_max_open_zones threshold, we missed to recover .i_wr_refcnt,
fix this.

Fixes: b5c00e975779 ("zonefs: open/close zone on file open/close")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/zonefs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 0fe76f376dee..be6b99f7de74 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -966,8 +966,7 @@ static int zonefs_open_zone(struct inode *inode)
 
 	mutex_lock(&zi->i_truncate_mutex);
 
-	zi->i_wr_refcnt++;
-	if (zi->i_wr_refcnt == 1) {
+	if (zi->i_wr_refcnt == 0) {
 
 		if (atomic_inc_return(&sbi->s_open_zones) > sbi->s_max_open_zones) {
 			atomic_dec(&sbi->s_open_zones);
@@ -978,7 +977,6 @@ static int zonefs_open_zone(struct inode *inode)
 		if (i_size_read(inode) < zi->i_max_size) {
 			ret = zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
 			if (ret) {
-				zi->i_wr_refcnt--;
 				atomic_dec(&sbi->s_open_zones);
 				goto unlock;
 			}
@@ -986,6 +984,8 @@ static int zonefs_open_zone(struct inode *inode)
 		}
 	}
 
+	zi->i_wr_refcnt++;
+
 unlock:
 	mutex_unlock(&zi->i_truncate_mutex);
 
-- 
2.29.2

