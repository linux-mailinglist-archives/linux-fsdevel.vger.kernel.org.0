Return-Path: <linux-fsdevel+bounces-38173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E829FD79D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 21:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E5164691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B601F866F;
	Fri, 27 Dec 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmIWoghi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4151C2BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735330127; cv=none; b=RLGCqI9nfn18HPh6EB2GYRKsjJLbkRnu2VHGpfgsjD3HYgzNKwvIvDlm2GnmiUlzbLQEcUGrRV6b9EBbzf2+GGmTqa+D8eBglpd93NgssEvJYcwjQmsgNmR/cdO6SPSkLlQvOccrrgETyXmSUsMD2VJeBNLQo9CpJqchDi0SoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735330127; c=relaxed/simple;
	bh=q+5/Pp5g3kesMsHS12Po70tZgleb4b/brrCmxY1g9Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At6qrzX7Lv41de5SOzHrrJQGzc6wIB4h02usXlGjdGTNQofN/Vm/SXNw6oP3SplfT/iy4lNWr3SGS5tdYPeu2UyMLdzYpSeAYd+7eE7vzkC6S/gSMWsU57kmx0Wyi28JT8kc6DtiWLw3zKD3Wlpr02hly740VUVQ+urogdWOBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmIWoghi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-468f6b3a439so69127021cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 12:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735330124; x=1735934924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+5/Pp5g3kesMsHS12Po70tZgleb4b/brrCmxY1g9Jw=;
        b=TmIWoghiaMpPy3bLC5tAbBmDeiAZ93bxThyvtvBt0hWnMyOrUeEq9H+rNWV8mLORDd
         JvBVunVL86HeHYtmlhJsTkIXOcL4yDZz+jo3+YrzL/mvWBDoJi1vTcRUloxDIVXrtDWQ
         gs/02BCtdhoGUcZe3txHYfDjAp4FyN1CDA1fMKp++yAWUmXBeLMTKcYPm7aJv8b7Jd8k
         BF/YRDS+Y3l5yiGv0ju4b6tb4IMulkDRGvo91oZTFTwYOssAKOYtKK3/W8Mw/Gcpwm8q
         hHEmwAyHzuBUvBJqSUV7EvPaD3p6dDGkTIMhlY6mG2W80L+t3o5xTxOrgdpRGMdRTo9R
         ZS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735330124; x=1735934924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+5/Pp5g3kesMsHS12Po70tZgleb4b/brrCmxY1g9Jw=;
        b=DE/7NbCp9Er4dDDX+3xGr4mD7muNzpDhgEVhbQ5V7FE3Nt5ewf/V2BqGfe7UcnksII
         OEhnPYHLNjt/5ggqCycXBzvKCZXM6GjT2n1CZI0186TnTqsFn4TwtZooiTPiZfKYjjKd
         OKkE07k31P9dnNpnwNZS4DDSIdMwmNuyZuSmOnMEuGIXYJiXAe9RDSjfbHdbTe9pzMot
         uq/cKNseS6gxs8tQLZbZnIQz1+5Sqk0fAzc9sxDmWMW0Xmf4ImMERhWJWqxtcdicu9o0
         0dYE/s3qvyJX0W6JfK58rh7Y4IXmfA2x4zTnmro4GEKibldXgR0Kv3YIYyBEowN1/Bq3
         CqKA==
X-Forwarded-Encrypted: i=1; AJvYcCW5OI9gwg/1TY2fxSmIIiMlz3V8cknBStK53+QuNwODOSzOpFm1AB1DYwEQH9DEFbHNujdFP+8vFumjM+hA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8inQHrCkm1ZzmcrXiLiG2cju56TJzuFfG7WL2kqCcL6bPhm0h
	YOeQnJUzC2XwmWvtri/qOreR64O1Os1Cf+mg5ej5I3z29eEEEGl2JtxOP2o+TXffbP6ZxjDwuUL
	saq6f0//qSpxeFqqP6K65vCHuXuE=
X-Gm-Gg: ASbGncuX2Wo5Yexz7K9jfAcYhWTc2TcrYoh+jlvwNf7BrGn0UUW2lOgiO6perVATTTm
	C4Tv7MJGDhUmd32xwe2yy2LZcJkxSs8lOJXtPd4y9W7A63LXzQNUX6g==
