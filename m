Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6E203697
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 14:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFVMSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgFVMSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:18:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC99C061794;
        Mon, 22 Jun 2020 05:18:45 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so19124938iow.8;
        Mon, 22 Jun 2020 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NnnUq7IDM5JBt1ImQ/OjPFJfNxXcY93InCMyrjtZ290=;
        b=ikvG2saPdMZV4cfjCRwp/G2LB7jCvMpt662Yu9i6rI0YHjp5bDUqeEIKy3yoKdTxS7
         XbbLi53IKeoGp68qjlGFaud6eRMulBJXUSxRCGZdvN30o2U4PXkShmPNBEkr0QgBqaHJ
         MKaHLD66/+33XnmKJ7pXRf7RXer463IUuO2wSpiHGd66yPoQfEb50RYYxBxFMSIq62EU
         MEEVrpJ6qnAbkbiPjtPVJUfHliA263Yep+pVCKlUqbXfCInRo3UObAkvbzGhzC+/kN7l
         SlwKusgSg3fTeC7zaHEJUFY79DmMGXO3MQ9FgvjiB4cV5HVCynKMp7BgMCitORiOlxFj
         9ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NnnUq7IDM5JBt1ImQ/OjPFJfNxXcY93InCMyrjtZ290=;
        b=sV5biYm3+RIRwnpjWPD/pkVKngqV7+N4EVsdwQml00tRyRMJTslmx+SlLCOzDS2ugN
         ghFBvYsdvv28/CozJK1pE30gax/nZhn0Acq4ANZ3BWmlBcZDZsqsK4IPQDzCpobOD+al
         62aOf7Fz+D1ackYVgocm2OlnIBPzk/eH1NqTOkfZi/onAI4y3CBOP8OXxLPRr70oe5GG
         w7i8uHDeCo1JoJVtUFI1C5VVHVU8kYKYEnDq5XF4uA/C2z5hKbYNLxM51kDp0WbAz8jr
         ObVqW4Xfoc+Fkbz8Q6f/rewGDNMBBsH6kBKnJ7KS3lltXF+hkeTaZLj0Ot8cgsal6z69
         fbpA==
X-Gm-Message-State: AOAM533Vh6oZyUDZ02Zzj6JMV8xVZa5mNbV1ADFkdtsr8RSEL6racAyN
        KY6pr1eFCbMAeXxa6UW+9+8RUmnwgrCobnPpaHE=
X-Google-Smtp-Source: ABdhPJxadLIziS5uohvCIOR68jQvCAvSv5nSdvq8coWAw3esyDudVrgXH1a6H4R7rNjGzoCoiW0wNCI8oIjjAML6k+k=
X-Received: by 2002:a05:6638:31b:: with SMTP id w27mr5030526jap.109.1592828324988;
 Mon, 22 Jun 2020 05:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <1592637174-19657-1-git-send-email-laoar.shao@gmail.com> <20200621230420.GT2005@dread.disaster.area>
In-Reply-To: <20200621230420.GT2005@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 22 Jun 2020 20:18:09 +0800
Message-ID: <CALOAHbDaDVXjfeYL8TqkTFzSnnQvYV2aKTiKC25UBdcUBdvB9A@mail.gmail.com>
Subject: Re: [PATCH] xfs: reintroduce PF_FSTRANS for transaction reservation
 recursion protection
