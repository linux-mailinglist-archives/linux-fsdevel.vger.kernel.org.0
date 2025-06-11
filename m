Return-Path: <linux-fsdevel+bounces-51334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE7AD5A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73EC1891C6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84811E520A;
	Wed, 11 Jun 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccaONr6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDE1AE875
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654762; cv=none; b=jfq58WOPqgcBaUQlkdmyh3hLKubu5w9JrG3zJH0MPVnXmJw9wHBDGQsbXMUQLvGthzFTA0zl82ZB6an/i5cLZ4hveVG8tnLhvMn4aFo2ktbIJoaWs7mboGm/hwldzta1nPZFpZDms12sZ9vdkn8dzQrh+1aTHusg9MGfxlx1twA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654762; c=relaxed/simple;
	bh=G4XMhSFu+LuQAzX5F16ZJjGqigE3Ld9WmzbMOCpaXMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTThdMRAzfo+WLrDmOZcg4Wyr0Zbz/X7W2yGw7xTh9EPKp86l7WjyVhmIhbHtkfxzd4WHSZ78Iodoh77QZ3hF/68So2N6KIs6XJodNf8iyDJf93EeC19DWfvLmlVWZOXBsbRK1SY4XpOxAhvTBYKmMmMka5jU9Eww4IlmoPk4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccaONr6a; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a5ac8fae12so467411cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749654758; x=1750259558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt93IEYu7V8NK/RtbCF2C3IoFoTGFK732QMojhQJ/7A=;
        b=ccaONr6anPNh+8DtOAOSYXL9sy3xSQE3+Ung5aS2vuY9XIKRDYCnDSedQpKXrHNnc5
         cKg5wIGQHXCJ3hO3jVjVkmkTtNSfwwO0CZS/UYQMkjOPpjaRmZyug2MXHfTcZxsIzXwW
         Dd9tOmQ/PJgddLXV6wOFcSqZODI11gagAcHDKc5Wk7rjhQaQfjjrRsfY0xoEaeYAfwE6
         9JGPGDrLKBbKUWAglZPKk1AuxLFRayjjfz3GPdfbooO5reLQvNfksLQr3oJeRdd/3PNn
         OjY3j7T30ux+ubUccCCso9djescDkBE7BohNrc+zE8/DB91WcLuNen5JjXiPf7/88DAf
         1Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654758; x=1750259558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vt93IEYu7V8NK/RtbCF2C3IoFoTGFK732QMojhQJ/7A=;
        b=RadcMUq3LO+qZEFvyQd3aqToUnVx0mrDmC+jsUgP4fiCKnF23805xFUveCCskOw0op
         NcAhPCbxJm8S2t9G3bkNSjZXi4qYr5GYvnH4fBHuVHbfQOstpD8wvSHUdHUF1bvKfRhI
         ajB5CEaZZEitec5IhkP7rdSb6IaZ9MN2Hd2j18Bg0W+kLmJF09Rtxsr19LCdMqx8qpSo
         /rdktoIwPttFHrPwjtEPLo9gj3U4GYcMA03niqgskk9MnYmEIfZo8P/EtHS1gLck32FX
         kBQPpSOgXKB4c3ynfqBsD45bN6XfVb/2JzgCwcSxdJQU/Mua9sfonda2YootEYxoaNAA
         7U6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVu8iVJQT28lf+VIt2usQm1Br4aPyDYEKMOwCcTnhG+cKuSdn5rLzxBpjD8JwKTakd9qE1J2o/jO9IRUhGY@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7u2D8bDrl1VgpHEHob1oVB0Kz+T4AIGqWTc9ADERAD34BUz4
	ENRCfYSTi/dPtCAytJLPqciu8f9HSdEp3jP5m648gOalfnuc3kVmXn4jMw9KjsP8ulQc91HoOom
	+Wwgz6IWbpAh5n/fJamniexshHWRm6/x0X/LNX/+1
X-Gm-Gg: ASbGncui+OB30VduPFDwgN7Yq4zsUFGsMrBCaBr5SwjN8ybsNHfzaaYQHRqmTYjXHLb
	wfc1/xZDYGlaJOMQH50UIN4oI8Gf6wqqMBotdt+psG83oqjma3PfVSdCwZD97Zwf6whSCSNXssw
	Z7ZiJt63CnoLHiSXNYH6XNW8Jr728SGf7FE72h23MO49Q94/CtqreHvH6ZjqbRDT8E3n2HNNrjk
	w==
X-Google-Smtp-Source: AGHT+IHzGFYAKWUalwhKzmDr6f/BedYikR7yGqBbr732z5Cnr0bZ64KCIEuuQhGsdvSdig6aLpOEi3il7VE4cwmKtQ4=
X-Received: by 2002:ac8:5887:0:b0:49d:88d0:145 with SMTP id
 d75a77b69052e-4a7173d3c2dmr2610771cf.23.1749654756878; Wed, 11 Jun 2025
 08:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com> <20250604231151.799834-7-surenb@google.com>
 <4cefe058-d67b-491c-83ac-293544385e84@lucifer.local> <CAJuCfpGxTdnEgKj1Mgu2bGK_6rxnBd=Sk5HiKKdp38uMtEHu3A@mail.gmail.com>
 <6364468a-ca45-4e21-8c4d-3d9c4e6396b8@lucifer.local> <CAJuCfpFb4Ky0Hw71KePuMPi5_pPPgK-9rDQ6HRAf39CfcWc6cw@mail.gmail.com>
 <7a26aae6-8695-4bbc-b00d-47d0c56b9cd6@lucifer.local>
In-Reply-To: <7a26aae6-8695-4bbc-b00d-47d0c56b9cd6@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Jun 2025 08:12:25 -0700
X-Gm-Features: AX0GCFvfGZ34IUv4v4zbL6UM3U4g9Jv_CMrms2rpyD8Xh11Gd5rOuYywDfythSY
Message-ID: <CAJuCfpFGZpQhSAh3gYv95AtJjxGjBC+uM0zoBwDTTrpOHZnb4g@mail.gmail.com>
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

On Wed, Jun 11, 2025 at 3:25=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Thanks for your patient replies :)
>
> OK to save us both time in such a huuuuge back-and-forth - I agree broadl=
y
> with your comments below and I think we are aligned on everything now.
>
> I will try to get you a list of merge scenarios and ideally have a look a=
t
> the test code too if I have time this week.
>
> But otherwise hopefully we are good for a respin here?

Ack. Working on it.

