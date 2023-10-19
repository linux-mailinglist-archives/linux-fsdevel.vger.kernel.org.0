Return-Path: <linux-fsdevel+bounces-785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9F67D013A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 20:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1663828225A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA9D38BD2;
	Thu, 19 Oct 2023 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uzjwlqkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7CAC8E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 18:16:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5C11F;
	Thu, 19 Oct 2023 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697739386; x=1729275386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y3YH1xLn8uCgLxMdmvkYS5BOmN4lSQz1MtdOJPGdEOM=;
  b=Uzjwlqkq2ti9M4xct0plOIP611P6EDAi8rVGVxhnFGWxlmbiIMUmZwEy
   L7VvS6X/9vxmH+4BsTWAPCRZpoAAMrTJfq1W8B2lw9PUphwKBhrowEBNF
   +IPdqloI8wsBGIKuuCABXZ41Q4Q3MjAkinMsFMFsaMUKb1U/3MDfo6ea3
   Wyq4czypv6Wa/m3LXJ1DOiezhRU8jS1Gil7hBzdAOOW1oSwysQpfMBKik
   EG/Q07+YZmNiw5bEPw5FbSHb2TUL4w21LpLS36t04rLwARSIPd5+ixJJU
   9twNi7BHF415q4/STg/fLM6m4T/LWu68xM8DxSE7yMafOC1rOwKVm3fyz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="383546381"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="383546381"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 11:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="786500596"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="786500596"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 11:16:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qtXZE-00000006xAZ-1j2y;
	Thu, 19 Oct 2023 21:16:20 +0300
Date: Thu, 19 Oct 2023 21:16:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
References: <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 19, 2023 at 09:10:25PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 19, 2023 at 10:51:18AM -0700, Linus Torvalds wrote:
> > On Thu, 19 Oct 2023 at 10:26, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > That said, the quota dependency is quite odd, since normally I
> > > wouldn't expect the quota code to really even trigger much during
> > > boot. When it triggers that consistently, and that early during boot,
> > > I would expect others to have reported more of this.
> > >
> > > Strange.
> > 
> > Hmm. I do think the quota list handling has some odd things going on.
> > And it did change with the whole ->dq_free thing.
> > 
> > Some of it is just bad:
> > 
> >   #ifdef CONFIG_QUOTA_DEBUG
> >           /* sanity check */
> >           BUG_ON(!list_empty(&dquot->dq_free));
> >   #endif
> > 
> > is done under a spinlock, and if it ever triggers, the machine is
> > dead. Dammit, I *hate* how people use BUG_ON() for assertions. It's a
> > disgrace. That should be a WARN_ON_ONCE().
> 
> In my configuration
> 
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> 
> > And it does have quite a bit of list-related changes, with the whole
> > series from Baokun Li changing how the ->dq_free list works.
> > 
> > The fact that it consistently bisects to the merge is still odd.
> 
> Exactly! Imre suggested to test the merge point itself, so
> far I tested the result of the merge in the upstream, but not
> the branch/tag that has been merged.
> 
> Let's see if I have time this week for that. This hunting is a bit exhaustive.

Meanwhile a wild idea, can it be some git (automatic) conflict resolution that
makes that merge affect another (not related to the main contents of the merge)
files? Like upstream has one base, the merge has another which is older/newer
in the history?

-- 
With Best Regards,
Andy Shevchenko



