Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3216B1090
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCHSCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 13:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCHSCO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:02:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888EC643B
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 10:02:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ay14so65409406edb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678298521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4ti/z/gy4KrrUZTxjXuzAZhonovpT4J/QPkichvLcg=;
        b=OW1g/V0ZnHiKXAAuMa/g45YdvNwqsGqpiHla8THv1YDkaz9IQf8iPFIObghMKUFgBj
         h8GtlHUimui34LY3Y3Yhe6QRBKAt/Dr6/Jd90I8NldNmylmZxWLj7uNbuuqlnijZ0P96
         qtl80rYWk1BPt88b1z9CICrJySHOMZj0S3ut4xWVeXTnG4KJd/dsdexjxmkhE95SVhKf
         G175FTaGfT9s6k/ogCXBil6pCss3RH49Zo23fV0QmslbdRaXkFb6m0lq7yOB92BPL0ox
         +D+9dCp92uwM+0RLJP4aHz8vBs2sWYdEHW+2L1M6bMCifCyHZTacFulKwTtQcE87im6B
         Ts+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4ti/z/gy4KrrUZTxjXuzAZhonovpT4J/QPkichvLcg=;
        b=tP5dGqPoIaMXSsKrVcSEeJZhy+TYulIXBDqj/tZhJfCmMOjZtXUWhGmGX/eTGmwKin
         5gcuBG+ofZpllQeNBcdIlt/zW0IRXniYK4Xp4aJa/2BOK4QLFrKFrlpplt71bfASKZSY
         bSwDYH7rEz3XNPuxRoOamovzEXbvhpJUzrgOjqpLylB2CbIU7mtkg9LPDEG6Fv+EhJ4+
         5oTfnul9XQlNhARDkizQbOop/k/SQX4DYHIpwAwHUPk3F99OKzb5XkV8hZmg+eL0F22h
         VpPULVGBeBV2qIIK8PENCFvX0wfJWI2zBWaUi1+e1EnoL37TK6i/P2DRjZWZ5ZD97VzS
         IR3w==
X-Gm-Message-State: AO0yUKWA9bKQxeCmkWJuCdtMQghxCagbciPZYa1TgHcZAp+DIQA+KpsG
        BpXLCCV/Y8JqPWmFuLOF0qANupZxbsaNH6M//GtqeA==
X-Google-Smtp-Source: AK7set8/jHpN5Gwo1YgmZIy+zhgP7w+9nthoGIsgE3sW+C9piQ9Y5z41ZNW8GzKbj+B/VAuIXkh35VxKjD5xkPj0xyg=
X-Received: by 2002:a17:906:1618:b0:8b3:8147:6b6e with SMTP id
 m24-20020a170906161800b008b381476b6emr8727807ejd.10.1678298520898; Wed, 08
 Mar 2023 10:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20230228085002.2592473-1-yosryahmed@google.com> <20230308160056.GA414058@cmpxchg.org>
In-Reply-To: <20230308160056.GA414058@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Mar 2023 10:01:24 -0800
Message-ID: <CAJD7tka=6b-U3m0FdMoP=9nC8sYuJ9thghb9muqN5hQ5ZMrDag@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 8, 2023 at 8:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> Hello Yosry,
>
> On Tue, Feb 28, 2023 at 08:50:00AM +0000, Yosry Ahmed wrote:
> > Reclaimed pages through other means than LRU-based reclaim are tracked
> > through reclaim_state in struct scan_control, which is stashed in
> > current task_struct. These pages are added to the number of reclaimed
> > pages through LRUs. For memcg reclaim, these pages generally cannot be
> > linked to the memcg under reclaim and can cause an overestimated count
> > of reclaimed pages. This short series tries to address that.
>
> Could you please add more details on how this manifests as a problem
> with real workloads?

We haven't observed problems in production workloads, but we have
observed problems in testing using memory.reclaim when sometimes a
write to memory.reclaim would succeed when we didn't fully reclaim the
requested amount. This leads to tests flaking sometimes, and we have
to look into the failures to find out if there is a real problem or
not.

>
> > Patch 1 is just refactoring updating reclaim_state into a helper
> > function, and renames reclaimed_slab to just reclaimed, with a comment
> > describing its true purpose.
>
> Looking through the code again, I don't think these helpers add value.
>
> report_freed_pages() is fairly vague. Report to who? It abstracts only
> two lines of code, and those two lines are more descriptive of what's
> happening than the helper is. Just leave them open-coded.

I agree the name is not great, I am usually bad at naming things and
hope people would point that out (like you're doing now). The reason I
added it is to contain the logic within mm/vmscan.c such that future
changes do not have to add noisy diffs to a lot of unrelated files. If
you have a better name that makes more sense to you please let me
know, otherwise I'm fine dropping the helper as well, no strong
opinions here.

>
> add_non_vmanscan_reclaimed() may or may not add anything. But let's
> take a step back. It only has two callsites because lrugen duplicates
> the entire reclaim implementation, including the call to shrink_slab()
> and the transfer of reclaim_state to sc->nr_reclaimed.
>
> IMO the resulting code would overall be simpler, less duplicative and
> easier to follow if you added a common shrink_slab_reclaim() that
> takes sc, handles the transfer, and documents the memcg exception.

IIUC you mean something like:

void shrink_slab_reclaim(struct scan_control *sc, pg_data_t *pgdat,
struct mem_cgroup *memcg)
{
    shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);

    /* very long comment */
    if (current->reclaim_state && !cgroup_reclaim(sc)) {
        sc->nr_reclaimed +=3D current->reclaim_state->reclaimed;
        current->reclaim_state->reclaimed =3D 0;
    }
}

The difference would be that today we handle the transfer once after
we scan all memcgs in classic lruvec, while we do the transfer once
per-memcg in lrugen. With this change, we would be doing the transfer
once per-memcg for both, but I guess that's not a big deal.

What I don't like about this is that it doubles down on associating
the counter in reclaim_state with slab, which is the opposite of what
patch 1 does (renaming reclaimed_slab to just reclaimed). If we do
this, maybe it's better from a consistency perspective to leave it as
reclaimed_slab, with a comment announcing that this is mainly used for
slab, but others are piggybacking on it. It seems like whatever we do
is not going to be ideal in this case, but we should at least be
consistent. Either add shrink_slab_reclaim(), leave it as
reclaimed_slab and call out other users as piggybackers -- or make it
generic and separate from slab completely, with a separate helper to
do the transfer.

I do not have a strong opinion here, so let me know what you prefer.
