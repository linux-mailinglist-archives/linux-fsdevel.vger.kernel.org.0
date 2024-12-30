Return-Path: <linux-fsdevel+bounces-38275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC659FEA04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D8C162210
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D9199230;
	Mon, 30 Dec 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxMi9wIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B3199234
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583910; cv=none; b=d1tL3NZ4166yqizjP9MVqF1165JzyURL2RpwwGrExNJ7VX0zuQtpYeHMGjZsJTEsMIo4aXL3yDTWxI7Xs4A0VWIYfYKI2ayXrz8foMWsMC9FqxL3ZB+5YGBrK4AOzax/z70+3M9Mj8LRRZ26rnY4rLzI0nwfAH8zlnrvww0ob+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583910; c=relaxed/simple;
	bh=gAH0I8O5bsMYve9ZnFyY+ICqseswmmello0NEnxvKKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xl6npiAr6wZPUtZWDJ8e090DcN9o6nieBa82vqPWw60x0dJP2rcsZxsqiN5xk2vgWztXhYbLKL+t3kSuY4ltnQcRjDpdimmWot0N+s0pA969rf2SQaWeJKYLYGZyOstrp1s5OLyBI/HsSYLJaJprd/P9Gs5EIJguMbg+bRzXPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxMi9wIZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a0a6c9fcso127054221cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 10:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735583908; x=1736188708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIBhi3sZlTanZJgZcnBKy+hL3cGk5vGjv2PbmgxoS6w=;
        b=QxMi9wIZN8kq944HsdJ/1rixlVrlrUDMdjXjNI8zwkHZl3q/l1g0gk2ynZRN+ndCgk
         Y7ayh370Fr6+U9K5m9Ky19uAb4QNRrtOeq4GPI4ghIMP1kjx7EfGLfwLvsUIXdHQSnN9
         PTQ+O+agPkOpof7DRW4UclF3sjUqPYCKp4XkcS+owkydkzumGdMAkPWOZVPNp13er+iK
         qomvRx/FXB2JyE5I+/8MHGA7AIzVXD1PsUxjBNNWwrLR9G2tjDBnXell6Y7Oshzm8Qxk
         lM6V+ofyBJQDPtg4QFPc0lfZKeiE8we4MJwuHdtk+DKgD0iK4QnLW3QAn0tgldiVLL7s
         cJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735583908; x=1736188708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIBhi3sZlTanZJgZcnBKy+hL3cGk5vGjv2PbmgxoS6w=;
        b=JgfZxalKqz4dSTLGNB1l/Aqqws4Te6lymk27Yq4Ih/F3DV/vs0PMArYKOag8YSjjml
         VV+CbVrIOictZ/mrnjzwLZVHYAu0HwgtdC2MFoLtNS53i7+HmX7hVG1eu64/CT/0hOkh
         czIqAFYNZHEgvQAGEuVRgaF6KTWFQ+620iKd9M/R4/tYu/X1nAvCLFxp4VBNTNdOtudO
         c1H652ZON/7bXjDJL7EjZ11LlH38NtVfFj+8mGPKcJwaqXSuWcenT0IvqMCg+Qpndtd6
         SJHsm093yQWlGV1i0/XwBOs0vW/SAACzn6Oz7ssWUrniWqCz0tSSGPC7QyWCOzpkiV2Z
         Zx0w==
X-Forwarded-Encrypted: i=1; AJvYcCXdaSsrbrwBZ7kvfRC7w2pAlBRl3eEodNWg/+qx2er2xFDALhS9DK0w01UK7u49+0d3RQ1hzASPtKPuVEHz@vger.kernel.org
X-Gm-Message-State: AOJu0YzMk9v1x/fPrFU0VjkoetmDzoW8NLwPOrGrnXSGNymVTCX3DN3E
	wR6hZSp2me4xGwpLc0RH7wGnmGykjWEJXVvjBsadnBp9l1c6WGG+cbuWoL+CsaXT/CcDne+5YCj
	SND2Ra61S1BLz7F5KDzrEjCtbvUs=
