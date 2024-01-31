Return-Path: <linux-fsdevel+bounces-9643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B5843FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD011F2A87E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806707AE5E;
	Wed, 31 Jan 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+TVZIwA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5FC79DAF
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705356; cv=none; b=PSSBdsMbQUAkd2wJmIouRoSUcR56mpc1lAspMr91RGbQUzGD5BI9MDG/6U46ZDn/DB+antDGMo3bh5m//ddY4PBZFGhaVr6x0TtqV+zB06SqbXSwTsul4Mw0k1iupnyNvOuODTbVr5M1qi87rZoLvLOcvk2Bd+/H3QnGg3fcZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705356; c=relaxed/simple;
	bh=Ncen0jClhMW7H0Sb27fz8K4AJgq762EtNuN0mV5UGwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE7z/1JvTH1KNZ+eOilWrbIiPCmekYRY66Ruyo75W8qvMBLeyHyAbwBtqbloOrG+x1+/jkTj18wXmrSdmSAH8hit393VrnZhPthTM5eILdPmrWqZ3PIYVdOijqzqgaePL2bW1NJ1lrGwM6Rw4Bb3CPFJgH+eiH9AlMy4RUxPYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+TVZIwA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706705353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scKPr+8Cf62Gt7irmdBRvL9FpKHGVZHfUDxCP6SwrZo=;
	b=V+TVZIwAGviB6PHsw0gShwrPk1RDiZOZiTGfGZWNGv+cSspOFmun/q0AXzo7+DVU9v4eSV
	IBuNSSWuRUq4DzDZpW2WTz4XOP7wuLx5OLExNqyio+4b4n1ds5pVJQzqrJs7ZGA2Zjy8IF
	jp2jmSk0lAAm4efpJc3a+DelIzipQ6o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-PLiBSkJGPCiyOB6yhWpA8A-1; Wed,
 31 Jan 2024 07:49:08 -0500
X-MC-Unique: PLiBSkJGPCiyOB6yhWpA8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 548B2285F98F;
	Wed, 31 Jan 2024 12:49:07 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C174B1C060B3;
	Wed, 31 Jan 2024 12:49:06 +0000 (UTC)
Date: Wed, 31 Jan 2024 07:50:25 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <ZbpCEagJOh61eH6M@bfoster>
References: <20240125085758.2393327-1-hch@lst.de>
 <20240125085758.2393327-20-hch@lst.de>
 <20240130104605.2i6mmdncuhwwwfin@quack3>
 <20240130141601.GA31330@lst.de>
 <20240130215016.npofgza5nmoxuw6m@quack3>
 <20240131071437.GA17336@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131071437.GA17336@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Wed, Jan 31, 2024 at 08:14:37AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 30, 2024 at 10:50:16PM +0100, Jan Kara wrote:
> > Well, batch release needs to be only here because if writeback_get_folio()
> > returns NULL, the batch has been already released by it.
> 
> Indeed.
> 
> > So what would be
> > duplicated is only the error assignment. But I'm fine with the version in
> > the following email and actually somewhat prefer it compared the yet
> > another variant you've sent.
> 
> So how about another variant, this is closer to your original suggestion.
> But I've switched around the ordered of the folio or not branches
> from my original patch, and completely reworked and (IMHO) improved the
> comments.  it replaces patch 19 instead of being incremental to be
> readable:
> 

Not a thorough review but at first glance I like it. I think the direct
function call makes things easier to follow. Just one quick thought...

