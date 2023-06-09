Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1C72928D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbjFIIRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 04:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240172AbjFIIRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:17:37 -0400
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C62D63
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 01:17:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686298619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nWHbWur0xcsiIJRNXO9BxnEFhJfaHaB29elJK86jImY=;
        b=hm9r9Z4VbXL0q0p45qjdxq5imQrOSAOz6SqUl1eCzpaZLRAaEqtUbZNLqwHOsLS/xhrsvk
        F6qAXhDOx6pg63ZiJRsecHNM4ZqohscqAvlPCfzuoV/QxWl4sCGfpNTwhJUjW8YLxQGSP6
        rDKDBy+yd9VO521dSPMx3hA8aLDd61s=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, muchun.song@linux.dev, yujie.liu@intel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/7] revert shrinker_srcu related changes
Date:   Fri,  9 Jun 2023 08:15:11 +0000
Message-Id: <20230609081518.3039120-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

Hi all,

Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
test case [1], which is caused by commit f95bdb700bc6 ("mm: vmscan: make
global slab shrink lockless"). The root cause is that SRCU has to be careful
to not frequently check for SRCU read-side critical section exits. Therefore,
even if no one is currently in the SRCU read-side critical section,
synchronize_srcu() cannot return quickly. That's why unregister_shrinker()
has become slower.

After discussion, we will try to use the refcount+RCU method [2] proposed
by Dave Chinner to continue to re-implement the lockless slab shrink. So
revert the shrinker_srcu related changes first.

[1]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
[2]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/

And hi Andrew, the commit c3b5cb881de6 ("mm: vmscan: move
shrinker_debugfs_remove() before synchronize_srcu()") is still in the
mm-unstable branch, you can drop it directly.

This series is based on v6.4-rc5.

Thanks,
Qi

Qi Zheng (7):
  Revert "mm: shrinkers: convert shrinker_rwsem to mutex"
  Revert "mm: vmscan: remove shrinker_rwsem from
    synchronize_shrinkers()"
  Revert "mm: vmscan: hold write lock to reparent shrinker nr_deferred"
  Revert "mm: shrinkers: make count and scan in shrinker debugfs
    lockless"
  Revert "mm: vmscan: add shrinker_srcu_generation"
  Revert "mm: vmscan: make memcg slab shrink lockless"
  Revert "mm: vmscan: make global slab shrink lockless"

 drivers/md/dm-cache-metadata.c |   2 +-
 drivers/md/dm-thin-metadata.c  |   2 +-
 fs/super.c                     |   2 +-
 mm/shrinker_debug.c            |  39 ++++++----
 mm/vmscan.c                    | 125 +++++++++++++++------------------
 5 files changed, 82 insertions(+), 88 deletions(-)

-- 
2.30.2

