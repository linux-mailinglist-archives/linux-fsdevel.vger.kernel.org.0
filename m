Return-Path: <linux-fsdevel+bounces-54539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CACEB0097C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343C21C88514
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACEE2F0E4C;
	Thu, 10 Jul 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAdAtPq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E072EFDB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166969; cv=none; b=W+Ct2a5E6F3Y43BWmzgVMVqXRnYGdjKj8Ds4xYyifRUYvWg8hcCmUhktY/JfYzYFzHL9I+83g5PJMO0PA4GHzBunjr5k1pDAFmz9cpjMUwUZPR45pQMDJmT57USesqYYlHhBTxJPi4Y/gsr3wipVA3hSwywCYffi0s8ibTGt3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166969; c=relaxed/simple;
	bh=1SMGOzOAT0vgNO8zV3p010iARupSLQVy+V5l86LUJFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=j4zk+sEVy8WtCgsKIKaW4zDQ4LAy2LPv8ULcDExRrbsNYkvHe+6DKB4dkxWVyhtyfunXJgIOZgzKEdrMYXenQw/awO8Nvhj3KR6PBINhnJH/AA2fRZvBHulcggJZIudibRLr6cMP3O8ZLxiwemW3hJ5QrO6pbxvV5SBgHeiEFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAdAtPq2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso8271cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752166966; x=1752771766; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnbqDnenE+faR/O+T8DVj3lDgIynjuykWVsJFB/NPT8=;
        b=AAdAtPq2IgCiqaghARGKFcMhbPvsBx0TsFgwanDn++2mJTKl8U/Dyw8532qW9YXDyn
         xCrkiyAWOaMEa6YY3oIL4M3CLDfPJzJZNOwt7MY6hKAZNqnWYLF/EM/BUondVhyXhSf5
         jLs11LFvzsbnCAZEfslC1QBdaefj6tHEcbS1IV1RM526j3I5LGyzeNVxPfxgw5YpWck+
         gwGCXEJ1w3qcaJtAWzgqSQXM1Xwvm2TGNJyWGIIHeTETJ1QUnY5dchTnU55cOPtl8oFQ
         V3d5yviHplKkWIUy4rqtAXM0sycYk79+nEmCI7f8JmZYWbYx9tRWW9Ey4wliMRAIvyYk
         OKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166966; x=1752771766;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnbqDnenE+faR/O+T8DVj3lDgIynjuykWVsJFB/NPT8=;
        b=YBnEo5s9PdWQbQO8MqQ0SzioRQW+kqHXDg9immPQfGjgR+uNEDNeh3EWel5Jxd3bAy
         P6tUwcaa92PjEOrGgs6wnuRO5t+tcAzSMaQYLyL++NJqdMP3p6mPHI+eI2aL27ClyHQK
         udoGXutIS5cUXdi3xgbOfWOnXPwENBdKOWeiQJyABzOTv4TuE46mey/m/FuF/jThmlVj
         RSbca5zKIIKmxySLLETjmlfSWG7fJdcxKBexRKyMOq8J3NRUArxGAIJyIwl88LAKBO7L
         pUvnQMkG4r5XdiKoumWDo3HJ6UBc5Jo0lHL9n6cugadzPaB0IxMR0t2IEqZSlKc/p575
         gvBw==
X-Forwarded-Encrypted: i=1; AJvYcCXeRZKfrlSZKwZBMa8wv373T/SXX0Ig18Ftzg+JVvEQC2odgaOH5sfFRjB3/Ujo8C7TWsWfkG1abQREYJrT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jAmk12Ye9Aln4TxGFnuQ0esXVSQ+94oEUoF4pVoC3HoM2S4T
	Wq7b895vgxjYY/DBsZBiUzZADPEeIaNrgxvst/bjE36PoWwwa9G4/EMo9jeTVO/wGjAo/Kp4ZYT
	zC6ucH4H+WDX0pObHC4xuaMHmNPnlE1LlrUSONkfS
X-Gm-Gg: ASbGnctyhAYK5CZpxp+wCK0Z+ihdpjWQCpgN/GhuVHlGtROwb64sqUl3e8XX/kAs7qg
	ffBZL1LLqzS3TM4w7WTJBtnOVMxASAI3w8w0k13fo8thb0BkkyH1HJzZosFO17QluVgh4zmj3rA
	K4jtel226ofV0RvAyGw9vNbhQ1GdX9QiX335WzTWLRVs1dTsAV4NdEwYSQs+vmqCQzTtWAla7Lz
	uEvTEENnNv3
