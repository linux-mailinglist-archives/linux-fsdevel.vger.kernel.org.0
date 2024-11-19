Return-Path: <linux-fsdevel+bounces-35239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69C29D2E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3271F2340F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64F1D2716;
	Tue, 19 Nov 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EvgMhu7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF421547C8;
	Tue, 19 Nov 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042291; cv=none; b=deS2XUFwU8DyFTdhI6BdGkU0XbmcRPKCSqLvjTqkQsyxHsocKTHlg42+npbeIU2N0jUUMEGJ1wG3Xad5kB5Dpoe9reDaMjnKPwENgSkyXiwO6ydYezO/LmNTDDwqSdvhciaNgyXrC1epDdoJB3mk4QWfZX6T2UBErW43GwTeyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042291; c=relaxed/simple;
	bh=Izhsq75g18QbzihAstecc5RgQNcsQpWPvNlpSv5wY/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvjhgYgTKYnnJaYPNZukiKoy0G3SALgTI/KRTYlsVO9nNpWlZ16EzPRZNOOR8SF/5R2hgWKcDjnSoCrIad8XX9NhpZQWd0fuSTJ0wZPwwkkCZJLSl9ns2HI7P2k6dXSOuZkGEtpD0A5yLa3J8PHC9zvBS2cqHAlFXPS7sg04Q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EvgMhu7T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=89rXTlyvwZf7wy1AENCo71hFPFgxU7iIh40Yvq9+ziw=; b=EvgMhu7TluBgBeWrE8nDe71+fU
	A9TW71iacELiK7rlvJ+FONkzEyTxhuiOuOojwE55G0XCDYerbTnkDeLl21TLOOs+2Zv5qZrdn+wAK
	S2LNeIqWba4oXI3yV/0S2u79Hv5T5bi8jccGMw09kFvwWR1domGUK5TDPKA+3wRRWKtn6GqbJlS+f
	0vJTptsx3NpYYq/f1skl8VjkAZC5xpCI68xYV1zdM8Wkq9WZ4m59YG4Jh2/Ae88RhgFXOi9f2xEQ1
	+iT6gbvy7MPbJUG16lAJlFSsgkL3qzyp/Z0Spi/lcuKDtoAGlwrPDbLeV7s0TcUOdQr85sqRgXOrI
	YVUCngYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDTJr-00000004PU4-1HUc;
	Tue, 19 Nov 2024 18:51:23 +0000
Date: Tue, 19 Nov 2024 18:51:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, Liam.Howlett@oracle.com, vbabka@suse.cz,
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com,
	schalla@marvell.com, david@redhat.com, osalvador@suse.de,
	usama.anjum@collabora.com, andrii@kernel.org, ryan.roberts@arm.com,
	peterx@redhat.com, oleg@redhat.com, tandersen@netflix.com,
	rientjes@google.com, gthelen@google.com,
	linux-hardening@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFCv1 0/6] Page Detective
Message-ID: <ZzzeK8Fi_GlXPzjc@casper.infradead.org>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local>
 <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
 <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com>
 <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com>
 <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com>
 <CAG48ez0NzMbwnbvMO7KbUROZq5ne7fhiau49v7oyxwPrYL=P6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0NzMbwnbvMO7KbUROZq5ne7fhiau49v7oyxwPrYL=P6Q@mail.gmail.com>

On Tue, Nov 19, 2024 at 01:52:00PM +0100, Jann Horn wrote:
> > I will take reference, as we already do that for memcg purpose, but
> > have not included dump_page().
> 
> Note that taking a reference on the page does not make all of
> dump_page() fine; in particular, my understanding is that
> folio_mapping() requires that the page is locked in order to return a
> stable pointer, and some of the code in dump_mapping() would probably
> also require some other locks - probably at least on the inode and
> maybe also on the dentry, I think? Otherwise the inode's dentry list
> can probably change concurrently, and the dentry's name pointer can
> change too.

First important thing is that we snapshot the page.  So while we may
have a torn snapshot of the page, it can't change under us any more,
so we don't have to worry about it being swizzled one way and then
swizzled back.

Second thing is that I think using folio_mapping() is actually wrong.
We don't want the swap mapping if it's an anon page that's in the
swapcache.  We'd be fine just doing mapping = folio->mapping (we'd need
to add a check for movable, but I think that's fine).  Anyway, we know
the folio isn't ksm or anon at the point that we call dump_mapping()
because there's a chain of "else" statements.  So I think we're fine
because we can't switch between anon & file while holding a refcount.

Having a refcount on the folio will prevent the folio from being allocated
to anything else again.  It will not protect the mapping from being torn
down (the folio can be truncated from the mapping, then the mapping can
be freed, and the memory reused).  As you say, the dentry can be renamed
as well.

This patch series makes me nervous.  I'd rather see it done as a bpf
script or drgn script, but if it is going to be done in C, I'd really
like to see more auditing of the safety here.  It feels like the kind
of hack that one deploys internally to debug a hard-to-hit condition,
rather than the kind of code that we like to ship upstream.