To:     Dave Chinner <david@fromorbit.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 7:04 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Jun 20, 2020 at 03:12:54AM -0400, Yafang Shao wrote:
> > PF_FSTRANS which is used to avoid transaction reservation recursion, is
> > dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> > PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> > memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> > means to avoid filesystem reclaim recursion. That change is subtle.
> > Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> > PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> > PF_MEMALLOC_NOFS is not proper.
> >
> > Bellow comment is quoted from Dave,
> > > It wasn't for memory allocation recursion protection in XFS - it was for
> > > transaction reservation recursion protection by something trying to flush
> > > data pages while holding a transaction reservation. Doing
> > > this could deadlock the journal because the existing reservation
> > > could prevent the nested reservation for being able to reserve space
> > > in the journal and that is a self-deadlock vector.
> > > IOWs, this check is not protecting against memory reclaim recursion
> > > bugs at all (that's the previous check [1]). This check is
> > > protecting against the filesystem calling writepages directly from a
> > > context where it can self-deadlock.
> > > So what we are seeing here is that the PF_FSTRANS ->
> > > PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> > > about what type of error this check was protecting against.
> >
> > Besides reintroducing PF_FSTRANS, there're some other improvements in this
> > patch,
> > - Remove useless MACRO current_clear_flags_nested(), current_pid() and
> >   current_test_flags().
> > - Remove useless memalloc_nofs_{save, restore} in __kmem_vmalloc()
> >
> > [1]. Bellow check is to avoid memory reclaim recursion.
> > if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> >       PF_MEMALLOC))
> >       goto redirty;
> >
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c    |  4 ++--
> >  fs/xfs/kmem.c             |  7 -------
> >  fs/xfs/kmem.h             |  2 +-
> >  fs/xfs/libxfs/xfs_btree.c |  2 +-
> >  fs/xfs/xfs_aops.c         |  4 ++--
> >  fs/xfs/xfs_linux.h        |  4 ----
> >  fs/xfs/xfs_trans.c        | 12 ++++++------
> >  include/linux/sched.h     |  1 +
> >  8 files changed, 13 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index bcfc288..0f1945c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1500,9 +1500,9 @@ static void iomap_writepage_end_bio(struct bio *bio)
> >
> >       /*
> >        * Given that we do not allow direct reclaim to call us, we should
> > -      * never be called in a recursive filesystem reclaim context.
> > +      * never be called while in a filesystem transaction.
> >        */
> > -     if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > +     if (WARN_ON_ONCE(current->flags & PF_FSTRANS))
> >               goto redirty;
>
> This is OK, but the rest of the patch is not.
>
> I did not say "replace all XFS use of GFP_NOFS/KM_NOFS with
> PF_TRANS", which is what this patch does. The use of
> PF_MEMALLOC_NOFS within transactions is correct and valid and needs
> to remain. Replacing this with PF_FSTRANS effectively reverts all
> the simplifications and obviously self-documneting code that
> PF_MEMALLOC_NOFS provides us with.
>

Sorry about that, I misunderstood it. Will correct it in the next version.

> IOWs, PF_MEMALLOC_NOFS is used to indicate that this is a "no
> reclaim recursion" path and so it's use remains completely unchanged
> in XFS. PF_FSTRANS is to indicate this is a "no
> transaction recursion" path, which is a different thing and needs
> it's own specific annotation.
>

Thanks for the explanation.

> > diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> > index f136647..9875a23 100644
> > --- a/fs/xfs/kmem.c
> > +++ b/fs/xfs/kmem.c
> > @@ -41,18 +41,11 @@
> >  static void *
> >  __kmem_vmalloc(size_t size, xfs_km_flags_t flags)
> >  {
> > -     unsigned nofs_flag = 0;
> >       void    *ptr;
> >       gfp_t   lflags = kmem_flags_convert(flags);
> >
> > -     if (flags & KM_NOFS)
> > -             nofs_flag = memalloc_nofs_save();
> > -
> >       ptr = __vmalloc(size, lflags);
> >
> > -     if (flags & KM_NOFS)
> > -             memalloc_nofs_restore(nofs_flag);
> > -
>
> This breaks both kmem_alloc_large() and kmem_alloc_io() if they are
> called from an explicit KM_NOFS context. vmalloc() does not respect
> the gfp flags that are passed to it and will always do GFP_KERNEL
> allocations deep down in the page table allocation code, and hence
> we must use memalloc_nofs_save() here if called in a KM_NOFS
> context.
>

I thought kmem_flags_convert() has already checked KM_NOFS so we don't
need to call memalloc_nofs_save(), but it seems I was wrong.
Thanks for the clarification.


> >       return ptr;
> >  }
> >
> > diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> > index 34cbcfd..ccc63de 100644
> > --- a/fs/xfs/kmem.h
> > +++ b/fs/xfs/kmem.h
> > @@ -34,7 +34,7 @@
> >       BUG_ON(flags & ~(KM_NOFS | KM_MAYFAIL | KM_ZERO | KM_NOLOCKDEP));
> >
> >       lflags = GFP_KERNEL | __GFP_NOWARN;
> > -     if (flags & KM_NOFS)
> > +     if (current->flags & PF_FSTRANS || flags & KM_NOFS)
> >               lflags &= ~__GFP_FS;
>
> No. If we are in a transaction context, PF_MEMALLOC_NOFS should be
> set. We got rid of all the PF_FSTRANS checks out of this code by
> moving to PF_MEMALLOC_NOFS, reverting this isn't an improvement.
>

