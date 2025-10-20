Return-Path: <linux-fsdevel+bounces-64708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7551EBF1B45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D57044F6A39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD66E31E102;
	Mon, 20 Oct 2025 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FQdkhRh4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZ3Z4url";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqBWEElY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Am1N2qnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FFF4FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968785; cv=none; b=MvR6+r403FiumjzN9a5Xe9jHwVSBw0MAEdEJ/fEcLEr7tBOrjocvtFq8336gVHBh6Wifil9YM1gCfwnvAci2jYUzmxTr98gAmluicNQGkzHFdnPM/ayxYz3HkQEfP5nfGAOhrVpFNkKfVZycJH8whzyBgcrhqT+7eLqKNVA35Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968785; c=relaxed/simple;
	bh=OyUd+BMhitFA3vyxMLfkuyDolf+rPnLgDAdSj+/uIBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcn7ZOE33gheT0WwV2tRJwD8dYSsGoHiOvo5ccRuFUORqh5DxMI3r8CAJ03SPt0H8GOsbc1FTTyaCEsJ0EgdDMVPcjrjWpblBVpbR0a62u8WbyrCsEeF/IL9sYE9md+LsPZ95Y24+ga6Ia7VNY2KBrzy1GQguBBNn0Tkemjq0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FQdkhRh4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZ3Z4url; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqBWEElY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Am1N2qnK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2F121F449;
	Mon, 20 Oct 2025 13:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760968777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmmBnH8SaXShmttGIVhlHzTTaFEYyrDdxlkZ0RuRQR4=;
	b=FQdkhRh4QvgfVUJRt2B9T8dfeTOjFnSMfLpX94GdcEEMr2Pvt4TJ2y8HCZ3xLW8SlCo5J3
	GGdSnOJ8RLS6oHbR6MdLHCPpsaBu4jBwOsGYxAxPXuFKrlfrBlR7cHbQnzEBdwoOO8fP3C
	MIKh99K0Z5lRvSG/LKlGiGvsWjP4KCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760968777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmmBnH8SaXShmttGIVhlHzTTaFEYyrDdxlkZ0RuRQR4=;
	b=sZ3Z4urltaAQy3/wzDpnB159pgqUwC5GVizivDfXDuXJF4CrEWLGwfWmPEU+7fWalaRII7
	tFE6dVZIFACeKBAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DqBWEElY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Am1N2qnK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760968773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmmBnH8SaXShmttGIVhlHzTTaFEYyrDdxlkZ0RuRQR4=;
	b=DqBWEElYvnvcjpRcxmCvkOjO4x2GNuawgcCE2nygLkKUwtzwl4GjMR5xfBzodD4ZccKM/r
	Tcd99bLtPNSiqM40emp5lHeKUNa7n1CIdDfxC3kmzInHh3JndZqXzvkX78ZQ6r5RZM29wS
	ImNUJl9ugPXh8VvCf4xxqAnwkzKbifY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760968773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmmBnH8SaXShmttGIVhlHzTTaFEYyrDdxlkZ0RuRQR4=;
	b=Am1N2qnK4Exp2HlXaXMXTh7+exhfTCHEBPIXXqW07kb92eLCghLQc30zY0Uof7h5rSk7dQ
	/7as+glrXJ2xScAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B42913AAC;
	Mon, 20 Oct 2025 13:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G7viJUVA9mhjBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 13:59:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 16CBAA088E; Mon, 20 Oct 2025 15:59:33 +0200 (CEST)
Date: Mon, 20 Oct 2025 15:59:33 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYgm3ey4eiFB4_o@infradead.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B2F121F449
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 20-10-25 04:44:27, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 01:16:39PM +0200, Jan Kara wrote:
> > Hmm, this is an interesting twist in the problems with pinned pages - so
> > far I was thinking about problems where pinned page cache page gets
> > modified (e.g. through DIO or RDMA) and this causes checksum failures if
> > it races with writeback. If I understand you right, now you are concerned
> > about a situation where some page is used as a buffer for direct IO write
> > / RDMA and it gets modified while the DMA is running which causes checksum
> > mismatch?
> 
> Really all of the above.  Even worse this can also happen for reads,
> e.g. when the parity or checksum is calculated in the user buffer.

OK.

> > Writeprotecting the buffer before the DIO starts isn't that hard
> > to do (although it has a non-trivial cost) but we don't have a mechanism to
> > make sure the page cannot be writeably mapped while it is pinned (and
> > avoiding that without introducing deadlocks would be *fun*).
> 
> Well, this goes back to the old idea of maybe bounce buffering in that
> case?

The idea was to bounce buffer the page we are writing back in case we spot
a long-term pin we cannot just wait for - hence bouncing should be rare.
But in this more general setting it is challenging to not bounce buffer for
every IO (in which case you'd be basically at performance of RWF_DONTCACHE
IO or perhaps worse so why bother?). Essentially if you hand out the real
page underlying the buffer for the IO, all other attemps to do IO to that
page have to block - bouncing is no longer an option because even with
bouncing the second IO we could still corrupt data of the first IO once we
copy to the final buffer. And if we'd block waiting for the first IO to
complete, userspace could construct deadlock cycles - like racing IO to
pages A, B with IO to pages B, A. So far I'm not sure about a sane way out
of this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

