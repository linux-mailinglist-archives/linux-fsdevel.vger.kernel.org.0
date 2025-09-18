Return-Path: <linux-fsdevel+bounces-62091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA3BB83F15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEA2A7B41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC482F25E9;
	Thu, 18 Sep 2025 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3GuC4/0E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6C39Yrta";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3GuC4/0E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6C39Yrta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA112E264C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189559; cv=none; b=uNNT5yYOhjJZJBHfBVK0voejWaenh0GjPN/6COBOkPh8Nv6dnaXSodfh1Fp0q2gvtAR1uCtKq0E8FSGxOucBV6N/oLxKYoG3hh6BpLvJK1IVgv25CaM88XMjZYDfxNaG5VbY/aw2aq43VYLyade1YPsMGL7nUojCfti1qGYlJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189559; c=relaxed/simple;
	bh=0RqsuiwyKINatYSR4jMGpA2kcsw74TNDR71ONXIxGVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agPRdmjZyW8zZR/uQozeBrdfFq77EPEdSggvYHGGIegt09vh5ZhR1EVQnniQ6QrfmrwKsF3OSnxcQvIz1B+nq3qhHPaGzaq/vHbdjWbrQ4ATFCvO5Uk2GDuuo/DlA2Fr46LQPKBM8SsQ1VObo9kwQXMBNnMngTgvgkByN6wrkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3GuC4/0E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6C39Yrta; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3GuC4/0E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6C39Yrta; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A50FF3370E;
	Thu, 18 Sep 2025 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758189555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v86nF+pbQuZ2GvN5imRKeIaZ48Qi34wAMqRkUSzBUxg=;
	b=3GuC4/0ESPjQC3pmzIZ8bUCKHTf/JnNQrCqYYL9kmgf85s872lNOzwXwhKUuxkWBLC2WyB
	s2R6wFu5VsG+nCwu65iLBy8RDidVPcj+vriWINrK6M18sij6Y/TJ2um4t+qOLPBnx4drYq
	bL0D9MtXtRERWp3NFmAKgwD1rwe74LA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758189555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v86nF+pbQuZ2GvN5imRKeIaZ48Qi34wAMqRkUSzBUxg=;
	b=6C39YrtawpyxD3kT6zBqWw3NoYY63UzNAjAlne7/PNQwND2TcTzmnUMngyuaa7EIaYb43S
	t41Z2/gB+1zvY9DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758189555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v86nF+pbQuZ2GvN5imRKeIaZ48Qi34wAMqRkUSzBUxg=;
	b=3GuC4/0ESPjQC3pmzIZ8bUCKHTf/JnNQrCqYYL9kmgf85s872lNOzwXwhKUuxkWBLC2WyB
	s2R6wFu5VsG+nCwu65iLBy8RDidVPcj+vriWINrK6M18sij6Y/TJ2um4t+qOLPBnx4drYq
	bL0D9MtXtRERWp3NFmAKgwD1rwe74LA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758189555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v86nF+pbQuZ2GvN5imRKeIaZ48Qi34wAMqRkUSzBUxg=;
	b=6C39YrtawpyxD3kT6zBqWw3NoYY63UzNAjAlne7/PNQwND2TcTzmnUMngyuaa7EIaYb43S
	t41Z2/gB+1zvY9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 902A913A51;
	Thu, 18 Sep 2025 09:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C//kIvPXy2giZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 09:59:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DA616A09B1; Thu, 18 Sep 2025 11:59:14 +0200 (CEST)
Date: Thu, 18 Sep 2025 11:59:14 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	Jakub Acs <acsjakub@amazon.de>, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
Message-ID: <vtan7uaf5mf35zxy6pma6sdahxr7idv2awaf7yh7vtyhxsoram@2au7ec4hto7i>
References: <20250915101510.7994-1-acsjakub@amazon.de>
 <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
 <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
 <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com>
 <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
 <CAOQ4uxhOMcaVupVVGXV2Srz_pAG+BzDc9Gb4hFdwKUtk45QypQ@mail.gmail.com>
 <scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa>
 <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com>
 <20250917204200.GB39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917204200.GB39973@ZenIV>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,amazon.de,vger.kernel.org,szeredi.hu,kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 17-09-25 21:42:00, Al Viro wrote:
> On Wed, Sep 17, 2025 at 01:07:45PM +0200, Amir Goldstein wrote:
> 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 60046ae23d514..8c9d0d6bb0045 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -1999,10 +1999,12 @@ struct dentry *d_make_root(struct inode *root_inode)
> > 
> >         if (root_inode) {
> >                 res = d_alloc_anon(root_inode->i_sb);
> > -               if (res)
> > +               if (res) {
> > +                       root_inode->i_opflags |= IOP_ROOT;
> >                         d_instantiate(res, root_inode);
> 
> Umm...  Not a good idea - if nothing else, root may end up
> being attached someplace (normal with nfs, for example).
> 
> But more fundamentally, once we are into ->kill_sb(), let alone
> generic_shutdown_super(), nobody should be playing silly buggers
> with the filesystem.  Sure, RCU accesses are possible, but messing
> around with fhandles?  ->s_root is not the only thing that might
> be no longer there.
> 
> What the fuck is fsnotify playing at?

The problem is fsnotify marks aren't shutdown until generic_shutdown_super()
calls fsnotify_sb_delete(). So until that moment fsnotify can be generating
events for the filesystem. Sure, userspace has no longer access to the fs
but stuff like delayed inode deletion or other in-kernel users can still
result in events being generated and these events may end up creating file
handles to report to userspace.

We have already uncovered with Amir quite a few moments how this is broken
so I agree that the best solution is to shutdown fsnotify before we call
shrink_dcache_for_umount(). The slight problem is this means iterating all
inodes in the sb which is costly when you have millions of them (this is
the reason why fsnotify_sb_delete() is currently called after
evict_inodes()). So it needs more work on fsnotify side...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

