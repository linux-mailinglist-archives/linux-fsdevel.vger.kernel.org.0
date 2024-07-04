Return-Path: <linux-fsdevel+bounces-23140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215CB9279A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56921F258A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D591B1202;
	Thu,  4 Jul 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LS1RL58Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B61B011C
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105851; cv=none; b=cAqRHso9yJEQnUKzVjKdHZY8h/+AeyHyNTnhrs2rdPv5/pS7rQDbMiiHIJfBK+xvnW2+DlLaXWg6OBST0zNB6UKHtE2fZOfAhaeN7Sdo5pZu62il1m/bULk9tB+ZpFJs6rEGiUX+jMv0R/Y3LKlQbWfzQVL4dgab4HH0LoLOU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105851; c=relaxed/simple;
	bh=kdfyLzqOFD0AEPMOk2FmlI3kV12dOyTSgPH6bRSusiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+MUwVKKtHUxAqUNq732ARMamTeK3au1Ps1/EDsEKnlofrAhDm5FgLIXe0KEKY1h7CGWea0aGh96d5AjMPkr3ZWHWIEdtuPmAXMrGDx4FduiSBcqFrvlF4YIoT93WsY5bOpeqS6t6eYdfM6tBpYRD4oosfVKusb4a64Z7kmGjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LS1RL58Y; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44633a67e52so4715651cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720105849; x=1720710649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q4AXpkrLxA4hGQYo4pOrj0QIXDZg0lnksvq2F51GXtQ=;
        b=LS1RL58YxDwYq4+pGTRfs9r4joNbmS9/QaM8NpTC0SXcHSuI3Vus/UFmfXOPdO9KCi
         5H2WcKfH30zXC/Y35JaapkLJONKAWn7125Yzs1lh7U91t4WaoYcbHYMdIWYevy/9FcLa
         nc/TCCJPuA6LIM15VG09Wsa/i1kUq6U4s6Lh/2ltYNWRAqvvH62VV7DIFELqCoM+0vz5
         L5tssWssRerz7rL5kPiyPiMX5bRQzsFnxDjlOVFYGG7wLhA5MFkWovkKz9+OUm1JLJQo
         e+Mt1YHCTwRf782RAorSDebgC7vlERbNUjeOx1s2jtCY/22Fk84HKOF9wEnZT1ewAnA4
         h1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105849; x=1720710649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4AXpkrLxA4hGQYo4pOrj0QIXDZg0lnksvq2F51GXtQ=;
        b=T+//nQQ7miquRuoQe2MIfWRsCuH+Lv2yO5WwU+cMQcvnBONTRDGUbOI+Cilm6+hxoT
         TquooPNOYZs/nse7Ry2nrMIqCdT3+fqOu7i3bcy9QdAhhSxorMbm6aow196TgHmd4nds
         7Gc6oTt+UQ8gWyQ89q5AE/FxgiLCG5k2jWZSIsVzNIqX/p6ib/NU6BCs+qw+8wzKbwTG
         OklBkj7tEVbQeNvUBhFwllUP/v90ZpnDcvrp/Fbg3A70qyqZTnchUW3GRSzU1CAkTtAU
         q8qnurVv5xrOW0jBvy9x84b//j7bUUdKd9VL7h4WJFjcUCjAeOfi0hq12BF+YenZ6Mey
         CLjg==
X-Forwarded-Encrypted: i=1; AJvYcCX0MTO2zL843cGZ56zljSMCbJ3eM5iZ4mnd2NWd54T1hxc3zUVOb6qYdl1b8ezDUvs1E3AQeoJf1OSrWRPRC/T/3JszAQPGgtrZTq9DuQ==
X-Gm-Message-State: AOJu0YxWniYDOS5wsLFfBgzgaxlylnYDZgUiXhvzuXca6RXDP6UbpWf7
	kuLyaCdLLM2cpY+kajUTPYAJPwXzidknSsH19HC1Xe7R4nLnp1gAE2kzY6j0Tds=
X-Google-Smtp-Source: AGHT+IHGA2WZeJO8NS74jrt29vjS73nXwXegeiaHYO9TgrUCrINBCe8YAxGj3JUmkglAHnM8mhrRNg==
X-Received: by 2002:ac8:5f13:0:b0:445:397:e629 with SMTP id d75a77b69052e-447cbf8e936mr23279981cf.45.1720105848753;
        Thu, 04 Jul 2024 08:10:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514cad7esm60682511cf.93.2024.07.04.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:10:48 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:10:47 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fuse: Allow to align reads/writes
Message-ID: <20240704151047.GB865828@perftesting>
References: <20240702163108.616342-1-bschubert@ddn.com>
 <20240703151549.GC734942@perftesting>
 <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm>
 <20240703173017.GB736953@perftesting>
 <CAJnrk1bYf85ipt2Hf1id-OBOzaASOeegOxnn3vGtUxYHNp3xHg@mail.gmail.com>
 <03aba951-1cab-4a40-a980-6ac3d52b2c91@ddn.com>
 <CAJnrk1a2_qDkEYSCCSOf-jpumLZv5neAgSwW6XGA__eTjBfBCw@mail.gmail.com>
 <65af4ae5-b8c8-4145-af2d-f722e50d68de@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65af4ae5-b8c8-4145-af2d-f722e50d68de@fastmail.fm>

