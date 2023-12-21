Return-Path: <linux-fsdevel+bounces-6686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742581B5FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5901F21BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E476DB6;
	Thu, 21 Dec 2023 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2zzrC1FT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t3AZ6zEZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2zzrC1FT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t3AZ6zEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A276DA9;
	Thu, 21 Dec 2023 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A91921E5D;
	Thu, 21 Dec 2023 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJLSNwQ5QmsjQ47r9hAM+XCcwY6F9aRMICRP236PlLc=;
	b=2zzrC1FT6sbYm5erWRGdcj452e0MRI86LSx9WwGcTyTgOF1exeUEod25I0+10RUjbCXd8B
	C2CHDbVJNPji8K6fQQFACMk96XkdStoHcWFADDg3igxcU0s3qdOPPLDSwivvtQMClhoPuy
	pfvThCa0HLwsVHa3BQ1BqwOovuZUOQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJLSNwQ5QmsjQ47r9hAM+XCcwY6F9aRMICRP236PlLc=;
	b=t3AZ6zEZEVtWLXJ6S10yo2RxRnYCZwil/s7orPWjCDjdekCGUZCXW42APzi52EUI/giupA
	Gv37yos5nh174rCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJLSNwQ5QmsjQ47r9hAM+XCcwY6F9aRMICRP236PlLc=;
	b=2zzrC1FT6sbYm5erWRGdcj452e0MRI86LSx9WwGcTyTgOF1exeUEod25I0+10RUjbCXd8B
	C2CHDbVJNPji8K6fQQFACMk96XkdStoHcWFADDg3igxcU0s3qdOPPLDSwivvtQMClhoPuy
	pfvThCa0HLwsVHa3BQ1BqwOovuZUOQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJLSNwQ5QmsjQ47r9hAM+XCcwY6F9aRMICRP236PlLc=;
	b=t3AZ6zEZEVtWLXJ6S10yo2RxRnYCZwil/s7orPWjCDjdekCGUZCXW42APzi52EUI/giupA
	Gv37yos5nh174rCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 408FB13AB5;
	Thu, 21 Dec 2023 12:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /928D+kvhGVvcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 12:30:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E57DFA07E3; Thu, 21 Dec 2023 13:30:28 +0100 (CET)
Date: Thu, 21 Dec 2023 13:30:28 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] writeback: Factor writeback_get_batch() out of
 write_cache_pages()
Message-ID: <20231221123028.gzkqd43bmdupcekz@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-8-hch@lst.de>
 <20231221111743.sppmjkyah3u4ao6g@quack3>
 <20231221122233.GC17956@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221122233.GC17956@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.92
X-Spamd-Result: default: False [-0.92 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[66.81%]
X-Spam-Flag: NO

On Thu 21-12-23 13:22:33, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 12:17:43PM +0100, Jan Kara wrote:
> > > +static void writeback_get_batch(struct address_space *mapping,
> > > +		struct writeback_control *wbc)
> > > +{
> > > +	folio_batch_release(&wbc->fbatch);
> > > +	cond_resched();
> > 
> > I'd prefer to have cond_resched() explicitely in the writeback loop instead
> > of hidden here in writeback_get_batch() where it logically does not make
> > too much sense to me...
> 
> Based on the final state after this series, where would you place it?

I guess writeback_get_folio() would be fine... Which is where it naturally
lands with the inlining I already suggested so probably nothing to do here.

> (That beeing said there is a discussion underway on lkml to maybe
>  kill cond_resched entirely as part of sorting out the preemption
>  model mess, at that point this would become a moot point anyway)
> 
> > >  	} else {
> > > -		index = wbc->range_start >> PAGE_SHIFT;
> > > +		wbc->index = wbc->range_start >> PAGE_SHIFT;
> > >  		end = wbc->range_end >> PAGE_SHIFT;
> > >  	}
> > 
> > Maybe we should have:
> > 	end = wbc_end(wbc);
> > 
> > when we have the helper? But I guess this gets cleaned up in later patches
> > anyway so whatever.
> 
> Yeah, this end just goes away.  I can convert it here, but that feels
> like pointless churn to me.

Agreed. Just leave it alone.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

