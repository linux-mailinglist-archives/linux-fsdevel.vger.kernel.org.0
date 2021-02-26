Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E904D3260C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 11:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhBZKAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 05:00:22 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:43662 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230402AbhBZJ67 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:58:59 -0500
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-05 (Coremail) with SMTP id zQCowAC3mBUqxDhgcvK9AA--.22811S2;
        Fri, 26 Feb 2021 17:49:30 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.orgwq
Subject: [PATCH] fs: Use WARN(1,...)
Date:   Fri, 26 Feb 2021 09:49:27 +0000
Message-Id: <20210226094927.49322-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAC3mBUqxDhgcvK9AA--.22811S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wry8Gr1fZw4DJr45uw1fXrb_yoWxArX_GF
        15JF4rW3yFqFyvyr4av3yjvFs3uryrCF4F9F4SkrW3Was5Jw13C3sYyr17X3s3Xr1xWF1x
        urZ7Jry8CwsI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4fMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4UGYDUUUU
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkEA10TfAjsqwAAs1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use WARN(1,...) rather than printk followed by WARN_ON(1).

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2cdfdcd4276b..1dad7069dfe5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1637,7 +1637,7 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
 	if (dentry == _data && dentry->d_lockref.count == 1)
 		return D_WALK_CONTINUE;
 
-	WARN(1, KERN_ERR "BUG: Dentry %p{i=%lx,n=%pd} "
+	WARN(1, "BUG: Dentry %p{i=%lx,n=%pd} "
 			" still in use (%d) [unmount of %s %s]\n",
 		       dentry,
 		       dentry->d_inode ?
-- 
2.17.1

