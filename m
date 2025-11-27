Return-Path: <linux-fsdevel+bounces-69978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F08BDC8CE26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 06:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA6944E17BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30EB27EFE3;
	Thu, 27 Nov 2025 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViG6FZub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B47259CBB
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764223024; cv=none; b=h6Kp6wIPoHGYJlNUjVuSRVbTH0zBBocidCd0Y89tcivIfemj4dPlaFs4kWHz/U9qwh4+B8x96KSRq8p/f1V7N71IIte3KOvydUE2QYTnasks65U16EKDI92NSmUdlvbsE0LdNi/SmKud4RlGTT92pE/QTSMHBa9cRv6mku5cJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764223024; c=relaxed/simple;
	bh=k4dBs1CPlVgxmKAPEouCWYFOGD/xaVNZgtHynW+VYyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npxo2hbczBT1Rn5FOzcHJY5okFLSlqQvF3qxgadPmP393ZnSFoSji/50fJAh+D6o8JOMnOixjWIuzqoyZigm5gLKMvdABn8fxjTakwTortMBkyexnT6HzVoGvmxwnaHmwTaFS72I+v2z8Mec+rADKyrSXUgxvwKlfe8B+Rj9lM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViG6FZub; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764223022; x=1795759022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k4dBs1CPlVgxmKAPEouCWYFOGD/xaVNZgtHynW+VYyg=;
  b=ViG6FZub+/DqyfufYnAcugQIhXd08UP1uix9D41C78UugASsIXkxF4mx
   dUSRZ3dIwVx/Oz6OG48GH6KogOu201NhTutjzTEav6lmcncvg56jyPcXQ
   NnrkRO3TjmIa/vf2RwYV1SHCaetc7T6LeFejABizU662pjt0bU2/eCSfo
   a967JKOSyVzGrdMczwuc10Ysu2yO69wBrcHI295KpW9PAmmk1ae+zIanL
   tYig45njjqRWXoJO20MI/RFkOmmpJCTy7neUR7Gc8G3a4F6bQ8m9Alwr+
   SBdm8qJ94s9BvGEBI/4w4KuUWQcn8RVmPEwNbuJPdunaV5RMdbI07FC3L
   w==;
X-CSE-ConnectionGUID: B73LytXbQxuEKt1gQgJKrA==
X-CSE-MsgGUID: +2bRrtFnT6WA3mvavphTwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="69887513"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="69887513"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 21:57:01 -0800
X-CSE-ConnectionGUID: HrFlNMkhQcacx9urAigC7g==
X-CSE-MsgGUID: 7/2qLCvMQDipkCXWLa9N5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193039287"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 21:56:59 -0800
Date: Thu, 27 Nov 2025 07:56:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Hans de Goede <hansg@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/nls: Fix inconsistency between utf8_to_utf32() and
 utf32_to_utf8()
Message-ID: <aSfoKXASYUqIxwD0@smile.fi.intel.com>
References: <20251126204355.337191-1-W_Armin@gmx.de>
 <7b503ef7-2c2a-4dbd-9e6a-bbb16d7876b5@kernel.org>
 <aSdtRQhclLWgXjmu@smile.fi.intel.com>
 <00274787-71f5-40ae-a2e4-ad13da0137cc@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00274787-71f5-40ae-a2e4-ad13da0137cc@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 11:45:57PM +0100, Armin Wolf wrote:
> Am 26.11.25 um 22:12 schrieb Andy Shevchenko:
> > On Wed, Nov 26, 2025 at 09:48:27PM +0100, Hans de Goede wrote:
> > > <dropping the lists from the Cc>
> > > 
> > > I think you've gotten the To: and Cc: lists wrong for this one ?
> > (Semi). The other part of the change is part of pending patches in PDx86.
> > Two options:
> > - apply now via PDx86 to make it consistent (personally my preference)
> > - wait for rc1 and push via NLS maintainers / Andrew Morton.
> 
> I too would prefer option 1, but i just noticed that get_maintainer.pl does not suggest
> the VFS maintainers when asking it about fs/nls/nls_base.c. I changed the MAINTAINERS entry
> for "VFS and infrastructure" from fs/* to fs/ to also include all subdirectories below
> fs/, and now get_maintainer.pl correctly suggests the VFS maintainers.
> 
> Should i send a patch for this too?

I don't think it's a good idea. VFS maintainers won't like to be "spammed" by
that. Probably NLS is handled by any maintainer or Andrew Morton, depending on
the case. Here we are totally fine to go via PDx86.

> > > On 26-Nov-25 9:43 PM, Armin Wolf wrote:
> > > > After commit 25524b619029 ("fs/nls: Fix utf16 to utf8 conversion"),
> > > > the return values of utf8_to_utf32() and utf32_to_utf8() are
> > > > inconsistent when encountering an error: utf8_to_utf32() returns -1,
> > > > while utf32_to_utf8() returns errno codes. Fix this inconsistency
> > > > by modifying utf8_to_utf32() to return errno codes as well.

-- 
With Best Regards,
Andy Shevchenko



