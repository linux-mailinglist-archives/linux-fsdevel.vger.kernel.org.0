Return-Path: <linux-fsdevel+bounces-55025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD409B06795
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EAC5017E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347F2BE641;
	Tue, 15 Jul 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0noSifIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282D26E718
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610431; cv=none; b=jnuH5UnsgAiepJujbpNTCbhdRh4Q2Coxk25/dcPdIPSpIx5MHL7eQA3tUgmhR/Dyg7RmODg/et9nQQuLnFtFYBjmT4Qb++FUvC+Lg5iahjUZTNlmfgEsrATXnHgh10/9vExVptossUeDfdvKsO74nHDnHvJ7R4PUKVZFPvSu+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610431; c=relaxed/simple;
	bh=tuJwKXRuFX+8Hv424txa6xR8j28WXqvE6aD7LyPgTkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efOnf1/3Grz97VV24XFw9hdCt3JoRYXRr7Q+L3bDIoA3V6gGv97SIC8ZaINh41Y6GTV3CVdKpGXV/1H/GA0GOL/KK3Yaqsc3ENIM7Nuh0qn4dTxYxLnaygN3LDVDO9RlcfIABdWst4gr2+0Ah/ZNGukiotIxzIF/th5BF3/CXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0noSifIr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso9181cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752610428; x=1753215228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnqN+9qSxUNQ+71q6fpzACj+u3aM7v+GPckeC6rcpuk=;
        b=0noSifIr0rccNqW2eoaJF0wT4cUmPRnkDqWbLvjlNunTSzQBgtpzflZDWrg7PXSH/9
         dm758K6WtAanexHM+RsZwUTvSFRDf4gYohZ6hMwOuOOsS0xtSqbcwvMNO2F0bGVxevw1
         yIV9ITnaHdUeoF40DWkuV1k4wzh5Lv65IcHjBwEOLMzJDPJcxtEY2aSm5DROF9kCVy1f
         tqe8Qbd/eJ0jQ3g+8AwUHBl5FqZbxKjOchIiHJZ0aCWxfi8gYzQ9IDIvtQdDFyymhh98
         jOS2PCiuzYeeW4us1bK4YvMdHXLB2n3OcKXkMuwozGx84ezR3RZ+xqBwS1LQceKwLo7O
         wpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610428; x=1753215228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnqN+9qSxUNQ+71q6fpzACj+u3aM7v+GPckeC6rcpuk=;
        b=Et7o6H+wHaq03cLtq6IunUiVHcdys1syS86h6a1W+1sm026C70xWl/mm+FDnT1USMG
         G9RFj/8AuUgpO341Ioe49BCWbD1mJcpi+V+yQbmoNkIVXTFsXMrAKnGz3xawXHEY8Dbv
         IJbl6wkMxv8LhnNvGUuWM+ETWeu9Ws8+ZnbDwFC7S9+5iRpxirSedErdmHXRpBsWKJxu
         F7O2yk10bp4sjIqzI1ETp7FE3cK7S/Ub4DpNvBt0P5BatsjOY9lm8TfWLLItrvJCZGwV
         BZ/QAWqMOWNBDFfICUAM++CYIw8WNdYja/IMbS/LqA65frF5/I2tSEzL5eIjM3LUvusD
         dwPA==
X-Forwarded-Encrypted: i=1; AJvYcCXntOUPiolWuYvAWP0jajtJbbnxOXJCleeISCoSJ/2jA4d8mcymb1NeIiOW3Ao1RzzwT4d7rHB51kxJA6jT@vger.kernel.org
X-Gm-Message-State: AOJu0YxcA2rACsAK8rEp44La5JG3vb54vS9VEnpym6skK2tEblaPfL6+
	QUriHzdk9fDgqGnDVVXYCGShNtDVhQzTEtf1a7JkKWAR3diMSx3ZIjN/8WGkilC7btS0urC7eXm
	d6fgf9Ux/7I+SftYEpwf6ebW6u++fCXVzodlFhk2A
X-Gm-Gg: ASbGnctZPSo+9cHaSYQCDEmRNR3ZTeBWNU2zDUf6AoEXE9nU2NUrgfD7rnr7m/1LVBa
	GiWMe7zmKBw2K0xjTiwvmjTe11mp2GVyu1iZffBIviLw75bpyQ1feyMOFhGH7yBfh7kbK2zBhbl
	4vGzjj4Jpy2WwTCGuf4oPATp6RPgQNxrzj6FIBW9iomEp/S++zG+b5wfN5EeXz+bIiAArV31CrO
	STm44gjopScwHtqZdIi3sGudoA9rrloBXhO
