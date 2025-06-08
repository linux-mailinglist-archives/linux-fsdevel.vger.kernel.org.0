Return-Path: <linux-fsdevel+bounces-50921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32980AD10BA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 03:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7FE188E37F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1974040;
	Sun,  8 Jun 2025 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJ+0fW/l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB42E401
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jun 2025 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749346910; cv=none; b=d8KpG1TRBaKsswMowOFYRqT1rHLXhx8yUKCd6bynFJxIQcVJ/ti2zHCTyg2QPWlZo0PUa7NgDLcrQwqyAJFFdq1uQEpmbt+r3j6usIiQaY/tLgH0g7UMMJT+4BRNLLsSPVxZaOt/80CDHMEM2up3FrDLurPs2RHC+fQ3XuohBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749346910; c=relaxed/simple;
	bh=2//yq73aNJKSgp9E7PvaMRaRPO3rmIq6PmztdTm879U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJFfhVxv7J3HfUJMZr9bDiBofHgQDrDSYY6iNYExYE2sdN9E9KjL96BzisZ9roadGBX24o5aA3+CYI5QyH/DEO30xsvFwxQYHZSyu7D5OKAJW1UKT6ukqVxi8jeu12SH9ZC/Qpcai334p+1VfaAbCK9795FA25y2YnFezIPVLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJ+0fW/l; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5ac8fae12so348961cf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 18:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749346907; x=1749951707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GTi9soOH0gss15/tu50fw9s97WlbXlhLt35zROKtX0=;
        b=AJ+0fW/lyrpnA5dhEowWoCj+yQTOtl8nOvMUIP0v0iCWaVEx2q8U5Q2tvx+jHOn6fp
         Rwb7p4sLyD9IsfkGUOu1Qikoo27wyNr9MVmQuWpQ1cp1VAWkDUzNq3AjnEG7SkPU/7lJ
         75v783l7jK/M7WS+McdUtu74QhNOm85KZeFex0u063XjqwUCmJYHMZLVQxfrxnT3DSVG
         GIcmKcWPcJmTzdraWKKoSD68+KS/EsbCUTS/PhW3Tl3azDJVVQ+DAL2zyZuUjQZpwSq3
         /wVFtXWqNki5txXgW746EdmAbi0W445sk0urTYBOAONeAezI2tVETKCYGGB6SRQ8wHG1
         SmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749346907; x=1749951707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GTi9soOH0gss15/tu50fw9s97WlbXlhLt35zROKtX0=;
        b=RMwvyW1eAfir8kHX0q3t5VEbtByi32V90Z/ybFoDNtpHdI+wXAhj/sZH5psMMX/Q4g
         9K5AjX3lOd2ysjP1P5GtYLZE7SyD1F8GEocfF+nyrPOS5rvbsgfD7IAS9xuubnPYvXuF
         mzmDtEUA5fgc7Agq7VctU97404g3XUAnVHnyiMIiuXNEmtdFOMItmbglx9LNGQgsX2iA
         qavwwY9EviGX0BXni2DwYDrCpN3U+rpW40REH9j6Rxa1T49jhdRS1odkj0+1saC5cuDh
         VW+NFVX/F9rT3hOUDXEzrLlu2H6vKjWnmr/EbXO7LuvELCHPczkv59hYgxyJnxA5ZSaQ
         lu8A==
X-Forwarded-Encrypted: i=1; AJvYcCUe52/UATh6wjH7xtxAgJyRLxGx7+8b/5cFZ41EEr7dnkR24DMOeQScGLL2jYmzOJzLrqPynIInSrCBEpLM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/Pd5UX0vX4/v7+sTJEVtDm86gW4biAuPQXzjpyKlWwrmcV3J
	ks8VT1i0A+KoTYsDnsJXPNwycAUw7QkZnUVn3LdM0IFewIrd0koHSL0Z0uYsuhIaOUnLM4RhvGR
	qqx8E2KK7L7Vqaf7SzW7wqB+qhY6wvl+ehYW7Lclg
