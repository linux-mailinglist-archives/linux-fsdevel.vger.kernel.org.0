Return-Path: <linux-fsdevel+bounces-54878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3284EB047AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 21:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BCC1AA0541
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 19:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDE5277008;
	Mon, 14 Jul 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVctf+Qh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mEOC/fLb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVctf+Qh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mEOC/fLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD713D531
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519766; cv=none; b=UtG7K3Cvq/Ek7Lm8t/apC1vcVbwxJqkSaVJrxCn2wNJRU8p2NMXCkNfYoWzEo7WpB6beX7sIJiQe6tLqF3ghTwPXd1RI9UfkA/6JOWXIVMKJdjPTY1Gdvz+Ygr65PYi+IL0k4fYfxyBJsXgDpJEx9DUzvwkjY9+0KpOkXDlN1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519766; c=relaxed/simple;
	bh=wO0CTJ/RXBHNN7GwcT4whj+ZmDFp7wHi5Bmx/NJkTBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuwZ4zJ5d7Ey0mCU6wxClk45uAngPJwmmtahs6AIbq2xfKRoPEQDZl1KwAkeLmvnu8YzCrrz8plMIE4s6KWeRfPOvdzcjURivjcyys4cyGCVMpGX8BRRuNjDwiVBLWV3FpoItzkx3KwG+sbluPJXdrC2jztxWpfzAWmJ0k49BMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVctf+Qh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mEOC/fLb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVctf+Qh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mEOC/fLb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02C472124B;
	Mon, 14 Jul 2025 19:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752519763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyGT8kFpzU1IyAl9KRXM5N041xbNLlsDWUwF3dtjuXk=;
	b=GVctf+QhIV81UmbuyMt7EsVcNawjzu42HAq7xQXuaOfYwKF3axCUiI2Hk6TXcE4QoRNoEM
	cLSvsHcWSYCcG1NjvL4d8GZvk4SZGSQonoZD1tgogIaldCBQAGZFUAl6ic4aNsF9Y0SdYV
	/niQP6xV26mvZfpRhlu5L7EO371MPNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752519763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyGT8kFpzU1IyAl9KRXM5N041xbNLlsDWUwF3dtjuXk=;
	b=mEOC/fLbOvnP8zloWhXGuKjS1yaofjHXs7tMvbKWIOM2lSyWR1v9CZ0A9JXKxHe4KxV9Wv
	OxiBEtlRqX+LpLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752519763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyGT8kFpzU1IyAl9KRXM5N041xbNLlsDWUwF3dtjuXk=;
	b=GVctf+QhIV81UmbuyMt7EsVcNawjzu42HAq7xQXuaOfYwKF3axCUiI2Hk6TXcE4QoRNoEM
	cLSvsHcWSYCcG1NjvL4d8GZvk4SZGSQonoZD1tgogIaldCBQAGZFUAl6ic4aNsF9Y0SdYV
	/niQP6xV26mvZfpRhlu5L7EO371MPNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752519763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyGT8kFpzU1IyAl9KRXM5N041xbNLlsDWUwF3dtjuXk=;
	b=mEOC/fLbOvnP8zloWhXGuKjS1yaofjHXs7tMvbKWIOM2lSyWR1v9CZ0A9JXKxHe4KxV9Wv
	OxiBEtlRqX+LpLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEE8913306;
	Mon, 14 Jul 2025 19:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TjY3NlJUdWiUdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Jul 2025 19:02:42 +0000
Date: Mon, 14 Jul 2025 21:02:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, wqu@suse.com,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
Message-ID: <20250714190233.GG22472@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250708132540.28285-1-dsterba@suse.com>
 <72fe27cf-b912-4459-bae6-074dd86e843b@gmx.com>
 <20250711191521.GF22472@twin.jikos.cz>
 <6bb8c4f4-bf17-471a-aa5f-ce26c8566a17@gmx.com>
 <a90a8a32-ea3a-4915-b98b-f52c51444aa5@gmx.com>
 <20250714-bahnfahren-bergregion-3491c6f304a4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-bahnfahren-bergregion-3491c6f304a4@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,suse.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Jul 14, 2025 at 12:27:37PM +0200, Christian Brauner wrote:
> > My bad, it's calling back into freeze_super() function, so it's fine.
> 
> You have to expose yourself to all the VFS handling and you must call
> freeze_super() at some point. You can't just do freeze on your own. You
> have roughly the following classes of freeze calls:
> 
> (1) initiated from userspace
>     (1.1) initiated from the block layer => upcall into the filesystem
>     (1.2) initiated from the filesystem
> (2) initiated from the kernel
>     (2.1) initiated from the filesystem
>     (2.2) suspend/hibernation
> 
> All of that requires synchronization and you cannot do this without
> going through the VFS layer's locking safely. At least not without
> causing royal pain for yourself and the block and VFS layer.

You weren't CCed on the initial patch
https://lore.kernel.org/linux-btrfs/20250708132540.28285-1-dsterba@suse.com/
so you can see we're not avoiding VFS, freeze_super() is called.

The problem I am solving is that we need to pass the information about
freezing being started before freeze_super() is called, or alternatively
by something that is set there before sb_wait_write() call.

> > The remaining concern is just should we do this by using
> > ->freeze_super() callback, or do the f2fs' way by poking into
> > s_writer.frozen.
> > 
> > I'd prefer the later one, as that's already exposed to filesystems and we do
> > not need extra callback functions especially when it's not widely used.
> 
> This would be simpler. You should probably add a helper that you can
> share with gfs2 to sample the state instead of raw accesses to
> s_writers->frozen. I find the latter a bit ugly and error prone if we
> ever change this. I'd rather have it encapsulated in the VFS layer as
> best as we can.

I chose to use separate bit rather than using s_writers->frozen, which
is what Qu prefers. I disgree with that on the API level as we probably
should not do such direct check. A helper would be best, semantically
teh same as the added filesystem bit.

