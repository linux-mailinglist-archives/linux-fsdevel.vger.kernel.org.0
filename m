Return-Path: <linux-fsdevel+bounces-10986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E784F9B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD092876F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032A8286C;
	Fri,  9 Feb 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Yp9lhmRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68318002E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496513; cv=none; b=lYWy8FnM2rcDlyR00h/q9ygoseyiKGvJdYihf24rncFPhFM/4HCaEDRRFULFBO2zEhgf0dIg5w+IyooRAC1wUSr9OcYCxvlOwEZ1b10lBgYcAKQPr/aAIg5hYpLt0SrNfXuzQPiGmPLIw56jy1hDXlT6ODYxKLqsMqDKPRp7CXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496513; c=relaxed/simple;
	bh=rcmKxtCWgen+51tfK1s4ekAWrSQQ536KWinqAljlu3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSWrxBEi3InjGBXlO44wc6xWE9OteJyCXloPfP2KgPfktwtnAd4w84uNHVDtXRGqulefxm6l8dTRS6RCtKSECs0yVRBBGH30WFByaQK/l7EO2fEURZSukgv1iBW8VgPVA9/TrYqa+dg/Cr8qk90Q5hNdcEJimjKYqMGAEwgubUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Yp9lhmRE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N2MtT0b9GQrwhFBxJh/SFUhEDzi6fb2qln/x4hIaZc8=; b=Yp9lhmREf54CosfhhuiUrydjwU
	+FD6wJgcp0MmB6r3w7G9nBYaCZlMHSYcoCh0y1Y4VZY1LWKFup+fmYNTZBRAAgjX/vsxdyg2d8IjO
	nrwP9QbPLNouMKalzytSAkj6TkAC0dVssSBj82C0kWM4JuX6+jQzRut2wonWjYvplod2rdukQi9xT
	MAdf+eHZ0yUsVebudUqCU/S5e5lnKWiStTA3l8FDo9Ar7boxd9W5DXbTlsHNdLCtNvjiC9cN9vFVy
	OjJIewYcb/KhbREjl7cKpv5WolkhZHqi6DDouZy0R0S9OiNVJNOdCj7zxhWA0w41eXPZLo06nC4x8
	K0uYwGpQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rYTqA-004JQW-1G;
	Fri, 09 Feb 2024 16:35:02 +0000
Date: Fri, 9 Feb 2024 16:35:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Christian Brauner <brauner@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] [RFC] fs: prefer kfree_rcu() in fasync_remove_entry()
Message-ID: <20240209163502.GC608142@ZenIV>
References: <20240209125220.330383-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209125220.330383-1-dmantipov@yandex.ru>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 09, 2024 at 03:52:19PM +0300, Dmitry Antipov wrote:
> In 'fasync_remove_entry()', prefer 'kfree_rcu()' over 'call_rcu()' with dummy
> 'fasync_free_rcu()' callback. This is mostly intended in attempt to fix weird
> https://syzkaller.appspot.com/bug?id=6a64ad907e361e49e92d1c4c114128a1bda2ed7f,
> where kmemleak may consider 'fa' as unreferenced during RCU grace period. See
> https://lore.kernel.org/stable/20230930174657.800551-1-joel@joelfernandes.org
> as well. Comments are highly appreciated.

That should go with mentioning that _these_ _days_ kfree() can be paired with
kmem_cache_alloc().  A reference to ae65a5211d90 "mm/slab: document kfree() as
allowed for kmem_cache_alloc() objects" might be a good idea; at the very least
it *must* come with "don't even think of backporting to any kernel that still
has SLOB support (i.e. anything prior to 6.4)".

Not sure if it's a good idea at this point - it doesn't look like it would get
mixed into anything that might need backporting, but...

