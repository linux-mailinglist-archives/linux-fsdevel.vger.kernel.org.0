Return-Path: <linux-fsdevel+bounces-78928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEkuB8GppWmpDgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:16:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D71DB9F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6715F306AE12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6594014AC;
	Mon,  2 Mar 2026 15:06:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A84014B1;
	Mon,  2 Mar 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464001; cv=none; b=NC/kyiCMKR8VSzcMCZeK4rORZjr595WCHhQYofH7Gl/4uEpqUFXRI32becLJM87Z6dvceV2ywM6bzw5x5nqFHJtvrNndgJlnq4MWJIe+VOBCaotka/ufsW8JfR3PBAWf+pv6olsfVCaDebsLpOeKij226XGtH5GfxefodCkt9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464001; c=relaxed/simple;
	bh=5744P+pGK+XyXUbnqiUcR4ppK8KbZz/PvWksth+Oz8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLrwPqpp39ky0LAkukojJS/E/jCcauI6r7IM25VW5y3eVNf9C8fx8AXbQOwR+FIqneHGutlIeKo+Ss+ZqluGcHAIAMUFw8v6AWIUuvNv9mWKR0tJZUoUMUjQs+E1412NH7AzIj9+JcIT8vnP3eN7L4GQngQLEIj2RwgC22DErp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 13A571A01BC;
	Mon,  2 Mar 2026 15:06:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf05.hostedemail.com (Postfix) with ESMTPA id 2235B20010;
	Mon,  2 Mar 2026 15:06:25 +0000 (UTC)
Date: Mon, 2 Mar 2026 09:06:23 -0600
From: John Groves <John@groves.net>
To: Ackerley Tng <ackerleytng@google.com>
Cc: John Groves <john@jagalactic.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	John Groves <jgroves@fastmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
Message-ID: <aaWlxFh-bqUYXgUo@groves.net>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223110.92320-1-john@jagalactic.com>
 <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
 <CAEvNRgHmfpx0BXPzt81DenKbyvQ1QwM5rZeJWMnKUO8fB8MeqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgHmfpx0BXPzt81DenKbyvQ1QwM5rZeJWMnKUO8fB8MeqA@mail.gmail.com>
X-Stat-Signature: cq87gmedzk7x7r9ny9iist1ng64zruqa
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX18sF70d1HqicCYqrH7vz+w2ws8l6S67ZfI=
X-HE-Tag: 1772463985-663465
X-HE-Meta: U2FsdGVkX19+wByPZPpcn3fFxdlS7efSS3Z9sfx2FbKmn+pO0ifUKq0ek7sbqcQSKckha/6QKB0dO38o4/5xEaBD+GsVsq7ETKFWcom7uRHSSn+RVp2j9JNOM/Vj30paav3NtmzU4PFup78HglM3hDeONluYWqykeNoY9+/HZXqJLcAm28+hN8/b030/2zXtfMMEyfxgHY/UmA3e1Sy8tR2hBLX7f4PnfVGd3ztqgPPlCvTkXDr77SPk3sW0FIEY7Sc7zV6DKmspXuu6y+44WrT7hu7h77kH7lp0l1mMiR4rrp96nReTeguCtrXqJdgiImk5Z17L0ZxaA7FMn3FzxVDz1xZoVZNrfTWMXAyyVaQRkd/slAXiwFd9Sk4SYq48vzEK1miTOhR/K8JA1pmO/lhXdIEt9BORVuZfc93ojrZt1rJbkmgV+Kgg5MKpQahN9r09EKJ14MBgVltwhztXEw==
X-Rspamd-Queue-Id: 391D71DB9F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jagalactic.com,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78928-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[groves.net];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John@groves.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.172];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email,jagalactic.com:email,groves.net:mid,groves.net:email]
X-Rspamd-Action: no action