X-Gm-Gg: ASbGncvtoEvxoAhjq6IpmpqfqToV9kz1otOAEWJVlV92V38t81mfyq8DaqUGcsoSh0c
	jAMoShSaN7WLR1Aqw6i+I7dSqmdfR/ywRZJHkifGNsNsNowEN2wnM5Emy9i/6SU8A0iGy0LvJ6K
	TKf43b8P0qq/bhzYbxLeNQoJl4V4Slj+zqzejWiiJqDg==
X-Google-Smtp-Source: AGHT+IGVm2XdWm2145FxdXLlBbDc7jiX5IbrDtDFFW2CfvtZZzBD27WrrRgPQT7KReX+eYnpxO2PtHN7wBuToGpsc3c=
X-Received: by 2002:ac8:5fcd:0:b0:4a4:fdf2:375c with SMTP id
 d75a77b69052e-4a6f0717b8dmr2657791cf.9.1749346906354; Sat, 07 Jun 2025
 18:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com> <20250604231151.799834-7-surenb@google.com>
 <4cefe058-d67b-491c-83ac-293544385e84@lucifer.local>
In-Reply-To: <4cefe058-d67b-491c-83ac-293544385e84@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 7 Jun 2025 18:41:35 -0700
X-Gm-Features: AX0GCFvoWhKvEDoi5YmO-bXgDMioSqBVGlI1naa_Yxiq0jTRuVa6pR1xKb4SAM0
Message-ID: <CAJuCfpGxTdnEgKj1Mgu2bGK_6rxnBd=Sk5HiKKdp38uMtEHu3A@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 10:43=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Hi Suren,
>
> Forgive me but I am going to ask a lot of questions here :p just want to
> make sure I'm getting everything right here.

No worries and thank you for reviewing!

>
> On Wed, Jun 04, 2025 at 04:11:50PM -0700, Suren Baghdasaryan wrote:
> > With maple_tree supporting vma tree traversal under RCU and per-vma
> > locks, /proc/pid/maps can be read while holding individual vma locks
> > instead of locking the entire address space.
>
> Nice :)
>
> > Completely lockless approach would be quite complex with the main issue
> > being get_vma_name() using callbacks which might not work correctly wit=
h
> > a stable vma copy, requiring original (unstable) vma.
>
> Hmmm can you expand on what a 'completely lockless' design might comprise=
 of?

In my previous implementation
(https://lore.kernel.org/all/20250418174959.1431962-1-surenb@google.com/)
I was doing this under RCU while checking mmap_lock seq counter to
detect address space changes. That's what I meant by a completely
lockless approach here.

>
> It's super un-greppable and I've not got clangd set up with an allmod ker=
nel to
> triple-check but I'm seeing at least 2 (are there more?):
>
> gate_vma_name() which is:
>
>         return "[vsyscall]";
>
> special_mapping_name() which is:
>
>          return ((struct vm_special_mapping *)vma->vm_private_data)->name=
;
>
> Which I'm guessing is the issue because it's a double pointer deref...

Correct but in more general terms, depending on implementation of the
vm_ops.name callback, vma->vm_ops->name(vma) might not work correctly
with a vma copy. special_mapping_name() is an example of that.

>
> Seems such a silly issue to get stuck on, I wonder if we can't just chang=
e
> this to function correctly?

I was thinking about different ways to overcome that but once I
realized per-vma locks result in even less contention and the
implementation is simpler and more robust, I decided that per-vma
locks direction is better.

>
> > When per-vma lock acquisition fails, we take the mmap_lock for reading,
> > lock the vma, release the mmap_lock and continue. This guarantees the
> > reader to make forward progress even during lock contention. This will
>
> Ah that fabled constant forward progress ;)
>
> > interfere with the writer but for a very short time while we are
> > acquiring the per-vma lock and only when there was contention on the
> > vma reader is interested in.
> > One case requiring special handling is when vma changes between the
> > time it was found and the time it got locked. A problematic case would
> > be if vma got shrunk so that it's start moved higher in the address
> > space and a new vma was installed at the beginning:
> >
> > reader found:               |--------VMA A--------|
> > VMA is modified:            |-VMA B-|----VMA A----|
> > reader locks modified VMA A
> > reader reports VMA A:       |  gap  |----VMA A----|
> >
> > This would result in reporting a gap in the address space that does not
> > exist. To prevent this we retry the lookup after locking the vma, howev=
er
> > we do that only when we identify a gap and detect that the address spac=
e
> > was changed after we found the vma.
>
> OK so in this case we have
>
> 1. Find VMA A - nothing is locked yet, but presumably we are under RCU so
>    are... safe? From unmaps? Or are we? I guess actually the detach
>    mechanism sorts this out for us perhaps?

