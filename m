Return-Path: <linux-fsdevel+bounces-27872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3E196496C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E001C247C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82A1B3B3E;
	Thu, 29 Aug 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2ZH+cca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813B1B3753
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943908; cv=none; b=c/av8QBxM/tkO216NaV+KfSDksNmdm4fDqHABTUD1CCSOhpENvsoRImW04RyLz2p1PXvjGpifm1Nfs4fuUtKEFBKboOtWa9/f0FQ4JudrKrxwAIs1Yy5Ihi4Vos5dYJndQnij1vNLlt05N3vLr7tZxQlJXWzYXzvoop7EtYMtB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943908; c=relaxed/simple;
	bh=hkK67Pa+UTw8SgpZObrB4L+YTrQEfv0f5ogPxL9+SAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIxJY71vf4u3azxG1Br1ZKCsukRv95RsNEcCp36dit6qApUjbyB2KIk3FgHWdBzRnalR8vo9EFVGscxh7/cLdej59fMwnLt7UoK970UIbg77ZX5EplpyfgHO/B9/yj1M8aaNbmbi5L3INaC1lGvTRs6SJ/y90kckDtXJQGdhqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2ZH+cca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724943905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEtXAsylG9E/XUImBTmGYjj17sWH4GzEv027Gz5kyGg=;
	b=c2ZH+ccan8Hbir84r1OwapWJWED81GYGYROwFO+r8daBMn5n+wTTxXswcR4kiHIDK443v4
	lxFXVENKgWx2WyPDcQREasPA/uympoE80SM0s4nxUX+62JQjSaY789/bDIIGA9X2xsdsZP
	OV1rAxJ6xr0ecWrC0blkqAfNK7VKVXY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-enIIUyQGMdaCy63USwkcUQ-1; Thu,
 29 Aug 2024 11:05:03 -0400
X-MC-Unique: enIIUyQGMdaCy63USwkcUQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34F6A1955BFA;
	Thu, 29 Aug 2024 15:05:01 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.95])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B42B919560AA;
	Thu, 29 Aug 2024 15:04:59 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:05:59 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org, josef@toxicpanda.com, david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <ZtCOVzK4KlPbcnk_@bfoster>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
 <Zs1uHoemE7jHQ2bw@infradead.org>
 <Zs3hTiXLtuwXkYgU@bfoster>
 <Zs6oY91eFfaFVrMw@infradead.org>
 <Zs8Zo3V1G3NAQEnK@bfoster>
 <ZtAKJH_NGhjxFQHa@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtAKJH_NGhjxFQHa@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Aug 28, 2024 at 10:41:56PM -0700, Christoph Hellwig wrote:
> On Wed, Aug 28, 2024 at 08:35:47AM -0400, Brian Foster wrote:
> > Yeah, it was buried in a separate review around potentially killing off
> > iomap_truncate_page():
> > 
> > https://lore.kernel.org/linux-fsdevel/ZlxUpYvb9dlOHFR3@bfoster/
> > 
> > The idea is pretty simple.. use the same kind of check this patch does
> > for doing a flush, but instead open code and isolate it to
> > iomap_truncate_page() so we can just default to doing the buffered write
> > instead.
> > 
> > Note that I don't think this replaces the need for patch 1, but it might
> > arguably make further optimization of the flush kind of pointless
> > because I'm not sure zero range would ever be called from somewhere that
> > doesn't flush already.
> > 
> > The tradeoffs I can think of are this might introduce some false
> > positives where an EOF folio might be dirty but a sub-folio size block
> > backing EOF might be clean, and again that callers like truncate and
> > write extension would need to both truncate the eof page and zero the
> > broader post-eof range. Neither of those seem all that significant to
> > me, but just my .02.
> 
> Looking at that patch and your current series I kinda like not having
> to deal with the dirty caches in the loop, and in fact I'd also prefer
> to not do any writeback from the low-level zero helpers if we can.
> That is not doing your patch 1 but instead auditing the callers if
> any of them needs them and documenting the expectation.
> 

I agree this seems better in some ways, but I don't like complicating or
putting more responsibility on the callers. I think if we had a high
level iomap function that wrapped a combination of this proposed variant
of truncate_page() and zero_range() for general inode size changes, that
might alleviate that concern.

Otherwise IME even if we audited and fixed all callers today, over time
we'll just reintroduce the same sorts of errors if the low level
mechanisms aren't made to function correctly.

> But please let Dave and Darrick chime in first before investing any
> work into this.
> 
> 

Based on the feedback to v2, it sounds like there's general consensus on
the approach modulo some code factoring discussion. Unless there is
objection, I think I'll stick with that for now for the sake of progress
and keep this option in mind on the back burner. None of this is really
that hard to change if we come up with something better.

Brian


