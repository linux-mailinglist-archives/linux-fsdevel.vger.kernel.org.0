Return-Path: <linux-fsdevel+bounces-60351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF0B4582D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F523BD221
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B86350D58;
	Fri,  5 Sep 2025 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wYssWw15";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GOKncyyN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wYssWw15";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GOKncyyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED49350D4F
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076638; cv=none; b=Rw6qud3h0oCRhVqzXT0P6NkaGMyA5UNiM5m4QCs4lwA9wn4iFqDqcb+o8EWCiM7k22uD79sf9mp86sk3r0VB4kAYSbGygFqsjdc3L3crykdLcS8hNPS+HrIpykK1R28JJAHsvINOLA+9oq52QW1ZAvYWh3qS/G4fs21EIWR5PMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076638; c=relaxed/simple;
	bh=il/KT4g+YVAo3+3KMjqG7UhPZXeYzVSqQxei8BB3jIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsIFLsL3rW+S4xkxMEyzbIrhzDE7W26i1q5tJQ+FNNFT/PHhrOfjiy0LJ7JbguUzjitPRLihisSbIlxJx5sVMW9YbBlf5ivK99GpXUXNamOu/4p9sVgTndbc2IRaXbFOfN7OAVzaDLwcPI6amyvRhMXwR+7ARkhYRchEVw1nEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wYssWw15; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GOKncyyN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wYssWw15; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GOKncyyN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98D6C5353;
	Fri,  5 Sep 2025 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757076634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi3KQaJbyoNPQY1v66CGkX0xH4AblgnUiTzltu1PAo4=;
	b=wYssWw15OmYErtbM6EH0YruZj8LCHa+nEw2/t6Pw3/Y2Gj3zzp0g2iqnaFLKfCpQMtWAvS
	kjjXbcc6kEUsbqCRw8r/KU/npRQLplmRdSGAd5XtuXMKpyxBSEXh+y/GcWdxbeCjd0CFfb
	8P9lrTkw57w/ti3qAMe4yBJmrM5w33U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757076634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi3KQaJbyoNPQY1v66CGkX0xH4AblgnUiTzltu1PAo4=;
	b=GOKncyyNup75bLtMDmNHAuBofvQGgFzgZ0rGeR6+O6k9y7RGISH188pVFCtd/g1j60OjPf
	IXM240S77uuxc7DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wYssWw15;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GOKncyyN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757076634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi3KQaJbyoNPQY1v66CGkX0xH4AblgnUiTzltu1PAo4=;
	b=wYssWw15OmYErtbM6EH0YruZj8LCHa+nEw2/t6Pw3/Y2Gj3zzp0g2iqnaFLKfCpQMtWAvS
	kjjXbcc6kEUsbqCRw8r/KU/npRQLplmRdSGAd5XtuXMKpyxBSEXh+y/GcWdxbeCjd0CFfb
	8P9lrTkw57w/ti3qAMe4yBJmrM5w33U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757076634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi3KQaJbyoNPQY1v66CGkX0xH4AblgnUiTzltu1PAo4=;
	b=GOKncyyNup75bLtMDmNHAuBofvQGgFzgZ0rGeR6+O6k9y7RGISH188pVFCtd/g1j60OjPf
	IXM240S77uuxc7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87AF813306;
	Fri,  5 Sep 2025 12:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8vAbIZrcumh6aQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 05 Sep 2025 12:50:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E3F54A0A48; Fri,  5 Sep 2025 14:50:25 +0200 (CEST)
Date: Fri, 5 Sep 2025 14:50:25 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Youling Tang <youling.tang@linux.dev>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, chizhiling@163.com, Youling Tang <tangyouling@kylinos.cn>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
Message-ID: <bv4t7a6boxh4dmjl7zsmhd74wm5hyfpdivypmrqerlpn23betz@tw52mlf4xf3s>
References: <20250711055509.91587-1-youling.tang@linux.dev>
 <jk3sbqrkfmtvrzgant74jfm2n3yn6hzd7tefjhjys42yt2trnp@avx5stdnkfsc>
 <afff8170-eed3-4c5c-8cc7-1595ccd32052@linux.dev>
 <20250903155046.bd82ae87ab9d30fe32ace2a6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903155046.bd82ae87ab9d30fe32ace2a6@linux-foundation.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,suse.cz,infradead.org,vger.kernel.org,kvack.org,163.com,kylinos.cn];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 98D6C5353
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed 03-09-25 15:50:46, Andrew Morton wrote:
> On Tue, 12 Aug 2025 17:08:53 +0800 Youling Tang <youling.tang@linux.dev> wrote:
> 
> > Hi, Jan
> > On 2025/7/14 17:33, Jan Kara wrote:
> > > On Fri 11-07-25 13:55:09, Youling Tang wrote:
> > >> From: Youling Tang <tangyouling@kylinos.cn>
> >
> > ...
> >
> > >> --- a/mm/filemap.c
> > >> +++ b/mm/filemap.c
> > >> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
> > >>   	unsigned int flags;
> > >>   	int err = 0;
> > >>   
> > >> -	/* "last_index" is the index of the page beyond the end of the read */
> > >> -	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> > >> +	/* "last_index" is the index of the folio beyond the end of the read */
> > >> +	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
> > >> +	last_index >>= PAGE_SHIFT;
> > > I think that filemap_get_pages() shouldn't be really trying to guess what
> > > readahead code needs and round last_index based on min folio order. After
> > > all the situation isn't special for LBS filesystems. It can also happen
> > > that the readahead mark ends up in the middle of large folio for other
> > > reasons. In fact, we already do have code in page_cache_ra_order() ->
> > > ra_alloc_folio() that handles rounding of index where mark should be placed
> > > so your changes essentially try to outsmart that code which is not good. I
> > > think the solution should really be placed in page_cache_ra_order() +
> > > ra_alloc_folio() instead.
> > >
> > > In fact the problem you are trying to solve was kind of introduced (or at
> > > least made more visible) by my commit ab4443fe3ca62 ("readahead: avoid
> > > multiple marked readahead pages"). There I've changed the code to round the
> > > index down because I've convinced myself it doesn't matter and rounding
> > > down is easier to handle in that place. But your example shows there are
> > > cases where rounding down has weird consequences and rounding up would have
> > > been better. So I think we need to come up with a method how to round up
> > > the index of marked folio to fix your case without reintroducing problems
> > > mentioned in commit ab4443fe3ca62.
> > Yes, I simply replaced round_up() in ra_alloc_folio() with round_down()
> > to avoid this phenomenon before submitting this patch.
> > 
> > But at present, I haven't found a suitable way to solve both of these 
> > problems
> > simultaneously. Do you have a better solution on your side?
> > 
> 
> fyi, this patch remains stuck in mm.git awaiting resolution.
> 
> Do we have any information regarding its importance?  Which means do we
> have any measurement of its effect upon any real-world workload?

OK, after experimenting with the code some more and with rounding the
readahead mark index up, I've found out we need something like Youling
proposed anyway because otherwise it could happen that the whole readahead
area fits into a single min-order folio and thus with rounding up we
wouldn't have a folio to place readahead mark on. So with that I'm
withdrawing my objections and feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

to Youling's patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

