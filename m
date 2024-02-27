Return-Path: <linux-fsdevel+bounces-12982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D41869C46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BD31C237C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C224A03;
	Tue, 27 Feb 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="zKnK8Qvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D80208BC;
	Tue, 27 Feb 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051787; cv=none; b=WQMiazr67OJh63CBn1BqX3MLxcTlp6Xi+VncPYcIklnbS4l2rdJ5vHqDf4qMdVrZ1WlKhY0O1c3s9ntH0UqBBg+g4OuRkAk/D6eZeROc/tMArobMLzlQpZUYVLJUHTJ4MxUYLV1WEFwmPp1U3nuPkhw+eWw0ajLMvkh8xSHqdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051787; c=relaxed/simple;
	bh=56oLOLwk+0gzok5ycHglBLAXhW+Lr4Bu/G6v4VE4XZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNaLLEWLjdPh7Oo1O6PVarRSUASwYfVnGxBvnwUWN9kxn5V6kUyOxHN2NdpH2+AeNNogkik01JAGsXOGAuWWlJrSu/a6HXkcbDleBmFsLh8FfXJ+Mko84XrXysCchhAF9VHHYYXgvlRWJhpxbOjScryZ1RVkLe97ZXDwEsVCg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=zKnK8Qvr; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TkjmH6yx6z9t2X;
	Tue, 27 Feb 2024 17:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709051776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdhs1FEp5gPtmyBg0kWiOrlktwzBd+wjBwP3BuiHBaE=;
	b=zKnK8QvrJXzjKjS+Q9MFJDjxT+rFc7LPUTwybsZgCYmh+0cbaj2tG/worixAKv8y4aKEDa
	iOgWAHXgW/GJBVw6WFFvPMLjC3+cSK19SnWLTqzVLTUP+EYJuMp6WPdjWsv1YBY0YnqKho
	3yhclwkoIJ+zqGRT2z0mt404JkTYzlMcPYUky816izVPVkbWS8TIW2wysjGImlec77RfBx
	Ue/qAm/QpydURkP6ukM3f7U7LOMgMk4kvy+oIOd1hIbZT5VZo8EtscF44DxTobcl/MQ4aW
	WMXPXrfJRQM6eIFBPFRoNxhxfsqIrnLZbS50St2ls0iYnh46cBTDgheaM0bmtg==
Date: Tue, 27 Feb 2024 17:36:09 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, david@fromorbit.com, 
	chandan.babu@oracle.com, akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, 
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 03/13] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <aajarho6xwi4sphqirwvukofvqy3cl6llpe5fetomj5sz7rgzp@xo2iqdwingtf>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-4-kernel@pankajraghav.com>
 <Zdyi6lFDAHXi8GPz@casper.infradead.org>
 <37kubwweih4zwvxzvjbhnhxunrafawdqaqggzcw6xayd6vtrfl@dllnk6n53akf>
 <hjrsbb34ghop4qbb6owmg3wqkxu4l42yrekshwfleeqattscqp@z2epeibc67lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hjrsbb34ghop4qbb6owmg3wqkxu4l42yrekshwfleeqattscqp@z2epeibc67lt>

On Tue, Feb 27, 2024 at 11:22:24AM -0500, Kent Overstreet wrote:
> On Tue, Feb 27, 2024 at 11:06:37AM +0100, Pankaj Raghav (Samsung) wrote:
> > On Mon, Feb 26, 2024 at 02:40:42PM +0000, Matthew Wilcox wrote:
> > > On Mon, Feb 26, 2024 at 10:49:26AM +0100, Pankaj Raghav (Samsung) wrote:
> > > > From: Luis Chamberlain <mcgrof@kernel.org>
> > > > 
> > > > Supporting mapping_min_order implies that we guarantee each folio in the
> > > > page cache has at least an order of mapping_min_order. So when adding new
> > > > folios to the page cache we must ensure the index used is aligned to the
> > > > mapping_min_order as the page cache requires the index to be aligned to
> > > > the order of the folio.
> > > 
> > > This seems like a remarkably complicated way of achieving:
> > > 
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 5603ced05fb7..36105dad4440 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -2427,9 +2427,11 @@ static int filemap_update_page(struct kiocb *iocb,
> > >  }
> > >  
> > >  static int filemap_create_folio(struct file *file,
> > > -		struct address_space *mapping, pgoff_t index,
> > > +		struct address_space *mapping, loff_t pos,
> > >  		struct folio_batch *fbatch)
> > >  {
> > > +	pgoff_t index;
> > > +	unsigned int min_order;
> > >  	struct folio *folio;
> > >  	int error;
> > >  
> > > @@ -2451,6 +2453,8 @@ static int filemap_create_folio(struct file *file,
> > >  	 * well to keep locking rules simple.
> > >  	 */
> > >  	filemap_invalidate_lock_shared(mapping);
> > > +	min_order = mapping_min_folio_order(mapping);
> > > +	index = (pos >> (min_order + PAGE_SHIFT)) << min_order;
> > 
> > That is some cool mathfu. I will add a comment here as it might not be
> > that obvious to some people (i.e me).
> 
> you guys are both wrong, just use rounddown()

Umm, what do you mean just use rounddown? rounddown to ...?

We need to get index that are in PAGE units but aligned to min_order
pages.

The original patch did this:

index = mapping_align_start_index(mapping, iocb->ki_pos >> PAGE_SHIFT);

Which is essentially a rounddown operation (probably this is what you
are suggesting?).

So what willy is proposing will do the same. To me, what I proposed is
less complicated but to willy it is the other way around.
 

