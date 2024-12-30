Return-Path: <linux-fsdevel+bounces-38274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C246B9FE987
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7667316202A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8002C1ACEC8;
	Mon, 30 Dec 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d32fAyna"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90D19DFAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735581173; cv=none; b=ig3SUnyxOwvVkaMjc0kUmCvXZHwPxCVJIroHF1qsmxM6bax5Q3XAUv4uSOMuRYyYnJmrEdYw1U6OF1AJjljBAl3xKvnOBudRKL3uob7tPwpN3DE3xUqdUJGhMqx/owo+LNIONc7/a0/XMkNfOe6fItsFnl1xyJ/BIYalsB/E5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735581173; c=relaxed/simple;
	bh=wtx9lhYgpzyt6UOu+vwUM54RV//vyEUnDlTE351tjcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYKX7fvI+4tUw40hrajq8cHN4QX6WlCDDfdrWn9+0xAOv46aolWRjc4Igxw1VbNwtIfsFa1hnaA+BlNKmHeiomdh47ns99rpSWiyMzrx59B8xgfF2m/DyHBxqiqWOOiG17XwuXTX1zVeEBCYuoXhO2jnfC5mS1HfF2UxWHt/kDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d32fAyna; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6c3629816so463232285a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 09:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735581171; x=1736185971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl6D4/OGPsSS/lVU4KW9chLe2IQERBjafIonsY8abVw=;
        b=d32fAynauXq1VylCT5HuhrP62te6ZIwzKs4/sicJj0NbItoRsPiwHVnIwBORUNuiLb
         gE3uWtH9EatnBquSZA4SsDKiRN6sJUd+pzWUL3iD2UQfHxMieJScjvE3S5PSwjXasoVU
         Dp7YnHeZa/Kvj2JjU+IEpYXjTm0qEJQOjOdDybHJoih3tvHtdUcsb4Yhh8efIRsrKT/D
         1kyfyj7Moe9qQY36YQGjQKONJpFmYa4ohNF3WO/hdjjrc4uyYOIlCclOtTpEzCJGvhFA
         7CHpc5+6bNIIxLShlXKn6ImU5HWZG0P1VLFT86+W326qtV98mC1uROvj8dnK+xmjq4hz
         MSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735581171; x=1736185971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl6D4/OGPsSS/lVU4KW9chLe2IQERBjafIonsY8abVw=;
        b=bw42tgJNzYe7V0VC+sjv6kj63cplbSWo1KZuMUPwwPyYN/bVprx+BD9a4OsjsP86z8
         kLlskBA8yuRWJPj6D7BjLpG27qJkgLLYj8q392y+JyQAjC9GICWqo68pnwreOQV0RMwE
         g6dNotM6OYrkoOJqevxWLUjLrGbiHq3cUyMuaNQRHORYk6YOlPIUlbu4pIgbc2mNULOA
         FBwJX6yzj0prnfjDGAP0cQzcyWv0s98w3tXxbWCEptAvB+Xff166IlJhaTToU5jcN76h
         RaXq5KrHH6618KDSA8qngg4GHsbRwDSPpIo+KQM9yAwfK7f6gF8qCQMZznXF40UNj0Mr
         WxLg==
X-Forwarded-Encrypted: i=1; AJvYcCWhbEaKeugaiFirfcZV60lDv9kTQ2ZpFBC5YLQT2aQali98UJsSGxmb35XI4rM4KSlkGKOsBrFtah8NXxVM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uMbgnCiy8yNGrwY7ZAGaCPQiLF5slWX8Lj99OKAarfjYwgEi
	2XCFdOCBwzPLTUJ4l/95pr8aVUvoRFYfEdH5GClVIsYxDjliaraP9fG9m8lmEPttNTifHzC3nOm
	0RZPLghhckEi5Rqd21tyih4aQfeY=
X-Gm-Gg: ASbGncuPYJpfAn96TnXGWs41jajxlc28/eAjXGWCfztHFMSISOPL0svIV9NRaWkJoGJ
	D0dAY1RnGNtmpvmSgY/M6tuCgxMW9hsNeFZDVFo4=
