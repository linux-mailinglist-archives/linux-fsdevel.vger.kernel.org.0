Return-Path: <linux-fsdevel+bounces-9278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF583FB3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 01:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D951F2292C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 00:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC75256;
	Mon, 29 Jan 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uoRchKiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0685664
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706489438; cv=none; b=CFJj4GC9R0WvjDyem+XaBQg/SLoqEuimpWfYxUPvS82taRq75Vsc+6MQY7V/fyfvmp0jU+EPlZxzVwtrYXtT1+Y5eb5qi8KWox0TRdpvu+5oQMPb6mMqCpqxvUfZhGs7a22mhJ7HFGhouys969wjG/LXBFjDB3wy31mHf2pFgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706489438; c=relaxed/simple;
	bh=f52b7Cfdbriw6cd2FhyUGv61wBH1SUjP1MYODkKD2Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+G1378epQNQrU1fa1ko2Fg0lqVtfcY+u7dZWa/lK9BGybHc4g353E8igzzO12RUhjhz7XNDN5rNteTbKCkOra33bEd+NlSuLTsQshSBTOOJEwrE6fILVxeItpJdXJCZDNf9KKH9IOVckJ3eboEG99VbEqTHt8WuYvYg1Tysb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uoRchKiy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5DBoxVV/Iwa1QqXupbVY7eCpJILqEFfpg23IlBibQao=; b=uoRchKiyQ6prWIu+AySjY9WaP7
	tmsgRd+CoxiJvclqf8orD30qM4UQ3mIds6ZpAwVRcYcfvlkvSlLkDPs5JafSPSj8cK9mTBiRp1S53
	H0FDpXRgYPP3rrs/SKAPoHelGvijIq9u9fRHAqHd+4DLE4BYZMFZ6qjwZ56umnhNKVz+ym7jykzLV
	pCMAgcpSYvc2sqUF0OskMDfhidoTR84WBN7D2niC+/MNGZ5O8pkQ4l1WKgUyYl8+m90cTjaMLqwvD
	Vnt75hf821oz755dHkG9QlxRDKnw0k2VxHDD+eslkDm0vxEl9sdf5a5X93P0NTWD3VeY0q3Y9Edht
	V8tMdowg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUFr7-000000052bx-3xwo;
	Mon, 29 Jan 2024 00:50:33 +0000
Date: Mon, 29 Jan 2024 00:50:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tony Solomonik <tony.solomonik@gmail.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v7 1/2] Add do_ftruncate that truncates a struct file
Message-ID: <Zbb2WXCuftbOhvOX@casper.infradead.org>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240126155720.20385-1-tony.solomonik@gmail.com>
 <20240126155720.20385-2-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126155720.20385-2-tony.solomonik@gmail.com>

On Fri, Jan 26, 2024 at 05:57:19PM +0200, Tony Solomonik wrote:
>  	f = fdget(fd);
>  	if (!f.file)
> -		goto out;
> +		return -EBADF;
>  
>  	/* explicitly opened as large or we are on 64-bit box */
>  	if (f.file->f_flags & O_LARGEFILE)
>  		small = 0;
>  
> -	dentry = f.file->f_path.dentry;
> -	inode = dentry->d_inode;
> -	error = -EINVAL;
> -	if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
> -		goto out_putf;
> -
> -	error = -EINVAL;
>  	/* Cannot ftruncate over 2^31 bytes without large file support */
>  	if (small && length > MAX_NON_LFS)
> -		goto out_putf;
> +		return -EINVAL;

I think this is wrong -- you need to putf after this point..


