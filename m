Return-Path: <linux-fsdevel+bounces-17115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BAB8A7FFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDEC1F226D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D612F59A;
	Wed, 17 Apr 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZB6hfLpo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U3zn0NZY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZB6hfLpo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U3zn0NZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9AB130499
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346778; cv=none; b=Ovusi9pfo/rEQIufL5BNhXo8QpSY8d7Jdnb3Nw7nLMln4xpms+2GTlaWvamY53PFqLMuB4fE+Y0hR9gCD0VHudUbZF71oGmGlqSRtcsLC60D1Y+LAkivbgvjEtv2CO8BmMZZN8rVQUifj6JXuVX7yRhUew1XZWKDUzeAOjv1/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346778; c=relaxed/simple;
	bh=F0GRBvg4Uv00Pp+1Xr/FR03rcoKUzlhwmfV3bDEQ7r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEEkHgWJ2icnKU5rwjPAV7VP1qCUAKz57mqb7zJ/WIR20poAVlUyxGBWUWVbsV4lBv7A2BA48iwLAlICR82rfUFP/S576LJNqIGUjhD38Yhklw6FaBDzPa9fFBodNEb/IDdw9hzdbHQ07HeMuOmaTO1vqfhCFPDIyexbMpsqgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZB6hfLpo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U3zn0NZY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZB6hfLpo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U3zn0NZY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F1E52065E;
	Wed, 17 Apr 2024 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713346774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Clq/MY3EBsb8V6KxiJub0cW84kcxlN42/ve81yNyQw=;
	b=ZB6hfLpoDbPvkTXKuBi8QB/knJ0I5lWitHhuv6NW44G/dJ+AUPkX1+OznJ4nnO+z1Iypr4
	BaoV5k93XF6vjIw+N4GNR4lxac2RSY53qDs7KcmFD6BXY3E+ySxkLvMURh3crbjlsYD8DO
	uaH81IHuwJfti/YfuR15ogoSpuJGmYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713346774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Clq/MY3EBsb8V6KxiJub0cW84kcxlN42/ve81yNyQw=;
	b=U3zn0NZY/zjLh43opCcHuXNi9MOMTWv785czbO4yfjKmOC5Y+9JcVzCGwenA0cMmSO57WY
	nKMtCi1xJb7FrHCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713346774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Clq/MY3EBsb8V6KxiJub0cW84kcxlN42/ve81yNyQw=;
	b=ZB6hfLpoDbPvkTXKuBi8QB/knJ0I5lWitHhuv6NW44G/dJ+AUPkX1+OznJ4nnO+z1Iypr4
	BaoV5k93XF6vjIw+N4GNR4lxac2RSY53qDs7KcmFD6BXY3E+ySxkLvMURh3crbjlsYD8DO
	uaH81IHuwJfti/YfuR15ogoSpuJGmYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713346774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Clq/MY3EBsb8V6KxiJub0cW84kcxlN42/ve81yNyQw=;
	b=U3zn0NZY/zjLh43opCcHuXNi9MOMTWv785czbO4yfjKmOC5Y+9JcVzCGwenA0cMmSO57WY
	nKMtCi1xJb7FrHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54F9213957;
	Wed, 17 Apr 2024 09:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id edS4FNaYH2auXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Apr 2024 09:39:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F06FCA082E; Wed, 17 Apr 2024 11:39:33 +0200 (CEST)
Date: Wed, 17 Apr 2024 11:39:33 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	kernel-team@fb.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Changing how we do file system
 maintenance
Message-ID: <20240417093933.e6mwtdjpibxu67lu@quack3>
References: <20240416180414.GA2100066@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416180414.GA2100066@perftesting>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hello!

On Tue 16-04-24 14:04:14, Josef Bacik wrote:
> I would like to propose we organize ourselves more akin to the other large
> subsystems.  We are one of the few where everybody sends their own PR to Linus,
> so oftentimes the first time we're testing eachothers code is when we all rebase
> our respective trees onto -rc1.  I think we could benefit from getting more
> organized amongst ourselves, having a single tree we all flow into, and then
> have that tree flow into Linus.
> 
> I'm also not a fan of single maintainers in general, much less for this large of
> an undertaking.  I would also propose that we have a maintainership group where
> we rotate the responsibilities of the mechanics of running a tree like this.
> I'm nothing if not unreliable so I wouldn't be part of this group per se, but I
> don't think we should just make Christian do it.  This would be a big job, and
> it would need to be shared.
> 
> I would also propose that along with this single tree and group maintainership
> we organize some guidelines about the above problems and all collectively agree
> on how we're going to address them.  Having clear guidelines for adding new file
> systems, clear guidelines for removing them.  Giving developers the ability to
> make big API changes outside of the individual file systems trees to make it
> easier to get things merged instead of having to base against 4 or 5 different
> trees.  Develop some guidelines about how we want patches to look, how we want
> testing to be done, etc. so people can move through our different communities
> and not have drastically different experiences.
> 
> This is a massive proposal, and not one that we're going to be able to nail down
> and implement quickly or easily.  But I think in the long term it'll make
> working in our community simpler, more predictable, and less frustrating for
> everybody.  Thanks,

I think this is good discussion for the FS track. I'd be certainly
interested in this.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

