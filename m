Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104566EB0BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjDURk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjDURkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:40:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7610912582
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:23 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a66bd44f6dso16018075ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682098823; x=1684690823;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PreKFJTa4Nhy/d8G1S1pWlqvl89TyRSt3luKcVUPmzw=;
        b=RbrkYV0CJdmfBIbmUIvZnVKhJQyLH4CYaft3mk2yfKLvyJZF8dDaaqVVnx3eiK4Ab7
         lZDDw30q1ppsBNzI772XXB/FRji5/R8TeuWfOOnXpJHy3+Y7JyutQQ2Gj19sY9tbj8iD
         l3vp+8XcixoSCatriNQ/fKYwuCkpY6rEOUk7vfFOeJNxNuSbxeoNvs3hSBNc92fiAIj4
         a4voAS83/3J7lvlMPpBscMu6mKr9RPsusaetGLt5BbQVCI9eFbxjUyZ5WoZ+y39zt/1d
         13legztw2c8S9smKxFGhZzKMk7rQhrAr+Y1NpiTukgQZJEDzm31H36UsudJPK7jznpxJ
         jqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098823; x=1684690823;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PreKFJTa4Nhy/d8G1S1pWlqvl89TyRSt3luKcVUPmzw=;
        b=G50d8gSsXhewinoD0iDEjzjxX0e2EUzFOxqwwvhaDwY8R+xdlpvX/xb7zgfQDAGjuS
         fZRO8wpzKJZWLULpN6YHeUfW1ZwigjzlMirWT5Qh2pO+37AdF40ml2xi68/kAXLDR/4w
         /tKQqxPnGIpVWtZjX+mTlz2oWbveqMKYtiZbMlXBfk54oj0FYHKRpqylq+3AQ1rldvQf
         OZobZUZZ+bWOtcPfyqaUrP7UhYN75UwXRkLfESSOnjpqp8ZOoAFtm15h+ChEX5lKJi51
         CSGEY31B6v3vVrwh8r/LmWWvzWa8pmaJoDhNvgquohfDdDy1pnzSRWahktKI2q17tLGH
         7GIA==
X-Gm-Message-State: AAQBX9dq0V3c7vXyqUfgXUXZYNGOMQ/G95fUbw+GAtYP/lyUVZTkkcgK
        LYYtWyALOxuN95QdZFVaaZGQSqUx2KiTu1Jb
X-Google-Smtp-Source: AKy350ZlnZj0cxHrv/Wjk1pQ1CQV0zgSpBwIct8jNYsZLeVb1GgBjLCU23xFOdjM3zTGe34xq+HU5r4O5Po/289Y
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:f302:b0:1a2:6e4d:782c with SMTP
 id c2-20020a170902f30200b001a26e4d782cmr1851742ple.13.1682098823035; Fri, 21
 Apr 2023 10:40:23 -0700 (PDT)
Date:   Fri, 21 Apr 2023 17:40:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421174020.2994750-1-yosryahmed@google.com>
Subject: [PATCH v5 0/5] cgroup: eliminate atomic rstat flushing
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A previous patch series ([1] currently in mm-stable) changed most
atomic rstat flushing contexts to become non-atomic. This was done to
avoid an expensive operation that scales with # cgroups and # cpus to
happen with irqs disabled and scheduling not permitted. There were two
remaining atomic flushing contexts after that series. This series tries
to eliminate them as well, eliminating atomic rstat flushing completely.

The two remaining atomic flushing contexts are:
(a) wb_over_bg_thresh()->mem_cgroup_wb_stats()
(b) mem_cgroup_threshold()->mem_cgroup_usage()

For (a), flushing needs to be atomic as wb_writeback() calls
wb_over_bg_thresh() with a spinlock held. However, it seems like the
call to wb_over_bg_thresh() doesn't need to be protected by that
spinlock, so this series proposes a refactoring that moves the call
outside the lock criticial section and makes the stats flushing
in mem_cgroup_wb_stats() non-atomic.

For (b), flushing needs to be atomic as mem_cgroup_threshold() is called
with irqs disabled. We only flush the stats when calculating the root
usage, as it is approximated as the sum of some memcg stats (file, anon,
and optionally swap) instead of the conventional page counter. This
series proposes changing this calculation to use the global stats
instead, eliminating the need for a memcg stat flush.

After these 2 contexts are eliminated, we no longer need
mem_cgroup_flush_stats_atomic() or cgroup_rstat_flush_atomic(). We can
remove them and simplify the code.

[1] https://lore.kernel.org/linux-mm/20230330191801.1967435-1-yosryahmed@google.com/

RFC -> v1:
- Collected R-b's and A-b's (Thanks everyone!).
- Rebased onto mm-stable.
- Cosmetic changes to commit logs.

RFC: https://lore.kernel.org/linux-mm/20230403220337.443510-1-yosryahmed@google.com/

Yosry Ahmed (5):
  writeback: move wb_over_bg_thresh() call outside lock section
  memcg: flush stats non-atomically in mem_cgroup_wb_stats()
  memcg: calculate root usage from global state
  memcg: remove mem_cgroup_flush_stats_atomic()
  cgroup: remove cgroup_rstat_flush_atomic()

 fs/fs-writeback.c          | 16 +++++++----
 include/linux/cgroup.h     |  1 -
 include/linux/memcontrol.h |  5 ----
 kernel/cgroup/rstat.c      | 26 ++++--------------
 mm/memcontrol.c            | 54 ++++++++------------------------------
 5 files changed, 27 insertions(+), 75 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