X-Gm-Gg: ASbGnct+CRMdz9D5JpQL2qq1aEMNMyA5Ohauv+WTvz5mWbmI3CumNXpTJ5xhamTZhtL
	b9nKLDCZfbWgrY93KZoqijJ3MwHYBDQf7DT8/GFQ=
X-Google-Smtp-Source: AGHT+IHhFR+9j2ElTQgI1v43znVjmdPD/UDZvi/qrv4RiDwr+t+JOVG0YC8hTCXV+qDqipb6YuI9Hp9JpaPqxbDploM=
X-Received: by 2002:a05:622a:110c:b0:467:6692:c18a with SMTP id
 d75a77b69052e-46a4a8dc464mr641394481cf.13.1735583907890; Mon, 30 Dec 2024
 10:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com> <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com> <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com> <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com> <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
In-Reply-To: <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 30 Dec 2024 10:38:16 -0800
Message-ID: <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 2:16=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> BTW, I just looked at NFS out of interest, in particular
> >> nfs_page_async_flush(), and I spot some logic about re-dirtying pages =
+
> >> canceling writeback. IIUC, there are default timeouts for UDP and TCP,
> >> whereby the TCP default one seems to be around 60s (* retrans?), and t=
he
> >> privileged user that mounts it can set higher ones. I guess one could =
run
> >> into similar writeback issues?
> >
>
> Hi,
>
> sorry for the late reply.
>
> > Yes, I think so.
> >
> >>
> >> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs?
> >
> > I feel like INDETERMINATE in the name is the main cause of confusion.
>
> We are adding logic that says "unconditionally, never wait on writeback
> for these folios, not even any sync migration". That's the main problem
> I have.
>
> Your explanation below is helpful. Because ...
>
> > So, let me explain why it is required (but later I will tell you how it
> > can be avoided). The FUSE thread which is actively handling writeback o=
f
> > a given folio can cause memory allocation either through syscall or pag=
e
> > fault. That memory allocation can trigger global reclaim synchronously
> > and in cgroup-v1, that FUSE thread can wait on the writeback on the sam=
e
> > folio whose writeback it is supposed to end and cauing a deadlock. So,
> > AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.
>  > > The in-kernel fs avoid this situation through the use of GFP_NOFS
> > allocations. The userspace fs can also use a similar approach which is
> > prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I have bee=
n
> > told that it is hard to use as it is per-thread flag and has to be set
> > for all the threads handling writeback which can be error prone if the
> > threadpool is dynamic. Second it is very coarse such that all the
> > allocations from those threads (e.g. page faults) become NOFS which
> > makes userspace very unreliable on highly utilized machine as NOFS can
> > not reclaim potentially a lot of memory and can not trigger oom-kill.
> >
>
> ... now I understand that we want to prevent a deadlock in one specific
> scenario only?
>
> What sounds plausible for me is:
>
> a) Make this only affect the actual deadlock path: sync migration
>     during compaction. Communicate it either using some "context"
>     information or with a new MIGRATE_SYNC_COMPACTION.
> b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to express
>      that very deadlock problem.
> c) Leave all others sync migration users alone for now

The deadlock path is separate from sync migration. The deadlock arises
from a corner case where cgroupv1 reclaim waits on a folio under
writeback where that writeback itself is blocked on reclaim.

>
> Would that prevent the deadlock? Even *better* would be to to be able to
> ask the fs if starting writeback on a specific folio could deadlock.
> Because in most cases, as I understand, we'll  not actually run into the
> deadlock and would just want to wait for writeback to just complete
> (esp. compaction).
>
> (I still think having folios under writeback for a long time might be a
> problem, but that's indeed something to sort out separately in the
> future, because I suspect NFS has similar issues. We'd want to "wait
> with timeout" and e.g., cancel writeback during memory
> offlining/alloc_cma ...)

