Return-Path: <linux-fsdevel+bounces-35934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D559D9D93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 19:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4623167F42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881EB1DE2CE;
	Tue, 26 Nov 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EU98cgwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D01DDC16;
	Tue, 26 Nov 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646580; cv=none; b=W0AuorioSP1As/APtPuc5tJdFymYh8oDOk6j6ousrPOAZ7jgIqDB/CojMrQSU+IINxqMtTtkYkyRdORCY2PyUFTWHvN0opbgrAjYXa9gElCVeuEkER/evS6jWvQJGThaUIvvRMseXgBb3h3zxdjXkOf/bTkAwERHUfs9aiKML5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646580; c=relaxed/simple;
	bh=pdLlhqynYqMly/XoYmkTY7q0UuiPTRMmYfkdnLd7xDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSiwLFr6c7soBzsP3MgtJUOh5KCymgRg5Q3ExsFP5g02tmj78QUkB36MI0whCcwxm58qxRH/EM13cZtrJMisT0ws0ggvl7kRscaCv7zX0Egrkoc7ax7O4H+CMPnjoHqhEraD/dyhJ19bbe7jSR98QduMBXLGelcs62LWoq3J6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EU98cgwj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iAMc31dd9MJkrpOFEbxZ+AE1N40iVg3cqLAXQKJHJ1A=; b=EU98cgwj9wlugyVXUEVULw592y
	QHqWpo0D00gREC10/6OCe1KDhwWIfabi1dmU4JzMcKTYLsfO78El+k4fmjHd+27tE3jCxh3XaXeLY
	GQVLlz+qGQDTkZ3Dx6cY3XqT4FMIXbvhQLN1TtzN6LVGm0cRHfH5TCCqW4hW+wbyHLXGS41FpdHQo
	Aou0aACX237d20dR8b3PfMcCXct58/RH1Rtm/+xbLQY/+C151Hzi6PeYfvc3P57XcX+3QK/WC4UA0
	J9R96ppHhjCr/WG+/YbfpQliCcSswGvlE8exKBL2wEUllc/2Ueg0R8r+9KXALvmxBlp+8O30Sfrzs
	rO/FWAGA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tG0WU-00000000Jfd-17G8;
	Tue, 26 Nov 2024 18:42:54 +0000
Date: Tue, 26 Nov 2024 18:42:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Philippe Troin <phil@fifi.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>
Subject: Re: Regression in NFS probably due to very large amounts of readahead
Message-ID: <Z0YWrvnz5rYcYrjV@casper.infradead.org>
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
 <20241126103719.bvd2umwarh26pmb3@quack3>
 <20241126150613.a4b57y2qmolapsuc@quack3>
 <fba6bc0c-2ea8-467c-b7ea-8810c9e13b84@gmail.com>
 <Z0X9hnjBEWXcVms-@casper.infradead.org>
 <569d0df0-71d5-4227-aa28-e57cd60bc9f1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569d0df0-71d5-4227-aa28-e57cd60bc9f1@gmail.com>

On Tue, Nov 26, 2024 at 06:26:13PM +0100, Anders Blomdell wrote:
> On 2024-11-26 17:55, Matthew Wilcox wrote:
> > On Tue, Nov 26, 2024 at 04:28:04PM +0100, Anders Blomdell wrote:
> > > On 2024-11-26 16:06, Jan Kara wrote:
> > > > Hum, checking the history the update of ra->size has been added by Neil two
> > > > years ago in 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't
> > > > process all pages"). Neil, the changelog seems as there was some real
> > > > motivation behind updating of ra->size in read_pages(). What was it? Now I
> > > > somewhat disagree with reducing ra->size in read_pages() because it seems
> > > > like a wrong place to do that and if we do need something like that,
> > > > readahead window sizing logic should rather be changed to take that into
> > > > account? But it all depends on what was the real rationale behind reducing
> > > > ra->size in read_pages()...
> > > 
> > > My (rather limited) understanding of the patch is that it was intended to read those pages
> > > that didn't get read because the allocation of a bigger folio failed, while not redoing what
> > > readpages already did; how it was actually going to accomplish that is still unclear to me,
> > > but I even don't even quite understand the comment...
> > > 
> > > 	/*
> > > 	 * If there were already pages in the page cache, then we may have
> > > 	 * left some gaps.  Let the regular readahead code take care of this
> > > 	 * situation.
> > > 	 */
> > > 
> > > the reason for an unchanged async_size is also beyond my understanding.
> > 
> > This isn't because we couldn't allocate a folio, this is when we
> > allocated folios, tried to read them and we failed to submit the I/O.
> > This is a pretty rare occurrence under normal conditions.
> 
> I beg to differ, the code is reached when there is
> no folio support or ra->size < 4 (not considered in
> this discussion) or falling throug when !err, err
> is set by:
> 
>         err = ra_alloc_folio(ractl, index, mark, order, gfp);
>                 if (err)
>                         break;
> 
> isn't the reading done by:
> 
>         read_pages(ractl);
> 
> which does not set err!

You're misunderstanding.  Yes, read_pages() is called when we fail to
allocate a fresh folio; either because there's already one in the
page cache, or because -ENOMEM (or if we raced to install one), but
it's also called when all folios are normally allocated.  Here:

        /*
         * Now start the IO.  We ignore I/O errors - if the folio is not
         * uptodate then the caller will launch read_folio again, and
         * will then handle the error.
         */
        read_pages(ractl);

So at the point that read_pages() is called, all folios that ractl
describes are present in the page cache, locked and !uptodate.

After calling aops->readahead() in read_pages(), most filesystems will
have consumed all folios described by ractl.  It seems that NFS is
choosing not to submit some folios, so rather than leave them sitting
around in the page cache, Neil decided that we should remove them from
the page cache.