Yes, VMAs are RCU-safe and we do detect if it got detached after we
found it but before we locked it.

>
> 2. We got unlucky and did this immediately prior to VMA A having its
>    vma->vm_start, vm_end updated to reflect the split.

Yes, the split happened after we found it and before we locked it.

>
> 3. We lock VMA A, now position with an apparent gap after the prior VMA
> which, in practice does not exist.

Correct.

>
> So I am guessing that by observing sequence numbers you are able to detec=
t
> that a change has occurred and thus retry the operation in this situation=
?

Yes, we detect the gap and we detect that address space has changed,
so to endure we did not miss a split we fall back to mmap_read_lock,
lock the VMA while holding mmap_read_lock, drop mmap_read_lock and
retry.

>
> I know we previously discussed the possibility of this retry mechanism
> going on forever, I guess I will see the resolution to this in the code :=
)

Retry in this case won't go forever because we take mmap_read_lock
during the retry. In the worst case we will be constantly falling back
to mmap_read_lock but that's a very unlikely case (the writer should
be constantly splitting the vma right before the reader locks it).

>
> > This change is designed to reduce mmap_lock contention and prevent a
> > process reading /proc/pid/maps files (often a low priority task, such
> > as monitoring/data collection services) from blocking address space
> > updates. Note that this change has a userspace visible disadvantage:
> > it allows for sub-page data tearing as opposed to the previous mechanis=
m
> > where data tearing could happen only between pages of generated output
> > data. Since current userspace considers data tearing between pages to b=
e
> > acceptable, we assume is will be able to handle sub-page data tearing
> > as well.
>
> By tearing do you mean for instance seeing a VMA more than once due to
> e.g. a VMA expanding in a racey way?

Yes.

>
> Pedantic I know, but it might be worth goiing through all the merge case,
> split and remap scenarios and explaining what might happen in each one (o=
r
> perhaps do that as some form of documentation?)
>
> I can try to put together a list of all of the possibilities if that woul=
d
> be helpful.

Hmm. That might be an interesting exercise. I called out this
particular case because my tests caught it. I spent some time thinking
about other possible scenarios where we would report a gap in a place
where there are no gaps but could not think of anything else.

>
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/internal.h |   6 ++
> >  fs/proc/task_mmu.c | 177 +++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 175 insertions(+), 8 deletions(-)
>
> I really hate having all this logic in the proc/task_mmu.c file.
>
> This is really delicate stuff and I'd really like it to live in mm if
> possible.
>
> I reallise this might be a total pain, but I'm quite worried about us
> putting super-delicate, carefully written VMA handling code in different
> places.
>
> Also having stuff in mm/vma.c opens the door to userland testing which,
> when I finally have time to really expand that, would allow for some real=
ly
> nice stress testing here.

That would require some sizable refactoring. I assume code for smaps
reading and PROCMAP_QUERY would have to be moved as well?

>
> >
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index 96122e91c645..3728c9012687 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -379,6 +379,12 @@ struct proc_maps_private {
> >       struct task_struct *task;
> >       struct mm_struct *mm;
> >       struct vma_iterator iter;
> > +     loff_t last_pos;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     bool mmap_locked;
> > +     unsigned int mm_wr_seq;
>
> Is this the _last_ sequence number observed in the mm_struct? or rather,
> previous? Nitty but maybe worth renaming accordingly.

It's a copy of the mm->mm_wr_seq. I can add a comment if needed.

>
> > +     struct vm_area_struct *locked_vma;
> > +#endif
> >  #ifdef CONFIG_NUMA
> >       struct mempolicy *task_mempolicy;
> >  #endif
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 27972c0749e7..36d883c4f394 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -127,13 +127,172 @@ static void release_task_mempolicy(struct proc_m=
aps_private *priv)
> >  }
> >  #endif
> >
> > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *p=
riv,
> > -                                             loff_t *ppos)
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static struct vm_area_struct *trylock_vma(struct proc_maps_private *pr=
iv,
> > +                                       struct vm_area_struct *vma,
> > +                                       unsigned long last_pos,
> > +                                       bool mm_unstable)
>
> This whole function is a bit weird tbh, you handle both the
> mm_unstable=3Dtrue and mm_unstable=3Dfalse cases, in the latter we don't =
try to
> lock at all...

