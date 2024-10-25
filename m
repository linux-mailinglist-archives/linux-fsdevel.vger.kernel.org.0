Return-Path: <linux-fsdevel+bounces-32993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6459B12EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 00:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F10E283B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87721314A;
	Fri, 25 Oct 2024 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PteQC8Rq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EC213121
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896040; cv=none; b=fgXcwFj1IbITiugst0lq9huUDBdyENd/a0vf+RidpacqyfRviYbfIN4kMi8d2aWzl3c04Sz2eUsDwr2Lm/pjEzKFq9NG3R9rm2YwmtCPw4aBQMKuRqpWfujLtOAVbVIQLf92f9QTenadI6uPyfgWkC8sf42GIin/o+ybl4eMDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896040; c=relaxed/simple;
	bh=c3SW5EuRbFvIp2zmo43KWDIcphSnaOalzDrYhcDbP0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMvnrvdJkj6v/J/TNBYUWMnfYZOYmk4lpZisZpPw9COoM6E4d6tL3dgQ3KUltmKNhNDLg0BFAjzgh/HDXRNuM1G/jxE73m4hDJO+/UEYGZ8j3zF9JyLNHjDit6XF4x7InaQrKirKam2QEB3iOBkL/alYf7aXWVZ+b3bmXOJakfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PteQC8Rq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460c2418e37so16676321cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729896037; x=1730500837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvXrzVj6NC2cWh2gHTFKDNacmkNtTMz1oS0GDy16qUM=;
        b=PteQC8RqTwXsBetFXIf8w/RtpwRDnJ6V1d1OS+BnQMhTmJNN/aGpWYHBFDd657ih6L
         y3emfOPctBmury4qF0QD7MUVrVBcc2TOFgB3lpeOZrM7EOaWA1q4b5UsfAJmUgzFa4VS
         iDWPGGz7AGn2dbKOedThM/u2jPB2F0k8+0or+qWpCtTa3h+FAEAaIYlkLhfhyN4M0CaR
         c14EXJRC3R1Z7IfJ1PgUGNzzEr8vQY4kG0f4q4GddqPyfXFhGUo1TN7H2yB+jO2yA8Va
         cEf9kFRRNqNpoMmckhacG+4tY4heRet/+H7f8Y4SijBynW5b7rDrHaE/zOmoNA/Cm6XK
         AJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729896037; x=1730500837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvXrzVj6NC2cWh2gHTFKDNacmkNtTMz1oS0GDy16qUM=;
        b=RWgh8naDDE4Haetbp8ZLaLJA7j9aA8LqilgjdJA0COPEvhGKlt0gU7u0oEa9K7hqao
         zy2v3Moso2mTs3GB+eCMqzY1TsDFMh4c4hsOCTTSR5LaF4rsRDlYu4XLJ6eOWnJnRcJY
         t9jDGrAhbFwsr+iXh/26Ez/oh2Ql6dy1aljvSFTYh7VoQw9ftehar5Ky9uFDRFXAhhO+
         NigUjlbAVWS1X1MrBWRHbLTX/fqmNVhL15tsBfDgvjz0HR+VwYckZA4smy3JZ/NA4cE6
         34HwPEhKUscU2ihY0tlDDRL6f5nagVYr4cWaKiVbP+zlIw7fPm8cc29x0nkohn5Gto6E
         peeA==
X-Forwarded-Encrypted: i=1; AJvYcCU8cQpYaEbvT5QxGbq4NUHbVQC3UoHZSs23o4V2U4OH0HPD6S9S4shkrlnFoIusLNCpIs0kxNV8vxyvqODx@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFbBUFrIxkMbM9PiX5cQHRQRPuPGSQ9UBUydifc69/C5Jb4Tc
	qTT96gKZEG/Xx6BcbcS+nt4KfYc5oiepdfqUnk5Ycxd48gvqAStiTzvQFtu7di12VV5gPRhcbPw
	6wmorVu/V34Bz0drxFozEaIy8E0A=
X-Google-Smtp-Source: AGHT+IE10myqGBOKYbDb9FUpEshghqJacEmL6+A2IxbUQypP5oS37tUoNRDJ3ddjfNdtyCkXc9Exq5t0fKs3dlnqVTk=
X-Received: by 2002:ac8:5993:0:b0:45d:9525:42ff with SMTP id
 d75a77b69052e-4613c1a08c7mr10867181cf.54.1729896036954; Fri, 25 Oct 2024
 15:40:36 -0700 (PDT)
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
In-Reply-To: <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 25 Oct 2024 15:40:25 -0700
Message-ID: <CAJnrk1ZNqLXAM=QZO+rCqarY1ZP=9_naU7WNyrmPAY=Q2Htu_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:36=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Thu, Oct 24, 2024 at 6:38=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba=
.com> wrote:
> >
> >
> >
> > On 10/25/24 12:54 AM, Joanne Koong wrote:
> > > On Mon, Oct 21, 2024 at 2:05=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > >>
> > >> On Mon, Oct 21, 2024 at 3:15=E2=80=AFAM Miklos Szeredi <miklos@szere=
di.hu> wrote:
> > >>>
> > >>> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev>=
 wrote:
> > >>>
> > >>>> I feel like this is too much restrictive and I am still not sure w=
hy
> > >>>> blocking on fuse folios served by non-privileges fuse server is wo=
rse
> > >>>> than blocking on folios served from the network.
> > >>>
> > >>> Might be.  But historically fuse had this behavior and I'd be very
> > >>> reluctant to change that unconditionally.
> > >>>
> > >>> With a systemwide maximal timeout for fuse requests it might make
> > >>> sense to allow sync(2), etc. to wait for fuse writeback.
> > >>>
> > >>> Without a timeout allowing fuse servers to block sync(2) indefinite=
ly
> > >>> seems rather risky.
> > >>
> > >> Could we skip waiting on writeback in sync(2) if it's a fuse folio?
> > >> That seems in line with the sync(2) documentation Jingbo referenced
> > >> earlier where it states "The writing, although scheduled, is not
> > >> necessarily complete upon return from sync()."
> > >> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html
> > >>
> > >
> > > So I think the answer to this is "no" for Linux. What the Linux man
> > > page for sync(2) says:
> > >
> > > "According to the standard specification (e.g., POSIX.1-2001), sync()
> > > schedules the writes, but may return before the actual writing is
> > > done.  However Linux waits for I/O completions, and thus sync() or
> > > syncfs() provide the same guarantees as fsync() called on every file
> > > in the system or filesystem respectively." [1]
> >
> > Actually as for FUSE, IIUC the writeback is not guaranteed to be
> > completed when sync(2) returns since the temp page mechanism.  When
> > sync(2) returns, PG_writeback is indeed cleared for all original pages
> > (in the address_space), while the real writeback work (initiated from
> > temp page) may be still in progress.
> >
>
> That's a great point. It seems like we can just skip waiting on
> writeback to finish for fuse folios in sync(2) altogether then. I'll
> look into what's the best way to do this.
>
> > I think this is also what Miklos means in:
> > https://lore.kernel.org/all/CAJfpegsJKD4YT5R5qfXXE=3DhyqKvhpTRbD4m1wsYN=
bGB6k4rC2A@mail.gmail.com/
> >
> > Though we need special handling for AS_NO_WRITEBACK_RECLAIM marked page=
s
> > in sync(2) codepath similar to what we have done for the direct reclaim
> > in patch 1.
> >
> >
> > >
> > > Regardless of the compaction / page migration issue then, this
> > > blocking sync(2) is a dealbreaker.
> >
> > I really should have figureg out the compaction / page migration
> > mechanism and the potential impact to FUSE when we dropping the temp
> > page.  Just too busy to take some time on this though.....
>
> Same here, I need to look some more into the compaction / page
> migration paths. I'm planning to do this early next week and will
> report back with what I find.
>

These are my notes so far:

* We hit the folio_wait_writeback() path when callers call
migrate_pages() with mode MIGRATE_SYNC
   ... -> migrate_pages() -> migrate_pages_sync() ->
migrate_pages_batch() -> migrate_folio_unmap() ->
folio_wait_writeback()

* These are the places where we call migrate_pages():
1) demote_folio_list()
Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode

2) __damon_pa_migrate_folio_list()
Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode

3) migrate_misplaced_folio()
Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode

4) do_move_pages_to_node()
Can ignore this. This calls migrate_pages() in MIGRATE_SYNC mode but
this path is only invoked by the move_pages() syscall. It's fine to
wait on writeback for the move_pages() syscall since the user would
have to deliberately invoke this on the fuse server for this to apply
to the server's fuse folios

5)  migrate_to_node()
Can ignore this for the same reason as in 4. This path is only invoked
by the migrate_pages() syscall.

6) do_mbind()
Can ignore this for the same reason as 4 and 5. This path is only
invoked by the mbind() syscall.

7) soft_offline_in_use_page()
Can skip soft offlining fuse folios (eg folios with the
AS_NO_WRITEBACK_WAIT mapping flag set).
The path for this is soft_offline_page() -> soft_offline_in_use_page()
-> migrate_pages(). soft_offline_page() only invokes this for in-use
pages in a well-defined state (see ret value of get_hwpoison_page()).
My understanding of soft offlining pages is that it's a mitigation
strategy for handling pages that are experiencing errors but are not
yet completely unusable, and its main purpose is to prevent future
issues. It seems fine to skip this for fuse folios.

8) do_migrate_range()
9) compact_zone()
10) migrate_longterm_unpinnable_folios()
11) __alloc_contig_migrate_range()

8 to 11 needs more investigation / thinking about. I don't see a good
way around these tbh. I think we have to operate under the assumption
that the fuse server running is malicious or benevolently but
incorrectly written and could possibly never complete writeback. So we
definitely can't wait on these but it also doesn't seem like we can
skip waiting on these, especially for the case where the server uses
spliced pages, nor does it seem like we can just fail these with
-EBUSY or something.

Will continue looking more into this early next week.

Thanks,
Joanne
>
> Thanks,
> Joanne
> >
> >
> > --
> > Thanks,
> > Jingbo

