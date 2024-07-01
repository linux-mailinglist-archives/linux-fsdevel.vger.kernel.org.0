Return-Path: <linux-fsdevel+bounces-22900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF3B91EB57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 01:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A7F1F21A32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 23:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C1B172BAC;
	Mon,  1 Jul 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc8BmwFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2FB80026
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719876498; cv=none; b=oh1OX01imo1PIPVUi8rOT9MJ16AfFCtiYIqZRwGZ8fZ1Kv2lB6wNNhvvm0qyzkPwRtr33u9d+z7XEKI3g6MzjKtapXpKPx9/lYPd0NR9kKWqrqQYrg1Jq8m7knkiSQXRE+lBaNkH+jWF/X9vs7JgtpUglYGphv29mc3pHO8Avfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719876498; c=relaxed/simple;
	bh=vc6ge0OdC9sdbmTEydPwoBN/7jjnKyiBPl88rtPq8AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXr949Apnc/HQFkU/NXqImGgoTErp9pqimgFnEMhgR4ZalAQbbGvckg0N/medp1pWhQKemIf+mWED7obU5cQOUPXhPsOJZuHhmRrrabkISlwUGH+ppYbFLY+YpbFTxaFPSx+U6tHmcOuGVhYS0JIqsHOa4BxQSf4bc7D4MhOygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc8BmwFy; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e03618fc78bso3172740276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719876496; x=1720481296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUC7LG1cB6P1gWAbeaN5TPq8w/gGH9UNcIvVmFjNZkc=;
        b=hc8BmwFyCThVMxZpAqwd/94hAlANxd2XVRi/oqjc75uatFWDdbx6aT3jmT6l9qzoX/
         /kxa5l11DV9UhHi7eG6u5fU5uGszuui7SDoFyJxbbjGJBpHnsuhWVf3TLVZDCxexRs9B
         fIfoFgp01+LeeO1CDPAkMm4+mCiKPn0t05FhxgVmdaRz5xTsrAXAGy08XwQTmVuamXbi
         cb/TVPwNAHCfZpxEyMKeRRvsg7noWYpQSCQJQqR9cI1D95ENU9kM2GnRtUCFEJKSs5zZ
         4tztPZXdMoIZAcXzEDgF8UqOMfZb0/OHmk81ExUSQtGHzHOJfJvU2TzBQgYLElJate2m
         jWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719876496; x=1720481296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUC7LG1cB6P1gWAbeaN5TPq8w/gGH9UNcIvVmFjNZkc=;
        b=lZSSm3kzEZDEbHpNDmf2uRxz96/hUV12hPl0MKP5JshetXU5a688zpHM4mMfaD7ie4
         gjJGX7hmeqflApkY2yoJCm0JcO99ga3mAroqUAlKqw2rbHjVHWYKB6tsbjz9H6oHwXHh
         j4+ndknmo0zB+1Fm9XVdPHjejZbROEyF9tohrBKO/BJjFnHIzAJMkOQPPhIcicxPaOEH
         cHFlq+0CQb2k48tEKL9e64rsZOpyYILGKaTyS7NFxJfHu/4GlqI4Tvx3xcRV3QsobWVp
         oMjEV8D/dsK1L1MLVPtEltrY5ahACGVWUUcfhMQZbjmRxb3BBvkN5jOwwN/UV8nYIq0r
         ZymQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgn4bsFgec03Fg/aQnJYH7NpOl71ElH6uH5iJKVp6h/NsfipZqwE/cCyg8TnHGd1xyPY+fR77RePT+6Ys+TjLto2Jzs/MtULeHGPRbtA==
X-Gm-Message-State: AOJu0Ywh1Ig/6JFeshggVKd5oYZJ/Z6SZFG0nHPOwgSWkmvBZzOsBtVQ
	J4lSXOjcbFfnJ+aCeH0huLheUxFaOhMBpHbECS78gZ5kVACu20S3la4anptgKIUHWBdg9kMe6uf
	iBo4dU44H4pVRHlFAEWq5vZtyCr0=
X-Google-Smtp-Source: AGHT+IHwJ1KDeQ989DmsXc9Mbex9E6o2A71hfYB8DUpJnS0ntiOfG2FFdzf7vJMyEpqgJrrvZegf4mgDx7tqpFBFqYk=
X-Received: by 2002:a5b:f09:0:b0:e02:c70d:d292 with SMTP id
 3f1490d57ef6-e036eb6e1b9mr7372987276.33.1719876496373; Mon, 01 Jul 2024
 16:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628001355.243805-1-joannelkoong@gmail.com>
 <20240628180305.GA413049@perftesting> <CAJnrk1YAt-dRUMYdS8TyyiXYG32nNBc_gTE0FeP0=XCZF3-pQA@mail.gmail.com>
 <8142b5da-db91-4f3e-ac63-6a476bc4f413@dorminy.me>