Why do you think so? vma_start_read() is always called but in case
mm_unstable=3Dtrue we double check for the gaps to take care of the case
I mentioned in the changelog.

>
> Nitty (sorry I know this is mildly irritating review) but maybe needs to =
be
> renamed, or split up somehow?
>
> This is only trylocking in the mm_unstable case...

Nope, I think you misunderstood the intention, as I mentioned above.

>
> > +{
> > +     vma =3D vma_start_read(priv->mm, vma);
>
> Do we want to do this with mm_unstable =3D=3D false?

Yes, always. mm_unstable=3Dtrue only indicates that we are already
holding mmap_read_lock, so we don't need to double-check for gaps.
Perhaps I should add some comments to clarify what purpose this
parameter serves...

>
> I know (from my own documentation :)) taking a VMA read lock while holdin=
g
> an mmap read lock is fine (the reverse isn't) but maybe it's suboptimal?

Ah, right. I should use vma_start_read_locked() instead when we are
holding mmap_read_lock. That's why that function was introduced. Will
change.

>
> > +     if (IS_ERR_OR_NULL(vma))
> > +             return NULL;
>
> Hmm IS_ERR_OR_NULL() is generally a code smell (I learned this some years
> ago from people moaning at me on code review :)
>
> Sorry I know that's annoying but perhaps its indicative of an issue in th=
e
> interface? That's possibly out of scope here however.

lock_vma_under_rcu() returns NULL or EAGAIN to signal
lock_vma_under_rcu() that it should retry the VMA lookup. In here in
either case we retry under mmap_read_lock, that's why EAGAIN is
ignored.

>
> Why are we ignoring errors here though? I guess because we don't care if
> the VMA got detached from under us, we don't bother retrying like we do i=
n
> lock_vma_under_rcu()?

No, we take mmap_read_lock and retry in either case. Perhaps I should
split trylock_vma() into two separate functions - one for the case
when we are holding mmap_read_lock and another one when we don't? I
think that would have prevented many of your questions. I'll try that
and see how it looks.

>
> Should we just abstract that part of lock_vma_under_rcu() and use it?

trylock_vma() is not that similar to lock_vma_under_rcu() for that
IMO. Also lock_vma_under_rcu() is in the pagefault path which is very
hot, so I would not want to add conditions there to make it work for
trylock_vma().

>
> > +
> > +     /* Check if the vma we locked is the right one. */
>
> Well it might not be the right one :) but might still belong to the right
> mm, so maybe better to refer to the right virtual address space.

Ack. Will change to "Check if the vma belongs to the right address space. "

>
> > +     if (unlikely(vma->vm_mm !=3D priv->mm))
> > +             goto err;
> > +
> > +     /* vma should not be ahead of the last search position. */
>
> You mean behind the last search position? Surely a VMA being _ahead_ of i=
t
> is fine?

Yes, you are correct. "should not" should have been "should".

>
> > +     if (unlikely(last_pos >=3D vma->vm_end))
>
> Should that be >=3D? Wouldn't an =3D=3D just be an adjacent VMA? Why is t=
hat
> problematic? Or is last_pos inclusive?

last_pos is inclusive and vma->vm_end is not inclusive, so if last_pos
=3D=3D vma->vm_end that would mean the vma is behind the last_pos. Since
we are searching forward from the last_pos, we should not be finding a
vma before last_pos unless it mutated.

