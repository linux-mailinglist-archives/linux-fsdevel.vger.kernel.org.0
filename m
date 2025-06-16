Return-Path: <linux-fsdevel+bounces-51704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3AADA699
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 05:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AA11890123
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BA13D891;
	Mon, 16 Jun 2025 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB8ME1mF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F103207
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042833; cv=none; b=UrcZdur0qY9hCikzHhpyiPZ4Rhm9BP2Vw1BpaEwwCypqyTQHL4dmFqkM4z501/PachJiMsTDblInERicqex0VitpgLRBlPqh9sPKvlVIMuDAjc9JCQRQ2ORW9iko3ocyLxzajo41hNaF7Zr002tS9uKqUZ6SY8NOLAJPGERsJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042833; c=relaxed/simple;
	bh=7ujwnX8o8CGIZtimMGbZgPkv3sibCCJJCACTP/mOQuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJfUBSbv8Hj6lD3O7StiqR+CV5Fbgy/6ZfsmKqh9hadBDIgo24Y1js1l/vXDVS/upN9gFLSBmcYqPIS/JdniVT2y3MtKp7bJmInpKlsF5lneADqaCnqftzwrwNSJr2umwu4MPrtOby8+QnweokLJY+cdtn04mXQO0i/2xd+QzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB8ME1mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9528BC4CEE3;
	Mon, 16 Jun 2025 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750042833;
	bh=7ujwnX8o8CGIZtimMGbZgPkv3sibCCJJCACTP/mOQuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oB8ME1mFpzZfUvoryqkE9UmoDQUTHUndxAgoZtGBin7re4dO5gEJHWhb88n7z41Jg
	 dQ9Kss2JIyozqQZNPWcMM+klUgWQVEiamj4qhlW5X7Oy/SOZuIMjvyTLGeWVHULBfr
	 e5aoMEKPDBkLTQ5vRgq+wghBrZbf9dYx8mlGqcA31sgFcumWmAvXmuUdvzd90syjQL
	 QeEDKdcSD/a+jZRsBrlxKwItciL6ipp9DACHb75+zbimavivRYBGKF+3HwNdg3E74D
	 pA4A9ovOnDvwoMrupTKzqrQaoaG/+hiERLkatcK2UAJS+1sul2FTYTcFXzsNwkO5FX
	 Tt6iMCY4hUsyQ==
Date: Mon, 16 Jun 2025 06:00:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] secretmem: move setting O_LARGEFILE and bumping users'
 count to the place where we create the file
Message-ID: <aE-Iy_UIFFP5fd3g@kernel.org>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV>
 <20250615003321.GC3011112@ZenIV>
 <20250615003507.GD3011112@ZenIV>
 <20250615144610.49c561aebe464f617a262343@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615144610.49c561aebe464f617a262343@linux-foundation.org>

On Sun, Jun 15, 2025 at 02:46:10PM -0700, Andrew Morton wrote:
> On Sun, 15 Jun 2025 01:35:07 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > [don't really care which tree that goes through; right now it's
> > in viro/vfs.git #work.misc, but if somebody prefers to grab it
> > through a different tree, just say so]
> 
> (cc Mike)
> 
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -208,7 +208,7 @@ static struct file *secretmem_file_create(unsigned long flags)
> >  	}
> >  
> >  	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> > -				 O_RDWR, &secretmem_fops);
> > +				 O_RDWR | O_LARGEFILE, &secretmem_fops);
> >  	if (IS_ERR(file))
> >  		goto err_free_inode;
> >  
> > @@ -222,6 +222,8 @@ static struct file *secretmem_file_create(unsigned long flags)
> >  	inode->i_mode |= S_IFREG;
> >  	inode->i_size = 0;
> >  
> > +	atomic_inc(&secretmem_users);
> > +
> >  	return file;
> >  
> >  err_free_inode:
> > @@ -255,9 +257,6 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
> >  		goto err_put_fd;
> >  	}
> >  
> > -	file->f_flags |= O_LARGEFILE;
> > -
> > -	atomic_inc(&secretmem_users);
> >  	fd_install(fd, file);
> >  	return fd;
> >  
> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
 
> Please retain this in the vfs tree.

-- 
Sincerely yours,
Mike.

