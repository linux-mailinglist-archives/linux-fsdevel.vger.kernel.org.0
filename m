Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448379DD80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 03:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbjIMBXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 21:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbjIMBXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:23:23 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05F910F6;
        Tue, 12 Sep 2023 18:23:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RljPw2FMhz4f3kKk;
        Wed, 13 Sep 2023 09:23:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgCXpwwDDwFlv7ZLAQ--.25966S4;
        Wed, 13 Sep 2023 09:23:16 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] fuse: remove usage of FR_WATING flag
Date:   Wed, 13 Sep 2023 17:22:46 +0800
Message-Id: <20230913092246.22747-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230913092246.22747-1-shikemeng@huaweicloud.com>
References: <20230913092246.22747-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCXpwwDDwFlv7ZLAQ--.25966S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7XryDJrWDAw4xKw47twb_yoW8Kw1kpF
        WxCayjyFsrXr4UW34fW34xZw1aq3yfAF93KryrGasIvF4DtrZIkrn5KFyUWF17Zr4xXrsI
        g390grs7Zw1Yq37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsmiiDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Each allocated request from fuse_request_alloc counts to num_waiting
before request is freed.
Simply drop num_waiting without FR_WAITING flag check in fuse_put_request
to remove unneeded usage of FR_WAITING flag.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fuse/dev.c    | 9 +--------
 fs/fuse/fuse_i.h | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 59e1357d4880..4f49b1946635 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -139,7 +139,6 @@ static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
 	req->in.h.gid = from_kgid(fc->user_ns, current_fsgid());
 	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
 
-	__set_bit(FR_WAITING, &req->flags);
 	if (for_background)
 		__set_bit(FR_BACKGROUND, &req->flags);
 
@@ -171,11 +170,7 @@ static void fuse_put_request(struct fuse_req *req)
 			spin_unlock(&fc->bg_lock);
 		}
 
-		if (test_bit(FR_WAITING, &req->flags)) {
-			__clear_bit(FR_WAITING, &req->flags);
-			fuse_drop_waiting(fc);
-		}
-
+		fuse_drop_waiting(fc);
 		fuse_request_free(req);
 	}
 }
@@ -495,7 +490,6 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 		if (!args->nocreds)
 			fuse_force_creds(req);
 
-		__set_bit(FR_WAITING, &req->flags);
 		__set_bit(FR_FORCE, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
@@ -556,7 +550,6 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 		if (!req)
 			return -ENOMEM;
 		atomic_inc(&fc->num_waiting);
-		__set_bit(FR_WAITING, &req->flags);
 		__set_bit(FR_BACKGROUND, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bf0b85d0b95c..a78764cef313 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -312,7 +312,6 @@ struct fuse_io_priv {
  * FR_ISREPLY:		set if the request has reply
  * FR_FORCE:		force sending of the request even if interrupted
  * FR_BACKGROUND:	request is sent in the background
- * FR_WAITING:		request is counted as "waiting"
  * FR_ABORTED:		the request was aborted
  * FR_INTERRUPTED:	the request has been interrupted
  * FR_LOCKED:		data is being copied to/from the request
@@ -326,7 +325,6 @@ enum fuse_req_flag {
 	FR_ISREPLY,
 	FR_FORCE,
 	FR_BACKGROUND,
-	FR_WAITING,
 	FR_ABORTED,
 	FR_INTERRUPTED,
 	FR_LOCKED,
-- 
2.30.0

