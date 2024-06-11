Return-Path: <linux-fsdevel+bounces-21427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D57903A10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B671C20D10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E817B42B;
	Tue, 11 Jun 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WtWc70mO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="noDFk3WR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ctZCvD7i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4cS1NJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008817A930;
	Tue, 11 Jun 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105331; cv=none; b=UheQHwcDIp/izTJ2dHLcEfvD/5saPd+2qt84IyST3HZLkcqv7yAmw6nNkPhxLBOmgImPIlQoYyp4P6lGeK1p/Fxrbd0Nxxb0j/UCMnGzVn+7RNsTJtBdOo7FvhmgA9oYYeerg2SaLXAg2fIDGFBMrlIxUEbkEa8ylrDB+E/0Ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105331; c=relaxed/simple;
	bh=sE2sIjcxSBPMVlZtqy+I5OHIi7O7fkx9sZPl7hLn5Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmnHhuayESUYBXzjYPo0A/DhxQrqKa6aapV3WNlU8HccCERLwGq7YwMDevwkevy1ndytUNBzuyLnnIkjEi1zHBup+eJe62X24kqeIHoaQ0Xyc4tW/V3f/T7K6PbKiJZ9PItVPSM/tKAmJVtB3Yxoxghl8LtJ1d5pFPavXLsgyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WtWc70mO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=noDFk3WR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ctZCvD7i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4cS1NJv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0615C22524;
	Tue, 11 Jun 2024 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718105328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHeWLnb8KC2jLdzBz76p5HVxy2f+0jlJm4o8fexYF44=;
	b=WtWc70mOW7GfXXgdvZFd3/ArRbxqoZgHNLR82V0S1M7KoUCUiTDnk2WVTPEUwGLenl0ZI8
	FxzTkCqJOGpZ3zJ8HSRabd1FnEZBdR43sEu6OXKmv4dFoxqHn5I6XbxxQ93pbww6P0DIO7
	Mv/9mRIDNgmbYoatZwilOP1tmvT8HZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718105328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHeWLnb8KC2jLdzBz76p5HVxy2f+0jlJm4o8fexYF44=;
	b=noDFk3WRdj9Ac3jYGApjPRm7VlqxP9mCUkYWUIJoq4e62bC4FV1nu2Isyotc/U4HPfcB0+
	SupSW9OGgeeGfgAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718105327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHeWLnb8KC2jLdzBz76p5HVxy2f+0jlJm4o8fexYF44=;
	b=ctZCvD7ir33yDP8d6Xu4TULtK2U4AAYnxT44yNBXShwM01+/b2EThUeLfB1XXYGNhWp1vp
	tEyV2EQefFpG2df8yxjOPpCp65sicVFilcJgKUsZNZksj0GaASvUeUk3NpR1keXwUzdUqN
	VuLnR0XCVrDSex4+sO+DutaESRnQdSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718105327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHeWLnb8KC2jLdzBz76p5HVxy2f+0jlJm4o8fexYF44=;
	b=N4cS1NJvOjhr8uz9+QRJAAug/T4DWztepasqQFk/IJ4kv4Tw8NUZ/CqANf0aA9ojnAss8I
	cSGuGHSCLEjjJwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF9C613A55;
	Tue, 11 Jun 2024 11:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vlh5Ou40aGY+GQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Jun 2024 11:28:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 93172A0889; Tue, 11 Jun 2024 13:28:46 +0200 (CEST)
Date: Tue, 11 Jun 2024 13:28:46 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <20240611112846.qesh7qhhuk3qp4dy@quack3>
References: <20240606140515.216424-1-mjguzik@gmail.com>
 <ZmJqyrgPXXjY2Iem@dread.disaster.area>
 <bujynmx7n32tzl2xro7vz6zddt5p7lf5ultnaljaz2p2ler64c@acr7jih3wad7>
 <ZmgkLHa6LoV8yzab@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmgkLHa6LoV8yzab@dread.disaster.area>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 11-06-24 20:17:16, Dave Chinner wrote:
> Your patch, however, just converts *some* of the lookup API
> operations to use RCU. It adds complexity for things like inserts
> which are going to need inode hash locking if the RCU lookup fails,
> anyway.
> 
> Hence your patch optimises the case where the inode is in cache but
> the dentry isn't, but we'll still get massive contention on lookup
> when the RCU lookup on the inode cache and inserts are always going
> to be required.
> 
> IOWs, even RCU lookups are not going to prevent inode hash lock
> contention for parallel cold cache lookups. Hence, with RCU,
> applications are going to see unpredictable contention behaviour
> dependent on the memory footprint of the caches at the time of the
> lookup. Users will have no way of predicting when the behaviour will
> change, let alone have any way of mitigating it. Unpredictable
> variable behaviour is the thing we want to avoid the most with core
> OS caches.

I don't believe this is what Mateusz's patches do (but maybe I've terribly
misread them). iget_locked() does:

	spin_lock(&inode_hash_lock);
	inode = find_inode_fast(...);
	spin_unlock(&inode_hash_lock);
	if (inode)
		we are happy and return
	inode = alloc_inode(sb);
	spin_lock(&inode_hash_lock);
	old = find_inode_fast(...)
	the rest of insert code
	spin_unlock(&inode_hash_lock);

And Mateusz got rid of the first lock-unlock pair by teaching
find_inode_fast() to *also* operate under RCU. The second lookup &
insertion stays under inode_hash_lock as it is now. So his optimization is
orthogonal to your hash bit lock improvements AFAICT. Sure his optimization
just ~halves the lock hold time for uncached cases (for cached it
completely eliminates the lock acquisition but I agree these are not that
interesting) so it is not a fundamental scalability improvement but still
it is a nice win for a contended lock AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

