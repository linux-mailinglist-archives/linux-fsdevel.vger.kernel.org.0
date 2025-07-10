Return-Path: <linux-fsdevel+bounces-54433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97240AFFA55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762E15430D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673492877E5;
	Thu, 10 Jul 2025 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfdXKpRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9D23ABBF
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131002; cv=none; b=im4MmIoatSqnOq/R+BUuNyRbNQ21xLIyWWKaIVYpxlqIM1EYK3O0oE4H+ujVwzT1hxqNAmjSvOhdhaAMYDFcBareEm19riMFZxnngm0kAg8191MYpZmAIjzOGuouBCJrjFx13rbcn+dMVe36qxggzG182UrB81inyZc/OttGpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131002; c=relaxed/simple;
	bh=Zkde/MCMnr1avbN8QLSpKrFKu6M3pzU6/6WktGYgcP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BgGY6T6pSK1yiaJLOGmtlqWe9jifuiGW/VQHeF/UJct3uUm5wCgHa+WeDPiPg7UOVo7g3A21M6SzscnwAkTzBR7sBNaN4KgbqxfsLrf2bqJgNxg1/Y2bUVrp42E8blzfn7FmrUjPIYaGAfL50PnJzKMnHUBAvnfVoIS+fKjD5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AfdXKpRq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso166061cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752130998; x=1752735798; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czjb2588E9c6YybnVN7gEK08FqLa9riqWhr4gBg65c4=;
        b=AfdXKpRqGwPsTh/QBYf/LtZc2j5z4EU6GacIm573p+onxpG/mUaQwAZwOaA8I03OZB
         YrvZnF+uL7YP0BMB02h5nBaot3PN5Lxt5yb9qeKcR3gEibHGi6jQ2b4IgFCxOQnni4Nt
         3MHElDCkRDzBAnv6ZIOAyph6OLlrLX9Zp8ncSCOQNJR/8EOXH75RPCeiASfftulpgTAO
         VkFg4Y1hn7c8SVCh8F3TzrfIdcewO90e3OBAuTtOGUm74kbs9MM7SWCu+lgnV4/KW8q9
         Kil0EKLEiXCKu8jW8ayavUB20KSMgOWpZsRwziMnvcv+/8GD3jABtC3LLcz6seGfOkuC
         jLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752130998; x=1752735798;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czjb2588E9c6YybnVN7gEK08FqLa9riqWhr4gBg65c4=;
        b=tt0qnU9B/pHI4AoqSu8FEUJiGszXztPlU3uF887NP7Li24/2ew9rwCu3QuTAbW7/YE
         Zp26Buy2qA+uVZ8gdwGrP8Xml9njNPHdAzTWUfLnp46t5rUg+M+gheRF2DZ2olXcaefl
         DjdxrpQFlRDFA/0SR5u8sLkHjyYJo22tOs5TFIJ7D7ZOR/XnJ1tUcaHIJHuqgsxKBrtg
         hcM99H+BA7G7D8WkBDzgZggHPeVyi2zY07o/Mvj20YMDwl15qaT7CiZ/wEf16ou3oWil
         6n8KeGr6llB5NU6M7RuNuI8FF8UGs0Fy6p0YYUGlhwWLOiqzJMN7SDc8OKNBReQQ5B0t
         nkdg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ0FE5l+lty7h19pdWmg3y5hYPhpFSO6Wuf5isRn/eHottor3EJO8QSPhsXW4r8rI9hCzcKYxRKyaUR0nP@vger.kernel.org
X-Gm-Message-State: AOJu0YxhL4+bdFVQNroWnYeqsFYwOT3dn34tO9lvqkSOL5Naw5z5Bj8q
	D96HDcgEpNWJ7gw1xM2k9W0bg+1oKBJ1wd0xOAdiPzJiLYiILTwQnjzocFRbLtat1yzlmN8IkA8
	xE/ASLjkMMDUgPqZxVeOLzOy1/k/JTFgV9KrswXQw
X-Gm-Gg: ASbGncvzcs1FWhX7AqHbkmSK6QHVb8Yq90OPmQE1bYvIb/Cf8eqR/jzy7YbN20QirJ8
	F8krt5Y9SQm4ZSwl4bfmKn2akhThuPivcDagKCQ/zHK0rUe+LiicDUq6/rDTX5J0yrT3HvWusFt
	6erwi2ZRFjZAJecB+KCcLopuhAcKPYaOwsH5/EoGrHS/oo2XdpH04ewAF/qlqHQjX1Ggx8Vaewe
	Q==
