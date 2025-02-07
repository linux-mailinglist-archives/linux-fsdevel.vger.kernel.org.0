Return-Path: <linux-fsdevel+bounces-41177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 221BEA2C08A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11914188CBA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6DD1DE3B6;
	Fri,  7 Feb 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ti6rnxIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2fvq+82";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ti6rnxIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2fvq+82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BA80BFF;
	Fri,  7 Feb 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923956; cv=none; b=sznSd+J9folzB9Wi2XSlp33WOh+0vazQTa0TvSC8DLynMjOIVZ3ueBR+HLmid6scVSKoqcBWXFiFv/t09JY8aDmHRaYfRxOo1fHZ+jJY2bgV6waAVOZFHqPyvyjzJT/d7GcZqH6aIg3mdRJKS6Fj/lI44gA/4HO2Onfa/D/eRbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923956; c=relaxed/simple;
	bh=C3yZNhdQLr150OHj7m4T/ffxAPLe/FGRnyvM3fsCSoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfJxY1lg2nOO6egYWnY4OTZNHElKNdBJDxvLr7yurkhZASwfz/V0VKY2NLZsCgftM71lRW8vMhG0vnZBYOs75HDHyWCjqin/qNEaJlkmequGjwKJhdjyJb5+RTvOa3mPLBcXyuN4Omd0YCDzryOh6729Z8UcEuPIkBe6kxQ3fIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ti6rnxIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2fvq+82; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ti6rnxIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2fvq+82; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C54DA21161;
	Fri,  7 Feb 2025 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738923946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4PcZmgG4NDKgXQ9ax0vEC5xMEC26xGqBmksg3k/Yng=;
	b=ti6rnxIWRJ1nov7ayMX9xq+I3tE4k/Vw/TJ0Cayy9Y4Nl7fngepsfvkiRfsgF0RvBEA24C
	coem/XYMHlCYZsb+rEz1+67BvsM8Xxu7EbEkavyRJbru1ZV9r7v0xlF3uGfr0iF9j/IBWU
	1K+RVjG5QntnZfy2oA59+8Psdeky8Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738923946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4PcZmgG4NDKgXQ9ax0vEC5xMEC26xGqBmksg3k/Yng=;
	b=Y2fvq+82EAXGOwkXuJIcpHmhBTdEIJytTHko3ByToSLDahHgUkbh7rypd7fwchBekWRyXa
	krUbd1P9TfgeZfDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ti6rnxIW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y2fvq+82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738923946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4PcZmgG4NDKgXQ9ax0vEC5xMEC26xGqBmksg3k/Yng=;
	b=ti6rnxIWRJ1nov7ayMX9xq+I3tE4k/Vw/TJ0Cayy9Y4Nl7fngepsfvkiRfsgF0RvBEA24C
	coem/XYMHlCYZsb+rEz1+67BvsM8Xxu7EbEkavyRJbru1ZV9r7v0xlF3uGfr0iF9j/IBWU
	1K+RVjG5QntnZfy2oA59+8Psdeky8Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738923946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4PcZmgG4NDKgXQ9ax0vEC5xMEC26xGqBmksg3k/Yng=;
	b=Y2fvq+82EAXGOwkXuJIcpHmhBTdEIJytTHko3ByToSLDahHgUkbh7rypd7fwchBekWRyXa
	krUbd1P9TfgeZfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD558139CB;
	Fri,  7 Feb 2025 10:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dxPpKarfpWcQcAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Feb 2025 10:25:46 +0000
Message-ID: <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
Date: Fri, 7 Feb 2025 11:25:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Heusel <christian@heusel.eu>, Josef Bacik
 <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 linux-mm <linux-mm@kvack.org>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <Z6XWVU6ZTCIl3jnc@casper.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z6XWVU6ZTCIl3jnc@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C54DA21161
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[heusel.eu,toxicpanda.com,redhat.com,lists.linux.dev,vger.kernel.org,gmail.com,kvack.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/7/25 10:45, Matthew Wilcox wrote:
> On Fri, Feb 07, 2025 at 10:34:52AM +0100, Miklos Szeredi wrote:
>> Seems like page allocation gets an inconsistent page (mapcount != -1)
>> in the report below.
> 
> I think you're misreading the report.  _mapcount is -1.  Which means
> mapcount is 0.
> 
>> > Feb 06 08:54:47 archvm kernel: BUG: Bad page state in process rnote  pfn:67587
>> > Feb 06 08:54:47 archvm kernel: page: refcount:-1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x67587

refcount of -1 doesn't look healthy too, should be 0 at this point?

>> > Feb 06 08:54:47 archvm kernel: flags: 0xfffffc8000020(lru|node=0|zone=1|lastcpupid=0x1fffff)
>> > Feb 06 08:54:47 archvm kernel: raw: 000fffffc8000020 dead000000000100 dead000000000122 0000000000000000
> 
> flags lru.next lru.prev mapping
> 
>> > Feb 06 08:54:47 archvm kernel: raw: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000000
> 
> index private mapcount:refcount memcg_data
> 
>> > Feb 06 08:54:47 archvm kernel: page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
> 
> So the problem is the lru flag is set.
> 
>> > Feb 06 08:54:47 archvm kernel:  dump_stack_lvl+0x5d/0x80
>> > Feb 06 08:54:47 archvm kernel:  bad_page.cold+0x7a/0x91
>> > Feb 06 08:54:47 archvm kernel:  __rmqueue_pcplist+0x200/0xc50
>> > Feb 06 08:54:47 archvm kernel:  get_page_from_freelist+0x2ae/0x1740
>> > Feb 06 08:54:47 archvm kernel:  __alloc_frozen_pages_noprof+0x184/0x330
>> > Feb 06 08:54:47 archvm kernel:  alloc_pages_mpol+0x7d/0x160
>> > Feb 06 08:54:47 archvm kernel:  folio_alloc_mpol_noprof+0x14/0x40
>> > Feb 06 08:54:47 archvm kernel:  vma_alloc_folio_noprof+0x69/0xb0
>> > Feb 06 08:54:47 archvm kernel:  do_anonymous_page+0x32a/0x8b0
> 
> It's very weird, because PG_lru is also in PAGE_FLAGS_CHECK_AT_FREE.
> So it should already have been checked and not be set.  I'm on holiday

Could be a use-after free of the page, which sets PG_lru again. The list
corruptions in __rmqueue_pcplist also suggest some page manipulation after
free. The -1 refcount suggests somebody was using the page while it was
freed due to refcount dropping to 0 and then did a put_page()?

> until Monday, so I'm not going to dive into this any further.




