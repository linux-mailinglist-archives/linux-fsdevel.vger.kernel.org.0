Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1D77DC7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbjHPIhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbjHPIgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:36:42 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D574231
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 01:35:36 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a776cf15c8so730480b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692174936; x=1692779736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEdYgrJyQcwssjv302WhniVvwDe0CeIVGQ4feBQhaZY=;
        b=et6Z88qKe8udA5UmW5oLmTpORkL3fIeyIwXvJu5IDozzfA5uufancc+rrBd0ryt6JC
         6B+J4OmPEbPTFRuR9eKr6ReSS8A4rZiqou2GXvBTPACQyHw1ViltTTNm0wDEVNssyZtm
         30sJNa/9x+0axRmKkdDF7edtwJSdqKpCcory28n4elEgjjuHTF34l/gDYGL2D31U0C8D
         i8UmplinKNtMrFYDe8xbzWWloasxtiXFLe2jOACr3e0IqmCMVRJod1OIWmZwb294Idmp
         b3W/BFdU/Fvw2X6rlj7kFmRwm7hqhNoAW5QKRgmFZOFXovnnMf3t1uqssqOhPGxF/+2V
         JsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692174936; x=1692779736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEdYgrJyQcwssjv302WhniVvwDe0CeIVGQ4feBQhaZY=;
        b=KWGUMNt2zQgg7pjn5/NmiXp88yzZbsG/XBGFWJDAvloLYsCE6rR2PzM/xVzh3VXr67
         Wg84c5uRtDgCEAvSc0oKj1iej0D4GBK2vVHuF6zXF4x9NRyTmriodA/ahvIrO5J7ycZW
         b2EJ9UjEjSBIvRN0TmCURTJZUBDa5ou8u4s/4NCPdiY2ZClCIpYtY6H7biSVOupRNNrc
         Hkb5q/CtZx0fv5Y/9Au5ypjoEp4repSAEdlfLWjQ1TgcVh6oos5uYpXRH1LrP+WScJDq
         ruU4h5jnnwXVWNbSBH+5v/lDTcyxoJ6w/6P1CEfcSbdYlvJMXpnIgHtZD3jkKu/EcUzJ
         YWvQ==
X-Gm-Message-State: AOJu0YzIQIZ4bKVrcI2Zs7okTvfoZFOXbPSX/SjUctMLzaL7C6z556h5
        y0qB2Ilf/bSAUGpLX9Bc3LMVgA==
X-Google-Smtp-Source: AGHT+IFaewitmFjxr4BvO1FUDyDefEj0UVoHIPf+uKAL+8+YoBigpvW7yp/jXIUbm7qypbdXYQDY6g==
X-Received: by 2002:a05:6808:3a19:b0:3a8:175f:86de with SMTP id gr25-20020a0568083a1900b003a8175f86demr1196396oib.5.1692174935973;
        Wed, 16 Aug 2023 01:35:35 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id p16-20020a639510000000b005658d3a46d7sm7506333pgd.84.2023.08.16.01.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:35:35 -0700 (PDT)
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
Subject: [PATCH 0/5] use refcount+RCU method to implement lockless slab shrink (part 1)
Date:   Wed, 16 Aug 2023 16:34:14 +0800
Message-Id: <20230816083419.41088-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

This series is the part 1.

Comments and suggestions are welcome.

[1]. https://lore.kernel.org/lkml/20230807110936.21819-1-zhengqi.arch@bytedance.com/

Thanks,
Qi

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

 drivers/gpu/drm/ttm/ttm_pool.c |  15 +
 include/linux/memcontrol.h     |  12 +-
 include/linux/shrinker.h       |  37 +-
 mm/Makefile                    |   4 +-
 mm/internal.h                  |  28 ++
 mm/shrinker.c                  | 751 +++++++++++++++++++++++++++++++++
 mm/shrinker_debug.c            |  16 +-
 mm/vmscan.c                    | 701 ------------------------------
 8 files changed, 815 insertions(+), 749 deletions(-)
 create mode 100644 mm/shrinker.c

-- 
2.30.2

