Return-Path: <linux-fsdevel+bounces-55146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F01B074E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3D7A0135
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710242F433C;
	Wed, 16 Jul 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3gFkJTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48522F3C1A;
	Wed, 16 Jul 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665801; cv=none; b=e1ydUnGPZ0bIzoPKS8kjJJ0s0yahS4WSrEa03NlBE7F7yp9EapcgeJJobD/ojSn7OEqcrS/d8EZXFzVpGGFR77hhZyeMe5SE2s9lR5/iIiTQ43Bm229YCURaekciraIwVJmZ63jK20kXEtvbp4luuGzQcR1lIvfqbpDpHh4NZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665801; c=relaxed/simple;
	bh=c0DQTu7/VfsTFc9UXQ4uKFq97+Z2GpfJts788IUFlU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hevrGIYW/dMAzjnJRoBLXopRaQg7wXkOgwD3yPr5EBxFYs/TT+TO8+6h3jEl24U0RRlHDSq3b6tiFBbBOKS6Lo1TSwcxUTFJW3FlqknMQl+sc60+1lGF0EvIx5+PGuwox8j0EKOUKoNIhh+a866odBrtix8zSf/EAaL7j3993UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i3gFkJTJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IfRmjwGtRP6oQ8KDbKEpggcGnwljF/EmhtdDL5jBVQw=; b=i3gFkJTJfYS1ekfShQMpLaepU5
	FnpJmCYB9e0gHP1WTbAtXyzG8pvxx2occdnfdtORm2PM2Ajgux/FnN86FElBG3qwyLi1q/tsSqQX9
	ZE/GHfam/po8RharCeTb56QYK8RHqgcpzG21HIR0Mk2fxdn9SqYUqCitQbI4oIezl2CtbooMZEYMU
	QhdYFq5DW9gdNaEWvQ/d8D7WhGy06ABQTdmeg/khiSCfdVEykbj+ZN4W2/hguH9iLkyXvFxnAdPRG
	odbAulxDKrID1PCemT7MDINWHv+dBNuV6pELRiZL29huOHbnaXW3xHJaG7PxvrGljUUjyLaOcb9di
	UXEHqDdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc0RC-00000007ZgG-1yzg;
	Wed, 16 Jul 2025 11:36:38 +0000
Date: Wed, 16 Jul 2025 04:36:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <aHeOxh_yaQGFVVwM@infradead.org>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
 <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
 <aHdE9zgr_vjQlpwH@infradead.org>
 <20250716101207-c4201cef-abbe-481d-bca5-c2b27f324506@linutronix.de>
 <aHeIyNmIYsKkBktV@infradead.org>
 <20250716132337-ee01c8f1-0942-4d45-a906-67d4884a765e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716132337-ee01c8f1-0942-4d45-a906-67d4884a765e@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 16, 2025 at 01:33:05PM +0200, Thomas Weißschuh wrote:
> On Wed, Jul 16, 2025 at 04:11:04AM -0700, Christoph Hellwig wrote:
> > On Wed, Jul 16, 2025 at 10:39:57AM +0200, Thomas Weißschuh wrote:
> > > Let's take kernel_execve() as example, there is no way around using this
> > > function in one way or another. It only has two existing callers.
> > > init/main.c: It is completely unsuitable for this usecase.
> > > kernel/umh.c: It is also what Al suggested and I am all for it.
> > > Unfortunately it is missing features. Citation from my response to Al:
> > 
> > But why does the code that calls it need to be modular?  I get why
> > the actual test cases should be modular, but the core test runner is
> > small and needs a lot of kernel internals.  Just require it to be
> > built-in and all this mess goes away.
> 
> KUnit UAPI calls into KUnit proper which itself is modular.
> As such it needs to be modular, too.

Not if you depend on KUNIT=y.

> > That being said some of this stuff, like get_fs_type / put_filesystem
> > or replace_fd seem like the wrong level of abstractions for something
> > running tests anyway.
> 
> This was modelled after usermode helper and usermode driver.
> To me it makes sense, and I don't see an obvious way to get rid of these.
> 
> Or do you mean to introduce a new in-core helper to abstract this away?
> Then everybody would need to pay the cost for this helper even if it is only
> used from some modular code.

I have no idea what you are doing as you only Cc'ed the exports patch
but not the actual work to the mailing lists, so I have no way of
helping you with the actual code.  I can just tell you my gut feeling
based on the symbols, and they are something that doesn't feel outside
of very core code.


