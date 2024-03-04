Return-Path: <linux-fsdevel+bounces-13410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F986F7FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 01:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27FD1C20AB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 00:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EC438B;
	Mon,  4 Mar 2024 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EivKppns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48007385
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709512526; cv=none; b=Xl5VGuGtgSv4kbT6UHhyQIAMoqt2j2CNC/fzhKWtC2QiQnhVoKXWZe87BCeGn22ZT4rFAqoIY907GFFOioV7IAsJ0R1Q3sqAb+exY8IwTnGymNRo/qFaNfxO4SFGmD113Ha0nZnjKbYfuyP62CRT3frNh8EInVhPw3EJSR8KDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709512526; c=relaxed/simple;
	bh=arvYeDpUORR1cZFLl/VuzxXtTl0IBxmrbd5derRF8yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkkrMU8oqF3eVL8m6yKNU6GzlBtdQgunt9wrpxoK303oNTEt2XzFgNt1ts7wM08+hWFnc6mWyIyYqk18/Pr6oWJ3xvjnXZnP+/tdUGM8JEvj8Y+qmpGnf4siFXEv21s8P1VRArlgZ6IyVRBTbs/+U6PwkF0juOrW9LK+zUMs+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EivKppns; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zaZmGutyO121MYVQQw/hfLZRSJAhEIRFLCywTeF9lFg=; b=EivKppnsAWxl4MrnKX2BtjzwLj
	VFHLQG4M9oSpAznJnRkVCFqZbNYbXMELlYpU0Ydi1rFwr8alOj7FD4jYp1DhqA3riXnQwaz5XTYl+
	Li1DggJVDIzcvzBHhIU3NUEv9GfYNRSLT3+wxCn2I1YcsnnuheEJfWypgRazZeLcptTNYBT7Pt5mQ
	1F5rOCvVME6wV7GKhCG8/7CvKntNpkg8TG/NvqyzwFfOIs6j3Xxirr4aW+GeSDkNu6OzZzl8rSXlY
	N7ey3tlYQoQoAItzWFdlc+//CXsuguGf9lmr3aTu0nrLOArFIIt4nvujR+T4HluLN20lK+jnvo9sm
	XZx+t+pw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgwIL-000000003UI-1QdC;
	Mon, 04 Mar 2024 00:35:05 +0000
Date: Mon, 4 Mar 2024 00:35:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <ZeUXORziOwkuB-tP@casper.infradead.org>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170950594802.24797.17587526251920021411@noble.neil.brown.name>

On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> I have in mind a more explicit statement of how much waiting is
> acceptable.
> 
> GFP_NOFAIL - wait indefinitely
> GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
> GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
>             don't wait indefinitely.  May abort more quickly if fatal
>             signal is pending.
> GFP_NO_RETRY - only try things once.  This may sleep, but will give up
>             fairly quickly.  Either deadlock is a significant
>             possibility, or alternate strategy is fairly cheap.
> GFP_ATOMIC - don't sleep - same as current.

I don't think these should be GFP flags.  Rather, these should be
context flags (and indeed, they're mutually exclusive, so this is a
small integer to represent where we are on the spectrum).  That is
we want code to do

void *alloc_foo(void)
{
	return init_foo(kmalloc(256, GFP_MOVABLE));
}

void submit_foo(void)
{
	spin_lock(&submit_lock);
	flags = memalloc_set_atomic();
	__submit_foo(alloc_foo());
	memalloc_restore_flags(flags);
	spin_unlock(&submit_lock);
}

struct foo *prealloc_foo(void)
{
	return alloc_foo();
}

... for various degrees of complexity.  That is, the _location_ of memory
is allocation site knowledge, but how hard to try is _path_ dependent,
and not known at the allocation site because it doesn't know what locks
are held.

