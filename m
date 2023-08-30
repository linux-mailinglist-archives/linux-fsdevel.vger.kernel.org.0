Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C185F78DBC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjH3Shl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244314AbjH3M5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:57:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7CF185
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0ecb9a075so23528195ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693400239; x=1694005039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtd6q3SyxBvaZmQAvE8P+QtZVZRCjxwa7BoiOx4Ow2A=;
        b=hXcYwd19n0oHlzatNp4OoAc9g+V+yogC6I0LGKFx/Mh/qFYIBfg0navOsaPrr2/Bwe
         DwwOlGRaHQU9Tl7prr4Q0u4zjsubk3TYs6duoWEsqibWe3rCT39pvnzvxyw5+5qxCrTD
         d+kxtTa2Ws5FpmUAS863F5h4NDx6nzaPMN6F5EscaWybPVkmTp9d6vkSq2oBzp7gG1Bs
         9OoJXae9XkpnJ9t73GxwRk79qkbvjXTxy/6Fq+nc9MzwxAP8+4CNfLOxzLKY3nStnt7m
         wpRRmwl9uGYmFA+kPTGmaZeyf4DQQI6gZGSwm+DjcEBgLTJ170ZK/hEz5JqnMjwREDbu
         uhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400239; x=1694005039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtd6q3SyxBvaZmQAvE8P+QtZVZRCjxwa7BoiOx4Ow2A=;
        b=Z7wGITtjR3kOW0pQy+z/Wmt4P1aW+eZ+3V9w88oFtK92eKxbwq6kc5aT6ekJsSTrUO
         46SHMeY53VeZBqZXN8gm33wwaHSxy8Lm4ea/gxjCsQtf8sk1Bu0j8WcU0QNs7sOqfC+L
         Ta8RL7jLIx+jzQy4dObCw5sncW2od8IlJGMnD+kOWaqU7Qas0mRJF3hleDCor+L7zdvY
         AnB82z8fofe6buAoT4owKsgApysRuaXVXLZYw6qfN/Jbz7tCoSugnyFMeqTDjX8SfR5i
         niwjobikGpF+3Yd5mNbIig0GpyxROFYOwCDVKuZS6s/K+AVd1q1mfm23qCXw/A15DcTY
         nyag==
X-Gm-Message-State: AOJu0Yz5qO9W4c22Mh1NBS8nlRkgoZi8cE0JEwZh2CUD41Qb2pbz/VH4
        /jHHLtHK/b7x+33sjjRUYxdRmQ==
X-Google-Smtp-Source: AGHT+IGKPuYQWBKa1a4+1P4c5NUAY3fS0w+iEhxnmdtT4j9dZZVQZKmRW9OE8TVjanTCPupqydzJDg==
X-Received: by 2002:a17:903:110d:b0:1bf:6c4e:4d60 with SMTP id n13-20020a170903110d00b001bf6c4e4d60mr2040423plh.3.1693400238850;
        Wed, 30 Aug 2023 05:57:18 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001bbd8cf6b57sm11023265plb.230.2023.08.30.05.57.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Aug 2023 05:57:18 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 0/6] Introduce __mt_dup() to improve the performance of fork()
Date:   Wed, 30 Aug 2023 20:56:48 +0800
Message-Id: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the process of duplicating mmap in fork(), VMAs will be inserted into the new
maple tree one by one. When inserting into the maple tree, the maple tree will
be rebalanced multiple times. The rebalancing of maple tree is not as fast as
the rebalancing of red-black tree and will be slower. Therefore, __mt_dup() is
introduced to directly duplicate the structure of the old maple tree, and then
modify each element of the new maple tree. This avoids rebalancing and some extra
copying, so is faster than the original method.
More information can refer to [1].

There is a "spawn" in byte-unixbench[2], which can be used to test the performance
of fork(). I modified it slightly to make it work with different number of VMAs.

Below are the test numbers. There are 21 VMAs by default. The first row indicates
the number of added VMAs. The following two lines are the number of fork() calls
every 10 seconds. These numbers are different from the test results in v1 because
this time the benchmark is bound to a CPU. This way the numbers are more stable.

  Increment of VMAs: 0      100     200     400     800     1600    3200    6400
6.5.0-next-20230829: 111878 75531   53683   35282   20741   11317   6110    3158
Apply this patchset: 114531 85420   64541   44592   28660   16371   9038    4831
                     +2.37% +13.09% +20.23% +26.39% +38.18% +44.66% +47.92% +52.98%

Todo:
  - Update the documentation.

Changes since v1:
 - Reimplement __mt_dup() and mtree_dup(). Loops are implemented without using
   goto instructions.
 - The new tree also needs to be locked to avoid some lockdep warnings.
 - Drop and add some helpers.
 - Add test for duplicating full tree.
 - Drop mas_replace_entry(), it doesn't seem to have a big impact on the
   performance of fork().

[1] https://lore.kernel.org/lkml/463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com/
[2] https://github.com/kdlucas/byte-unixbench/tree/master

v1: https://lore.kernel.org/lkml/20230726080916.17454-1-zhangpeng.00@bytedance.com/

Peng Zhang (6):
  maple_tree: Add two helpers
  maple_tree: Introduce interfaces __mt_dup() and mtree_dup()
  maple_tree: Add test for mtree_dup()
  maple_tree: Skip other tests when BENCH is enabled
  maple_tree: Update check_forking() and bench_forking()
  fork: Use __mt_dup() to duplicate maple tree in dup_mmap()

 include/linux/maple_tree.h       |   3 +
 kernel/fork.c                    |  34 ++-
 lib/maple_tree.c                 | 277 ++++++++++++++++++++++++-
 lib/test_maple_tree.c            |  69 +++---
 mm/mmap.c                        |  14 +-
 tools/testing/radix-tree/maple.c | 346 +++++++++++++++++++++++++++++++
 6 files changed, 697 insertions(+), 46 deletions(-)

-- 
2.20.1

