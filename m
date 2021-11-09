Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2985844B97E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 00:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhKIX7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 18:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhKIX7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:59:02 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18BC061766
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 15:56:15 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id k21so753542ioh.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 15:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoK2BBW7Jb6r8LW9mP4KvyVyymYNKZIHae58TqDdmjM=;
        b=e62I04EFslO8JvLVvNHAQ9M278/k+EW9C9hQfqvs/2+1DafaBcurjF1Tw40Jotuw+8
         a76hUHEIBUw5sz5N2VC+8FIXdNs5LWOHUchzTowWdzRQ/qhobM2E6HSI8tealG9nyest
         n2XPAp6ghoqcSFzmU+dOTMiMh92xrGfzgVxjnE32SvOSK3UTFa+XyHQAYUb3cuogUoI3
         ktrpsTE3cnwIVA+a7jEVel4GzAXQTy3pA5r5hQezKzGG9mHJiJKuHKaOieoaFn5B8RRJ
         ylafV0ZEx69LyWI/2bXv3H+IPK2Jfx1t20og61f7SXBp24yFlnMaUX9QSaLexn24zRvF
         S8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoK2BBW7Jb6r8LW9mP4KvyVyymYNKZIHae58TqDdmjM=;
        b=8RrPYPftG3dS+i9mgZv4vO7tfv9aOXz6c5SUSQ+zAdaHqUkQjTw06woZA4kxLSbdvj
         aGRHdNsjA6hw3J1a6ZDJTl405E7E6zntUgL2RtV6w1INE0yNIlLAHSzdq41rGFNyf3JG
         251Es4KqibVrNMGnMWEIDR63t+1tdZz1CCUenItNN+0EBalmV2xn2GzqByiUeUMvhnUE
         TpV/5urv++sjI6NUGVzRrSqW7lm03JobDRBOcZoWHtZRk4Ofg8DUcefMPUi3Zz+TFzq3
         6A7YKunBv6AwlrhacAubunLvfw0Z3ddzvUPy0sC+baKyuMDNQvC96vzuTFhr0U4pF/3b
         JwXg==
X-Gm-Message-State: AOAM533B0zTWY825VoLwcxUgr3L1RBQ3XjbM37voKqDmHSMDGPtapfTN
        Nu4z8o4jH0z4aa2/VwQqC+osxVVr0pOrTf1824gwXQ==
X-Google-Smtp-Source: ABdhPJzG072qHQ/0yi0HddSOZXPMaJDZ+ZFS0cuRcHJhcqYNWirO7+r+0gMr2/R+GvX5VWGlK+sRjtiZ3BPsTw10ozg=
X-Received: by 2002:a05:6638:4183:: with SMTP id az3mr431731jab.56.1636502174733;
 Tue, 09 Nov 2021 15:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-2-almasrymina@google.com> <20211108221047.GE418105@dread.disaster.area>
 <YYm1v25dLZL99qKK@casper.infradead.org> <20211109011837.GF418105@dread.disaster.area>
In-Reply-To: <20211109011837.GF418105@dread.disaster.area>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 9 Nov 2021 15:56:03 -0800
Message-ID: <CAHS8izNwX80px5X=JrQAfgTBO5=rCN_hSybLW6T1CWmqG5b7eQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] mm/shmem: support deterministic charging of tmpfs
To:     david@fromorbit.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 8, 2021 at 5:18 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Nov 08, 2021 at 11:41:51PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 09, 2021 at 09:10:47AM +1100, Dave Chinner wrote:
> > > > + rcu_read_lock();
> > > > + memcg = rcu_dereference(mapping->host->i_sb->s_memcg_to_charge);
> > >
> > > Anything doing pointer chasing to obtain static, unchanging
> > > superblock state is poorly implemented. The s_memcg_to_charge value never
> > > changes, so this code should associate the memcg to charge directly
> > > on the mapping when the mapping is first initialised by the
> > > filesystem. We already do this with things like attaching address
> > > space ops and mapping specific gfp masks (i.e
> > > mapping_set_gfp_mask()), so this association should be set up that
> > > way, too (e.g. mapping_set_memcg_to_charge()).
> >
> > I'm not a fan of enlarging struct address_space with another pointer
> > unless it's going to be used by all/most filesystems.  If this is
> > destined to be a shmem-only feature, then it should be in the
> > shmem_inode instead of the mapping.
>
> Neither am I, but I'm also not a fan of the filemap code still
> having to drill through the mapping to the host inode just to check
> if it needs to do special stuff for shmem inodes on every call that
> adds a page to the page cache. This is just as messy and intrusive
> and the memcg code really has no business digging about in the
> filesystem specific details of the inode behind the mapping.
>
> Hmmm. The mem_cgroup_charge() call in filemap_add_folio() passes a
> null mm context, so deep in the guts it ends getting the memcg from
> active_memcg() in get_mem_cgroup_from_mm(). That ends up using
> current->active_memcg, so maybe a better approach here is to have
> shmem override current->active_memcg via set_active_memcg() before
> it enters the generic fs paths and restore it on return...
>
> current_fsmemcg()?
>

Thank you for providing a detailed alternative. To be honest it seems
a bit brittle to me, as in folks can easily add calls to generic fs
paths forgetting to override the active_memcg and having memory
charged incorrectly, but if there is no other option and we want to
make this a shmem-only feature, I can do this anyway.

> > If we are to have this for all filesystems, then let's do that properly
> > and make it generic functionality from its introduction.
>
> Fully agree.

So the tmpfs feature addresses the first 2 usecases I mention in the
cover letter. For the 3rd usecase I will likely need to extend this
support to 1 disk-based filesystem, and I'm not sure which at this
point. It also looks like Roman has in mind 1 or more use cases and
may extend it to other filesystems as a result. I'm hoping that I can
provide the generic implementation and the tmpfs support and in follow
up patches folks can extend this to other file systems by providing
the fs-specific changes needed for that filesystem.

AFAICT with this patch the work to extend to another file system is to
parse the memcg= option in that filesystem, set the s_memcg_to_charge
on the superblock (or mapping) of that filesystem, and to charge
s_memcg_to_charge in fs specific code paths, so all are fs-specific
changes.

Based on this, it seems to me the suggestion is to hang the
memcg_to_charge off the mapping? I'm not sure if *most/all*
filesystems will eventually support it, but likely more than just
tmpfs.




>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