>
> Cheers, Lorenzo
>
> On Tue, Jun 10, 2025 at 05:16:36PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Jun 10, 2025 at 10:43=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Sat, Jun 07, 2025 at 06:41:35PM -0700, Suren Baghdasaryan wrote:
> > > > On Sat, Jun 7, 2025 at 10:43=E2=80=AFAM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > Hi Suren,
> > > > >
> > > > > Forgive me but I am going to ask a lot of questions here :p just =
want to
> > > > > make sure I'm getting everything right here.
> > > >
> > > > No worries and thank you for reviewing!
> > >
> > > No problem!
> > >
> > > >
> > > > >
> > > > > On Wed, Jun 04, 2025 at 04:11:50PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > With maple_tree supporting vma tree traversal under RCU and per=
-vma
> > > > > > locks, /proc/pid/maps can be read while holding individual vma =
locks
> > > > > > instead of locking the entire address space.
> > > > >
> > > > > Nice :)
> > > > >
> > > > > > Completely lockless approach would be quite complex with the ma=
in issue
> > > > > > being get_vma_name() using callbacks which might not work corre=
ctly with
> > > > > > a stable vma copy, requiring original (unstable) vma.
> > > > >
> > > > > Hmmm can you expand on what a 'completely lockless' design might =
comprise of?
> > > >
> > > > In my previous implementation
> > > > (https://lore.kernel.org/all/20250418174959.1431962-1-surenb@google=
.com/)
> > > > I was doing this under RCU while checking mmap_lock seq counter to
> > > > detect address space changes. That's what I meant by a completely
> > > > lockless approach here.
> > >
> > > Oh did that approach not even use VMA locks _at all_?
> >
> > Correct, it was done under RCU protection.
> >
> > >
> > > >
> > > > >
> > > > > It's super un-greppable and I've not got clangd set up with an al=
lmod kernel to
> > > > > triple-check but I'm seeing at least 2 (are there more?):
> > > > >
> > > > > gate_vma_name() which is:
> > > > >
> > > > >         return "[vsyscall]";
> > > > >
> > > > > special_mapping_name() which is:
> > > > >
> > > > >          return ((struct vm_special_mapping *)vma->vm_private_dat=
a)->name;
> > > > >
> > > > > Which I'm guessing is the issue because it's a double pointer der=
ef...
> > > >
> > > > Correct but in more general terms, depending on implementation of t=
he
> > > > vm_ops.name callback, vma->vm_ops->name(vma) might not work correct=
ly
> > > > with a vma copy. special_mapping_name() is an example of that.
> > >
> > > Yeah, this is a horrible situation to be in for such a trivial thing.=
 But I
> > > guess unavoidable for now.
> > >
> > > >
> > > > >
> > > > > Seems such a silly issue to get stuck on, I wonder if we can't ju=
st change
> > > > > this to function correctly?
> > > >
> > > > I was thinking about different ways to overcome that but once I
> > > > realized per-vma locks result in even less contention and the
> > > > implementation is simpler and more robust, I decided that per-vma
> > > > locks direction is better.
> > >
> > > Ack well in that case :)
> > >
> > > But still it'd be nice to somehow restrict the impact of this callbac=
k.
> >
> > With VMA locked we are back in a safe place, I think.
> >
> > >
> > > >
> > > > >
> > > > > > When per-vma lock acquisition fails, we take the mmap_lock for =
reading,
> > > > > > lock the vma, release the mmap_lock and continue. This guarante=
es the
> > > > > > reader to make forward progress even during lock contention. Th=
is will
> > > > >
> > > > > Ah that fabled constant forward progress ;)
> > > > >
> > > > > > interfere with the writer but for a very short time while we ar=
e
> > > > > > acquiring the per-vma lock and only when there was contention o=
n the
> > > > > > vma reader is interested in.
> > > > > > One case requiring special handling is when vma changes between=
 the
> > > > > > time it was found and the time it got locked. A problematic cas=
e would
> > > > > > be if vma got shrunk so that it's start moved higher in the add=
ress
> > > > > > space and a new vma was installed at the beginning:
> > > > > >
> > > > > > reader found:               |--------VMA A--------|
> > > > > > VMA is modified:            |-VMA B-|----VMA A----|
> > > > > > reader locks modified VMA A
> > > > > > reader reports VMA A:       |  gap  |----VMA A----|
> > > > > >
> > > > > > This would result in reporting a gap in the address space that =
does not
> > > > > > exist. To prevent this we retry the lookup after locking the vm=
a, however
> > > > > > we do that only when we identify a gap and detect that the addr=
ess space
> > > > > > was changed after we found the vma.
> > > > >
> > > > > OK so in this case we have
> > > > >
> > > > > 1. Find VMA A - nothing is locked yet, but presumably we are unde=
r RCU so
> > > > >    are... safe? From unmaps? Or are we? I guess actually the deta=
ch
> > > > >    mechanism sorts this out for us perhaps?
> > > >
> > > > Yes, VMAs are RCU-safe and we do detect if it got detached after we
> > > > found it but before we locked it.
> > >
> > > Ack I thought so.
> > >
> > > >
> > > > >
> > > > > 2. We got unlucky and did this immediately prior to VMA A having =
its
> > > > >    vma->vm_start, vm_end updated to reflect the split.
> > > >
> > > > Yes, the split happened after we found it and before we locked it.
> > > >
> > > > >
> > > > > 3. We lock VMA A, now position with an apparent gap after the pri=
or VMA
> > > > > which, in practice does not exist.
> > > >
> > > > Correct.
> > >
> > > Ack
> > >
> > > >
> > > > >
> > > > > So I am guessing that by observing sequence numbers you are able =
to detect
> > > > > that a change has occurred and thus retry the operation in this s=
ituation?
> > > >
> > > > Yes, we detect the gap and we detect that address space has changed=
,
> > > > so to endure we did not miss a split we fall back to mmap_read_lock=
,
> > > > lock the VMA while holding mmap_read_lock, drop mmap_read_lock and
> > > > retry.
> > > >
> > > > >
> > > > > I know we previously discussed the possibility of this retry mech=
anism
> > > > > going on forever, I guess I will see the resolution to this in th=
e code :)
> > > >
> > > > Retry in this case won't go forever because we take mmap_read_lock
> > > > during the retry. In the worst case we will be constantly falling b=
ack
> > > > to mmap_read_lock but that's a very unlikely case (the writer shoul=
d
> > > > be constantly splitting the vma right before the reader locks it).
> > >
> > > It might be worth adding that to commit message to underline that thi=
s has
> > > been considered and this is the resolution.
> > >
> > > Something like:
> > >
> > >         we guarantee forward progress by always resolving contention =
via a
> > >         fallback to an mmap-read lock.
> > >
> > >         We shouldn't see a repeated fallback to mmap read locks in
> > >         practice, as this require a vanishingly unlikely series of lo=
ck
> > >         contentions (for instance due to repeated VMA split
> > >         operations). However even if this did somehow happen, we woul=
d
> > >         still progress.
> >
> > Ack.
> >
> > >
> > > >
> > > > >
> > > > > > This change is designed to reduce mmap_lock contention and prev=
ent a
> > > > > > process reading /proc/pid/maps files (often a low priority task=
, such
> > > > > > as monitoring/data collection services) from blocking address s=
pace
> > > > > > updates. Note that this change has a userspace visible disadvan=
tage:
> > > > > > it allows for sub-page data tearing as opposed to the previous =
mechanism
> > > > > > where data tearing could happen only between pages of generated=
 output
