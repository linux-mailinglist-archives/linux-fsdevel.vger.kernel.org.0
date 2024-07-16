Return-Path: <linux-fsdevel+bounces-23774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0FF932C14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C512B21293
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6A19FA8F;
	Tue, 16 Jul 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jTSF3sz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523519B59C;
	Tue, 16 Jul 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145082; cv=none; b=QKoVA6Fe9AhlZAq8jHgKV73uLa25Cvu7fFB/ZKPsojyBdnLeyiW3j61C++AcKcTNsZclkSkiO+9P0NEcDecFuwPExvAibKRYNGCyPQJ0CsuKhbEbP5x+bSZ7oyr0dIhBqXasjFd0bKZAAw0JHVixfcdR3fyztJx+turCvvw6JSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145082; c=relaxed/simple;
	bh=4lqw+d2NzbybLHZriO5nYcuQxQzfCRrAy5e2KZf34hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBm1ZBPeruEDDZQsP22UtFBAzlmNZgOfpOc/ev3OsMthY7xOPy8l1tQQfuYHXAUALKA8MetD1uwzyRVpqUfIRf39a52GGkbrM3077X8CUFAcv4pae+MEsJ0Hi66fTv9z3Cp+hthDZ+2qq4QpMoh8eLodcrjlJdQZClpyBVM+TMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jTSF3sz2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4jgezgNznqVGAT5m0Kkwye6L9viL7JmSTPZJ2Vkl7xc=; b=jTSF3sz2sJUVvHhOWh6b+zf3NL
	hIPcamev6t/QTc/1y6FJxrBl70tgP8sR606R4Ilw3iMMo1fCh1KEO0vX7uEzu2K/RrCdeAq6E7A/X
	Cg/0fYFBYyxlQtDz/sPgKfxCAGfxXQBRNMCL9gAL0UPtdip7rQu8Elnr/KHe3n9sQXyiY1XXvZjqj
	5xvZ3EIs46WdGXSojsKCcYDg40qsRomc2iT+sJcug+fAL6CJq5AUKj9D6v1FSv6OMSD/4fc7AsJpt
	sti8nEJGbDv7ylMe8mHnsjt9R2ShEZVjXw4PLz3AbeOh9+yPpfKhe1Ps0LeuYBD35H20CVoO6TJYD
	Hh3buPWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTkST-0000000HGcg-1maT;
	Tue, 16 Jul 2024 15:51:17 +0000
Date: Tue, 16 Jul 2024 16:51:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] fs: buffer: set the expression type to unsigned long in
 folio_create_buffers()
Message-ID: <ZpaW9ebdKyJremzp@casper.infradead.org>
References: <20240716090105.72179-1-r.smirnov@omp.ru>
 <5002a830-6a66-82fc-19e3-ec1e907eeb49@omp.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5002a830-6a66-82fc-19e3-ec1e907eeb49@omp.ru>

On Tue, Jul 16, 2024 at 06:41:49PM +0300, Sergey Shtylyov wrote:
>    And here we'll have at least one potential problem (that you neglected
> to describe): with 1 << 31, that 1 will land in a sign bit and then, when
> it's implicitly cast to *unsigned long*, the 32-bit value will be sign-
> extended to 64-bit on 64-bit arches) and then we'll have an incorrect size
> (0xffffffff80000000) passed to create_empty_buffers()...

Tell me more about this block device you have with a 2GB block size ... ?

(ie note that this is a purely theoretical issue)

> > to use 1UL instead.
> 
>    Perphas was worth noting that using 1UL saves us 1 movsx instruction on
> x86_64...

That is a worthwhile addition to the change log.

Also, you should cc the person who wrote that code, ie me.

