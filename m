Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6B79B279
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjIKUw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbjIKJus (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:50:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100D9E44
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:50:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf1876ef69so11144205ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425820; x=1695030620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89uHTpJcIxLZo7abv8HLEcqu89E7sxjnosGqTuxXflE=;
        b=hIHD0F8GO3yyHZO8YOa8ZRpyhOG3Y5eVMeDgFHBjo7pBPAxZApxCLrT5UfjzkMSXQ5
         s/W6x43VNIJ0S1XtyToZxbPNk3AvZTow69XR69vzMnbNQVT1Z/cVsiaQojftOQhDf4q0
         xpFLNBpNVqM+4+RvlBoprTYj9+HEOf7JoLBE2+UFSELQZl1h7BITxC/ivzCTgLl2xrir
         C9MrPqTuAZdxOzbWcVUc4Q3J3eGrtk8w2Vo+cuyMgJWl3W8Cqe9lOgZRO7SIebfrwU3U
         a6OKSeIp+Fnv7RxNG6FOK36XWBCDVDL3N5SjE3aEgte8K7B1CLoYUnG5krA4jKFT0FUS
         XZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425820; x=1695030620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89uHTpJcIxLZo7abv8HLEcqu89E7sxjnosGqTuxXflE=;
        b=WYScU8RA5sBWLKjPEdPRWw6zXfWgMVVSXE8upgYTHI6LVomNw1VL/tdJ27o5cYJHDc
         FDqVkFTYlVZGH6757xvI/H/tXEW+CfHlNWqab2G52LL2vxlM3j7/X2dfOpvqGsPQU+AV
         4MAZsNvzLh+XX7xn+J4Y+7zuQT/3aZfRmw+e21M9N+B9fzOEO/bnhXNy1DbNAeEOcpVu
         H5UTlfb9q0iZ8jgVpPOo5CADx8u0VWsekgzU5BFCaRlW0nbxHoQyTJhoqU1hj1usABU5
         Gj5jG+9uQjN8it5AtpeUdRhWwFA1NIUbsRk5s/JaMnwbMaUPvh1LxMYdVnyg5EiGnPu+
         fThg==
X-Gm-Message-State: AOJu0Yz8hXO9PwIwjVTtE5mAqorIQ+B2fV8tiFc0yezxLUJi2p7wBwva
        RMBcGveArb0gewtcUtQrBzl+GQ==
X-Google-Smtp-Source: AGHT+IEvj565qWnkofccC8hLFXJuQMn8WbyJUnUdIWHGtU6d/4Mn9yJ5j8IFsYM+kWtEVXfSyuocaw==
X-Received: by 2002:a17:902:e5c7:b0:1c1:fc5c:b34a with SMTP id u7-20020a170902e5c700b001c1fc5cb34amr10661836plf.3.1694425820591;
        Mon, 11 Sep 2023 02:50:20 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:50:20 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 34/45] xfs: dynamically allocate the xfs-buf shrinker
Date:   Mon, 11 Sep 2023 17:44:33 +0800
Message-Id: <20230911094444.68966-35-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the xfs-buf shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct xfs_buftarg.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Chandan Babu R <chandan.babu@oracle.com>
CC: "Darrick J. Wong" <djwong@kernel.org>
CC: linux-xfs@vger.kernel.org
---
 fs/xfs/xfs_buf.c | 24 +++++++++++++-----------
 fs/xfs/xfs_buf.h |  2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index c1ece4a08ff4..9e7ba04572db 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1913,8 +1913,7 @@ xfs_buftarg_shrink_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_buftarg	*btp = container_of(shrink,
-					struct xfs_buftarg, bt_shrinker);
+	struct xfs_buftarg	*btp = shrink->private_data;
 	LIST_HEAD(dispose);
 	unsigned long		freed;
 
@@ -1936,8 +1935,7 @@ xfs_buftarg_shrink_count(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_buftarg	*btp = container_of(shrink,
-					struct xfs_buftarg, bt_shrinker);
+	struct xfs_buftarg	*btp = shrink->private_data;
 	return list_lru_shrink_count(&btp->bt_lru, sc);
 }
 
@@ -1947,7 +1945,7 @@ xfs_free_buftarg(
 {
 	struct block_device	*bdev = btp->bt_bdev;
 
-	unregister_shrinker(&btp->bt_shrinker);
+	shrinker_free(btp->bt_shrinker);
 	ASSERT(percpu_counter_sum(&btp->bt_io_count) == 0);
 	percpu_counter_destroy(&btp->bt_io_count);
 	list_lru_destroy(&btp->bt_lru);
@@ -2031,13 +2029,17 @@ xfs_alloc_buftarg(
 	if (percpu_counter_init(&btp->bt_io_count, 0, GFP_KERNEL))
 		goto error_lru;
 
-	btp->bt_shrinker.count_objects = xfs_buftarg_shrink_count;
-	btp->bt_shrinker.scan_objects = xfs_buftarg_shrink_scan;
-	btp->bt_shrinker.seeks = DEFAULT_SEEKS;
-	btp->bt_shrinker.flags = SHRINKER_NUMA_AWARE;
-	if (register_shrinker(&btp->bt_shrinker, "xfs-buf:%s",
-			      mp->m_super->s_id))
+	btp->bt_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "xfs-buf:%s",
+					  mp->m_super->s_id);
+	if (!btp->bt_shrinker)
 		goto error_pcpu;
+
+	btp->bt_shrinker->count_objects = xfs_buftarg_shrink_count;
+	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
+	btp->bt_shrinker->private_data = btp;
+
+	shrinker_register(btp->bt_shrinker);
+
 	return btp;
 
 error_pcpu:
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index df8f47953bb4..702e7d9ea2ac 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -108,7 +108,7 @@ typedef struct xfs_buftarg {
 	size_t			bt_logical_sectormask;
 
 	/* LRU control structures */
-	struct shrinker		bt_shrinker;
+	struct shrinker		*bt_shrinker;
 	struct list_lru		bt_lru;
 
 	struct percpu_counter	bt_io_count;
-- 
2.30.2

