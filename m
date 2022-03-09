Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B94D2C66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 10:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiCIJpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 04:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCIJo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:44:59 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04991151D34;
        Wed,  9 Mar 2022 01:44:01 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 85so1253110qkm.9;
        Wed, 09 Mar 2022 01:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJcsiCvuU0LEpDBG3YLrgQ6iZjq8OgfZ7I3Jt2iwnik=;
        b=nTpovFHqrUcu1YKcuKeMad3NEJIkWsFY4E1ZGaZ//DzOuXb+Hck7Et4RZVgZVhAs0X
         6Y08wfQM6QYvyHqwC25iJp+tF+xc9F63LDowZuGLP5NYb00ZzhJMqj25x/XLhKknYwDj
         S9BFdw3xPSpBUmcFSA2TcnRrbsDs3wzleTmwDfKND8MGrZncr/Dk28KsaK8KROuiKnaO
         IotL5w88jCfOngXO3t1WKpldiiTqwjKj7JGhSOV1rLE7aJyYoQJ+O2e79NlBjHVShfeF
         TTcTAnduzWNdBtxEk8sA4bv75Eb/gXxWGtkD0c0x3hxSbHl1wsxGlO0s5er2psdjNNwm
         DuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJcsiCvuU0LEpDBG3YLrgQ6iZjq8OgfZ7I3Jt2iwnik=;
        b=4xEiJ+/axTysFsCMALrs+/GEfmzRdHP6z8jrQVe0DPmM1Cl56nRnVIgBmu6WeC94VH
         j43lD7grbepoav8QY/I4JXE6jmXJoslzM5rU70AbceddYgrON04M1FbzJeOyM+dgs6Gp
         p15yq7DuLwWGimJeJI+aqEinXH370FI2JanGDoKiTYPtVtSOAWdFz5NeRwPKyXtL4BX+
         wTcgVjTXKiCiRVnKOsCLEoHR4XPnSwbf942gio3Em4iMl1uVgLqUUYAGP48GUh1JmqTm
         z0GLUNDuFIgjcTeM7X2YKTAJlv4Vni2NZEcZ3H9rKwFZ2F+jwN92Rpt5fogbMrK0+G20
         zt5A==
X-Gm-Message-State: AOAM531TkNsZM5R9z2kfXVAxejswYFSUALFMpNko5BGK3/jUJZRuLmxq
        6cezB2tXJPTr6yYISD5Wxs4=
X-Google-Smtp-Source: ABdhPJxSzeWLjN6BZeTA6KKMjZewlgWBNGOkEKArl+PeihcsKPe75rN9ajFH+ag+rHi5hO7Jyoi0LA==
X-Received: by 2002:a05:620a:14ab:b0:60d:d5cf:627a with SMTP id x11-20020a05620a14ab00b0060dd5cf627amr12731999qkj.103.1646819039769;
        Wed, 09 Mar 2022 01:43:59 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b002de4d014733sm974987qtf.13.2022.03.09.01.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:43:59 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, hannes@cmpxchg.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH] block/psi: remove PSI annotations from submit_bio
Date:   Wed,  9 Mar 2022 09:43:24 +0000
Message-Id: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
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

psi tracks the time spent submitting the IO of refaulting pages[1].
But after we tracks refault stalls from swap_readpage[2][3], there
is no need to do so anymore. Since swap_readpage already includes
IO submitting time.

[1] commit b8e24a9300b0 ("block: annotate refault stalls from IO submission")
[2] commit 937790699be9 ("mm/page_io.c: annotate refault stalls from swap_readpage")
[3] commit 2b413a1a728f ("mm: page_io: fix psi memory pressure error on cold swapins")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 block/bio.c               |  8 --------
 block/blk-core.c          | 17 -----------------
 fs/direct-io.c            |  2 --
 include/linux/blk_types.h |  1 -
 4 files changed, 28 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3c57b3ba727d..efbbeed348e3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1034,9 +1034,6 @@ void __bio_add_page(struct bio *bio, struct page *page,
 
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
-
-	if (!bio_flagged(bio, BIO_WORKINGSET) && unlikely(PageWorkingset(page)))
-		bio_set_flag(bio, BIO_WORKINGSET);
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
@@ -1252,9 +1249,6 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * fit into the bio, or are requested in @iter, whatever is smaller. If
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
- *
- * It's intended for direct IO, so doesn't do PSI tracking, the caller is
- * responsible for setting BIO_WORKINGSET if necessary.
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1273,8 +1267,6 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
-	/* don't account direct I/O as memory stall */
-	bio_clear_flag(bio, BIO_WORKINGSET);
 	return bio->bi_vcnt ? 0 : ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
diff --git a/block/blk-core.c b/block/blk-core.c
index ddac62aebc55..faf7d950a4d5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -37,7 +37,6 @@
 #include <linux/t10-pi.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
-#include <linux/psi.h>
 #include <linux/part_stat.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
@@ -911,22 +910,6 @@ void submit_bio(struct bio *bio)
 		}
 	}
 
-	/*
-	 * If we're reading data that is part of the userspace workingset, count
-	 * submission time as memory stall.  When the device is congested, or
-	 * the submitting cgroup IO-throttled, submission can be a significant
-	 * part of overall IO time.
-	 */
-	if (unlikely(bio_op(bio) == REQ_OP_READ &&
-	    bio_flagged(bio, BIO_WORKINGSET))) {
-		unsigned long pflags;
-
-		psi_memstall_enter(&pflags);
-		submit_bio_noacct(bio);
-		psi_memstall_leave(&pflags);
-		return;
-	}
-
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index aef06e607b40..5cac8c8869c5 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -419,8 +419,6 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 	unsigned long flags;
 
 	bio->bi_private = dio;
-	/* don't account direct I/O as memory stall */
-	bio_clear_flag(bio, BIO_WORKINGSET);
 
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	dio->refcount++;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0c7a9a1f06c8..ab50c59b02ce 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -314,7 +314,6 @@ enum {
 	BIO_NO_PAGE_REF,	/* don't put release vec pages */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
-	BIO_WORKINGSET,		/* contains userspace workingset pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
-- 
2.25.1

