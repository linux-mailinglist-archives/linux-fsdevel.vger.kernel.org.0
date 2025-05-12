Return-Path: <linux-fsdevel+bounces-48773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFEFAB4590
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 22:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C36519E79A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C260298C39;
	Mon, 12 May 2025 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6m4aQvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF52185BC;
	Mon, 12 May 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747082447; cv=none; b=lQgW/ssg9kIbCH5VeWxDl4RTq3oVbB0rFxtCviawhdCEAHCQfYmM+W+FLrafZlcvKYQC5ZvarhDRkpIQKD/BNko9mfqqeRDiD9rtIi12qMaIMLFr2mTVXcCSKlhzMhGcABGvZ3d2j/W72enDFpdjkeLFr164F8uYzqaUcKJe7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747082447; c=relaxed/simple;
	bh=bf5PIRNk9xJap20uZgQzAP7S5TiH/EgmMIGZvh3z444=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa4/6IKZMM6f6uo4a0+7TkzwpZun0SNcmCM6gjcdcepdVy1yH62rT6mqZOs0xKqZr2Tu1CiOkDBcAZDeAUDqR+W3auHwiAoMwGAOE/GDTi2BmesGzfs8ptGqpLMbhror5FATe4KMfDm1w5j9raUNGtj1b9cH/qEkdJRcI1eihiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6m4aQvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA003C4CEE7;
	Mon, 12 May 2025 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747082446;
	bh=bf5PIRNk9xJap20uZgQzAP7S5TiH/EgmMIGZvh3z444=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6m4aQvrd6TLCpXv8P4z74bpm8a6flnmv2MsHpjztJTaUKYwJWnIR0P39740sP39M
	 Gj1E+DeExSU8PhNNJXxDGBPl7g8z3EPtGUnRtVIWX2jQ5zbrnNRijtNcm5roFBDk37
	 fayuA+aMQFo8HAz2xhA3mYsI39fO+VY1T3dRl2tzlku1feXUNeAsIqRXFHPfyoAgPd
	 BGxHei/iCuj+GuYDx40SVK24QuS+Bl0uXwCGMS4qJ9MiOTjBSnt9Y8Qb/3qjvxCETJ
	 Nv525B5gzF76FqoPoZ7ErA6kyaW+mVukXNut5aDUiqRzUeAkTNHWdB7jsmcolmIl2Z
	 4C5cSv2B5zxzg==
Date: Mon, 12 May 2025 13:40:44 -0700
From: Kees Cook <kees@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Ali Saidi <alisaidi@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_elf: Move brk for static PIE even if ASLR
 disabled
Message-ID: <202505121340.7CA14D4C@keescook>
References: <20250502001820.it.026-kees@kernel.org>
 <87f80506-eeb3-4848-adc9-8a030b5f4136@arm.com>
 <a786b348-7622-4c62-bfdc-f04e05066184@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a786b348-7622-4c62-bfdc-f04e05066184@arm.com>

On Mon, May 12, 2025 at 04:17:12PM +0100, Ryan Roberts wrote:
> Hi Andrew,
> 
> 
> On 02/05/2025 11:01, Ryan Roberts wrote:
> > On 02/05/2025 01:18, Kees Cook wrote:
> >> In commit bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
> >> direct loader exec"), the brk was moved out of the mmap region when
> >> loading static PIE binaries (ET_DYN without INTERP). The common case
> >> for these binaries was testing new ELF loaders, so the brk needed to
> >> be away from mmap to avoid colliding with stack, future mmaps (of the
> >> loader-loaded binary), etc. But this was only done when ASLR was enabled,
> >> in an attempt to minimize changes to memory layouts.
> >>
> >> After adding support to respect alignment requirements for static PIE
> >> binaries in commit 3545deff0ec7 ("binfmt_elf: Honor PT_LOAD alignment
> >> for static PIE"), it became possible to have a large gap after the
> >> final PT_LOAD segment and the top of the mmap region. This means that
> >> future mmap allocations might go after the last PT_LOAD segment (where
> >> brk might be if ASLR was disabled) instead of before them (where they
> >> traditionally ended up).
> >>
> >> On arm64, running with ASLR disabled, Ubuntu 22.04's "ldconfig" binary,
> >> a static PIE, has alignment requirements that leaves a gap large enough
> >> after the last PT_LOAD segment to fit the vdso and vvar, but still leave
> >> enough space for the brk (which immediately follows the last PT_LOAD
> >> segment) to be allocated by the binary.
> >>
> >> fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /sbin/ldconfig.real
> >> fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /sbin/ldconfig.real
> >> fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
> >> ***[brk will go here at fffff7ffa000]***
> >> fffff7ffc000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
> >> fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
> >> fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]
> >>
> >> After commit 0b3bc3354eb9 ("arm64: vdso: Switch to generic storage
> >> implementation"), the arm64 vvar grew slightly, and suddenly the brk
> >> collided with the allocation.
> >>
> >> fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /sbin/ldconfig.real
> >> fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /sbin/ldconfig.real
> >> fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
> >> ***[oops, no room any more, vvar is at fffff7ffa000!]***
> >> fffff7ffa000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
> >> fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
> >> fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]
> 
> This change is fixing a pretty serious bug that appeared in v6.15-rc1 so I was
> hoping it would make it into the v6.15 final release. I'm guessing mm is the
> correct route in? But I don't currently see this in linus's tree or in any of
> your mm- staging branches. Is there still time to get this in?

I'll be sending it to Linus this week. I've been letting it bake in
-next for a while just to see if anything shakes out.

-- 
Kees Cook