X-Google-Smtp-Source: AGHT+IG1fD9d2qEe8NNVF+XcqnA5vIgr9NXzg3d5mpIjwEWn94FC5Kw0ccjCiDvmkt4DDKgeMLrK9SdqwNMGS8A1vmQ=
X-Received: by 2002:a05:620a:3915:b0:7b6:dd82:ac9c with SMTP id
 af79cd13be357-7b9ba6ef8a0mr6082113785a.12.1735581170846; Mon, 30 Dec 2024
 09:52:50 -0800 (PST)
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
 <CAJnrk1YwNw7C=EMfKQzN88Zq_2Qih5Te_bfkeaOf=tG+L3u9eA@mail.gmail.com> <934dc31b-e38a-4506-a2eb-59a67f544305@fastmail.fm>
In-Reply-To: <934dc31b-e38a-4506-a2eb-59a67f544305@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 30 Dec 2024 09:52:40 -0800
Message-ID: <CAJnrk1aoKB_uMqjtdM7omj2ZEJ08es3pfdkzku9PmQg8vx=9zQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 12:32=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 12/27/24 21:08, Joanne Koong wrote:
> > On Thu, Dec 26, 2024 at 12:13=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> >>
> >> On Tue, Dec 24, 2024 at 01:37:49PM +0100, David Hildenbrand wrote:
> >>> On 23.12.24 23:14, Shakeel Butt wrote:
> >>>> On Sat, Dec 21, 2024 at 05:18:20PM +0100, David Hildenbrand wrote:
> >>>> [...]
> >>>>>
> >>>>> Yes, so I can see fuse
> >>>>>
> >>>>> (1) Breaking memory reclaim (memory cannot get freed up)
> >>>>>
> >>>>> (2) Breaking page migration (memory cannot be migrated)
> >>>>>
> >>>>> Due to (1) we might experience bigger memory pressure in the system=
 I guess.
> >>>>> A handful of these pages don't really hurt, I have no idea how bad =
having
> >>>>> many of these pages can be. But yes, inherently we cannot throw awa=
y the
> >>>>> data as long as it is dirty without causing harm. (maybe we could m=
ove it to
> >>>>> some other cache, like swap/zswap; but that smells like a big and
> >>>>> complicated project)
> >>>>>
> >>>>> Due to (2) we turn pages that are supposed to be movable possibly f=
or a long
> >>>>> time unmovable. Even a *single* such page will mean that CMA alloca=
tions /
> >>>>> memory unplug can start failing.
> >>>>>
> >>>>> We have similar situations with page pinning. With things like O_DI=
RECT, our
> >>>>> assumption/experience so far is that it will only take a couple of =
seconds
> >>>>> max, and retry loops are sufficient to handle it. That's why only l=
ong-term
> >>>>> pinning ("indeterminate", e.g., vfio) migrate these pages out of
> >>>>> ZONE_MOVABLE/MIGRATE_CMA areas in order to long-term pin them.
> >>>>>
> >>>>>
> >>>>> The biggest concern I have is that timeouts, while likely reasonabl=
e it many
> >>>>> scenarios, might not be desirable even for some sane workloads, and=
 the
> >>>>> default in all system will be "no timeout", letting the clueless ad=
min of
> >>>>> each and every system out there that might support fuse to make a d=
ecision.
> >>>>>
> >>>>> I might have misunderstood something, in which case I am very sorry=
, but we
> >>>>> also don't want CMA allocations to start failing simply because a n=
etwork
> >>>>> connection is down for a couple of minutes such that a fuse daemon =
cannot
> >>>>> make progress.
> >>>>>
> >>>>
> >>>> I think you have valid concerns but these are not new and not unique=
 to
