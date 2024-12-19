Return-Path: <linux-fsdevel+bounces-37877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50FD9F85CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 21:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15AC7A1948
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 20:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B31A4F1B;
	Thu, 19 Dec 2024 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vQ7OXFcl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E013D279
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639861; cv=none; b=ue2s1VCpju0g1N9xic9CoFgX4Gs9PDs12D54l/5/WogotaU050camzXaFetyoqcEruZowq7RkiMtbdgekcLFZaz5rje77zr5ZfyTkZ42CfbnDSXqFTs5/xqJATbmTr8cCKmUmlI/sE1fNzYt6SnjIyWVS8VkLOFGQLZpiQXfWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639861; c=relaxed/simple;
	bh=RA2ktsWodE7uY/f2+mqrPEnO14EwKojV13qbYitUL8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJa416I3EgUWw7upteOWUI3fFRf4ii4jhBe17Cz2gWbCxYxe/+hq6nYeaa0QVEMME+paSNQsADsY5oqOsrneNoQP7dCfIufE4RJvDi3gLyLa9oZDtZRWi327kiQF5npX6hBIHRbWb3UEwUhXyUhmcv4bFS4qqQA6zbbk0Frrk0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vQ7OXFcl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A2/D4DeH0ZBcOF8aXl0fNhMd+z5TxNm8Gqfq4xS8FVY=; b=vQ7OXFclA3lpxictEY5CFh6MBG
	1ymSCGtRTlatdu1YdwvPT1vQiZJF6yDZmVclo4vl2zJDSDn7qb4Aj1YbS8rkcq7lXl1ZOmjUo2s9J
	kIWlsXxGp2lR7jGsmzMHwudgykrjqYTSgWM1fNA27u1WPPeKW9K8h270diROPGFcAPxOBKDVuFLuI
	K+z2UYETlONR/YGKgjAAJJLTWyHNHJpKHbtk+tXAaIRZ8/OLwqv+F2D1NI72jGLVpOCyOdLSXFEy1
	STHqIUS1HEOnU9aYYEt+bBHNr/nveUdzT/Gt0z+jBcaoe3WMbLCrQFq36BJtolA7yZ3MUtIv2lJ2t
	AYIYK0Cw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tON46-00000005Eqv-0Qa4;
	Thu, 19 Dec 2024 20:24:10 +0000
Date: Thu, 19 Dec 2024 20:24:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 04/12] fuse: support large folios for writethrough
 writes
Message-ID: <Z2SA6Qi78hkNUmbw@casper.infradead.org>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
 <20241213221818.322371-5-joannelkoong@gmail.com>
 <c1c8b8043f5b724bce86d5c84430d4dbf6c1c207.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c8b8043f5b724bce86d5c84430d4dbf6c1c207.camel@kernel.org>

On Thu, Dec 19, 2024 at 01:08:15PM -0500, Jeff Layton wrote:
> > +		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
> 
> Just to save someone else going down the same rabbit hole:
> 
> copy_folio_from_iter_atomic() is defined as:
> 
> static inline size_t copy_folio_from_iter_atomic(struct folio *folio,
>                 size_t offset, size_t bytes, struct iov_iter *i)
> {
>         return copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
> }
> 
> ...which _looks_ sort of like it's not fully baked yet and can't handle
> a large folio, but it turns out that copy_page_from_iter_atomic() can
> handle compound pages, so I think this is actually OK. Whew!

Yes, this is fine.  I'd love to clean this up further.  If someone wants
the kudos of doing that, ntfs_compress_write() is your challenge.  It's
the only remaining caller of copy_page_from_iter_atomic() and
once it's converted to use folios, we can push folios deeper into
the iov_iter code.

