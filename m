Return-Path: <linux-fsdevel+bounces-18824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2468BCC1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065841C21B94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038EC142914;
	Mon,  6 May 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yn+vNPDK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7324204B;
	Mon,  6 May 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991935; cv=none; b=p5vE86fX8JmEAALRWNEWd2GFHm1UHckhutbWyOMZbM6ot8LZ6iAqMC+zTQKSxPxwLH3iJTTdJMr2iQJfD3b9dmuUFZ1NtFJ71JlDTId4dXq8csKz2+ppAeJdWGVXs5hIxfGbb3tXhxVZ5LwMTQk4XbGr9gL7Hez1L9xh10uXHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991935; c=relaxed/simple;
	bh=02jhnwOiS0QtF/pgwOtieUVchda/o2cZ6028VWK7IZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwtp4ny8Q++yp8KANC2viWr1kzZCZi5mgTbaWVlZjGVziTLc/6QARCowRV6Pe3xVPpUK3MN0xsHHoNnFVadvuVQsZ54d9VSgff3bcJYIvsEAOdoHalF3pSlrQdJ5VlD+2Y3wL9GsNT5+ReSlnq3vUUeX5H+4KH9RZZPt4ZYLi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yn+vNPDK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C1vNOBcYPu24/KsvOJhsEyUZ+lh1CQwNcPGM2ZQDJdw=; b=Yn+vNPDKwqkHpn+SytUx3aohk3
	V6AUgZayL5XgR539k2baEwTGggGTOPdp7XT+WqO9+AEDX1JDCrG0pn74gbMc9iqehd4EPQ9D4Kit7
	Dc2kMXAiJwX+l0hnxn8chx6jtI6Fje92rS8duHVP2WU10yUz/r18pQzxHQ1Q1PjFVzy3rCcc507my
	E/nlwFj4fCuJ/KAzTZXyJ3uc03f0vB90CRXd+XTR7flyF/oFLFriMfAViQMBgz5lcZbH1/mk7BzQD
	RrQdJBEdFl/oD9I1YpNJL7InZ3XZ1zfyP143rDERtb9j8IOq38fn4GM75uiSMvImnWWIltQPvSoye
	ufnBqn/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3vk8-0000000AjiN-3zQ6;
	Mon, 06 May 2024 10:38:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 991FA300362; Mon,  6 May 2024 12:38:48 +0200 (CEST)
Date: Mon, 6 May 2024 12:38:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: WARN when f_count resurrection is attempted
Message-ID: <20240506103848.GN40213@noisy.programming.kicks-ass.net>
References: <20240503201620.work.651-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503201620.work.651-kees@kernel.org>

On Fri, May 03, 2024 at 01:16:25PM -0700, Kees Cook wrote:
> It should never happen that get_file() is called on a file with
> f_count equal to zero. If this happens, a use-after-free condition
> has happened[1], and we need to attempt a best-effort reporting of
> the situation to help find the root cause more easily. Additionally,
> this serves as a data corruption indicator that system owners using
> warn_limit or panic_on_warn would like to have detected.
> 
> Link: https://lore.kernel.org/lkml/7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com/ [1]
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  include/linux/fs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 00fc429b0af0..fa9ea5390f33 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1038,7 +1038,8 @@ struct file_handle {
>  
>  static inline struct file *get_file(struct file *f)
>  {
> -	atomic_long_inc(&f->f_count);
> +	long prior = atomic_long_fetch_inc_relaxed(&f->f_count);
> +	WARN_ONCE(!prior, "struct file::f_count incremented from zero; use-after-free condition present!\n");

This reminds me, I should some day try and fix the horrible code-gen for
WARN() :/ WARN_ON_*() and friends turn into a single trap instruction,
but the WARN() and friends thing turns into a horrible piece of crap for
the printk().

