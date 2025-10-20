Return-Path: <linux-fsdevel+bounces-64719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33364BF243B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26EE189FBFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248227BF7C;
	Mon, 20 Oct 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bnhi+g3V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jmb7mHUP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDSbH0dq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5WSTFPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52CD27A103
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975946; cv=none; b=AYRbwf0UOX9yMBGPDMtCeUGUGpMBLxNNykov2KiTiNLxSKNN5ViZZYHSPlhKRWhmYqAz81dSSiZYGt4+578y+yHB9xz6i7NWGJbkgRb5lksZbE9Av6LeYh+/TZ+8UI5bM5ouDAieDimneoCsbTiC5XCNuiMqClD5YZVXXeXGW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975946; c=relaxed/simple;
	bh=oPxzTs6WsuKHqebg42NTifrc63HsEvL1hy6GgDh6TXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWjZmKf988dMyId26vQtrWJlWnGh8VeiVylOEIrTxX2T/zkZGm6TTWLMSz2oiv4aqeKbdemPn0A4bH/7Xexdt0AfwFNpcBj5tKaNHPvFMWyHg2eS19lPwOxg2b0arqJENQpyDW4wBQyR9Am1yzLWKivtkX0opLNSOnECLj9ANFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bnhi+g3V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jmb7mHUP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDSbH0dq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5WSTFPT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B09F8211AD;
	Mon, 20 Oct 2025 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760975938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+T13MT5+DVqI4FOljyY2wyHe35kwNpItnKtnAfrs7U=;
	b=bnhi+g3V4guyjrFM7W2wvNQYgft8AKwfnrmdAJfYt+OshztZCGnA1OLjpJEGZIFD2RyIeB
	0xCUTtvLxJmDGaz2Hjk5AUzrIJZ2m42QncakyNgpWMG5GRQloTyBkPAyCYSdl47ukrkEAh
	Pxm1sV4k/jmAPJwphJBbggz9CK0Lt8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760975938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+T13MT5+DVqI4FOljyY2wyHe35kwNpItnKtnAfrs7U=;
	b=jmb7mHUPVa8eqJyOkhrTMAJqcVl0YdILYwlGdaxHrB9Bg+CkElEHgd7V5CWs/1fw2LgFxM
	7MiFG2FTf5cyVNAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760975934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+T13MT5+DVqI4FOljyY2wyHe35kwNpItnKtnAfrs7U=;
	b=eDSbH0dqSfRA6WHKd9eLOdNQcxqexCI4JCFeyuSRhL4zpE3t9/I286H+RaDKonEHzKtgkm
	s5JBwkXqBlXOmjwrbCT9ixRSjikaAiX5mfxrkXJwfZY38sixPiNF2z25ST6srKiIHUFz4Y
	vqVvzvIQ0MkIc6GcPvVoNyvIm7A+OLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760975934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+T13MT5+DVqI4FOljyY2wyHe35kwNpItnKtnAfrs7U=;
	b=P5WSTFPTevE66kkbFzbp2BlR5n8P+P85VjF6E9ukLw6GquJTeMbJVLmhe4KZGa+kJD0dNh
	hn8X7c3dF213TYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1EB413AAC;
	Mon, 20 Oct 2025 15:58:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V4+DJz5c9mhJeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 15:58:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 536C2A088E; Mon, 20 Oct 2025 17:58:54 +0200 (CEST)
Date: Mon, 20 Oct 2025 17:58:54 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, djwong@kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZOO3dFv61blHBz@casper.infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 20-10-25 15:59:07, Matthew Wilcox wrote:
> On Mon, Oct 20, 2025 at 03:59:33PM +0200, Jan Kara wrote:
> > The idea was to bounce buffer the page we are writing back in case we spot
> > a long-term pin we cannot just wait for - hence bouncing should be rare.
> > But in this more general setting it is challenging to not bounce buffer for
> > every IO (in which case you'd be basically at performance of RWF_DONTCACHE
> > IO or perhaps worse so why bother?). Essentially if you hand out the real
> > page underlying the buffer for the IO, all other attemps to do IO to that
> > page have to block - bouncing is no longer an option because even with
> > bouncing the second IO we could still corrupt data of the first IO once we
> > copy to the final buffer. And if we'd block waiting for the first IO to
> > complete, userspace could construct deadlock cycles - like racing IO to
> > pages A, B with IO to pages B, A. So far I'm not sure about a sane way out
> > of this...
> 
> There isn't one.  We might have DMA-mapped this page earlier, and so a
> device could write to it at any time.  Even if we remove PTE write
> permissions ...

True but writes through DMA to the page are guarded by holding a page pin
these days so we could in theory block getting another page pin or mapping
the page writeably until the pin is released... if we can figure out a
convincing story for dealing with long-term pins from RDMA and dealing with
possible deadlocks created by this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

