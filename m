Return-Path: <linux-fsdevel+bounces-72385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA6DCF2DFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34F1C300EDE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6EF31A579;
	Mon,  5 Jan 2026 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhwCtBTW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejZSeGwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5103FC9;
	Mon,  5 Jan 2026 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607041; cv=none; b=E/HkUsq4kt1soFkLnaZjtg15oyks9Fv5/m8HDk2dMR0YVPCpRHbsQ2i0g2dFHoww44D1IXwYUKLzmaswbL0cT+W3fagEhsz9DuMX2iGYQWdLKQdDJxmsBPO2XmmMff7INOe8mtJiyWR995CNm0b5OxTqQFpPz6Ro62fMvYCFlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607041; c=relaxed/simple;
	bh=iKhVYsPd3xjI//wmGXtgta1cQPO1Wdk//hk+Sb44+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIIip1GB1t0kMihi8ucS7oNtfQRZyS3q/6d9IapGHtCq69QqLO0hsVunMVsF2QpnmENWfdDWn68czoKnTpS1JSg8bcsuwfVYeX1Tt1wghgqwW676DFf6Jy7AEm3FvxN4VHfypzJd+FKXoV+/LiDdUTvMnjxyfzEQDUI25MFU3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhwCtBTW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ejZSeGwx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 Jan 2026 10:57:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767607038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuijUZ/0RA0CIbUtjMYRmWCI5fwbdYagkTZ2rdcL1lY=;
	b=bhwCtBTWhbAGyLBMdDnFWD7YT8uwQQlq2SZLJrr00gBzkrcjXMxWZuEyC7O6g2uloWllGs
	TPxdeVuMfJZjEUYvfKN//ipxinZhrXrsF2ZAFr/VafK0wOQydtyXyg3iFl2K2dSQ9UETP+
	wu3ObudQpGi4jGckBpMinRa1p6u7c7+6eJfs++NnYVOZqScUVBNb0ffGnCUSAD1w8XZIdh
	hz+vUt1Ebku0YaCjsvZC7Te7DRZ46hSsSktxlnFqS5/r6sSTVYCmCwla3hCzG74ARiVNda
	EYp/JkbcdhdMnJ8rjvqeBxqtCW/GDd6Q2LmKCdT/dnj318UrWE69hQFfi+ougg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767607038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuijUZ/0RA0CIbUtjMYRmWCI5fwbdYagkTZ2rdcL1lY=;
	b=ejZSeGwxfotngO5iJO34oG6+7Ll/f75Cqnf/2cMdNNL365G5whELq0goWVVWfoPamFyidg
	gedKdWqSicnQwqDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Message-ID: <20260105104342-8d6f1457-f422-4ef6-ac66-5170869a5ec7@linutronix.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
 <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>

On Mon, Jan 05, 2026 at 09:50:30AM +0100, Bernd Schubert wrote:
> 
> 
> On 1/5/26 09:40, Thomas Weiﬂschuh wrote:
> > On Sat, Jan 03, 2026 at 01:44:49PM +0100, Bernd Schubert wrote:
> >>
> >>
> >> On 1/2/26 23:27, Bernd Schubert wrote:
> >>>
> >>>
> >>> On 12/30/25 13:10, Thomas Weiﬂschuh wrote:
> >>>> Using libc types and headers from the UAPI headers is problematic as it
> >>>> introduces a dependency on a full C toolchain.
> >>>>
> >>>> Use the fixed-width integer types provided by the UAPI headers instead.
> >>>> To keep compatibility with non-Linux platforms, add a stdint.h fallback.
> >>>>
> >>>> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Fix structure member alignments
> >>>> - Keep compatibility with non-Linux platforms
> >>>> - Link to v1: https://lore.kernel.org/r/20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de
> >>>> ---
> >>>>  include/uapi/linux/fuse.h | 626 +++++++++++++++++++++++-----------------------
> >>>>  1 file changed, 319 insertions(+), 307 deletions(-)
> >>>
> >>> I tested this and it breaks libfuse compilation
> >>>
> >>> https://github.com/libfuse/libfuse/pull/1410
> >>>
> >>> Any chance you could test libfuse compilation for v3? Easiest way is to
> >>> copy it to <libfuse>/include/fuse_kernel.h and then create PR. That
> >>> includes a BSD test.
> > 
> > Ack.
> > 
> >>> libfuse3.so.3.19.0.p/fuse_uring.c.o -c
> >>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
> >>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
> >>> format specifies type 'unsigned long' but the argument has type '__u64'
> >>> (aka 'unsigned long long') [-Werror,-Wformat]
> >>>   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
> >>> ", result=%d\n",
> >>>       |                                                       ~~~~~~~~~
> >>>   197 |                          out->unique, ent_in_out->payload_sz);
> >>>       |                          ^~~~~~~~~~~
> >>> 1 error generated.
> >>>
> >>>
> >>> I can certainly work it around in libfuse by adding a cast, IMHO,
> >>> PRIu64 is the right format.
> > 
> > PRIu64 is indeed the right format for uint64_t. Unfortunately not necessarily
> > for __u64. As the vast majority of the UAPI headers to use the UAPI types,
> > adding a cast in this case is already necessary for most UAPI users.
> > 
> >> I think what would work is the attached version. Short interesting part
> >>
> >> #if defined(__KERNEL__)
> >> #include <linux/types.h>
> >> typedef __u8	fuse_u8;
> >> typedef __u16	fuse_u16;
> >> typedef __u32	fuse_u32;
> >> typedef __u64	fuse_u64;
> >> typedef __s8	fuse_s8;
> >> typedef __s16	fuse_s16;
> >> typedef __s32	fuse_s32;
> >> typedef __s64	fuse_s64;
> >> #else
> >> #include <stdint.h>
> >> typedef uint8_t		fuse_u8;
> >> typedef uint16_t	fuse_u16;
> >> typedef uint32_t	fuse_u32;
> >> typedef uint64_t	fuse_u64;
> >> typedef int8_t		fuse_s8;
> >> typedef int16_t		fuse_s16;
> >> typedef int32_t		fuse_s32;
> >> typedef int64_t		fuse_s64;
> >> #endif
> > 
> > Unfortunately this is equivalent to the status quo.
> > It contains a dependency on the libc header stdint.h when used from userspace.
> > 
> > IMO the best way forward is to use the v2 patch and add a cast in fuse_uring.c.
> 
> libfuse is easy, but libfuse is just one library that might use/copy the
> header. If libfuse breaks the others might as well.

Yes, unfortunately.

> Maybe you could explain your issue more detailed? I.e. how are you using
> this include exactly?

I want the linux/fuse.h to work together with -nostdinc.

This has various advantages:
* It allows compilers for other languages to parse the C headers without
  the dependency on a full toolchain.
* It enables the usage in other, non-libc based C environments.
* Together with [0], it allows the verification of the header for all
  architectures. For example Arnd works on validating the UAPI against -Wpadded
  which requires the header to be built for each architecture.

This affected me at [1] and now I'm trying to proactively avoid this issue in
other places and prevent its re-introduction.

[0] https://lore.kernel.org/lkml/20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de/
[1] https://lore.kernel.org/lkml/20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de/


Thomas

