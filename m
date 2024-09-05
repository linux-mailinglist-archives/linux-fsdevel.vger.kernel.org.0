Return-Path: <linux-fsdevel+bounces-28798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074896E5E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 00:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFA3286ED0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 22:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE831B12DB;
	Thu,  5 Sep 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhkGPnu9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026601AB514
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576432; cv=none; b=iLBITGdeSDf28KMdb579ZFmQbU3OFGWT8/Y6kngJkdcOjCBnNjzDbnXqoCgBcAXWsd8U8r76fDnvmDQynzpjh33tiLDnGTEDADO4g7KvMy75Yp0MQ+3sOhpxH1aclNgdourB9od+ebPLs/AS8a8ZDmoyE0O9BA3ixlek0vtiLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576432; c=relaxed/simple;
	bh=fOgigyhe3pHXTLHKDr+CRs0u7fJXhtx6fhiRZWqspIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwGmTVBzVbK1HxKaUrh0nqkgJ4In/Jap8GVH3GbwR6Z5mQmGZIybEtm09vxtS/YO4S4vjWWvt+9NM2pWBnu5IE5nx3w30clmbllEU8Lt5cb5Eye95LAHc9tSCia9L+N4rvrPt29HMBUOzNyZVhcfZBSzS718vTQGCnq0Ve+L790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhkGPnu9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4567edb7dceso8553481cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2024 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725576430; x=1726181230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOgigyhe3pHXTLHKDr+CRs0u7fJXhtx6fhiRZWqspIs=;
        b=WhkGPnu9Vwsdz5qGAV/HVyMvHULhs4jNDaKzIPMuNxLunVgs57zrqMTWuz8V54Z6CO
         Ga7DnZ7BMqkvjRNtCq544/+RqMgdAzaPiacmUaj0OBJNmCPof7znOxmImmnsH9nDbO62
         SYDfxxUtPNvD1m8+NFZ4uVjvaLIpFNI3kr4J+I/cxfcmL/DlL6vp0ECHJS1QPdrtC0Vt
         RwG/qbwxOgT2WvwvCnK7Ru7T6um9qbLoYfUhwgaSdyHD1bE6C68Ca11P4SaUdjovt1Cy
         53zsa/Yt/SdCqyleLJ+z1LXA27/Q5UI7yNWLw8ZXKQDKaevLI9+drVwmJyEyekp1L3lG
         fevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725576430; x=1726181230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOgigyhe3pHXTLHKDr+CRs0u7fJXhtx6fhiRZWqspIs=;
        b=ravSQFtlTTSwNIIRU8gDLwX5xUur/51KvuSZPZDNjKw7OSpBp6OHYZOwJWhTNGl1gY
         mDZ8JnkrxCjJ+5DyC3PYcy6KrryCjsKhdalZ58hD67wzyKKDbd7v/6dAu3x7HcHO3zpv
         y2DaCoaA4kCFdmELEQuEY4TnEV00lBcg24m+GBbC5g5O+Z97vVb0/1fFFJPbKQp8vE/D
         cGb7EX6KF5mRXrs1Sh76r4CafHNuVOVhFcs3eTNx+7BjZ8tvb4K/whYIWlN9MBi/YmNs
         oe5lIwha1se+Wya4tv7t2EC74/HgYZ59c1K0GuROdDe1JfT7gMlpMfTQY8TA/Pd91sgk
         Cr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcz5ewcLrTBW1otYjAsRHAPgZ2hdVycrYzgo+mgKeQffkewM8ToUH5tU1IGWkepn8YejA6yO7YsqSJZomU@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwOehuCB721EbMq2HNvjxCuEaHeBPr3nvrjym+v67SBvkhKgh
	79ZW+WUbcpPD33EhJzMLdnFQRWK0lagiy96G/PLZrW3qUqPW7saRlPyqFX7SP2afeGbQIfqxivO
	npsmlucW2SU2LvbtlwJ8A377TdsoOcJrl
X-Google-Smtp-Source: AGHT+IEgWKvE43JnLH2yIS1rx8GYpJm+oXatOzjS2p1p/a+AIRJQi5Z5ILESag2rOaH4UpXNlWfyqrJWCTVTlNXtBvU=
X-Received: by 2002:ac8:5854:0:b0:456:959d:ec39 with SMTP id
 d75a77b69052e-4580c760851mr7408061cf.41.1725576429819; Thu, 05 Sep 2024
 15:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905174541.392785-1-joannelkoong@gmail.com>
 <27b6ad2f-9a43-4938-9f0d-2d11581e8be7@fastmail.fm> <CAJnrk1Z6R3cOMeVTaE0L1Nn4WO2K-4d3E0PY+-s_iege0PaEVA@mail.gmail.com>
In-Reply-To: <CAJnrk1Z6R3cOMeVTaE0L1Nn4WO2K-4d3E0PY+-s_iege0PaEVA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Sep 2024 15:46:58 -0700
Message-ID: <CAJnrk1YFEP_X5pcSU5uAA6+Q7uPTDDS0uH2kKz_xpYmcHi8D7g@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	sweettea-kernel@dorminy.me, kernel-team@meta.com, laoji.jx@alibaba-inc.com, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 3:32=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Thu, Sep 5, 2024 at 2:16=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > Hi Joanne,
> >
> > On 9/5/24 19:45, Joanne Koong wrote:
> > > Introduce the capability to dynamically configure the fuse max pages
> > > limit (formerly #defined as FUSE_MAX_MAX_PAGES) through a sysctl.
> > > This enhancement allows system administrators to adjust the value
> > > based on system-specific requirements.
> > >
> > > This removes the previous static limit of 256 max pages, which limits
> > > the max write size of a request to 1 MiB (on 4096 pagesize systems).
> > > Having the ability to up the max write size beyond 1 MiB allows for t=
he
> > > perf improvements detailed in this thread [1].
> >
> > the change itself looks good to me, but have you seen this discussion h=
ere?
> >
> > https://lore.kernel.org/lkml/CAJfpegs10SdtzNXJfj3=3DvxoAZMhksT5A1u5W5L6=
nKL-P2UOuLQ@mail.gmail.com/T/
> >
> >
> > Miklos is basically worried about page pinning and accounting for that
> > for unprivileged user processes.
> >
>
> Thanks for the link to the previous discussion, Bernd. I'll cc Xu and
> Jingbo, who started that thread, to this email.
>
> I'm curious whether this sysctl approach might mitigate those worries
> here since modifying the sysctl value will require admin privileges to
> explicitly opt into this. I liked Sweet Tea's comment
>
> "Perhaps, in analogy to soft and hard limits on pipe size,
> FUSE_MAX_MAX_PAGES could be increased and treated as the maximum
> possible hard limit for max_write; and the default hard limit could stay
> at 1M, thereby allowing folks to opt into the new behavior if they care
> about the performance more than the memory?"
>
> where something like this could let admins choose what aspects they'd
> like to optimize for.
>
> My understanding of how bigger write buffers affects pinning is that
> each chunk of the write will pin a higher number of contiguous pages
> at one time (but overall for the duration of the write request, the
> number for total pages that get pinned are the same). My understanding
> is that the pages only get pinned when we do the copying to the fuse
> server's buffer (and is not pinned while the server is servicing the

Just realized my wording of "when we do the copying to the fuse
server's buffer" can be interpreted in different ways. By this I mean
from when we do the "fuse_pages_alloc()" call in fuse_perform_write()
to when we finish fuse_send_write_pages().

> request).
>
>
> Thanks,
> Joanne
>
> >
> > Thanks,
> > Bernd
> >
> >