X-Google-Smtp-Source: AGHT+IHrqNPgAUrlVE9u9Q8PEloLbIM4uXsW4ONQq8EcgVHEtwEPdX0kMzaabJfdXe3wi1GRCfRjHI1CDyYocT9mPSw=
X-Received: by 2002:a05:622a:1818:b0:467:6e87:99ea with SMTP id
 d75a77b69052e-46a4a972786mr438767401cf.44.1735330124158; Fri, 27 Dec 2024
 12:08:44 -0800 (PST)
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
In-Reply-To: <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Dec 2024 12:08:33 -0800
Message-ID: <CAJnrk1YwNw7C=EMfKQzN88Zq_2Qih5Te_bfkeaOf=tG+L3u9eA@mail.gmail.com>
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

On Thu, Dec 26, 2024 at 12:13=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Dec 24, 2024 at 01:37:49PM +0100, David Hildenbrand wrote:
> > On 23.12.24 23:14, Shakeel Butt wrote:
> > > On Sat, Dec 21, 2024 at 05:18:20PM +0100, David Hildenbrand wrote:
> > > [...]
> > > >
> > > > Yes, so I can see fuse
> > > >
> > > > (1) Breaking memory reclaim (memory cannot get freed up)
> > > >
> > > > (2) Breaking page migration (memory cannot be migrated)
> > > >
> > > > Due to (1) we might experience bigger memory pressure in the system=
 I guess.
> > > > A handful of these pages don't really hurt, I have no idea how bad =
having
> > > > many of these pages can be. But yes, inherently we cannot throw awa=
y the
> > > > data as long as it is dirty without causing harm. (maybe we could m=
ove it to
> > > > some other cache, like swap/zswap; but that smells like a big and
> > > > complicated project)
> > > >
> > > > Due to (2) we turn pages that are supposed to be movable possibly f=
or a long
> > > > time unmovable. Even a *single* such page will mean that CMA alloca=
tions /
> > > > memory unplug can start failing.
> > > >
> > > > We have similar situations with page pinning. With things like O_DI=
RECT, our
> > > > assumption/experience so far is that it will only take a couple of =
seconds
> > > > max, and retry loops are sufficient to handle it. That's why only l=
ong-term
> > > > pinning ("indeterminate", e.g., vfio) migrate these pages out of
> > > > ZONE_MOVABLE/MIGRATE_CMA areas in order to long-term pin them.
> > > >
> > > >
> > > > The biggest concern I have is that timeouts, while likely reasonabl=
e it many
> > > > scenarios, might not be desirable even for some sane workloads, and=
 the