>
> > +             goto err;
>
> Am I correct in thinking thi is what is being checked?
>
>           last_pos
>              |
>              v
> |---------|
> |         |
> |---------|
>         vm_end
>    <--- vma 'next'??? How did we go backwards?

Exactly.

>
> When last_pos gets updated, is it possible for a shrink to race to cause
> this somehow?

No, we update last_pos only after we locked the vma and confirmed it's
the right one.

>
> Do we treat this as an entirely unexpected error condition? In which case
> is a WARN_ON_ONCE() warranted?

No, the VMA might have mutated from under us before we locked it. For
example it might have been remapped to a higher address.

>
> > +
> > +     /*
> > +      * vma ahead of last search position is possible but we need to
> > +      * verify that it was not shrunk after we found it, and another
> > +      * vma has not been installed ahead of it. Otherwise we might
> > +      * observe a gap that should not be there.
> > +      */
>
> OK so this is the juicy bit.

Yep, that's the case singled out in the changelog.

>
>
> > +     if (mm_unstable && last_pos < vma->vm_start) {
> > +             /* Verify only if the address space changed since vma loo=
kup. */
> > +             if ((priv->mm_wr_seq & 1) ||
>
> Can we wrap this into a helper? This is a 'you just have to know that odd
> seq number means a write operation is in effect'. I know you have a comme=
nt
> here, but I think something like:
>
>         if (has_mm_been_modified(priv) ||
>
> Would be a lot clearer.

Yeah, I was thinking about that. I think an even cleaner way would be
to remember the return value of mmap_lock_speculate_try_begin() and
pass it around. I was hoping to avoid that extra parameter but sounds
like for the sake of clarity that would be preferable?

>
> Again this speaks to the usefulness of abstracting all this logic from th=
e
> proc code, we are putting super delicate VMA stuff here and it's just not
> the right place.
>
> As an aside, I don't see coverage in the process_addrs documentation on
> sequence number odd/even or speculation?
>
> I think we probably need to cover this to maintain an up-to-date
> description of how the VMA locking mechanism works and is used?

I think that's a very low level technical detail which I should not
have exposed here. As I mentioned, I should simply store the return
value of mmap_lock_speculate_try_begin() instead of doing these tricky
mm_wr_seq checks.

>
> > +                 mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq))=
 {
>
> Nit, again unrelated to this series, but would be useful to add a comment
> to mmap_lock_speculate_retry() to indicate that a true return value
> indicates a retry is needed, or renaming it.

This is how seqcount API works in general. Note that
mmap_lock_speculate_retry() is just a wrapper around
read_seqcount_retry().

>
> Maybe mmap_lock_speculate_needs_retry()? Also I think that function needs=
 a
> comment.

See https://elixir.bootlin.com/linux/v6.15.1/source/include/linux/seqlock.h=
#L395

>
> Naming is hard :P
>
> Anyway the totality of this expression is 'something changed' or 'read
> section retry required'.

Not quite. The expression is "something is changed from under us or
something was changing even before we started VMA lookup". Or in more
technical terms, mmap_write_lock was acquired while we were locking
the VMA or mmap_write_lock was already held even before we started the
VMA search.

>
> Under what circumstances would this happen?

See my previous comment and I hope that clarifies it.

>
> OK so we're into the 'retry' logic here:
>
> > +                     vma_iter_init(&priv->iter, priv->mm, last_pos);
>
> I'd definitely want Liam to confirm this is all above board and correct, =
as
> these operations are pretty sensitive.
>
> But assuming this is safe, we reset the iterator to the last position...
>
> > +                     if (vma !=3D vma_next(&priv->iter))
>
> Then assert the following VMA is the one we seek.
>
> > +                             goto err;
>
> Might this ever be the case in the course of ordinary operation? Is this
> really an error?

This simply means that the VMA we found before is not at the place we
found it anymore. The locking fails and we should retry.

>
> > +             }
> > +     }
> > +
> > +     priv->locked_vma =3D vma;
> > +
> > +     return vma;
> > +err:
>
> As queried above, is this really an error path or something we might expe=
ct
> to happen that could simply result in an expected fallback to mmap lock?

