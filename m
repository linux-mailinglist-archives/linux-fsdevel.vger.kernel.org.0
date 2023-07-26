Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BC762933
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 05:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGZDWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 23:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGZDWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:22:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8552697;
        Tue, 25 Jul 2023 20:21:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9fMR097cz4f3jMH;
        Wed, 26 Jul 2023 11:21:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgCHLaFPkcBkmKBNOw--.42869S4;
        Wed, 26 Jul 2023 11:21:55 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] epoll: simplify ep_alloc()
Date:   Wed, 26 Jul 2023 11:21:35 +0800
Message-Id: <20230726032135.933-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHLaFPkcBkmKBNOw--.42869S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4UAF43Kr4xKFWUKFWfXwb_yoWkZrX_AF
        W09a4DGrW8JF4fJa4UAw1YvFWfKa1FvFW8Zr40kFZ7Wa43Gr93Zayqvr43Zr17uFW3WFya
        vwn7C39Iq3Wj9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JrC_JFWl1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFCJmUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The get_current_user() does not fail, and moving it after kzalloc() can
simplify the code a bit.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/eventpoll.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4b1b3362f697b11..1d9a71a0c4c1678 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -975,15 +975,11 @@ void eventpoll_release_file(struct file *file)
 
 static int ep_alloc(struct eventpoll **pep)
 {
-	int error;
-	struct user_struct *user;
 	struct eventpoll *ep;
 
-	user = get_current_user();
-	error = -ENOMEM;
 	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
 	if (unlikely(!ep))
-		goto free_uid;
+		return -ENOMEM;
 
 	mutex_init(&ep->mtx);
 	rwlock_init(&ep->lock);
@@ -992,16 +988,12 @@ static int ep_alloc(struct eventpoll **pep)
 	INIT_LIST_HEAD(&ep->rdllist);
 	ep->rbr = RB_ROOT_CACHED;
 	ep->ovflist = EP_UNACTIVE_PTR;
-	ep->user = user;
+	ep->user = get_current_user();
 	refcount_set(&ep->refcount, 1);
 
 	*pep = ep;
 
 	return 0;
-
-free_uid:
-	free_uid(user);
-	return error;
 }
 
 /*
-- 
2.25.1