> > > > > > data. Since current userspace considers data tearing between pa=
ges to be
> > > > > > acceptable, we assume is will be able to handle sub-page data t=
earing
> > > > > > as well.
> > > > >
> > > > > By tearing do you mean for instance seeing a VMA more than once d=
ue to
> > > > > e.g. a VMA expanding in a racey way?
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > > Pedantic I know, but it might be worth goiing through all the mer=
ge case,
> > > > > split and remap scenarios and explaining what might happen in eac=
h one (or
> > > > > perhaps do that as some form of documentation?)
> > > > >
> > > > > I can try to put together a list of all of the possibilities if t=
hat would
> > > > > be helpful.
> > > >
> > > > Hmm. That might be an interesting exercise. I called out this
> > > > particular case because my tests caught it. I spent some time think=
ing
> > > > about other possible scenarios where we would report a gap in a pla=
ce
> > > > where there are no gaps but could not think of anything else.
> > >
> > > todo++; :)
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > ---
> > > > > >  fs/proc/internal.h |   6 ++
> > > > > >  fs/proc/task_mmu.c | 177 +++++++++++++++++++++++++++++++++++++=
++++++--
> > > > > >  2 files changed, 175 insertions(+), 8 deletions(-)
> > > > >
> > > > > I really hate having all this logic in the proc/task_mmu.c file.
> > > > >
> > > > > This is really delicate stuff and I'd really like it to live in m=
m if
> > > > > possible.
> > > > >
> > > > > I reallise this might be a total pain, but I'm quite worried abou=
t us
> > > > > putting super-delicate, carefully written VMA handling code in di=
fferent
> > > > > places.
> > > > >
> > > > > Also having stuff in mm/vma.c opens the door to userland testing =
which,
> > > > > when I finally have time to really expand that, would allow for s=
ome really
> > > > > nice stress testing here.
> > > >
> > > > That would require some sizable refactoring. I assume code for smap=
s
> > > > reading and PROCMAP_QUERY would have to be moved as well?
> > >
> > > Yeah, I know, and apologies for that, but I really oppose us having t=
his
> > > super delicate VMA logic in an fs/proc file, one we don't maintain fo=
r that
> > > matter.
> > >
> > > I know it's a total pain, but this just isn't the right place to be d=
oing
> > > such a careful dance.
> > >
> > > I'm not saying relocate code that belongs here, but find a way to abs=
tract
> > > the operations.
> >
> > Ok, I'll take a stab at refactoring purely mm-related code and will
> > see how that looks.
> >
> > >
> > > Perhaps could be a walker or something that does all the state transi=
tion
> > > stuff that you can then just call from the walker functions here?
> > >
> > > You could then figure out something similar for the PROCMAP_QUERY log=
ic.
> > >
> > > We're not doing this VMA locking stuff for smaps are we? As that is w=
alking
> > > page tables anyway right? So nothing would change for that.
> >
> > Yeah, smaps would stay as they are but refactoring might affect its
> > code portions as well.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > > > > > index 96122e91c645..3728c9012687 100644
> > > > > > --- a/fs/proc/internal.h
> > > > > > +++ b/fs/proc/internal.h
> > > > > > @@ -379,6 +379,12 @@ struct proc_maps_private {
> > > > > >       struct task_struct *task;
> > > > > >       struct mm_struct *mm;
> > > > > >       struct vma_iterator iter;
> > > > > > +     loff_t last_pos;
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +     bool mmap_locked;
> > > > > > +     unsigned int mm_wr_seq;
> > > > >
> > > > > Is this the _last_ sequence number observed in the mm_struct? or =
rather,
> > > > > previous? Nitty but maybe worth renaming accordingly.
> > > >
> > > > It's a copy of the mm->mm_wr_seq. I can add a comment if needed.
> > >
> > > Right, of course. But I think the problem is the 'when' it refers to.=
 It's
> > > the sequence number associatied with the mm here sure, but when was i=
t
> > > snapshotted? How do we use it?
> > >
> > > Something like 'last_seen_seqnum' or 'mm_wr_seq_start' or something p=
lus a
> > > comment would be helpful.
> > >
> > > This is nitty I know... but this stuff is very confusing and I think =
every
> > > little bit we do to help explain things is helpful here.
> >
> > Ok, I'll add a comment that mm_wr_seq is a snapshot of mm->mm_wr_seq
> > before we started the VMA lookup.
> >
> > >
> > > >
> > > > >
> > > > > > +     struct vm_area_struct *locked_vma;
> > > > > > +#endif
> > > > > >  #ifdef CONFIG_NUMA
> > > > > >       struct mempolicy *task_mempolicy;
> > > > > >  #endif
> > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > index 27972c0749e7..36d883c4f394 100644
> > > > > > --- a/fs/proc/task_mmu.c
> > > > > > +++ b/fs/proc/task_mmu.c
> > > > > > @@ -127,13 +127,172 @@ static void release_task_mempolicy(struc=
t proc_maps_private *priv)
> > > > > >  }
> > > > > >  #endif
> > > > > >
> > > > > > -static struct vm_area_struct *proc_get_vma(struct proc_maps_pr=
ivate *priv,
> > > > > > -                                             loff_t *ppos)
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +
> > > > > > +static struct vm_area_struct *trylock_vma(struct proc_maps_pri=
vate *priv,
> > > > > > +                                       struct vm_area_struct *=
vma,
> > > > > > +                                       unsigned long last_pos,
> > > > > > +                                       bool mm_unstable)
> > > > >
> > > > > This whole function is a bit weird tbh, you handle both the
> > > > > mm_unstable=3Dtrue and mm_unstable=3Dfalse cases, in the latter w=
e don't try to
> > > > > lock at all...
> > > >
> > > > Why do you think so? vma_start_read() is always called but in case
> > > > mm_unstable=3Dtrue we double check for the gaps to take care of the=
 case
> > > > I mentioned in the changelog.
> > >
> > > Well the read lock will always succeed if mmap read lock is held righ=
t?
> > > Actually... no :)
> > >
> > > I see your point below about vma_start_read_locked() :>)
> > >
> > > I see below you suggest splitting into two functions, that seems to b=
e a
> > > good way forward.
> >
> > Ack.
> >
> > >
> > > I _think_ we won't even need the checks re: mm and last_pos in that c=
ase
> > > right? As holding the mmap lock we should be able to guarantee? Or at=
 least
