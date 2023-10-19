Return-Path: <linux-fsdevel+bounces-784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA37D012A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 20:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FAF282252
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371D737CB0;
	Thu, 19 Oct 2023 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKxqSG/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1FA37C8C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 18:10:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6811D;
	Thu, 19 Oct 2023 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697739032; x=1729275032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WLkdmAbBAGfuTVcTLJRtWZbWSZmkdlhB5Mb62pp+XO0=;
  b=PKxqSG/PhqUeQNY8EavDt8ORJSROc3+7cfNSafex3IiFvVUGrS792aMq
   VTw1l0KH+q+EEu+F/NVLnx1TWikd5Gta0It9tPQoYyAgElKeyEYYeb29A
   RNd2mx2QJp7NXpK1yJBtV1TJrrFTdcuxvJvc7qyUv/hJEUba8IjYfW8d4
   3dFx2oK2L243WZuYxEuVClN9ufh+b3PsW4eilItSeoDs28KYNISpYVHN3
   +ThA6fOfnLqQRYnlcLB73+U9QtrLEJ0E7opOoFyMVL+7rhE+BlJsaDCNI
   eFdoinljs7ZWtn0EYFpSW+7iX5/k+Z5NvqJ3I/eL7uYdm0b7h1WXR9ct4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="371396929"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="371396929"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 11:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1004321882"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1004321882"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 11:10:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qtXTW-00000006x5Y-0xfe;
	Thu, 19 Oct 2023 21:10:26 +0300
Date: Thu, 19 Oct 2023 21:10:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
References: <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 19, 2023 at 10:51:18AM -0700, Linus Torvalds wrote:
> On Thu, 19 Oct 2023 at 10:26, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That said, the quota dependency is quite odd, since normally I
> > wouldn't expect the quota code to really even trigger much during
> > boot. When it triggers that consistently, and that early during boot,
> > I would expect others to have reported more of this.
> >
> > Strange.
> 
> Hmm. I do think the quota list handling has some odd things going on.
> And it did change with the whole ->dq_free thing.
> 
> Some of it is just bad:
> 
>   #ifdef CONFIG_QUOTA_DEBUG
>           /* sanity check */
>           BUG_ON(!list_empty(&dquot->dq_free));
>   #endif
> 
> is done under a spinlock, and if it ever triggers, the machine is
> dead. Dammit, I *hate* how people use BUG_ON() for assertions. It's a
> disgrace. That should be a WARN_ON_ONCE().

In my configuration

CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y

> And it does have quite a bit of list-related changes, with the whole
> series from Baokun Li changing how the ->dq_free list works.
> 
> The fact that it consistently bisects to the merge is still odd.

Exactly! Imre suggested to test the merge point itself, so
far I tested the result of the merge in the upstream, but not
the branch/tag that has been merged.

Let's see if I have time this week for that. This hunting is a bit exhaustive.

-- 
With Best Regards,
Andy Shevchenko



