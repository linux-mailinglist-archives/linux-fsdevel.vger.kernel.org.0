Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD779115F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352353AbjIDGaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbjIDGar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:30:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCFD109;
        Sun,  3 Sep 2023 23:30:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfJfj2mMbz4f3k6P;
        Mon,  4 Sep 2023 14:30:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDnFDGLefVkRQ7ICA--.14846S3;
        Mon, 04 Sep 2023 14:30:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 1/3] fuse: move FR_WAITING set from fuse_request_queue_background to fuse_simple_background
Date:   Mon,  4 Sep 2023 22:30:16 +0800
Message-Id: <20230904143018.5709-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230904143018.5709-1-shikemeng@huaweicloud.com>
References: <20230904143018.5709-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnFDGLefVkRQ7ICA--.14846S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UGw1UJr4rXry5CFW7Jwb_yoW8Cry5pr
        48G3WYyFZrXF4UGr90g3yxZw1ag3yIyr4fCryfGasIyr45Jwsa9rn5GFy5X3WxAr4xZr4a
        g3ZxW3y3Z34ava7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRPrc3UUUUU
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current way to set FR_WAITING in fuse_simple_background:
fuse_simple_background
	if (args->force)
		fuse_request_alloc
		/* need to increase num_waiting before request is queued */
	else
		fuse_get_req
			atomic_inc(&fc->num_waiting);
			__set_bit(FR_WAITING, &req->flags);

	fuse_request_queue_background
		if (!test_bit(FR_WAITING, &req->flags)
			__set_bit(FR_WAITING, &req->flags);
			atomic_inc(&fc->num_waiting);

We only need to increase num_waiting for force allocated reqeust in
fuse_request_queue_background. Simply increase num_waiting in force block
to remove unnecessary test_bit(FR_WAITING).
This patch also makes it more intuitive to remove FR_WATING usage in next
commit.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fuse/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..59e1357d4880 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -528,10 +528,6 @@ static bool fuse_request_queue_background(struct fuse_req *req)
 	bool queued = false;
 
 	WARN_ON(!test_bit(FR_BACKGROUND, &req->flags));
-	if (!test_bit(FR_WAITING, &req->flags)) {
-		__set_bit(FR_WAITING, &req->flags);
-		atomic_inc(&fc->num_waiting);
-	}
 	__set_bit(FR_ISREPLY, &req->flags);
 	spin_lock(&fc->bg_lock);
 	if (likely(fc->connected)) {
@@ -553,10 +549,14 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_req *req;
 
 	if (args->force) {
+		struct fuse_conn *fc = fm->fc;
+
 		WARN_ON(!args->nocreds);
 		req = fuse_request_alloc(fm, gfp_flags);
 		if (!req)
 			return -ENOMEM;
+		atomic_inc(&fc->num_waiting);
+		__set_bit(FR_WAITING, &req->flags);
 		__set_bit(FR_BACKGROUND, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
-- 
2.30.0

