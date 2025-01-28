Return-Path: <linux-fsdevel+bounces-40230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65375A20B4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 14:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAA818864ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4951A83E2;
	Tue, 28 Jan 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVI6Fg6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A119CCEC;
	Tue, 28 Jan 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070812; cv=none; b=Qc++a7foynUyrzQwUxpNyZ0RYYil7BJu4ClsArqOOp49MhYPlBu8N0iJBFpihrT8CJYVw4JQ+o/fzK16RRy3CDJOF8BBFz+fcRwt9yC8jCr1SCDjhKlP4CrBL0tiSmdqm6Xv/VnsC95vBO8TS5CW08/6rJmRHPPbyQflX+F7f20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070812; c=relaxed/simple;
	bh=xmGvAmLs1TOKoZKF82mBR3UUIuOtx8OIOiBL6BHICNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEO4/qTm481bhAID+Ph0kuKrufEtB9wW87jn2bfXAwgHmQcfZD5Hnk04cbL92Sad5YZJ9LbTax8DFdl/9/yVJNd+9wOAAw2Fudj3A/Zk896n7y5DpYSff2joGO2SUm9QQmNBsePSxULYBqW6SmTnuLRaXcJe/snDYmsPtkqt7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVI6Fg6s; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738070810; x=1769606810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xmGvAmLs1TOKoZKF82mBR3UUIuOtx8OIOiBL6BHICNA=;
  b=YVI6Fg6svocztwLqVVZ5pfh5Zoazne6thkiMrDln0LXjDZ66lmMInc0+
   wc3X5pa/BgeMlY+wjzDnUcIC+DHRJN1PXKMPaQM+mA14asNCB1kZEnijv
   XtOMFYed1huyoZBXKSsu3MWsHK20is/nokkq0u/KRjJVSyRw6q8mBBHCy
   Y3cVB0JUJgH2314AXX9/rYaJVRhjlZisVak0nPPHhrWkKiYjGBz9gyduL
   geJxtJfU/SLVNoZ9f27Y9zaKj7/Zfz4S2HFzLSoyIH+dFArcvVg11VNTR
   q3leGFqijj1AyuH/4mjra01PlCD2VnYOAgxnZnN0mzL8bNz3IQuKmocr0
   A==;
X-CSE-ConnectionGUID: 6gnsWMMBQFW42LYKvms+rw==
X-CSE-MsgGUID: ZlbWSDXrQCildycYlXS/PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38436933"
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="38436933"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 05:26:50 -0800
X-CSE-ConnectionGUID: CKzHCSaeQOy95cF6W4m0eg==
X-CSE-MsgGUID: IKTe+aODSjie6BgVH6N5aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="108841878"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 05:26:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tclc6-000000064Z4-0wfn;
	Tue, 28 Jan 2025 15:26:46 +0200
Date: Tue, 28 Jan 2025 15:26:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <Z5jbFiB1UzfChk0r@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <9ba95b5e-72cb-445a-99b7-54dad4dab148@leemhuis.info>
 <5884527d-a4a2-44e2-96bc-4b300c9e2fb8@leemhuis.info>
 <ZWDTkmQZ7uojegiS@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWDTkmQZ7uojegiS@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 24, 2023 at 06:47:14PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 22, 2023 at 09:15:06AM +0100, Linux regression tracking #update (Thorsten Leemhuis) wrote:
> > On 22.10.23 15:46, Linux regression tracking #adding (Thorsten Leemhuis)
> > wrote:
> > > On 17.10.23 12:27, Andy Shevchenko wrote:
> > >> On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > >>>   Hello Linus,
> > >>>
> > >>>   could you please pull from
> > >>>
> > >>> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1
> > >>
> > >> This merge commit (?) broke boot on Intel Merrifield.
> > >> It has earlycon enabled and only what I got is watchdog
> > >> trigger without a bit of information printed out.
> > >>
> > >> I tried to give a two bisects with the same result.
> > > 
> > > #regzbot ^introduced 024128477809f8
> > > #regzbot title quota: boot on Intel Merrifield after merge commit
> > > 1500e7e0726e
> > > #regzbot ignore-activity
> > 
> > Removing this from the tracking. To quote Linus from
> > https://lore.kernel.org/all/CAHk-=wgEHNFHpcvnp2X6-fjBngrhPYO=oHAR905Q_qk-njV31A@mail.gmail.com/
> > 
> > """
> > The quota thing remains unexplained, and honestly seems like a timing
> > issue that just happens to hit Andy. Very strange, but I suspect that
> > without more reports (that may or may not ever happen), we're stuck.
> > """
> > 
> > No other reports showed up afaik.
> 
> Yeah, have no time to dig into this more... Maybe later, who knows?

FYI: Just shared all my findings and the root cause analysis here:
https://lore.kernel.org/r/Z5jahxEopW5ixuFz@smile.fi.intel.com

TL;DR: there is no bug in this PR.

-- 
With Best Regards,
Andy Shevchenko



