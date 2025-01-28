Return-Path: <linux-fsdevel+bounces-40229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC9A20B43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 14:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F1C7A1814
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3121A725A;
	Tue, 28 Jan 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmXDHuhQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBD1A08A6;
	Tue, 28 Jan 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070670; cv=none; b=ewKc1rr1L8aLQ33YQ8MWjEXuAITzasecQ3802c4CwDynq2DhgCa8hbk0AeHIvl+AlnrGf+ES680tp6pioecp9stdR6SvqvjJQAAps1WqY5uH1L2hPc6Vz4D11zIfndK6kcw5chHKdphNCJgEQ6Un4giImIWge47NIjjoX7DyBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070670; c=relaxed/simple;
	bh=HV9Gsp0UdgnQEvAVU7AhpmWTZQIHOU7h3dazbPxQnk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHJVc52bzYjc/3wYmd8m3r661fpnYnSTrfKxkiAuZS7n21Gy3bbiQ4HE/1oX5o8l1VDo2pjnKvmJQ2CyXdmM+jbnpCPoFN/iuTAoyf0un5eWTT0XluOcVZseVx2YjohoNQqxecyPLt4HD/8xi9CAe19ERwBoWFUoHrKUPmsNnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmXDHuhQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738070668; x=1769606668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HV9Gsp0UdgnQEvAVU7AhpmWTZQIHOU7h3dazbPxQnk0=;
  b=XmXDHuhQsLc7s4+7FjHOsKN78Ivs38wNrf4f6J4sWcGbKEPUofPv1JNZ
   zYj7JjWFQ2W+4hXdm09fPsy+DOdMyjxAL429QPwNOtBHvVKiKvi7kxLaB
   fVtmAgkHMJ/qt8ZPuGKolclf+vkSvo9JrRhMbGkO5rPQCuG06iwLEbQRt
   zaBLX34RLP2Px3JtSOE7AoVGaJaqu/bBBkTz+JgbtXLK9K+5xfYdH1yjd
   G/Z7sU2vn1iOaBRz3cVb9ct8iZcgEWBA6eCasgbmAHu5b7eYxy14odajU
   KqlUSKfsATG57doGMWdhGYhYGAAKyYSQCWdbaP5O2mqXAWofoaHT78+fb
   A==;
X-CSE-ConnectionGUID: Uow8ddVBR8mXletmynI1rw==
X-CSE-MsgGUID: dN6mPk4FRpWXAAx98fULQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49142603"
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="49142603"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 05:24:27 -0800
X-CSE-ConnectionGUID: OPmg1nVgQsO723SsPbrscw==
X-CSE-MsgGUID: 3U0WOi5DRxOXYZTxQ2BwWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="108700453"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 05:24:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tclZn-000000064Uz-1tVb;
	Tue, 28 Jan 2025 15:24:23 +0200
Date: Tue, 28 Jan 2025 15:24:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Kara <jack@suse.cz>, Ferry Toth <ftoth@exalondelft.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <Z5jahxEopW5ixuFz@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 17, 2023 at 02:46:20PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:

...

> > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > It has earlycon enabled and only what I got is watchdog
> > > > trigger without a bit of information printed out.
> 
> Okay, seems false positive as with different configuration it
> boots. It might be related to the size of the kernel itself.

So, here is the thing, I dug into it and found a workaround.

TL;DR: It all was started from the commit [0].
But read the long read below for all the details.

The memory layout of the platform in question is that

    BIOS-provided physical RAM map:
    BIOS-e820: [mem 0x0000000000000400-0x0000000000097fff] usable
    BIOS-e820: [mem 0x0000000000100000-0x0000000003ffffff] usable
    BIOS-e820: [mem 0x0000000004000000-0x0000000005ffffff] reserved
    BIOS-e820: [mem 0x0000000006000000-0x000000003f4fffff] usable
    BIOS-e820: [mem 0x000000003f500000-0x000000003fffffff] reserved
    BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
    BIOS-e820: [mem 0x00000000fec04000-0x00000000fec07fff] reserved
    BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
    BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved

So, as you can see the first 64Mb (excluding the first one) is usable memory.
It's immediately followed up by reserved one.

Back in 2014-2016 the kernel and initramfs have been smaller and basically
the window of 64Mb was enough to load kernel at the 0x100000 (1Mb) and
followed by initramfs somewhere at the offset 0x3000000 (48Mb). But after
the mentioned commit [0] people have noticed that it failed to boot [1]
and workaround was quickly found back then by moving initramfs to the next
available window, i.e. 0x6000000 (96Mb), problem solved! No, not really.

With the kernel growing bigger and bigger it started randomly fail to boot
as I have reported here. Mostly I'm using this platform with kexec'ing new
kernels and I was under the impression that kexec is more flexible than
U-Boot that's used on this platform. It appears that kexec'ed boots also
started failing!

So, what the commit [0] does is that it starts occupying the end of the given
window and hence it was put a garbage to the initramfs. On top of that it appears
that kexec doesn't properly calculating the window size which is needed for the
kernel to be unpacked. See patches [2][3] that I upstreamed to the kexec v2.0.30.
In internal discussion with HPA it appears that many bootloaders didn't get it
right due to... documentation unclearness. This what I have fixed in kernel
recently [4]. Took me a while to go through the assembler code and figure all
this out.

TODO in the kernel (as I referred in some discussion that kernel can do better):
Ideally we should split kaslr algorithm for memory search for even non-KASLR
kernels and make use of it at the very beginning, so for relocatable kernels
we may find better addresses and still trust bootloader that puts kernel and
initramfs binaries close to each other in the same memory window.

[0]: 974f221c84b0 ("x86/boot: Move compressed kernel to the end of the decompression buffer")
[1]: https://lore.kernel.org/all/20160816040147.GA4492@hydra.tuxags.com/
[2]: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=ec3e4dfeec22a2c78d6c7fbccf006bf4a7ba635d
[3]: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=07a6217af3cfb7b7952be22a58d4a3a365e422bb
[4]: be4ca6c53e66 ("x86/Documentation: Update algo in init_size description of boot protocol")

-- 
With Best Regards,
Andy Shevchenko