> > > the mm check?
> >
> > Correct. These checks are needed only if we are searching the VMA
> > under RCU protection before locking it. If we are holding mmap_lock
> > then all this is not needed.
> >
> > >
> > > >
> > > > >
> > > > > Nitty (sorry I know this is mildly irritating review) but maybe n=
eeds to be
> > > > > renamed, or split up somehow?
> > > > >
> > > > > This is only trylocking in the mm_unstable case...
> > > >
> > > > Nope, I think you misunderstood the intention, as I mentioned above=
.
> > > >
> > > > >
> > > > > > +{
> > > > > > +     vma =3D vma_start_read(priv->mm, vma);
> > > > >
> > > > > Do we want to do this with mm_unstable =3D=3D false?
> > > >
> > > > Yes, always. mm_unstable=3Dtrue only indicates that we are already
> > > > holding mmap_read_lock, so we don't need to double-check for gaps.
> > > > Perhaps I should add some comments to clarify what purpose this
> > > > parameter serves...
> > > >
> > > > >
> > > > > I know (from my own documentation :)) taking a VMA read lock whil=
e holding
> > > > > an mmap read lock is fine (the reverse isn't) but maybe it's subo=
ptimal?
> > > >
> > > > Ah, right. I should use vma_start_read_locked() instead when we are
> > > > holding mmap_read_lock. That's why that function was introduced. Wi=
ll
> > > > change.
> > >
> > > Yeah, I'll pretend this is what I meant to sound smart :P but this is=
 a
> > > really good point!
> > >
> > > >
> > > > >
> > > > > > +     if (IS_ERR_OR_NULL(vma))
> > > > > > +             return NULL;
> > > > >
> > > > > Hmm IS_ERR_OR_NULL() is generally a code smell (I learned this so=
me years
> > > > > ago from people moaning at me on code review :)
> > > > >
> > > > > Sorry I know that's annoying but perhaps its indicative of an iss=
ue in the
> > > > > interface? That's possibly out of scope here however.
> > > >
> > > > lock_vma_under_rcu() returns NULL or EAGAIN to signal
> > > > lock_vma_under_rcu() that it should retry the VMA lookup. In here i=
n
> > > > either case we retry under mmap_read_lock, that's why EAGAIN is
> > > > ignored.
> > >
> > > Yeah indeed you're right. I guess I'm just echoing previous review tr=
aumas
> > > here :P
> > >
> > > >
> > > > >
> > > > > Why are we ignoring errors here though? I guess because we don't =
care if
> > > > > the VMA got detached from under us, we don't bother retrying like=
 we do in
> > > > > lock_vma_under_rcu()?
> > > >
> > > > No, we take mmap_read_lock and retry in either case. Perhaps I shou=
ld
> > > > split trylock_vma() into two separate functions - one for the case
> > > > when we are holding mmap_read_lock and another one when we don't? I
> > > > think that would have prevented many of your questions. I'll try th=
at
> > > > and see how it looks.
> > >
> > > Yeah that'd be helpful. I think this should also simplify things?
> >
> > Yes. Will try that.
> >
> > >
> > > >
> > > > >
> > > > > Should we just abstract that part of lock_vma_under_rcu() and use=
 it?
> > > >
> > > > trylock_vma() is not that similar to lock_vma_under_rcu() for that
> > > > IMO. Also lock_vma_under_rcu() is in the pagefault path which is ve=
ry
> > > > hot, so I would not want to add conditions there to make it work fo=
r
> > > > trylock_vma().
> > >
> > > Right sure.
> > >
> > > But I'm just wondering why we don't do the retry stuff, e.g.:
> > >
> > >                 /* Check if the VMA got isolated after we found it */
> > >                 if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > >                         count_vm_vma_lock_event(VMA_LOCK_MISS);
> > >                         /* The area was replaced with another one */
> > >                         goto retry;
> > >                 }
> > >
> > > I mean do we need to retry under mmap lock in that case? Can we just =
retry
> > > the lookup? Or is this not a worthwhile optimisation here?
> >
> > Hmm. That might be applicable here as well. Let me think some more
> > about it. Theoretically that might affect our forward progress
> > guarantee but for us to retry infinitely the VMA we find has to be
> > knocked out from under us each time we find it. So, quite unlikely to
> > happen continuously.
> >
> > >
> > > >
> > > > >
> > > > > > +
> > > > > > +     /* Check if the vma we locked is the right one. */
> > > > >
> > > > > Well it might not be the right one :) but might still belong to t=
he right
> > > > > mm, so maybe better to refer to the right virtual address space.
> > > >
> > > > Ack. Will change to "Check if the vma belongs to the right address =
space. "
> > >
> > > Thanks!
> > >
> > > >
> > > > >
> > > > > > +     if (unlikely(vma->vm_mm !=3D priv->mm))
> > > > > > +             goto err;
> > > > > > +
> > > > > > +     /* vma should not be ahead of the last search position. *=
/
> > > > >
> > > > > You mean behind the last search position? Surely a VMA being _ahe=
ad_ of it
> > > > > is fine?
> > > >
> > > > Yes, you are correct. "should not" should have been "should".
> > >
> > > Thanks!
> > >
> > > >
> > > > >
> > > > > > +     if (unlikely(last_pos >=3D vma->vm_end))
> > > > >
> > > > > Should that be >=3D? Wouldn't an =3D=3D just be an adjacent VMA? =
Why is that
> > > > > problematic? Or is last_pos inclusive?
> > > >
> > > > last_pos is inclusive and vma->vm_end is not inclusive, so if last_=
pos
> > > > =3D=3D vma->vm_end that would mean the vma is behind the last_pos. =
Since
> > > > we are searching forward from the last_pos, we should not be findin=
g a
> > > > vma before last_pos unless it mutated.
> > >
> > > Ahhh that explains it. Thanks.
> > >
> > > >
> > > > >
> > > > > > +             goto err;
> > > > >
> > > > > Am I correct in thinking thi is what is being checked?
> > > > >
> > > > >           last_pos
> > > > >              |
> > > > >              v
> > > > > |---------|
> > > > > |         |
> > > > > |---------|
> > > > >         vm_end
> > > > >    <--- vma 'next'??? How did we go backwards?
> > > >
> > > > Exactly.
> > > >
> > > > >
> > > > > When last_pos gets updated, is it possible for a shrink to race t=
o cause
> > > > > this somehow?
> > > >
> > > > No, we update last_pos only after we locked the vma and confirmed i=
t's
> > > > the right one.
> > >
> > > Ack.
> > >
> > > >
> > > > >
> > > > > Do we treat this as an entirely unexpected error condition? In wh=
ich case
> > > > > is a WARN_ON_ONCE() warranted?
> > > >
> > > > No, the VMA might have mutated from under us before we locked it. F=
or
> > > > example it might have been remapped to a higher address.
> > > >
> > > > >
> > > > > > +
> > > > > > +     /*
> > > > > > +      * vma ahead of last search position is possible but we n=
eed to
> > > > > > +      * verify that it was not shrunk after we found it, and a=
nother
> > > > > > +      * vma has not been installed ahead of it. Otherwise we m=
ight
> > > > > > +      * observe a gap that should not be there.
> > > > > > +      */
> > > > >
> > > > > OK so this is the juicy bit.
> > > >
> > > > Yep, that's the case singled out in the changelog.
> > >
> > > And rightly so!
> > >
> > > >
> > > > >
> > > > >
> > > > > > +     if (mm_unstable && last_pos < vma->vm_start) {
> > > > > > +             /* Verify only if the address space changed since=
 vma lookup. */
> > > > > > +             if ((priv->mm_wr_seq & 1) ||
> > > > >
> > > > > Can we wrap this into a helper? This is a 'you just have to know =
that odd
> > > > > seq number means a write operation is in effect'. I know you have=
 a comment
> > > > > here, but I think something like:
> > > > >
> > > > >         if (has_mm_been_modified(priv) ||
> > > > >
> > > > > Would be a lot clearer.
> > > >
> > > > Yeah, I was thinking about that. I think an even cleaner way would =
be
> > > > to remember the return value of mmap_lock_speculate_try_begin() and
> > > > pass it around. I was hoping to avoid that extra parameter but soun=
ds
> > > > like for the sake of clarity that would be preferable?
> > >
> > > You know, it's me so I might have to mention a helper struct here :P =
it's
> > > the two most Lorenzo things - helper sructs and churn...
> > >
> > > >
> > > > >
> > > > > Again this speaks to the usefulness of abstracting all this logic=
 from the
> > > > > proc code, we are putting super delicate VMA stuff here and it's =
just not
> > > > > the right place.
> > > > >
> > > > > As an aside, I don't see coverage in the process_addrs documentat=
ion on
> > > > > sequence number odd/even or speculation?
> > > > >
> > > > > I think we probably need to cover this to maintain an up-to-date
> > > > > description of how the VMA locking mechanism works and is used?
> > > >
> > > > I think that's a very low level technical detail which I should not
> > > > have exposed here. As I mentioned, I should simply store the return
> > > > value of mmap_lock_speculate_try_begin() instead of doing these tri=
cky
> > > > mm_wr_seq checks.
> > >
> > > Right yeah I'm all for simplifying if we can! Sounds sensible.
> > >
> > > >
> > > > >
> > > > > > +                 mmap_lock_speculate_retry(priv->mm, priv->mm_=
wr_seq)) {
> > > > >
> > > > > Nit, again unrelated to this series, but would be useful to add a=
 comment
> > > > > to mmap_lock_speculate_retry() to indicate that a true return val=
ue
> > > > > indicates a retry is needed, or renaming it.
> > > >
> > > > This is how seqcount API works in general. Note that
> > > > mmap_lock_speculate_retry() is just a wrapper around
> > > > read_seqcount_retry().
> > >
> > > Yeah, I guess I can moan to PeterZ about that :P
> > >
> > > It's not a big deal honestly, but it was just something I found confu=
sing.
> > >
> > > I think adjusting the comment above to something like:
> > >
> > >                 /*
> > >                  * Verify if the address space changed since vma look=
up, or if
> > >                  * the speculative lock needs to be retried.
> > >                  */
> > >
> > > Or perhaps somethig more in line with the description you give below?
> >
> > Ack.
> >
> > >
> > > >
> > > > >
> > > > > Maybe mmap_lock_speculate_needs_retry()? Also I think that functi=
on needs a
> > > > > comment.
> > > >
> > > > See https://elixir.bootlin.com/linux/v6.15.1/source/include/linux/s=
eqlock.h#L395
> > >
> > > Yeah I saw that, but going 2 levels deep to read a comment isn't grea=
t.
> > >
> > > But again this isn't the end of the world.
> > >
> > > >
> > > > >
> > > > > Naming is hard :P
> > > > >
> > > > > Anyway the totality of this expression is 'something changed' or =
'read
> > > > > section retry required'.
> > > >
> > > > Not quite. The expression is "something is changed from under us or
> > > > something was changing even before we started VMA lookup". Or in mo=
re
> > > > technical terms, mmap_write_lock was acquired while we were locking
> > > > the VMA or mmap_write_lock was already held even before we started =
the
> > > > VMA search.
> > >
> > > OK so read section retry required =3D the seq num changes from under =
us
> > > (checked carefully with memory barriers and carefully considered and
> > > thought out such logic), and the priv->mm_wr_seq check before it is t=
he
> > > 'was this changed even before we began?'
> > >
> > > I wonder btw if we could put both into a single helper function to ch=
eck
> > > whether that'd be clearer.
> >
> > So this will look something like this:
> >
> > priv->can_speculate =3D mmap_lock_speculate_try_begin();
> > ...
> > if (!priv->can_speculate || mmap_lock_speculate_retry()) {
> >     // fallback
> > }
> >
> > Is that descriptive enough?
> >
> > >
> > > >
> > > > >
> > > > > Under what circumstances would this happen?
> > > >
> > > > See my previous comment and I hope that clarifies it.
> > >
> > > Thanks!
> > >
> > > >
> > > > >
> > > > > OK so we're into the 'retry' logic here:
> > > > >
> > > > > > +                     vma_iter_init(&priv->iter, priv->mm, last=
_pos);
> > > > >
> > > > > I'd definitely want Liam to confirm this is all above board and c=
orrect, as
> > > > > these operations are pretty sensitive.
> > > > >
> > > > > But assuming this is safe, we reset the iterator to the last posi=
tion...
> > > > >
> > > > > > +                     if (vma !=3D vma_next(&priv->iter))
> > > > >
> > > > > Then assert the following VMA is the one we seek.
> > > > >
> > > > > > +                             goto err;
> > > > >
> > > > > Might this ever be the case in the course of ordinary operation? =
Is this
> > > > > really an error?
> > > >
> > > > This simply means that the VMA we found before is not at the place =
we
> > > > found it anymore. The locking fails and we should retry.
> > >
> > > I know it's pedantic but feels like 'err' is not a great name for thi=
s.
> > >
> > > Maybe 'nolock' or something? Or 'lock_failed'?
> >
> > lock_failed sounds good.
> >
> >
> > >
> > > >
> > > > >
> > > > > > +             }
> > > > > > +     }
> > > > > > +
> > > > > > +     priv->locked_vma =3D vma;
> > > > > > +
> > > > > > +     return vma;
> > > > > > +err:
> > > > >
> > > > > As queried above, is this really an error path or something we mi=
ght expect
> > > > > to happen that could simply result in an expected fallback to mma=
p lock?
> > > >
> > > > It's a failure to lock the VMA, which is handled by retrying under
> > > > mmap_read_lock. So, trylock_vma() failure does not mean a fault in =
the
> > > > logic. It's expected to happen occasionally.
> > >
> > > Ack yes understood thanks!
> > >
> > > >
> > > > >
> > > > > > +     vma_end_read(vma);
> > > > > > +     return NULL;
> > > > > > +}
> > > > > > +
> > > > > > +
> > > > > > +static void unlock_vma(struct proc_maps_private *priv)
> > > > > > +{
> > > > > > +     if (priv->locked_vma) {
> > > > > > +             vma_end_read(priv->locked_vma);
> > > > > > +             priv->locked_vma =3D NULL;
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > > +static const struct seq_operations proc_pid_maps_op;
> > > > > > +
> > > > > > +static inline bool lock_content(struct seq_file *m,
> > > > > > +                             struct proc_maps_private *priv)
> > > > >
> > > > > Pedantic I know but isn't 'lock_content' a bit generic?
> > > > >
> > > > > He says, not being able to think of a great alternative...
> > > > >
> > > > > OK maybe fine... :)
> > > >
> > > > Yeah, I struggled with this myself. Help in naming is appreciated.
> > >
> > > This is where it gets difficult haha so easy to point out but not so =
easy
> > > to fix...
> > >
> > > lock_vma_range()?
> >
> > Ack.
> >
> > >
> > > >
> > > > >
> > > > > > +{
> > > > > > +     /*
> > > > > > +      * smaps and numa_maps perform page table walk, therefore=
 require
> > > > > > +      * mmap_lock but maps can be read with locked vma only.
> > > > > > +      */
> > > > > > +     if (m->op !=3D &proc_pid_maps_op) {
> > > > >
> > > > > Nit but is there a neater way of checking this? Actually I imagin=
e not...
> > > > >
> > > > > But maybe worth, instead of forward-declaring proc_pid_maps_op, f=
orward declare e.g.
> > > > >
> > > > > static inline bool is_maps_op(struct seq_file *m);
> > > > >
> > > > > And check e.g.
> > > > >
> > > > > if (is_maps_op(m)) { ... in the above.
> > > > >
> > > > > Yeah this is nitty not a massive del :)
> > > >
> > > > I'll try that and see how it looks. Thanks!
> > >
> > > Thanks!
> > >
> > > >
> > > > >
> > > > > > +             if (mmap_read_lock_killable(priv->mm))
> > > > > > +                     return false;
> > > > > > +
> > > > > > +             priv->mmap_locked =3D true;
> > > > > > +     } else {
> > > > > > +             rcu_read_lock();
> > > > > > +             priv->locked_vma =3D NULL;
> > > > > > +             priv->mmap_locked =3D false;
> > > > > > +     }
> > > > > > +
> > > > > > +     return true;
> > > > > > +}
> > > > > > +
> > > > > > +static inline void unlock_content(struct proc_maps_private *pr=
iv)
> > > > > > +{
> > > > > > +     if (priv->mmap_locked) {
> > > > > > +             mmap_read_unlock(priv->mm);
> > > > > > +     } else {
> > > > > > +             unlock_vma(priv);
> > > > > > +             rcu_read_unlock();
> > > > >
> > > > > Does this always get called even in error cases?
> > > >
> > > > What error cases do you have in mind? Error to lock a VMA is handle=
d
> > > > by retrying and we should be happily proceeding. Please clarify.
> > >
> > > Well it was more of a question really - can the traversal through
> > > /proc/$pid/maps result in some kind of error that doesn't reach this
> > > function, thereby leaving things locked mistakenly?
> > >
> > > If not then happy days :)
> > >
> > > I'm guessing there isn't.
> >
> > There is EINTR in m_start() but unlock_content() won't be called in
> > that case, so I think we are good.
> >
> > >
> > > >
> > > > >
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > > +static struct vm_area_struct *get_next_vma(struct proc_maps_pr=
ivate *priv,
> > > > > > +                                        loff_t last_pos)
> > > > >
> > > > > We really need a generalised RCU multi-VMA locking mechanism (we'=
re looking
> > > > > into madvise VMA locking atm with a conservative single VMA lock =
at the
> > > > > moment, but in future we probably want to be able to span multipl=
e for
> > > > > instance) and this really really feels like it doesn't belong in =
this proc
> > > > > code.
> > > >
> > > > Ok, I guess you are building a case to move more code into vma.c? I
> > > > see what you are doing :)
> > >
> > > Haha damn it, my evil plans revealed :P
> > >
> > > >
> > > > >
> > > > > >  {
> > > > > > -     struct vm_area_struct *vma =3D vma_next(&priv->iter);
> > > > > > +     struct vm_area_struct *vma;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (priv->mmap_locked)
> > > > > > +             return vma_next(&priv->iter);
> > > > > > +
> > > > > > +     unlock_vma(priv);
> > > > > > +     /*
> > > > > > +      * Record sequence number ahead of vma lookup.
> > > > > > +      * Odd seqcount means address space modification is in pr=
ogress.
> > > > > > +      */
> > > > > > +     mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq)=
;
> > > > >
> > > > > Hmm we're discarding the return value I guess we don't really car=
e about
> > > > > that at this stage? Or do we? Do we want to assert the read criti=
cal
> > > > > section state here?
> > > >
> > > > Yeah, as I mentioned, instead of relying on priv->mm_wr_seq being o=
dd
> > > > I should record the return value of mmap_lock_speculate_try_begin()=
.
> > > > In the functional sense these two are interchangeable.
> > >
> > > Ack, thanks!
> > >
> > > >
> > > > >
> > > > > I guess since we have the mm_rq_seq which we use later it's the s=
ame thing
> > > > > and doesn't matter.
> > > >
> > > > Yep.
> > >
> > > Ack
> > >
> > > >
> > > > >
> > > > > ~~(off topic a bit)~~
> > > > >
> > > > > OK so off-topic again afaict we're doing something pretty horribl=
y gross here.
> > > > >
> > > > > We pass &priv->mm_rw_seq as 'unsigned int *seq' field to
> > > > > mmap_lock_speculate_try_begin(), which in turn calls:
> > > > >
> > > > >         return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
> > > > >
> > > > > And this is defined as a macro of:
> > > > >
> > > > > #define raw_seqcount_try_begin(s, start)                         =
       \
> > > > > ({                                                               =
       \
> > > > >         start =3D raw_read_seqcount(s);                          =
         \
> > > > >         !(start & 1);                                            =
       \
> > > > > })
> > > > >
> > > > > So surely this expands to:
> > > > >
> > > > >         *seq =3D raw_read_seqcount(&mm->mm_lock_seq);
> > > > >         !(*seq & 1) // return true if even, false if odd
> > > > >
> > > > > So we're basically ostensibly passing an unsigned int, but becaus=
e we're
> > > > > calling a macro it's actually just 'text' and we're instead able =
to then
> > > > > reassign the underlying unsigned int * ptr and... ugh.
> > > > >
> > > > > ~~(/off topic a bit)~~
> > > >
> > > > Aaaand we are back...
> > >
> > > :)) yeah this isn't your fault, just a related 'wtf' moan :P we can p=
retend
> > > like it never happened *ahem*
> > >
> > > >
> > > > >
> > > > > > +     vma =3D vma_next(&priv->iter);
> > > > >
> > > > >
> > > > >
> > > > > > +     if (!vma)
> > > > > > +             return NULL;
> > > > > > +
> > > > > > +     vma =3D trylock_vma(priv, vma, last_pos, true);
> > > > > > +     if (vma)
> > > > > > +             return vma;
> > > > > > +
> > > > >
> > > > > Really feels like this should be a boolean... I guess neat to res=
et vma if
> > > > > not locked though.
> > > >
> > > > I guess I can change trylock_vma() to return boolean. We always ret=
urn
> > > > the same vma or NULL I think.
> > >
> > > Ack, I mean I guess you're looking at reworking it in general so can =
take
> > > this into account.
> >
> > Ack.
> >
> > >
> > > >
> > > > >
> > > > > > +     /* Address space got modified, vma might be stale. Re-loc=
k and retry */
> > > > >
> > > > > > +     rcu_read_unlock();
> > > > >
> > > > > Might we see a VMA possibly actually legit unmapped in a race her=
e? Do we
> > > > > need to update last_pos/ppos to account for this? Otherwise we mi=
ght just
> > > > > fail on the last_pos >=3D vma->vm_end check in trylock_vma() no?
> > > >
> > > > Yes, it can happen and trylock_vma() will fail to lock the modified
> > > > VMA. That's by design. In such cases we retry the lookup from the s=
ame
> > > > last_pos.
> > >
> > > OK and then we're fine with it because the gap we report will be an a=
ctual
> > > gap.
> >
> > Yes, either the actual gap or a VMA newly mapped at that address.
> >
> > >
> > > >
> > > > >
> > > > > > +     ret =3D mmap_read_lock_killable(priv->mm);
> > > > >
> > > > > Shouldn't we set priv->mmap_locked here?
> > > >
> > > > No, we will drop the mmap_read_lock shortly. priv->mmap_locked
> > > > indicates the overall mode we operate in. When priv->mmap_locked=3D=
false
> > > > we can still temporarily take the mmap_read_lock when retrying and
> > > > then drop it after we found the VMA.
> > >
> > > Right yeah, makes sense.
> > >
> > > >
> > > > >
> > > > > I guess not as we are simply holding the mmap lock to definitely =
get the
> > > > > next VMA.
> > > >
> > > > Correct.
> > >
> > > Ack
> > >
> > > >
> > > > >
> > > > > > +     rcu_read_lock();
> > > > > > +     if (ret)
> > > > > > +             return ERR_PTR(ret);
> > > > > > +
> > > > > > +     /* Lookup the vma at the last position again under mmap_r=
ead_lock */
> > > > > > +     vma_iter_init(&priv->iter, priv->mm, last_pos);
> > > > > > +     vma =3D vma_next(&priv->iter);
> > > > > > +     if (vma) {
> > > > > > +             vma =3D trylock_vma(priv, vma, last_pos, false);
> > > > >
> > > > > Be good to use Liam's convention of /* mm_unstable =3D */ false t=
o make this
> > > > > clear.
> > > >
> > > > Yeah, I'm thinking of splitting trylock_vma() into two separate
> > > > functions for mm_unstable=3Dtrue and mm_unstable=3Dfalse cases.
> > >
> > > Yes :) thanks!
> > >
> > > >
> > > > >
> > > > > Find it kinda weird again we're 'trylocking' something we already=
 have
