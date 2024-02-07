Return-Path: <linux-fsdevel+bounces-10575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D884C66B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706F02870E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258D4208C5;
	Wed,  7 Feb 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D9B8ecpX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a/DE9HMm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D9B8ecpX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a/DE9HMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22986208B2;
	Wed,  7 Feb 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295357; cv=none; b=p3XTUi6XZNzVH3H7wm55pqrfMt8F12p45ylZQXF95sYEId1tkDyrlt+Ir8DGt3aGi8GV33KTcj61x1gbu+lj26uXmOO1uq/RMa4q+cORwzqrAWOyU+lrik6Xh+807OGvPkYV1j7/IYCbUF3NBT4y3nc5pzgi/skOgVDmfUHLkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295357; c=relaxed/simple;
	bh=uffdOHcZH2TfTFxM+Zsni5/ucr3a5SiFcPQaj7PvZXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyaQE7GK4ksD8LDhZiutZQ0Npi0qtX4o58bd2hEdZdTAF4N/m+nbNNV2fxXS0B3VArkIgmu8MLAP5xJQphW1+spFKZnBU5/5XICCEW7Jc2XSla6q/nbbOyIlqH6eYsdhKgvRpDE7ZRDm2fzHmI16rjaURLfuzlGx30uFFma5pRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D9B8ecpX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a/DE9HMm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D9B8ecpX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a/DE9HMm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 236E81F45B;
	Wed,  7 Feb 2024 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707295349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2g70fPjpQ5IfQrdko+WLA6L2tGMboSG/Vf9GkcU2sHM=;
	b=D9B8ecpXtDdsnSvQF4JPndq8iFjXGjxZa+fB38klu9RVra65ZPQE7HCe82gb5CfC4SBwYq
	sas+r21Oc8S+95NiK6k1QsHkv9j7zb6/fFcjqa5Z3JkKuSOLWRIg49Ii9XPAUvJ+zyhpZu
	mhkpKZiUk7YYcMGBaTokGcOCCFLX/p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707295349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2g70fPjpQ5IfQrdko+WLA6L2tGMboSG/Vf9GkcU2sHM=;
	b=a/DE9HMmPKkuE0y3lNqk20qSVQpF+J5hf7l47fcHv0t8wjx82YmaMwOrdaRh0oN9njYfLQ
	Upx0hhnWuFiFm+Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707295349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2g70fPjpQ5IfQrdko+WLA6L2tGMboSG/Vf9GkcU2sHM=;
	b=D9B8ecpXtDdsnSvQF4JPndq8iFjXGjxZa+fB38klu9RVra65ZPQE7HCe82gb5CfC4SBwYq
	sas+r21Oc8S+95NiK6k1QsHkv9j7zb6/fFcjqa5Z3JkKuSOLWRIg49Ii9XPAUvJ+zyhpZu
	mhkpKZiUk7YYcMGBaTokGcOCCFLX/p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707295349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2g70fPjpQ5IfQrdko+WLA6L2tGMboSG/Vf9GkcU2sHM=;
	b=a/DE9HMmPKkuE0y3lNqk20qSVQpF+J5hf7l47fcHv0t8wjx82YmaMwOrdaRh0oN9njYfLQ
	Upx0hhnWuFiFm+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16D7B139D8;
	Wed,  7 Feb 2024 08:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pOOGBXVCw2WeQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 08:42:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9F9CA0809; Wed,  7 Feb 2024 09:42:24 +0100 (CET)
Date: Wed, 7 Feb 2024 09:42:24 +0100
From: Jan Kara <jack@suse.cz>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] writeback: add a writeback iterator
Message-ID: <20240207084224.o6nn4l7owwhzb5e3@quack3>
References: <20240203071147.862076-1-hch@lst.de>
 <20240203071147.862076-13-hch@lst.de>
 <ZcD/4HNZt1zu2eZF@bfoster>
 <ZcJICXOyW7XbiEPp@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcJICXOyW7XbiEPp@bfoster>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 06-02-24 09:54:01, Brian Foster wrote:
> On Mon, Feb 05, 2024 at 10:33:52AM -0500, Brian Foster wrote:
> > On Sat, Feb 03, 2024 at 08:11:46AM +0100, Christoph Hellwig wrote:
> > > Refactor the code left in write_cache_pages into an iterator that the
> > > file system can call to get the next folio for a writeback operation:
> > > 
> > > 	struct folio *folio = NULL;
> > > 
> > > 	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> > > 		error = <do per-foli writeback>;
> > > 	}
> > > 
> > > The twist here is that the error value is passed by reference, so that
> > > the iterator can restore it when breaking out of the loop.
> > > 
> > > Handling of the magic AOP_WRITEPAGE_ACTIVATE value stays outside the
> > > iterator and needs is just kept in the write_cache_pages legacy wrapper.
> > > in preparation for eventually killing it off.
> > > 
> > > Heavily based on a for_each* based iterator from Matthew Wilcox.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  include/linux/writeback.h |   4 +
> > >  mm/page-writeback.c       | 192 ++++++++++++++++++++++----------------
> > >  2 files changed, 118 insertions(+), 78 deletions(-)
> > > 
> > ...
> > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > index 3abb053e70580e..5fe4cdb7dbd61a 100644
> > > --- a/mm/page-writeback.c
> > > +++ b/mm/page-writeback.c
> > ...
> > > @@ -2434,69 +2434,68 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
> > >  }
> > >  
> > >  /**
> > ...
> > >   */
> > > -int write_cache_pages(struct address_space *mapping,
> > > -		      struct writeback_control *wbc, writepage_t writepage,
> > > -		      void *data)
> > > +struct folio *writeback_iter(struct address_space *mapping,
> > > +		struct writeback_control *wbc, struct folio *folio, int *error)
> > >  {
> > ...
> > > +	} else {
> > >  		wbc->nr_to_write -= folio_nr_pages(folio);
> > >  
> > > -		if (error == AOP_WRITEPAGE_ACTIVATE) {
> > > -			folio_unlock(folio);
> > > -			error = 0;
> > > -		}
> > > +		WARN_ON_ONCE(*error > 0);
> > 
> > Why the warning on writeback error here? It looks like new behavior, but
> > maybe I missed something. Otherwise the factoring LGTM.
> 
> Err, sorry.. I glossed over the > 0 check and read it as < 0.
> Disregard, this seems reasonable to me as long as we no longer expect
> those AOP returns (which I'm not really clear on either, but anyways..):
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>

So my understanding is that AOP_WRITEPAGE_ACTIVATE should be now handled
directly by the caller of ->writepage hook and not by writeback_iter()
which is the reason why the warning is here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