X-Google-Smtp-Source: AGHT+IFSez0+oMK6YMO+TcCXoRNn3chPSvpcOeXH7/WZTO3+0AFNyoo2EXsI3flRMIii6xEZbuW9CceMGCgKGn1wBAA=
X-Received: by 2002:a05:622a:830f:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4a9eb0d40dbmr4338371cf.10.1752166965550; Thu, 10 Jul 2025
 10:02:45 -0700 (PDT)
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
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com> <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
In-Reply-To: <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Jul 2025 10:02:32 -0700
X-Gm-Features: Ac12FXyx_VaQ8h5nLqA_dLlxBKXAGv3g1OKRZbCjjg0VJoNtnRC8CppImxARGXU
Message-ID: <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
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

On Thu, Jul 10, 2025 at 12:03=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Wed, Jul 9, 2025 at 10:47=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Jul 9, 2025 at 4:12=E2=80=AFPM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * Suren Baghdasaryan <surenb@google.com> [250709 11:06]:
> > > > On Wed, Jul 9, 2025 at 3:03=E2=80=AFPM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> > > > >
> > > > > On 7/9/25 16:43, Suren Baghdasaryan wrote:
> > > > > > On Wed, Jul 9, 2025 at 1:57=E2=80=AFAM Vlastimil Babka <vbabka@=
suse.cz> wrote:
> > > > > >>
> > > > > >> On 7/8/25 01:10, Suren Baghdasaryan wrote:
> > > > > >> >>> +     rcu_read_unlock();
> > > > > >> >>> +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> > > > > >> >>> +     rcu_read_lock();
> > > > > >> >> OK I guess we hold the RCU lock the whole time as we traver=
se except when
> > > > > >> >> we lock under mmap lock.
> > > > > >> > Correct.
> > > > > >>
> > > > > >> I wonder if it's really necessary? Can't it be done just insid=
e
> > > > > >> lock_next_vma()? It would also avoid the unlock/lock dance quo=
ted above.
> > > > > >>
> > > > > >> Even if we later manage to extend this approach to smaps and e=
mploy rcu
> > > > > >> locking to traverse the page tables, I'd think it's best to se=
parate and
> > > > > >> fine-grain the rcu lock usage for vma iterator and page tables=
, if only to
> > > > > >> avoid too long time under the lock.
> > > > > >
> > > > > > I thought we would need to be in the same rcu read section whil=
e
> > > > > > traversing the maple tree using vma_next() but now looking at i=
t,
> > > > > > maybe we can indeed enter only while finding and locking the ne=
xt
> > > > > > vma...
> > > > > > Liam, would that work? I see struct ma_state containing a node =
field.
> > > > > > Can it be freed from under us if we find a vma, exit rcu read s=
ection
> > > > > > then re-enter rcu and use the same iterator to find the next vm=
a?
> > > > >
> > > > > If the rcu protection needs to be contigous, and patch 8 avoids t=
he issue by
> > > > > always doing vma_iter_init() after rcu_read_lock() (but does it r=
eally avoid
> > > > > the issue or is it why we see the syzbot reports?) then I guess i=
n the code
> > > > > quoted above we also need a vma_iter_init() after the rcu_read_lo=
ck(),
> > > > > because although the iterator was used briefly under mmap_lock pr=
otection,
> > > > > that was then unlocked and there can be a race before the rcu_rea=
d_lock().
> > > >
> > > > Quite true. So, let's wait for Liam's confirmation and based on his
> > > > answer I'll change the patch by either reducing the rcu read sectio=
n
> > > > or adding the missing vma_iter_init() after we switch to mmap_lock.
> > >
> > > You need to either be under rcu or mmap lock to ensure the node in th=
e
> > > maple state hasn't been freed (and potentially, reallocated).
> > >
> > > So in this case, in the higher level, we can hold the rcu read lock f=
or
> > > a series of walks and avoid re-walking the tree then the performance
> > > would be better.
> >
> > Got it. Thanks for confirming!
> >
> > >
> > > When we return to userspace, then we should drop the rcu read lock an=
d
> > > will need to vma_iter_set()/vma_iter_invalidate() on return.  I thoug=
ht
> > > this was being done (through vma_iter_init()), but syzbot seems to
> > > indicate a path that was missed?
> >
> > We do that in m_start()/m_stop() by calling
> > lock_vma_range()/unlock_vma_range() but I think I have two problems
> > here:
> > 1. As Vlastimil mentioned I do not reset the iterator when falling
> > back to mmap_lock and exiting and then re-entering rcu read section;
> > 2. I do not reset the iterator after exiting rcu read section in
> > m_stop() and re-entering it in m_start(), so the later call to
> > lock_next_vma() might be using an iterator with a node that was freed
> > (and possibly reallocated).
> >
> > >
> > > This is the same thing that needed to be done previously with the mma=
p
> > > lock, but now under the rcu lock.
> > >
> > > I'm not sure how to mitigate the issue with the page table, maybe we
> > > guess on the number of vmas that we were doing for 4k blocks of outpu=
t
> > > and just drop/reacquire then.  Probably a problem for another day
> > > anyways.
> > >
> > > Also, I think you can also change the vma_iter_init() to vma_iter_set=
(),
> > > which is slightly less code under the hood.  Vlastimil asked about th=
is
> > > and it's probably a better choice.
> >
> > Ack.
> > I'll update my series with these fixes and all comments I received so
> > far, will run the reproducers to confirm no issues and repost them
> > later today.
>
> I have the patchset ready but would like to test it some more. Will
> post it tomorrow.

