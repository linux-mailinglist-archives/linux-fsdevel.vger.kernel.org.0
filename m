Return-Path: <linux-fsdevel+bounces-33091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC319B3D67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 23:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA26289DE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 22:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE92B1F4299;
	Mon, 28 Oct 2024 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzKdCw9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4081F4293
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152709; cv=none; b=JPPJIu0AA1xxD3b7RAILaTEQVAe6GKnNU1LkFcXSCpbQr34VnMbvpn6mzzB5GJ2p7/79A8ihY6053xk1zvbEvls6u0cDvbRP6+JNi7QQyIgcr4pFTNDMREPkOeQLyTRAm8yhkt8vh8xpoGBcteLyjBWpXgRZHnoJBehFwqcJXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152709; c=relaxed/simple;
	bh=eX4C4QXvqzRx27A4qMK4EvrZocDatMDVI+kivjSBLQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/XoGql/og5DlYOrtxLMB1G/H+2ebjQhjFL/Tf/fauPAYA3IZLgJtEBznP6R7MbkoiAyuE5zvF9DoPbK7SYhqLNmkKrkdlSOayjDmdKaIm9BVf6LgsYivKDXsm+q3hprAAgJNmKDJb2ETr3NUmaRwgNI9/KG0S1zXjHAWcZnuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzKdCw9r; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fd01c9defso1486178241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730152705; x=1730757505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3nHNIn+SyqbBhOxYH3nfi3fd5TG0GXRysbDD+pOE5g=;
        b=RzKdCw9rmHe4WCeeKrP/xNnqwoQy/O4OX8lF8RfbwVkD3Pd7y8fTOEwJdLWaUtp3DJ
         ch/4BQwiNFbFg3sKo1R02uiFJqqSYWch3j0nPdhDuJA59Wo8IYJwpfZYoCqfxrqsAfC1
         wA4bVl2tF7cSl45qtptPHjqOlLLrHZ13qD6X3wjLBcByLVFORyYdwobJ7KymdfYY9vP6
         oS7j78rI0+RZnD5ST+2ZOPn0n4O28hj8lv3VF2QZqLmWdetY6Y3zMQrarSBy4J/PfPtc
         O7kAyDwfNfSPzschunWxhA+trKfHFv0dzE9AYFFUGWU5CQXY9n0FipsCZKogMj8Y+hra
         X5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152705; x=1730757505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3nHNIn+SyqbBhOxYH3nfi3fd5TG0GXRysbDD+pOE5g=;
        b=K/EoMiqaf1xsyuCyyvDd9/XI3/fr2sivvuFchB//ZhR+ZsMlDhvzXzAZNMp0AqC2OW
         2KlH3zkGdaMcJ/qxmMfAMcmblTzzsObEkQuwDGApRTYeS386rwpbnaDO7qaDkZiGa5Yi
         BU8uTNVlY5984EK6tlCMqe7aao/S9lkl2h2gURwPMa1EQw4z1XgJ1HDxAeocJ1jHUOSn
         BgW1fvfK65mGyamSEft63W3Fs7KprRO1fZdAdr9zn6v+rkQbUhViWUfo3iv0EKuW2u6V
         fowX4MHImYDHqKIE8VZ55MOCoKCKYk/A/tQc1lbBx+dTeW2bB0YpqaahnGpqeXpSf2hW
         fB0w==
X-Forwarded-Encrypted: i=1; AJvYcCVmh/YozYDAai1+0NC+ueRkMEewiuy292htfxlJzQDUjpN0+60usYh0b7zevpj+3xiQ8OWKESIBQEcm/zg3@vger.kernel.org
X-Gm-Message-State: AOJu0YyPtJbI5oRbFbX3Eb7Z/0Q6aB3NkIn572olvYjK4YRZ1cCkWS7X
	AtYwARcFt8exq6p20/jAPU+1JhUHQm4O8PWlAl3z40g7oCLsIrO2QGtmHYk0oytoElFaBmMj43u
	52YCrHE8P02NvJAiHR/lsKl7mL4M=
