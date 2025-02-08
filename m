Return-Path: <linux-fsdevel+bounces-41282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C384FA2D56B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 11:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF398188CF14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5D1B0418;
	Sat,  8 Feb 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NU8jo/aU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916E7DA8C;
	Sat,  8 Feb 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739009519; cv=none; b=tlHYT40Wjz6/qxVh66/0z/DFxk7veVVLeZJnYwmgnOw+JspEeygLPPq+eBeuaSfo2RS/2+GrZrqHNNAMPOkQl7WHxETHIH3Y+HkjQf2es5uJRjbPBIK1dmlNkQQY7wx72IUvJSMEnJ/YDVK7j/C6aExf1w8Rbsi1/ULeQWTkb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739009519; c=relaxed/simple;
	bh=MkuBmQus/e8uwIsd5zQOF1zf//X1fSM4hZUt0+5WeJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouAUFQhzMCcn2D+DNOy+HDvgLMlPk0Xrbek4XHb+quzgKaJKae9mMIQpJXNLoC5yerl9/kF+LJKMxCHWU00EldAzoyb24JHjRE9pevMGjPfLkPtKh+KmrqGE2TSeNPKHBlNiaINNZqY/sFJ7RP469zLr4Bt/I64zVoozQ5TX0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NU8jo/aU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g3Z94bETGQeiDOIJu0r91P2vvPEJCA5AYCK0Qiv6LYE=; b=NU8jo/aUuMYlL2bMSPJulrSSFS
	Kz9EhAwK1QsnNlf8Bu5FQJoBrR+SF8RZs/jjxHDIZt/wHZIcCzSmBgQzL10ISIQV0yxh5ihCkaifg
	stTtauwYH0SPg0QB3G4T2ld6GHKGCxdQCd7AP8ySh063u+eymiFc5gK29quNsuxT+qCremQV92JNi
	Vlq+HmT2ihV0qN9+MEbf/uia8gjUOky9f/BpArQeF7G+oxDVl67E3TrA367gW5ZXOHRNxq67GICiW
	/x7Jvo2Ij3xpQ5gL6tigzRr4pUDs5BJcNTUkLMhOFB8CUlAWeqWpXLtrXctqDcVXLvswVdPszNYu7
	tfGooJQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tghoQ-0000000A8iq-0fM5;
	Sat, 08 Feb 2025 10:11:46 +0000
Date: Sat, 8 Feb 2025 10:11:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Heusel <christian@heusel.eu>,
	Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>,
	Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for
 FUSE/Flatpak related applications since v6.13
Message-ID: <Z6ct4bEdeZwmksxS@casper.infradead.org>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
 <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
 <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>

On Fri, Feb 07, 2025 at 04:22:56PM -0800, Joanne Koong wrote:
> > Thanks, Josef. I guess we can at least try to confirm we're on the right track.
> > Can anyone affected see if this (only compile tested) patch fixes the issue?
> > Created on top of 6.13.1.
> 
> This fixes the crash for me on 6.14.0-rc1. I ran the repro using
> Mantas's instructions for Obfuscate. I was able to trigger the crash
> on a clean build and then with this patch, I'm not seeing the crash
> anymore.

Since this patch fixes the bug, we're looking for one call to folio_put()
too many.  Is it possibly in fuse_try_move_page()?  In particular, this
one:

        /* Drop ref for ap->pages[] array */
        folio_put(oldfolio);

I don't know fuse very well.  Maybe this isn't it.

