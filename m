Return-Path: <linux-fsdevel+bounces-64833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E28BF537C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9EA3A58BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5D303A15;
	Tue, 21 Oct 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vIz7QdwR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A8eT9kKK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qAc/bZaK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZ/rHkbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C742EDD62
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035233; cv=none; b=bedGR0vzhBuKnH0p5DiX8CX8OH+58OtEm1VitpmlSoGGJ8YVclqpvggYOnPuxodGaLJ6loJvx8g0+RbDc9W5DEM47Ad6CFgfy5pCCzG2F7oPHwJO+N/7ZJd9ChqUslEAnUM8jPMm+M46ECckw4hcy8S0FOtMXO3v0cj9KiyAoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035233; c=relaxed/simple;
	bh=6lLQuo2cBk1EtH+T2vY5IhwMEEZxodrp6Mjsn2OSJEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMz1MNZiW2Qr+pmheY6l07/UZz15CbmclNEpxufFZHWPgFg7KC7ZBvCN5K5faoR16wWEh0s12L82HOJ+K4QFu/aTWMisP8fhseLK5v2ZA0Y5vF+ZEDVRl1XGZvI3c5ByRip6DD/t9ePaKQOphanfc4g/82kiQOse8/GBTBb1wxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vIz7QdwR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A8eT9kKK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qAc/bZaK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZ/rHkbv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 681D21F385;
	Tue, 21 Oct 2025 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761035225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eM5uKYPimXpUkghvLJUuBzWoqYrQThF+Lr3Lf5X1p8k=;
	b=vIz7QdwR2CK91QXv7Z1+jCI25tUZbdFr6z5NvW5nXkoM9HO5rUzhr9ZgaTAqkysB8bXQjj
	XHlNAtm2P3wLDAdc4BV6h1OApsO++COo+o4vfSmjgBniNrYblZZNy1RU6EIhdB1OEqCRTw
	Y7fX5Gp96b9ZFuLShDNim0Xp9n5XvOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761035225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eM5uKYPimXpUkghvLJUuBzWoqYrQThF+Lr3Lf5X1p8k=;
	b=A8eT9kKKnUSxIRKGY3rHEZh7CeTywonbwaIsHvaKMXV9kBDL2pRNM3wXin2DwKEfEma7QM
	UqHZmiuoc3zLHZCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qAc/bZaK";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="mZ/rHkbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761035221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eM5uKYPimXpUkghvLJUuBzWoqYrQThF+Lr3Lf5X1p8k=;
	b=qAc/bZaKzNTb2nkIpj7xU1vZRYyHMoUdIqZgAtOK8zm6z1cE1t4NPCs8Z3KPIkZoHSvWvU
	X5W+34sxNWWUouNwAd6h8Moxjym+kkJIxHcqicgd22VEcwKN0b/suJ2AJs1LDNfuZjjDUc
	h5vj3J3/Np9RJo4CL7ODWqVLSpd1DO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761035221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eM5uKYPimXpUkghvLJUuBzWoqYrQThF+Lr3Lf5X1p8k=;
	b=mZ/rHkbvmvLqRgVFbdD1Zw0Wd0XaI6+DAJ/IDtl4G/ECbTVa26bHdr+t/uvcOf9CRYAvie
	k1/xY+sUURIfzAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59FA2139B1;
	Tue, 21 Oct 2025 08:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZZbxFdVD92giDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 08:27:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F386BA0990; Tue, 21 Oct 2025 10:27:00 +0200 (CEST)
Date: Tue, 21 Oct 2025 10:27:00 +0200
From: Jan Kara <jack@suse.cz>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	djwong@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <6hedspdzoxjtdim7nruoeh5m4mx3xecubf7einzl67jzjmi3er@o54b7v5njwk5>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
 <a1cffdbd-ba98-4e24-bbb6-298eba40a11e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1cffdbd-ba98-4e24-bbb6-298eba40a11e@nvidia.com>
X-Rspamd-Queue-Id: 681D21F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 20-10-25 10:55:06, John Hubbard wrote:
> On 10/20/25 8:58 AM, Jan Kara wrote:
> > On Mon 20-10-25 15:59:07, Matthew Wilcox wrote:
> > > On Mon, Oct 20, 2025 at 03:59:33PM +0200, Jan Kara wrote:
> > > > The idea was to bounce buffer the page we are writing back in case we spot
> > > > a long-term pin we cannot just wait for - hence bouncing should be rare.
> > > > But in this more general setting it is challenging to not bounce buffer for
> > > > every IO (in which case you'd be basically at performance of RWF_DONTCACHE
> > > > IO or perhaps worse so why bother?). Essentially if you hand out the real
> > > > page underlying the buffer for the IO, all other attemps to do IO to that
> > > > page have to block - bouncing is no longer an option because even with
> > > > bouncing the second IO we could still corrupt data of the first IO once we
> > > > copy to the final buffer. And if we'd block waiting for the first IO to
> > > > complete, userspace could construct deadlock cycles - like racing IO to
> > > > pages A, B with IO to pages B, A. So far I'm not sure about a sane way out
> > > > of this...
> > > 
> > > There isn't one.  We might have DMA-mapped this page earlier, and so a
> > > device could write to it at any time.  Even if we remove PTE write
> > > permissions ...
> > 
> > True but writes through DMA to the page are guarded by holding a page pin
> > these days so we could in theory block getting another page pin or mapping
> 
> Do you mean, "setting up to do DMA is guarded by holding a FOLL_LONGTERM
> page pin"? Or something else (that's new to me)?

I meant to say that users that end up setting up DMA to a page also hold a
page pin (either longterm for RDMA and similar users or shortterm for
direct IO). Do you disagree?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

