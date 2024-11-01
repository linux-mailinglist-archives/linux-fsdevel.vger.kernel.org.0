Return-Path: <linux-fsdevel+bounces-33490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BE89B96B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 18:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F4C1C21B54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB31CCEED;
	Fri,  1 Nov 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fjjAXLw6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHsb90yC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fjjAXLw6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHsb90yC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C71AC884;
	Fri,  1 Nov 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482817; cv=none; b=Iz4vqMlrb9Q5IxIgZAiKWP8AKUg8u3PxXUG38pjARAiJdm9u3R4Klpojz8KwfBTiwmHTktl8utnXcNLXU7erSq0t8mloi18FIeW15jHfcBvLQ7CDoYKeMaSvnseMceZi+uXW/ITCLH8KLpbBDDjyB0IzXB7SBE+0M8XHk1OlayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482817; c=relaxed/simple;
	bh=CZrAVnnpzOJDdVoZU/5ILdchGhlyW/PdozvsrQHMfi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4LQZiS6A9eSC4hQbhomA4xdqvPL9os91uL4dPfVcOuzI+vTWE/LtWOOUiupPPad5FtJh/sWIFc4A5TdGJxyBhY+YieqpuyQisQtvaaDu9ckb2czypqn8AwtIydB1h0WsXCw12ictNW+qQ9+ESYarYkRi/gdG7b83Bm2edQPcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fjjAXLw6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHsb90yC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fjjAXLw6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHsb90yC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 013A41FD1A;
	Fri,  1 Nov 2024 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730482812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EkUVnR3b2RICCgZ0VtY69liY0oePq73KCG0v1Hn+ThA=;
	b=fjjAXLw61xUIZ3mOr5IxfAcVwcarlS+ogFC4ZIPC39p05+Lyi7I99vNSH0o6gsC3YXZt7a
	V5isn7hiQ/dIu5MeMcSSr5W6d4MX/899Ohd4GwSPhrpxiKnG03ZnSLL46a1AceQFBlTvFl
	98519cGcipwUF+F3fsaPwLqv3ySnuqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730482812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EkUVnR3b2RICCgZ0VtY69liY0oePq73KCG0v1Hn+ThA=;
	b=aHsb90yC82idUpXZvg8L0mJHfT2bWGiy1aWtULHBKowsyUw+DfBCg+aleRt4j4IUF1Vn3x
	ggPTLjvWMRHiPlAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730482812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EkUVnR3b2RICCgZ0VtY69liY0oePq73KCG0v1Hn+ThA=;
	b=fjjAXLw61xUIZ3mOr5IxfAcVwcarlS+ogFC4ZIPC39p05+Lyi7I99vNSH0o6gsC3YXZt7a
	V5isn7hiQ/dIu5MeMcSSr5W6d4MX/899Ohd4GwSPhrpxiKnG03ZnSLL46a1AceQFBlTvFl
	98519cGcipwUF+F3fsaPwLqv3ySnuqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730482812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EkUVnR3b2RICCgZ0VtY69liY0oePq73KCG0v1Hn+ThA=;
	b=aHsb90yC82idUpXZvg8L0mJHfT2bWGiy1aWtULHBKowsyUw+DfBCg+aleRt4j4IUF1Vn3x
	ggPTLjvWMRHiPlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5EF2136C7;
	Fri,  1 Nov 2024 17:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8zzcN3sSJWe7OAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 01 Nov 2024 17:40:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C502A0AF7; Fri,  1 Nov 2024 18:39:56 +0100 (CET)
Date: Fri, 1 Nov 2024 18:39:56 +0100
From: Jan Kara <jack@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify.7,fanotify_mark.2: update documentation of
 fanotify w.r.t fsid
Message-ID: <20241101173956.2neyqoszjkdg53w4@quack3>
References: <20241008094503.368923-1-amir73il@gmail.com>
 <20241009153836.xkuzuei2gxeh2ghj@quack3>
 <20241101130732.xzpottv5ru63w4wd@devuan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101130732.xzpottv5ru63w4wd@devuan>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

Hi Alejandro!

On Fri 01-11-24 14:07:32, Alejandro Colomar wrote:
> On Wed, Oct 09, 2024 at 05:38:36PM +0200, Jan Kara wrote:
> > On Tue 08-10-24 11:45:03, Amir Goldstein wrote:
> > > Clarify the conditions for getting the -EXDEV and -ENODEV errors.
> > > 
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > 
> > Looks good. Feel free to add:
> 
> Please see some minor inline comments below.
> 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Thanks!
> 
> > 
> > But I've read somewhere that Alejandro stepped down as manpages maintainer
> > so they are officially unmaintained?
> 
> A contract is imminent, and I've started to review/apply old patches
> today already.  I'll probably make an official announcement soon.

I'm happy to hear that!

> Maintenance is restored.  (As much as I possibly can, since my region
> has limited electricity, water, and internet, after the worst flooding
> in centuries.)

I've heard about huge floods in Spain. We had pretty bad ones a month and
half ago in Czech republic as well. But my area was only lightly affected.
Stay safe!
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

