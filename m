Return-Path: <linux-fsdevel+bounces-13130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB08E86B869
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 20:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7BD1F21988
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAFF15F30A;
	Wed, 28 Feb 2024 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fw23fKiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784D15E5D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149084; cv=none; b=dpZGehJlJgegxJiA2uH/HfRoAwTSMkcOfmL5p10eo+rmDamjVFGyQcJ4EofsGyL8bIoeEaq0k7m/lyJC3JxvK+l87S/gHpLVNPTvAd5uuIqoZ+PvGQMEZvIuL+uUxJmUvEkAamGPGNpFaYG1xV9fEuj3kxbI7BWYeWPbDIylRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149084; c=relaxed/simple;
	bh=2HmxLDVJbI8So6OIequCMHgfO08YTmBLONcuLm46RNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDH9Y07fKgS30Y3N46m7k81xcsfvtTUf3SRo8e4FWonLB/FXrS8yJv/gWBIDizPE5WSPlwh2WgIWMNKviR1KvKEA0qe5N4HXXixDEYAhzwVp2+doGB7t0yVevR4o7qcvRl1sGotu5AGxOnqsp8w1uTCFXsDBpJts6lyHdcUgg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fw23fKiv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3bitNwsNUQtvL4clG/gQllWxq/ktd5g1prsDm36+c7U=; b=fw23fKivUso0nrN7IX48yB2MFq
	v58/vrqI0g7FXF3hCKTBT34s7A0u3nwl7pwtMilLM/ntPnCg/TYwP6eYf1IAsleW2TKYbH7cveTTH
	JAqAWtRECINpOzrzU3CsISMJgJAwHNHQ7VuhvwuI5lrza5gieZtErg4r3c+rJZgXxACpFAGCi8rsl
	GzrTRxvIyD16O8/jJ91M7vpqK2idTNjK3Ypd/xu5zoIFEOc9MMJ1MIjaYQCyblju9K5g2zbCPzddh
	vCLH94yQNkqBa3YBkgiEvNelbCscBJ3pEZ5p6DIOWkXF1UB28ePZSCOEdY/wPvYpJy/ur8bf8jz+o
	hyXfCP8A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfPkc-000000061uw-0uvg;
	Wed, 28 Feb 2024 19:37:58 +0000
Date: Wed, 28 Feb 2024 19:37:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: paulmck@kernel.org, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <Zd-LljY351NCrrCP@casper.infradead.org>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>

On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > Recent discussions [1] suggest that greater mutual understanding between
> > memory reclaim on the one hand and RCU on the other might be in order.
> >
> > One possibility would be an open discussion.  If it would help, I would
> > be happy to describe how RCU reacts and responds to heavy load, along with
> > some ways that RCU's reactions and responses could be enhanced if needed.
> >
> 
> Adding fsdevel as this should probably be a cross track session.

Perhaps broaden this slightly.  On the THP Cabal call we just had a
conversation about the requirements on filesystems in the writeback
path.  We currently tell filesystem authors that the entire writeback
path must avoid allocating memory in order to prevent deadlock (or use
GFP_MEMALLOC).  Is this appropriate?  It's a lot of work to assure that
writing pagecache back will not allocate memory in, eg, the network stack,
the device driver, and any other layers the write must traverse.

With the removal of ->writepage from vmscan, perhaps we can make
filesystem authors lives easier by relaxing this requirement as pagecache
should be cleaned long before we get to reclaiming it.

I don't think there's anything to be done about swapping anon memory.
We probably don't want to proactively write anon memory to swap, so by
the time we're in ->swap_rw we really are low on memory.

