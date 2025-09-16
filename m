Return-Path: <linux-fsdevel+bounces-61721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF6B594EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586917ADA2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5902C2359;
	Tue, 16 Sep 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPccqQnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB825B30D;
	Tue, 16 Sep 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021480; cv=none; b=BVcNTHZLtRc0TK4FBDHzoZKH5bBoSGUs7iklavs63f+yFMzZL967w/LdQdqyr/3GRgk8jTkSt5/PYjrNcnp8UHpLGPELmg+V/vRu3zU13kZHRT4y0KbLOpGsOGUfPGs2B142LeOlmI85WJyu2RtqrB1KNGeJFdd0+gwlPOoxonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021480; c=relaxed/simple;
	bh=CTjPrnm5eHCp0MoEimtBQ1qh43ZfQU9K48Rja20O4c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EybFyuoXQNC/xy0qbc6jwjhOZPagkhhqY9KISydrPG3pvmXrw6U6Wv5mRf+QTov/2hT/FIkPXDc0zllNBY9KYQ37gfCOaohuRkRL3pKdRiQCtOnond1k+4HkrYFei4JtoZBLAS0lYWdcPUrxeIu50DnSYJAeJEP8qi6EBjGbIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPccqQnU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758021475; x=1789557475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CTjPrnm5eHCp0MoEimtBQ1qh43ZfQU9K48Rja20O4c4=;
  b=HPccqQnUD49ieY2nSx/Es1HSrXo5FKEjWJUhyJnqCPDq23NtUHB1+7x4
   bdEWE2fplPTcTezeW5kRsBTGHP7rrb95DJEofb38wiPlmM8MQiHYuTFTw
   eDkI8wHF3qQbuV5KQ8zsLhZjkdBl0a1R980eP2uPyN+4sTs44Y7Xcq3kl
   rBE5I0o7hexLQO7OjTI0t2rA1Jvy3Xiorr5sjxKEE6fWtkTBG5MDbm0jt
   582wT2tkSsPgQ67crhBLvRQ7ew5glN/M+E0Pjcyy4kshgVS8L2107pNLg
   uO0EDM5I6aJDD4dCwStVxEmssHOGUFViIpA3xGIcdlb2gJZTPDgbtFvbx
   g==;
X-CSE-ConnectionGUID: j3fBAkW6S7OqkXgcNNr3MQ==
X-CSE-MsgGUID: /PykqSVFSh2QrcUPn+oFAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="62935311"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="62935311"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 04:17:54 -0700
X-CSE-ConnectionGUID: YOmZPaRGSNiOTJBbCfjT4w==
X-CSE-MsgGUID: UPSOZh2bR9a8cHnYeb12QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="180167887"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 04:17:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyTgy-00000003Vdh-3drX;
	Tue, 16 Sep 2025 14:17:48 +0300
Date: Tue, 16 Sep 2025 14:17:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] lock_mount(): Remove unused function
Message-ID: <aMlHXBswxpy0D7s9@smile.fi.intel.com>
References: <20250915160221.2916038-1-andriy.shevchenko@linux.intel.com>
 <20250916012537.GL39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916012537.GL39973@ZenIV>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 02:25:37AM +0100, Al Viro wrote:
> On Mon, Sep 15, 2025 at 06:02:21PM +0200, Andy Shevchenko wrote:
> > clang is not happy about unused function:
> > 
> > /fs/namespace.c:2856:20: error: unused function 'lock_mount' [-Werror,-Wunused-function]
> >  2856 | static inline void lock_mount(const struct path *path,
> >       |                    ^~~~~~~~~~
> > 1 error generated.
> > 
> > Fix the compilation breakage (`make W=1` build) by removing unused function.
> > 
> > Fixes: d14b32629541 ("change calling conventions for lock_mount() et.al.")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Folded into commit in question to avoid bisect hazard

Thank you!

-- 
With Best Regards,
Andy Shevchenko