In-Reply-To: <8142b5da-db91-4f3e-ac63-6a476bc4f413@dorminy.me>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 1 Jul 2024 16:28:05 -0700
Message-ID: <CAJnrk1aaWdKU4Bz2dE5yxvK0bTwSKD3CXn1xE0FACLQt-TAWiA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Enable dynamic configuration of FUSE_MAX_MAX_PAGES
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Josef Bacik <josef@toxicpanda.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	osandov@osandov.com, laoji.jx@alibaba-inc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 12:15=E2=80=AFPM Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
> On 7/1/24 12:48 PM, Joanne Koong wrote:
> > On Fri, Jun 28, 2024 at 11:03=E2=80=AFAM Josef Bacik <josef@toxicpanda.=
com> wrote:
> >>
> >> On Thu, Jun 27, 2024 at 05:13:55PM -0700, Joanne Koong wrote:
> >>> Introduce the capability to dynamically configure the FUSE_MAX_MAX_PA=
GES
> >>> limit through a sysctl. This enhancement allows system administrators=
 to
> >>> adjust the value based on system-specific requirements.
> >>>
> >>> This removes the previous static limit of 256 max pages, which limits
> >>> the max write size of a request to 1 MiB (on 4096 pagesize systems).
> >>> Having the ability to up the max write size beyond 1 MiB allows for t=
he
> >>> perf improvements detailed in this thread [1].
> >>>
> >>> $ sysctl -a | grep fuse_max_max_pages
> >>> fs.fuse.fuse_max_max_pages =3D 256
> >>>
> >>> $ sysctl -n fs.fuse.fuse_max_max_pages
> >>> 256
> >>>
> >>> $ echo 1024 | sudo tee /proc/sys/fs/fuse/fuse_max_max_pages
> >>> 1024
> >>>
> >>> $ sysctl -n fs.fuse.fuse_max_max_pages
> >>> 1024
> >>>
> >>> [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jeff=
lexu@linux.alibaba.com/T/#u
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>
> >> Overall the change is great, and I see why you named it the way you di=
d, but I
> >> think may be 'fuse_max_pages_limit' may be a better name?  The origina=
l constant
> >> name wasn't great, but it was fine in its context.  I think having it =
as an
> >> interface we should name it something less silly.
> >
> > 'fuse_max_pages_limit' sounds great to me. I'll submit v2 with this ren=
ame.
> >
>
> Whatever-it's-called might make sense to be in bytes, since max_read,
> max_write are the values visible to a userspace fuse server and are in
> bytes.

I like this in theory but in practice, I think this adds more
logic/complexity in the kernel than it's worth, since we will need to
keep track of and enforce non-page-size-aligned values that may be set
as the limit. For example, if the sysctl value gets set to 1048577
bytes (eg 1 MiB + 1 byte) and the user sets "max_write" to 1048578
bytes in the init callback, we need to make sure we cap writes to
exactly 1048577 bytes, which means we'll need to keep track of this in
the kernel at the byte granularity. Additionally, there are some
places where fc->max_pages is used (eg for fuse_readahead) where it
doesn't quite make sense to have this limit be a non-page-size-aligned
number.

My personal vote is to keep it simple with page size granularity, but
I'm happy to talk more about this if you or anyone else feels
strongly.

>
> Additionally, the sysctl should probably disallow values at or above
> 1<<16 pages -- fuse_init_out expects that max_pages fits in a u16, and
> there are a couple of places where fc->max_pages << PAGE_SHIFT is
> expected to fit in a u32. fc->max_pages is constrained by max_max_pages
> at present so this is true but would not be true if max_max_pages is
> only constrained by being a uint.

Good point! I missed that fc->max_pages will be bounded anyways by the
uint16_t "fuse_init_out->max_pages", so setting larger values than u16
won't do anything. I'll make this change in v2.
(For the fc->max_pages << PAGE_SHIFT being expected to fit in a u32, I
only see that for fuse_verify_ioctl_iov() but that function looks like
it should be defining "max" to size_t instead of a u32 and then
casting to size_t? Not relevant to this conversation since I'll be
changing it to u16 but I was just curious)

Thanks for taking a look!

