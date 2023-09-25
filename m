Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC67ACED7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 05:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjIYD6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 23:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjIYD6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:58:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B43DF
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 20:57:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso3896418b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695614265; x=1696219065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL8oS6h/SMWhCHncu4CSFCmNusM3zUoiub5E91Pn6TA=;
        b=X05cR9gbgpWsd0WxF7LzGEEkNoOB2lSNWyHrgCKsLdSkUQ9GPgk24OxyjUfmJWf+5s
         X+wclKE2/DDG+aH5gtS8YgXFfLgsezLkaLA2Q+xHgmd4FP8o0P7l4pRe1wlNj/HrlG7M
         uNRHOHBniyUAQ5pKWf+Lvl51Dan7sRanpbPU35oWE8HMrBuPJjJMsXEX05vLeSEKFrL4
         tADUkI6Eiyh7QQ/FMZGb3G3yOP9+Vb3i/P8xb06KjZ0uVxVAx1g1CjFHPgUMoqy9ujnd
         0c6jUq5F4xQ+bIBFtrEWXFS3BP8A+HzNt8nVnfAo8bJUkvfNiyp1/SPde6pqk6PpTvIl
         FTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695614265; x=1696219065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZL8oS6h/SMWhCHncu4CSFCmNusM3zUoiub5E91Pn6TA=;
        b=Yq1gI/+MZ0Lyj/wvwRNP7rxtsC+lZNO6BJnqwjNZZgjp+D9Yb0dcaolkmTlNom7vAU
         56HZlQx4CmEX8Wj8b3BKsn2PgJRZZxasXz4QSplAYwZzVsU23fUi6uCkcz8N5HCP1CME
         IJrhxdAyWT58bjKb57uFCe3TatXlJ1n2W01KpWq6tKwCjc6jL7/ccA2r3Qc5wsoR2Lis
         p9nkXNho9dIzE+RHOvVV0J5FfkbZXzA/tPFiJb77Zae4yJgfJ3TOKuiLKtnN5uqlNCab
         5inv4iLWpdWeIrRhbNCfALVms+/ae1ZrzR+46WXWtuntDWCcjhDtcjLMNTg6NKMkCki4
         ATQg==
X-Gm-Message-State: AOJu0YzpD57EziHMFldQmgl2jpryfLwTFuwHrIGEEqHfKhjEoyIazLZh
        UehLX4CEYMcvNm0dMrdgN+B8cQ==
X-Google-Smtp-Source: AGHT+IFP1hfquosoj31qZFLIMz20MNEzlSyLXJoKN6SESAMuexDGVnApQHVkteHWucUZMl8Lpc79LA==
X-Received: by 2002:a05:6a00:1990:b0:68b:fdfe:76c2 with SMTP id d16-20020a056a00199000b0068bfdfe76c2mr4715925pfl.20.1695614264958;
        Sun, 24 Sep 2023 20:57:44 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm1-20020a056a002f8100b00679a4b56e41sm7025387pfb.43.2023.09.24.20.57.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Sep 2023 20:57:43 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/9] Introduce __mt_dup() to improve the performance of fork()
Date:   Mon, 25 Sep 2023 11:56:08 +0800
Message-Id: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

Hi all,

This series introduces __mt_dup() to improve the performance of fork(). During
the duplication process of mmap, all VMAs are traversed and inserted one by one
into the new maple tree, causing the maple tree to be rebalanced multiple times.
Balancing the maple tree is a costly operation. To duplicate VMAs more
efficiently, mtree_dup() and __mt_dup() are introduced for the maple tree. They
can efficiently duplicate a maple tree. By applying __mt_dup() to dup_mmap(),
better performance is achieved compared to the original method. After using this
method, the average time complexity decreases from O(n * log(n)) to O(n).

Here are some algorithmic details about {mtree, __mt}_dup(). We perform a DFS
pre-order traversal of all nodes in the source maple tree. During this process,
we fully copy the nodes from the source tree to the new tree. This involves
memory allocation, and when encountering a new node, if it is a non-leaf node,
all its child nodes are allocated at once.
Some previous discussions can be referred to as [1].

There is a "spawn" in byte-unixbench[2], which can be used to test the
performance of fork(). I modified it slightly to make it work with
different number of VMAs.

Below are the test results. By default, there are 21 VMAs. The first row
shows the number of additional VMAs added on top of the default. The last
two rows show the number of fork() calls per ten seconds. The test results
were obtained with CPU binding to avoid scheduler load balancing that
could cause unstable results. There are still some fluctuations in the
test results, but at least they are better than the original performance.

Increment of VMAs: 0      100     200     400     800     1600    3200    6400
next-20230921:     112326 75469   54529   34619   20750   11355   6115    3183
Apply this:        116505 85971   67121   46080   29722   16665   9050    4805
                   +3.72% +13.92% +23.09% +33.11% +43.24% +46.76% +48.00% +50.96%

Thanks to kernel test robot <oliver.sang@intel.com> for reporting the warning
about nested locks.

Thanks to Liam for all the suggestions.

Changes since v2:
 - Some minor modifications to mtree_dup(), __mt_dup() and their test code.
 - Introduce {mtree, mas}_lock_nested() to address lockdep warnings.
 - Update the documentation for maple tree.
 - Introduce undo_dup_mmap() to address the failure of dup_mmap().
 - Performance data was retested based on the latest next-20230921, and there
   were some fluctuations in the results which were expected.

[1] https://lore.kernel.org/lkml/463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com/
[2] https://github.com/kdlucas/byte-unixbench/tree/master

v1: https://lore.kernel.org/lkml/20230726080916.17454-1-zhangpeng.00@bytedance.com/
v2: https://lore.kernel.org/lkml/20230830125654.21257-1-zhangpeng.00@bytedance.com/

Peng Zhang (9):
  maple_tree: Add mt_free_one() and mt_attr() helpers
  maple_tree: Introduce {mtree,mas}_lock_nested()
  maple_tree: Introduce interfaces __mt_dup() and mtree_dup()
  maple_tree: Add test for mtree_dup()
  maple_tree: Update the documentation of maple tree
  maple_tree: Skip other tests when BENCH is enabled
  maple_tree: Update check_forking() and bench_forking()
  maple_tree: Preserve the tree attributes when destroying maple tree
  fork: Use __mt_dup() to duplicate maple tree in dup_mmap()

 Documentation/core-api/maple_tree.rst |   4 +
 include/linux/maple_tree.h            |   7 +
 include/linux/mm.h                    |   1 +
 kernel/fork.c                         |  34 ++-
 lib/maple_tree.c                      | 300 ++++++++++++++++++++-
 lib/test_maple_tree.c                 |  69 +++--
 mm/internal.h                         |   3 +-
 mm/memory.c                           |   7 +-
 mm/mmap.c                             |  52 +++-
 tools/include/linux/spinlock.h        |   1 +
 tools/testing/radix-tree/maple.c      | 363 ++++++++++++++++++++++++++
 11 files changed, 787 insertions(+), 54 deletions(-)

-- 
2.20.1