X-Google-Smtp-Source: AGHT+IHz0yCVAXbdoe681ITqxZohUJiYZlX8ylfbpQbm8VmW93+o3sQapqeMltiltwk3XwTrVWx4XRtCYFhEMy9XuIg=
X-Received: by 2002:ac8:7dd1:0:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4ab92567edemr844891cf.10.1752610427738; Tue, 15 Jul 2025
 13:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com>
 <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local> <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz> <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz> <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com> <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
In-Reply-To: <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Jul 2025 13:13:36 -0700
X-Gm-Features: Ac12FXx1qtrIEv4cPL5REuI2yEHzLi9rHCGSMPDn5j2m4o0efnabufB8WvT1p3k
Message-ID: <CAJuCfpH8zsboafV1UWufYhbVXN-yKgMOKm=vr2vBYAPNmPtrvw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	akpm@linux-foundation.org, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:16=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/10/25 19:02, Suren Baghdasaryan wrote:
> > On Thu, Jul 10, 2025 at 12:03=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >>
> >> On Wed, Jul 9, 2025 at 10:47=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >> >
> >> > On Wed, Jul 9, 2025 at 4:12=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> >> > >
> >> > > * Suren Baghdasaryan <surenb@google.com> [250709 11:06]:
> >> > > > On Wed, Jul 9, 2025 at 3:03=E2=80=AFPM Vlastimil Babka <vbabka@s=
use.cz> wrote:
> >> > > > >
> >> > > > > On 7/9/25 16:43, Suren Baghdasaryan wrote:
> >> > > > > > On Wed, Jul 9, 2025 at 1:57=E2=80=AFAM Vlastimil Babka <vbab=
ka@suse.cz> wrote:
> >> > > > > >>
> >> > > > > >> On 7/8/25 01:10, Suren Baghdasaryan wrote:
> >> > > > > >> >>> +     rcu_read_unlock();
> >> > > > > >> >>> +     vma =3D lock_vma_under_mmap_lock(mm, iter, addres=
s);
> >> > > > > >> >>> +     rcu_read_lock();
> >> > > > > >> >> OK I guess we hold the RCU lock the whole time as we tra=
verse except when
> >> > > > > >> >> we lock under mmap lock.
> >> > > > > >> > Correct.
> >> > > > > >>
> >> > > > > >> I wonder if it's really necessary? Can't it be done just in=
side
> >> > > > > >> lock_next_vma()? It would also avoid the unlock/lock dance =
quoted above.
> >> > > > > >>
> >> > > > > >> Even if we later manage to extend this approach to smaps an=
d employ rcu
> >> > > > > >> locking to traverse the page tables, I'd think it's best to=
 separate and
> >> > > > > >> fine-grain the rcu lock usage for vma iterator and page tab=
les, if only to
> >> > > > > >> avoid too long time under the lock.
> >> > > > > >
> >> > > > > > I thought we would need to be in the same rcu read section w=
hile
> >> > > > > > traversing the maple tree using vma_next() but now looking a=
t it,
> >> > > > > > maybe we can indeed enter only while finding and locking the=
 next
> >> > > > > > vma...
> >> > > > > > Liam, would that work? I see struct ma_state containing a no=
de field.
> >> > > > > > Can it be freed from under us if we find a vma, exit rcu rea=
d section
> >> > > > > > then re-enter rcu and use the same iterator to find the next=
 vma?
> >> > > > >
> >> > > > > If the rcu protection needs to be contigous, and patch 8 avoid=
s the issue by
> >> > > > > always doing vma_iter_init() after rcu_read_lock() (but does i=
t really avoid
> >> > > > > the issue or is it why we see the syzbot reports?) then I gues=
s in the code
> >> > > > > quoted above we also need a vma_iter_init() after the rcu_read=
_lock(),
> >> > > > > because although the iterator was used briefly under mmap_lock=
 protection,
> >> > > > > that was then unlocked and there can be a race before the rcu_=
read_lock().
> >> > > >
> >> > > > Quite true. So, let's wait for Liam's confirmation and based on =
his
> >> > > > answer I'll change the patch by either reducing the rcu read sec=
tion
> >> > > > or adding the missing vma_iter_init() after we switch to mmap_lo=
ck.
> >> > >
> >> > > You need to either be under rcu or mmap lock to ensure the node in=
 the
