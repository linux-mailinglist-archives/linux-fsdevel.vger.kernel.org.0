Return-Path: <linux-fsdevel+bounces-38342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404119FFFBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 20:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509A21883C7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E871B4F23;
	Thu,  2 Jan 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ7TDJnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E67E0E4
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847979; cv=none; b=HWhRdXfMqS6AU25lXbCx4ryh2T9nvDNr2oXtcHckwEoW9BEQVmGdcr+IhyvPGqVeHHANKvDgSArKsHZTvDQPIxE1iHa6ZSVvfjd0VPUo39qfy1LWa5/AipxqSTm7K94kUDYAvlD4NoLVJHsfsIijDjVZHcgNoyNKFRIIiKS13X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847979; c=relaxed/simple;
	bh=De/AtM6Llzu+P+VAtiydarvxmSKAH42c26KQku0OU+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdIXZmqqtjSzxNjEfT6RI7Le+YRggCAKrTuSoxz6npj6u2HDjRJ009XKB7bqrKKs8aU6JZZu8HTk+sSfSbiV0CdM5zOS0YRvaj8HGoPQV3z9PhNPWoyXVC9Rxd8VEJmCI7cNd7XWDvcnjsw3uNrsXJF/iLGDMEd7oqiJztsfJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ7TDJnl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a37a2a53so139985351cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735847977; x=1736452777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjSIfZUGuUkWyeI8Uu3qOfSAK+XFtRgECvJydFhzJn8=;
        b=AQ7TDJnl8ZXoRGuQV9Zrjkmb30ZTo5GoUH/3berZc+iGkYfWNPZMwmaEOxbgH9M5i4
         a44RZpNxtsSUUFbhSm7o/e7AKV6VbvYRXbdtl3Prvzj8Yj+EBufXNFI14sjMIDFKS8Zg
         xxGECxfYCqaOT5Si/ESG/TFzPKCoVQXVxot/mVVEt83fw+nrjyD2OELXWzT9ednpW3CZ
         Wu3I1B3tWR+jhurh+Dwbp3akfBu39heBOpy5y1zEwla9oUapvHKcT0ZOyPa56QrEbckg
         eOt+4bB9Mglt5CCCWhMwSWMJkeeMYU6MnihAuu/46RCixIDwW5ZAdDSvrvrHo26YRXyZ
         qLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735847977; x=1736452777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjSIfZUGuUkWyeI8Uu3qOfSAK+XFtRgECvJydFhzJn8=;
        b=MxrJeGjYyPaGwpJKWwTDCJiNq4TNojmKnvoT1JE8AES15cdGqrWXU7djNvhx/1qzXW
         IbHEq8cP0a3nk4LB8T2JAy+spMckqL+PwSPd+gvBmZ0xaBBEEAonSVASS0tQEurjffmF
         U+kETPc+hJYVqgLsOc01BkpQmOyz2UmZDdq74vLcCyTWhLaGJCPghDVVVQz20cToV+Kf
         PUKYqaPe01qBtr97FkQR8JwiedMIJ69NbvB/x/GYuLY1xYygMc6xl0SQCcMayaDz6keA
         lOBa9mgQrSzB158DFDF55QVP+RP8e5ZKlZoR25wwBNzI4uWAjLJR6yn2o5ZU5CcJdYTc
         Sg5A==
X-Forwarded-Encrypted: i=1; AJvYcCVWtLFwDJFOXHNMkCt2o3H1PuDp6VDX/Gbq97qlQrwnRdOmkI1UaXIqbAGCE59Ke5IJ6Xd6Dyrb6v9H861u@vger.kernel.org
X-Gm-Message-State: AOJu0YywEQT/4vmIvOJZZcveJaQfuSBdPdkgQBOOmnRFf3Uxjfftx128
	n3wIAACWc9JM6Ax0FoLZNSslfqnRxGVE3Pf9caOsV+GIXlJcI8d1LQhs38aeFhLdUVattV8RGaR
	7dc9SfEksrE13DXY54t2yuqg/DYc=
X-Gm-Gg: ASbGncu37FTFSeX5hPxQqszxOOZAOOidhvsUyDlQI6FGnQpPx2mYlTv2sl2XfIDmL57
	zb6uPGIsN/q/HsCD9xssHOd0Mp1gCsa9BlmI2A90=