Ok, I found a couple of issues using the syzbot reproducer [1] (which
is awesome BTW!):
1. rwsem_acquire_read() inside vma_start_read() at [2] should be moved
after the last check, otherwise the lock is considered taken on
vma->vm_refcnt overflow;
2. query_matching_vma() is missing unlock_vma() call when it does
"goto next_vma;" and re-issues query_vma_find_by_addr(). The previous
vma is left locked;

[1] https://syzkaller.appspot.com/x/repro.c?x=3D101edf70580000
[2] https://elixir.bootlin.com/linux/v6.15.5/source/include/linux/mm.h#L747

After these fixes it's much harder to fail but I still get one more
error copied below. I will continue the investigation and will hold
off reposting until this is fixed. That will be next week since I'll
be out of town the rest of this week.

Andrew, could you please remove this patchset from mm-unstable for now
until I fix the issue and re-post the new version?

The error I got after these fixes is:

[   56.342886]
[   56.342910] ------------[ cut here ]------------
[   56.342934] WARNING: CPU: 46 PID: 5701 at lib/maple_tree.c:4734
mas_next_slot+0x552/0x840
[   56.344691] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[   56.344695] WARNING: lock held when returning to user space!
[   56.344698] 6.16.0-rc5-00321-g31d640f7b07c-dirty #379 Not tainted
[   56.344702] ------------------------------------------------
[   56.344704] syzbot_repro1/5700 is leaving the kernel with locks still he=
ld!
[   56.344715] 1 lock held by syzbot_repro1/5700:
[   56.344720]  #0: ffff93a8c2cea788 (vm_lock){++++}-{0:0}
[   56.349286] Modules linked in:
[   56.355569] , at: get_next_vma+0x91/0xe0
[   56.377452]
[   56.377929] CPU: 46 UID: 0 PID: 5701 Comm: syzbot_repro1 Not
tainted 6.16.0-rc5-00321-g31d640f7b07c-dirty #379 PREEMPT(voluntary)
[   56.381592] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.384664] RIP: 0010:mas_next_slot+0x552/0x840
[   56.386097] Code: 43 38 83 e8 02 83 f8 01 77 c4 e9 e5 fa ff ff 48
8b 43 28 e9 83 fb ff ff 49 8b 06 30 c0 49 39 c6 74 be c7 43 38 05 00
00 00 90 <0f> 0b 90 48 c7 04 24 00 001
[   56.392303] RSP: 0018:ffffa01188217cd8 EFLAGS: 00010206
[   56.393928] RAX: ffff93a8c2724e00 RBX: ffff93a8c1af2898 RCX: 1ffff275191=
83e61
[   56.396300] RDX: ffff93a8c2724e0e RSI: 0000000000000000 RDI: ffff93a8c1a=
f2898
[   56.398515] RBP: 00007ffd83c2ffff R08: 00000000ffffffff R09: ffff93a8c8c=
1f308
[   56.400722] R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffff=
fffff
[   56.402935] R13: 0000000000000001 R14: ffff93a8c8c1f300 R15: ffff93a8c8c=
1f308
[   56.405222] FS:  00007ff71a3946c0(0000) GS:ffff93b83a9af000(0000)
knlGS:0000000000000000
[   56.408236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.409994] CR2: 00007ff71a393bb0 CR3: 0000000102f84000 CR4: 00000000007=
50ef0
[   56.412367] PKRU: 55555554
[   56.413231] Call Trace:
[   56.413955]  <TASK>
[   56.414672]  mas_find+0x5c/0x1c0
[   56.415713]  lock_next_vma+0x41/0x4d0
[   56.416869]  get_next_vma+0x91/0xe0
[   56.417954]  do_procmap_query+0x249/0xa90
[   56.419310]  ? do_procmap_query+0x1b8/0xa90
[   56.420591]  procfs_procmap_ioctl+0x20/0x40
[   56.421896]  __x64_sys_ioctl+0x8e/0xe0
[   56.423514]  do_syscall_64+0xbb/0x360
[   56.424715]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.426296] RIP: 0033:0x41a7e9
[   56.427254] Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c38
[   56.432893] RSP: 002b:00007ff71a3941f8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   56.435222] RAX: ffffffffffffffda RBX: 00007ff71a394cdc RCX: 00000000004=
1a7e9
[   56.437475] RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 00000000000=
00003
[   56.440084] RBP: 00007ff71a394220 R08: 00007ff71a3946c0 R09: 00007ff71a3=
94210
[   56.442345] R10: 0000000000000000 R11: 0000000000000246 R12: fffffffffff=
fffd0
[   56.444545] R13: 0000000000000000 R14: 00007ffd83c4fe30 R15: 00007ffd83c=
4ff18
[   56.446732]  </TASK>
[   56.447436] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   56.449433] CPU: 46 UID: 0 PID: 5701 Comm: syzbot_repro1 Not
tainted 6.16.0-rc5-00321-g31d640f7b07c-dirty #379 PREEMPT(voluntary)
[   56.453043] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.456564] Call Trace:
[   56.457340]  <TASK>
[   56.457969]  dump_stack_lvl+0x5d/0x80
[   56.459188]  ? mas_next_slot+0x510/0x840
[   56.460388]  panic+0x11a/0x2ce
[   56.461353]  ? mas_next_slot+0x552/0x840
[   56.462564]  check_panic_on_warn.cold+0xf/0x1e
[   56.463960]  __warn.cold+0xc3/0x153
[   56.465043]  ? mas_next_slot+0x552/0x840
[   56.466367]  report_bug+0xff/0x140
[   56.467441]  ? mas_next_slot+0x552/0x840
[   56.468993]  handle_bug+0x163/0x1e0
[   56.470236]  exc_invalid_op+0x17/0x70
[   56.471366]  asm_exc_invalid_op+0x1a/0x20
[   56.472629] RIP: 0010:mas_next_slot+0x552/0x840
[   56.474053] Code: 43 38 83 e8 02 83 f8 01 77 c4 e9 e5 fa ff ff 48
8b 43 28 e9 83 fb ff ff 49 8b 06 30 c0 49 39 c6 74 be c7 43 38 05 00
00 00 90 <0f> 0b 90 48 c7 04 24 00 001
[   56.479861] RSP: 0018:ffffa01188217cd8 EFLAGS: 00010206
[   56.481501] RAX: ffff93a8c2724e00 RBX: ffff93a8c1af2898 RCX: 1ffff275191=
83e61
[   56.483665] RDX: ffff93a8c2724e0e RSI: 0000000000000000 RDI: ffff93a8c1a=
f2898
[   56.486323] RBP: 00007ffd83c2ffff R08: 00000000ffffffff R09: ffff93a8c8c=
1f308
[   56.488491] R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffff=
fffff
[   56.490634] R13: 0000000000000001 R14: ffff93a8c8c1f300 R15: ffff93a8c8c=
1f308
[   56.492856]  mas_find+0x5c/0x1c0
[   56.493888]  lock_next_vma+0x41/0x4d0
[   56.495022]  get_next_vma+0x91/0xe0
[   56.496204]  do_procmap_query+0x249/0xa90
[   56.497515]  ? do_procmap_query+0x1b8/0xa90
[   56.499232]  procfs_procmap_ioctl+0x20/0x40
[   56.500500]  __x64_sys_ioctl+0x8e/0xe0
[   56.501682]  do_syscall_64+0xbb/0x360
[   56.502845]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.504408] RIP: 0033:0x41a7e9
[   56.505362] Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c38
[   56.511066] RSP: 002b:00007ff71a3941f8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   56.513523] RAX: ffffffffffffffda RBX: 00007ff71a394cdc RCX: 00000000004=
1a7e9
[   56.515977] RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 00000000000=
00003
[   56.518440] RBP: 00007ff71a394220 R08: 00007ff71a3946c0 R09: 00007ff71a3=
94210
[   56.520643] R10: 0000000000000000 R11: 0000000000000246 R12: fffffffffff=
fffd0
[   56.522884] R13: 0000000000000000 R14: 00007ffd83c4fe30 R15: 00007ffd83c=
4ff18
[   56.525170]  </TASK>
[   56.527859] Kernel Offset: 0x1a00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   56.531106] Rebooting in 86400 seconds..

>
> > Thanks,
> > Suren.
> >
> > >
> > > Thanks,
> > > Liam
> > >