Got it. Thanks.

> >
> >       /*
> > diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> > index 2d25bab..65d0afe 100644
> > --- a/fs/xfs/libxfs/xfs_btree.c
> > +++ b/fs/xfs/libxfs/xfs_btree.c
> > @@ -2814,7 +2814,7 @@ struct xfs_btree_split_args {
> >       struct xfs_btree_split_args     *args = container_of(work,
> >                                               struct xfs_btree_split_args, work);
> >       unsigned long           pflags;
> > -     unsigned long           new_pflags = PF_MEMALLOC_NOFS;
> > +     unsigned long           new_pflags = PF_FSTRANS;
>
>         new_pflags = PF_MEMALLOC_NOFS | PF_FSTRANS;
> >
> >       /*
> >        * we are in a transaction context here, but may also be doing work
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index b356118..02733eb 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -62,7 +62,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
> >        * We hand off the transaction to the completion thread now, so
> >        * clear the flag here.
> >        */
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     current_restore_flags_nested(&tp->t_pflags, PF_FSTRANS);
>
>         current_restore_flags_nested(PF_MEMALLOC_NOFS | PF_FSTRANS);
>

Thanks

> >       return 0;
> >  }
> >
> > @@ -125,7 +125,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
> >        * thus we need to mark ourselves as being in a transaction manually.
> >        * Similarly for freeze protection.
> >        */
> > -     current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     current_set_flags_nested(&tp->t_pflags, PF_FSTRANS);
>
>         current_set_flags_nested(PF_MEMALLOC_NOFS | PF_FSTRANS);
>

Thanks

> >       __sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
> >
> >       /* we abort the update if there was an IO error */
> > diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> > index 9f70d2f..ab737fe 100644
> > --- a/fs/xfs/xfs_linux.h
> > +++ b/fs/xfs/xfs_linux.h
> > @@ -102,12 +102,8 @@
> >  #define xfs_cowb_secs                xfs_params.cowb_timer.val
> >
> >  #define current_cpu()                (raw_smp_processor_id())
> > -#define current_pid()                (current->pid)
> > -#define current_test_flags(f)        (current->flags & (f))
> >  #define current_set_flags_nested(sp, f)              \
> >               (*(sp) = current->flags, current->flags |= (f))
> > -#define current_clear_flags_nested(sp, f)    \
> > -             (*(sp) = current->flags, current->flags &= ~(f))
> >  #define current_restore_flags_nested(sp, f)  \
> >               (current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
>
> Separate cleanup patch to remove unrelated definitions, please.
>

Sure, I will.

> > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > index 3c94e5f..1c1b982 100644
> > --- a/fs/xfs/xfs_trans.c
> > +++ b/fs/xfs/xfs_trans.c
> > @@ -153,7 +153,7 @@
> >       bool                    rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
> >
> >       /* Mark this thread as being in a transaction */
> > -     current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     current_set_flags_nested(&tp->t_pflags, PF_FSTRANS);
> >
>
> And, again, PF_FSTRANS | PF_MEMALLOC_NOFS through this code.
>

Thanks



-- 
Thanks
Yafang
