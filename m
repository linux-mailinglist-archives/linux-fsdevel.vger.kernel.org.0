Return-Path: <linux-fsdevel+bounces-29353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02289787B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 20:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F81B23B0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7B612CDA5;
	Fri, 13 Sep 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fV+Oqrwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7900BA2D;
	Fri, 13 Sep 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251719; cv=none; b=DpMxmgttRXysd08cukB7uyIwmycEPBCFMinhu+tjzMfyZxTEvG+pf6p/REngNLPaT9VzPsLwzLlh3/n6DMNRcY83yG6AM/oKTmj5S0NVjcTq2bvHt+GajxFq24FvGpEH2wDPUio6hh4OCJ5J+uexZESts2HWxUhfzON2e6QYaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251719; c=relaxed/simple;
	bh=uxPIZJ+1ViYGAZS6fAskkOGEtedQeDT8jbs3FuZ4Zis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/NNkSdQbz+oTo31Z0OGTVRF/231DBqrlKVWdioOPJoTUimzt8rLlS3jvAnAGgz+QGylku6mNEuxt4+U+nom1xIUOsCZjxdg9jdkfEJSPZAyKucbT0I9UBMj+DGADGd4r2N5c3VO9TTXaGIYYY0k2hFkc2I7NKCYBYAtHYm3eRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fV+Oqrwc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wYxEaFz9qZ7MrEYfGMbQ7ngu7vfp+A8Nm3wr0M3NPsQ=; b=fV+OqrwcETEKCSa5SY8JoOHjs7
	etiKndVR41a5f7s8aTZX5h8jAytgSk4CJ0EseqUw48EVRQb4M6YWtPUOhdu6yF4syiIyIy0PFFNdL
	NiZ1frxk7F0Lxg+Thg5WIrg54l01zruGR0vvkBfGMNPVskCgwhI8C8x19eG+7F9hO9O62NM0A7Agn
	MqasK56ejj1DLwICA7i9epd8XjW4Owtk4NiO/hygPX4aotARfV6tETagS0taEZrcHGKV7fmviLaBo
	i7ZBteR7oA4nUedADY3nDw88itgEmVZWe72f7K5Kj3H8A2iX0wp+LCH9iSrMeDmq1MEIwvKhAQuY6
	td9MOg/A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spAva-0000000Grip-3Jze;
	Fri, 13 Sep 2024 18:21:54 +0000
Date: Fri, 13 Sep 2024 19:21:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: trondmy@kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] filemap: Fix bounds checking in filemap_read()
Message-ID: <ZuSCwiSl4kbo3Nar@casper.infradead.org>
References: <c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com>

On Fri, Sep 13, 2024 at 01:57:04PM -0400, trondmy@kernel.org wrote:
> If the caller supplies an iocb->ki_pos value that is close to the
> filesystem upper limit, and an iterator with a count that causes us to
> overflow that limit, then filemap_read() enters an infinite loop.

Are we guaranteed that ki_pos lies in the range [0..s_maxbytes)?
I'm not too familiar with the upper paths of the VFS and what guarantees
we can depend on.  If we are guaranteed that, could somebody document
it (and indeed create kernel-doc for struct kiocb)?

>  
> -	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
> +	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
>  	folio_batch_init(&fbatch);
>  
>  	do {
> -- 
> 2.46.0
> 

