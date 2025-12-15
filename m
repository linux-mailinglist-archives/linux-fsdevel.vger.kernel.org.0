Return-Path: <linux-fsdevel+bounces-71365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606ECBF56C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 19:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC2E3016340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B97325496;
	Mon, 15 Dec 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dA7IVJmI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1RPZ0nE7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dA7IVJmI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1RPZ0nE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F75322C73
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821631; cv=none; b=jUC5bM+k2KqW+icJXN7nfUaF3kyVZCRE483fb97xheXvqVi4J26r1RLrMTI6YzP62q2TXJLOzReY/QuXyoTdHssAFCHiHkktrnp8CjQtuadSsumlP2AZx89dNDe1FcW4C4R+ljroOK2JyNnxF6l0XgyaNKZVFPPGzMgutGlxMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821631; c=relaxed/simple;
	bh=PP1QB9fP7iJIa9UMyxTSOQmxthWq7BvOOJOKOeGeSgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St1uh+iePI1xBVK+qdyvjo90mANimIyhUr3WX7/XM2M8CYMFmGdeZfzFPbR2h02RWqdUcr3df4N6P0OfX6/iepKZ+URvjjrbuIJr+i1NTIToqYdsjQCWXe1y0+bObGiuHWdcIuKbiD6Gouj3a2AC/9+A3lOB5DsSk7KZLjbwXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dA7IVJmI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1RPZ0nE7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dA7IVJmI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1RPZ0nE7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA36C337FA;
	Mon, 15 Dec 2025 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765821627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NB+wF0ukLb6g2fbRJemjtHvsFGr3BKPYjICDCF6HH+k=;
	b=dA7IVJmIx4yykWLzmbmNGytoNvmrE2GCvufzTNYMpw1+oK49blXx+hVpb+DJsYkwyEpA/C
	drlGJBlYDPSEbiNn7DclExM6ol11MD4Nsbm/vwF/UMoATwZd1yfTBYmmc/zqz+y3McrnBz
	BCScszpx8S3hoBbwIEeHWnTF5pKbRco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765821627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NB+wF0ukLb6g2fbRJemjtHvsFGr3BKPYjICDCF6HH+k=;
	b=1RPZ0nE7XHEdIQR6UnyTwJDTir6oc7uGcoXgMs/XPbzWrTzAeJnl/XwbGdd/+Th5s7M3Be
	rM82wEv2wH2lKWDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765821627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NB+wF0ukLb6g2fbRJemjtHvsFGr3BKPYjICDCF6HH+k=;
	b=dA7IVJmIx4yykWLzmbmNGytoNvmrE2GCvufzTNYMpw1+oK49blXx+hVpb+DJsYkwyEpA/C
	drlGJBlYDPSEbiNn7DclExM6ol11MD4Nsbm/vwF/UMoATwZd1yfTBYmmc/zqz+y3McrnBz
	BCScszpx8S3hoBbwIEeHWnTF5pKbRco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765821627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NB+wF0ukLb6g2fbRJemjtHvsFGr3BKPYjICDCF6HH+k=;
	b=1RPZ0nE7XHEdIQR6UnyTwJDTir6oc7uGcoXgMs/XPbzWrTzAeJnl/XwbGdd/+Th5s7M3Be
	rM82wEv2wH2lKWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C09893EA63;
	Mon, 15 Dec 2025 18:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XCUAL7tMQGkNXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Dec 2025 18:00:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B4ACA0927; Mon, 15 Dec 2025 19:00:19 +0100 (CET)
Date: Mon, 15 Dec 2025 19:00:19 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, jack@suse.cz, 
	Deepakkumar Karn <dkarn@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/buffer: add alert in try_to_free_buffers() for
 folios without buffers
Message-ID: <bqxwr6mbyhgstdidmhvz7cbojkdizmlrsdu3x7cfj3n4xt5nuy@h7imqnipzihl>
References: <20251211131211.308021-1-dkarn@redhat.com>
 <20251215-zuckungen-autogramm-a0c4291e525b@brauner>
 <aUAWwPWDq0GgAjnP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUAWwPWDq0GgAjnP@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 15-12-25 14:10:08, Matthew Wilcox wrote:
> On Mon, Dec 15, 2025 at 03:07:35PM +0100, Christian Brauner wrote:
> > On Thu, 11 Dec 2025 18:42:11 +0530, Deepakkumar Karn wrote:
> > > try_to_free_buffers() can be called on folios with no buffers attached
> > > when filemap_release_folio() is invoked on a folio belonging to a mapping
> > > with AS_RELEASE_ALWAYS set but no release_folio operation defined.
> > > 
> > > In such cases, folio_needs_release() returns true because of the
> > > AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
> > > causes try_to_free_buffers() to call drop_buffers() on a folio with no
> > > buffers, leading to a null pointer dereference.
> > > 
> > > [...]
> > 
> > Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.0.misc branch should appear in linux-next soon.
> 
> No, this is the wrong fix.  Please drop.

Nobody says this is a fix (it has WARN_ON() in it after all). But it's a
sensible hardening regardless of other changes we do in this area. After our
discussion I agree that the change to mapping_set_release_always() is not
needed if we instead rework how .release_folio (and try_to_free_buffers())
is called but this is a separate change...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

