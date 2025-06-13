Return-Path: <linux-fsdevel+bounces-51550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B72AD82B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC63188F87C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83E24E4A8;
	Fri, 13 Jun 2025 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nHpDQdSK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B92F4311;
	Fri, 13 Jun 2025 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793563; cv=none; b=q+S2jxZ/Y7OMrAOHsdXy6ZFaBQI7GcJVMm9GfpYU1Jwv4r1OpyTeeRs1PgwwcqZnbmkc+GByGrJ24fxK4EHxBTaPKV9uai5p/oiPjy8GzrMuOWXjrgVuV8NwAgRvnLOJ2YK6atNiixminJDvZWSnR5kIDPvfuBzbDD0wMyvqOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793563; c=relaxed/simple;
	bh=4fqXpc97924wJoXA7QsMhZJWFlxSbs6Egk6EObeBVt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2YtYLswllJP5yngJUlVXF7T8RjIPeRH5WDhyHvENFJTG8j7YIMWy4Aw4WinNwUp3hq4E5X8KnTw56BTP6P3wEy6wrWBRbLFuuoBSfGmNdE0F0pmfsal+YT2ocTQT91c53liNLtuFvA21ZLCNWLk0s0TkRPvBNJw6AzpkIUPPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nHpDQdSK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sOp91Em8OeLhPgudK3PqHU28W38RB+5KU7SLvqrKdFQ=; b=nHpDQdSKnTK+Jo9Sf0vA/zABiE
	bThJyvuNBM0GCoP9k67NguGuJr5gNqAekPeRfejrm7GGh6cGvnW8lXTIdrlPP+mVz4gg7OJud148A
	W24f3QGC2PHcjk0JAb6DmHoOqX/9Dfj/4CDM6IcjyIITWbkyKIAt+WhS1yKDKg7bLgxeh3M3m6s/7
	t2f3dQBGsYUTw9KGM+MNY3M3Z0X1GW2KKxnN0bSuqltAPgB6disdhmxuwEzfyIC1lerl3FtxbfXdt
	+xiKefUSpYG95mIWUXWOy1aX/EX1CGOEU7T1DNvsOUwDm4yppKoRAiYrv3d0V6GunAYr8NoKNtvm3
	ppgLKi+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPxEn-0000000FQFG-0uri;
	Fri, 13 Jun 2025 05:46:01 +0000
Date: Thu, 12 Jun 2025 22:46:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aEu7GSa7HRNNVJVA@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 12, 2025 at 12:22:42PM -0400, Jeff Layton wrote:
> If you're against the idea, I won't waste my time.
> 
> It would require some fairly hefty rejiggering of the receive code. The
> v4 part would be pretty nightmarish to work out too since you'd have to
> decode the compound as you receive to tell where the next op starts.
> 
> The potential for corruption with unaligned writes is also pretty
> nasty.

Maybe I'm missing an improvement to the receive buffer handling in modern
network hardware, but AFAIK this still would only help you to align the
sunrpc data buffer to page boundaries, but avoid the data copy from the
hardware receive buffer to the sunrpc data buffer as you still don't have
hardware header splitting.

And I don't even know what this is supposed to buy the nfs server.
Direct I/O writes need to have the proper file offset alignment, but as
far as Linux is concerned we don't require any memory alignment.  Most
storage hardware has requirements for the memory alignment that we pass
on, but typically that's just a dword (4-byte) alignment, which matches
the alignment sunrpc wants for most XDR data structures anyway.  So what
additional alignment is actually needed for support direct I/O writes
assuming that is the goal?  (I might also simply misunderstand the
problem).

