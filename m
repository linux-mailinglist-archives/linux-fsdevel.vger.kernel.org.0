Return-Path: <linux-fsdevel+bounces-29454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F41979F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967C71C232C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA9E1552E0;
	Mon, 16 Sep 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozU29vl5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P782iKJW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozU29vl5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P782iKJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656C154452;
	Mon, 16 Sep 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483307; cv=none; b=sf34sP6Yq64Bko3Vbt+gI/GGt5Ne/OAVbEw1NPGW5ns+I1F97RdP80lSWmK8NvhWVB7CpQP8ujr0YtwBDccZ6V2+i6jVtlSZPr3Nf3z0nHQtzvYV24HiDbYmk73MaI6NLqaaRwOSSUghjn5pfx/e2Lp4HYgrXthlBsutu2uoKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483307; c=relaxed/simple;
	bh=+eAUe1ZWABJhNJlB37hWU1XZqWNeqT/0ac9DwLkeS34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMyU6ufp2JHAHXlFaEgmxRrXnjBXzzq3MWd6hZn4+DXOd3mKA599NG9oXPWwuJVrHrrkKqAK6D0VxNVNmkCmuSmjRqeGTNP8WX1HZpPNC6pLVccRwmXDbgcYcXBRDISjjtDs4oLtHd8ALB6sZ2o7CUqKqRXdc8TTO+jdnPm5t+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozU29vl5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P782iKJW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozU29vl5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P782iKJW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 900CB21B89;
	Mon, 16 Sep 2024 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726483303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N3aOGLH423G/wEEHTy7fM4jmCXgglLmwd1qlb5YIg=;
	b=ozU29vl5gK1sNFAtjZDsHYPZJK3MaYwcT4LbyRWubGVvq3IL6rsQzi00/v97cSfvDQyR8r
	iYxUXKHve+x1clM5OAz98G0mbZIDz4GuJMb0QLwx5X+92uYZDNhYKvWZ+sQYmGdm685VnH
	F0PvcpWjzTT1KOLm9q1Ty1E9wdp9edQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726483303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N3aOGLH423G/wEEHTy7fM4jmCXgglLmwd1qlb5YIg=;
	b=P782iKJWrVmFxfPRrldNvRMyNYW7+9SgwWth7Boufeht3mUClyMS1Eb67YIPGcny3EeJKL
	SGo6NYHrC9Ky5cDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ozU29vl5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=P782iKJW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726483303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N3aOGLH423G/wEEHTy7fM4jmCXgglLmwd1qlb5YIg=;
	b=ozU29vl5gK1sNFAtjZDsHYPZJK3MaYwcT4LbyRWubGVvq3IL6rsQzi00/v97cSfvDQyR8r
	iYxUXKHve+x1clM5OAz98G0mbZIDz4GuJMb0QLwx5X+92uYZDNhYKvWZ+sQYmGdm685VnH
	F0PvcpWjzTT1KOLm9q1Ty1E9wdp9edQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726483303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N3aOGLH423G/wEEHTy7fM4jmCXgglLmwd1qlb5YIg=;
	b=P782iKJWrVmFxfPRrldNvRMyNYW7+9SgwWth7Boufeht3mUClyMS1Eb67YIPGcny3EeJKL
	SGo6NYHrC9Ky5cDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80D6B13A91;
	Mon, 16 Sep 2024 10:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OcxmH2cL6GZMaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Sep 2024 10:41:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1EB3FA08B3; Mon, 16 Sep 2024 12:41:39 +0200 (CEST)
Date: Mon, 16 Sep 2024 12:41:39 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
Message-ID: <20240916104139.exqiayn2o7uniw2p@quack3>
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org>
 <20240913112602.xrfdn7hinz32bhso@quack3>
 <bfc8fc016aa16a757f264010fdb8e525513379ce.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc8fc016aa16a757f264010fdb8e525513379ce.camel@kernel.org>
X-Rspamd-Queue-Id: 900CB21B89
X-Spam-Score: -4.01
X-Rspamd-Action: no action
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 13-09-24 08:01:28, Jeff Layton wrote:
> On Fri, 2024-09-13 at 13:26 +0200, Jan Kara wrote:
> > On Thu 12-09-24 14:02:52, Jeff Layton wrote:
> > > +/**
> > > + * ktime_get_real_ts64_mg - attempt to update floor value and return result
> > > + * @ts:		pointer to the timespec to be set
> > > + * @cookie:	opaque cookie from earlier call to ktime_get_coarse_real_ts64_mg()
> > > + *
> > > + * Get a current monotonic fine-grained time value and attempt to swap
> > > + * it into the floor using @cookie as the "old" value. @ts will be
> > > + * filled with the resulting floor value, regardless of the outcome of
> > > + * the swap.
> > > + */
> > > +void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
> > > +{
> > > +	struct timekeeper *tk = &tk_core.timekeeper;
> > > +	ktime_t offset, mono, old = (ktime_t)cookie;
> > > +	unsigned int seq;
> > > +	u64 nsecs;
> > 
> > So what would be the difference if we did instead:
> > 
> > 	old = atomic64_read(&mg_floor);
> > 
> > and not bother with the cookie? AFAIU this could result in somewhat more
> > updates to mg_floor (the contention on the mg_floor cacheline would be the
> > same but there would be more invalidates of the cacheline). OTOH these
> > updates can happen only if max(current_coarse_time, mg_floor) ==
> > inode->i_ctime which is presumably rare? What is your concern that I'm
> > missing?
> > 
> 
> My main concern is the "somewhat more updates to mg_floor". mg_floor is
> a global variable, so one of my main goals is to minimize the updates
> to it. There is no correctness issue in doing what you're saying above
> (AFAICT anyway), but the window of time between when we fetch the
> current floor and try to do the swap will be smaller, and we'll end up
> doing more swaps as a result.
> 
> Do you have any objection to adding the cookie to this API?

No objection as such but as John said, I had also some trouble
understanding what the cookie value is about and what are the constraints
in using it. So if we can live without cookie, it would be a simplification
of the API. If the cooking indeed brings noticeable performance benefit, we
just need to document that the cookie is about performance and how to use
it to get good performance.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

