Return-Path: <linux-fsdevel+bounces-48113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F489AA98EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E01517D556
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476EF26771B;
	Mon,  5 May 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lwuuNtS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9D15AF6;
	Mon,  5 May 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462481; cv=none; b=RYdbKfynBScgayXFJt6UjhxhQyXS4zZigETsXnCHDzOoTwXDokHiI5hivNBG9wgfhJldPq2w7b+npXkQZi5FxA16EW4WZN0XAzvMNOD0fPTjgHnlyAlJpg4AxDSW52yFVVs9KYnkoBvOkhiS3dOKUnnAuXVqQtFjPa5RYjZClBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462481; c=relaxed/simple;
	bh=x2huZpx4W5mvzsnutjV4Nr/VcpkSiWQFc8s5hS4QT3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/z8EF8w+ur7WTmDdyk7Rkjg5sjnC9Inv0Q9G0M17HIQUAbqofrflRE29DH10EpdJ/x196jwrd4culYoJtYL0Y6O0R7R2qp2yIvJ+DXr8Abbr575IiamnbPSfZ3VtAsywT23NfG9+tfZGCANBAxm6066qUmfYhj4WBf/7aStxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lwuuNtS4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n9palP+uVzQLbPniK3EFvHs8Z1+LTjOm2zRGYChvchA=; b=lwuuNtS44N0CmaXWM/pDHCGqLQ
	K73j/U9RBtA+m3XMXDmYGBJ5lFRpUeEviUG6FH9hLfpX5j759+eC0rvC64Syew3EB7HoYmRQ5jcY2
	wpAUcyhlpEpVgBELqJpK8YrnuEg4rf9wcFgSkjl0+khxoo8LFzYzoHfDQbxoiz8C8MnD5V2i3SgnA
	y/y1V9+mrwDEZqJm88Z9YvXnWKoPPaEWpF8Ry52Je7NApiWH6hU22B4BIDkHkg7afJ+mzL2F3iZ6p
	71IAvdbzcCAekW81E4laAUa70QfRidvvbu6pwyXXbvnX4Dsv6IM3Gpv0I/KT+/6fhpS8g+VdS9dDP
	aAElSKag==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uByfG-0000000D9g1-2FB1;
	Mon, 05 May 2025 16:27:34 +0000
Date: Mon, 5 May 2025 17:27:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	John Schoenick <johns@valvesoftware.com>
Subject: Re: [PATCH] vfs: change 'struct file *' argument to 'const struct
 file *' where possible
Message-ID: <aBjm9khhIBOUTFcV@casper.infradead.org>
References: <20250505154149.301235-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505154149.301235-1-mszeredi@redhat.com>

On Mon, May 05, 2025 at 05:41:47PM +0200, Miklos Szeredi wrote:
> -static inline struct backing_file *backing_file(struct file *f)
> +#define backing_file(f) container_of(f, struct backing_file, file)
> +
> +struct path *backing_file_user_path(struct file *f)
>  {
> -	return container_of(f, struct backing_file, file);
> +	return &backing_file(f)->user_path;
>  }
>  
> -struct path *backing_file_user_path(struct file *f)
> +const struct path *backing_file_user_path_c(const struct file *f)
>  {
>  	return &backing_file(f)->user_path;
>  }
> -EXPORT_SYMBOL_GPL(backing_file_user_path);
> +EXPORT_SYMBOL_GPL(backing_file_user_path_c);

May I suggest:

#define backing_file_user_path(f)	(_Generic((f),		\
	const struct file *:	(const struct path *)&backing_file(f)->user_path,  \
	struct file *:		(struct path *)&backing_file(f)->user_path)))

It's the same technique we use for page_folio() so it's quite well
tested.

