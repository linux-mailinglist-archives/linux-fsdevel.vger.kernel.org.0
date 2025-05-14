Return-Path: <linux-fsdevel+bounces-48970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC411AB6F80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A50A4C5E39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4B27A101;
	Wed, 14 May 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qde/O+A4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD521FF31;
	Wed, 14 May 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235647; cv=none; b=YnsvhkWNLlREyZMEtZdQioOozROn7MULY7GKENGgGh8X7d2LVsqzzdFMWssnylQw2T/g4SWNvgF1UO2k366eD+a3z0ZSXtZEL4KpjwpAba6XL20sOmNDxHYeG7G14m9gjBTeL2ozXEErnDVAufS/ysRnSwzvhdJX7FKUSAWlXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235647; c=relaxed/simple;
	bh=ASy4XXDUZ+XqgKJMKMfMraYghZijkdij/uWWZG56WI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mORlD20YTZDiOstDUqRJPkHxgyJoq+0XUpnwCoc6hYc31tneFywSdztTnNlmdCy1tsYNunrMBbCJNvJAtTDUfsQJwOPh4+drZ1v3g4A873FBmK8nnrcPzNJHLTO9dktQT7gjGG+rIHql4McQBftRwBYUadzcvGeVOPBSS5NhRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qde/O+A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB88C4CEE3;
	Wed, 14 May 2025 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747235647;
	bh=ASy4XXDUZ+XqgKJMKMfMraYghZijkdij/uWWZG56WI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qde/O+A4Int0tYt4EQwVneuXsRQr1YUBRqt7rxRMlvMEWAJba/NBWkoZqkNIgIebj
	 9S0lhDyh8DffOLN0Qy+hBivOJB2moQtFdeamW2PvJQAbIwCSONv0pmYxMS7J7dRtxg
	 fFSCY3LP0kcoKl+3Afu/mO2T6+9zfnKuLAixYUcjkzJs3N4z57CdVxf9dcKKtk58iY
	 PeQ1oLnGtJpLI1gPyy93GClLSVtFJJ6iTkuvAsghIQ4OMvusPwQMhN7IRQUuKhNbR0
	 FS0eCeyHMXbNNc0jk1gQmvfkg7n0joHw80vdo1QDSRvZ4jCSzBhPWo9JW4xwPO6QUs
	 9AcK7XSRN/Xpw==
Date: Wed, 14 May 2025 16:14:01 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 5/5] mm/filemap: Allow arch to request folio size
 for exec memory
Message-ID: <20250514151400.GB10762@willie-the-truck>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-6-ryan.roberts@arm.com>
 <20250509135223.GB5707@willie-the-truck>
 <c52861ac-9622-4d4f-899e-3a759f04af12@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c52861ac-9622-4d4f-899e-3a759f04af12@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, May 13, 2025 at 01:46:06PM +0100, Ryan Roberts wrote:
> On 09/05/2025 14:52, Will Deacon wrote:
> > On Wed, Apr 30, 2025 at 03:59:18PM +0100, Ryan Roberts wrote:
> >> diff --git a/mm/filemap.c b/mm/filemap.c
> >> index e61f374068d4..37fe4a55c00d 100644
> >> --- a/mm/filemap.c
> >> +++ b/mm/filemap.c
> >> @@ -3252,14 +3252,40 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >>  	if (mmap_miss > MMAP_LOTSAMISS)
> >>  		return fpin;
> >>  
> >> -	/*
> >> -	 * mmap read-around
> >> -	 */
> >>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> >> -	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> >> -	ra->size = ra->ra_pages;
> >> -	ra->async_size = ra->ra_pages / 4;
> >> -	ra->order = 0;
> >> +	if (vm_flags & VM_EXEC) {
> >> +		/*
> >> +		 * Allow arch to request a preferred minimum folio order for
> >> +		 * executable memory. This can often be beneficial to
> >> +		 * performance if (e.g.) arm64 can contpte-map the folio.
> >> +		 * Executable memory rarely benefits from readahead, due to its
> >> +		 * random access nature, so set async_size to 0.
> > 
> > In light of this observation (about randomness of instruction fetch), do
> > you think it's worth ignoring VM_RAND_READ for VM_EXEC?
> 
> Hmm, yeah that makes sense. Something like:
> 
> ---8<---
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7b90cbeb4a1a..6c8bf5116c54 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3233,7 +3233,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault
> *vmf)
>         if (!ra->ra_pages)
>                 return fpin;
> 
> -       if (vm_flags & VM_SEQ_READ) {
> +       /* VM_EXEC case below is already intended for random access */
> +       if ((vm_flags & (VM_SEQ_READ | VM_EXEC)) == VM_SEQ_READ) {
>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>                 page_cache_sync_ra(&ractl, ra->ra_pages);
>                 return fpin;
> ---8<---

I was thinking about the:

	if (vm_flags & VM_RAND_READ)
		return fpin;

code above this which bails if VM_RAND_READ is set. That seems contrary
to the code you're adding which says that, even for random access
patterns where readahead doesn't help, it's still worth sizing the folio
appropriately for contpte mappings.

Will

