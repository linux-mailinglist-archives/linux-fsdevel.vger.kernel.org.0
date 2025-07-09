Return-Path: <linux-fsdevel+bounces-54377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D23AFF017
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 19:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0A51C83199
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796782356BC;
	Wed,  9 Jul 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuOTuIqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFC21D001
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083241; cv=none; b=GBOhgG5y56wZ1n8fuZUKtH+YMcdbDMPsY5W9OxD6oPd7EoJpSLfwGyaHoUrmOpyfpjugKI5F2t2XY8XLPRMvl7eJSOERlG6ZQ3MNAJmAN4dQV7hs0zTWvbWqYPJNixtP/+AmrT8b072q6Dwdkw6ulMzyteGUHYMttY0gnC1eCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083241; c=relaxed/simple;
	bh=GM48os+8pL5T2U30zO10mSKGhOYw3yAFpfmGrD6fmTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Wr9IBRlVaMd8IvBM0AwecPRaCrvSoOiibqoqFMai3dtLRU+JHQVxNECI9wD6U5tnFw/ldPR27H3Vq/kcZFMNED2sXBj48t4pD8uEpML+poixYbUvFbY0TiSFJfOCbi4WR3E0FQhULv75AVO13oie2xXFkiO4rFieUloJ/PzwSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuOTuIqh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a58197794eso13231cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752083238; x=1752688038; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN3J1spQZH5koi2K42kd0GhPe/aELqOGYCyAPqMRKaY=;
        b=MuOTuIqhVHPnJ0xKT438PGLqMImsfifWVGZPa3tmcf2dwskXC/9Rb7QpoUrQ34U3Xn
         yB+fPTzc2v6yLjujX/nQV+wwoQfTHmW3Lek+0ZCA4grUQiJi9R9Qu/94dqB7laUbON1i
         jiSGRRhq8JDklB4tAy+Zt9s7jkgvipvr7ifzfIdcWXtaTHPxHqGF3UhjrL7+xym948UZ
         1UPJ4Sh2rH3MvE5vEgVephCH1x9zX8cFhGspGc4dRBnKWXrRwL6t62FV62r6A29y1fYs
         SsBktSbxGBmv+pK0QYyFkLfl7YK2dv6QIJ5Ya7m7rGqB1V5VR+FfVXc5c7xSmfzGklMX
         CzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083238; x=1752688038;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cN3J1spQZH5koi2K42kd0GhPe/aELqOGYCyAPqMRKaY=;
        b=AVAapvdHPdnG9PIIpV0i5uN5RWz23HyzWQatO7+h/cj0crIrEOL8u3WPlr7X8yvd4E
         j0ttfdMOhdlVwJ5UoV8T/6LPPYU5cMygU7kmSUDHcF/1hag146kFgHQ3me7b6HEEyLun
         CL+2pYgBFGqe36uPSzWg4W4KyuPiBTxf3wA+Yme/q9DWIMrkcAMZRDvM3dkrw0rcAjYp
         Uq/5lW8Wz/PJ9BYEisjK2vRMz+gBN3vrzbcEQd1nPf2hU3Lq0vixJcHdaazlRG6g7898
         G5Miw4bWFZBAB0PSkyTXuddv2R9kfyw9PNA75W1YN99w23G7pauUM4OQP95TCMJWovPf
         nueQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaJiiLcdqxfiShYqlu6Ub76adpjNnFTZQLwTAw9NzRDgi1XLRqU/fGDLh2nxMnE94JcQ3VRtVV3yyue5w1@vger.kernel.org
X-Gm-Message-State: AOJu0YzvtFdpjTWIZXyh6iaWz7hMrHaHVRB68VYxQTWIhGmgrDkmtZVF
	OUxoqb/L1pLeIt3thwVfVXScmRAcBKnpLia9k25JSkh/Xh/rqS7D5O9WsMloPezlbQWa4OXW5Eu
	5P/F03AmUXBZqL//5N2pLze02qZtTRks42Gj7lNFj
X-Gm-Gg: ASbGncuj73QiO9h33MuSaFjBY0tYq6aldjrNbX2j6NlcyyvxoMvy7YagW6iZJaxMHMh
	7JIdspJhSZwnKpKIMXD9jNqL3XZ2E8xQdq9HC7kp5P0TTbREzrW4nlN5mvGkxiHZJV5MndW3sgZ
	nM8rTiuxG/zGo87CURJF145uc7kvohrFYRfKHNdcJ/Dw6paTOZGDHtgtBCbm2r/VRKKfMqNVc=