I'm looking back at some of the discussions in v2 [1] and I'm still
not clear on how memory fragmentation for non-movable pages differs
from memory fragmentation from movable pages and whether one is worse
than the other. Currently fuse uses movable temp pages (allocated with
gfp flags GFP_NOFS | __GFP_HIGHMEM), and these can run into the same
issue where a buggy/malicious server may never complete writeback.
This has the same effect of fragmenting memory and has a worse memory
cost to the system in terms of memory used. With not having temp pages
though, now in this scenario, pages allocated in a movable page block
can't be compacted and that memory is fragmented. My (basic and maybe
incorrect) understanding is that memory gets allocated through a buddy
allocator and moveable vs nonmovable pages get allocated to
corresponding blocks that match their type, but there's no other
difference otherwise. Is this understanding correct? Or is there some
substantial difference between fragmentation for movable vs nonmovable
blocks?


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241014182228.1941246-1-joannelk=
oong@gmail.com/T/#m7637e26a559db86348461ebc1104352083085d6d

>
> >> Not
> >> sure if I grasped all details about NFS and writeback and when it woul=
d
> >> redirty+end writeback, and if there is some other handling in there.
> >>
> > [...]
> >>>
> >>> Please note that such filesystems are mostly used in environments lik=
e
> >>> data center or hyperscalar and usually have more advanced mechanisms =
to
> >>> handle and avoid situations like long delays. For such environment
> >>> network unavailability is a larger issue than some cma allocation
> >>> failure. My point is: let's not assume the disastrous situaion is nor=
mal
> >>> and overcomplicate the solution.
> >>
> >> Let me summarize my main point: ZONE_MOVABLE/MIGRATE_CMA must only be =
used
> >> for movable allocations.
> >>
> >> Mechanisms that possible turn these folios unmovable for a
> >> long/indeterminate time must either fail or migrate these folios out o=
f
> >> these regions, otherwise we start violating the very semantics why
> >> ZONE_MOVABLE/MIGRATE_CMA was added in the first place.
> >>
> >> Yes, there are corner cases where we cannot guarantee movability (e.g.=
, OOM
> >> when allocating a migration destination), but these are not cases that=
 can
> >> be triggered by (unprivileged) user space easily.
> >>
> >> That's why FOLL_LONGTERM pinning does exactly that: even if user space=
 would
> >> promise that this is really only "short-term", we will treat it as "po=
ssibly
> >> forever", because it's under user-space control.
> >>
> >>
> >> Instead of having more subsystems violate these semantics because
> >> "performance" ... I would hope we would do better. Maybe it's an issue=
 for
> >> NFS as well ("at least" only for privileged user space)? In which case=
,
> >> again, I would hope we would do better.
> >>
> >>
> >> Anyhow, I'm hoping there will be more feedback from other MM folks, bu=
t
> >> likely right now a lot of people are out (just like I should ;) ).
> >>
> >> If I end up being the only one with these concerns, then likely people=
 can
> >> feel free to ignore them. ;)
> >
> > I agree we should do better but IMHO it should be an iterative process.
>  > I think your concerns are valid, so let's push the discussion
> towards> resolving those concerns. I think the concerns can be resolved
> by better
> > handling of lifetime of folios under writeback. The amount of such
> > folios is already handled through existing dirty throttling mechanism.
> >
> > We should start with a baseline i.e. distribution of lifetime of folios
> > under writeback for traditional storage devices (spinning disk and SSDs=
)
> > as we don't want an unrealistic goal for ourself. I think this data wil=
l
> > drive the appropriate timeout values (if we decide timeout based
> > approach is the right one).
> >
> > At the moment we have timeout based approach to limit the lifetime of
> > folios under writeback. Any other ideas?
>
> See above, maybe we could limit the deadlock avoidance to the actual
> deadlock path and sort out the "infinite writeback in some corner cases"
> problem separately.
>
> --
> Cheers,
>
> David / dhildenb
>

