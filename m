Return-Path: <linux-fsdevel+bounces-23056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9192672D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B875B214A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A54186E31;
	Wed,  3 Jul 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0hOLmp7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80471822FB
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027822; cv=none; b=fmOHni0z1Al8hM7gHuZnj2wbiTpi2f7HIknwfF/zp0mhYhGrRc+Zs8/BVmsiGCcQdLtMtHCvxf5Spg/tfPasHjCQmOM29rg8U9VWN8Sj9nd8I7hCzuMFHTIZkm5psVe68+zK5Xd64UTNhkx4VBke05wxFmutlUGsYQ1xSB4jFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027822; c=relaxed/simple;
	bh=LE25tns728OkfYWJ2B/b43D2CrrVAFiVeNf62SzQgF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6mC1x67N8wxMMHBVQTw53omWKAZx6Bjv1dGCza9g8KtiOfr1hv87PZaC9XmpgMVIgf1EjMRcVhEU0+YMK7XcsmsC9TF0aav7l7N2MN+iPzeObXdwABRzIog8XKDQsLuEKCGPciEtj3jJUjPHcsthDaG7J11lCP7SjJGlqLumng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0hOLmp7G; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d55c0fadd2so3557279b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720027820; x=1720632620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIuCz/XquY0GE0/b+R2ElDS3674UjMbuN9GdYORT3eA=;
        b=0hOLmp7GIGqsxG3cxBUH4fA+n8T+ujNQPLsx3ir3Odg1wzLsANZnEO93YCQS2uXLyz
         rTjYhLSM90UQfBSDtPpgw/lnMzhU33ewgon+XE/FBREZ+Aqsou8atEvCWpnu8ggan2AP
         mV8CqkNdoymTb6aF7M59NokYu9tm/pPgRG/R9DWwxhWgftO0pXuHt0EaTtQNGf878RpB
         t7A+Y6SHhMPY3nASBW1D25o8xthD3LelqTyoStFjh+zUkIC6/E9sEOAKkkNAkC6HE2wp
         sjnUy5Gbqi3ExsymUmmGQYLA8Xd3jiNV0CPsEVvffYknUQ3uon7xgPUhU2vwdV4pO9zH
         DSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027820; x=1720632620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIuCz/XquY0GE0/b+R2ElDS3674UjMbuN9GdYORT3eA=;
        b=PEzY4rbsWIFq/xhr7ckQYKMvEJ2Pj1c5b5Xx3oKqW302cXJdjrtOG0oOWAZmzCPDT/
         euAJeeigs8SL4yIqR4LF/sooGgCxuUu26tWhBAFyKRzoUZnZ34SlKWSdd+WCYJCmGJHs
         w8O4JkTpPUURmSPtx63Cchs7bueyP4aJ812LGmvkTMecrNZm9gkGIR8aj9eR5jHI3g4l
         woiiX5BKn3GGWS1IxReT8wagm2WC7dL5QUkxAFRSQYHZSFAzMikcHUG2i5QinKF1uusc
         OyKXwSh0sPpFlHOpPvtat+SUvLqQ1Mc90LvfgBP0i9wsVHxeEt5+6q5437BXlBkJbVff
         adlA==
X-Forwarded-Encrypted: i=1; AJvYcCUY4aB1e/h0/1FIwh0LXOEEdYUI/0H316rL6btOd0/M3TRZXTPvkpJ5DpTg6X8wLemtoJmOhHE+69WeE1qDlKF5xl3C0d869ZN5WUmbAQ==
X-Gm-Message-State: AOJu0YxjaILljgAkCyJGZkUBXIP7n6dnVBYc3FFZXwic/HvZIXYdKeCZ
	R9dLdnqDuZmFI56ARQyY7nhzi6n4S1qe147D6xzOrLCo9StpAhc1blVOin68B00=
X-Google-Smtp-Source: AGHT+IH19ghxnED0pt53MiNJHakjRl5PoQCYacnPoPNCOTFHCpA5GtdoCfrgW4YW7/DWWvGJLQP79w==
X-Received: by 2002:a05:6808:23c8:b0:3d6:35cc:7624 with SMTP id 5614622812f47-3d6b472713emr15672766b6e.36.1720027818532;
        Wed, 03 Jul 2024 10:30:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e368c0csm55127916d6.22.2024.07.03.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:30:18 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:30:17 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: Allow to align reads/writes
Message-ID: <20240703173017.GB736953@perftesting>
References: <20240702163108.616342-1-bschubert@ddn.com>
 <20240703151549.GC734942@perftesting>
 <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm>

On Wed, Jul 03, 2024 at 05:58:20PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/3/24 17:15, Josef Bacik wrote:
> > On Tue, Jul 02, 2024 at 06:31:08PM +0200, Bernd Schubert wrote:
> >> Read/writes IOs should be page aligned as fuse server
> >> might need to copy data to another buffer otherwise in
> >> order to fulfill network or device storage requirements.
> >>
> >> Simple reproducer is with libfuse, example/passthrough*
> >> and opening a file with O_DIRECT - without this change
> >> writing to that file failed with -EINVAL if the underlying
> >> file system was using ext4 (for passthrough_hp the
> >> 'passthrough' feature has to be disabled).
> >>
> >> Given this needs server side changes as new feature flag is
> >> introduced.
> >>
> >> Disadvantage of aligned writes is that server side needs
> >> needs another splice syscall (when splice is used) to seek
> >> over the unaligned area - i.e. syscall and memory copy overhead.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >>
> >> ---
> >> From implementation point of view 'struct fuse_in_arg' /
> >> 'struct fuse_arg' gets another parameter 'align_size', which has to
> >> be set by fuse_write_args_fill. For all other fuse operations this
> >> parameter has to be 0, which is guranteed by the existing
> >> initialization via FUSE_ARGS and C99 style
> >> initialization { .size = 0, .value = NULL }, i.e. other members are
> >> zero.
> >> Another choice would have been to extend fuse_write_in to
> >> PAGE_SIZE - sizeof(fuse_in_header), but then would be an
> >> arch/PAGE_SIZE depending struct size and would also require
> >> lots of stack usage.
> > 
> > Can I see the libfuse side of this?  I'm confused why we need the align_size at
> > all?  Is it enough to just say that this connection is aligned, negotiate what
> > the alignment is up front, and then avoid sending it along on every write?
> 
> Sure, I had forgotten to post it
> https://github.com/bsbernd/libfuse/commit/89049d066efade047a72bcd1af8ad68061b11e7c
> 
> We could also just act on fc->align_writes / FUSE_ALIGN_WRITES and always use 
> sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) in libfuse and would
> avoid to send it inside of fuse_write_in. We still need to add it to struct fuse_in_arg,
> unless you want to check the request type within fuse_copy_args().

I think I like this approach better, at the very least it allows us to use the
padding for other silly things in the future.

> 
> The part I don't like in general about current fuse header handling (besides alignment)
> is that any header size changes will break fuse server and therefore need to be very
> carefully handled. See for example libfuse commit 681a0c1178fa.
> 

Agreed, if we could have the length of the control struct in the header then
then things would be a lot simpler to extend later on, but here we are.  Thanks,

Josef

