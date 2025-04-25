Return-Path: <linux-fsdevel+bounces-47410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98524A9D204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 21:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BB64637DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD1221739;
	Fri, 25 Apr 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sgZkY3nA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646322127B;
	Fri, 25 Apr 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610041; cv=none; b=EcIJNdHGA7TVejdQRteCrg2QqllhlMsabEAStskGhWu2RQ1UfxepANDowDhJ7IUdMVKOh55BE7WecUQVAwKDaH6XAajkWczzAmy5jR7tI3WxKpA15RPKSasnGL/VRD3kHsXPz8xokVu8RGZrUI4iFcQZouPYAj3vYz6WGLNvx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610041; c=relaxed/simple;
	bh=VREBMwvCQDoCqN5IaoNLR4E6gOht5nf7Iss06swoSpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAq7NRkNHrVC45cb2mVo1344TVgQRUVe0nBFxj473yrf2lFeJ7b548HGHeP3W/OteTm8W5HC7ZWocRuF2xdRkcKc++bkqxzItrYhFY7yBjuVjncknuQWWJIDT/kMjHDABMoY0PVRGSYkKFEtofZT5q+Nfgm5WOy0gQtomzo6exM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sgZkY3nA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0IqPKkbdUdZ451fkPgHg1pO5T9dqWYEu1XP1uzcPCQM=; b=sgZkY3nAXGKtwBXBJpGhw1vyQo
	bTv7jBF+rb1DEEL5o2mS0dEaUgetDPnVh+ZRpABvOBCk7CHlPCvIZ34/e3vzuJNGGF+j/1ILkrdFA
	Fp2YJ7/Xpim/rQejdgx919L7WqBAlH+YLVGcjzmHhlVjM+POawrb8vuzBeXVL1QDe6+GIf8oUrKU1
	n+dEgYFebNeGUhz10W7HWEpn3abHo2zX3pHK6o4t7Sb3ws+k5aeQjK/MjbM0EKvPte6UpECfMkGN7
	2YM4R0dvokIG0uuxfKarPWcxD/rKYcTEO+P4hmLDHKn8PtwN5dctUF4zutNse14szoSgTD1Ll38mp
	n+pCFj3w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8OuZ-0000000FNE7-3is7;
	Fri, 25 Apr 2025 19:40:35 +0000
Date: Fri, 25 Apr 2025 20:40:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <aAvlM1G1k94kvCs9@casper.infradead.org>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>

On Fri, Apr 25, 2025 at 09:35:27AM -0700, Linus Torvalds wrote:
> Now, if filesystem people were to see the light, and have a proper and
> well-designed case insensitivity, that might change. But I've never
> seen even a *whiff* of that. I have only seen bad code that
> understands neither how UTF-8 works, nor how unicode works (or rather:
> how unicode does *not* work - code that uses the unicode comparison
> functions without a deeper understanding of what the implications
> are).
> 
> Your comments blaming unicode is only another sign of that.
> 
> Because no, the problem with bad case folding isn't in unicode.
> 
> It's in filesystem people who didn't understand - and still don't,
> after decades - that you MUST NOT just blindly follow some external
> case folding table that you don't understand and that can change over
> time.

I think this is something that NTFS actually got right.  Each filesystem
carries with it a 128KiB table that maps each codepoint to its
case-insensitive equivalent.  So there's no ambiguity about "which
version of the unicode standard are we using", "Does the user care
about Turkish language rules?", "Is Aachen a German or Danish word?".
The sysadmin specified all that when they created the filesystem, and it
doesn't matter what the Unicode standard changes in the future; if you
need to change how the filesystem sorts things, you can update the table.

It's not the perfect solution, but it might be the least-bad one I've
seen.