X-Google-Smtp-Source: AGHT+IEZkNcUvY6ZY5oPLOjgB3IoNX19M+CYYbv8xFIM1fWH0J82WPyfmMIYP/gUvxNTXaDxcMsgUr+umRjaqoRECa0=
X-Received: by 2002:ac8:5d07:0:b0:467:73f3:887d with SMTP id
 d75a77b69052e-46a4a8f0f2cmr764271641cf.33.1735847976752; Thu, 02 Jan 2025
 11:59:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm> <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com> <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com> <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com> <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <xucuoi4ywape4ftgzgahqqgzk6xhvotzdu67crq37ccmyl53oa@oiq354b6sfu7>
In-Reply-To: <xucuoi4ywape4ftgzgahqqgzk6xhvotzdu67crq37ccmyl53oa@oiq354b6sfu7>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jan 2025 11:59:25 -0800
Message-ID: <CAJnrk1bmjd_yE0LO=Qdff==Zk5neunvUbnsEVYqNPPDsSJUudw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 12:04=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Dec 30, 2024 at 10:38:16AM -0800, Joanne Koong wrote:
> > On Mon, Dec 30, 2024 at 2:16=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
>
> Thanks David for the response.
>
> > >
> > > >> BTW, I just looked at NFS out of interest, in particular
> > > >> nfs_page_async_flush(), and I spot some logic about re-dirtying pa=
ges +
> > > >> canceling writeback. IIUC, there are default timeouts for UDP and =
TCP,
> > > >> whereby the TCP default one seems to be around 60s (* retrans?), a=
nd the
> > > >> privileged user that mounts it can set higher ones. I guess one co=
uld run
> > > >> into similar writeback issues?
> > > >
> > >
> > > Hi,
> > >
> > > sorry for the late reply.
> > >
> > > > Yes, I think so.
> > > >
> > > >>
> > > >> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for n=
fs?
> > > >
> > > > I feel like INDETERMINATE in the name is the main cause of confusio=
n.
> > >
> > > We are adding logic that says "unconditionally, never wait on writeba=
ck
> > > for these folios, not even any sync migration". That's the main probl=
em
> > > I have.
> > >
> > > Your explanation below is helpful. Because ...
> > >
> > > > So, let me explain why it is required (but later I will tell you ho=
w it
> > > > can be avoided). The FUSE thread which is actively handling writeba=
ck of
> > > > a given folio can cause memory allocation either through syscall or=
 page
> > > > fault. That memory allocation can trigger global reclaim synchronou=
sly
> > > > and in cgroup-v1, that FUSE thread can wait on the writeback on the=
 same
> > > > folio whose writeback it is supposed to end and cauing a deadlock. =
So,
> > > > AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.
> > >  > > The in-kernel fs avoid this situation through the use of GFP_NOF=
S
> > > > allocations. The userspace fs can also use a similar approach which=
 is
> > > > prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I have=
 been
> > > > told that it is hard to use as it is per-thread flag and has to be =
set
> > > > for all the threads handling writeback which can be error prone if =
the
> > > > threadpool is dynamic. Second it is very coarse such that all the
> > > > allocations from those threads (e.g. page faults) become NOFS which
> > > > makes userspace very unreliable on highly utilized machine as NOFS =
can
> > > > not reclaim potentially a lot of memory and can not trigger oom-kil=
l.
> > > >
> > >
> > > ... now I understand that we want to prevent a deadlock in one specif=
ic
> > > scenario only?
> > >
> > > What sounds plausible for me is:
> > >
> > > a) Make this only affect the actual deadlock path: sync migration
> > >     during compaction. Communicate it either using some "context"
> > >     information or with a new MIGRATE_SYNC_COMPACTION.
> > > b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to expres=
s
> > >      that very deadlock problem.
> > > c) Leave all others sync migration users alone for now
> >
> > The deadlock path is separate from sync migration. The deadlock arises
> > from a corner case where cgroupv1 reclaim waits on a folio under
> > writeback where that writeback itself is blocked on reclaim.
> >
>
> Joanne, let's drop the patch to migrate.c completely and let's rename
> the flag to something like what David is suggesting and only handle in
> the reclaim path.
>
> > >
> > > Would that prevent the deadlock? Even *better* would be to to be able=
 to
