Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8979B211
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbjIKU4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjIKJ0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:26:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9383BCD3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:25:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68e3c6aa339so761249b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694424355; x=1695029155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVX9WeWGptEOVbuDunuTR7x+0VEpx5JzgLCEo/pvZQ8=;
        b=DbOajRgy2xFmheWiYFJNiF/VqFWhMN7MqRf1KIZ/fq6Bs63joSkDy1w3+5EvoBQV28
         yGKKd4Iz+CS2aFASp+sR9WS7RBZb2YXCzIvyFiFhI711CORejhkt7/lsD9FkZ6v5rlDF
         5r5nbSVGp8nhXVcii06hLJqTdphitOJg5pyHMtNSvteWcTfXQv6E+YO24oXzlMs3LkRY
         Z4ZayDdRe1KGQ5wD+LADkzCR2ikO2nvW5/Cbn9MHDJ0o8Smu9BDAk/q2vdON1YmnKMZp
         F+kaH/lHExQy1jGBPgC2OVX73tuHvdULyq7oNaZk0o/Cf2+P03iVOJsh0QFA/tJs8AgI
         fONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424355; x=1695029155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVX9WeWGptEOVbuDunuTR7x+0VEpx5JzgLCEo/pvZQ8=;
        b=tVm3OdM3GLZSzx4nWZWoPw0zqjgtEKFQFjVHeYK60MPKMRor0OHKqWTKgX/U4Zi/6Z
         oaDksKKn8IuJKMjgn9DnavAZHb0fM66iGdzqIUNiMUtfcmz8m6TgZwZ1lpktSO8PICtZ
         Wr2QgIJIfKZljhGO+H8D4UCJk+CILEzWoyd5cpPxIKfIDs5/mX2BbM9xcfYhjAARvI0R
         KaFj5Gc7TsNYLiFGoNU+dhuuAUO9uW/gkcZ4MLTJz7Ns9UJ04lDv1O3lCDeborBHEyK3
         Rex0yDuOalWViSpIqWlMYdlTUrEUyv+joa7wGZ3PZNFpIPeVsxSCgO3/ZVj42isCTeQV
         BFpA==
X-Gm-Message-State: AOJu0Yz7TuqZ2HO/0vvo73BAT+ITi6PQthGoPHzht8HTAtvvAaGCd2Qj
        gUVkZv3kqCEitbSSbN3hhBbNsg==
X-Google-Smtp-Source: AGHT+IFA8N2LVaGnVCnfvNYWcDqv3xveqW6PwXfspm7irjG2TpwEtxpwFLm2nXmkPtV/jExbnj34Wg==
X-Received: by 2002:a05:6a20:5498:b0:145:3bd9:1377 with SMTP id i24-20020a056a20549800b001453bd91377mr11799129pzk.5.1694424355065;
        Mon, 11 Sep 2023 02:25:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001b89466a5f4sm5964623pll.105.2023.09.11.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:25:54 -0700 (PDT)
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
Subject: [PATCH v4 0/4] cleanups for lockless slab shrink
Date:   Mon, 11 Sep 2023 17:25:13 +0800
Message-Id: <20230911092517.64141-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series is some cleanups for lockless slab shrink, I dropped the
[PATCH v2 5/5] which is more related to the main lockless patch.

This series is based on the v6.6-rc1.

Comments and suggestions are welcome.

Thanks,
Qi

Changlog in v3 -> v4:
 - rebase onto the v6.6-rc1

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

