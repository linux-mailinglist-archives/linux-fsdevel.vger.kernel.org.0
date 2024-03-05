Return-Path: <linux-fsdevel+bounces-13625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14189872169
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FDE1F226F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9976086659;
	Tue,  5 Mar 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Un4AFB2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F378662A
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648803; cv=none; b=qolCNtvXk5RYGvoCOwcTJNAs5CzAUkuhY3dM3hdzPXqfjDrGoi3bOQJvB03bjVU4EGvQROHRyDX3rcavV3vXmgoTxrYA8ypHR2gkmDChWZvsumr6Rb58Rg7gUES+7Cfn0XiegVHIk8elE8/IonZ/VQ8XcQre4ekGeB6Sl4YY8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648803; c=relaxed/simple;
	bh=ruqqX5qO4PFwwdwYGfmvAVa1H9eyuPYZRlafUStwf6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bONIaTjc00XA14s86UpIeTQpoRF0DPmPen76KgLPIQ1xxjNRuCE7vbOPCl0ep2MHGa0T73/tHDi5n5vvKOlHL3grGGIIrqy+uLNnMZgpjQdaGlJyn8hIJFzztWKfen2ExOGheDml8F3GMg1no813f1vyXbJU+1rzIP566ng6r/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Un4AFB2Y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so112099966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709648798; x=1710253598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SNRQOholZ1nb17dk+3mdK/tk6Wz5FXAQ7vxevC3NaZU=;
        b=Un4AFB2YamB5LxK/Mbgglba/iZkVlri1AucJezXHouNw9PV4EIILwQrnFibLF85hPj
         2ut8XJc1A+SDJJIQIyMPqAI22QOV3WmWv/1Y9f78zwsnz9eguiKkyp82lR+5isbkAeFO
         d8bOPYPh54MSVi/kdZ4OgWFAaNXBLFAp7qGLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648798; x=1710253598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNRQOholZ1nb17dk+3mdK/tk6Wz5FXAQ7vxevC3NaZU=;
        b=YQnj+rjPxac7Yqv125gAEXTYCLL62QjwUOE+UjpDBmk3WyjbEoG5MS59ZzujOw2810
         Sx3zuuniG7U8e4BLpaxZQ/O5/2w156SGAO6YxtBLKHCAUkvs0Ma4yEoL0CVDumBrhkrY
         Ggtnw8aiep6B0U2S5txhdzVgXbsmzfxf5/805atyzdzVAMvX4IbtuYQxyeWnkP66xRCB
         sSCHMrLiDnhU//bgY6lQWDdjzqiU+E7WEgKqFzqK4FoC82xs7r3qXTF4dx8dKcIWpvAd
         PSfXvsyW1sfzOBNUgub+wefQDHd+Kc9YtHyhVSz9ll89pV60ktFeGw9Hm+ckGafNBtwX
         QGCQ==
X-Gm-Message-State: AOJu0YzbFyB0uNPX6N7XlDNQ2zXYdietbzko5KPdQKRtb4ZLZY+H3HLQ
	BQdkAEduOdtNY9BvJOTikDMpFs29/r+IBVIR79QE8CikQfBhRStsl9DbRKcJctBklQC5CNZJG3X
	ytcQyjzvfnsfI+du04hwP741Du3+XUzp9fzTh9Q==
X-Google-Smtp-Source: AGHT+IHuyqTEJgnyqPan4wheohLar4swLZ64UBZctUdkezgVTSN0RNi2bvORob6BA4/dnKSg6dpA/SZJMZ8bnYgEkyI=
X-Received: by 2002:a17:906:688:b0:a45:16ec:66ef with SMTP id
 u8-20020a170906068800b00a4516ec66efmr4588337ejb.77.1709648798124; Tue, 05 Mar
 2024 06:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
 <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
 <6e6bef3d-dd26-45ce-bc4a-c04a960dfb9c@linux.alibaba.com> <b4e6b930-ed06-4e0d-b17d-61d05381ac92@linux.alibaba.com>
 <27b34186-bc7c-4f3c-8818-ee73eb3f82ba@linux.alibaba.com>