It's a failure to lock the VMA, which is handled by retrying under
mmap_read_lock. So, trylock_vma() failure does not mean a fault in the
logic. It's expected to happen occasionally.

>
> > +     vma_end_read(vma);
> > +     return NULL;
> > +}
> > +
> > +
> > +static void unlock_vma(struct proc_maps_private *priv)
> > +{
> > +     if (priv->locked_vma) {
> > +             vma_end_read(priv->locked_vma);
> > +             priv->locked_vma =3D NULL;
> > +     }
> > +}
> > +
> > +static const struct seq_operations proc_pid_maps_op;
> > +
> > +static inline bool lock_content(struct seq_file *m,
> > +                             struct proc_maps_private *priv)
>
> Pedantic I know but isn't 'lock_content' a bit generic?
>
> He says, not being able to think of a great alternative...
>
> OK maybe fine... :)

Yeah, I struggled with this myself. Help in naming is appreciated.

>
> > +{
> > +     /*
> > +      * smaps and numa_maps perform page table walk, therefore require
> > +      * mmap_lock but maps can be read with locked vma only.
> > +      */
> > +     if (m->op !=3D &proc_pid_maps_op) {
>
> Nit but is there a neater way of checking this? Actually I imagine not...
>
> But maybe worth, instead of forward-declaring proc_pid_maps_op, forward d=
eclare e.g.
>
> static inline bool is_maps_op(struct seq_file *m);
>
> And check e.g.
>
> if (is_maps_op(m)) { ... in the above.
>
> Yeah this is nitty not a massive del :)

I'll try that and see how it looks. Thanks!

>
> > +             if (mmap_read_lock_killable(priv->mm))
> > +                     return false;
> > +
> > +             priv->mmap_locked =3D true;
> > +     } else {
> > +             rcu_read_lock();
> > +             priv->locked_vma =3D NULL;
> > +             priv->mmap_locked =3D false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static inline void unlock_content(struct proc_maps_private *priv)
> > +{
> > +     if (priv->mmap_locked) {
> > +             mmap_read_unlock(priv->mm);
> > +     } else {
> > +             unlock_vma(priv);
> > +             rcu_read_unlock();
>
> Does this always get called even in error cases?

What error cases do you have in mind? Error to lock a VMA is handled
by retrying and we should be happily proceeding. Please clarify.

>
> > +     }
> > +}
> > +
> > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> > +                                        loff_t last_pos)
>
> We really need a generalised RCU multi-VMA locking mechanism (we're looki=
ng
> into madvise VMA locking atm with a conservative single VMA lock at the
> moment, but in future we probably want to be able to span multiple for
> instance) and this really really feels like it doesn't belong in this pro=
c
> code.

Ok, I guess you are building a case to move more code into vma.c? I
see what you are doing :)

>
> >  {
> > -     struct vm_area_struct *vma =3D vma_next(&priv->iter);
> > +     struct vm_area_struct *vma;
> > +     int ret;
> > +
> > +     if (priv->mmap_locked)
> > +             return vma_next(&priv->iter);
> > +
> > +     unlock_vma(priv);
> > +     /*
> > +      * Record sequence number ahead of vma lookup.
> > +      * Odd seqcount means address space modification is in progress.
> > +      */
> > +     mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq);
>
> Hmm we're discarding the return value I guess we don't really care about
> that at this stage? Or do we? Do we want to assert the read critical
> section state here?

Yeah, as I mentioned, instead of relying on priv->mm_wr_seq being odd
I should record the return value of mmap_lock_speculate_try_begin().
In the functional sense these two are interchangeable.

>
> I guess since we have the mm_rq_seq which we use later it's the same thin=
g
> and doesn't matter.

Yep.

>
> ~~(off topic a bit)~~
>
> OK so off-topic again afaict we're doing something pretty horribly gross =
here.
>
> We pass &priv->mm_rw_seq as 'unsigned int *seq' field to
> mmap_lock_speculate_try_begin(), which in turn calls:
>
>         return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
>
> And this is defined as a macro of:
>
> #define raw_seqcount_try_begin(s, start)                                \
> ({                                                                      \
>         start =3D raw_read_seqcount(s);                                  =
 \
>         !(start & 1);                                                   \
> })
>
> So surely this expands to:
>
>         *seq =3D raw_read_seqcount(&mm->mm_lock_seq);
>         !(*seq & 1) // return true if even, false if odd
>
> So we're basically ostensibly passing an unsigned int, but because we're
> calling a macro it's actually just 'text' and we're instead able to then
> reassign the underlying unsigned int * ptr and... ugh.
>
> ~~(/off topic a bit)~~

