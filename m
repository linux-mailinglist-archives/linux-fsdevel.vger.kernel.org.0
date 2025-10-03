Return-Path: <linux-fsdevel+bounces-63366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C2BB7069
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12E73B0465
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1821DE892;
	Fri,  3 Oct 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="08eoz1gI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Z+Qo1Dm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="08eoz1gI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Z+Qo1Dm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D41C2334
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498435; cv=none; b=rH9S1g6aIw4eqqzgz1YlnMk8OpH1hYIGT1T3Nnsm/rWDGxwmQlvvzx3sRaBRcU4D5gWu1QepRmeI8RPaM4e256l9lbHRF1PKEhBIXEEFOD4rnJ23xd+fp2Vx/xJJ7AOPQENiuNEZCg2MlX85QoKBFfSaKrv3Xa/qgymWjzhZ+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498435; c=relaxed/simple;
	bh=WvqA0odo4vJ7K3VDGIPqkqKMlhtKxFxMNaxBV+LA+nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/0jTINCT3TASA3EjsMAJeSL5LvzYjDOeo6u34Lwc0HKniDK45tRbjhcS4xkMeMS826URCbnz2kK8HTe7L1e5iT/TQwlUk1RAdS19k3j83RcHpuPt5O6uhUCPpWPzlbXDtHT6OhDJRvmOZVJzPNO0d6zWCE8gsqJ5S1G0jyz/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=08eoz1gI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Z+Qo1Dm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=08eoz1gI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Z+Qo1Dm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 541D833906;
	Fri,  3 Oct 2025 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759498412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X26N7+coLhPtysSvgG++2IwZmuSczwN6ZHetWwJ4SnI=;
	b=08eoz1gIYV/e/WHayg0E93/lShV4nRIFDoegdx8F9/IV110aH2yK8RJReunGssKfdUyD2J
	Xq1N39kf20eEU8gY98ncDkhoEmyrJmnf765E9JAJbrhFz3q6g1/L4q70DvlrK3m4CvDXQN
	I4bUWuk2xzIZW2VdbWHq0wqCIwVETeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759498412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X26N7+coLhPtysSvgG++2IwZmuSczwN6ZHetWwJ4SnI=;
	b=0Z+Qo1DmdAH55xhD0wahxbeZsFYq4WqGMcKclzqvaOnpRtz1vfdt4tRv/FI2aMBR8GvS1O
	slpbU0LWcPUXwyBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=08eoz1gI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0Z+Qo1Dm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759498412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X26N7+coLhPtysSvgG++2IwZmuSczwN6ZHetWwJ4SnI=;
	b=08eoz1gIYV/e/WHayg0E93/lShV4nRIFDoegdx8F9/IV110aH2yK8RJReunGssKfdUyD2J
	Xq1N39kf20eEU8gY98ncDkhoEmyrJmnf765E9JAJbrhFz3q6g1/L4q70DvlrK3m4CvDXQN
	I4bUWuk2xzIZW2VdbWHq0wqCIwVETeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759498412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X26N7+coLhPtysSvgG++2IwZmuSczwN6ZHetWwJ4SnI=;
	b=0Z+Qo1DmdAH55xhD0wahxbeZsFYq4WqGMcKclzqvaOnpRtz1vfdt4tRv/FI2aMBR8GvS1O
	slpbU0LWcPUXwyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35F5D13990;
	Fri,  3 Oct 2025 13:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KuvmDKzQ32hFRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Oct 2025 13:33:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 46729A0A58; Fri,  3 Oct 2025 15:33:27 +0200 (CEST)
Date: Fri, 3 Oct 2025 15:33:27 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Deepanshu Kartikey <kartikey406@gmail.com>, 
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] vfs: Don't leak disconnected dentries on umount
Message-ID: <c5cztgzzigretiyl2nilxusa32i2uuepwziltsoipsnxnzoebj@6phxi6h5sxyu>
References: <20251002155506.10755-2-jack@suse.cz>
 <20251002163649.GO39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002163649.GO39973@ZenIV>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[1d79ebe5383fc016cf07];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 541D833906
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Thu 02-10-25 17:36:49, Al Viro wrote:
> On Thu, Oct 02, 2025 at 05:55:07PM +0200, Jan Kara wrote:
> 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 65cc11939654..3ec21f9cedba 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -2557,6 +2557,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
> >  	spin_lock(&parent->d_lock);
> >  	new->d_parent = dget_dlock(parent);
> >  	hlist_add_head(&new->d_sib, &parent->d_children);
> > +	if (parent->d_flags & DCACHE_DISCONNECTED)
> > +		new->d_flags |= DCACHE_DISCONNECTED;
> >  	spin_unlock(&parent->d_lock);
> 
> Not a good place for that |=, IMO...

The second place I was considering was a bit earlier where we set
DCACHE_PAR_LOOKUP in new->d_flags but then I've decided to put this under
parent's d_lock so that parent->d_flags cannot change under us. But in
principle that race is harmless so do you prefer to move this setting out
of parent->d_lock critical section?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