> >>>> fuse. Any filesystem with a potential arbitrary stall can have simil=
ar
> >>>> issues. The arbitrary stall can be caused due to network issues or s=
ome
> >>>> faultly local storage.
> >>>
> >>> What concerns me more is that this is can be triggered by even unpriv=
ileged
> >>> user space, and that there is no default protection as far as I under=
stood,
> >>> because timeouts cannot be set universally to a sane defaults.
> >>>
> >>> Again, please correct me if I got that wrong.
> >>>
> >>
> >> Let's route this question to FUSE folks. More specifically: can an
> >> unprivileged process create a mount point backed by itself, create a
> >> lot of dirty (bound by cgroup) and writeback pages on it and let the
> >> writeback pages in that state forever?
> >>
> >>>
> >>> BTW, I just looked at NFS out of interest, in particular
> >>> nfs_page_async_flush(), and I spot some logic about re-dirtying pages=
 +
> >>> canceling writeback. IIUC, there are default timeouts for UDP and TCP=
,
> >>> whereby the TCP default one seems to be around 60s (* retrans?), and =
the
> >>> privileged user that mounts it can set higher ones. I guess one could=
 run
> >>> into similar writeback issues?
> >>
> >> Yes, I think so.
> >>
> >>>
> >>> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs?
> >>
> >> I feel like INDETERMINATE in the name is the main cause of confusion.
> >> So, let me explain why it is required (but later I will tell you how i=
t
> >> can be avoided). The FUSE thread which is actively handling writeback =
of
> >> a given folio can cause memory allocation either through syscall or pa=
ge
> >> fault. That memory allocation can trigger global reclaim synchronously
> >> and in cgroup-v1, that FUSE thread can wait on the writeback on the sa=
me
> >> folio whose writeback it is supposed to end and cauing a deadlock. So,
> >> AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.
> >>
> >> The in-kernel fs avoid this situation through the use of GFP_NOFS
> >> allocations. The userspace fs can also use a similar approach which is
> >> prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I have be=
en
> >> told that it is hard to use as it is per-thread flag and has to be set
> >> for all the threads handling writeback which can be error prone if the
> >> threadpool is dynamic. Second it is very coarse such that all the
> >> allocations from those threads (e.g. page faults) become NOFS which
> >> makes userspace very unreliable on highly utilized machine as NOFS can
> >> not reclaim potentially a lot of memory and can not trigger oom-kill.
> >>
> >>> Not
> >>> sure if I grasped all details about NFS and writeback and when it wou=
ld
> >>> redirty+end writeback, and if there is some other handling in there.
> >>>
> >> [...]
> >>>>
> >>>> Please note that such filesystems are mostly used in environments li=
ke
> >>>> data center or hyperscalar and usually have more advanced mechanisms=
 to
> >>>> handle and avoid situations like long delays. For such environment
> >>>> network unavailability is a larger issue than some cma allocation
> >>>> failure. My point is: let's not assume the disastrous situaion is no=
rmal
> >>>> and overcomplicate the solution.
> >>>
> >>> Let me summarize my main point: ZONE_MOVABLE/MIGRATE_CMA must only be=
 used
