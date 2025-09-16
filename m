Return-Path: <linux-fsdevel+bounces-61726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B100B59658
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B193BFD2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4430C611;
	Tue, 16 Sep 2025 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbCCalfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EA306B21;
	Tue, 16 Sep 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026280; cv=none; b=MBZdT9SxygCSSHJ5t0VvIEhS8/UOZYJpiHCK5TEOQl1d9bLCiuyKUfTsQDDWxcY+Hx1x3QdO7KA90LRopYoZTwdNcYDtnrfMYqEjdxHBRx5ZUrzDXZRiEltzstFnPZNEbcDREX2P2iOUINgBNxX78lxbcFsVcBP19BDneD3+51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026280; c=relaxed/simple;
	bh=XVyDlZ1SCJXgq+chWGP6vIGrgyIk1SQPZ/6k4hcNvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf2BUPTlVvYCRzz27DovJhVm/kSiy2eA7dX3Cs7XFJsECJvErERJXvmgAeeZCkdG7xqYBA70fSaCUIJg+oHdY9ROI68HOOgi+CdPaIevcVcylNGMQTFtlIFBuVUfftjhSFXaC9r+dXYURA1xpFc6R+1/vncgqtBz4Gf2/GqqmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbCCalfv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758026274; x=1789562274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVyDlZ1SCJXgq+chWGP6vIGrgyIk1SQPZ/6k4hcNvh0=;
  b=bbCCalfvapPlNCpnGPLbwiNVi0KFo0yz3dk0zlTS+deP+NABTAAj9MgE
   1pHo667MZutYls2zYZ4HT5qMxVACACwbESnvwZcIkb/tBf1Gzo/PqJoKC
   QsMlQdcEMGD8bae+7qTjNjWR4u/Pag0Fb9O3xSq/Q90tE/LZYcMx+wEZO
   9z7D5jTzvWOGpxAkUEulmtS1GJ8+gvqay4CXTEFfstOJoXWJQS8bA4ujG
   hEMHCWDRZe04VK9jTOxjNu+0TbU/JCu3f5eeUcqGD7ZULvev66kYV4Xyp
   oBJUPqef3rLRuqi7NJCvlQNDi5rUWUqFwckntCExzUbmWjQLCZrR6CDde
   Q==;
X-CSE-ConnectionGUID: C9oY+X6hQVWhUzbsjpQ3TA==
X-CSE-MsgGUID: FR6fUMrkQWiQMK9P9pgarg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77911519"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="77911519"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:37:53 -0700
X-CSE-ConnectionGUID: vqsWCP6PT0CN9pfuYNJyGg==
X-CSE-MsgGUID: MbPp+YYXQ9SXfecXIdFwhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174866470"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:37:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyUwO-00000003WfM-076A;
	Tue, 16 Sep 2025 15:37:48 +0300
Date: Tue, 16 Sep 2025 15:37:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] lock_mount(): Remove unused function
Message-ID: <aMlaG5gXag1C-MGr@smile.fi.intel.com>
References: <20250915160221.2916038-1-andriy.shevchenko@linux.intel.com>
 <20250916012537.GL39973@ZenIV>
 <aMlHXBswxpy0D7s9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlHXBswxpy0D7s9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 02:17:48PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 02:25:37AM +0100, Al Viro wrote:
> > On Mon, Sep 15, 2025 at 06:02:21PM +0200, Andy Shevchenko wrote:
> > > clang is not happy about unused function:
> > > 
> > > /fs/namespace.c:2856:20: error: unused function 'lock_mount' [-Werror,-Wunused-function]
> > >  2856 | static inline void lock_mount(const struct path *path,
> > >       |                    ^~~~~~~~~~
> > > 1 error generated.
> > > 
> > > Fix the compilation breakage (`make W=1` build) by removing unused function.
> > > 
> > > Fixes: d14b32629541 ("change calling conventions for lock_mount() et.al.")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Folded into commit in question to avoid bisect hazard
> 
> Thank you!

It seems similar treatment needs for node_to_mnt_ns() as it's now unused after
the commit 96ff702edaec ("mnt: support ns lookup") if I'm not mistaken.

Should I send a patch?

-- 
With Best Regards,
Andy Shevchenko