> > > > default in all system will be "no timeout", letting the clueless ad=
min of
> > > > each and every system out there that might support fuse to make a d=
ecision.
> > > >
> > > > I might have misunderstood something, in which case I am very sorry=
, but we
> > > > also don't want CMA allocations to start failing simply because a n=
etwork
> > > > connection is down for a couple of minutes such that a fuse daemon =
cannot
> > > > make progress.
> > > >
> > >
> > > I think you have valid concerns but these are not new and not unique =
to
> > > fuse. Any filesystem with a potential arbitrary stall can have simila=
r
> > > issues. The arbitrary stall can be caused due to network issues or so=
me
> > > faultly local storage.
> >
> > What concerns me more is that this is can be triggered by even unprivil=
eged
> > user space, and that there is no default protection as far as I underst=
ood,
> > because timeouts cannot be set universally to a sane defaults.
> >
> > Again, please correct me if I got that wrong.
> >
>
> Let's route this question to FUSE folks. More specifically: can an
> unprivileged process create a mount point backed by itself, create a
> lot of dirty (bound by cgroup) and writeback pages on it and let the
> writeback pages in that state forever?
>
> >
> > BTW, I just looked at NFS out of interest, in particular
> > nfs_page_async_flush(), and I spot some logic about re-dirtying pages +
> > canceling writeback. IIUC, there are default timeouts for UDP and TCP,
> > whereby the TCP default one seems to be around 60s (* retrans?), and th=
e
> > privileged user that mounts it can set higher ones. I guess one could r=
un
> > into similar writeback issues?
>
> Yes, I think so.
>
> >
> > So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs?
>
> I feel like INDETERMINATE in the name is the main cause of confusion.
> So, let me explain why it is required (but later I will tell you how it
> can be avoided). The FUSE thread which is actively handling writeback of
> a given folio can cause memory allocation either through syscall or page
> fault. That memory allocation can trigger global reclaim synchronously
> and in cgroup-v1, that FUSE thread can wait on the writeback on the same
> folio whose writeback it is supposed to end and cauing a deadlock. So,
> AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.
>
> The in-kernel fs avoid this situation through the use of GFP_NOFS
> allocations. The userspace fs can also use a similar approach which is
> prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I have been
> told that it is hard to use as it is per-thread flag and has to be set
> for all the threads handling writeback which can be error prone if the
> threadpool is dynamic. Second it is very coarse such that all the
> allocations from those threads (e.g. page faults) become NOFS which
> makes userspace very unreliable on highly utilized machine as NOFS can
> not reclaim potentially a lot of memory and can not trigger oom-kill.
>
> > Not
> > sure if I grasped all details about NFS and writeback and when it would
> > redirty+end writeback, and if there is some other handling in there.
> >
> [...]
> > >
> > > Please note that such filesystems are mostly used in environments lik=
e
> > > data center or hyperscalar and usually have more advanced mechanisms =
to
> > > handle and avoid situations like long delays. For such environment
> > > network unavailability is a larger issue than some cma allocation
> > > failure. My point is: let's not assume the disastrous situaion is nor=
mal
> > > and overcomplicate the solution.
> >
> > Let me summarize my main point: ZONE_MOVABLE/MIGRATE_CMA must only be u=
sed
> > for movable allocations.
> >
> > Mechanisms that possible turn these folios unmovable for a
> > long/indeterminate time must either fail or migrate these folios out of
> > these regions, otherwise we start violating the very semantics why
> > ZONE_MOVABLE/MIGRATE_CMA was added in the first place.
> >
> > Yes, there are corner cases where we cannot guarantee movability (e.g.,=
 OOM
> > when allocating a migration destination), but these are not cases that =
can
> > be triggered by (unprivileged) user space easily.
> >
> > That's why FOLL_LONGTERM pinning does exactly that: even if user space =
would
> > promise that this is really only "short-term", we will treat it as "pos=
sibly
> > forever", because it's under user-space control.
> >
> >
> > Instead of having more subsystems violate these semantics because
> > "performance" ... I would hope we would do better. Maybe it's an issue =
for
> > NFS as well ("at least" only for privileged user space)? In which case,
> > again, I would hope we would do better.
> >
> >
> > Anyhow, I'm hoping there will be more feedback from other MM folks, but
> > likely right now a lot of people are out (just like I should ;) ).
> >
> > If I end up being the only one with these concerns, then likely people =
can
> > feel free to ignore them. ;)
>
> I agree we should do better but IMHO it should be an iterative process.
> I think your concerns are valid, so let's push the discussion towards
> resolving those concerns. I think the concerns can be resolved by better
> handling of lifetime of folios under writeback. The amount of such
> folios is already handled through existing dirty throttling mechanism.
>
> We should start with a baseline i.e. distribution of lifetime of folios
> under writeback for traditional storage devices (spinning disk and SSDs)
> as we don't want an unrealistic goal for ourself. I think this data will
> drive the appropriate timeout values (if we decide timeout based
> approach is the right one).
>
> At the moment we have timeout based approach to limit the lifetime of
> folios under writeback. Any other ideas?

I don't see any other approach that would handle splice, other than
modifying the splice code to prevent the underlying buf->page from
being migrated while it's being copied out, which seems non-viable to
consider. The other alternatives I see are to either a) do the extra
temp page copying for splice and "abort" the writeback if migration is
triggered or b) gate this to only apply to servers running as
privileged. I assume the majority of use cases do use splice, in which
case a) would be pointless and would make the internal logic more
complicated (eg we would still need the rb tree and would now need to
check writeback against the folio writeback state or the rb tree,
etc). I'm not sure how useful this would be either if this is just
gated to privileged servers.


Thanks,
Joanne

