Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17116B12CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 21:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCHURK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 15:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCHURJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:17:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1521D13D4
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 12:16:36 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l13so19501593qtv.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 12:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678306591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+jvBsh7LbTE3BBTYqkpZsR8VusiDvh1HfdbNeXAcFCM=;
        b=yag6FV13Ig3iSSTEMkdIaAry85Fcek0dOQvKFYaXiOTLwD+yt6xwMobzPBqyyGuwnE
         x6e9O75UrWI/EhG/hKB+SoRid6lJd6jsVqgogeJ+M/KLtcDOy+1wiyLRFJZdMhJZuy67
         4cFEH9iJ9rt78ebthg4KuViKITwgGrKIBZfVtg4jejfD3NJfBZlWyLRWfKCiUUDJhk3M
         AUZ91ZRAELBUgAwYSmxyn+R9LKXstzdhXdS3aCt/AcIFxXpwEhx/C4JnoPSVrsWtp56O
         Pw7f9hyfXpo61FvfHLR2VrxrczLUh00iJJPQPGLxSGZhaRQbITAln0l3Io0L2LGlMTqm
         z49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678306591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jvBsh7LbTE3BBTYqkpZsR8VusiDvh1HfdbNeXAcFCM=;
        b=puCRndmCnci50H3laxjm5iam94EePsELc+A5m1wlyLVdZGgtKgxBehHzkq0Genx5+v
         sEmigWyguVD4w59h/cvnUA2Lb0c0JxDliFuTzhlM0mEBsNhR/4FK+j9XgX4kG8KFfdi5
         nf1BRKQyeZY5koFCp3H6L46gLKCS4SsDi/CkHRmCE7C6S4+L5rEstVD+9n3HXTC+785P
         9ZhfRdwu5El1uNCDuuheFmvJHUviOz6K1AzBgVcM14gEyDK26g+jv8RddG4aMEmHfqK1
         gHF7EaBFzdnKHappepe4QJcWfpwbJHcDDHMiuYBEGYCtVPoZfLhZlfRUEyyLlCHscgtL
         vs1g==
X-Gm-Message-State: AO0yUKUR7maHyocyr402Lqit5rUrK4RxjoVsTXglnNCj2T+YaUoyyBn4
        +myo0sXTTmlMhU5DgZNQYbk7ew==
X-Google-Smtp-Source: AK7set/wqHwokeLnuFtipo28PT4sjFacv/VxOQnhvXvVV+Nsg7Ki3HCu1cum2w+Q3/hSnb/ROYu+7w==
X-Received: by 2002:ac8:4e94:0:b0:3bf:c085:e953 with SMTP id 20-20020ac84e94000000b003bfc085e953mr25211678qtp.24.1678306590929;
        Wed, 08 Mar 2023 12:16:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:d32c])
        by smtp.gmail.com with ESMTPSA id m8-20020aed27c8000000b003bfc355c3a6sm12285754qtg.80.2023.03.08.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:16:30 -0800 (PST)
Date:   Wed, 8 Mar 2023 15:16:29 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
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
Subject: Re: [PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
Message-ID: <20230308201629.GB476158@cmpxchg.org>
References: <20230228085002.2592473-1-yosryahmed@google.com>
 <20230308160056.GA414058@cmpxchg.org>
 <CAJD7tka=6b-U3m0FdMoP=9nC8sYuJ9thghb9muqN5hQ5ZMrDag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka=6b-U3m0FdMoP=9nC8sYuJ9thghb9muqN5hQ5ZMrDag@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:01:24AM -0800, Yosry Ahmed wrote:
> On Wed, Mar 8, 2023 at 8:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Hello Yosry,
> >
> > On Tue, Feb 28, 2023 at 08:50:00AM +0000, Yosry Ahmed wrote:
> > > Reclaimed pages through other means than LRU-based reclaim are tracked
> > > through reclaim_state in struct scan_control, which is stashed in
> > > current task_struct. These pages are added to the number of reclaimed
> > > pages through LRUs. For memcg reclaim, these pages generally cannot be
> > > linked to the memcg under reclaim and can cause an overestimated count
> > > of reclaimed pages. This short series tries to address that.
> >
> > Could you please add more details on how this manifests as a problem
> > with real workloads?
> 
> We haven't observed problems in production workloads, but we have
> observed problems in testing using memory.reclaim when sometimes a
> write to memory.reclaim would succeed when we didn't fully reclaim the
> requested amount. This leads to tests flaking sometimes, and we have
> to look into the failures to find out if there is a real problem or
> not.

Ah, that would be great to have in the cover letter. Thanks!

Have you also tested this patch against prod without memory.reclaim?
Just to make sure there are no problems with cgroup OOMs or
similar. There shouldn't be, but, you know...

> > > Patch 1 is just refactoring updating reclaim_state into a helper
> > > function, and renames reclaimed_slab to just reclaimed, with a comment
> > > describing its true purpose.
> >
> > Looking through the code again, I don't think these helpers add value.
> >
> > report_freed_pages() is fairly vague. Report to who? It abstracts only
> > two lines of code, and those two lines are more descriptive of what's
> > happening than the helper is. Just leave them open-coded.
> 
> I agree the name is not great, I am usually bad at naming things and
> hope people would point that out (like you're doing now). The reason I
> added it is to contain the logic within mm/vmscan.c such that future
> changes do not have to add noisy diffs to a lot of unrelated files. If
> you have a better name that makes more sense to you please let me
> know, otherwise I'm fine dropping the helper as well, no strong
> opinions here.

I tried to come up with something better, but wasn't happy with any of
the options, either. So I defaulted to just leaving it alone :-)

It's part of the shrinker API and the name hasn't changed since the
initial git import of the kernel tree. It should be fine, churn-wise.

> > add_non_vmanscan_reclaimed() may or may not add anything. But let's
> > take a step back. It only has two callsites because lrugen duplicates
> > the entire reclaim implementation, including the call to shrink_slab()
> > and the transfer of reclaim_state to sc->nr_reclaimed.
> >
> > IMO the resulting code would overall be simpler, less duplicative and
> > easier to follow if you added a common shrink_slab_reclaim() that
> > takes sc, handles the transfer, and documents the memcg exception.
> 
> IIUC you mean something like:
> 
> void shrink_slab_reclaim(struct scan_control *sc, pg_data_t *pgdat,
> struct mem_cgroup *memcg)
> {
>     shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
> 
>     /* very long comment */
>     if (current->reclaim_state && !cgroup_reclaim(sc)) {
>         sc->nr_reclaimed += current->reclaim_state->reclaimed;
>         current->reclaim_state->reclaimed = 0;
>     }
> }

Sorry, I screwed up, that doesn't actually work.

reclaim_state is used by buffer heads freed in shrink_folio_list() ->
filemap_release_folio(). So flushing the count cannot be shrink_slab()
specific. Bummer. Your patch had it right by making a helper for just
flushing the reclaim state. But add_non_vmscan_reclaimed() is then
also not a great name because these frees are directly from vmscan.

Maybe simply flush_reclaim_state()?

As far as the name reclaimed_slab, I agree it's not optimal, although
90% accurate ;-) I wouldn't mind a rename to just 'reclaimed'.