> > > > > locked via the mmap lock but I already mentioend this... :)
> > > > >
> > > > > > +             WARN_ON(!vma); /* mm is stable, has to succeed */
> > > > >
> > > > > I wonder if this is really useful, at any rate seems like there'd=
 be a
> > > > > flood here so WARN_ON_ONCE()? Perhaps VM_WARN_ON_ONCE() given thi=
s really
> > > > > really ought not happen?
> > > >
> > > > Well, I can't use BUG_ON(), so WARN_ON() is the next tool I have :)=
 In
> > > > reality this should never happen, so
> > > > WARN_ON/WARN_ON_ONCE/WARN_ON_RATELIMITED/or whatever does not matte=
r
> > > > much.
> > >
> > > I think if you refactor into two separate functions this becomes even=
 more
> > > unnecessary because then you are using a vma lock function that can n=
ever
> > > fail etc.
> > >
> > > I mean maybe just stick a VM_ in front if it's not going to happen bu=
t for
> > > debug/dev/early stabilisation purposes we want to keep an eye on it.
> >
> > Yeah, I think after refactoring we won't need any warnings here.
> >
> > >
> > > >
> > > > >
> > > > > > +     }
> > > > > > +     mmap_read_unlock(priv->mm);
> > > > > > +
> > > > > > +     return vma;
> > > > > > +}
> > > > > > +
> > > > > > +#else /* CONFIG_PER_VMA_LOCK */
> > > > > >
> > > > > > +static inline bool lock_content(struct seq_file *m,
> > > > > > +                             struct proc_maps_private *priv)
> > > > > > +{
> > > > > > +     return mmap_read_lock_killable(priv->mm) =3D=3D 0;
> > > > > > +}
> > > > > > +
> > > > > > +static inline void unlock_content(struct proc_maps_private *pr=
iv)
> > > > > > +{
> > > > > > +     mmap_read_unlock(priv->mm);
> > > > > > +}
> > > > > > +
> > > > > > +static struct vm_area_struct *get_next_vma(struct proc_maps_pr=
ivate *priv,
> > > > > > +                                        loff_t last_pos)
> > > > > > +{
> > > > > > +     return vma_next(&priv->iter);
> > > > > > +}
> > > > > > +
> > > > > > +#endif /* CONFIG_PER_VMA_LOCK */
> > > > > > +
> > > > > > +static struct vm_area_struct *proc_get_vma(struct seq_file *m,=
 loff_t *ppos)