On 26/02/23 07:00PM, Ackerley Tng wrote:
> John Groves <john@jagalactic.com> writes:
> 
> > From: John Groves <John@Groves.net>
> >
> > Both fs/dax.c:dax_folio_put() and drivers/dax/fsdev.c:
> > fsdev_clear_folio_state() (the latter coming in the next commit after this
> > one) contain nearly identical code to reset a compound DAX folio back to
> > order-0 pages. Factor this out into a shared helper function.
> >
> > The new dax_folio_reset_order() function:
> > - Clears the folio's mapping and share count
> > - Resets compound folio state via folio_reset_order()
> > - Clears PageHead and compound_head for each sub-page
> > - Restores the pgmap pointer for each resulting order-0 folio
> > - Returns the original folio order (for callers that need to advance by
> >   that many pages)
> >
> > This simplifies fsdev_clear_folio_state() from ~50 lines to ~15 lines while
> > maintaining the same functionality in both call sites.
> >
> > Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/dax.c | 60 +++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 42 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 289e6254aa30..7d7bbfb32c41 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -378,6 +378,45 @@ static void dax_folio_make_shared(struct folio *folio)
> >  	folio->share = 1;
> >  }
> >
> > +/**
> > + * dax_folio_reset_order - Reset a compound DAX folio to order-0 pages
> > + * @folio: The folio to reset
> > + *
> > + * Splits a compound folio back into individual order-0 pages,
> > + * clearing compound state and restoring pgmap pointers.
> > + *
> > + * Returns: the original folio order (0 if already order-0)
> > + */
> > +int dax_folio_reset_order(struct folio *folio)
> > +{
> > +	struct dev_pagemap *pgmap = page_pgmap(&folio->page);
> > +	int order = folio_order(folio);
> > +	int i;
> > +
> > +	folio->mapping = NULL;
> > +	folio->share = 0;
> > +
> > +	if (!order) {
> > +		folio->pgmap = pgmap;
> > +		return 0;
> > +	}
> > +
> > +	folio_reset_order(folio);
> > +
> > +	for (i = 0; i < (1UL << order); i++) {
> > +		struct page *page = folio_page(folio, i);
> > +		struct folio *f = (struct folio *)page;
> > +
> > +		ClearPageHead(page);
> > +		clear_compound_head(page);
> > +		f->mapping = NULL;
> > +		f->share = 0;
> > +		f->pgmap = pgmap;
> > +	}
> > +
> > +	return order;
> > +}
> > +
> 
> I'm implementing something similar for guest_memfd and was going to
> reuse __split_folio_to_order(). Would you consider using the
> __split_folio_to_order() function?
> 
> I see that dax_folio_reset_order() needs to set f->share to 0 though,
> which is a union with index, and __split_folio_to_order() sets non-0
> indices.
> 
> Also, __split_folio_to_order() doesn't handle f->pgmap (or f->lru).
> 
> Could these two steps be added to a separate loop after
> __split_folio_to_order()?
> 
> Does dax_folio_reset_order() need to handle any of the folio flags that
> __split_folio_to_order() handles?

Sorry to reply slowly; this took some thought.

I'm nervous about sharing folio initialization code between the page cache
and dax. Might this be something we could unify after the fact - if it
passes muster? 

Unifying paths like this could be regression-prone (page cache changes
breaking dax or vice versa) unless it's really well conceived...

> 
> >  static inline unsigned long dax_folio_put(struct folio *folio)
> >  {
> >  	unsigned long ref;
> > @@ -391,28 +430,13 @@ static inline unsigned long dax_folio_put(struct folio *folio)
> >  	if (ref)
> >  		return ref;
> >
> > -	folio->mapping = NULL;
> > -	order = folio_order(folio);
> > -	if (!order)
> > -		return 0;
> > -	folio_reset_order(folio);
> > +	order = dax_folio_reset_order(folio);
> >
> > +	/* Debug check: verify refcounts are zero for all sub-folios */
> >  	for (i = 0; i < (1UL << order); i++) {
> > -		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
> >  		struct page *page = folio_page(folio, i);
> > -		struct folio *new_folio = (struct folio *)page;
> >
> > -		ClearPageHead(page);
> > -		clear_compound_head(page);
> > -
> > -		new_folio->mapping = NULL;
> > -		/*
> > -		 * Reset pgmap which was over-written by
> > -		 * prep_compound_page().
> > -		 */
> 
> Actually, where's the call to prep_compound_page()? Was that in
> dax_folio_init()? Is this comment still valid and does pgmap have to be
> reset?

Yep, in dax_folio_init()...


Thanks,
John

[snip]


