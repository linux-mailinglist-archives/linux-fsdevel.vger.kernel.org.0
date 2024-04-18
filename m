Return-Path: <linux-fsdevel+bounces-17246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A068A99BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 14:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3B31F216EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618415F404;
	Thu, 18 Apr 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D/g3O9yx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7815D5D6
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443259; cv=none; b=MBsi9Y26puGnb9T2rGrlT2DvFzidbOWuG5+KCdL6YlBDn0sc+MjHh2ACpO5rE1b6AlYTxmRTU6SdrDA9JMIY2WyCYaR4TjiypNpqPpv4GiA+hLDQTaIax0QW/9wg2crgAfp8pY31XiajGTqAwTkYcrj88Lql15Ea/QsZ5otpQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443259; c=relaxed/simple;
	bh=VIeNIftQYcpb93uO7n1Lh+PzTU8AanovUrEJ5CPBI68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZfSZwKF6f7H1of3PkyntLSbkZX5Z20/nCeIjP3EerUYMzg3NexbFs4Puk/5VPsTbQcV72OY5qPd+t+H16V0K5CqNfXgiJKKUjP+EfLMVl6KkX3YUiYBz/ejOqqjxHX5I5faoJl5unaoCahXB0Tp+pYy/JUs5hvj9PtlcwuxO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D/g3O9yx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cQwFEXNPyIvISI4PpUGgJ1EHNiW/7E5erKCd2114Qb8=; b=D/g3O9yxKDQZ9DO5gDiF6qNs7y
	i9yUYjLC2BzxMybYZSqm+Z02lTuzBS3YHW5Cmul3RxaY00h9bk7a0r+hNgYLOFvb/BBnYRhDcGcUT
	frda4Gupo53veVCVNI/uLtHEBnIZqpAd0yhgGu6Pr6zIz8nv+kpQpqyKrGxeibHCJ3m8q0NfZDPfF
	3OrHELaw7NUjmi2/SSXIgTfjv5U97nJh3SeWeiy/DguJy460SruB71CJ5/gLmFGelz2K5MG2K2P71
	eDRFnoGTPsrsBcGMSgIw8vM+WwkzZk12GS9MjALXBpocU5GOXi1ed1W1Dp8/XrM31NVCJK21ondQM
	0Y0DNiww==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxQrX-00000005JVm-11Ay;
	Thu, 18 Apr 2024 12:27:35 +0000
Date: Thu, 18 Apr 2024 13:27:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] udf: Convert udf_symlink_filler() to use a folio
Message-ID: <ZiERt6j_zTDrFC_3@casper.infradead.org>
References: <20240417150416.752929-1-willy@infradead.org>
 <20240417150416.752929-2-willy@infradead.org>
 <20240418103734.kdr5u3556wyt3zgw@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418103734.kdr5u3556wyt3zgw@quack3>

On Thu, Apr 18, 2024 at 12:37:34PM +0200, Jan Kara wrote:
> On Wed 17-04-24 16:04:07, Matthew Wilcox (Oracle) wrote:
> > Remove the conversion to struct page and use folio APIs throughout.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Looks good. I've just noticed this removes the SetPageError(). Grepping for
> a while we seem to set/clear that in quite some places in the filesystems
> but nobody is reading it these days (to be fair jfs has one test and btrfs
> also one)? And similarly with folio_test_error... I have a recollection
> this was actually used in the past but maybe you've removed it as part of
> folio overhaul? Anyway, either something should start using the error bit
> or we can drop the dead code and free up a page flags bit. Yay.

Right, the VFS never checks PageError nor folio_test_error.  It's purely
a filesystem-internal-use flag at this point.  I think buffer.c used
to test it, but only locally, so I turned it into a local bool.  So all
the places in filesystems which set/clear it can be removed ... except
for the filesystems which check it.

I'd love to reclaim that flag, I just need to figure out how to remove
the few remaining places that check it.  The btrfs usage is awful because
PageError was _supposed_ to be used for read errors, but they're using
it for writeback errors.  And they're using that flag on the bdev's page
cache, not even their own page cache.  It's also buggy for machines with
PAGE_SIZE > 4kB; it's just that writeback errors are rare, so they get
away with it.  I had a go at fixing it once, but failed.

JFS is more straightforward; I think I can use a bit in struct metapage
as a replacement read error flag.  I should probably have another go at
fixing these two and then I can reclaim PG_error.


