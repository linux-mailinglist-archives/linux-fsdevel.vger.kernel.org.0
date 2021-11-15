Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379DD4502FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 12:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhKOLDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 06:03:52 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27207 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbhKOLDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:03:22 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ht5ll5Ws5z8vQv;
        Mon, 15 Nov 2021 18:58:43 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 19:00:23 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 19:00:23 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <wangfangpeng1@huawei.com>, <kechengsong@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: Fix truncate never updates m/ctime
Date:   Mon, 15 Nov 2021 19:00:18 +0800
Message-ID: <1636974018-31285-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: zhongjubin <zhongjubin@huawei.com>

Syscall truncate() never updates m/ctime even if the file size is
changed. However, this is incorrect according to man file:

  truncate (2):
  If  the  size  changed, then the st_ctime and st_mtime fields
  (respectively, time of last status change and time of last modification;
  see stat(2)) for the file are updated, and the set-user-ID and
  set-group-ID mode bits may be cleared.

Check file size before do_truncate() to fix this.

Signed-off-by: zhongjubin <zhongjubin@huawei.com>
---
 fs/open.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index f732fb94600c..02404b759c2e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -106,8 +106,11 @@ long vfs_truncate(const struct path *path, loff_t length)
 		goto put_write_and_out;
 
 	error = security_path_truncate(path);
-	if (!error)
-		error = do_truncate(mnt_userns, path->dentry, length, 0, NULL);
+	if (error)
+		goto put_write_and_out;
+
+	if (i_size_read(inode) != length)
+		error = do_truncate(mnt_userns, path->dentry, length, ATTR_MTIME | ATTR_CTIME, NULL);
 
 put_write_and_out:
 	put_write_access(inode);
-- 
2.12.3

