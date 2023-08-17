Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7077F515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 13:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350235AbjHQLZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350248AbjHQLYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:24:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A82D58
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 04:24:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf11a7cf9fso1077065ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692271461; x=1692876261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjcEuXYPc+3P+LflzNgS/R35PrZZxb+MjPLlVSZIGUc=;
        b=VQyIIEXMiq6pS36wIOW0IXVYQlXj6t1+KnNqrtLm+JWyhseZuF/zL3mfYeyfkuTkax
         L2evGQoksYxnfMdnfi7L5aelupBzM9GKiySr4tbyMKg6ti09dvUHMz3K83sLuqcnwOC6
         zVhrcmRWkwFwqkOo511Jr7OJuivS8aHsEj+t05Cp5TVi9xMh+ZV1Hl/K1hNUfhJjioSV
         u8B2KKWIBCJGihrrTPOzc7H9CH4IHP54TtrVh2620huZ9ap2bfecBprTLHC6J6Qv+Jfa
         lCH0H3x/Qd9cZhCqRkB+y1K0uMDQJXkuZPox9U/8W4MA2XkhKTj+NGusIquX0F6iHqpx
         BONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692271461; x=1692876261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjcEuXYPc+3P+LflzNgS/R35PrZZxb+MjPLlVSZIGUc=;
        b=kndALC87zXoNV3KfxZ7uK+OFJKVx90+rFnRtbaVZhW2BLeU0a95JWz1PMNGBJX92oK
         C8QOjOCRUaFTjap/f2l6/RiwWQRV37fT3rHJ2kMtnNcu7V9sEqhCf3DZ8vHLpff1vYp6
         rT8pD3P3dqvIq95nUFVHjzObJbYwUC9qHdfEtvQavbNgr4Jox5aosP+fO52HMFCqrtAm
         kTK9D5Z0HnEYvmJyZRFCoGtL0VPrGOLCEtZhZ3kymq26CopJtVjFdJ2oMUtKPXKOiEMJ
         lmO7HY7rTABp7LtpRAztgOR54Yd4WzIdFAur6aTTXcG9Iy5rIkmSoEOM6qGpSDtYcoEF
         3P1g==
X-Gm-Message-State: AOJu0YzTKQ4cAknOQNjZ7167GcYZD8daqzZAsklkBwLkLyTMq0h1OWug
        cA6cw85BGBE/tiMZQaJrVywO7A==
X-Google-Smtp-Source: AGHT+IEeXBbxeyhPNz97Ub6nYdX4Bl9hgGdsmEb3/sN/aMQfAJ6bX7scVeQIfkeMLyVVQUcumeSs6g==
X-Received: by 2002:a17:902:e803:b0:1b8:9fc4:2733 with SMTP id u3-20020a170902e80300b001b89fc42733mr5237062plg.3.1692271460997;
        Thu, 17 Aug 2023 04:24:20 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001bde877a7casm7229309plb.264.2023.08.17.04.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 04:24:20 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 0/5] use refcount+RCU method to implement lockless slab shrink (part 1)
Date:   Thu, 17 Aug 2023 19:23:57 +0800
Message-Id: <20230817112402.77010-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

To make reviewing and updating easier, I've chosen to split the previous
patchset[1] into the following three parts:

part 1: some cleanups and preparations
part 2: introduce new APIs and convert all shrinnkers to use these
part 3: implement lockless slab shrink

This series is the part 1 and is based on the next-20230815.

Comments and suggestions are welcome.

[1]. https://lore.kernel.org/lkml/20230807110936.21819-1-zhengqi.arch@bytedance.com/

Thanks,
Qi

Changlog in part 1 v1 -> part 1 v2:
 - fix compilation warning in [PATCH 1/5]
 - rename synchronize_shrinkers() to ttm_pool_synchronize_shrinkers()
   (pointed by Christian König)
 - collect Reviewed-by

Changlog in v4 -> part 1 v1:
 - split from the previous large patchset
 - fix comment format in [PATCH v4 01/48] (pointed by Muchun Song)
 - change to use kzalloc_node() and fix typo in [PATCH v4 44/48]
   (pointed by Dave Chinner)
 - collect Reviewed-bys
 - rebase onto the next-20230815

Qi Zheng (5):
  mm: move some shrinker-related function declarations to mm/internal.h
  mm: vmscan: move shrinker-related code into a separate file
  mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
  drm/ttm: introduce pool_shrink_rwsem
  mm: shrinker: add a secondary array for shrinker_info::{map,
    nr_deferred}

 drivers/gpu/drm/ttm/ttm_pool.c |  17 +-
 include/linux/memcontrol.h     |  12 +-
 include/linux/shrinker.h       |  37 +-
 mm/Makefile                    |   4 +-
 mm/internal.h                  |  28 ++
 mm/shrinker.c                  | 751 +++++++++++++++++++++++++++++++++
 mm/shrinker_debug.c            |  18 +-
 mm/vmscan.c                    | 701 ------------------------------
 8 files changed, 818 insertions(+), 750 deletions(-)
 create mode 100644 mm/shrinker.c

-- 
2.30.2

