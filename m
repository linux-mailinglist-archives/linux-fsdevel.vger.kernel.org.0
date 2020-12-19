Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850C92DEC71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 01:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgLSAdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 19:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgLSAdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 19:33:15 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57572C0617B0;
        Fri, 18 Dec 2020 16:32:35 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q1so3813394ilt.6;
        Fri, 18 Dec 2020 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JitJkpTV7wl8VuDaQVYn0aa0uVhFO5sQBwVgoYVnyaU=;
        b=EoIrf+fAqP4bq73P7dx0uRYKhuSFnNrbh1V1wdoor8DAFaSGqhsdhx5VxKiaHFoopi
         ETZEwHQqlM08+pYLmZDtwcuUADxnGmCc8OImoRyuGGrBOmL/66NQkQFJP6KHJTY38tkB
         TGA1GmYVNKUkfCU6I9Xt3/7/P4/QuqFBPCEos+g+Zsr8iZ3zyfQVKmNaaOl7kfhAaguT
         NYul5WXE/9m7GtPz8hR8w8rTaSA7zJn2zLPR9C48JOIcdpP2FdnsLPzvn6AIUPmM90dI
         itr43/LbBzmkAOjH2LLZh9CdOaeIYtCCV69Jk6DqooG4cb3+O3nuAUOJKVSjEm1o72YU
         Htwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JitJkpTV7wl8VuDaQVYn0aa0uVhFO5sQBwVgoYVnyaU=;
        b=XiYf2X0NpE6H1nU2rcjbXCaNoTx8D8GQy48B2pKlPcpQBQWgS02yT3OolrsmQZ6Rqb
         G68Q3IFmIF2Ft5pwTx05fNN3d1W1QvtfbO/WVepyevRdzzPJVGDxzuwcIePOxv8XTfqP
         FF9TZB7geV1UIJktfiujVm0KeN5oswNeY587yjD+ECDwl91FbxHZcE1Wopi4x9TeWjQw
         lFGWS3DbfElQm34L7hkVuYEGe852YWo/zhBP3AVYzVtQJWJjf7SiB5VBiUyOHTx8nV0d
         TDa1sLZDl0pmkmtMuEGBV9/AR55GK25g6gzmcOLQA2Q7iW4tMCe73YZDD/sFtFOAk59N
         R5zg==
X-Gm-Message-State: AOAM531JtBPEgCD7MNLZBkKk59faEZzyFWsrtIMWykH7wdu/1AnIJM0e
        gK1LsxSoqbcbAqUaVwlg9UDO6OkxZ++xOCDoc9k=
X-Google-Smtp-Source: ABdhPJzBhTlloThFSbngFUSOPAeYALZjLbpAe0za2X9hBcKTdxptneepWBoejNXqYFr1PxGnGFPWlotevXhOJRLtZRY=
X-Received: by 2002:a05:6e02:c32:: with SMTP id q18mr6716194ilg.203.1608337954743;
 Fri, 18 Dec 2020 16:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20201217011157.92549-1-laoar.shao@gmail.com> <20201217011157.92549-4-laoar.shao@gmail.com>
 <20201217221509.GQ632069@dread.disaster.area> <20201217230627.GB6911@magnolia>
 <20201218000705.GR632069@dread.disaster.area>
In-Reply-To: <20201218000705.GR632069@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 19 Dec 2020 08:31:58 +0800
Message-ID: <CALOAHbAAJSU5xZiNktX=z4-SHF6=xY4z8H1+VggSttFcgDeMHQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 8:07 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Dec 17, 2020 at 03:06:27PM -0800, Darrick J. Wong wrote:
> > On Fri, Dec 18, 2020 at 09:15:09AM +1100, Dave Chinner wrote:
> > > The obvious solution: we've moved the saved process state to a
> > > different context, so it is no longer needed for the current
> > > transaction we are about to commit. So How about just clearing the
> > > saved state from the original transaction when swappingi like so:
> > >
> > > static inline void
> > > xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> > > {
> > >     ntp->t_pflags = tp->t_pflags;
> > >     tp->t_flags = 0;
> > > }
> > >
> > > And now, when we go to clear the transaction context, we can simply
> > > do this:
> > >
> > > static inline void
> > > xfs_trans_context_clear(struct xfs_trans *tp)
> > > {
> > >     if (tp->t_pflags)
> > >             memalloc_nofs_restore(tp->t_pflags);
> > > }
> > >
> > > and the problem is solved. The NOFS state will follow the active
> > > transaction and not be reset until the entire transaction chain is
> > > completed.
> >
> > Er... correct me if I'm wrong, but I thought t_pflags stores the old
> > state of current->flags from before we call xfs_trans_alloc?  So if we
> > call into xfs_trans_alloc with current->flags==0 and we commit the
> > transaction having not rolled, we won't unset the _NOFS state, and exit
> > back to userspace with _NOFS set.
>
> Minor thinko.
>
> tp->t_pflags only stores a single bit of information w.r.t
> PF_MEMALLOC_NOFS state, not the entire set of current task flags:
> whether it should be cleared or not on a call to
> memalloc_nofs_restore(). See memalloc_nofs_save():
>
> static inline unsigned int memalloc_nofs_save(void)
> {
>         unsigned int flags = current->flags & PF_MEMALLOC_NOFS;
>         current->flags |= PF_MEMALLOC_NOFS;
>         return flags;
> }
>
> So, yeah, I got the t_pflags logic the wrong way around here - zero
> means clear it, non-zero means don't clear it. IOWs, swap:
>
>         ntp->t_pflags = tp->t_pflags;
>         tp->t_flags = -1;
>
> and clear:
>
>         if (!tp->t_flags)
>                 memalloc_nofs_restore(tp->t_pflags);
>
> This should only be temporary code, anyway. The next patch should
> change this state clearing check to use current->journal_info, then
> we aren't dependent on process flags state at all.
>
> > I think the logic is correct here -- we transfer the old pflags value
> > from @tp to @ntp, which effectively puts @ntp in charge of restoring the
> > old pflags value; and then we set tp->t_pflags to current->flags, which
> > means that @tp will "restore" the current pflags value into pflags, which
> > is a nop.
>
> That's pretty much what the current logic guarantees. Once the
> wrappers provide this same guarantee, we can greatly simply the the
> transaction context state management (i.e. set on alloc, swap on
> dup, clear on free). And thread handoffs can just use clear/set
> appropriately.
>

Make sense to me.


-- 
Thanks
Yafang
