Return-Path: <linux-fsdevel+bounces-32913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7AA9B0BBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7671C24214
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A841C69;
	Fri, 25 Oct 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHk354wF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7320C31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877801; cv=none; b=ni5fE50im5U5viFIIILfyiQBpxqiP3nbegWvILw2zT8AyI7AKmGbTH8/Kmzilrvdsf9lS4Ch9F3IchGb0h+NwqaCF/w89pgRVFxIRH61mtlSMudAHiRdUOIIECLkotVuNMI+SltxSc7pSPj4Hfu5mslPekC9nUhnE6QUDRUXDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877801; c=relaxed/simple;
	bh=xuX+9r+PnxiGiTGhcgLytOKd27qvZfHefj0rLxzlb3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5wZTSafyzbBYfZ/aN6JKIG3uoZzIaJKRkzfunNdkqPJFhbJNFbiFjIyYtaUVBLJVFrgsGxpW0RikzRp8riD2CbxRocEnD26nfRc6SdS7sJ8mm/XK+x83lG3bZPteKby87FEi65M1gnOoeAspP6ieR81D3DSaaNMvlFIbgk/Cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHk354wF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460e6d331d6so13587481cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729877798; x=1730482598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0az00lxDNAIqegju9SoC5ZxH1jcOnDSrVBFR0VhF8yY=;
        b=ZHk354wFrcprAV8TnjnUbFH/4AdD5cT7rdgzhxnHp4SzK5lpgxQxbWH5j3kZsBNbx3
         YfFQ6OINQp/QFkAzrs9VJ18YWw3v+1U1sGiujOtAf+fNtN4n65gOKIkoJuPgngAe+5yO
         Shakgn08swWr+RZQRxbH3KIHnt8HnL2w/+7dFaEWXWpeB7rNf0cHqhN/1mD0msB+aJ//
         1N03DOn6h5CHhKZNhx3ek+LhvuGYdP2j/LWPx0uHiKRs84yznMKPzzgu8sUceU+NmtwD
         sf/Fe2I/LlDVla46wEHjM/fa5R+xM5aErVeK2pLL/gVK8CMb56GQEbtT09AuaMAqv3lz
         P8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877798; x=1730482598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0az00lxDNAIqegju9SoC5ZxH1jcOnDSrVBFR0VhF8yY=;
        b=MHwhZcFcHqpP/z+DO8YPzzdwSV+ffwXYiZW0qlmRZhy4hA8F3TYLKxzi2NyQy6wqxh
         6/5KQyUtgtOnjzO6Vte+Mp3/zcrcoUb51lvu8aWEtmQy99dK4JxOyc414brNSO7KGpbq
         uL/ipuYBLx2ftWTKZGqL9l/VWikBfmHkGr8+2IHSNuvivrYzixcDrinjl+g2dQTdg2J9
         BD4OghKrtrkGEGR9p58NO0RVMnSffw/4rp88B+SloJTEt39Oh9ra+yagYsXajIdioEWs
         Iou8WF8rAwxLAGXhIzuOL+Vy4dFy3pQA9zNQWKK21K8l05fm/YhxhGKRB6ziPDeZv5q5
         0MTA==
X-Forwarded-Encrypted: i=1; AJvYcCUPEGBJl+3zm2B4Pabjxw/QlkR4lKA4CEF/vriuQbyxACT+1m6KjhnqKaRwzz8MbMTiaICPaxM+sjQtZnPq@vger.kernel.org
X-Gm-Message-State: AOJu0YwG04T50iKe7nyxUldIbigTcydZ0dCG5An1SSO3ABlwydReUdRJ
	7uoEv+UkGw+prnRYCiT4I9B7wSwXMy9Ac6U9NqiFKdc/yrhO0A4MVNLbhUVOMPg3bdXfpJqpv6M
	Ov+YC7iJV62yZ7N9jR6F+lao48Z4=
X-Google-Smtp-Source: AGHT+IGgUJTGTvWVjwfxjsQTiCen6/FgeIoYvhFOGlz59d6rzI1orPrnmd07K1Y0ysC62zVCBCgAPY/JQNLDfRf4TWE=
X-Received: by 2002:a05:622a:19a6:b0:45f:898:5c65 with SMTP id
 d75a77b69052e-4613c0541c1mr541531cf.31.1729877797713; Fri, 25 Oct 2024
 10:36:37 -0700 (PDT)
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
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com> <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
In-Reply-To: <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 25 Oct 2024 10:36:26 -0700
Message-ID: <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 6:38=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 10/25/24 12:54 AM, Joanne Koong wrote:
> > On Mon, Oct 21, 2024 at 2:05=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >> On Mon, Oct 21, 2024 at 3:15=E2=80=AFAM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> >>>
> >>> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev> w=
rote:
> >>>
> >>>> I feel like this is too much restrictive and I am still not sure why
> >>>> blocking on fuse folios served by non-privileges fuse server is wors=
e
> >>>> than blocking on folios served from the network.
> >>>
> >>> Might be.  But historically fuse had this behavior and I'd be very
> >>> reluctant to change that unconditionally.
> >>>
> >>> With a systemwide maximal timeout for fuse requests it might make
> >>> sense to allow sync(2), etc. to wait for fuse writeback.
> >>>
> >>> Without a timeout allowing fuse servers to block sync(2) indefinitely
> >>> seems rather risky.
> >>
> >> Could we skip waiting on writeback in sync(2) if it's a fuse folio?
> >> That seems in line with the sync(2) documentation Jingbo referenced
> >> earlier where it states "The writing, although scheduled, is not
> >> necessarily complete upon return from sync()."
> >> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html
> >>
> >
> > So I think the answer to this is "no" for Linux. What the Linux man
> > page for sync(2) says:
> >
> > "According to the standard specification (e.g., POSIX.1-2001), sync()
> > schedules the writes, but may return before the actual writing is
> > done.  However Linux waits for I/O completions, and thus sync() or
> > syncfs() provide the same guarantees as fsync() called on every file
> > in the system or filesystem respectively." [1]
>
> Actually as for FUSE, IIUC the writeback is not guaranteed to be
> completed when sync(2) returns since the temp page mechanism.  When
> sync(2) returns, PG_writeback is indeed cleared for all original pages
> (in the address_space), while the real writeback work (initiated from
> temp page) may be still in progress.
>

That's a great point. It seems like we can just skip waiting on
writeback to finish for fuse folios in sync(2) altogether then. I'll
look into what's the best way to do this.

> I think this is also what Miklos means in:
> https://lore.kernel.org/all/CAJfpegsJKD4YT5R5qfXXE=3DhyqKvhpTRbD4m1wsYNbG=
B6k4rC2A@mail.gmail.com/
>
> Though we need special handling for AS_NO_WRITEBACK_RECLAIM marked pages
> in sync(2) codepath similar to what we have done for the direct reclaim
> in patch 1.
>
>
> >
> > Regardless of the compaction / page migration issue then, this
> > blocking sync(2) is a dealbreaker.
>
> I really should have figureg out the compaction / page migration
> mechanism and the potential impact to FUSE when we dropping the temp
> page.  Just too busy to take some time on this though.....

Same here, I need to look some more into the compaction / page
migration paths. I'm planning to do this early next week and will
report back with what I find.


Thanks,
Joanne
>
>
> --
> Thanks,
> Jingbo