X-Google-Smtp-Source: AGHT+IGTPkceBN5rXEH7cS6guGCFxTUJCyFx78BQM1XPeK2sw1zZlYSCbxYSZi4Q0TMNXdmeO1AsxjKvDINxFRdw+pI=
X-Received: by 2002:a05:6102:160a:b0:4a5:e5e5:f929 with SMTP id
 ada2fe7eead31-4a8cfb85fe5mr8216854137.13.1730152705400; Mon, 28 Oct 2024
 14:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
 <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com> <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJnrk1ZNqLXAM=QZO+rCqarY1ZP=9_naU7WNyrmPAY=Q2Htu_Q@mail.gmail.com>
In-Reply-To: <CAJnrk1ZNqLXAM=QZO+rCqarY1ZP=9_naU7WNyrmPAY=Q2Htu_Q@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 28 Oct 2024 14:58:14 -0700
Message-ID: <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:40=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, Oct 25, 2024 at 10:36=E2=80=AFAM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 6:38=E2=80=AFPM Jingbo Xu <jefflexu@linux.aliba=
ba.com> wrote:
> > >
> > >
> > >
> > > On 10/25/24 12:54 AM, Joanne Koong wrote:
> > > > On Mon, Oct 21, 2024 at 2:05=E2=80=AFPM Joanne Koong <joannelkoong@=
gmail.com> wrote:
> > > >>
> > > >> On Mon, Oct 21, 2024 at 3:15=E2=80=AFAM Miklos Szeredi <miklos@sze=
redi.hu> wrote:
> > > >>>
> > > >>> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
> > > >>>
> > > >>>> I feel like this is too much restrictive and I am still not sure=
 why
