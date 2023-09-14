Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E879FD6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 09:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjINHqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 03:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjINHqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:46:33 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE801BF6;
        Thu, 14 Sep 2023 00:46:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RmTsS72Ldz4f3jM3;
        Thu, 14 Sep 2023 15:46:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP3 (Coremail) with SMTP id _Ch0CgAngVBPugJlwkKgAQ--.8394S2;
        Thu, 14 Sep 2023 15:46:24 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: remove unneeded lock which protecting update of congestion_threshold
Date:   Thu, 14 Sep 2023 23:45:53 +0800
Message-Id: <20230914154553.71939-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAngVBPugJlwkKgAQ--.8394S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4kJF4UJF1xur43XrW8Zwb_yoWkGrc_WF
        s8XFn7C3W5trWF9asrZw1Yqryvg34jyF1Yv395JryYvFy5tr4avF9rurn5ury7ZF4jq3s8
        CrnYgFW3WwsF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
        AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
        JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
        Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0miiDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 670d21c6e17f6 ("fuse: remove reliance on bdi congestion") change how
congestion_threshold is used and lock in
fuse_conn_congestion_threshold_write is not needed anymore.
1. Access to supe_block is removed along with removing of bdi congestion.
Then down_read(&fc->killsb) which protecting access to super_block is no
needed.
2. Compare num_background and congestion_threshold without holding
bg_lock. Then there is no need to hold bg_lock to update
congestion_threshold.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fuse/control.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 247ef4f76761..c5d7bf80efed 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -174,11 +174,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 	if (!fc)
 		goto out;
 
-	down_read(&fc->killsb);
-	spin_lock(&fc->bg_lock);
 	fc->congestion_threshold = val;
-	spin_unlock(&fc->bg_lock);
-	up_read(&fc->killsb);
 	fuse_conn_put(fc);
 out:
 	return ret;
-- 
2.30.0

