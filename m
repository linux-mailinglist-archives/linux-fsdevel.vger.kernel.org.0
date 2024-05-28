Return-Path: <linux-fsdevel+bounces-20315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9638D1606
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F154B21349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B813D8B3;
	Tue, 28 May 2024 08:12:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FA13D8A6;
	Tue, 28 May 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883975; cv=none; b=FQm3FSezYrhxHhIutXjpvNpuHMR/QIEfeXiCJqMupqMp7Xbf4aVX7Yn6S146Qy7R+HulqZFzTqCTDsDiFFawH778L/1rUzVCvzRP9xd3jmUvv4bfZkJBeCQo+Z2jivuL0WcZh6MvYw1cV+xglFaRObilw8QkqzUvK/Id5O6hzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883975; c=relaxed/simple;
	bh=IzUbOSJv1UNWlKPQlFqYVLQlt6cBtVdIllaKtcWGvu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OErWuAkWkzyuhNXKf/OOZlPwunekVFJRRPvpvjmB4Fp7t3W83aML6TkPsvCzLB5MF2pKCv4J/74C9gb5CYyuUAhfbwM36P+gVk5vbpUjJy/9LC/pRqXgJ40q/fjCqg3htT2yVDIk2/TcxhdKtWeJ5pbBIaJ2ltRrcWy1naAx3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF8E568B05; Tue, 28 May 2024 10:12:48 +0200 (CEST)
Date: Tue, 28 May 2024 10:12:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] filemap: Convert generic_perform_write() to
 support large folios
Message-ID: <20240528081248.GA3192@lst.de>
References: <20240527163616.1135968-1-hch@lst.de> <20240527163616.1135968-2-hch@lst.de> <ZlTOLsrhD4P4Yiwl@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlTOLsrhD4P4Yiwl@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 27, 2024 at 07:17:18PM +0100, Matthew Wilcox wrote:
> Could you remind me why we need to call flush_dcache_folio() in
> generic_perform_write() while we don't in iomap_write_iter()?

> > -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> > -		flush_dcache_page(page);
> > +		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> > +		flush_dcache_folio(folio);
> 
> (this one has no equivalent in iomap)

The iomap equivalent is in __iomap_write_end and iomap_write_end_inline
and block_write_end.