> > > > > > +{
> > > > > > +     struct proc_maps_private *priv =3D m->private;
> > > > > > +     struct vm_area_struct *vma;
> > > > > > +
> > > > > > +     vma =3D get_next_vma(priv, *ppos);
> > > > > > +     if (IS_ERR(vma))
> > > > > > +             return vma;
> > > > > > +
> > > > > > +     /* Store previous position to be able to restart if neede=
d */
> > > > > > +     priv->last_pos =3D *ppos;
> > > > > >       if (vma) {
> > > > > > -             *ppos =3D vma->vm_start;
> > > > > > +             /*
> > > > > > +              * Track the end of the reported vma to ensure po=
sition changes
> > > > > > +              * even if previous vma was merged with the next =
vma and we
> > > > > > +              * found the extended vma with the same vm_start.
> > > > > > +              */
> > > > >
> > > > > Right, so observing repetitions is acceptable in such circumstanc=
es? I mean
> > > > > I agree.
> > > >
> > > > Yep, the VMA will be reported twice in such a case.
> > >
> > > Ack.
> > >
> > > >
> > > > >
> > > > > > +             *ppos =3D vma->vm_end;
> > > > >
> > > > > If we store the end, does the last_pos logic which resets the VMA=
 iterator
> > > > > later work correctly in all cases?
> > > >
> > > > I think so. By resetting to vma->vm_end we will start the next sear=
ch
> > > > from the address right next to the last reported VMA, no?
> > >
> > > Yeah, I was just wondering whether there were any odd corner case tha=
t
> > > might be problematic.
> > >
> > > But since we treat last_pos as inclusive as you said in a response ab=
ove,
> > > and of course vma->vm_end is exclusive, then this makes sense.
> > >
> > > >
> > > > >
> > > > > >       } else {
> > > > > >               *ppos =3D -2UL;
> > > > > >               vma =3D get_gate_vma(priv->mm);
> > > > >
> > > > > Is it always the case that !vma here implies a gate VMA (yuck yuc=
k)? I see
> > > > > this was the original logic, but maybe put a comment about this a=
s it's
> > > > > weird and confusing? (and not your fault obviously :P)
> > > >
> > > > What comment would you like to see here?
> > >
> > > It's so gross this. I guess something about the inner workings of gat=
e VMAs
> > > and the use of -2UL as a weird sentinel etc.
> >
> > Ok, I'll try to add a meaningful comment here.
> >
> > >
> > > But this is out of scope here.
> > >
> > > >
> > > > >
> > > > > Also, are all locks and state corectly handled in this case? Seem=
s like one
> > > > > of this nasty edge case situations that could have jagged edges..=
.
> > > >
> > > > I think we are fine. get_next_vma() returned NULL, so we did not lo=
ck
> > > > any VMA and priv->locked_vma should be NULL.
> > > >
> > > > >
> > > > > > @@ -163,19 +322,21 @@ static void *m_start(struct seq_file *m, =
loff_t *ppos)
> > > > > >               return NULL;
> > > > > >       }
> > > > > >
> > > > > > -     if (mmap_read_lock_killable(mm)) {
> > > > > > +     if (!lock_content(m, priv)) {
> > > > >
> > > > > Nice that this just slots in like this! :)
> > > > >
> > > > > >               mmput(mm);
> > > > > >               put_task_struct(priv->task);
> > > > > >               priv->task =3D NULL;
> > > > > >               return ERR_PTR(-EINTR);
> > > > > >       }
> > > > > >
> > > > > > +     if (last_addr > 0)
> > > > >
> > > > > last_addr is an unsigned long, this will always be true.
> > > >
> > > > Not unless last_addr=3D=3D0. That's what I'm really checking here: =
is this
> > > > the first invocation of m_start(), in which case we are starting fr=
om
> > > > the beginning and not restarting from priv->last_pos. Should I add =
a
> > > > comment?
> > >
> > > Yeah sorry I was being an idiot, I misread this as >=3D 0 obviously.
> > >
> > > I had assumed you were checking for the -2 and -1 cases (though -1 ea=
rly
> > > exits above).
> > >
> > > So in that case, are you handling the gate VMA correctly here? Surely=
 we
> > > should exclude that? Wouldn't setting ppos =3D last_addr =3D priv->la=
st_pos be
> > > incorrect if this were a gate vma?
> >
> > You are actually right. last_addr can be -2UL here and we should not
> > override it. I'll fix it. Thanks!
> >
> > >
> > > Even if we then call get_gate_vma() we've changed these values? Or is=
 that
> > > fine?
> > >
> > > And yeah a comment would be good thanks!
> > >
> > > >
> > > > >
> > > > > You probably want to put an explicit check for -1UL, -2UL here or=
?
> > > > >
> > > > > God I hate this mechanism for indicating gate VMA... yuck yuck (a=
gain, this
> > > > > bit not your fault :P)
> > > >
> > > > No, I don't care here about -1UL, -2UL, just that last_addr=3D=3D0 =
or not.
> > >
> > > OK, so maybe above concerns not a thing.
> > >
> > > >
> > > > >
> > > > > > +             *ppos =3D last_addr =3D priv->last_pos;
> > > > > >       vma_iter_init(&priv->iter, mm, last_addr);
> > > > > >       hold_task_mempolicy(priv);
> > > > > >       if (last_addr =3D=3D -2UL)
> > > > > >               return get_gate_vma(mm);
> > > > > >
> > > > > > -     return proc_get_vma(priv, ppos);
> > > > > > +     return proc_get_vma(m, ppos);
> > > > > >  }
> > > > > >
> > > > > >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > > > > > @@ -184,7 +345,7 @@ static void *m_next(struct seq_file *m, voi=
d *v, loff_t *ppos)
> > > > > >               *ppos =3D -1UL;
> > > > > >               return NULL;
> > > > > >       }
> > > > > > -     return proc_get_vma(m->private, ppos);
> > > > > > +     return proc_get_vma(m, ppos);
> > > > > >  }
> > > > > >
> > > > > >  static void m_stop(struct seq_file *m, void *v)
> > > > > > @@ -196,7 +357,7 @@ static void m_stop(struct seq_file *m, void=
 *v)
> > > > > >               return;
> > > > > >
> > > > > >       release_task_mempolicy(priv);
> > > > > > -     mmap_read_unlock(mm);
> > > > > > +     unlock_content(priv);
> > > > > >       mmput(mm);
> > > > > >       put_task_struct(priv->task);
> > > > > >       priv->task =3D NULL;
> > > > > > --
> > > > > > 2.49.0.1266.g31b7d2e469-goog
> > > > > >
> > > > >
> > > > > Sorry to add to workload by digging into so many details here, bu=
t we
> > > > > really need to make sure all the i's are dotted and t's are cross=
ed given
> > > > > how fiddly and fragile this stuff is :)
> > > > >
> > > > > Very much appreciate the work, this is a significant improvement =
and will
> > > > > have a great deal of real world impact!
> > > >
> > > > Thanks for meticulously going over the code! This is really helpful=
.
> > > > Suren.
> > >
> > > No problem!
> > >
> > > >
> > > > >
> > > > > Cheers, Lorenzo

