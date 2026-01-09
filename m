Return-Path: <linux-fsdevel+bounces-73015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B875AD07BC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 09:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841F6306383E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236B2FB093;
	Fri,  9 Jan 2026 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+F1xIOR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ha+8Tikp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6F2ED872;
	Fri,  9 Jan 2026 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946295; cv=none; b=Y9hQ0z48QlxjssKqZbGZOAwhtlaeGySlDkP/zVQim7wkhX3XFwskiWu8pUW3q78M86ch3FS5oU6rtlojO3oF0OsHZ0MYaHwOz6rfEjYvORqrrmCPJvyOdmUKtk05ANBGBQZjPjjG6aOo7D4FdV9JHAT8H+bB1dQhAhGb7ofOywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946295; c=relaxed/simple;
	bh=AJgdFOqgkWoplkJWLmbZ2mlEFzm7sL7M1WxVqetxKcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNbColxQAiF/XcuAV9XFjibIhCLLFp/MvdxNRv5B2O4+mUIBIG8e/tfbNEnirceu+g3m/OFY8fIBRoO4v/kE7uP4rC8zl9jUXF2TNk8b2JQ4lrDPpVMn/jXWzeSkl72RwBqs13KTw7dNXwX9mU5n8kTXt1iLK1Iz2ARDM5Sw3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+F1xIOR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ha+8Tikp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 9 Jan 2026 09:11:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767946290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMEAnpS9NJkeJ8OxX1giPaXgpWPPFjUQ1ahU3svg4VI=;
	b=v+F1xIORsR1lIfErQ2dLmVy6CZa0Hgn7fB0hPSgOr1HiRA8dKYOiBD+DNbgRNfzXuy9eK/
	D5XauTd0Wv4+kMu5+La6YMFOlQyGq4WI/REuiv9rWuVW162jKmbGQW+L6eANSLrXecdX+F
	mzb3RRS7RPNfza50VEtfkHD0ILGJUuELS0jy+ozcr6i0he387OTHxVkIPYT8Fk/7lA/4WQ
	VaMsy0OFbBjaFIMg8mb7DhjKJaFiOeJJ7zvR4+pScEPhYSPExlKJgJKAt/55n0MVWxfN8L
	EQLT7H0y8ulk+NJMIGoHaHhUUXiL0hrTXlXAQ6mVI0qlmoN0X+WA8CgwMhucIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767946290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMEAnpS9NJkeJ8OxX1giPaXgpWPPFjUQ1ahU3svg4VI=;
	b=Ha+8TikpEPaGFd9Hetv3jHQYQa7a4GCRjAwA0C/oQ+DKqNiAlYDyJ3gKIb9pI3niubGiKK
	dX/V0yNb+39p/gAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Message-ID: <20260109085917-e316ce57-5e78-4827-96d7-4a48a68aa752@linutronix.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
 <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
 <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
 <e22544a1-dea4-44d0-9a72-b60d38eeac19@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e22544a1-dea4-44d0-9a72-b60d38eeac19@bsbernd.com>

