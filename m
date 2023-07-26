Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE42762F97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGZIWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjGZIVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:21:44 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABFE49F3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:09:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-348c62db335so17140805ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690358989; x=1690963789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2dLh/uGiMpMzYsXqB2cYj7xJxo2Ps0eqGhMV20FNlw=;
        b=HnjyOJ+l7FNJ7d3Q68VgFo45FqzJSVRLcLrWfoocPC/tALn5DwJ4EzCz6W2zsrl1tz
         m3xlYewQbRATIsLvNNYPEJsYsl3PaTdzyv7kUE7HzT2iiN5tVv5fk67BbLok6xfsDglz
         lU/afwdiWaHWXRDAOoK5kDrJlpCGkJuXL64YymOBIZvmOoI++RDrLc7Dgc6YsYlGppKe
         6yOlbC8kUtF4kcYykHIfxgVOFj4YoHQI7Ao5fFiBl4qpCYtm6n3zG1pn6VjEETMTsTJk
         BUKdur+CWRhocn35XByLCs68leeyZwgl8WydRdFQOn8JRQhPG60TFo1IWAW8OOk8edTw
         V2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358989; x=1690963789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2dLh/uGiMpMzYsXqB2cYj7xJxo2Ps0eqGhMV20FNlw=;
        b=KQSnLw5ZSQZvoMzv8fRZCCYj1xU7wB/fg3/YtwQskjiH78DBDKBAJ54mNDfXgUsuxr
         7TpB5TtVfrwV17E3fA6AhZj0HUn3emnZQraggRJb0/s3zC4AIP67UU0mLE8tKMZgmPBo
         bhkaHcz3wPJvPAqD7IHFH9nLLqCcameZ8Pr4OHNQthfcYIcvkez6SKbWUZLey1xtARw9
         VykGp88kwJV2Y/+PkWAdKFXrubfnAMoIOKN3RCFeTXtVFRcOa7aHyS3kMWF1bzwK/bqG
         RAUFl+qmIGxGZzn7Mb2ZR7OsM3dsskh7tiNZuP7uvXVm/B1EsznoBX2xXmY5m2uRc1DW
         Tzzg==
X-Gm-Message-State: ABy/qLadcDpe7W13/VbBWogiWih/8H+z0KDDtGwmV/67xLorgp8apZBj
        xa2u4utmseDd644eu7s+0F+VHQ==
X-Google-Smtp-Source: APBJJlGFuOk5isZR4/+qS0sIxAc4XoYeJCy3FONS359I8jJMygiVODk1sNpeRSv1+vKLVQcpXvx+YQ==
X-Received: by 2002:a05:6e02:1341:b0:346:6dc2:997b with SMTP id k1-20020a056e02134100b003466dc2997bmr1160807ilr.23.1690358989560;
        Wed, 26 Jul 2023 01:09:49 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.09.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:09:49 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 00/11] Introduce mt_dup() to improve the performance of fork()
Date:   Wed, 26 Jul 2023 16:09:05 +0800
Message-Id: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A few weeks ago, Liam and I discussed "Fork & Dup tree + Delete DONT_COPY" in
[1]. Thanks Liam for a lot of useful information there.

I didn't use the scheme of linking the leaf nodes, nor did I use the scheme
of building the tree in BFS order. I ended up using the scheme of building the
tree in DFS order. I implemented this algorithm and it seems to be very
efficient.

Use bench_forking() in lib/test_maple_tree.c to test in user space, and get the
performance numbers of duplicating maple tree as follows:

before: 13.52s
after: 2.60s

Their meaning is the time consumed by duplicating 80,000 maple trees with 134
entries. These numbers do not include the time consumed by mt_validate() and
mtree_destroy(). It can be seen that the time consumed has been reduced by
80.77%.

The performance improvement of fork() can be summarized as follows:
With 23 VMAs, performance improves by about 3%, with 223 VMAs, performance
improves by about 15%, and with 4023 VMAs, performance improves by about 30%.
See patch[11/11] for details.

In addition, I would like to assist Liam in maintaining the maple tree, which
requires Liam's consent. In the future I will make some contributions to the
development of maple tree.

The layout of these patches:
001 - 003: Introduce some internal functions to facilitate the
           implementation of mt_dup().
004 - 005: Introduce __mt_dup() and mt_dup(), and their tests.
      006: Introduce mas_replace_entry() to efficiently replace an entry.
007 - 009: Follow-up work on introducing these things.
      010: Add myself as co-maintainer for maple tree.
      011: Use __mt_dup() to duplicate maple tree in dup_mmap().

[1] https://lore.kernel.org/lkml/463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com/

Peng Zhang (11):
  maple_tree: Introduce ma_nonleaf_data_end{_nocheck}()
  maple_tree: Validate MAPLE_ENODE and ma_nonleaf_data_end()
  maple_tree: Add some helper functions
  maple_tree: Introduce interfaces __mt_dup() and mt_dup()
  maple_tree: Add test for mt_dup()
  maple_tree: Introduce mas_replace_entry() to directly replace an entry
  maple_tree: Update the documentation of maple tree
  maple_tree: Skip other tests when BENCH is enabled
  maple_tree: Update check_forking() and bench_forking()
  MAINTAINERS: Add co-maintainer for maple tree
  fork: Use __mt_dup() to duplicate maple tree in dup_mmap()

 Documentation/core-api/maple_tree.rst |  10 +
 MAINTAINERS                           |   1 +
 include/linux/maple_tree.h            |   4 +
 kernel/fork.c                         |  35 ++-
 lib/maple_tree.c                      | 389 ++++++++++++++++++++++++--
 lib/test_maple_tree.c                 |  67 ++---
 mm/mmap.c                             |  14 +-
 tools/testing/radix-tree/maple.c      | 204 ++++++++++++++
 8 files changed, 658 insertions(+), 66 deletions(-)

-- 
2.20.1