Aaaand we are back...

>
> > +     vma =3D vma_next(&priv->iter);
>
>
>
> > +     if (!vma)
> > +             return NULL;
> > +
> > +     vma =3D trylock_vma(priv, vma, last_pos, true);
> > +     if (vma)
> > +             return vma;
> > +
>
> Really feels like this should be a boolean... I guess neat to reset vma i=
f
> not locked though.

I guess I can change trylock_vma() to return boolean. We always return
the same vma or NULL I think.

>
> > +     /* Address space got modified, vma might be stale. Re-lock and re=
try */
>
> > +     rcu_read_unlock();
>
> Might we see a VMA possibly actually legit unmapped in a race here? Do we
> need to update last_pos/ppos to account for this? Otherwise we might just
> fail on the last_pos >=3D vma->vm_end check in trylock_vma() no?

Yes, it can happen and trylock_vma() will fail to lock the modified
VMA. That's by design. In such cases we retry the lookup from the same
last_pos.

>
> > +     ret =3D mmap_read_lock_killable(priv->mm);
>
> Shouldn't we set priv->mmap_locked here?

No, we will drop the mmap_read_lock shortly. priv->mmap_locked
indicates the overall mode we operate in. When priv->mmap_locked=3Dfalse
we can still temporarily take the mmap_read_lock when retrying and
then drop it after we found the VMA.

>
> I guess not as we are simply holding the mmap lock to definitely get the
> next VMA.

Correct.

>
> > +     rcu_read_lock();
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     /* Lookup the vma at the last position again under mmap_read_lock=
 */
> > +     vma_iter_init(&priv->iter, priv->mm, last_pos);
> > +     vma =3D vma_next(&priv->iter);
> > +     if (vma) {
> > +             vma =3D trylock_vma(priv, vma, last_pos, false);
>
> Be good to use Liam's convention of /* mm_unstable =3D */ false to make t=
his
> clear.

Yeah, I'm thinking of splitting trylock_vma() into two separate
functions for mm_unstable=3Dtrue and mm_unstable=3Dfalse cases.

>
> Find it kinda weird again we're 'trylocking' something we already have
> locked via the mmap lock but I already mentioend this... :)
>
> > +             WARN_ON(!vma); /* mm is stable, has to succeed */
>
> I wonder if this is really useful, at any rate seems like there'd be a
> flood here so WARN_ON_ONCE()? Perhaps VM_WARN_ON_ONCE() given this really
> really ought not happen?

Well, I can't use BUG_ON(), so WARN_ON() is the next tool I have :) In
reality this should never happen, so
WARN_ON/WARN_ON_ONCE/WARN_ON_RATELIMITED/or whatever does not matter
much.

