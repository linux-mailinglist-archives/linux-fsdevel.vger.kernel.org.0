Return-Path: <linux-fsdevel+bounces-75293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHKYOZiCc2kDxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:15:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA1076D69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A7EF3048B1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D7319601;
	Fri, 23 Jan 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+NoXB/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A66257459;
	Fri, 23 Jan 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177584; cv=none; b=J5JVSsfnDRfQvS+GHjhtxR+rzJuDhairJl4ABz8CUnzMPcvUZ4QPpibpPBFewGdSJZq6FBzWRV261Hw7fCpfwbTFECzJUPhsep9jb7LtJuR+BSwxj7pOaldhBNXgBiu3KUvYquiWYKYCwN9KEJdPxdUeiMYVeZs3l/pfj8ZZ4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177584; c=relaxed/simple;
	bh=lyTyiQtwRBFzkXWLU64FTAxGOrVq/MNWmp+g8Q7CIGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH7+0Fp5rXtfVaMVaycMgyFLoerpDeDDV3OaNNFxdbnmAw6gemcitrAMkyJ8EV7P76FLSeSxSWKZeIGu3GFfrPp+/ZGpzhyIkrZk5oRjslIdeXYYbGa4hoNFjlTxEc2jhRh396J82d/m2IspF4Behqduh3zLUPbR6Klx5whct50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+NoXB/x; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769177583; x=1800713583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lyTyiQtwRBFzkXWLU64FTAxGOrVq/MNWmp+g8Q7CIGs=;
  b=J+NoXB/xC/jyFeU8E539Yji8U7nmlpxWYdKkoyBZ4pvL44myt4AwGCSs
   74Dz/q/u+SeC2zSZw5F1ZaOSrCXpaQRMIq1acAhfeEt4lzJylOVQwmY/k
   7v3yJfFlk5EaaT1oOcfSgMqn9JpcdIKlJMEheUQiRanga1BrSmKEHWeIJ
   ssisSUsl6tiVSCTn0KULa6Be6a2fsCrfLhlvhXFugJ7wEKRoDpuO/7PwG
   ZBICDEQ8H/v+cvPexmzckL0BYWIanDtneUG3YqLlcwwgrZdyDqnITmRQu
   jcN0DtBSf+CrU3BK9ET4WfEz6Dkt/il0g4OyLKlN/kQGhuQamatOqaCR5
   Q==;
X-CSE-ConnectionGUID: Yyw5mzsuSJC9UbWbanojgA==
X-CSE-MsgGUID: brvQRRtCSR2J0U1Jgfc3Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70405596"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70405596"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:13:03 -0800
X-CSE-ConnectionGUID: 3z6fRu1lQu6ai0hVmFYztw==
X-CSE-MsgGUID: bghCXoGeTsimmZ+JYMeYMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207291337"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:12:59 -0800
Date: Fri, 23 Jan 2026 16:12:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v1 0/4] initramfs: get rid of custom hex2bin()
Message-ID: <aXOB6Sab5rlipPnH@smile.fi.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
 <20260120-umleiten-gehackt-abb27d77dd73@brauner>
 <aW95Pk3f0GGtyNrY@smile.fi.intel.com>
 <20260123-locher-neider-24c1c9cc64f2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-locher-neider-24c1c9cc64f2@brauner>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75293-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 6BA1076D69
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 01:22:44PM +0100, Christian Brauner wrote:
> On Tue, Jan 20, 2026 at 02:46:54PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 20, 2026 at 12:20:41PM +0100, Christian Brauner wrote:
> > > > Here is the refactoring to show that. This is assumed to go via PRINTK
> > > > tree.

> > > No, initramfs is maintained by the VFS and we already carry other patches.
> > 
> > If this applies cleanly, take them through it, I will be glad, thanks!
> > 
> > > If you want the kstrtox changes to go another route then I will take the
> > > first two changes in a stable branch that can be merged.
> > 
> > I am fine with this route as long as the custom approach is gone.
> > 
> > > > I have tested this on x86, but I believe the same result will be
> > > > on big-endian CPUs (I deduced that from how strtox() works).
> > > 
> > > Did you rerun the kunit tests the original change was part of or did you
> > > do some custom testing?
> > 
> > I'm not sure I understand the point. There were no test cases added for
> > simple_strntoul() AFAICS. Did I miss anything?
> > 
> > (If I didn't that is the second point on why the patches didn't get enough
> >  time for review and not every stakeholder seen them, usually we require
> >  the test cases for new APIs.)
> 
> Sorry, I meant the kunit tests that do test the initramfs unpacking.

Nope, I run on the real HW with real initramfs and I saw the difference when
code was under development (not working). The version I sent works good. But
noted, next time I will run also above mentioned test cases, thanks for
pointing that out.

-- 
With Best Regards,
Andy Shevchenko



