Return-Path: <linux-fsdevel+bounces-68211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57657C5754C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E5A54E3C1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A674334D900;
	Thu, 13 Nov 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hrHHQWEp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nkXakMXt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hrHHQWEp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nkXakMXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616661FF7B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035603; cv=none; b=cENnfVPSnKvhdTMjUlk7QNeLu7w7mdtvP+sBVspdK1XqMi4ntgxIqU9/FPOiTRO39f7ZPMLwrny6HaZPtKHVpV4xUAFpXMshYsaSrqpnyc7dWBVzOJBcWBy4jezv2P9jVJ32lwFj/1dZpVdk0LXcYTFEGEgbH2hq8oJUTLYmECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035603; c=relaxed/simple;
	bh=yrvDiDKzpFYSwwEOjEa2jRDwy5YUGiYDzkG7yPgzIBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4UBA7ohZos9n81NtFrWgzP3AaUUi10cbXuQqY5mLICHlG/EP+glgNRx+FaYRKKBOxlPYGLtQWbTwW+kQTnlTjp5TvfVbZfsOg5TpLay20ugI1IXmo5uBOOtPMYkyucor2LIs3y/na1Kei7nZU3gJOy4r7b2f7XzThM888LZI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hrHHQWEp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nkXakMXt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hrHHQWEp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nkXakMXt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C53F1F791;
	Thu, 13 Nov 2025 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763035598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XxtGqNT9dhEtTqLxGydDggWgePLuKL0ln40czHWmrDY=;
	b=hrHHQWEpVmvsUN5Li7eb2fPV7DCyf9GIDv0ZgTSU9f2fcUVb7PwYjAsEpHI24bOF7czucT
	oVw6ybzIwTfJVNKwQ34Lu2HmpbEM6zaIsDa9+asf3kRSubBpLoWR5kZsnRq2C8VG8BZxDA
	WuG4SeWjHhe/6xnttyCwBk565+ZvpZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763035598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XxtGqNT9dhEtTqLxGydDggWgePLuKL0ln40czHWmrDY=;
	b=nkXakMXtMygpkBjVfjmVjRtyIf1c6+FPT0l1K6EPikR4sxe5YzLEsO+cSI7M9l7xyllbwj
	1fF+eDwPpIPbK1Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hrHHQWEp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nkXakMXt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763035598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XxtGqNT9dhEtTqLxGydDggWgePLuKL0ln40czHWmrDY=;
	b=hrHHQWEpVmvsUN5Li7eb2fPV7DCyf9GIDv0ZgTSU9f2fcUVb7PwYjAsEpHI24bOF7czucT
	oVw6ybzIwTfJVNKwQ34Lu2HmpbEM6zaIsDa9+asf3kRSubBpLoWR5kZsnRq2C8VG8BZxDA
	WuG4SeWjHhe/6xnttyCwBk565+ZvpZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763035598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XxtGqNT9dhEtTqLxGydDggWgePLuKL0ln40czHWmrDY=;
	b=nkXakMXtMygpkBjVfjmVjRtyIf1c6+FPT0l1K6EPikR4sxe5YzLEsO+cSI7M9l7xyllbwj
	1fF+eDwPpIPbK1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B25A3EA61;
	Thu, 13 Nov 2025 12:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PkIMHs7JFWkyFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Nov 2025 12:06:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3643AA0976; Thu, 13 Nov 2025 13:06:34 +0100 (CET)
Date: Thu, 13 Nov 2025 13:06:34 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Darrick J. Wong" <djwong@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Avi Kivity <avi@scylladb.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org
Subject: Re: [PATCH 4/5] iomap: support write completions from interrupt
 context
Message-ID: <ewzcc5tots6ughnbqlqmvje4ex2eb5tug2mapzvcf4zstb7fxn@qruu4xs4nblt>
References: <20251112072214.844816-1-hch@lst.de>
 <20251112072214.844816-5-hch@lst.de>
 <nujtqnweb7jfbyk4ov3a7z5tdtl24xljntzbpecgv6l7aoeytd@nkxsilt6w7d3>
 <20251113065055.GA29641@lst.de>
 <x76swsaqkkyko6oyjch2imsbqh3q3dx3uqqofjnktzbzfdkbhe@jog777bckvu6>
 <20251113100630.GB10056@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113100630.GB10056@lst.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8C53F1F791
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -4.01

On Thu 13-11-25 11:06:30, Christoph Hellwig wrote:
> On Thu, Nov 13, 2025 at 10:54:46AM +0100, Jan Kara wrote:
> > > You mean drop the common helper?  How would that be better and less
> > > fragile?   Note that I care strongly, but I don't really see the point.
> > 
> > Sorry I was a bit terse. What I meant is that the two users of
> > iomap_dio_is_overwrite() actually care about different things and that
> > results in that function having a bit odd semantics IMHO. The first user
> > wants to figure out whether calling generic_write_sync() is needed upon io
> > completion to make data persistent (crash safe).
> 
> Yes.
> 
> > The second user cares
> > whether we need to do metadata modifications upon io completion to make data
> > visible at all.
> 
> Not quite.  It cares if either generic_write_sync needs be called,
> or we need a metadata modification, because both require the workqueue.

I agree but generic_write_sync() calling is handled by 

+       else if (dio->flags & IOMAP_DIO_NEED_SYNC)
+               dio->flags &= ~IOMAP_DIO_INLINE_COMP;

in your patch. So I assumed (maybe wrongly) that the second call to
iomap_dio_is_overwrite() in iomap_dio_bio_iter() is only about detecting a
need of metadata modification. And my argument is that the patch could use
IOMAP_DIO_UNWRITTEN | IOMAP_DIO_COW the same way as it uses
IOMAP_DIO_NEED_SYNC instead of calling iomap_dio_is_overwrite().

But if you don't like that I don't think it makes a huge difference and the
code is correct as is so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