X-Google-Smtp-Source: AGHT+IF5cYv23UdH28BLI5Dpa0xi/QijAGQHszwhzAY2gHXh+9/fijn3Wu/NhxWdHt+CT++oYjA8XVxu0MQ0aYWeYmI=
X-Received: by 2002:ac8:5fc3:0:b0:4a5:a9f4:b7c2 with SMTP id
 d75a77b69052e-4a9ec849010mr1976131cf.17.1752130997981; Thu, 10 Jul 2025
 00:03:17 -0700 (PDT)
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
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm> <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
In-Reply-To: <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Jul 2025 00:03:06 -0700
X-Gm-Features: Ac12FXyB6946DkPN-YjZ5xyUeJCgHbkvs1R9oIUtLa3p_9gPg-mvfpHqpMIC_X0
Message-ID: <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
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

On Wed, Jul 9, 2025 at 10:47=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jul 9, 2025 at 4:12=E2=80=AFPM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [250709 11:06]:
> > > On Wed, Jul 9, 2025 at 3:03=E2=80=AFPM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> > > >
> > > > On 7/9/25 16:43, Suren Baghdasaryan wrote:
> > > > > On Wed, Jul 9, 2025 at 1:57=E2=80=AFAM Vlastimil Babka <vbabka@su=
se.cz> wrote:
> > > > >>
> > > > >> On 7/8/25 01:10, Suren Baghdasaryan wrote:
> > > > >> >>> +     rcu_read_unlock();
> > > > >> >>> +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> > > > >> >>> +     rcu_read_lock();
> > > > >> >> OK I guess we hold the RCU lock the whole time as we traverse=
 except when
> > > > >> >> we lock under mmap lock.
> > > > >> > Correct.
> > > > >>
> > > > >> I wonder if it's really necessary? Can't it be done just inside
> > > > >> lock_next_vma()? It would also avoid the unlock/lock dance quote=
d above.
> > > > >>
> > > > >> Even if we later manage to extend this approach to smaps and emp=
loy rcu
> > > > >> locking to traverse the page tables, I'd think it's best to sepa=
rate and
> > > > >> fine-grain the rcu lock usage for vma iterator and page tables, =
if only to
> > > > >> avoid too long time under the lock.
> > > > >
> > > > > I thought we would need to be in the same rcu read section while
> > > > > traversing the maple tree using vma_next() but now looking at it,
> > > > > maybe we can indeed enter only while finding and locking the next
> > > > > vma...
> > > > > Liam, would that work? I see struct ma_state containing a node fi=
eld.
> > > > > Can it be freed from under us if we find a vma, exit rcu read sec=
tion
> > > > > then re-enter rcu and use the same iterator to find the next vma?
> > > >
> > > > If the rcu protection needs to be contigous, and patch 8 avoids the=
 issue by
> > > > always doing vma_iter_init() after rcu_read_lock() (but does it rea=
lly avoid
> > > > the issue or is it why we see the syzbot reports?) then I guess in =
the code
> > > > quoted above we also need a vma_iter_init() after the rcu_read_lock=
(),
> > > > because although the iterator was used briefly under mmap_lock prot=
ection,
> > > > that was then unlocked and there can be a race before the rcu_read_=
lock().
> > >
> > > Quite true. So, let's wait for Liam's confirmation and based on his
> > > answer I'll change the patch by either reducing the rcu read section
> > > or adding the missing vma_iter_init() after we switch to mmap_lock.
> >
> > You need to either be under rcu or mmap lock to ensure the node in the
> > maple state hasn't been freed (and potentially, reallocated).
> >
> > So in this case, in the higher level, we can hold the rcu read lock for
> > a series of walks and avoid re-walking the tree then the performance
> > would be better.
>
> Got it. Thanks for confirming!
>
> >
> > When we return to userspace, then we should drop the rcu read lock and
> > will need to vma_iter_set()/vma_iter_invalidate() on return.  I thought
> > this was being done (through vma_iter_init()), but syzbot seems to
> > indicate a path that was missed?
>
> We do that in m_start()/m_stop() by calling
> lock_vma_range()/unlock_vma_range() but I think I have two problems
> here:
> 1. As Vlastimil mentioned I do not reset the iterator when falling
> back to mmap_lock and exiting and then re-entering rcu read section;
> 2. I do not reset the iterator after exiting rcu read section in
> m_stop() and re-entering it in m_start(), so the later call to
> lock_next_vma() might be using an iterator with a node that was freed
> (and possibly reallocated).
>
> >
> > This is the same thing that needed to be done previously with the mmap
> > lock, but now under the rcu lock.
> >
> > I'm not sure how to mitigate the issue with the page table, maybe we
> > guess on the number of vmas that we were doing for 4k blocks of output
> > and just drop/reacquire then.  Probably a problem for another day
> > anyways.
> >
> > Also, I think you can also change the vma_iter_init() to vma_iter_set()=
,
> > which is slightly less code under the hood.  Vlastimil asked about this
> > and it's probably a better choice.
>
> Ack.
> I'll update my series with these fixes and all comments I received so
> far, will run the reproducers to confirm no issues and repost them
> later today.

I have the patchset ready but would like to test it some more. Will
post it tomorrow.

> Thanks,
> Suren.
>
> >
> > Thanks,
> > Liam
> >

