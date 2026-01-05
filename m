Return-Path: <linux-fsdevel+bounces-72382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADEDCF280B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 09:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C263083C6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F45314A95;
	Mon,  5 Jan 2026 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BuOzavmG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q65vPzMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF22D7DE2;
	Mon,  5 Jan 2026 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767602455; cv=none; b=VAzfLA5ojtIZG06MB3enHF0sjDl0dVjDzBMIysuSIQdiJToigJfOhGaFiVjwBUQebwfVkwvaLyi1Lw81QwkhEBQcvhSKnm+oL20K2Arc8K6EtqKHEEs+EZwoeZrH6ZwKV4WFVxIw8aTpydsynYD19FaJPcqROdnHWVnIqZ+Ww9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767602455; c=relaxed/simple;
	bh=qIqmzAoAJvbtIK3YcBH/Ur5W1f6GQ6mNVB23ryuWO5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk013hI+IkCjpk6w/0ul/Tvwzqv9sN7UY5HUG53owr4hRchcRSlwVMQMKqgpHE1HP5MztscAmmVLDFCZiFex7Ns/x0E3uhZDVxKKah45OgrvZSY/VKb824eeSowO/aEh8uy9DA0Fjo7Gcv5bgNNMOJA0rBmzsWu5O3BPySW4Vvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BuOzavmG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q65vPzMz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 Jan 2026 09:40:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767602450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pV2vpahg+KrCpFbT1EwZxaiRnCS3tKiETUQtDX4uIg=;
	b=BuOzavmG347/RjPlFuTbvl6ylWMFRR2aOYebfStNmFnbNw8VRQS1Sbv4XqkQW6yB0K2tdX
	Aw50zPFsK5caKZiZhshkZMAnIRcqQgp2trg+mHwzLH2WOZZ/gaDF1jG/daN4+KgtrNjCMw
	/5mobSa5nPHRbka3tVotfudK6fMjOndhiFqd+ysWrVK0r5AhakRK+eoCZTLJzGWS8TqmPu
	mNVgsIUvMog0/4kS2Spt3adzG1K/mA7Yu+zKNhJ2Nrr5nqwbvSPe3UcjIjkxcN+bFu2Zsk
	08SZeItT8PPZE+i9pULkFHEDk8wk5+kjjB0CpkEG2h+4I53M0h/+vfgLuiwh6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767602450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pV2vpahg+KrCpFbT1EwZxaiRnCS3tKiETUQtDX4uIg=;
	b=q65vPzMzjtSbbcBJzhrG67+WduYAL87xYWEgW/Aai+kjJ6ayeZy6WnkcsBbQmnLTPtfV1G
	cGetuYKW4jdVb5Dw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Message-ID: <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>

On Sat, Jan 03, 2026 at 01:44:49PM +0100, Bernd Schubert wrote:
> 
> 
> On 1/2/26 23:27, Bernd Schubert wrote:
> > 
> > 
> > On 12/30/25 13:10, Thomas Weiﬂschuh wrote:
> >> Using libc types and headers from the UAPI headers is problematic as it
> >> introduces a dependency on a full C toolchain.
> >>
> >> Use the fixed-width integer types provided by the UAPI headers instead.
> >> To keep compatibility with non-Linux platforms, add a stdint.h fallback.
> >>
> >> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> >> ---
> >> Changes in v2:
> >> - Fix structure member alignments
> >> - Keep compatibility with non-Linux platforms
> >> - Link to v1: https://lore.kernel.org/r/20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de
> >> ---
> >>  include/uapi/linux/fuse.h | 626 +++++++++++++++++++++++-----------------------
> >>  1 file changed, 319 insertions(+), 307 deletions(-)
> > 
> > I tested this and it breaks libfuse compilation
> > 
> > https://github.com/libfuse/libfuse/pull/1410
> > 
> > Any chance you could test libfuse compilation for v3? Easiest way is to
> > copy it to <libfuse>/include/fuse_kernel.h and then create PR. That
> > includes a BSD test.

Ack.

> > libfuse3.so.3.19.0.p/fuse_uring.c.o -c
> > ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
> > ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
> > format specifies type 'unsigned long' but the argument has type '__u64'
> > (aka 'unsigned long long') [-Werror,-Wformat]
> >   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
> > ", result=%d\n",
> >       |                                                       ~~~~~~~~~
> >   197 |                          out->unique, ent_in_out->payload_sz);
> >       |                          ^~~~~~~~~~~
> > 1 error generated.
> > 
> > 
> > I can certainly work it around in libfuse by adding a cast, IMHO,
> > PRIu64 is the right format.

PRIu64 is indeed the right format for uint64_t. Unfortunately not necessarily
for __u64. As the vast majority of the UAPI headers to use the UAPI types,
adding a cast in this case is already necessary for most UAPI users.

> I think what would work is the attached version. Short interesting part
> 
> #if defined(__KERNEL__)
> #include <linux/types.h>
> typedef __u8	fuse_u8;
> typedef __u16	fuse_u16;
> typedef __u32	fuse_u32;
> typedef __u64	fuse_u64;
> typedef __s8	fuse_s8;
> typedef __s16	fuse_s16;
> typedef __s32	fuse_s32;
> typedef __s64	fuse_s64;
> #else
> #include <stdint.h>
> typedef uint8_t		fuse_u8;
> typedef uint16_t	fuse_u16;
> typedef uint32_t	fuse_u32;
> typedef uint64_t	fuse_u64;
> typedef int8_t		fuse_s8;
> typedef int16_t		fuse_s16;
> typedef int32_t		fuse_s32;
> typedef int64_t		fuse_s64;
> #endif

Unfortunately this is equivalent to the status quo.
It contains a dependency on the libc header stdint.h when used from userspace.

IMO the best way forward is to use the v2 patch and add a cast in fuse_uring.c.


Thomas

