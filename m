Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830EF6D181B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 09:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCaHIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCaHIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:08:22 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A57CA27
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 00:08:22 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x4-20020a170902ec8400b001a1a5f6f272so12459997plg.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 00:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680246501;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AxV13ttd0okhRK37057Bft4LTQPnmiMqtPZxYuE9zT4=;
        b=YADI96jVgiYPZRSA/peAggJ1UQ51//UvA/NHqCLbFRbrvy6NrfGn7y68B7SqPbKkWr
         0St+ZzCJthd+R7lYoheP1BORTpoCjw4zPzaECkLQxVQTHrMI8B9cjt7DcBGKSw82qoV7
         govybumASYXhf60cCUp/IaMa0u8IjM5BtYMB7XLWRbZTN2AHMrwl7r6Pl36MpeIoLENE
         DQR8j5Vv14GXCDRTUsQx4sKmHq9BSMZeAYA1VDEA82FeD7/GDaQmT73P882/ebuiiwwv
         zKf3lK298QFggp7XoIt7VpvXlIweYbvefoc6upchYkznH6ammqvuCWagsQRerA20UDUV
         19pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680246501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxV13ttd0okhRK37057Bft4LTQPnmiMqtPZxYuE9zT4=;
        b=g4Ef+JO6+XRtlJN5NItvLqcQBORL+dCMis9uWdSHkVFeOquRonnIqqFTGJOXynm34K
         YuucloepVnyd5D2TOS5OybGKdvhZl7wU2JZ7S31RaghVbepXriPOs6mn09eek5ipGlQ5
         E5DG/r74JjYZemlYxkPjRjkd/yeXEm08pSJn8b+MkO17pNWiAHDKu7SLrTYpzZ4MuL5H
         Lal/UNIx/3sC6+uBZHddt/m/uPBm8Wc7BZYJlCeUsBm3UjFE5xipAQfIBAAArI/1THd3
         OF+0vH+V99hKDTPZqXycMtdVDB8RC+xNVpgaHGM9tlA4RzknSSQJKUEYl7E3uG+DMocO
         jUCA==
X-Gm-Message-State: AAQBX9db0yD7DbEHm7uWYZ7x8Ve5COCBux1PHBPqK5KkmjI6Sbrc9mwD
        PbV30UgW5NjvREe1zayxswfrVpIKeZC2lkXY
X-Google-Smtp-Source: AKy350b0knEaTNZ6EqlFZpPPUswwWCJeCMzE7r5/axoeUeK3BbwwP1Kc/GQBYQhutWHarYFOq+PIColFf89yH3jn
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:68cb:b0:23f:d120:4413 with SMTP
 id q11-20020a17090a68cb00b0023fd1204413mr7943430pjj.1.1680246501490; Fri, 31
 Mar 2023 00:08:21 -0700 (PDT)
Date:   Fri, 31 Mar 2023 07:08:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331070818.2792558-1-yosryahmed@google.com>
Subject: [PATCH v3 0/3] Ignore non-LRU-based reclaim in memcg reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Upon running some proactive reclaim tests using memory.reclaim, we
noticed some tests flaking where writing to memory.reclaim would be
successful even though we did not reclaim the requested amount fully.
Looking further into it, I discovered that *sometimes* we over-report
the number of reclaimed pages in memcg reclaim.

Reclaimed pages through other means than LRU-based reclaim are tracked
through reclaim_state in struct scan_control, which is stashed in
current task_struct. These pages are added to the number of reclaimed
pages through LRUs. For memcg reclaim, these pages generally cannot be
linked to the memcg under reclaim and can cause an overestimated count
of reclaimed pages. This short series tries to address that.

Patches 1-2 are just refactoring, they add helpers that wrap some
operations on current->reclaim_state, and rename
reclaim_state->reclaimed_slab to reclaim_state->reclaimed.

Patch 3 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
The pages are uncharged anyway, so even if we end up under-reporting
reclaimed pages we will still succeed in making progress during
charging.

Do not let the diff stat deceive you, the core of this series is patch 3,
which has one line of code change. All the rest is refactoring and one
huge comment.

v2 -> v3:
- Fixed a compilation problem in patch 2 reported by the bot.
- Rebased on top of v6.3-rc2.

v1 -> v2:
- Renamed report_freed_pages() to mm_account_reclaimed_pages(), as
  suggested by Dave Chinner. There were discussions about leaving
  updating current->reclaim_state open-coded as it's not worth hiding
  the current dereferencing to remove one line, but I'd rather have the
  logic contained with mm/vmscan.c so that the next person that changes
  this logic doesn't have to change 7 different files.
- Renamed add_non_vmscan_reclaimed() to flush_reclaim_state() (Johannes
  Weiner).
- Added more context about how this problem was found in the cover
  letter (Johannes Weiner).
- Added a patch to move set_task_reclaim_state() below the definition of
  cgroup_reclaim(), and added additional helpers in the same position.
  This way all the helpers for reclaim_state live together, and there is
  no need to declare cgroup_reclaim() early or move its definition
  around to call it from flush_reclaim_state(). This should also fix the
  build error reported by the bot in !CONFIG_MEMCG.

RFC -> v1:
- Exported report_freed_pages() in case XFS is built as a module (Matthew
  Wilcox).
- Renamed reclaimed_slab to reclaim in previously missed MGLRU code.
- Refactored using reclaim_state to update sc->nr_reclaimed into a
  helper and added an XL comment explaining why we ignore
  reclaim_state->reclaimed in memcg reclaim (Johannes Weiner).

Yosry Ahmed (3):
  mm: vmscan: move set_task_reclaim_state() after cgroup_reclaim()
  mm: vmscan: refactor updating reclaimed pages in reclaim_state
  mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim

 fs/inode.c           |  3 +-
 fs/xfs/xfs_buf.c     |  3 +-
 include/linux/swap.h |  5 ++-
 mm/slab.c            |  3 +-
 mm/slob.c            |  6 +--
 mm/slub.c            |  5 +--
 mm/vmscan.c          | 88 +++++++++++++++++++++++++++++++++++---------
 7 files changed, 81 insertions(+), 32 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

