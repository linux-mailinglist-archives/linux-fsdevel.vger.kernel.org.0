Return-Path: <linux-fsdevel+bounces-30901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870B98F41C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 18:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED4BB21E82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3D1A7060;
	Thu,  3 Oct 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ceaws/fq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PfWjCOhE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ceaws/fq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PfWjCOhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A519D077;
	Thu,  3 Oct 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972258; cv=none; b=WpdyoZqacEuSLCvyd4fo0gGWxW8iLzobMasOCoqGkDMK6F1IbySK0zD1Eb4dqVOY/gDoUaiDGx5zROEFEavQOsS6wGiT4ty3pmjJn/Qg2n5NYS4eDZS7f+eayAb/+FaCIdsror1dJxzW2/opklM/KWM2ULJ+VO3nbP1LmXcqQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972258; c=relaxed/simple;
	bh=2c8c8dyaaznI0fOEDaxMu6U2YcdGwR4Lgr+JksfC2cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU7r9EhN8KJOtfm4QgbG8ZoZGl44vtyoxPLQYdG6lnCZH3KB5rlD+Sy85xchKzbELSfA2UqgIo6fomnJaAPL6CP97GZpEXv1k8gUKcfFW7FUS6l/mZzYyYTzMhZ2Iaw5o27X2KifhQmNZ5mDtTa58jQYadhgnwMp3wOT7WWAB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ceaws/fq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PfWjCOhE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ceaws/fq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PfWjCOhE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EE501FE04;
	Thu,  3 Oct 2024 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727972252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1SkCvgbyLtxw38crET3p5i3VwsvsmrMyJ5rZxKdl8Zg=;
	b=Ceaws/fq+jiDpwm4FLn6tTlN0PXv2FUN27+FBweb7SKeaqSMMFlSwraRoKCDYCqFdU0pkC
	RAYdHI27lqMemSvAjYgN0amiLlf/OuHo+M4NsogLDIK/rkVLFHVZmzxiSpR+xDJ8h62BdY
	dReuz9PlbL/8y6KW0azdgNv2P+uREYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727972252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1SkCvgbyLtxw38crET3p5i3VwsvsmrMyJ5rZxKdl8Zg=;
	b=PfWjCOhERqJD0aQm+oUPI2PhCck2lsA4gf+J4EpiYNtEKMIqr8hLLp5yD8iEiLAzvtAJC1
	JcJ7d02hlmxJ7qBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727972252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1SkCvgbyLtxw38crET3p5i3VwsvsmrMyJ5rZxKdl8Zg=;
	b=Ceaws/fq+jiDpwm4FLn6tTlN0PXv2FUN27+FBweb7SKeaqSMMFlSwraRoKCDYCqFdU0pkC
	RAYdHI27lqMemSvAjYgN0amiLlf/OuHo+M4NsogLDIK/rkVLFHVZmzxiSpR+xDJ8h62BdY
	dReuz9PlbL/8y6KW0azdgNv2P+uREYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727972252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1SkCvgbyLtxw38crET3p5i3VwsvsmrMyJ5rZxKdl8Zg=;
	b=PfWjCOhERqJD0aQm+oUPI2PhCck2lsA4gf+J4EpiYNtEKMIqr8hLLp5yD8iEiLAzvtAJC1
	JcJ7d02hlmxJ7qBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 420C313882;
	Thu,  3 Oct 2024 16:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 80kbEJzD/mZcbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 16:17:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD33AA086F; Thu,  3 Oct 2024 18:17:31 +0200 (CEST)
Date: Thu, 3 Oct 2024 18:17:31 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241003161731.kwveypqzu4bivesv@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3>
 <Zv6jV40xKIJYuePA@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6jV40xKIJYuePA@dread.disaster.area>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,infradead.org,vger.kernel.org,linux.dev,linux-foundation.org,linux.microsoft.com,google.com,hallyn.com,chromium.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 03-10-24 23:59:51, Dave Chinner wrote:
> On Thu, Oct 03, 2024 at 02:56:50PM +0200, Jan Kara wrote:
> > On Thu 03-10-24 05:39:23, Christoph Hellwig wrote:
> > > @@ -789,11 +789,23 @@ static bool dispose_list(struct list_head *head)
> > >   */
> > >  static int evict_inode_fn(struct inode *inode, void *data)
> > >  {
> > > +	struct super_block *sb = inode->i_sb;
> > >  	struct list_head *dispose = data;
> > > +	bool post_unmount = !(sb->s_flags & SB_ACTIVE);
> > >  
> > >  	spin_lock(&inode->i_lock);
> > > -	if (atomic_read(&inode->i_count) ||
> > > -	    (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))) {
> > > +	if (atomic_read(&inode->i_count)) {
> > > +		spin_unlock(&inode->i_lock);
> > > +
> > > +		/* for each watch, send FS_UNMOUNT and then remove it */
> > > +		if (post_unmount && fsnotify_sb_info(sb)) {
> > > +			fsnotify_inode(inode, FS_UNMOUNT);
> > > +			fsnotify_inode_delete(inode);
> > > +		}
> > 
> > This will not work because you are in unsafe iterator holding
> > sb->s_inode_list_lock. To be able to call into fsnotify, you need to do the
> > iget / iput dance and releasing of s_inode_list_lock which does not work
> > when a filesystem has its own inodes iterator AFAICT... That's why I've
> > called it a layering violation.
> 
> The whole point of the iget/iput dance is to stabilise the
> s_inodes list iteration whilst it is unlocked - the actual fsnotify
> calls don't need an inode reference to work correctly.
> 
> IOWs, we don't need to run the fsnotify stuff right here - we can
> defer that like we do with the dispose list for all the inodes we
> mark as I_FREEING here.
> 
> So if we pass a structure:
> 
> struct evict_inode_args {
> 	struct list_head	dispose;
> 	struct list_head	fsnotify;
> };
> 
> If we use __iget() instead of requiring an inode state flag to keep
> the inode off the LRU for the fsnotify cleanup, then the code
> fragment above becomes:
> 
> 	if (atomic_read(&inode->i_count)) {
> 		if (post_unmount && fsnotify_sb_info(sb)) {
> 			__iget(inode);
> 			inode_lru_list_del(inode);
> 			spin_unlock(&inode->i_lock);
> 			list_add(&inode->i_lru, &args->fsnotify);
> 		}

Nit: Need to release i_lock in else branch here.  Otherwise interesting
idea. Yes, something like this could work even in unsafe iterator.

> 		return INO_ITER_DONE;
> 	}
> And then once we return to evict_inodes(), we do this:
> 
> 	while (!list_empty(args->fsnotify)) {
> 		struct inode *inode
> 
> 		inode = list_first_entry(head, struct inode, i_lru);
>                 list_del_init(&inode->i_lru);
> 
> 		fsnotify_inode(inode, FS_UNMOUNT);
> 		fsnotify_inode_delete(inode);
> 		iput(inode);
> 		cond_resched();
> 	}
> 
> And so now all the fsnotify cleanup is done outside the traversal in
> one large batch from evict_inodes().

Yup.

> As for the landlock code, I think it needs to have it's own internal
> tracking mechanism and not search the sb inode list for inodes that
> it holds references to. LSM cleanup should be run before before we
> get to tearing down the inode cache, not after....

Well, I think LSM cleanup could in principle be handled together with the
fsnotify cleanup but I didn't check the details.


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

