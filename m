Return-Path: <linux-fsdevel+bounces-79173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H0HAKe7pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:44:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D991ECE5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B7730515C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0294E39D6E4;
	Tue,  3 Mar 2026 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cNqkvYj4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a68tipc5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cNqkvYj4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a68tipc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE139D6D4
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534392; cv=none; b=O+O1mkv0k77L1jD7iqyD6Doy0wJ/PVylEI15HcABHG5LTk4xCwUgaetMMWc5fvAo7VlXjJ40AubHiDXEJh+i5vdSOq73Jn0ol07VgRgRh6u7/B5dKsZlyqoJqgEj9cBI0jgZQOy4CtWc7rriSImDXJmjSiPlWyJN+TG9YMOJ6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534392; c=relaxed/simple;
	bh=essgaAgDRWL4fqgbnKnUQBwC0YsjHBgOFl8UlFR+RRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/xg6bw7MYgKU4RMShEwG573B9mvetb0lsDy+TgEa+AqjNzjsqBqV+idQZ1j3AxgqZrYhLoAqxxPimtYWy9zjkO7pFrAQ83svdMXeitQPw6uGwOv7/i4JtlLyhOyc6/sogiKXHVND5YdZU096NMh775cErIrD/wpIhAPmzlHgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cNqkvYj4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a68tipc5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cNqkvYj4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a68tipc5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE4CF5BDEA;
	Tue,  3 Mar 2026 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDKEWjSVOqkrZc6vTVeKneTnpLaNmie+ySjDkZuCOrk=;
	b=cNqkvYj4wBqDXl9j0WVpUChli3T7qASE5M+Zr17hq13Fr7BvA48MgQnP8lMjEFS3zlyQdx
	QDa9vELibp292cA2BJMaMq9suPmVkz2N0oZuaSSgwV8yvT2uX0t9129X5pKdNEXzQtPDn0
	2GQD7e8QJZwustXF+VSTHc709NeA/Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDKEWjSVOqkrZc6vTVeKneTnpLaNmie+ySjDkZuCOrk=;
	b=a68tipc5Waz0LebOf6mtviHCUF0ztGCOw8awtTpbzJ2vBfITtpK+dl6TJPz+cXJR1FuREe
	B6XG/A7VhOlQbnCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cNqkvYj4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a68tipc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDKEWjSVOqkrZc6vTVeKneTnpLaNmie+ySjDkZuCOrk=;
	b=cNqkvYj4wBqDXl9j0WVpUChli3T7qASE5M+Zr17hq13Fr7BvA48MgQnP8lMjEFS3zlyQdx
	QDa9vELibp292cA2BJMaMq9suPmVkz2N0oZuaSSgwV8yvT2uX0t9129X5pKdNEXzQtPDn0
	2GQD7e8QJZwustXF+VSTHc709NeA/Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDKEWjSVOqkrZc6vTVeKneTnpLaNmie+ySjDkZuCOrk=;
	b=a68tipc5Waz0LebOf6mtviHCUF0ztGCOw8awtTpbzJ2vBfITtpK+dl6TJPz+cXJR1FuREe
	B6XG/A7VhOlQbnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A29173EA69;
	Tue,  3 Mar 2026 10:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UTCrJ3W6pmmwGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:39:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E5C8A0A1B; Tue,  3 Mar 2026 11:39:49 +0100 (CET)
Date: Tue, 3 Mar 2026 11:39:49 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Tal Zussman <tz2294@columbia.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/2] filemap: defer dropbehind invalidation from
 IRQ context
Message-ID: <aaybsigvp33i54w244jy4jarwf53zph5mzwjy2hcfm4v7m5o5o@e5hljmjqa3kq>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
 <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu>
 <wen63cjbk3k54mjzgw7zftsuze6bzxmdk5u5wdjabzdiqg645k@67666k5lrevh>
 <aaXK0_HqEnU5SK61@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaXK0_HqEnU5SK61@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 55D991ECE5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79173-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 17:37:23, Matthew Wilcox wrote:
> On Mon, Mar 02, 2026 at 10:11:19AM +0100, Jan Kara wrote:
> > Folio batches are relatively small (31 folios). With 4k folios it is very
> > easy to overflow the batch with a single IO completion. Large folios will
> > obviously make this less likely but I'm not sure reasonable working of
> > dropbehind should be dependent on large folios... Not sure how to best
> > address this though. We could use larger batches but that would mean using
> > our own array of folios instead of folio_batch.
> 
> That's why I think we should allow the bio to be tagged as
> "finish the bio in workqueue context",
> https://lore.kernel.org/linux-fsdevel/aaC3LUFa1Jz2ahk3@casper.infradead.org/

Yeah, what you suggested there makes sense to me. The workqueue would
probably have to be a per-cpu one for performance reasons but otherwise I
think it's worth a try.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

