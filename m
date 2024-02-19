Return-Path: <linux-fsdevel+bounces-11969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EABF859AB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 03:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17701C20939
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F41210D;
	Mon, 19 Feb 2024 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBEgKY4v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA291C3E;
	Mon, 19 Feb 2024 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708309713; cv=none; b=GZVuV7GncRwWdLhRwLv8v+OTkwSTMGTXdvwuNV4YiZXcDofoKrClbp2LX2OnaUjd/ocAoHaOBd81CUnJHPQUh0VrkERoM+uKHECvO1fLHbZIvwNZ+s+hW6QNX1VLTxs7Ic6bvRRr29jeEha7UNb/jX/Xcl10Spp/ChQarMRz/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708309713; c=relaxed/simple;
	bh=T3iYYfOGyXURvLXVfrDd8rFn2rXciuaCL5lbx26GKe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcyFvmREgNdRNdsM7bc35qc5rbyP2ttMfJ18cmj43KoossHJ4NyHf8pHsJ4cVMUxByjnzHq6XlEmapUe5ifRPYeKX/ZJQbpiRHSM9zldcNYDrd2t70Q8GPYdzxaBQV+3DztJsvzvPgqWXqJdVdksLGfShQPIynASi2DA+dIEiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBEgKY4v; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708309712; x=1739845712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3iYYfOGyXURvLXVfrDd8rFn2rXciuaCL5lbx26GKe8=;
  b=LBEgKY4vjff/7ci3w3TnnAVFgJuvh7cY4nfZ0hDcJQzOZ3O4TsJX/NTx
   AdxD1craZZyyvQ7HezdDui6wiiW8NiMD4dj4E6rL71QHbvXJ9WfutPweN
   5QSRsbPUgYa7lnBwIJym/Vdy+kiR9yJlS4BwJT9kN0Nl+fXN8yqzR7j5p
   esYDdEiJ1BNzImHjEaok85pZj4p9njMqWm5OXr16MC8jFW7+yHcvBWIUb
   P+BSII75HSaWrhzfDVxQgMxqY9zOBU4DI6c7k/Prp3U48gDLQF6+zXOn/
   ll+jd+MfuT1qtjaaKGUUgeNJ0mDAEuJXH0Pk6ymtQbi63r+7Qyw3FfKzv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13001134"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13001134"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:28:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4314701"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:28:31 -0800
Date: Sun, 18 Feb 2024 18:28:29 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] fs/select: rework stack allocation hack for clang
Message-ID: <ZdK8zaBic5NNbYNw@tassilo>
References: <20240216202352.2492798-1-arnd@kernel.org>
 <ZdHZydVbQ7rIhMYV@tassilo>
 <3a829098-612b-4e5a-bcec-3727acee7ff8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a829098-612b-4e5a-bcec-3727acee7ff8@app.fastmail.com>

On Sun, Feb 18, 2024 at 11:29:32AM +0100, Arnd Bergmann wrote:
> On Sun, Feb 18, 2024, at 11:19, Andi Kleen wrote:
> > I suspect given the larger default stack now we could maybe just increase the
> > warning limit too, but that should be fine.
> 
> I don't think we have increased the default stack size in decades,
> it's still 8KB on almost all 32-bit architectures (sh, hexagon and m68k
> still allow 4KB stacks, but that's probably broken). I would actually
> like to (optionally) reduce the stack size for 64-bit machines
> from 16KB to 12KB now that it's always vmapped.

now == after 4/8K.

The 1024 warning limit dates back to the 4/8K times. It could
be certainly reevaluated for this decade's setup.

-Andi