X-Google-Smtp-Source: AGHT+IEb9yL4kemL51aVpg60aXKmeWtcEpHCM8E6uKXxUeBvlOxi3YCv64SzOVL5NCkC47UGQze2rhIhsvwdXDbQx9M=
X-Received: by 2002:a05:622a:1346:b0:4a9:95a6:3a69 with SMTP id
 d75a77b69052e-4a9eb05d8d9mr149361cf.8.1752083237536; Wed, 09 Jul 2025
 10:47:17 -0700 (PDT)
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
In-Reply-To: <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 17:47:06 +0000
X-Gm-Features: Ac12FXx7m-6kbzNrIap1Lfhn2R7EobVbpfkfdAZXQinEXMeB9hh_cUG7y6G0IHg
Message-ID: <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	david@redhat.com, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:12=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [250709 11:06]:
> > On Wed, Jul 9, 2025 at 3:03=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> > >
> > > On 7/9/25 16:43, Suren Baghdasaryan wrote:
> > > > On Wed, Jul 9, 2025 at 1:57=E2=80=AFAM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> > > >>
> > > >> On 7/8/25 01:10, Suren Baghdasaryan wrote:
> > > >> >>> +     rcu_read_unlock();
> > > >> >>> +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> > > >> >>> +     rcu_read_lock();
> > > >> >> OK I guess we hold the RCU lock the whole time as we traverse e=
xcept when
> > > >> >> we lock under mmap lock.
> > > >> > Correct.
> > > >>
> > > >> I wonder if it's really necessary? Can't it be done just inside
> > > >> lock_next_vma()? It would also avoid the unlock/lock dance quoted =
above.
> > > >>
> > > >> Even if we later manage to extend this approach to smaps and emplo=
y rcu
> > > >> locking to traverse the page tables, I'd think it's best to separa=
te and
> > > >> fine-grain the rcu lock usage for vma iterator and page tables, if=
 only to
> > > >> avoid too long time under the lock.
> > > >
> > > > I thought we would need to be in the same rcu read section while
> > > > traversing the maple tree using vma_next() but now looking at it,
> > > > maybe we can indeed enter only while finding and locking the next
> > > > vma...
> > > > Liam, would that work? I see struct ma_state containing a node fiel=
d.
> > > > Can it be freed from under us if we find a vma, exit rcu read secti=
on
> > > > then re-enter rcu and use the same iterator to find the next vma?
> > >
> > > If the rcu protection needs to be contigous, and patch 8 avoids the i=
ssue by
> > > always doing vma_iter_init() after rcu_read_lock() (but does it reall=
y avoid
> > > the issue or is it why we see the syzbot reports?) then I guess in th=
e code
> > > quoted above we also need a vma_iter_init() after the rcu_read_lock()=
,
> > > because although the iterator was used briefly under mmap_lock protec=
tion,
> > > that was then unlocked and there can be a race before the rcu_read_lo=
ck().
> >
> > Quite true. So, let's wait for Liam's confirmation and based on his
> > answer I'll change the patch by either reducing the rcu read section
> > or adding the missing vma_iter_init() after we switch to mmap_lock.
>
> You need to either be under rcu or mmap lock to ensure the node in the
> maple state hasn't been freed (and potentially, reallocated).
>
> So in this case, in the higher level, we can hold the rcu read lock for
> a series of walks and avoid re-walking the tree then the performance
> would be better.

Got it. Thanks for confirming!

>
> When we return to userspace, then we should drop the rcu read lock and
> will need to vma_iter_set()/vma_iter_invalidate() on return.  I thought
> this was being done (through vma_iter_init()), but syzbot seems to
> indicate a path that was missed?

We do that in m_start()/m_stop() by calling
lock_vma_range()/unlock_vma_range() but I think I have two problems
here:
1. As Vlastimil mentioned I do not reset the iterator when falling
back to mmap_lock and exiting and then re-entering rcu read section;
2. I do not reset the iterator after exiting rcu read section in
m_stop() and re-entering it in m_start(), so the later call to
lock_next_vma() might be using an iterator with a node that was freed
(and possibly reallocated).

>
> This is the same thing that needed to be done previously with the mmap
> lock, but now under the rcu lock.
>
> I'm not sure how to mitigate the issue with the page table, maybe we
> guess on the number of vmas that we were doing for 4k blocks of output
> and just drop/reacquire then.  Probably a problem for another day
> anyways.
>
> Also, I think you can also change the vma_iter_init() to vma_iter_set(),
> which is slightly less code under the hood.  Vlastimil asked about this
> and it's probably a better choice.

Ack.
I'll update my series with these fixes and all comments I received so
far, will run the reproducers to confirm no issues and repost them
later today.
Thanks,
Suren.

>
> Thanks,
> Liam
>

