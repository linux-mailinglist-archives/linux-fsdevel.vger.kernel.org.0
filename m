Return-Path: <linux-fsdevel+bounces-71379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F96CCC0A00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 03:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A54A33021FA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 02:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3612E92BA;
	Tue, 16 Dec 2025 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DypHeXhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13A261593;
	Tue, 16 Dec 2025 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852936; cv=none; b=NEMa6XDXrvWtimbnSwXBm9rb0FtZo62qM9z6TLcX/abkTQuB3DH/td/ZgRsKCpA0YDnUKez2kkVMLz6tNSXLM+FWwLwm52aRbthL4M4tXEJXOG5BTG5F0T2C5/uBoz5cf1cb8wXOqIREdmGdBQo/mk9nAhdrmeVv6RZYbLld+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852936; c=relaxed/simple;
	bh=0m4W044tWow/sa1/oEMPL5EiVteSVQLyeQxj5r1K0qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpPEL586mWAN5yb/oaLQ1dZWZylY9O0H4Ot/u0xnRpZXxAkV4sqrBvDOzTFTfuofwl+OgOtkmqLm8MR2bEvKyz3aMVhVH1aFPkJz5Chz8wap7vNOQ/IlkDZsdf3pR1MbuJlgD9foPYAooMltbd9hzl7wKGVUKSezE5pDB42sNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DypHeXhf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=McLudrjs2j6oX0GPBfhtmrgo6TzeswArw6lwH1JBWU0=; b=DypHeXhfBLS8DsrvCzzfWPCmyo
	LLz7DvZamsbgfncd7ffQpFwKyyb+K3KiInYuOjGOkzv5lJUd9Z4MC7ymef+8DbKq2+yofAiXiaLHY
	WHf6YJjWwab3i1lurZm/N0lDii/Lkbc65Tb0oLqCWuOTKLNkiXOwvxjdmhapfF0R70aYK0FUVsAEz
	wGNuctd9DUl+1ce5B8r8NX4vpluy5jm9XqsUwtNvHZLhOSwfbfGVPQoLa8lpLgofcdWfrf2BbG3pg
	NXAFUbRBKJ7JPhv1URgED6qsgafY8bGOSm6WIVfahsUE+ekfZUTc97+iwdaiMK6QuRXXiBBiSgMd/
	nDz3kgZw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVL0o-00000002iNY-13t1;
	Tue, 16 Dec 2025 02:42:06 +0000
Date: Tue, 16 Dec 2025 02:42:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUDG_vVdM03PyVYs@casper.infradead.org>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
 <aUAZn1ituYtbCEdd@casper.infradead.org>
 <aUC32PJZWFayGO-X@ndev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUC32PJZWFayGO-X@ndev>

On Tue, Dec 16, 2025 at 09:37:51AM +0800, Jinchao Wang wrote:
> On Mon, Dec 15, 2025 at 02:22:23PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 15, 2025 at 10:19:00PM +0800, Jinchao Wang wrote:
> > > page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
> > > constraints before taking the invalidate lock, allowing concurrent changes to
> > > violate page cache invariants.
> > > 
> > > Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
> > > allocations respect the mapping constraints.
> > 
> > Why are the mapping folio size constraints being changed?  They're
> > supposed to be set at inode instantiation and then never changed.
> 
> They can change after instantiation for block devices. In the syzbot repro:
>   blkdev_ioctl() -> blkdev_bszset() -> set_blocksize() ->
>   mapping_set_folio_min_order()

Oh, this is just syzbot doing stupid things.  We should probably make
blkdev_bszset() fail if somebody else has an fd open.

