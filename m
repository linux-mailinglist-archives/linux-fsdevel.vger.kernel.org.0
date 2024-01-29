Return-Path: <linux-fsdevel+bounces-9384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A178408D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AB41F26CBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B79152E04;
	Mon, 29 Jan 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ROFlSVTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1A151CFB;
	Mon, 29 Jan 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539323; cv=none; b=FZAvd3kW8DJTBewVzSLe6IN1pLxfjBD67AZ3VayC8TEG7/bPp+iI4kOFZtEenwtWaLL9cOFzyqOPquQy6BJ8pymxtTUQeqow+NLOxlUAs21PwsS/Rze8DA/mJyVsCdoF/ljxBZokvbFiWTaO2pWNf5HLsuJrj9idEPAVWDyQqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539323; c=relaxed/simple;
	bh=XfHCbPuZ9Sd6Dii9sMHgMoRG9OJOdipphUeAliz/bbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoHEMomSls5qJKIR3ubtKiErhhHs5G4bNe5SzNmJZ5RqW2ATdBdOrcM11CUAem9ojXmcCxjM1aa3Z2Tn7Jeep96Obegxq/VqJfmpfQFnjcycVugQu9tpjsAKjeEmlKkzQKzOyw8RbLq4H7eXJVfAQdmb1+6NqlzW6YVG6eSEWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ROFlSVTd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qvYyv6g1p9HNR7/QDn+cPswg81RWpt5qBAdgn5bPezw=; b=ROFlSVTd1kgyssYmy6tVpcJUtf
	z3nFeKi0OwU5HmznNOR0u7CHaLQpg7AYX2wmPgHRowOIvC5ms9mynHoDW4KyEJczHdCnZryoZzhSc
	13f5Ek8zW2WcfHs67PtWBmFS09IG5TUOb6mQTqDnonns/nvSs+kb9x+tsUVWVw6AhV/VHA+za0HRb
	5asZ0gGvCYBhJ3f380lurNdYu5OVgiJFPu3rsQy84Gq/vezfDirvghj3WX6HCin+KRYbvXMY+fc4O
	MKf6iRbHnmzZVjlwP3+WULzjVoTpXQkr2vjRgYf75aO7RtrQ1uhpQzjuTwLsuss9xiXH0Yi7UPaNO
	PSDhf1Fw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUSph-00000006sUh-0ImC;
	Mon, 29 Jan 2024 14:41:57 +0000
Date: Mon, 29 Jan 2024 14:41:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Roman Smirnov <r.smirnov@omp.ru>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, lvc-project@linuxtesting.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 5.10/5.15 v2 0/1 RFC] mm/truncate: fix WARNING in
 ext4_set_page_dirty()
Message-ID: <Zbe5NBKrugBpRpM-@casper.infradead.org>
References: <20240125130947.600632-1-r.smirnov@omp.ru>
 <ZbJrAvCIufx1K2PU@casper.infradead.org>
 <20240129091124.vbyohvklcfkrpbyp@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129091124.vbyohvklcfkrpbyp@quack3>

On Mon, Jan 29, 2024 at 10:11:24AM +0100, Jan Kara wrote:
> On Thu 25-01-24 14:06:58, Matthew Wilcox wrote:
> > On Thu, Jan 25, 2024 at 01:09:46PM +0000, Roman Smirnov wrote:
> > > Syzkaller reports warning in ext4_set_page_dirty() in 5.10 and 5.15
> > > stable releases. It happens because invalidate_inode_page() frees pages
> > > that are needed for the system. To fix this we need to add additional
> > > checks to the function. page_mapped() checks if a page exists in the 
> > > page tables, but this is not enough. The page can be used in other places:
> > > https://elixir.bootlin.com/linux/v6.8-rc1/source/include/linux/page_ref.h#L71
> > > 
> > > Kernel outputs an error line related to direct I/O:
> > > https://syzkaller.appspot.com/text?tag=CrashLog&x=14ab52dac80000
> > 
> > OK, this is making a lot more sense.
> > 
> > The invalidate_inode_page() path (after the page_mapped check) calls
> > try_to_release_page() which strips the buffers from the page.
> > __remove_mapping() tries to freeze the page and presuambly fails.
> 
> Yep, likely.
> 
> > ext4 is checking there are still buffer heads attached to the page.
> > I'm not sure why it's doing that; it's legitimate to strip the
> > bufferheads from a page and then reattach them later (if they're
> > attached to a dirty page, they are created dirty).
> 
> Well, we really need to track dirtiness on per fs-block basis in ext4
> (which makes a difference when blocksize < page size). For example for
> delayed block allocation we reserve exactly as many blocks as we need
> (which need not be all the blocks in the page e.g. when writing just one
> block in the middle of a large hole). So when all buffers would be marked
> as dirty we would overrun our reservation. Hence at the moment of dirtying
> we really need buffers to be attached to the page and stay there until the
> page is written back.

Thanks for the clear explanation!

Isn't the correct place to ensure that this is true in
ext4_release_folio()?  I think all paths to remove buffer_heads from a
folio go through ext4_release_folio() and so it can be prohibited here
if the folio is part of a delalloc extent?

I worry that the proposed fix here cuts off only one path to hitting
this WARN_ON and we need a more comprehensive fix.

