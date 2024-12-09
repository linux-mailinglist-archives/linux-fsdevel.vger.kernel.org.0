Return-Path: <linux-fsdevel+bounces-36832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FC9E9A7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F77428207A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E641C5CAF;
	Mon,  9 Dec 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OSiYtp+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7A1BEF9F
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758102; cv=none; b=tm3/EmV1h9S/SQ/pCGRke18/6VL/wFK8p9rU0NixJUlzUoSu0eWlTnviep05JA+aUrZNYy5FQo6ycB+HFaNZzTcl9YZdNhJID/FcXrj09QOH7sMfaiZ1wG0r5rqv2ktu+mffNaLsxB4WUb78BgBY5RHJGY0eXkB2YvqotXljOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758102; c=relaxed/simple;
	bh=ge6wYI9hAm2KQy3Cidd0SSfkra5GRD0zuBcObht/wDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3WX2+VoAbzb+Sj/u2WtRshqItCIeF3B3/bbU9oLCviNC2kHmmNuIut+hEovvmdqBBZ6DeEhhLY4V2LCBnlk1qj/Y65R0jwPQl0heUtGG5Sjp7wLhyMI2elrnzpTUCfzHIkFOppl71ydUyetbHEQiW5kKVdpHtHsweLinCdn9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OSiYtp+E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dLFs6cg5+j4UdRrD5ma0qnljt4sdeHlzFIfRfH+7dYU=; b=OSiYtp+EcwzM7EYibuuRjhWFNN
	KwXxnFhCSLuzhV1W9KrV31iuhHZWBEe9P6TFK30m6yHJ6W5pCIr5JrixL9CN2GHImBWdFYk5WjPVK
	yIEuNAyxpDMWbt9WTK5dyKoqjeNtHyiR8K3OSz0xYe10iwMFb15LB8U6u0cxtjaFaxEMFXw/ZBphw
	ZM+wwJ8xLgzpohz7p8vt/n3z7ddPYIRSPclvmJ3ekr+8DaLrDzdI6/x1XX3m00ZQ+g27OdudeeC0Q
	TuCBjUW/XTuki9JpaSxlxdUguOZ+iIYXXU/bhuxWrG0rnBQ2mvF3I4bBfZN+km6d8v5Vzg4lNAYn+
	S73DV0GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKfgE-00000002x1s-2TJR;
	Mon, 09 Dec 2024 15:28:14 +0000
Date: Mon, 9 Dec 2024 15:28:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <Z1cMjlWfehN6ssRb@casper.infradead.org>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209144948.GE2840216@perftesting>

On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
> > Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
> > with 3b97c3652d91 as the culprit.
> 
> Willy, I've looked at this code and it does indeed look like a 1:1 conversion,
> EXCEPT I'm fuzzy about how how this works with large folios.  Previously, if we
> got a hugepage in, we'd get each individual struct page back for the whole range
> of the hugepage, so if for example we had a 2M hugepage, we'd fill in the
> ->offset for each "middle" struct page as 0, since obviously we're consuming
> PAGE_SIZE chunks at a time.
> 
> But now we're doing this
> 
> 	for (i = 0; i < nfolios; i++)
> 		ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> 
> So if userspace handed us a 2M hugepage, page_folio() on each of the
> intermediary struct page's would return the same folio, correct?  So we'd end up
> with the wrong offsets for our fuse request, because they should be based from
> the start of the folio, correct?

I think you're 100% right.  We could put in some nice asserts to check
this is what's happening, but it does seem like a rather incautious
conversion.  Yes, all folios _in the page cache_ for fuse are small, but
that's not guaranteed to be the case for folios found in userspace for
directio.  At least the comment is wrong, and I'd suggest the code is too.

