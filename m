Return-Path: <linux-fsdevel+bounces-33258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C629B68D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A791C21BD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432B21764B;
	Wed, 30 Oct 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJrRdiCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F4215C42
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304314; cv=none; b=FZMKAiZABh93BJRRtHPWYEDHP3GBlCpWbPur+fggPFcAHf/OrV91H/lAkNt3bfyvEACr7nbuen4NooqUTnzn0Ydrd1mcrLytP9h3Fx65tkTIEYrH00Dw/FWVbvjEhH5OC/y4AxmqvkSwOt5xCSuWcudwp5MeSvT8W9sXn6ItLEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304314; c=relaxed/simple;
	bh=1NlHwaaPKdQvAJxIn5Lc8arDeCpVlqTkaIh7edf3X7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJRPdeNC3ibiprEAbmkk8thaWsZuSO52EjGBxaQsuybtZJEQE8r8uGfhCMN0d2mx1ggmYvw0GxYokptZ4U/pvZGU+8Bn9saXtrCKo9ry7gnwOO+CSvcLBIaMLsSjLVMvZi16UbeBEgSKBWEcMYozO/YC+h9bRg7CZH6kEKQz/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJrRdiCi; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460ad98b031so415481cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730304311; x=1730909111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6rBxDoMeGU1XAZ5CKnR5c6eqwtuSXjVYA5VGpPM5Q8=;
        b=SJrRdiCi+fCDeFplRohLPHd4DOhmEy+B/IBasy2mon1BhzAuFevq+dYxAZ5gVndhst
         StFg9y4a6/bAfqLiIJnfbrI+8zIgrHpjd3mT8uWQDs2URgnxZ1yLM6a7nUIfXY0etp1f
         BMYI6aftvTDCpiEZmYAj8SBhN5DQ6NmQy46cgl2MVs9LMClVr4mzEJB67nVy8yUKL46y
         faEVaXJnAsBJrlgY2CaYuyoCjrK63xCV77R1T1jYvWlMofImuqSbcacM7LOGb2OOhJ8r
         IGjZTvfH3SkU4DkowhS4he7TR5rBpzz4ce5bTB/e2xutb1T/FbXUTLsGMRmGB5q6BSJE
         +0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304311; x=1730909111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6rBxDoMeGU1XAZ5CKnR5c6eqwtuSXjVYA5VGpPM5Q8=;
        b=f1f94gbYrpJCZr97P1QOv2pnbW1ZA1SCeP9jmSHcwpnlG9Z2C0mFMVMCaEE/D8TCu8
         sG9hdavLTiZggIyYNWKdClvhLFTMq2gb7VpAKGZpl52C4ByPSa6abiyh35yS1u64lh9Y
         xzbtVgFlgTAdPVaWkTBDWcPR1BzcBJ7OO4hSCmWGhmWn2d8iq0Eja+ljfws7PZ+9wynx
         ItJxxf8MeIVgca9/qRsIriME8aT8JS3nmeDDxMqaWh+CG2W2z1hWkY86Hwukg8dwdb3Q
         cEHLD9M3Cg3kSra8JT4oTYMH03n2keYWmBR2koOCV1ZXzhov/t7LLt+P2sSo/eIQmhHt
         2PxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFv9MsFkdOtGzEf09ynXZl278no5B2NiOf3T+QFe/TqNJndaHO7QxzolgLmArTJ3jEzeMAPI2GxZAgil4p@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaj+jiN0d7Cn2InePnYiXaOaPKPWtmLz1guv7S/d9gRa2hjZUG
	SePgy7aL4MAb4ipa4D6bjjnVrxT4t4w+BH/abQZEUfE81WR6PUOR9nVp8PDw4fnzWLVynQhdTY1
	vP07skZB7D86AM1yeil4XxP2EAOs=
X-Google-Smtp-Source: AGHT+IF3eZqBbcty68Z/nY+r1rpVGK1MObGX4mzosigOkKr9VKbu8vlHA5A2Cfaxx0Mb5Vnl+aOEWabJY6mtG5IjAJg=
X-Received: by 2002:a05:622a:354:b0:461:2616:84bf with SMTP id
 d75a77b69052e-4613c01552cmr215734991cf.23.1730304310471; Wed, 30 Oct 2024
 09:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
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
 <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com> <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm>