> >>> for movable allocations.
> >>>
> >>> Mechanisms that possible turn these folios unmovable for a
> >>> long/indeterminate time must either fail or migrate these folios out =
of
> >>> these regions, otherwise we start violating the very semantics why
> >>> ZONE_MOVABLE/MIGRATE_CMA was added in the first place.
> >>>
> >>> Yes, there are corner cases where we cannot guarantee movability (e.g=
., OOM
> >>> when allocating a migration destination), but these are not cases tha=
t can
> >>> be triggered by (unprivileged) user space easily.
> >>>
> >>> That's why FOLL_LONGTERM pinning does exactly that: even if user spac=
e would
> >>> promise that this is really only "short-term", we will treat it as "p=
ossibly
> >>> forever", because it's under user-space control.
> >>>
> >>>
> >>> Instead of having more subsystems violate these semantics because
> >>> "performance" ... I would hope we would do better. Maybe it's an issu=
e for
> >>> NFS as well ("at least" only for privileged user space)? In which cas=
e,
> >>> again, I would hope we would do better.
> >>>
> >>>
> >>> Anyhow, I'm hoping there will be more feedback from other MM folks, b=
ut
> >>> likely right now a lot of people are out (just like I should ;) ).
> >>>
> >>> If I end up being the only one with these concerns, then likely peopl=
e can
> >>> feel free to ignore them. ;)
> >>
> >> I agree we should do better but IMHO it should be an iterative process=
.
> >> I think your concerns are valid, so let's push the discussion towards
> >> resolving those concerns. I think the concerns can be resolved by bett=
er
> >> handling of lifetime of folios under writeback. The amount of such
> >> folios is already handled through existing dirty throttling mechanism.
> >>
> >> We should start with a baseline i.e. distribution of lifetime of folio=
s
> >> under writeback for traditional storage devices (spinning disk and SSD=
s)
> >> as we don't want an unrealistic goal for ourself. I think this data wi=
ll
> >> drive the appropriate timeout values (if we decide timeout based
> >> approach is the right one).
> >>
> >> At the moment we have timeout based approach to limit the lifetime of
> >> folios under writeback. Any other ideas?
> >
> > I don't see any other approach that would handle splice, other than
> > modifying the splice code to prevent the underlying buf->page from
> > being migrated while it's being copied out, which seems non-viable to
> > consider. The other alternatives I see are to either a) do the extra
> > temp page copying for splice and "abort" the writeback if migration is
> > triggered or b) gate this to only apply to servers running as
> > privileged. I assume the majority of use cases do use splice, in which
> > case a) would be pointless and would make the internal logic more
> > complicated (eg we would still need the rb tree and would now need to
> > check writeback against the folio writeback state or the rb tree,
> > etc). I'm not sure how useful this would be either if this is just
> > gated to privileged servers.
>
>
> I'm not so sure about that majority of unprivileged servers.
> Try this patch and then run an unprivileged process.
>
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index ee0b3b1d0470..adebfbc03d4c 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -3588,6 +3588,7 @@ static int _fuse_session_receive_buf(struct fuse_se=
ssion *se,
>                         res =3D fcntl(llp->pipe[0], F_SETPIPE_SZ, bufsize=
);
>                         if (res =3D=3D -1) {
>                                 llp->can_grow =3D 0;
> +                               fuse_log(FUSE_LOG_ERR, "cannot grow pipe\=
n");
>                                 res =3D grow_pipe_to_max(llp->pipe[0]);
>                                 if (res > 0)
>                                         llp->size =3D res;
> @@ -3678,6 +3679,7 @@ static int _fuse_session_receive_buf(struct fuse_se=
ssion *se,
>
>         } else {
>                 /* Don't overwrite buf->mem, as that would cause a leak *=
/
> +               fuse_log(FUSE_LOG_WARNING, "Using splice\n");
>                 buf->fd =3D tmpbuf.fd;
>                 buf->flags =3D tmpbuf.flags;
>         }
> @@ -3687,6 +3689,7 @@ static int _fuse_session_receive_buf(struct fuse_se=
ssion *se,
>
>  fallback:
>  #endif
> +       fuse_log(FUSE_LOG_WARNING, "Splice fallback\n");
>         if (!buf->mem) {
>                 buf->mem =3D buf_alloc(se->bufsize, internal);
>                 if (!buf->mem) {
>
>
> And then run this again after
> sudo sysctl -w fs.pipe-max-size=3D1052672
>
> (Please don't change '/proc/sys/fs/fuse/max_pages_limit'
> from default).
>
> And now we would need to know how many users either limit
> max-pages + header to fit default pipe-max-size (1MB) or
> increase max_pages_limit. Given there is no warning in
> libfuse about the fallback from splice to buf copy, I doubt
> many people know about that - who would change system
> defaults without the knowledge?
>

My concern is that this would break backwards compatibility for the
rare subset of users who use their own custom library instead of
libfuse, who expect splice to work as-is and might not have this
in-built fallback to buffer copies.


Thanks,
Joanne

>
> And then, I still doubt that copy-to-tmp-page-and-splice
> is any faster than no-tmp-page-copy-but-copy-to-lib-fuse-buffer.
> Especially as the tmp page copy is single threaded, I think.
> But needs to be benchmarked.
>
>
> Thanks,
> Bernd
>
>
>