On Wed, Jul 03, 2024 at 10:44:28PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/3/24 22:28, Joanne Koong wrote:
> > On Wed, Jul 3, 2024 at 11:08 AM Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> On 7/3/24 19:49, Joanne Koong wrote:
> >>> On Wed, Jul 3, 2024 at 10:30 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >>>>
> >>>> On Wed, Jul 03, 2024 at 05:58:20PM +0200, Bernd Schubert wrote:
> >>>>>
> >>>>>
> >>>>> On 7/3/24 17:15, Josef Bacik wrote:
> >>>>>> On Tue, Jul 02, 2024 at 06:31:08PM +0200, Bernd Schubert wrote:
> >>>>>>> Read/writes IOs should be page aligned as fuse server
> >>>>>>> might need to copy data to another buffer otherwise in
> >>>>>>> order to fulfill network or device storage requirements.
> >>>>>>>
> >>>>>>> Simple reproducer is with libfuse, example/passthrough*
> >>>>>>> and opening a file with O_DIRECT - without this change
> >>>>>>> writing to that file failed with -EINVAL if the underlying
> >>>>>>> file system was using ext4 (for passthrough_hp the
> >>>>>>> 'passthrough' feature has to be disabled).
> >>>>>>>
> >>>>>>> Given this needs server side changes as new feature flag is
> >>>>>>> introduced.
> >>>>>>>
> >>>>>>> Disadvantage of aligned writes is that server side needs
> >>>>>>> needs another splice syscall (when splice is used) to seek
> >>>>>>> over the unaligned area - i.e. syscall and memory copy overhead.
> >>>>>>>
> >>>>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >>>>>>>
> >>>>>>> ---
> >>>>>>> From implementation point of view 'struct fuse_in_arg' /
> >>>>>>> 'struct fuse_arg' gets another parameter 'align_size', which has to
> >>>>>>> be set by fuse_write_args_fill. For all other fuse operations this
> >>>>>>> parameter has to be 0, which is guranteed by the existing
> >>>>>>> initialization via FUSE_ARGS and C99 style
> >>>>>>> initialization { .size = 0, .value = NULL }, i.e. other members are
> >>>>>>> zero.
> >>>>>>> Another choice would have been to extend fuse_write_in to
> >>>>>>> PAGE_SIZE - sizeof(fuse_in_header), but then would be an
> >>>>>>> arch/PAGE_SIZE depending struct size and would also require
> >>>>>>> lots of stack usage.
> >>>>>>
> >>>>>> Can I see the libfuse side of this?  I'm confused why we need the align_size at
> >>>>>> all?  Is it enough to just say that this connection is aligned, negotiate what
> >>>>>> the alignment is up front, and then avoid sending it along on every write?
> >>>>>
> >>>>> Sure, I had forgotten to post it
> >>>>> https://github.com/bsbernd/libfuse/commit/89049d066efade047a72bcd1af8ad68061b11e7c
> >>>>>
> >>>>> We could also just act on fc->align_writes / FUSE_ALIGN_WRITES and always use
> >>>>> sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) in libfuse and would
> >>>>> avoid to send it inside of fuse_write_in. We still need to add it to struct fuse_in_arg,
> >>>>> unless you want to check the request type within fuse_copy_args().
> >>>>
> >>>> I think I like this approach better, at the very least it allows us to use the
> >>>> padding for other silly things in the future.
> >>>>
> >>>
> >>> This approach seems cleaner to me as well.
> >>> I also like the idea of having callers pass in whether alignment
> >>> should be done or not to fuse_copy_args() instead of adding
> >>> "align_writes" to struct fuse_in_arg.
> >>
> >> There is no caller for FUSE_WRITE for fuse_copy_args(), but it is called
> >> from fuse_dev_do_read for all request types. I'm going to add in request
> >> parsing within fuse_copy_args, I can't decide myself which of both
> >> versions I like less.
> > 
> > Sorry I should have clarified better :) By callers, I meant callers to
> > fuse_copy_args(). I'm still getting up to speed with the fuse code but
> > it looks like it gets called by both fuse_dev_do_read and
> > fuse_dev_do_write (through copy_out_args() -> fuse_copy_args()). The
> > cleanest solution to me seems like to pass in from those callers
> > whether the request should be page-aligned after the headers or not,
> > instead of doing the request parsing within fuse_copy_args() itself. I
> > think if we do the request parsing within fuse_copy_args() then we
> > would also need to have some way to differentiate between FUSE_WRITE
> > requests from the dev_do_read vs dev_do_write side (since, as I
> > understand it, writes only needs to be aligned for dev_do_read write
> > requests).
> 
> fuse_dev_do_write() is used to submit results from fuse server
> (userspace), i.e. not interesting here. If we don't parse in
> fuse_copy_args(), we would have to do that in fuse_dev_do_read() - it
> doesn't have knowledge about the request it handles either - it just
> takes from lists what is there. So if we don't want to have it encoded
> in fuse_in_arg, there has to request type checking. Given the existing
> number of conditions in fuse_dev_do_read, I would like to avoid adding
> in even more there.
> 

Your original alternative I think is better, leave it in fuse_in_arg and take it
out of the write arg.  Thanks,

Josef