> > > >>>> blocking on fuse folios served by non-privileges fuse server is =
worse
> > > >>>> than blocking on folios served from the network.
> > > >>>
> > > >>> Might be.  But historically fuse had this behavior and I'd be ver=
y
> > > >>> reluctant to change that unconditionally.
> > > >>>
> > > >>> With a systemwide maximal timeout for fuse requests it might make
> > > >>> sense to allow sync(2), etc. to wait for fuse writeback.
> > > >>>
> > > >>> Without a timeout allowing fuse servers to block sync(2) indefini=
tely
> > > >>> seems rather risky.
> > > >>
> > > >> Could we skip waiting on writeback in sync(2) if it's a fuse folio=
?
> > > >> That seems in line with the sync(2) documentation Jingbo reference=
d
> > > >> earlier where it states "The writing, although scheduled, is not
> > > >> necessarily complete upon return from sync()."
> > > >> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.ht=
ml
> > > >>
> > > >
> > > > So I think the answer to this is "no" for Linux. What the Linux man
> > > > page for sync(2) says:
> > > >
> > > > "According to the standard specification (e.g., POSIX.1-2001), sync=
()
> > > > schedules the writes, but may return before the actual writing is
> > > > done.  However Linux waits for I/O completions, and thus sync() or
> > > > syncfs() provide the same guarantees as fsync() called on every fil=
e
> > > > in the system or filesystem respectively." [1]
> > >
> > > Actually as for FUSE, IIUC the writeback is not guaranteed to be
> > > completed when sync(2) returns since the temp page mechanism.  When
> > > sync(2) returns, PG_writeback is indeed cleared for all original page=
s
> > > (in the address_space), while the real writeback work (initiated from
> > > temp page) may be still in progress.
> > >
> >
> > That's a great point. It seems like we can just skip waiting on
> > writeback to finish for fuse folios in sync(2) altogether then. I'll
> > look into what's the best way to do this.
> >
> > > I think this is also what Miklos means in:
> > > https://lore.kernel.org/all/CAJfpegsJKD4YT5R5qfXXE=3DhyqKvhpTRbD4m1ws=
YNbGB6k4rC2A@mail.gmail.com/
> > >
> > > Though we need special handling for AS_NO_WRITEBACK_RECLAIM marked pa=
ges
> > > in sync(2) codepath similar to what we have done for the direct recla=
im
> > > in patch 1.
> > >
> > >
> > > >
> > > > Regardless of the compaction / page migration issue then, this
> > > > blocking sync(2) is a dealbreaker.
> > >
> > > I really should have figureg out the compaction / page migration
> > > mechanism and the potential impact to FUSE when we dropping the temp
> > > page.  Just too busy to take some time on this though.....
> >
> > Same here, I need to look some more into the compaction / page
> > migration paths. I'm planning to do this early next week and will
> > report back with what I find.
> >
>
> These are my notes so far:
>
> * We hit the folio_wait_writeback() path when callers call
> migrate_pages() with mode MIGRATE_SYNC
>    ... -> migrate_pages() -> migrate_pages_sync() ->
> migrate_pages_batch() -> migrate_folio_unmap() ->
> folio_wait_writeback()
>
> * These are the places where we call migrate_pages():
> 1) demote_folio_list()
> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>
> 2) __damon_pa_migrate_folio_list()
> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>
> 3) migrate_misplaced_folio()
> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>
> 4) do_move_pages_to_node()
> Can ignore this. This calls migrate_pages() in MIGRATE_SYNC mode but
> this path is only invoked by the move_pages() syscall. It's fine to
> wait on writeback for the move_pages() syscall since the user would
> have to deliberately invoke this on the fuse server for this to apply
> to the server's fuse folios
>
> 5)  migrate_to_node()
> Can ignore this for the same reason as in 4. This path is only invoked
> by the migrate_pages() syscall.
>
> 6) do_mbind()
> Can ignore this for the same reason as 4 and 5. This path is only
> invoked by the mbind() syscall.
>
> 7) soft_offline_in_use_page()
> Can skip soft offlining fuse folios (eg folios with the
> AS_NO_WRITEBACK_WAIT mapping flag set).
> The path for this is soft_offline_page() -> soft_offline_in_use_page()
> -> migrate_pages(). soft_offline_page() only invokes this for in-use
> pages in a well-defined state (see ret value of get_hwpoison_page()).
> My understanding of soft offlining pages is that it's a mitigation
> strategy for handling pages that are experiencing errors but are not
> yet completely unusable, and its main purpose is to prevent future
> issues. It seems fine to skip this for fuse folios.
>
> 8) do_migrate_range()
> 9) compact_zone()
> 10) migrate_longterm_unpinnable_folios()
> 11) __alloc_contig_migrate_range()
>
> 8 to 11 needs more investigation / thinking about. I don't see a good
> way around these tbh. I think we have to operate under the assumption
> that the fuse server running is malicious or benevolently but
> incorrectly written and could possibly never complete writeback. So we
> definitely can't wait on these but it also doesn't seem like we can
> skip waiting on these, especially for the case where the server uses
> spliced pages, nor does it seem like we can just fail these with
> -EBUSY or something.
>

I'm still not seeing a good way around this.

What about this then? We add a new fuse sysctl called something like
"/proc/sys/fs/fuse/writeback_optimization_timeout" where if the sys
admin sets this, then it opts into optimizing writeback to be as fast
as possible (eg skipping the page copies) and if the server doesn't
fulfill the writeback by the set timeout value, then the connection is
aborted.

Alternatively, we could also repurpose
/proc/sys/fs/fuse/max_request_timeout from the request timeout
patchset [1] but I like the additional flexibility and explicitness
having the "writeback_optimization_timeout" sysctl gives.

Any thoughts on this?

[1] https://lore.kernel.org/linux-fsdevel/20241011191320.91592-4-joannelkoo=
ng@gmail.com/

Thanks,
Joanne

> Will continue looking more into this early next week.
>
> Thanks,
> Joanne
> >
> > Thanks,
> > Joanne
> > >
> > >
> > > --
> > > Thanks,
> > > Jingbo

