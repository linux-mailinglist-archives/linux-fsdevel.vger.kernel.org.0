Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9D7865E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbjHXDgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjHXDgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:36:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544BE10F1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:36:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a4dab8172so653814b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848174; x=1693452974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JbfRyB2vcpbgEbI5bcL+aaH/pKOG9tfRLOJc/3sbjg=;
        b=AmQeV5ugpfZZk/4usllkCaeo1yH+UEXJG7jnjRc8qsNsDjPHxzLvzK5kA+yWBZeygJ
         QCqKnO1KHf3+eaN6ECbGrfa0j2v5LKRtFyUEy/g2RLEfv+j6XgMptGwJuiJlZXgRctDR
         1nnjangfvZWRxM22knmOQhBjMh5+8kZXKYFdw6kEqV40Y7puFZ+EPVN5qqZqX1CCDlXK
         NX2tu+NjcfQnBPGwpvzf+O6OeU6GMUuaWrUR8aBMKqTlTLnD8yNu3RGk0KaXEBdC74Xr
         0NM+Tlk2UHZgkp5BBPIerGy6xK/sweDwCZE9YbGgyUcwE7V2RgWUkzgPwzp5TYYR7s7D
         Q9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848174; x=1693452974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JbfRyB2vcpbgEbI5bcL+aaH/pKOG9tfRLOJc/3sbjg=;
        b=D5lbKqly9kHofI5nqL1lp22d2TWesnNcmY6fJ7251gTNVsZJjZKbFnktZ/UcPngaFi
         K6f4Z/mxT9oCCwGBdg/AsxQMIbjtkb1jrU2MvuqlQu8Nw+lxRxiWXu+C0kcMv+27OxfL
         rWIniEuyNTmZA+2vFQsCvkpf2U5Z0wHY4VhrFR0g1BiUlJ0NkIfQuG33Og6cUhFkx38R
         fiOOSHf6sXW6BvkI4ZpzhAfjqgqVFvXP10rSlFmcSE8uL1LZmqBd4a7n9lqbpFFmFCeA
         OnFTYrQJSy7XoF2vT33H+NgVSle4lykbA0+7zAU9yDA2WMfWBXeTvT2Hj0lVK3RIHiUz
         JDWQ==
X-Gm-Message-State: AOJu0YxJTCuGFjKAGJ6TTcICjmXiXc4WLCg4FesUHnH5FJfUhoI3UfUC
        uzmnrR4ZKMDBBANVsg2efTWJtw==
X-Google-Smtp-Source: AGHT+IGrTGKA8Ukg4Uzs0bSKtsW+ppGLKZSPF9YJn/x2SceKMjMMpmj5eKgpoHo48YWv/+BWfzDTow==
X-Received: by 2002:a05:6a21:788b:b0:13d:fff1:c672 with SMTP id bf11-20020a056a21788b00b0013dfff1c672mr19904947pzc.4.1692848173825;
        Wed, 23 Aug 2023 20:36:13 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id p16-20020a62ab10000000b0068b6137d144sm2996570pff.30.2023.08.23.20.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:36:13 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 0/4] cleanups for lockless slab shrink
Date:   Thu, 24 Aug 2023 11:35:35 +0800
Message-Id: <20230824033539.34570-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series is some cleanups split from the previous patchset[1], I dropped the
[PATCH v2 5/5] which is more related to the main lockless patch.

This series is based on the next-20230823.

Comments and suggestions are welcome.

[1]. https://lore.kernel.org/lkml/20230807110936.21819-1-zhengqi.arch@bytedance.com/

Thanks,
Qi

Changlog in part 1 v2 -> part 1 v3:
 - drop [PATCH v2 5/5]
 - collect Acked-by
 - rebase onto the next-20230823

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

Qi Zheng (4):
  mm: move some shrinker-related function declarations to mm/internal.h
  mm: vmscan: move shrinker-related code into a separate file
  mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
  drm/ttm: introduce pool_shrink_rwsem

 drivers/gpu/drm/ttm/ttm_pool.c |  17 +-
 include/linux/shrinker.h       |  20 -
 mm/Makefile                    |   4 +-
 mm/internal.h                  |  28 ++
 mm/shrinker.c                  | 694 ++++++++++++++++++++++++++++++++
 mm/shrinker_debug.c            |  18 +-
 mm/vmscan.c                    | 701 ---------------------------------
 7 files changed, 743 insertions(+), 739 deletions(-)
 create mode 100644 mm/shrinker.c

-- 
2.30.2

