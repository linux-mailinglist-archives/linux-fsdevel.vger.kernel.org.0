Return-Path: <linux-fsdevel+bounces-9804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61122845064
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 05:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E421C23236
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE253B7AA;
	Thu,  1 Feb 2024 04:42:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F23BB21;
	Thu,  1 Feb 2024 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762572; cv=none; b=NnpcOhV8od123owkjn8OpXpBq1a+IY+Lrd7btQlkD94g1+v+ClSAK0GQt2RKqbaqY2q0UT22KA1lEN86ldob0ozxv7tvKkKuwT+ea4Wj90VCxkyo1xDIzyim5pDAmLDKnUWJB97h5OOvRAAwlmdsiP2Y5766qdajJ6TLp5lPeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762572; c=relaxed/simple;
	bh=MhL63WgwsFxDJhAoegljqRueB5JQHLx3QCQjicgGBoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBduv3Cf475tJgiu9G/ajlPKkwMo8d6iI0u18G/oDRKk5gPjowmGLzbZq5YRZEgHmiR03On7VKAYlkf2cG0mFsAJzax4/qGoX5ALeN8l5roDsjbgIdh16eY+nv47aESjHF/tZbuxZ8952nggETDvl8PMOBiPgkGzP1rnUZVdTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE27468AFE; Thu,  1 Feb 2024 05:42:46 +0100 (CET)
Date: Thu, 1 Feb 2024 05:42:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: Introduce buffered_write_operations
Message-ID: <20240201044246.GA14117@lst.de>
References: <20240130055414.2143959-1-willy@infradead.org> <20240130055414.2143959-2-willy@infradead.org> <20240130081252.GC22621@lst.de> <ZbsfuaANd4DIVb4w@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbsfuaANd4DIVb4w@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 01, 2024 at 04:36:09AM +0000, Matthew Wilcox wrote:
> +static struct folio *iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> +               size_t len)
> 
> with corresponding changes.  Again, ends up looking slightly cleaner.

iomap also really needs some tweaks to the naming in the area as a
__foo function calling foo as the default is horrible.  I'll take a
look at your patches and can add that on top.

> f2fs also doesn't seem terribly objectional; passing rpages between
> begin & end.
> 
> ocfs2 is passing a ocfs2_write_ctxt between the two.

Well, it might be the intended purpose, but as-is it is horribly
inefficient - they need to do a dynamic allocation for every
page they iterate over.  So all of them are candidates for an
iterator model that does this allocation once per write.

But maybe this isn't the time to deal with that and we should just leave
it in place.