> >> > > maple state hasn't been freed (and potentially, reallocated).
> >> > >
> >> > > So in this case, in the higher level, we can hold the rcu read loc=
k for
> >> > > a series of walks and avoid re-walking the tree then the performan=
ce
> >> > > would be better.
> >> >
> >> > Got it. Thanks for confirming!
> >> >
> >> > >
> >> > > When we return to userspace, then we should drop the rcu read lock=
 and
> >> > > will need to vma_iter_set()/vma_iter_invalidate() on return.  I th=
ought
> >> > > this was being done (through vma_iter_init()), but syzbot seems to
> >> > > indicate a path that was missed?
> >> >
> >> > We do that in m_start()/m_stop() by calling
> >> > lock_vma_range()/unlock_vma_range() but I think I have two problems
> >> > here:
> >> > 1. As Vlastimil mentioned I do not reset the iterator when falling
> >> > back to mmap_lock and exiting and then re-entering rcu read section;
> >> > 2. I do not reset the iterator after exiting rcu read section in
> >> > m_stop() and re-entering it in m_start(), so the later call to
> >> > lock_next_vma() might be using an iterator with a node that was free=
d
> >> > (and possibly reallocated).
> >> >
> >> > >
> >> > > This is the same thing that needed to be done previously with the =
mmap
> >> > > lock, but now under the rcu lock.
> >> > >
> >> > > I'm not sure how to mitigate the issue with the page table, maybe =
we
> >> > > guess on the number of vmas that we were doing for 4k blocks of ou=
tput
> >> > > and just drop/reacquire then.  Probably a problem for another day
> >> > > anyways.
> >> > >
> >> > > Also, I think you can also change the vma_iter_init() to vma_iter_=
set(),
> >> > > which is slightly less code under the hood.  Vlastimil asked about=
 this
> >> > > and it's probably a better choice.
> >> >
> >> > Ack.
> >> > I'll update my series with these fixes and all comments I received s=
o
> >> > far, will run the reproducers to confirm no issues and repost them
> >> > later today.
> >>
> >> I have the patchset ready but would like to test it some more. Will
> >> post it tomorrow.
> >
> > Ok, I found a couple of issues using the syzbot reproducer [1] (which
> > is awesome BTW!):
> > 1. rwsem_acquire_read() inside vma_start_read() at [2] should be moved
> > after the last check, otherwise the lock is considered taken on
> > vma->vm_refcnt overflow;
>
> I think it's fine because if the last check fails there's a
> vma_refcount_put() that includes rwsem_release(), no?

Ah, yes, you are right. This is fine. Obviously trying to figure out
the issue right before a flight is not a good idea :)

>
> > 2. query_matching_vma() is missing unlock_vma() call when it does
> > "goto next_vma;" and re-issues query_vma_find_by_addr(). The previous
> > vma is left locked;
> >
> > [1] https://syzkaller.appspot.com/x/repro.c?x=3D101edf70580000
> > [2] https://elixir.bootlin.com/linux/v6.15.5/source/include/linux/mm.h#=
L747
> >
> > After these fixes it's much harder to fail but I still get one more
> > error copied below. I will continue the investigation and will hold
> > off reposting until this is fixed. That will be next week since I'll
> > be out of town the rest of this week.
> >
> > Andrew, could you please remove this patchset from mm-unstable for now
> > until I fix the issue and re-post the new version?
>
> Andrew can you do that please? We keep getting new syzbot reports.
>
> > The error I got after these fixes is:
>
> I suspect the root cause is the ioctls are not serialized against each ot=
her
> (probably not even against read()) and yet we treat m->private as safe to
> work on. Now we have various fields that are dangerous to race on - for
> example locked_vma and iter races would explain a lot of this.
>
> I suspect as long as we used purely seq_file workflow, it did the right
> thing for us wrt serialization, but the ioctl addition violates that. We
> should rather recheck even the code before this series, if dangerous ioct=
l
> vs read() races are possible. And the ioctl implementation should be
> refactored to use an own per-ioctl-call private context, not the seq_file=
's
> per-file-open context.

Huh, I completely failed to consider this. In hindsight it is quite
obvious... Thanks Vlastimil, I owe you a beer or two.

