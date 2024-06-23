Return-Path: <linux-fsdevel+bounces-22217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CCD913EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 00:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377E11F2215D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021A1850A7;
	Sun, 23 Jun 2024 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ulZaUDdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D465C
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jun 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719181304; cv=none; b=aR0S/2pUUc/TgHItGDC2ag6c2u1bRy0jfOnaUEk5cj0DvogjoPkRd9ZqGjeVIA1A9A2/9rRPFIrY0sEeOkxu00A60qq22mwubYf7/noG4mM/a1pV1uu1MKJfYmIdPEN6smOhvZeEOWYTcbFQMAEvE+B9LGHa+A9RQC7KQV+OpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719181304; c=relaxed/simple;
	bh=x2M0dauBDgLmWJN4BZ2ljTFOGUMdXPNE3BjYI9oO65A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtzTvMlEBLo630iaIEH3vyr/GAUVoJVlLnU9PfWgCYUe8ULkhu+Bx5kq71BEjlf38Z7tkWsikp/AYBdV9MtXfNGaPOZadzqkLD8U4gTvceqG73cFHMdx9k/4VU8+si/gPEVyYHVs74BqMXjT5fsWPlY7bBorJQCHOzLxza41laI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ulZaUDdR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tglx@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719181300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmWP1icMJZcxscx4T7pr7aUXM8WbtI7ppH47QYQ42+0=;
	b=ulZaUDdRAdR0NGqH4EqH3ur2XkUNiW/qVDr5iGUw65QVgOqy77v6MABJkgVEmY5Hu6u6H8
	wFmaljExGf12YVaYSvRWiESnuHHxyFERLyBhb519bu3MbDW+YkJezhBJleg+uCrK58wSfv
	Hz3Enxb5zVv9fcBUEk+Bjx1eKYXmdc0=
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: josef@toxicpanda.com
Date: Sun, 23 Jun 2024 18:21:36 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, linux-mm@kvack.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/5] fs: sys_ringbuffer
Message-ID: <odohwdryb2yhzi5kzvlwv65kazbhzqyps6fzr2wukksdewukmr@gono7fdsth5d>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
 <20240603003306.2030491-4-kent.overstreet@linux.dev>
 <87frt39ujz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frt39ujz.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 12:13:36AM +0200, Thomas Gleixner wrote:
> Kent!
> 
> On Sun, Jun 02 2024 at 20:33, Kent Overstreet wrote:
> > +/*
> > + * ringbuffer_ptrs - head and tail pointers for a ringbuffer, mappped to
> > + * userspace:
> > + */
> > +struct ringbuffer_ptrs {
> 
> The naming is confusing. ringbuffer_ctrl or something like that would be
> more clear because it's more than just the pointers, which are in fact
> positions. You have size, mask ... too, no?

I like that name, yeah.

> > +	/*
> > +	 * We use u32s because this type is shared between the kernel and
> > +	 * userspace - ulong/size_t won't work here, we might be 32bit userland
> > +	 * and 64 bit kernel, and u64 would be preferable (reduced probability
> > +	 * of ABA) but not all architectures can atomically read/write to a u64;
> > +	 * we need to avoid torn reads/writes.
> 
> union rbmagic {
> 	u64	__val64;
>         struct {
>                 // TOOTIRED: Add big/little endian voodoo
> 	        u32	__val32;
>                 u32	__unused;
>         };
> };
> 
> Plus a bunch of accessors which depend on BITS_PER_LONG, no?

Not sure I follow?

I know biendian machines exist, but I've never heard of both big and
little endian being used at the same time. Nor why we'd care about
BITS_PER_LONG? This just uses fixed size integer types.

