Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AA04DAACD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 07:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348607AbiCPGlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 02:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbiCPGlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:41:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABFD61A04;
        Tue, 15 Mar 2022 23:40:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx5so1370544pjb.3;
        Tue, 15 Mar 2022 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cebtj685AgXtmcsyJeJda1YE4pGqoQ5q0ZmxYFaVukE=;
        b=cId/x0+Y02qWXqJjrz+j5kvVvjxdnNmc0MoDuR/QRitRTBb8lAiXSPTt9b0VDMtSnb
         b8Ou6vIS2LpElxp8a6yllSdCrQNVa9igL0DUprJyPMDGxp9cQ/fVV/Khp28zOUU34on4
         YWwfdNgu8tLoroJKovuXnmu0jWgktPHRLbObM3zZ1qKW989xbevFIQkprSy8ZZTYJcKY
         vfEWFWIjbMPCdp17om0vTPiUNdVJt9Xftw0t5JrRWO2Rsm4KwgxSBl/7iTa3FDA8WrYw
         RVlQNOCI6HkeyLr94RPj7LYj/b0Rv+7aSTQeGA4sSocOD7RRJnYUaXjfXxi+UFq/CT+o
         bYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cebtj685AgXtmcsyJeJda1YE4pGqoQ5q0ZmxYFaVukE=;
        b=C1XOk8gHy9yJBBU+69K8vp/PAY36VlUMvULZKd6DsM+wVUA4u+YwE/2D10KJKvkrEG
         mUtvbtgR0u54iaSNHeP0Vu+r4UjBcu0atgrCxyRubLj1qLNFNIcPlS3B5Kj1/6G/g6+v
         BjyLOTcmxyrGp4y3Q9xb5dCIwP4C5Ffb39N5za15UDe3Vq7K2XX/VPqPGEHKdEu6MNA7
         jFiVX+EtwM5CL+aKAItEP6HQypwZhd07ADRzPiBHt754G8+fWipqiDr42c392zwyoNFt
         U7i1qZz5Gx6rXyIrE1dEMYhmu8kVALk+7kkrCbjJ6i3OlEwir3h0aviuYH17P8I+Nkyc
         wTSw==
X-Gm-Message-State: AOAM533tlmRJmNECjleYl5g1wdAHXEBepaUXrU9dyPtb/8h3l1YpXZGG
        rCrpfa15EyPDRuMUApeFYB8=
X-Google-Smtp-Source: ABdhPJxngJoehZOIScA2hpCHNvTTlrD0qoP4/ZWAWYTzYBjd/Me9vnzrVK/QMH+SLwT2jRid5JAoWw==
X-Received: by 2002:a17:903:2312:b0:153:1d6f:83a3 with SMTP id d18-20020a170903231200b001531d6f83a3mr30327619plh.157.1647412823092;
        Tue, 15 Mar 2022 23:40:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m79-20020a628c52000000b004f6f249d298sm1323485pfd.80.2022.03.15.23.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 23:40:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, hannes@cmpxchg.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH] block/psi: make PSI annotations of submit_bio only work for file pages
Date:   Wed, 16 Mar 2022 06:39:28 +0000
Message-Id: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

psi tracks the time spent on submitting the IO of refaulting file pages
and anonymous pages[1]. But after we tracks refaulting anonymous pages
in swap_readpage[2][3], there is no need to track refaulting anonymous
pages in submit_bio.

So this patch can reduce redundant calling of psi_memstall_enter. And
make it easier to track refaulting file pages and anonymous pages
separately.

[1] commit b8e24a9300b0 ("block: annotate refault stalls from IO submission")
[2] commit 937790699be9 ("mm/page_io.c: annotate refault stalls from swap_readpage")
[3] commit 2b413a1a728f ("mm: page_io: fix psi memory pressure error on cold swapins")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 block/bio.c               | 9 +++++----
 block/blk-core.c          | 2 +-
 fs/direct-io.c            | 2 +-
 include/linux/blk_types.h | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3c57b3ba727d..54b60be4f3b0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1035,8 +1035,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
 
-	if (!bio_flagged(bio, BIO_WORKINGSET) && unlikely(PageWorkingset(page)))
-		bio_set_flag(bio, BIO_WORKINGSET);
+	if (!bio_flagged(bio, BIO_WORKINGSET_FILE) &&
+	    unlikely(PageWorkingset(page)) && !PageSwapBacked(page))
+		bio_set_flag(bio, BIO_WORKINGSET_FILE);
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
@@ -1254,7 +1255,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * is returned only if 0 pages could be pinned.
  *
  * It's intended for direct IO, so doesn't do PSI tracking, the caller is
- * responsible for setting BIO_WORKINGSET if necessary.
+ * responsible for setting BIO_WORKINGSET_FILE if necessary.
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1274,7 +1275,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
 	/* don't account direct I/O as memory stall */
-	bio_clear_flag(bio, BIO_WORKINGSET);
+	bio_clear_flag(bio, BIO_WORKINGSET_FILE);
 	return bio->bi_vcnt ? 0 : ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
diff --git a/block/blk-core.c b/block/blk-core.c
index ddac62aebc55..9a955323734b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -918,7 +918,7 @@ void submit_bio(struct bio *bio)
 	 * part of overall IO time.
 	 */
 	if (unlikely(bio_op(bio) == REQ_OP_READ &&
-	    bio_flagged(bio, BIO_WORKINGSET))) {
+	    bio_flagged(bio, BIO_WORKINGSET_FILE))) {
 		unsigned long pflags;
 
 		psi_memstall_enter(&pflags);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index aef06e607b40..7cdec50fb27b 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -420,7 +420,7 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 
 	bio->bi_private = dio;
 	/* don't account direct I/O as memory stall */
-	bio_clear_flag(bio, BIO_WORKINGSET);
+	bio_clear_flag(bio, BIO_WORKINGSET_FILE);
 
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	dio->refcount++;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0c7a9a1f06c8..a1aaba4767e9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -314,7 +314,7 @@ enum {
 	BIO_NO_PAGE_REF,	/* don't put release vec pages */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
-	BIO_WORKINGSET,		/* contains userspace workingset pages */
+	BIO_WORKINGSET_FILE,	/* contains userspace workingset file pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
-- 
2.25.1

