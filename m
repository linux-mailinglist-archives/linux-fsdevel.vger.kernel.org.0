Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF046C5DC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 05:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCWEG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 00:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWEGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:06:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1EE1F5EF
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 21:06:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b20so48381243edd.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZdX0zzJKzWZ5XKjbLc+5SlxbkCswtENUW050E1wjGk=;
        b=YNVfINBm00Zd995dBeW0DDRzCfNhhwl3o+PiaTu4txCBPHZK4brFWKhX4BF6It/Wsb
         EPmopGFmlzfTAKS0dL++bEqFLsD4ToXQ44j6Wiv7sYiYv4Hy9/oxcmuOQK9AswHVWWpf
         rj4gX/+U0Onw1Qy4W6+3hbQAaD8Ch74ehfibMziF7Ti3W4x5svk5HFhyO8xyukr6OzmW
         Yav3yfqQKDe5KvKW5D5Ke2cfLkMwF0rG8SPKOfcygshjyGBWOBvW+cuSnZNJtsKcY+e1
         /+Q2LwJu+2BsdXDdc2MlqSoJx+rapqg+0IbXcrAi7lnd5x8c6xqrSXzG1jdKw8q8RhUQ
         Cg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZdX0zzJKzWZ5XKjbLc+5SlxbkCswtENUW050E1wjGk=;
        b=rltSUcLp2A9bC+SREo4jBzYlpHfUa+FJ9uT22NFM7K3z3Sg09euMt2jMI7HjegWbJy
         4ZKKb+gxrYj6De38jl1kkL+Ejnu6o5zsRz/PbP7XwzYwsAexaezNAGE2k099SiAStZ3G
         bkkzyR1tGknCeXSvBjikxcnqfxEFV3Vh6qx0HHEbitlMl5/CQMtmUn+rvmbfPL9CnAhB
         XnpA1d/uH+pc9Dq2OGsa137QQynXwNI9fSzdB72HkHE3Xhwj2zBPzbtFYWXduq9HPmvR
         J4HDMyj1FSxh8viyum2+1f1OdjAoSVGUW0hvGs5CwGqSJcw9GMG+zCBrPTyIhnAFlKMl
         aF5A==
X-Gm-Message-State: AO0yUKW6+jYWaXV+NzyOFyua6RviX+hFW45rIB4vt09BvkkryRlXt+V4
        vFfp73i/mhpc2qL8rssNU96jMUDgZmSMF4mQshK+Uw==
X-Google-Smtp-Source: AK7set/x0L6xL2vwQegBkGdVFVaSfGgafJFSRErVoiwJ/47Q3xkJsCVmfJEwHU4RiRF1MtOBxUxN57yV/jIPR3Fyiwc=
X-Received: by 2002:a50:cc9b:0:b0:4fa:d8aa:74ad with SMTP id
 q27-20020a50cc9b000000b004fad8aa74admr4544724edi.8.1679544381396; Wed, 22 Mar
 2023 21:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230309093109.3039327-1-yosryahmed@google.com>
In-Reply-To: <20230309093109.3039327-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 22 Mar 2023 21:05:45 -0700
Message-ID: <CAJD7tkY-S-v117nYuQN7=3cte+kv0QgMa2B-NgOf6bH8bm1XbQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Ignore non-LRU-based reclaim in memcg reclaim
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Any thoughts on this respin?

On Thu, Mar 9, 2023 at 1:31=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Upon running some proactive reclaim tests using memory.reclaim, we
> noticed some tests flaking where writing to memory.reclaim would be
> successful even though we did not reclaim the requested amount fully.
> Looking further into it, I discovered that *sometimes* we over-report
> the number of reclaimed pages in memcg reclaim.
>
> Reclaimed pages through other means than LRU-based reclaim are tracked
> through reclaim_state in struct scan_control, which is stashed in
> current task_struct. These pages are added to the number of reclaimed
> pages through LRUs. For memcg reclaim, these pages generally cannot be
> linked to the memcg under reclaim and can cause an overestimated count
> of reclaimed pages. This short series tries to address that.
>
> Patches 1-2 are just refactoring, they add helpers that wrap some
> operations on current->reclaim_state, and rename
> reclaim_state->reclaimed_slab to reclaim_state->reclaimed.
>
> Patch 3 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
> The pages are uncharged anyway, so even if we end up under-reporting
> reclaimed pages we will still succeed in making progress during
> charging.
>
> Do not let the diff stat deceive you, the core of this series is patch 3,
> which has one line of code change. All the rest is refactoring and one
> huge comment.
>
> v1 -> v2:
> - Renamed report_freed_pages() to mm_account_reclaimed_pages(), as
>   suggested by Dave Chinner. There were discussions about leaving
>   updating current->reclaim_state open-coded as it's not worth hiding
>   the current dereferencing to remove one line, but I'd rather have the
>   logic contained with mm/vmscan.c so that the next person that changes
>   this logic doesn't have to change 7 different files.
> - Renamed add_non_vmscan_reclaimed() to flush_reclaim_state() (Johannes
>   Weiner).
> - Added more context about how this problem was found in the cover
>   letter (Johannes Weiner).
> - Added a patch to move set_task_reclaim_state() below the definition of
>   cgroup_reclaim(), and added additional helpers in the same position.
>   This way all the helpers for reclaim_state live together, and there is
>   no need to declare cgroup_reclaim() early or move its definition
>   around to call it from flush_reclaim_state(). This should also fix the
>   build error reported by the bot in !CONFIG_MEMCG.
>
> RFC -> v1:
> - Exported report_freed_pages() in case XFS is built as a module (Matthew
>   Wilcox).
> - Renamed reclaimed_slab to reclaim in previously missed MGLRU code.
> - Refactored using reclaim_state to update sc->nr_reclaimed into a
>   helper and added an XL comment explaining why we ignore
>   reclaim_state->reclaimed in memcg reclaim (Johannes Weiner).
>
> Yosry Ahmed (3):
>   mm: vmscan: move set_task_reclaim_state() after cgroup_reclaim()
>   mm: vmscan: refactor updating reclaimed pages in reclaim_state
>   mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
>
>  fs/inode.c           |  3 +-
>  fs/xfs/xfs_buf.c     |  3 +-
>  include/linux/swap.h |  5 ++-
>  mm/slab.c            |  3 +-
>  mm/slob.c            |  6 +--
>  mm/slub.c            |  5 +--
>  mm/vmscan.c          | 88 +++++++++++++++++++++++++++++++++++---------
>  7 files changed, 81 insertions(+), 32 deletions(-)
>
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