> > > ask the fs if starting writeback on a specific folio could deadlock.
> > > Because in most cases, as I understand, we'll  not actually run into =
the
> > > deadlock and would just want to wait for writeback to just complete
> > > (esp. compaction).
> > >
> > > (I still think having folios under writeback for a long time might be=
 a
> > > problem, but that's indeed something to sort out separately in the
> > > future, because I suspect NFS has similar issues. We'd want to "wait
> > > with timeout" and e.g., cancel writeback during memory
> > > offlining/alloc_cma ...)
>
> Thanks David and yes let's handle the folios under writeback issue
> separately.
>
> >
> > I'm looking back at some of the discussions in v2 [1] and I'm still
> > not clear on how memory fragmentation for non-movable pages differs
> > from memory fragmentation from movable pages and whether one is worse
> > than the other.
>
> I think the fragmentation due to movable pages becoming unmovable is
> worse as that situation is unexpected and the kernel can waste a lot of
> CPU to defrag the block containing those folios. For non-movable blocks,
> the kernel will not even try to defrag. Now we can have a situation
> where almost all memory is backed by non-movable blocks and higher order
> allocations start failing even when there is enough free memory. For
> such situations either system needs to be restarted (or workloads
> restarted if they are cause of high non-movable memory) or the admin
> needs to setup ZONE_MOVABLE where non-movable allocations don't go.

Thanks for the explanations.

The reason I ask is because I'm trying to figure out if having a time
interval wait or retry mechanism instead of skipping migration would
be a viable solution. Where when attempting the migration for folios
with the as_writeback_indeterminate flag that are under writeback,
it'll wait on folio writeback for a certain amount of time and then
skip the migration if no progress has been made and the folio is still
under writeback.

there are two cases for fuse folios under writeback (for folios not
under writeback, migration will work as is):
a) normal case: server is not malicious or buggy, writeback is
completed in a timely manner.
For this case, migration would be successful and there'd be no
difference for this between having no temp pages vs temp pages


b) server is malicious or buggy:
eg the server never completes writeback

With no temp pages:
The folio under writeback prevents a memory block (not sure how big
this usually is?) from being compacted, leading to memory
fragmentation

With temp pages:
fuse allocates a non-movable page for every page it needs to write
back, which worsens memory usage, these pages will never get freed
since the server never finishes writeback on them. The non-movable
pages could also fragment memory blocks like in the scenario with no
temp pages.


Is the b) case with no temp pages worse for memory health than the
scenario with temp pages? For the cpu usage issue (eg kernel keeps
trying to defrag blocks containing these problematic folios), it seems
like this could be potentially mitigated by marking these blocks as
uncompactable?


Thanks,
Joanne

>
> > Currently fuse uses movable temp pages (allocated with
> > gfp flags GFP_NOFS | __GFP_HIGHMEM), and these can run into the same
> > issue where a buggy/malicious server may never complete writeback.
>
> So, these temp pages are not an issue for fragmenting the movable blocks
> but if there is no limit on temp pages, the whole system can become
> non-movable (there is a case where movable blocks on non-ZONE_MOVABLE
> can be converted into non-movable blocks under low memory). ZONE_MOVABLE
> will avoid such scenario but tuning the right size of ZONE_MOVABLE is
> not easy.
>
> > This has the same effect of fragmenting memory and has a worse memory
> > cost to the system in terms of memory used. With not having temp pages
> > though, now in this scenario, pages allocated in a movable page block
> > can't be compacted and that memory is fragmented. My (basic and maybe
> > incorrect) understanding is that memory gets allocated through a buddy
> > allocator and moveable vs nonmovable pages get allocated to
> > corresponding blocks that match their type, but there's no other
> > difference otherwise. Is this understanding correct? Or is there some
> > substantial difference between fragmentation for movable vs nonmovable
> > blocks?
>
> The main difference is the fallback of high order allocation which can
> trigger compaction or background compaction through kcompactd. The
> kernel will only try to defrag the movable blocks.
>

