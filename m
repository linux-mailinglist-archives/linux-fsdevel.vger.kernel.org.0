Return-Path: <linux-fsdevel+bounces-9537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D28426B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 15:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C39281A21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603F6DD06;
	Tue, 30 Jan 2024 14:16:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3F6DCE8;
	Tue, 30 Jan 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624168; cv=none; b=CzaTPxWoGGAml0EdGV7eXO5QpJfjPT9/nXEZz0jXMsc6ztp/ve5vQ5m8WP57NgCq98zW8mQmUZVUmJ4z+xn/y43HYYDV8WElRseDidnGcyYJg/C+1xqha2VUulnH28uIIFYNmYKVw9qCRbirF+BQSQYxv/8AZCZoGx72rUAQYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624168; c=relaxed/simple;
	bh=ImXecEhuep996vGaWscJBS4axlSdLV1KhnIAesMx3bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA0stswuJyP7ZLuPv6KLqXt3Cnne3zZY5E/XWWSKmbAoUBdloDfIR1WKKOvJEfSxxb2JUIhH8ZpxipVrQxDrsQd/4olQgjwvRIkr+2zWOO5hhTnEq6GDFMC3C8lvKWxAhOkhJAUepBVyZMrG2O6FdKolrYtJTXUAZWxruiK4KIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9847868C4E; Tue, 30 Jan 2024 15:16:01 +0100 (CET)
Date: Tue, 30 Jan 2024 15:16:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <20240130141601.GA31330@lst.de>
References: <20240125085758.2393327-1-hch@lst.de> <20240125085758.2393327-20-hch@lst.de> <20240130104605.2i6mmdncuhwwwfin@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130104605.2i6mmdncuhwwwfin@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 11:46:05AM +0100, Jan Kara wrote:
> Looking at it now I'm thinking whether we would not be better off to
> completely dump the 'error' argument of writeback_iter() /
> writeback_iter_next() and just make all .writepage implementations set
> wbc->err directly. But that means touching all the ~20 writepage
> implementations we still have...

Heh.  I actually had an earlier version that looked at wbc->err in
the ->writepages callers.  But it felt a bit too ugly.

> > +		 */
> > +		if (wbc->sync_mode == WB_SYNC_NONE &&
> > +		    (wbc->err || wbc->nr_to_write <= 0))
> > +			goto finish;
> 
> I think it would be a bit more comprehensible if we replace the goto with:
> 			folio_batch_release(&wbc->fbatch);
> 			if (wbc->range_cyclic)
> 				mapping->writeback_index =
> 					folio->index + folio_nr_pages(folio);
> 			*error = wbc->err;
> 			return NULL;

I agree that keeping the logic on when to break and when to set the
writeback_index is good, but duplicating the batch release and error
assignment seems a bit suboptimal.  Let me know what you think of the
alternatіve variant below.

> > +	struct folio *folio = 0;
> 			     ^^ NULL please

Fixed.

> >  			ret = writeback_use_writepage(mapping, wbc);
> > +			if (!ret)
> > +				ret = wbc->err;
> 
> AFAICT this should not be needed as writeback_iter() made sure wbc->err is
> returned when set?

Heh.  That's a leftover from my above mentioned different attempt at
error handling and shouldn't have stayed in.