>
> > +     }
> > +     mmap_read_unlock(priv->mm);
> > +
> > +     return vma;
> > +}
> > +
> > +#else /* CONFIG_PER_VMA_LOCK */
> >
> > +static inline bool lock_content(struct seq_file *m,
> > +                             struct proc_maps_private *priv)
> > +{
> > +     return mmap_read_lock_killable(priv->mm) =3D=3D 0;
> > +}
> > +
> > +static inline void unlock_content(struct proc_maps_private *priv)
> > +{
> > +     mmap_read_unlock(priv->mm);
> > +}
> > +
> > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> > +                                        loff_t last_pos)
> > +{
> > +     return vma_next(&priv->iter);
> > +}
> > +
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> > +static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t =
*ppos)
> > +{
> > +     struct proc_maps_private *priv =3D m->private;
> > +     struct vm_area_struct *vma;
> > +
> > +     vma =3D get_next_vma(priv, *ppos);
> > +     if (IS_ERR(vma))
> > +             return vma;
> > +
> > +     /* Store previous position to be able to restart if needed */
> > +     priv->last_pos =3D *ppos;
> >       if (vma) {
> > -             *ppos =3D vma->vm_start;
> > +             /*
> > +              * Track the end of the reported vma to ensure position c=
hanges
> > +              * even if previous vma was merged with the next vma and =
we
> > +              * found the extended vma with the same vm_start.
> > +              */
>
> Right, so observing repetitions is acceptable in such circumstances? I me=
an
> I agree.

Yep, the VMA will be reported twice in such a case.

>
> > +             *ppos =3D vma->vm_end;
>
> If we store the end, does the last_pos logic which resets the VMA iterato=
r
> later work correctly in all cases?

I think so. By resetting to vma->vm_end we will start the next search
from the address right next to the last reported VMA, no?

>
> >       } else {
> >               *ppos =3D -2UL;
> >               vma =3D get_gate_vma(priv->mm);
>
> Is it always the case that !vma here implies a gate VMA (yuck yuck)? I se=
e
> this was the original logic, but maybe put a comment about this as it's
> weird and confusing? (and not your fault obviously :P)

What comment would you like to see here?

>
> Also, are all locks and state corectly handled in this case? Seems like o=
ne
> of this nasty edge case situations that could have jagged edges...

I think we are fine. get_next_vma() returned NULL, so we did not lock
any VMA and priv->locked_vma should be NULL.

>
> > @@ -163,19 +322,21 @@ static void *m_start(struct seq_file *m, loff_t *=
ppos)
> >               return NULL;
> >       }
> >
> > -     if (mmap_read_lock_killable(mm)) {
> > +     if (!lock_content(m, priv)) {
>
> Nice that this just slots in like this! :)
>
> >               mmput(mm);
> >               put_task_struct(priv->task);
> >               priv->task =3D NULL;
> >               return ERR_PTR(-EINTR);
> >       }
> >
> > +     if (last_addr > 0)
>
> last_addr is an unsigned long, this will always be true.

Not unless last_addr=3D=3D0. That's what I'm really checking here: is this
the first invocation of m_start(), in which case we are starting from
the beginning and not restarting from priv->last_pos. Should I add a
comment?

>
> You probably want to put an explicit check for -1UL, -2UL here or?
>
> God I hate this mechanism for indicating gate VMA... yuck yuck (again, th=
is
> bit not your fault :P)

No, I don't care here about -1UL, -2UL, just that last_addr=3D=3D0 or not.

>
> > +             *ppos =3D last_addr =3D priv->last_pos;
> >       vma_iter_init(&priv->iter, mm, last_addr);
> >       hold_task_mempolicy(priv);
> >       if (last_addr =3D=3D -2UL)
> >               return get_gate_vma(mm);
> >
> > -     return proc_get_vma(priv, ppos);
> > +     return proc_get_vma(m, ppos);
> >  }
> >
> >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > @@ -184,7 +345,7 @@ static void *m_next(struct seq_file *m, void *v, lo=
ff_t *ppos)
> >               *ppos =3D -1UL;
> >               return NULL;
> >       }
> > -     return proc_get_vma(m->private, ppos);
> > +     return proc_get_vma(m, ppos);
> >  }
> >
> >  static void m_stop(struct seq_file *m, void *v)
> > @@ -196,7 +357,7 @@ static void m_stop(struct seq_file *m, void *v)
> >               return;
> >
> >       release_task_mempolicy(priv);
> > -     mmap_read_unlock(mm);
> > +     unlock_content(priv);
> >       mmput(mm);
> >       put_task_struct(priv->task);
> >       priv->task =3D NULL;
> > --
> > 2.49.0.1266.g31b7d2e469-goog
> >
>
> Sorry to add to workload by digging into so many details here, but we
> really need to make sure all the i's are dotted and t's are crossed given
> how fiddly and fragile this stuff is :)
>
> Very much appreciate the work, this is a significant improvement and will
> have a great deal of real world impact!

Thanks for meticulously going over the code! This is really helpful.
Suren.

>
> Cheers, Lorenzo

