Return-Path: <linux-fsdevel+bounces-33501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB09B99B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 21:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67B11C22635
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1581E2609;
	Fri,  1 Nov 2024 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAtDehl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CC1E1C32
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494465; cv=none; b=HqaCuMEAE3vnrzRi/BPH1lnj4NEao2a6tCZZ9AYHzPQ3HxTEOQvUnkeBEF+OvQdtkUNdtbG6Wicz78n4cCa1xfENFhjKvbz+IKdK4RNPMcA81wEHMf+kOXFaj84SKiy/fplXhxSY47ziCsNt4kTTFjRuqfDDlmEDq/gx6JmxR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494465; c=relaxed/simple;
	bh=Tvw9ArwGHTAW6KkCJ87rVq1E3JTK4kff2Pw3NgLwhfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPsdqMhoRP0/1Oja9u+DbTa8urOPVzmyeL2bkxAHuxQ7yT4d2JlrU3DihkRLY1zZ5eBFKYqs1F0t0Dx0E2+kR8GIdl9+QtabuKcUeUyQXs8EBMVPzDhpwNmmZ+RMiewvkYdG+0NDawvVMTmjXkd4olSwuuHagRyrcdq9+H0q+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAtDehl7; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fc21ac668so524475241.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Nov 2024 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730494462; x=1731099262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72rrXdFo0l5ehALIIAXsZqz06DGl5q6wJrjEh4jxrE4=;
        b=MAtDehl79gWNW2mvl+5xpX59t4+QtHlSPHvwT+VfCpM9m/8M1yYSRSsOhOQMGmGEaS
         iENAM2rkTgUADcNweHo6ZTm9D0slIt4oyzG/Yc+/yeVuWkt1wYnEHyEUY6mvh4ucuFn0
         PHftSdQlMKzu+jFMsrCg+41VEHO7DecfEshduhcivS1/N4T8U69yjFim6Z7nRssJpDUL
         gAEhMIFrajA/3S6Mq6ynfuctOon7LeK6ptNwX6sc2CVDtAO/rpSsS7MZxl05tqnmbZWa
         cT8EFm4GP6AhuXv8sOihOICbO+Q0DjkSZ2Nos7X1E0aNqypc6C04zO1qZUKtuIbE3JcF
         5njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494462; x=1731099262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72rrXdFo0l5ehALIIAXsZqz06DGl5q6wJrjEh4jxrE4=;
        b=miI9aRHoz4QBWalYIfoKx1BoG9busZAXwsJjuvhv9HUxPGfhD9hEObdjedpG0WIJ5E
         xwBowrBuDn8Y32qkcQFmenqZ7Clos43ENXUMYFMIMfc3M+xOnygOmI8ooet6kGrD4eqI
         5sIUPQksmBv7W6laiv+w7Djo+/PscrH0H83cUS6EZTvZcl3Or2gjXx3I/m+NyrHlfAGE
         4YwT/sXF7FROyTxP3YPVXbbvlWhk3UvicB7oNU/anjmQ1/M+xHSl9LHQcL2BmGTNN2yO
         qbSK1ApPEZYN6RFJtz6ZP8Vj99SJtU8bqPuIQeqc1xbOJbUsGcWryoFc3jsHUAVPJ/oF
         bRrg==
X-Forwarded-Encrypted: i=1; AJvYcCW6yiwCe8itsnATuJoxsaBUGYMqqm2TzTtniuG7zRGd0bljUIX7QoZQu78e/07B152s0tVLmjsyCl+/jVrK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43IvCT1DQKvgh2c1UkIc43Q/bHrjjJyVvvPVWO/yHXMhQ4XlH
	4mVa+wcO2K0LA5kNMjXCGjTN///ccmN6/7BZErDVHP5Uae6cvjzs6SBevkhsZUlrlovWl9mVZfU
	+vLbySrwy7B6uk0Q3P3Agu194WnI=
X-Google-Smtp-Source: AGHT+IGuZG6Zps+QEUgjuCFxK13wB0hEARewUS++teG0zGNgGa68js4bh98mD2veSaeWbGmEogOQwRhqfD0Ttz81phk=
X-Received: by 2002:a05:6102:390b:b0:4a3:e644:54dd with SMTP id
 ada2fe7eead31-4a8cfb4d9e4mr24241735137.12.1730494462040; Fri, 01 Nov 2024
 13:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm> <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm> <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm> <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
 <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
 <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com>
 <ipa4ozknzw5wq4z4znhza3km5erishys7kf6ov26kmmh4r7kph@vedmnra6kpbz>
 <CAJnrk1aZV=1mXwO+SNupffLQtQNeD3Uz+PBcxL1TKBDgGsgQPg@mail.gmail.com> <43aeed1a-0572-4bcc-8c06-49522459f7d2@linux.alibaba.com>
