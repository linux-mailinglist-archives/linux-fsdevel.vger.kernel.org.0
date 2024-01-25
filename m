Return-Path: <linux-fsdevel+bounces-8922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC3483C452
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B39E1F25201
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA024633F2;
	Thu, 25 Jan 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UfJQK2+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35962818;
	Thu, 25 Jan 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191629; cv=none; b=sizlazH2HmyriL2NAdfyAgpyPopZKnb6rCbABA8yhMknHLOpwXu6rBHIrdTCCufd/Lgjc+bI433OMlWzhVAyV01PrM48bgqCwyNEHlIaJil5qayyTMc857hnxP+IeFghm4RqLv+wMPQEMIxhIdmW024J7gTkT8sBJViC5pDZ0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191629; c=relaxed/simple;
	bh=IcOwiCYIKlbjRViqEZg0G3ysWLmWBTRKQjL9VUBzpek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJh6okQ/ZVllQhGmJ/ddtZkPqbozYB3BTvE+yDXKmlGjTIrTw8RxtdH8QKocGYlUUfabtJWgANYNRDwy8To09IWeyzb7qIJjPrM6qz6irpfcaq6NgqsgweKEAcsgtZ0Igo3C7zWfGO8/00CIGg5+1mmgMp2E4NsIc8IJTg9EgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UfJQK2+v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XXP3YFJkDTAm2zsOnv3DQrubzByWfNV5K63UqeZtxcI=; b=UfJQK2+vPgy8YoGDyfQldf36jb
	69jJrRB/0sNkNhT1B58DiM/8Bl2RysOAJ+BO6ns/YE8GS5Vd+FMcUPe8GPiwt6vZxUqmMib2Dzc9u
	EuQnVQHGu2k6IUzH6aCEU18TR0l5fWFtGXJw1GZtAdzoMErMseyPH7WT7i2vjIuUIgeIImfsQNES2
	NFpvDy5JeZJNcM+1N4L8H6o+w23uXhDea7Z4ues8MRH8ibqKq6aBkjCddPHc59spj8/b9bNH+OJtR
	dk04RjSjwFhNEPpE1exj+3AbInvJCiCbL0grUgqheIr18GnKaP09vqKxO4UMzmyjygKWREedqDNAv
	Tfzuhogw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0Ne-0000000A91C-1kHD;
	Thu, 25 Jan 2024 14:06:58 +0000
Date: Thu, 25 Jan 2024 14:06:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <ZbJrAvCIufx1K2PU@casper.infradead.org>
References: <20240125130947.600632-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125130947.600632-1-r.smirnov@omp.ru>

On Thu, Jan 25, 2024 at 01:09:46PM +0000, Roman Smirnov wrote:
> Syzkaller reports warning in ext4_set_page_dirty() in 5.10 and 5.15
> stable releases. It happens because invalidate_inode_page() frees pages
> that are needed for the system. To fix this we need to add additional
> checks to the function. page_mapped() checks if a page exists in the 
> page tables, but this is not enough. The page can be used in other places:
> https://elixir.bootlin.com/linux/v6.8-rc1/source/include/linux/page_ref.h#L71
> 
> Kernel outputs an error line related to direct I/O:
> https://syzkaller.appspot.com/text?tag=CrashLog&x=14ab52dac80000

OK, this is making a lot more sense.

The invalidate_inode_page() path (after the page_mapped check) calls
try_to_release_page() which strips the buffers from the page.
__remove_mapping() tries to freeze the page and presuambly fails.

ext4 is checking there are still buffer heads attached to the page.
I'm not sure why it's doing that; it's legitimate to strip the
bufferheads from a page and then reattach them later (if they're
attached to a dirty page, they are created dirty).

So the only question in my mind is whether ext4 is right to have this
assert in the first place.  It seems wrong to me, but perhaps someone
from ext4 can explain why it's correct.

> The problem can be fixed in 5.10 and 5.15 stable releases by the 
> following patch.
> 
> The patch replaces page_mapped() call with check that finds additional
> references to the page excluding page cache and filesystem private data.
> If additional references exist, the page cannot be freed.
> 
> This version does not include the first patch from the first version.
> The problem can be fixed without it. 
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Link: https://syzkaller.appspot.com/bug?extid=02f21431b65c214aa1d6
> 
> Matthew Wilcox (Oracle) (1):
>   mm/truncate: Replace page_mapped() call in invalidate_inode_page()
> 
>  mm/truncate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> -- 
> 2.34.1
> 

