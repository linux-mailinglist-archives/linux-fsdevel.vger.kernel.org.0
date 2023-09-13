Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA179DD7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 03:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjIMBXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 21:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjIMBXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:23:23 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD5A10FE;
        Tue, 12 Sep 2023 18:23:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RljPv0X3Wz4f3m6n;
        Wed, 13 Sep 2023 09:23:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgCXpwwDDwFlv7ZLAQ--.25966S3;
        Wed, 13 Sep 2023 09:23:16 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] fuse: move FR_WAITING set from fuse_request_queue_background to fuse_simple_background
Date:   Wed, 13 Sep 2023 17:22:45 +0800
Message-Id: <20230913092246.22747-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230913092246.22747-1-shikemeng@huaweicloud.com>
References: <20230913092246.22747-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCXpwwDDwFlv7ZLAQ--.25966S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UGw1UJr4rXry5CFW7Jwb_yoW8Cryrpr
        48G3WYyFZrXF4UGr90g3yxZw1ag3yIyrs3CryfGasIyr45Jwsa9rn5GFy3X3WxAr4xZr4a
        q3ZxW3y3Z34ava7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07js2-5UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
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
This patch also makes it more intuitive to remove FR_WAITING usage in next
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