In-Reply-To: <43aeed1a-0572-4bcc-8c06-49522459f7d2@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 1 Nov 2024 13:54:10 -0700
Message-ID: <CAJnrk1ZOGrOXPRhX0325RvqkLJbv3Bz_CB4Er+5eTs6=3Dr+Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 4:44=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
> Hi Joanne,
>
> Thanks for keeping pushing this forward.
>
> On 11/1/24 5:52 AM, Joanne Koong wrote:
> > On Thu, Oct 31, 2024 at 1:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> >>
> >> On Thu, Oct 31, 2024 at 12:06:49PM GMT, Joanne Koong wrote:
> >>> On Wed, Oct 30, 2024 at 5:30=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> >> [...]
> >>>>
> >>>> Memory pool is a bit confusing term here. Most probably you are aski=
ng
> >>>> about the migrate type of the page block from which tmp page is
> >>>> allocated from. In a normal system, tmp page would be allocated from=
 page
> >>>> block with MIGRATE_UNMOVABLE migrate type while the page cache page,=
 it
> >>>> depends on what gfp flag was used for its allocation. What does fuse=
 fs
> >>>> use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situat=
ion
> >>>> allocations can get mixed up with different migrate types.
> >>>>
> >>>
> >>> I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
> >>> fuse doesn't set any additional gfp masks on the inode mapping.
> >>>
> >>> Could we just allocate the fuse writeback pages with GFP_HIGHUSER
> >>> instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin()
> >>> where we pass in the gfp mask to __filemap_get_folio(). I think this
> >>> would give us the same behavior memory-wise as what the tmp pages
> >>> currently do,
> >>
> >> I don't think it would be the same behavior. From what I understand th=
e
> >> liftime of the tmp page is from the start of the writeback till the ac=
k
> >> from the fuse server that writeback is done. While the lifetime of the
> >> page of the page cache can be arbitrarily large. We should just make i=
t
> >> unmovable for its lifetime. I think it is fine to make the page
> >> unmovable during the writeback. We should not try to optimize for the
> >> bad or buggy behavior of fuse server.
> >>
> >> Regarding the avoidance of wait on writeback for fuse folios, I think =
we
> >> can handle the migration similar to how you are handling reclaim and i=
n
> >> addition we can add a WARN() in folio_wait_writeback() if the kernel e=
ver
> >> sees a fuse folio in that function.
> >
> > Awesome, this is what I'm planning to do in v3 to address migration the=
n:
> >
> > 1) in migrate_folio_unmap(), only call "folio_wait_writeback(src);" if
> > src->mapping does not have the AS_NO_WRITEBACK_WAIT bit set on it (eg
> > fuse folios will have that AS_NO_WRITEBACK_WAIT bit set)
>
> I think it's generally okay to skip FUSE pages under writeback when the
> sync migrate_pages() is called in low memory context, which only tries
> to migrate as many pages as possible (i.e. best effort).
>
> While more caution may be needed when the sync migrate_pages() is called
> with an implicit hint that the migration can not fail.  For example,
>
> ```
> offline_pages
>         while {
>                 scan_movable_pages
>                 do_migrate_range
>         }
> ```
>
> If the malicious server never completes the writeback IO, no progress
> will be made in the above while loop, and I'm afraid it will be a dead
> loop then.
>

Thanks for taking a look and sharing your thoughts.
I agree. I think for this offline_pages() path, we need to handle this
"TODO: fatal migration failures should bail out". For v3 I'm thinking
of handling this by having some number of retries where we try
do_migrate_range() but if it still doesn't succeed, to skip those
pages and move onto the next.

>
> >
> > 2) in the fuse filesystem's implementation of the
> > mapping->a_ops->migrate_folio callback, return -EAGAIN if the folio is
> > under writeback.
>
> Is there any possibility that a_ops->migrate_folio() may be called with
> the folio under writeback?
>
> - for most pages without AS_NO_WRITEBACK_WAIT, a_ops->migrate_folio()
> will be called only when Page_writeback is cleared;
> - for AS_NO_WRITEBACK_WAIT pages, they are skipped if they are under
> writeback
>

For AS_NO_WRITEBACK_WAIT_PAGES, if we skip waiting on them if they are
under writeback, I think the a_ops->migrate_folio() will still get
called (by migrate_pages_batch() -> migrate_folio_move() ->
move_to_new_folio()).

Looking at migrate_folio_unmap() some more though,  I don't think we
can just skip the wait call like we can for the sync(2) case. I think
we need to error out here instead since after the wait call,
migrate_folio_unmap() will replace the folio's page table mappings
(try_to_migrate()). If we error out here, then there's no hitting
a_ops->migrate_folio() when the folio is under writeback.


Thanks,
Joanne
> --
> Thanks,
> Jingbo

