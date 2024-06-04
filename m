Return-Path: <linux-fsdevel+bounces-20939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E861C8FAFDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 12:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC21F238BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 10:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770D0144D02;
	Tue,  4 Jun 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="rp6HJoAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2329401;
	Tue,  4 Jun 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496981; cv=none; b=PWbM3M/8aTmw4tC+YVoU1GrOLmNJr+r2hx++QH7rpRtubRkNeQ7p5bMnn3fJzyeiVzmiNQq8pygO9CZ8n0eIlB2l2tRRD/E8kxuMuJeNgTlQTR3wUqm3XyrcbIClgOszNB2ue9yxzcCpjl5wi7v19oC5iM0lSpAARsge9MYrHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496981; c=relaxed/simple;
	bh=BQ+qiq72QPdaBXb30EQGfPMHadzeqg43TjzADDa4iJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6Mr6sxo3byVovmgpJxFDHr3vzE7ZQuRRP7QKitZsmcZZsIwRwsKi/LUex98YEGkNNb0U8H/Vq/eI0eHFg1yxdMhh0FqBgXF5G/naZydm+0F+pWe87h92oBdwS9al7YZz/O4NZXLk/x+rR7KjAyjFVCx0fR7ocqNMZMPIv5QcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=rp6HJoAr; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Vtmzt1dBjz9sS2;
	Tue,  4 Jun 2024 12:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717496970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6DG7DXE2JJh9dM3bhGo7RQTMbF5V2xeF0wZaeXe7lOs=;
	b=rp6HJoAr4fgn8D/Lj3iM+i2F/Bkkah1tOkbOY3bFKl3+D6oskWV+IVl4f4fY7q49kt4oJY
	PecYhtX+D45PzWEvv0NaHqK+hDsMs1YUuzzdS02RRSMarCRks2Zh+RxHJAEv7lPhiecDGT
	O4RHqW3zPVzx+TjgEPU6GT1fveYC5d+NpIRI23HIpf4KndEokN/ti0YAjO10KfJfT8JVl3
	D397p4GHT6fAhAWQyZ54Vx3o0yDI1oDRZfzRWLzy+qZcoNBb0DnOjyMqPZVvVZFX5axh7N
	DjrOhaIEALi7giAnw0mqMUlY0PCNOnLlOJkHlkH3aHfHlm+S8+0KypkCo1uuSg==
Date: Tue, 4 Jun 2024 10:29:24 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, chandan.babu@oracle.com, akpm@linux-foundation.org,
	brauner@kernel.org, djwong@kernel.org, linux-kernel@vger.kernel.org,
	hare@suse.de, john.g.garry@oracle.com, gost.dev@samsung.com,
	yang@os.amperecomputing.com, p.raghav@samsung.com,
	cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
	mcgrof@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 05/11] mm: split a folio in minimum folio order chunks
Message-ID: <20240604102924.u6n35x4rfzdvis3l@quentin>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-6-kernel@pankajraghav.com>
 <Zl243qf2WiPHIMWN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl243qf2WiPHIMWN@casper.infradead.org>
X-Rspamd-Queue-Id: 4Vtmzt1dBjz9sS2

On Mon, Jun 03, 2024 at 01:36:46PM +0100, Matthew Wilcox wrote:
> On Wed, May 29, 2024 at 03:45:03PM +0200, Pankaj Raghav (Samsung) wrote:
> > @@ -3572,14 +3600,19 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
> >  
> >  	for (index = off_start; index < off_end; index += nr_pages) {
> >  		struct folio *folio = filemap_get_folio(mapping, index);
> > +		unsigned int min_order, target_order = new_order;
> >  
> >  		nr_pages = 1;
> >  		if (IS_ERR(folio))
> >  			continue;
> >  
> > -		if (!folio_test_large(folio))
> > +		if (!folio->mapping || !folio_test_large(folio))
> >  			goto next;
> 
> This check is useless.  folio->mapping is set to NULL on truncate,
> but you haven't done anything to prevent truncate yet.  That happens
> later when you lock the folio.
> 
> > +		min_order = mapping_min_folio_order(mapping);
> 
> You should hoist this out of the loop.
> 
> > +		if (new_order < min_order)
> > +			target_order = min_order;
> > +
> >  		total++;
> >  		nr_pages = folio_nr_pages(folio);
> >  
> > @@ -3589,7 +3622,18 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
> >  		if (!folio_trylock(folio))
> >  			goto next;
> >  
> > -		if (!split_folio_to_order(folio, new_order))
> > +		if (!folio_test_anon(folio)) {
> 
> Please explain how a folio _in a file_ can be anon?
> 
> > +			unsigned int min_order;
> > +
> > +			if (!folio->mapping)
> > +				goto next;
> > +
> > +			min_order = mapping_min_folio_order(folio->mapping);
> > +			if (new_order < target_order)
> > +				target_order = min_order;
> 
> Why is this being repeated?
> 
> > +		}

You are right. There are some repetition and checks that are not needed.
I will clean this function for the next revision. 

Thanks.

--
Pankaj