On Thu, Jan 08, 2026 at 11:12:29PM +0100, Bernd Schubert wrote:
> 
> 
> On 1/5/26 13:09, Arnd Bergmann wrote:
> > On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:
> >> On 1/5/26 09:40, Thomas Weißschuh wrote:
> >>> On Sat, Jan 03, 2026 at 01:44:49PM +0100, Bernd Schubert wrote:
> >>>
> >>>>> libfuse3.so.3.19.0.p/fuse_uring.c.o -c
> >>>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
> >>>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
> >>>>> format specifies type 'unsigned long' but the argument has type '__u64'
> >>>>> (aka 'unsigned long long') [-Werror,-Wformat]
> >>>>>   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
> >>>>> ", result=%d\n",
> >>>>>       |                                                       ~~~~~~~~~
> >>>>>   197 |                          out->unique, ent_in_out->payload_sz);
> >>>>>       |                          ^~~~~~~~~~~
> >>>>> 1 error generated.
> >>>>>
> >>>>>
> >>>>> I can certainly work it around in libfuse by adding a cast, IMHO,
> >>>>> PRIu64 is the right format.
> >>>
> >>> PRIu64 is indeed the right format for uint64_t. Unfortunately not necessarily
> >>> for __u64. As the vast majority of the UAPI headers to use the UAPI types,
> >>> adding a cast in this case is already necessary for most UAPI users.
> > 
> > Which target did the warning show up on? I would expect the patch
> > to not have changed anything for BSD, since not defining __linux__
> > makes it use the stdint types after all.
> > 
> > On alpha/mips/powerpc, the default is to use 'unsigned long' unless
> > the __SANE_USERSPACE_TYPES__ macro is defined before linux/types.h
> > gets included, and we may be able to do the same on other
> > architectures as well for consistency. All the other 64-bit
> > architectures (x86-64, arm64, riscv64, s390x, parisc64, sparc64)
> > only provide the ll64 types from uapi but seem to use the l64
> > version both in gcc's predefined types and in glibc.
> > 
> >>>> I think what would work is the attached version. Short interesting part
> >>>>
> >>>> #if defined(__KERNEL__)
> >>>> #include <linux/types.h>
> >>>> typedef __u8	fuse_u8;
> >>>> typedef __u16	fuse_u16;
> >>>> typedef __u32	fuse_u32;
> >>>> typedef __u64	fuse_u64;
> >>>> typedef __s8	fuse_s8;
> >>>> typedef __s16	fuse_s16;
> >>>> typedef __s32	fuse_s32;
> >>>> typedef __s64	fuse_s64;
> >>>> #else
> >>>> #include <stdint.h>
> >>>> typedef uint8_t		fuse_u8;
> >>>> typedef uint16_t	fuse_u16;
> >>>> typedef uint32_t	fuse_u32;
> >>>> typedef uint64_t	fuse_u64;
> >>>> typedef int8_t		fuse_s8;
> >>>> typedef int16_t		fuse_s16;
> >>>> typedef int32_t		fuse_s32;
> >>>> typedef int64_t		fuse_s64;
> >>>> #endif
> >>>
> >>> Unfortunately this is equivalent to the status quo.
> >>> It contains a dependency on the libc header stdint.h when used from userspace.
> >>>
> >>> IMO the best way forward is to use the v2 patch and add a cast in fuse_uring.c.
> >>
> >> libfuse is easy, but libfuse is just one library that might use/copy the
> >> header. If libfuse breaks the others might as well.
> > 
> > I don't think we'll find a solution that won't break somewhere,
> > and using the kernel-internal types at least makes it consistent
> > with the rest of the kernel headers.
> > 
> > If we can rely on compiling with a modern compiler (any version of
> > clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
> > could be used for custom typedef:
> > 
> > #ifdef __UINT64_TYPE__
> > typedef __UINT64_TYPE__		fuse_u64;
> > typedef __INT64_TYPE__		fuse_s64;
> > typedef __UINT32_TYPE__		fuse_u32;
> > typedef __INT32_TYPE__		fuse_s32;
> > ...
> > #else
> > #include <stdint.h>
> > typedef uint64_t		fuse_u64;
> > typedef int64_t			fuse_s64;
> > typedef uint32_t		fuse_u32;
> > typedef int32_t			fuse_s32;
> > ...
> > #endif
> 
> I personally like this version.

Ack, I'll use this. Although I am not sure why uint64_t and __UINT64_TYPE__
should be guaranteed to be identical.

> > The #else side could perhaps be left out here.
> 
> Maybe we should keep it for safety? Less for kernel, but more for
> userspace- we don't know in which environments/libs the header is used.

Ack.

> >> Maybe you could explain your issue more detailed? I.e. how are you using
> >> this include exactly?
> > 
> > I'm interested specifically in two aspects:
> > 
> > - being able to build-test all kernel headers for continuous
> >   integration testing, without having to have access to libc
> >   headers for each target architecture when cross compiling.
> > 
> > - layering kernel headers such that kernel headers never depend
> >   on libc headers and (in a later stage) any kernel header
> >   can be included without clashing with libc definitions. 
> 
> Thank you, I think it would good to add these details to the commit message.

Ack.


Thomas

