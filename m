Return-Path: <linux-fsdevel+bounces-30860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3B98EEA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47151C21098
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F516F265;
	Thu,  3 Oct 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dnN+Xzz6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cnFWgQY6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dnN+Xzz6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cnFWgQY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D515573B;
	Thu,  3 Oct 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956650; cv=none; b=M0uRyImmYyVZlAX5bGydbRxGCAMv9wTH6B4Q/MQioPFMAuZb+8CrIH2PqBmCf3Qy7UjTZ6rvUCqY7dwqdiFfRhREllukrjZcfRv3U2Sld6eVGzfqQ5qpbOaf6vG9U4IjWRIPDbFFV0T3UxYRHIlWuhplw70xVBN7lngG8ek5XjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956650; c=relaxed/simple;
	bh=JZVvikQJZ5BFhUB7aOPfTjOX9OwufknPp9hudMSsxrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYZr7fIc7/v2vRQH9+umBW3PaC1R1KPIUZKB9QsdjBQcqrD4H0xc+Osskb2JDng36byRTFEICQboUmkp6TRlplOQp9hzrxuPjF7HnhGTTNEI/mSYi6SI48L/+r8bJZ/9BnNzjoum9UzDv6hSuqxCGas7tl/tZdgcekY203QHEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dnN+Xzz6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cnFWgQY6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dnN+Xzz6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cnFWgQY6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76BC11F7CE;
	Thu,  3 Oct 2024 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727956646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VdL/fRqrsdriBW6pXJN6cZZ3u/9359xzFOhfjWyBnk=;
	b=dnN+Xzz6m1OdqwYQMa2ExYiZg4hHmfo86iGRJcQcnyGraK1U8J/iTw3r7TW0NBErULqZuM
	xOLNbGDVYc7KYkQn4j2VB27jmqO20KoenDre5Veiuc4pUn5N59nApPx8mbYGFZoqkwaaN0
	tXDUmKGmf9SGWyS8i/Pj4pGJGwYTkAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727956646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VdL/fRqrsdriBW6pXJN6cZZ3u/9359xzFOhfjWyBnk=;
	b=cnFWgQY64NPIDGd4Q2ZeT4qYjuUN8ZdPWKgyg7NjZ96Ot/JlKG0WALKVR4gOylfOsNBSlc
	Lg/XsKGO5jlEtGAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dnN+Xzz6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cnFWgQY6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727956646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VdL/fRqrsdriBW6pXJN6cZZ3u/9359xzFOhfjWyBnk=;
	b=dnN+Xzz6m1OdqwYQMa2ExYiZg4hHmfo86iGRJcQcnyGraK1U8J/iTw3r7TW0NBErULqZuM
	xOLNbGDVYc7KYkQn4j2VB27jmqO20KoenDre5Veiuc4pUn5N59nApPx8mbYGFZoqkwaaN0
	tXDUmKGmf9SGWyS8i/Pj4pGJGwYTkAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727956646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VdL/fRqrsdriBW6pXJN6cZZ3u/9359xzFOhfjWyBnk=;
	b=cnFWgQY64NPIDGd4Q2ZeT4qYjuUN8ZdPWKgyg7NjZ96Ot/JlKG0WALKVR4gOylfOsNBSlc
	Lg/XsKGO5jlEtGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67F4913882;
	Thu,  3 Oct 2024 11:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zcZZGaaG/mYHHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 11:57:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1C47A086F; Thu,  3 Oct 2024 13:57:21 +0200 (CEST)
Date: Thu, 3 Oct 2024 13:57:21 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev, torvalds@linux-foundation.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241003115721.kg2caqgj2xxinnth@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv5J3VTGqdjUAu1J@infradead.org>
X-Rspamd-Queue-Id: 76BC11F7CE
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fromorbit.com,vger.kernel.org,linux.dev,linux-foundation.org,linux.microsoft.com,google.com,hallyn.com,chromium.org,suse.cz,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 03-10-24 00:38:05, Christoph Hellwig wrote:
> On Thu, Oct 03, 2024 at 12:23:41AM -0700, Christoph Hellwig wrote:
> > On Wed, Oct 02, 2024 at 11:33:21AM +1000, Dave Chinner wrote:
> > > --- a/security/landlock/fs.c
> > > +++ b/security/landlock/fs.c
> > > @@ -1223,109 +1223,60 @@ static void hook_inode_free_security_rcu(void *inode_security)
> > >  
> > >  /*
> > >   * Release the inodes used in a security policy.
> > > - *
> > > - * Cf. fsnotify_unmount_inodes() and invalidate_inodes()
> > >   */
> > > +static int release_inode_fn(struct inode *inode, void *data)
> > 
> > Looks like this is called from the sb_delete LSM hook, which
> > is only implemented by landlock, and only called from
> > generic_shutdown_super, separated from evict_inodes only by call
> > to fsnotify_sb_delete.  Why did LSM not hook into that and instead
> 
> An the main thing that fsnotify_sb_delete does is yet another inode
> iteration..
> 
> Ay chance you all could get together an figure out how to get down
> to a single sb inode iteration per unmount?

Fair enough. If we go with the iterator variant I've suggested to Dave in
[1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
Landlocks hook_sb_delete() into a single iteration relatively easily. But
I'd wait with that convertion until this series lands.

								Honza

[1] https://lore.kernel.org/all/20241003114555.bl34fkqsja4s5tok@quack3
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

