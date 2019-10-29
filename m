Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8FE89B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 14:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbfJ2NjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 09:39:23 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43645 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388274AbfJ2NjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:39:23 -0400
Received: from linux.loongson.cn (unknown [10.20.41.27])
        by mail (Coremail) with SMTP id QMiowPDxz1wIQbhd0YEZAA--.70S2;
        Tue, 29 Oct 2019 21:39:20 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsnotify: Use NULL instead of 0 for pointer
Date:   Tue, 29 Oct 2019 21:39:02 +0800
Message-Id: <1572356342-24776-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: QMiowPDxz1wIQbhd0YEZAA--.70S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWfKF17Jr47XFWfKFW5Awb_yoWftFbE9r
        1qva1kWryrursYyr43CrWYyF97ur1kGr18CFsFqr1jka15trZxJFyvvrZ3Zw48uFWYkw4r
        K3sFk347KF1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbakYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6xIIjxv20xvE14v26r1Y6r
        17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAK
        I48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
        1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j
        6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
        IYCTnIWIevJa73UjIFyTuYvjxU4KsjUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following sparse warning:

fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer

Fixes: be77196b809c ("fs, notify: add procfs fdinfo helper")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/notify/fdinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 1e2bfd2..cd2846e 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -50,7 +50,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	f.handle.handle_bytes = sizeof(f.pad);
 	size = f.handle.handle_bytes >> 2;
 
-	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
+	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle,
+				       &size, NULL);
 	if ((ret == FILEID_INVALID) || (ret < 0)) {
 		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
 		return;
-- 
2.1.0