In-Reply-To: <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 30 Oct 2024 09:04:59 -0700
Message-ID: <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:32=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 10/28/24 22:58, Joanne Koong wrote:
> > On Fri, Oct 25, 2024 at 3:40=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >>> Same here, I need to look some more into the compaction / page
> >>> migration paths. I'm planning to do this early next week and will
> >>> report back with what I find.
> >>>
> >>
> >> These are my notes so far:
> >>
> >> * We hit the folio_wait_writeback() path when callers call
> >> migrate_pages() with mode MIGRATE_SYNC
> >>    ... -> migrate_pages() -> migrate_pages_sync() ->
> >> migrate_pages_batch() -> migrate_folio_unmap() ->
> >> folio_wait_writeback()
> >>
> >> * These are the places where we call migrate_pages():
> >> 1) demote_folio_list()
> >> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
> >>
> >> 2) __damon_pa_migrate_folio_list()
> >> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
> >>
> >> 3) migrate_misplaced_folio()
> >> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
> >>
> >> 4) do_move_pages_to_node()
> >> Can ignore this. This calls migrate_pages() in MIGRATE_SYNC mode but
> >> this path is only invoked by the move_pages() syscall. It's fine to
> >> wait on writeback for the move_pages() syscall since the user would
> >> have to deliberately invoke this on the fuse server for this to apply
> >> to the server's fuse folios
> >>
> >> 5)  migrate_to_node()
> >> Can ignore this for the same reason as in 4. This path is only invoked
> >> by the migrate_pages() syscall.
> >>
> >> 6) do_mbind()
> >> Can ignore this for the same reason as 4 and 5. This path is only
> >> invoked by the mbind() syscall.
> >>
> >> 7) soft_offline_in_use_page()
> >> Can skip soft offlining fuse folios (eg folios with the
> >> AS_NO_WRITEBACK_WAIT mapping flag set).
> >> The path for this is soft_offline_page() -> soft_offline_in_use_page()
> >> -> migrate_pages(). soft_offline_page() only invokes this for in-use
> >> pages in a well-defined state (see ret value of get_hwpoison_page()).
> >> My understanding of soft offlining pages is that it's a mitigation
> >> strategy for handling pages that are experiencing errors but are not
> >> yet completely unusable, and its main purpose is to prevent future
> >> issues. It seems fine to skip this for fuse folios.
> >>
> >> 8) do_migrate_range()
> >> 9) compact_zone()
> >> 10) migrate_longterm_unpinnable_folios()
> >> 11) __alloc_contig_migrate_range()
> >>
> >> 8 to 11 needs more investigation / thinking about. I don't see a good
> >> way around these tbh. I think we have to operate under the assumption
> >> that the fuse server running is malicious or benevolently but
> >> incorrectly written and could possibly never complete writeback. So we
> >> definitely can't wait on these but it also doesn't seem like we can
> >> skip waiting on these, especially for the case where the server uses
> >> spliced pages, nor does it seem like we can just fail these with
> >> -EBUSY or something.
>
> I see some code paths with -EAGAIN in migration. Could you explain why
> we can't just fail migration for fuse write-back pages?
>

My understanding (and please correct me here Shakeel if I'm wrong) is
that this could block system optimizations, especially since if an
unprivileged malicious fuse server never replies to the writeback
request, then this completely stalls progress. In the best case
scenario, -EAGAIN could be used because the server might just be slow
in serving the writeback, but I think we need to also account for
servers that never complete the writeback. For
__alloc_contig_migrate_range() for example, my understanding is that
this is used to migrate pages so that there are more physically
contiguous ranges of memory freed up. If fuse writeback blocks that,
then that hurts system health overall.

> >>
> >
> > I'm still not seeing a good way around this.
> >
> > What about this then? We add a new fuse sysctl called something like
> > "/proc/sys/fs/fuse/writeback_optimization_timeout" where if the sys
> > admin sets this, then it opts into optimizing writeback to be as fast
> > as possible (eg skipping the page copies) and if the server doesn't
> > fulfill the writeback by the set timeout value, then the connection is
> > aborted.
> >
> > Alternatively, we could also repurpose
> > /proc/sys/fs/fuse/max_request_timeout from the request timeout
> > patchset [1] but I like the additional flexibility and explicitness
> > having the "writeback_optimization_timeout" sysctl gives.
> >
> > Any thoughts on this?
>
>
> I'm a bit worried that we might lock up the system until time out is
> reached - not ideal. Especially as timeouts are in minutes now. But
> even a slightly stuttering video system not be great. I think we
> should give users/admin the choice then, if they prefer slow page
> copies or fast, but possibly shortly unresponsive system.
>
I was thinking the /proc/sys/fs/fuse/writeback_optimization_timeout
would be in seconds, where the sys admin would probably set something
more reasonable like 5 seconds or so.
If this syctl value is set, then servers who want writebacks to be
fast can opt into it at mount time (and by doing so agree that they
will service writeback requests by the timeout or their connection
will be aborted).


Thanks,
Joanne
>
> Thank,
> Bernd

