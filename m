Return-Path: <linux-fsdevel+bounces-16866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF968A3D97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F96B21490
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4493482C6;
	Sat, 13 Apr 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HFvMuqMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A1481A4
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713023989; cv=none; b=BJm0eB2Fab2BbDiC0mONlpwS+63GGnBhR2lGHxFrBIoQsmqkEgTr2ASHBEzoPQTzZT+BEi8iGtF/KkFr63UA9ajjNfGu+ZWqXUCTCcx2pwCMA+lXgwGSMQM8FBWyiqeOak+hPImYBxEVyykTKOiqp4a31Ci/C47/23Ih5stR4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713023989; c=relaxed/simple;
	bh=4MwUs/BK9jSXjqYOc6FTvSgrSf57/DDlDGfV3lp3FKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi21XrrtMXBfU18vh4NTBcnYnnn0uCjxZcdGyiXI3qio1h4dhu4ZaYK+4xljUZWM4n7EDs3eedUNNfhiRoPTVFYNGV8muZtbLZ5jluiNOloHJktJ78ia1NebIFvI3N/A4MK3NAhFzDYwKMKvYgGaCNdkrHd+TbM4YDglvzOh5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HFvMuqMy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ceduGatgIo/eee4hZRhtz1mIEiUQ8QR2B2vNAZ3bbuY=; b=HFvMuqMyV533mR/8CWrd2BgTEh
	nrHS+TE0ZZcqfude26/uK9w92+H2D0FlZIPItQca+daIGex9CdMbRgBscNQMwsyejrzZmJrFf9j0E
	lUPbsyVWe4FPe8Za/SEMUXRGq7LTIq/MwHkVfea26RR7+IY12TvFIFaY/Tc1GEY+0YYRWnir5KjU/
	Ihb/DMlvAopG8ojW77DWZHx7KtlOg5WTETdrAlIvnYxxM7CWXAI0axEM7WKLQ7O3s4Zb40GfZyFI2
	Rf2w93bQgWAm9QgWJ4UqN7m27M6v1EVxdA/+WayTpJ29bohUbHx+LQVtNziaAdA7oLlZi+I7t63sj
	+zs3W2nw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvfn6-0000000BfD9-2rOC;
	Sat, 13 Apr 2024 15:59:44 +0000
Date: Sat, 13 Apr 2024 16:59:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fuse: Convert fuse_writepage_locked to take a folio
Message-ID: <Zhqr8Kj0rraBCJDY@casper.infradead.org>
References: <20240228182940.1404651-1-willy@infradead.org>
 <20240228182940.1404651-2-willy@infradead.org>
 <13cbb507-45b5-48fb-a696-cb43ad14a5b2@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13cbb507-45b5-48fb-a696-cb43ad14a5b2@fastmail.fm>

On Sat, Apr 13, 2024 at 01:28:31PM +0200, Bernd Schubert wrote:
> On 2/28/24 19:29, Matthew Wilcox (Oracle) wrote:
> > The one remaining caller of fuse_writepage_locked() already has a folio,
> > so convert this function entirely.  Saves a few calls to compound_head()
> > but no attempt is made to support large folios in this patch.
>
> sorry for late review. The part I'm totally confused with (already
> without this patch), why is this handling a single page only and not the
> entire folio? Is it guaranteed that the folio has a single page only?

Hi Bernd,

, filesystems have to tell the VFS that they support large folios before
they'll see a large folio.  That's a call to mapping_set_large_folios()
today, although there's proposals to make that more granular.

If there's interest in supporting large folios in FUSE, I'm happy to
help, but my primary motivation is sorting out struct page, not fixing
individual filesystems.

