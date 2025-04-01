Return-Path: <linux-fsdevel+bounces-45463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223F7A7806B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 18:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18267166158
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCB2046B2;
	Tue,  1 Apr 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fj+uYHb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB0A194C96
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524808; cv=none; b=R7LzI6nOzYnf/LgVikmGgnguGlArgEpdB6PCBN/kqHda11fXs58DzCCLJAgkjDK/5rBuljbrY1C05osfx5gDxcmiegEmYOGNze+mPhKlYwnDva0pi/BkjA0kun5juWsvmVCuGz99kOAnv+QIsF0PDOGTG3+fmE7ANxTvfKcSNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524808; c=relaxed/simple;
	bh=oCgpZCYGZ7/G514TH5UZ9pZUQv763Mqmff8BhwdfrDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKnUKEpAHS7ypjk6L7jhEEsj3sf0SREc5u9t5a28N4YxQAZGqslJ727Nl+DfMA2Ja7eKe7tmBGI60BNYx4PRdbx9/pw/f5fY2MYeYho8HemHWxkmk5A6bZBghln5E//gW66LTZnFsvpdeXhcXgFfT+f31BpX+ps/gtCMNqmL1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fj+uYHb+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LNObDbT4ATxiT4jSsqJRv32cSZfqzQ9KW0j8T6d9+NE=; b=Fj+uYHb+jju1ndZ3029s90cXHJ
	RjOZokodxO+o8OZVrk6AydFnf0CTEyq0g1K/rpjgoFZhSJag7dBNSYmOjwNiFay88aHcbxNSrBFDm
	A801t3F9NemVnDQAYUTGQ4rWAHZwebMcwF5QUbgdrEDA3HRU4iYyL4ZFQ9zm3Gc1K/51AwaGOdNUL
	MsJcoDB06ZRPica41iZmYHoWFNNtiPCzrCssrlP2qSN6BLfVouUhhnAmmNMjpPuQj1FIEhKTajgsN
	AUTE5zQGuSUNhoAiry4WwmiEATZJmbBWelTvz8jcKNCckGHwz50bGISpQaB75mzLlC3Aq/DbApwRW
	b7I7P7QA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzeRn-00000007dTF-1bdv;
	Tue, 01 Apr 2025 16:26:43 +0000
Date: Tue, 1 Apr 2025 17:26:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 11/11] fs: Remove aops->writepage
Message-ID: <Z-wTw5p5r4yPGfFE@casper.infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-12-willy@infradead.org>
 <Z9d2JH33sLeCuzfE@fan>
 <Z9eVdplZKs2XVB9J@casper.infradead.org>
 <Z9iibbHs-jHTu7LP@casper.infradead.org>
 <9937a6346feccb7ab739aff63a084f63f3ad4382.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9937a6346feccb7ab739aff63a084f63f3ad4382.camel@linux.intel.com>

On Tue, Mar 18, 2025 at 09:10:38AM +0100, Thomas Hellström wrote:
> On Mon, 2025-03-17 at 22:30 +0000, Matthew Wilcox wrote:
> > This patch fixes the compilation problem.  But I don't understand why
> > it's messing with the reclaim flag.  Thomas, can you explain?
> 
> Hi, Sorry for not responding earlier. The patch that uses writepage()
> here has been around for quite some time waiting for reviews / acks so
> I failed to notice that it's going away.

My turn to be sorry for dropping this conversation ...

> Anyway the reclaim flag clearing follows that of pageout() in vmscan.c
> which was also the case for the i915_gem_shmem.c usage in
> __shmem_writeback(). My understanding was that if the writeback was
> already completed at that point, the reclaim flag was no longer
> desirable.

I think the question is really why you're setting it in the first place.
Setting the reclaim flag indicates that you want the folio removed from
the page cache as soon as possible.  Other changes in flight are about
to make this more aggressive --  instead of waiting for the folio to
reach the end of the writeout queue, it'll be removed upon I/O completion.

It doesn't seem to me that this is what you actually want for TTM,
but perhaps I've misunderstood the intent of the code.

