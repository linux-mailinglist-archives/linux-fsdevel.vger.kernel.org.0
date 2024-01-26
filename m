Return-Path: <linux-fsdevel+bounces-9130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68A83E5C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4288B218C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DDD50A9A;
	Fri, 26 Jan 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fe8aqhlp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA41DA2E
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308881; cv=none; b=gsGlZ+BixYzWrCEe+KNks7lhzyUFIxjPdYTTqcDzvnov0NkfJq9h6CxQgYYItsmKLeogXgJa8jSbQnajtTawJ8h+wqW5U5aFbkfq5xw1O3AZHOWsU7JLmFu6lzTQXFfIJb1W9TDKrS38JySab2iHkelx65uhsTL4PHl4kftLq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308881; c=relaxed/simple;
	bh=YMjvOI7UzROvVnMe5/3qIgiCsIVcyFemNOG9FtKopag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbJIYdgn6xib0Qk7g7XVbgnUFzg4g3kTtNVJoAaqX7322eDoHYboptw3EEVGyz9So/q42gXPunUFgrc78SW+EQFcGh0v5vR4A+jJS+Dp6yMtalYyONixSYTFD3L9NV0YRDLuoHLP7r9KvmJ3t48yGbB13eS9SofIDbIm8Hvpci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fe8aqhlp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gusVsBfkL21x6oD4Vy8Tud6uSdVagu5Sz+iAtnYxIm0=; b=fe8aqhlpRPmYmsKKUHQEUsrNQx
	SZ8oVxsHOeGlbzrAzMk5rtRULt1bPMZT5qgk0BiqUkSLy/PP1HcDz8timLttVZzi8kwgOf0GEkt4L
	b4njRUOD0/dqobVVrmj58xCbnO6RECrw3la+175a39vkmb2eDoyQND7LkmsyO1lrVG/5/pI2zv4z5
	9CeNaxceRD7QKqEHFEl7Zla8T884IwvZW0cvf+/JpH0WKZHlojNzZ5hkYeV0W0cP3D1eCKAlbkHZU
	qPMiDap5YmmB70dI1zplL6xUw+EWUseWfbZgS58h8yhehy8GccIyHhfxpKSzCDjf0agZaHSYa6BFa
	EfJIHGJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTUss-0000000F4lb-1DM2;
	Fri, 26 Jan 2024 22:41:14 +0000
Date: Fri, 26 Jan 2024 22:41:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Message-ID: <ZbQ1CrwP2IT4v6sq@casper.infradead.org>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbGCsAsLcgreH6+a@dread.disaster.area>
 <CAKYAXd-MDm-9AiTsdL744cZomrFzNRvk1Sk8wrZXsZvpx8KOzA@mail.gmail.com>
 <ZbMJWI6Bg4lTy1aZ@dread.disaster.area>
 <ZbMe4CbbONCzfP7p@casper.infradead.org>
 <ZbQzChVQ+y+nfLQ2@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQzChVQ+y+nfLQ2@dread.disaster.area>

On Sat, Jan 27, 2024 at 09:32:42AM +1100, Dave Chinner wrote:
> > but the problem is that Microsoft half-arsed their support for holes.
> > See my other mail in this thread.
> 
> Why does that matter?  It's exactly the same problem with any other
> filesytsem that doesn't support sparse files.
> 
> All I said is that IO operations beyond the "valid size" should
> be treated like a operating in a hole - I pass no judgement on the
> filesystem design, implementation or level of sparse file support
> it has. ALl it needs to do is treat the "not valid" size range as if
> it was a hole or unwritten, regardless of whether the file is sparse
> or not....
> 
> > truncate the file up to 4TB
> > write a byte at offset 3TB
> > 
> > ... now we have to stream 3TB of zeroes through the page cache so that
> > we can write the byte at 3TB.
> 
> This behaviour cannot be avoided on filesystems without sparse file
> support - the hit of writing zeroes has to be taken somewhere. We
> can handle this in truncate(), the write() path or in ->page_mkwrite
> *if* the zeroing condition is hit.  There's no need to do it at
> mmap() time if that range of the file is not actually written to by
> the application...

It's really hard to return -ENOSPC from ->page_mkwrite.  At best you'll
get a SIGBUS or SEGV.  So truncate() or mmap() are the only two places to
do it.  And if we do it in truncate() then we can't take any advantage
of the limited "hole" support the filesystem has.

Most files are never mmaped, much less mapped writable.  I think doing
it in mmap() is the best of several bad options.

