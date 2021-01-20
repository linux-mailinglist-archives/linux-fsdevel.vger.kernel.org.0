Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D12FCD37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 10:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbhATJLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 04:11:38 -0500
Received: from m12-17.163.com ([220.181.12.17]:47198 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbhATJKR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=W5D55ps0RZmkxAN1oX
        R5Ip5Kp9uplo6b3uZqibjopRo=; b=RqDqIh2dXeTM7sorlBW2P8GUTs3d8tFPRL
        sly13kpFwUjEjxX/OQObaGf1KDtZ0pyCO/xQCX2mtC+kmeiJL7sFDo8US5qykYbH
        qGGI/AyqX9s/5oVKM4TU+d3nI87aYKyi3yNbkP2RIKVN5awhw40Z2FCJ39JCxwK6
        KdZpetkcM=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp13 (Coremail) with SMTP id EcCowABnvDgD7wdga9nqgg--.47424S4;
        Wed, 20 Jan 2021 16:51:18 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     David Sterba <dsterba@suse.com>, Fabian Frederick <fabf@skynet.be>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] fs/affs: release old buffer head on error path
Date:   Wed, 20 Jan 2021 00:51:13 -0800
Message-Id: <20210120085113.118984-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowABnvDgD7wdga9nqgg--.47424S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFy3KF4kuFWkAFW7XFyDGFg_yoW3Wrb_GF
        y0vFy0grWSqrySyw45ua43tryruF4FyrWxG393tFZrtrZ8KF98KF4qy3W3Ja4xuF4xWrW5
        urykAry3Zry2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU87Ef5UUUUU==
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQAcgclSIhrmpBQAAsa
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The reference count of the old buffer head should be decremented on path
that fails to get the new buffer head.

Fixes: 6b4657667ba0 ("fs/affs: add rename exchange")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/affs/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 41c5749f4db7..5400a876d73f 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -460,8 +460,10 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 		return -EIO;
 
 	bh_new = affs_bread(sb, d_inode(new_dentry)->i_ino);
-	if (!bh_new)
+	if (!bh_new) {
+		affs_brelse(bh_old);
 		return -EIO;
+	}
 
 	/* Remove old header from its parent directory. */
 	affs_lock_dir(old_dir);
-- 
2.17.1


