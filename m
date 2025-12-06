Return-Path: <linux-fsdevel+bounces-70939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0EBCAA696
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AC763110395
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B022F6591;
	Sat,  6 Dec 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VDTttdSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373121C9EA;
	Sat,  6 Dec 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765025568; cv=none; b=GdkuFGNt9okjbRKuAbBqwIP4HWVHfbWs3FuyJ9xY+e6Ac/lHeUX1XF3KtjLbS02GZN5e9HoRpQe3FIBoeAoVKrEqAiSWBPy4f3hmY/PH0pXMreCPb4rSuzAi6fuIzwvs6Wucb0YhFYT0iDeYDrFmgFBrFHv6CusF3iyzazESup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765025568; c=relaxed/simple;
	bh=lvDEHVs7qI4kzz6WzpsV7jNYvgUtUB3WQFvbWUK7P3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th2NEqkgByZuPGeXB0ekPDHiu+qU0Z6jCcOna8qDXGQiOAHrR0EUhWD0i5+r3SqJKgasroaonlwnemAVRT55mtfiP5G9S4HnjHyNXx3HlXcdOzw1kbrCYo6TECdGNTjrAG9EdzaHv9P1v5dYTbxJC3cYga9oJWkzy29BiPwP9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VDTttdSV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+mdIdRGmGgmF50KJMgs3fRDNqKfdLumTX4KIFEo0UUo=; b=VDTttdSVbSgb+REcQzD5Fsh15A
	qhRaA3qvutQzHNRVsH8tbtpbbcOk77jrTKWBpAAamzI5HuQGlwzRipfwomCjla+EKCjMoQV3YV/yH
	5ZBa/jk9LXGBQ21Fgne9d+RvbEkG7r8hCkdG6dRAATCgnvgOuvyKtUqXLwbYK2ny+NDNodbgAcB8L
	QxsMEOlRqsX7JLRNPW6sBv3A/xzpfzDea+8aWgPE+kdHKEYUdyT18+AgozL7aPL2e+SGU+Bj00hky
	2zOFUXrmLMbO38v6F1DYHQ7CIxgWPNzLpetlgCR1PutN79QA65PzY5kdwcaGsI8QKpVIM3+e9+rcV
	Yg45ITrw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRrm9-00000007BhE-1GZr;
	Sat, 06 Dec 2025 12:52:37 +0000
Date: Sat, 6 Dec 2025 12:52:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: enforce the immutable flag on open files
Message-ID: <aTQnFQIc3ylSci1u@casper.infradead.org>
References: <znhu3eyffewvvhleewehuvod2wrf4tz6vxrouoakiarjtxt5uy@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <znhu3eyffewvvhleewehuvod2wrf4tz6vxrouoakiarjtxt5uy@tarta.nabijaczleweli.xyz>

On Sat, Dec 06, 2025 at 01:03:35PM +0100, Ahelenia Ziemiańska wrote:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ebd75684cb0a..0b0d5cfbcd44 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3945,12 +3945,18 @@ EXPORT_SYMBOL(filemap_map_pages);
>  
>  vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
>  {
> -	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	struct file *file = vmf->vma->vm_file;
> +	struct address_space *mapping = file->f_mapping;
>  	struct folio *folio = page_folio(vmf->page);
>  	vm_fault_t ret = VM_FAULT_LOCKED;
>  
> +	if (unlikely(IS_IMMUTABLE(file_inode(file)))) {
> +		ret = VM_FAULT_SIGBUS;
> +		goto out;

I don't believe you tested this code path.  It contains a rather obvious
bug.

> +	}
> +
>  	sb_start_pagefault(mapping->host->i_sb);
> -	file_update_time(vmf->vma->vm_file);
> +	file_update_time(file);
>  	folio_lock(folio);
>  	if (folio->mapping != mapping) {
>  		folio_unlock(folio);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d578d8e765d7..5d3fbf4efb3d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1294,6 +1294,14 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  	bool update_mtime = false;
>  	bool update_ctime = true;
>  
> +	if (unlikely(IS_IMMUTABLE(inode)))
> +		return -EPERM;
> +
> +	if (unlikely(IS_APPEND(inode) &&
> +		     (attr->ia_valid & (ATTR_MODE | ATTR_UID |
> +					ATTR_GID | ATTR_TIMES_SET))))
> +		return -EPERM;
> +
>  	error = setattr_prepare(idmap, dentry, attr);
>  	if (error)
>  		return error;
> @@ -3475,6 +3483,10 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ret = generic_write_checks(iocb, from);
>  	if (ret <= 0)
>  		goto unlock;
> +	if (unlikely(IS_IMMUTABLE(inode))) {
> +		ret = -EPERM;
> +		goto unlock;
> +	}
>  	ret = file_remove_privs(file);
>  	if (ret)
>  		goto unlock;
> -- 
> 2.39.5



