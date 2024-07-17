Return-Path: <linux-fsdevel+bounces-23823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B8933D79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9CBB20EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878591802A7;
	Wed, 17 Jul 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FCsQ8CH/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i1oShcmK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FCsQ8CH/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i1oShcmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9C1BF3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222177; cv=none; b=Rvs3NZn1vGupgm8UHVD5Nfn7Snvh1HLw2d/H04xMm6eu8edctF66eScZE2BREk+xYXzEUYt251j0RdFjxPPZbGrXZlwOKsPcXdWGR0CQgbwwKS29wZrioCYhn5qNAjlN4TjWb0Js+f/VmsIHMvxzI+TFT1o9FV8iAhY4497t9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222177; c=relaxed/simple;
	bh=mY7haYfcSHgx7WoMlKDUqOnMNLyMV+I4Z6yflBljg1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBpDL5r2pUHCkOFOt0UTIgaTSZ/L2r4h5o4WCxhHMShV1P2CzAFWBU7BtcGEUeOwb9eqP4KLT+DQ6OiyLYYAaojLGIFowE9fAcH+p3zmV3OvqKwGSdWScC4yv383XvGYy2sek8X+pEOA5s7WxtUU5LaKSzZl2zMJnKh2e41Iu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FCsQ8CH/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i1oShcmK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FCsQ8CH/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i1oShcmK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89C931FCEC;
	Wed, 17 Jul 2024 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721222173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciFJhjOyYeYfMPLTIVlo4ew7V5xqTYycL9E+NzpYny4=;
	b=FCsQ8CH/Eps6DQDcYbhVUzSCtObr5Vgar8Gff62KPHGp89ADl+6j//S2TTrKql11IMrBNV
	GWyCh/MtR0RJ7IQlkDQdGDkS4mb0t4SBnnbb2X24BFYKLEUgQ0NaVJrjwdoqbQfdwVLyOb
	SrA/UWn5CHp6HPfwrD2AmgZN5Ldo5oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721222173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciFJhjOyYeYfMPLTIVlo4ew7V5xqTYycL9E+NzpYny4=;
	b=i1oShcmKC1sFokMYrLzxpxpu3nDTHqetkmlUs39EhKXUUbF9U997JtwXm+FXAZX4RyE049
	o9BsJiWKW4W7h7BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721222173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciFJhjOyYeYfMPLTIVlo4ew7V5xqTYycL9E+NzpYny4=;
	b=FCsQ8CH/Eps6DQDcYbhVUzSCtObr5Vgar8Gff62KPHGp89ADl+6j//S2TTrKql11IMrBNV
	GWyCh/MtR0RJ7IQlkDQdGDkS4mb0t4SBnnbb2X24BFYKLEUgQ0NaVJrjwdoqbQfdwVLyOb
	SrA/UWn5CHp6HPfwrD2AmgZN5Ldo5oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721222173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciFJhjOyYeYfMPLTIVlo4ew7V5xqTYycL9E+NzpYny4=;
	b=i1oShcmKC1sFokMYrLzxpxpu3nDTHqetkmlUs39EhKXUUbF9U997JtwXm+FXAZX4RyE049
	o9BsJiWKW4W7h7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FA69136E5;
	Wed, 17 Jul 2024 13:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DIE7Gx3El2aYbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 13:16:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D59EA0987; Wed, 17 Jul 2024 15:16:09 +0200 (CEST)
Date: Wed, 17 Jul 2024 15:16:09 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fsnotify: Avoid data race between
 fsnotify_recalc_mask() and fsnotify_object_watched()
Message-ID: <20240717131609.elqjv5yeufdndhmi@quack3>
References: <20240715130410.30475-1-jack@suse.cz>
 <20240715142203.GA1649877@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715142203.GA1649877@perftesting>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[701037856c25b143f1ad];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Mon 15-07-24 10:22:03, Josef Bacik wrote:
> On Mon, Jul 15, 2024 at 03:04:10PM +0200, Jan Kara wrote:
> > When __fsnotify_recalc_mask() recomputes the mask on the watched object,
> > the compiler can "optimize" the code to perform partial updates to the
> > mask (including zeroing it at the beginning). Thus places checking
> > the object mask without conn->lock such as fsnotify_object_watched()
> > could see invalid states of the mask. Make sure the mask update is
> > performed by one memory store using WRITE_ONCE().
> > 
> > Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Link: https://lore.kernel.org/all/CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> I'm still hazy on the rules here and what KCSAN expects, but if we're using
> READ_ONCE/WRITE_ONCE on a thing, do we have to use them everywhere we access
> that member?  Because there's a few accesses in include/linux/fsnotify_backend.h
> that were missed if so.  Thanks,

Indeed there are two accesses there that should be using READ_ONCE() as
well. I've missed those. Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