In-Reply-To: <27b34186-bc7c-4f3c-8818-ee73eb3f82ba@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:26:26 +0100
Message-ID: <CAJfpegvLUrqkCkVc=yTXcjZyNNQEG4Z4c6TONEZHGGmjiQ5X2g@mail.gmail.com>
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangjiachen.jaycee@bytedance.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 05:00, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> Hi Miklos,
>
> On 1/26/24 2:29 PM, Jingbo Xu wrote:
> >
> >
> > On 1/24/24 8:47 PM, Jingbo Xu wrote:
> >>
> >>
> >> On 1/24/24 8:23 PM, Miklos Szeredi wrote:
> >>> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> >>>>
> >>>> From: Xu Ji <laoji.jx@alibaba-inc.com>
> >>>>
> >>>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
> >>>> single request is increased.
> >>>
> >>> The only worry is about where this memory is getting accounted to.
> >>> This needs to be thought through, since the we are increasing the
> >>> possible memory that an unprivileged user is allowed to pin.
> >
> > Apart from the request size, the maximum number of background requests,
> > i.e. max_background (12 by default, and configurable by the fuse
> > daemon), also limits the size of the memory that an unprivileged user
> > can pin.  But yes, it indeed increases the number proportionally by
> > increasing the maximum request size.
> >
> >
> >>
> >>>
> >>>
> >>>
> >>>>
> >>>> This optimizes the write performance especially when the optimal IO size
> >>>> of the backend store at the fuse daemon side is greater than the original
> >>>> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
> >>>> 4096 PAGE_SIZE).
> >>>>
> >>>> Be noted that this only increases the upper limit of the maximum request
> >>>> size, while the real maximum request size relies on the FUSE_INIT
> >>>> negotiation with the fuse daemon.
> >>>>
> >>>> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
> >>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> >>>> ---
> >>>> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
> >>>> Bytedance floks seems to had increased the maximum request size to 8M
> >>>> and saw a ~20% performance boost.
> >>>
> >>> The 20% is against the 256 pages, I guess.
> >>
> >> Yeah I guess so.
> >>
> >>
> >>> It would be interesting to
> >>> see the how the number of pages per request affects performance and
> >>> why.
> >>
> >> To be honest, I'm not sure the root cause of the performance boost in
> >> bytedance's case.
> >>
> >> While in our internal use scenario, the optimal IO size of the backend
> >> store at the fuse server side is, e.g. 4MB, and thus if the maximum
> >> throughput can not be achieved with current 256 pages per request. IOW
> >> the backend store, e.g. a distributed parallel filesystem, get optimal
> >> performance when the data is aligned at 4MB boundary.  I can ask my folk
> >> who implements the fuse server to give more background info and the
> >> exact performance statistics.
> >
> > Here are more details about our internal use case:
> >
> > We have a fuse server used in our internal cloud scenarios, while the
> > backend store is actually a distributed filesystem.  That is, the fuse
> > server actually plays as the client of the remote distributed
> > filesystem.  The fuse server forwards the fuse requests to the remote
> > backing store through network, while the remote distributed filesystem
> > handles the IO requests, e.g. process the data from/to the persistent store.
> >
> > Then it comes the details of the remote distributed filesystem when it
> > process the requested data with the persistent store.
> >
> > [1] The remote distributed filesystem uses, e.g. a 8+3 mode, EC
> > (ErasureCode), where each fixed sized user data is split and stored as 8
> > data blocks plus 3 extra parity blocks. For example, with 512 bytes
> > block size, for each 4MB user data, it's split and stored as 8 (512
> > bytes) data blocks with 3 (512 bytes) parity blocks.
> >
> > It also utilize the stripe technology to boost the performance, for
> > example, there are 8 data disks and 3 parity disks in the above 8+3 mode
> > example, in which each stripe consists of 8 data blocks and 3 parity
> > blocks.
> >
> > [2] To avoid data corruption on power off, the remote distributed
> > filesystem commit a O_SYNC write right away once a write (fuse) request
> > received.  Since the EC described above, when the write fuse request is
> > not aligned on 4MB (the stripe size) boundary, say it's 1MB in size, the
> > other 3MB is read from the persistent store first, then compute the
> > extra 3 parity blocks with the complete 4MB stripe, and finally write
> > the 8 data blocks and 3 parity blocks down.
> >
> >
> > Thus the write amplification is un-neglectable and is the performance
> > bottleneck when the fuse request size is less than the stripe size.
> >
> > Here are some simple performance statistics with varying request size.
> > With 4MB stripe size, there's ~3x bandwidth improvement when the maximum
> > request size is increased from 256KB to 3.9MB, and another ~20%
> > improvement when the request size is increased to 4MB from 3.9MB.

I sort of understand the issue, although my guess is that this could
be worked around in the client by coalescing writes.  This could be
done by adding a small delay before sending a write request off to the
network.

Would that work in your case?

Thanks,
Miklos

