Return-Path: <linux-fsdevel+bounces-22901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CB791EB61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4CC1C21714
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04E172BC9;
	Mon,  1 Jul 2024 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOnc4HW5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093212F29;
	Mon,  1 Jul 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877165; cv=none; b=doEQHgtAN3mbiPN4KgQUoRKQIyIsLmdtVPFvKuDJd/mov3uLG2+Ts4S2GvXBsf/JtqOx3A9xjk96J8vHXaq6Z2gtSFDVGHcgabii0+rjGHJf86up2DRdJ4WzS0Mw4AaZNz//LbdgNEiMFObfSDFJzpN1TDmdEuBCbg2UpzQIMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877165; c=relaxed/simple;
	bh=Cv3qHuSFe/yVQvVRlGehTCuG/jEU/jarDzlAQwq1gJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2JKU5CSIYnYyklfGUyZt+Dgwg3bi7ZXKalD1XyIDKMiNSMS/oVFvJ1A3Dz7K85YL7uPhIAKdHX2nKCb9hPFHvTzyD965YbwhG36HA/PGTyscsbWzBXETATHyo9f1jjvEbOharbz8NNYXH5j1A538cbuqK8aZkbOqvbXEeadY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOnc4HW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A18CC116B1;
	Mon,  1 Jul 2024 23:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719877164;
	bh=Cv3qHuSFe/yVQvVRlGehTCuG/jEU/jarDzlAQwq1gJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOnc4HW5e/Wt9HcHyUf/XtkqA49cKXve/njNs8bznoh3+Ck5rDoSQ0aXg2jN8EPPp
	 6BupjT8Az/AvpKVt8H/DXrMor31cn3uTB0I+lylT8WY+iNaQLbbkr/bBaeNsC/Krs6
	 pfX5aM/1wAV02IkyPmSKNLNm1LG/SJ7y9HIeSMTElJSb2tCVy81Wq8rNSLraeJ0mfD
	 79jFcIoOrgZZlzJZdXL9DQJj1I6S2nAtV0nnFbjKNSB4yzXTMz+A3Rgz4sPsufRtq8
	 3ohiDqiZ4gV7wuHjE5soapu6fsfQiGLN490krm3XW2Lzv9m8duYrFGW8yPhw0Jzrsr
	 K3jUBIXrivWpg==
Date: Mon, 1 Jul 2024 16:39:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 05/10] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
Message-ID: <20240701233924.GG612460@frogsfrogsfrogs>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-6-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-6-kernel@pankajraghav.com>

On Tue, Jun 25, 2024 at 11:44:15AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Usually the page cache does not extend beyond the size of the inode,
> therefore, no PTEs are created for folios that extend beyond the size.
> 
> But with LBS support, we might extend page cache beyond the size of the
> inode as we need to guarantee folios of minimum order. While doing a
> read, do_fault_around() can create PTEs for pages that lie beyond the
> EOF leading to incorrect error return when accessing a page beyond the
> mapped file.
> 
> Cap the PTE range to be created for the page cache up to the end of
> file(EOF) in filemap_map_pages() so that return error codes are consistent
> with POSIX[1] for LBS configurations.
> 
> generic/749(currently in xfstest-dev patches-in-queue branch [0]) has
> been created to trigger this edge case. This also fixes generic/749 for
> tmpfs with huge=always on systems with 4k base page size.
> 
> [0] https://lore.kernel.org/all/20240615002935.1033031-3-mcgrof@kernel.org/
> [1](from mmap(2))  SIGBUS
>     Attempted access to a page of the buffer that lies beyond the end
>     of the mapped file.  For an explanation of the treatment  of  the
>     bytes  in  the  page that corresponds to the end of a mapped file
>     that is not a multiple of the page size, see NOTES.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Heh, another fun mmap wart!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  mm/filemap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8eafbd4a4d0c..56ff1d936aa8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3612,7 +3612,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct file *file = vma->vm_file;
>  	struct address_space *mapping = file->f_mapping;
> -	pgoff_t last_pgoff = start_pgoff;
> +	pgoff_t file_end, last_pgoff = start_pgoff;
>  	unsigned long addr;
>  	XA_STATE(xas, &mapping->i_pages, start_pgoff);
>  	struct folio *folio;
> @@ -3638,6 +3638,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		goto out;
>  	}
>  
> +	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
> +	if (end_pgoff > file_end)
> +		end_pgoff = file_end;
> +
>  	folio_type = mm_counter_file(folio);
>  	do {
>  		unsigned long end;
> -- 
> 2.44.1
> 
> 

