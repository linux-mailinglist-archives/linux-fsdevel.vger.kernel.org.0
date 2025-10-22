Return-Path: <linux-fsdevel+bounces-65064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1EBBFA9D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED1FD4F18BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4F2FD1DA;
	Wed, 22 Oct 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KukVtGGW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="veJQOarc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RBDxyTiE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QYPrHAhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450E2FC000
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118725; cv=none; b=VCiIbA5JsQb6ClFaU+hJqsWu0Ef6WP2XInQORM9vfh6m38xVg2DrEPvX4IuaI79KaNrtK0xanS5RsxVAIKWahcpes93HlERuZEy7JdWzOz71Jgl9RDVKiVoTCOZRMi3g1Z4Ja67WD9ZcdjZ6LikU5g/rVMrELnm7K/EY+DLnS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118725; c=relaxed/simple;
	bh=K960BDuQHcE/jBjNcwfUBPgxb8pUqAI9A3XKJlwc+js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWeagon+mJW+WO2q33i9qWm//lxA9MjGHiVCxQiAPfLO3iLHyhCIpMKwj9WDqaPmAp7QKVh9EUl3xCrTe1FNOgY7IuzkjgLC58n+b65WeeTkQY0EmXREhbJx8FUkvSomk8bqCy1A9Wc2hPD0mu4D6HSTi8RqiLJXgBzLKtmewjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KukVtGGW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=veJQOarc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RBDxyTiE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QYPrHAhn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 399731F391;
	Wed, 22 Oct 2025 07:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761118717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Myzl7tA1DnESjNsonDhfQ1k0YqDE7S12DaYO8n4h//c=;
	b=KukVtGGWqSuem/LJklYW0q+zc5HKvfxVuJPkcHLDHZx8D7vROffVpcP73HtODiay68RRay
	QN8gAZIdga1NdvQUAg3k1InyPvsKc8O7qNSsf4EgjVJ16tMsksmsvaU2nwQFvt7Qgs1Awz
	hTNqcp+LKLH6PpY5Cijtjh1i7w05Wyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761118717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Myzl7tA1DnESjNsonDhfQ1k0YqDE7S12DaYO8n4h//c=;
	b=veJQOarcKigKf26sRa6IuzSsBqRioFdBls/D4dmszIC6X38QE3qFdg7IZiEegurQGVUvZ9
	Yc7a8PLBih3CcJCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RBDxyTiE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QYPrHAhn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761118713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Myzl7tA1DnESjNsonDhfQ1k0YqDE7S12DaYO8n4h//c=;
	b=RBDxyTiEJNM7tQqrsbbtjGRrg2f1678Z4QNrLli+dxOSiPMBbJgnOL8ogYjvPpA6JvLqqD
	yK8Ix6a2uHQgo2neTu596fnX7CxdF645RlJCn2YJFFp6LQAr5Asv4zyQYAE+nCLOxOLnoN
	d4pY55cHObJe9y2OsWBtn4s8B+V6D10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761118713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Myzl7tA1DnESjNsonDhfQ1k0YqDE7S12DaYO8n4h//c=;
	b=QYPrHAhnO5Xk2QgbkFCm383lUU/0V5g5zF/efIyre3pCxn7kENc2pz342o23/KhxzU8tTe
	4Xg11GUsOf/GhqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6651F1339F;
	Wed, 22 Oct 2025 07:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7gOsFfiJ+GiKHAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 22 Oct 2025 07:38:32 +0000
Date: Wed, 22 Oct 2025 08:38:30 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <2dyj6zrxbd2wjnor2wswis5p5z7brtfgzjnhbexhjsd3kqnvx2@y6i2wnvr6gdr>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <zuzs6ucmgxujim4fb67tw5izp3w2t5k6dzk2ktntqyuwjva73d@tqgwkk6stpgz>
 <CAHk-=wgw8oZwA6k8rVuzczkZUP26P2MAtFmM4k8TqdtfDr9eTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgw8oZwA6k8rVuzczkZUP26P2MAtFmM4k8TqdtfDr9eTg@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 399731F391
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Tue, Oct 21, 2025 at 09:13:28PM -1000, Linus Torvalds wrote:
> On Tue, 21 Oct 2025 at 21:08, Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > I think we may still have a problematic (rare, possibly theoretical) race here where:
> >
> >    T0                                           T1                                              T3
> > filemap_read_fast_rcu()    |                                                    |
> >   folio = xas_load(&xas);  |                                                    |
> >   /* ... */                |  /* truncate or reclaim frees folio, bumps delete  |
> >                            |     seq */                                         |       folio_alloc() from e.g secretmem
> >                            |                                                    |       set_direct_map_invalid_noflush(!!)
> > memcpy_from_file_folio()   |                                                    |
> >
> > We may have to use copy_from_kernel_nofault() here? Or is something else stopping this from happening?
> 
> Explain how the sequence count doesn't catch this?
> 
> We read the sequence count before we do the xas_load(), and we verify
> it after we've done the memcpy_from_folio.
> 
> The whole *point* is that the copy itself is not race-free. That's
> *why* we do the sequence count.
> 
> And only after the sequence count has been verified do we then copy
> the result to user space.
> 
> So the "maybe this buffer content is garbage" happens, but it only
> happens in the temporary kernel on-stack buffer, not visibly to the
> user.

The problem isn't that the contents might be garbage, but that the direct map
may be swept from under us, as we don't have a reference to the folio. So the
folio can be transparently freed under us (as designed), but some user can
call fun stuff like set_direct_map_invalid_noflush() and we're not handling
any "oopsie we faulted reading the folio" here. The sequence count doesn't
help here, because we, uhh, faulted. Does this make sense?

TL;DR I don't think it's safe to touch the direct map of folios we don't own
without the seatbelt of a copy_from_kernel_nofault or so.

-- 
Pedro