...
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0763c4353a676a..eefcb00cb7b227 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
...
> @@ -2458,60 +2433,107 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
>  	return folio;
>  }
>  
...
> +struct folio *writeback_iter(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio, int *error)
>  {
> -	if (wbc->range_cyclic)
> -		wbc->index = mapping->writeback_index; /* prev offset */
> -	else
> -		wbc->index = wbc->range_start >> PAGE_SHIFT;
> -
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag_pages_for_writeback(mapping, wbc->index, wbc_end(wbc));
> -
> -	wbc->err = 0;
> -	folio_batch_init(&wbc->fbatch);
> -	return writeback_get_folio(mapping, wbc);
> -}
> +	if (!folio) {
> +		folio_batch_init(&wbc->fbatch);
> +		wbc->err = 0;

The implied field initialization via !folio feels a little wonky to me
just because it's not clear from the client code that both fields must
be initialized. Even though the interface is simpler, I wonder if it's
still worth having a dumb/macro type init function that at least does
the batch and error field initialization.

Or on second thought maybe having writeback_iter() reset *error as well
on folio == NULL might be a little cleaner without changing the
interface....

Brian

>  
> -struct folio *writeback_iter_next(struct address_space *mapping,
> -		struct writeback_control *wbc, struct folio *folio, int error)
> -{
> -	unsigned long nr = folio_nr_pages(folio);
> +		/*
> +		 * For range cyclic writeback we remember where we stopped so
> +		 * that we can continue where we stopped.
> +		 *
> +		 * For non-cyclic writeback we always start at the beginning of
> +		 * the passed in range.
> +		 */
> +		if (wbc->range_cyclic)
> +			wbc->index = mapping->writeback_index;
> +		else
> +			wbc->index = wbc->range_start >> PAGE_SHIFT;
>  
> -	wbc->nr_to_write -= nr;
> +		/*
> +		 * To avoid livelocks when other processes dirty new pages, we
> +		 * first tag pages which should be written back and only then
> +		 * start writing them.
> +		 *
> +		 * For data-integrity sync we have to be careful so that we do
> +		 * not miss some pages (e.g., because some other process has
> +		 * cleared the TOWRITE tag we set).  The rule we follow is that
> +		 * TOWRITE tag can be cleared only by the process clearing the
> +		 * DIRTY tag (and submitting the page for I/O).
> +		 */
> +		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +			tag_pages_for_writeback(mapping, wbc->index,
> +					wbc_end(wbc));
> +	} else {
> +		wbc->nr_to_write -= folio_nr_pages(folio);
>  
> -	/*
> -	 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
> -	 * Eventually all instances should just unlock the folio themselves and
> -	 * return 0;
> -	 */
> -	if (error == AOP_WRITEPAGE_ACTIVATE) {
> -		folio_unlock(folio);
> -		error = 0;
> +		/*
> +		 * For integrity writeback  we have to keep going until we have
> +		 * written all the folios we tagged for writeback prior to
> +		 * entering the writeback loop, even if we run past
> +		 * wbc->nr_to_write or encounter errors, and just stash away
> +		 * the first error we encounter in wbc->err so that it can
> +		 * be retrieved on return.
> +		 *
> +		 * This is because the file system may still have state to clear
> +		 * for each folio.  We'll eventually return the first error
> +		 * encountered.
> +		 */
> +		if (wbc->sync_mode == WB_SYNC_ALL) {
> +			if (*error && !wbc->err)
> +				wbc->err = *error;
> +		} else {
> +			if (*error || wbc->nr_to_write <= 0)
> +				goto done;
> +		}
>  	}
>  
> -	if (error && !wbc->err)
> -		wbc->err = error;
> +	folio = writeback_get_folio(mapping, wbc);
> +	if (!folio) {
> +		/*
> +		 * For range cyclic writeback not finding another folios means
> +		 * that we are at the end of the file.  In that case go back
> +		 * to the start of the file for the next call.
> +		 */
> +		if (wbc->range_cyclic)
> +			mapping->writeback_index = 0;
>  
> -	/*
> -	 * For integrity sync  we have to keep going until we have written all
> -	 * the folios we tagged for writeback prior to entering the writeback
> -	 * loop, even if we run past wbc->nr_to_write or encounter errors.
> -	 * This is because the file system may still have state to clear for
> -	 * each folio.   We'll eventually return the first error encountered.
> -	 *
> -	 * For background writeback just push done_index past this folio so that
> -	 * we can just restart where we left off and media errors won't choke
> -	 * writeout for the entire file.
> -	 */
> -	if (wbc->sync_mode == WB_SYNC_NONE &&
> -	    (wbc->err || wbc->nr_to_write <= 0)) {
> -		writeback_finish(mapping, wbc, folio->index + nr);
> -		return NULL;
> +		/*
> +		 * Return the first error we encountered (if there was any) to
> +		 * the caller now that we are done.
> +		 */
> +		*error = wbc->err;
>  	}
> +	return folio;
>  
> -	return writeback_get_folio(mapping, wbc);
> +done:
> +	if (wbc->range_cyclic)
> +		mapping->writeback_index = folio->index + folio_nr_pages(folio);
> +	folio_batch_release(&wbc->fbatch);
> +	return NULL;
>  }
>  
>  /**
> @@ -2549,13 +2571,18 @@ int write_cache_pages(struct address_space *mapping,
>  		      struct writeback_control *wbc, writepage_t writepage,
>  		      void *data)
>  {
> -	struct folio *folio;
> -	int error;
> +	struct folio *folio = NULL;
> +	int error = 0;
>  
> -	for_each_writeback_folio(mapping, wbc, folio, error)
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
>  		error = writepage(folio, wbc, data);
> +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			error = 0;
> +		}
> +	}
>  
> -	return wbc->err;
> +	return error;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> @@ -2563,13 +2590,17 @@ static int writeback_use_writepage(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
>  	struct blk_plug plug;
> -	struct folio *folio;
> -	int err;
> +	struct folio *folio = NULL;
> +	int err = 0;
>  
>  	blk_start_plug(&plug);
> -	for_each_writeback_folio(mapping, wbc, folio, err) {
> +	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
>  		err = mapping->a_ops->writepage(&folio->page, wbc);
>  		mapping_set_error(mapping, err);
> +		if (err == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			err = 0;
> +		}
>  	}
>  	blk_finish_plug(&plug);
>  
> 


