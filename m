Return-Path: <linux-fsdevel+bounces-11797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4CF8572F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBC41C21814
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D5BE5E;
	Fri, 16 Feb 2024 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NziljXAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F929443;
	Fri, 16 Feb 2024 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045081; cv=none; b=KOsLLwGXKEyrF7gA1HfGaSilzBdJdXjTx2yBHvLREkPq51hyx+Bs2QytQaaAUXVDpagpCPM/k6c6+uzsptBwPPXU50uz/66ycqjdewHv7W2NgGIblbt1yU139oUgncI9DnFVnaP3we1kWflvBFEkJZzqozwXenvQMCMUJJ/L7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045081; c=relaxed/simple;
	bh=fT4BK4v0vw0QmXZmUXqjIWAaiwOlJdKTDaW84jKtOQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as5G3yD+VsfPf5e37SJbC+x9ljXCIZKWyWrELzUxepeXdgE7nRQ4FYpC1voVD6D69Hknk2RDfBCiza85EG1k0woqIkVNgaevDpe8KXq36FjAG2SfPLiHt5XDdaG70QBwAFitUNPn7zbm1jUX8O4ibrwfRClygyw6XrNKMx86onI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NziljXAa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rg6keNXeCzOyvnz/qJIf0xHBc+UX5gdIdINZ7tsu7Xw=; b=NziljXAaygDB3mcdw4/YBOsBVJ
	Qtvp6PQFvcuaCuE+7XRi1f1qP1CSdT7T0a8NnhpZwL+ganDoDemR24/m/s7Jf+tg5xdScrWx/0gYa
	NbtwOtR0SurZ+1jrCln/Nz2RruCuRnDP0+272eqqrIlX3/XzJ9oOIp5PG9Da8PEjzZgRwwx00QhaD
	vP7sqNCStpsJgGhwm/FZD5bhUQsnY1R9YJAfBmZzFXcPLe+MBIk0tP9zGDJMrmV31yXdsiT7V7nkB
	dDVcGkPOMr1QU/hjbkPqz24E83cITqAbAl88P5qojIT92b0bKclYd6o1aFAzJiHRtC5opve9NGBHd
	2DNZbUuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ramY3-00000003KzI-0jn6;
	Fri, 16 Feb 2024 00:57:51 +0000
Date: Fri, 16 Feb 2024 00:57:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <21cnbao@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/filemap: Allow arch to request folio size for exec
 memory
Message-ID: <Zc6zD4zfsrkRlHe6@casper.infradead.org>
References: <20240215154059.2863126-1-ryan.roberts@arm.com>
 <Zc6mcDlcnOZIjqGm@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc6mcDlcnOZIjqGm@dread.disaster.area>

On Fri, Feb 16, 2024 at 11:04:00AM +1100, Dave Chinner wrote:
> > The reason for the low liklihood is that the current readahead algorithm
> > starts with an order-2 folio and increases the folio order by 2 every
> > time the readahead mark is hit. But most executable memory is faulted in
> > fairly randomly and so the readahead mark is rarely hit and most
> > executable folios remain order-2.
> 
> Yup, this is a bug in the readahead code, and really has nothing to
> do with executable files, mmap or the architecture.  We don't want
> some magic new VM_EXEC min folio size per architecture thingy to be
> set - we just want readahead to do the right thing.
> 
> Indeed, we are already adding a mapping minimum folio order
> directive to the address space to allow for filesystem block sizes
> greater than PAGE_SIZE. That's the generic mechanism that this
> functionality requires. See here:
> 
> https://lore.kernel.org/linux-xfs/20240213093713.1753368-5-kernel@pankajraghav.com/
> 
> (Probably worth reading some of the other readahead mods in that
> series and the discussion because readahead needs to ensure that it
> fill entire high order folios in a single IO to avoid partial folio
> up-to-date states from partial reads.)
> 
> IOWs, it seems to me that we could use this proposed generic mapping
> min order functionality when mmap() is run and VM_EXEC is set to set
> the min order to, say, 64kB. Then the readahead code would simply do
> the right thing, as would all other reads and writes to that
> mapping.
> 
> We could trigger this in the ->mmap() method of the filesystem so
> that filesysetms that can use large folios can turn it on, whilst
> other filesystems remain blissfully unaware of the functionality.
> Filesystems could also do smarter things here, too. eg. enable PMD
> alignment for large mapped files....

We already enable PMD alignment for large mapped files (which caused
some shrieking from those who believe that ASLR continues to offer
worthwhile protection), commit efa7df3e3bb5.

My problem with your minimum order proposal is that it would be a
hard failure if we couldn't get an order-4 folio.  I think we'd do
better to set the ra_state parameters to 64KiB at mmap time (and I
think that's better done in the MM, not in each FS)

