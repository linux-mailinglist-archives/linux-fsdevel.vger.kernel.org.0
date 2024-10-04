Return-Path: <linux-fsdevel+bounces-30993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A09904D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187621F2272E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383DC212EF6;
	Fri,  4 Oct 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="haK5nDLH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TpTUMYOI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hAZ+aiPi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0/ozA6Iv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AF149DF4;
	Fri,  4 Oct 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049761; cv=none; b=kr1ILWEreIMQp3RdlYzcQahhA4PhdSe2/ZJVlHLYtpFxvbAPCOe3g+GJ3uItUOZgOTbfHdLbSH/Htql2642MdtSqsHgKN6/gMzuHJGGQ69nLtkXPtm1gI/q0pdfYR0k+0xH92Mq/5SGV81aUHOPxBdBKJG7Qg+VE4khk1Luyv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049761; c=relaxed/simple;
	bh=bdKOyQxOMlw5ZwF3KbxBUpE1MpOsXreC4z0dygBDgc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4JUPOpenkcc3+MDJrVgNZEnfOtIuf1kXCAmwOF0rfD0GTdzUNZl0Yf7iQgV/l1uspVgaoo/HcfJaTw1ffSp+YJQPXrfPIyVoMN2RP2SXSnijWtRcBjGUTJK9i+ND7+BO29GmmRrQr9lDxzvAJQobJAPchhSgzuSvu+rvz7PEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=haK5nDLH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TpTUMYOI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hAZ+aiPi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0/ozA6Iv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F11F621A5C;
	Fri,  4 Oct 2024 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728049755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQ0mVd/8DvK/zSrxrLHtczEDUgVUMyy7i2d8GwYO9Vg=;
	b=haK5nDLHJartsaRstvGzKUnXUb2VkBB2SY9TMx+GF8+VAozrrgPcgXbkfAT4KJAuwGiMzZ
	J0zB6+U3K0mvTS8GuDESqQpqAc7djLXG1g2J6j2LSGYMBVxR899hd/PLK+aZFkj6HN5m1r
	ZDNGeNhv0MkHkm3BAN9ucXsD+TxfpE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728049755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQ0mVd/8DvK/zSrxrLHtczEDUgVUMyy7i2d8GwYO9Vg=;
	b=TpTUMYOIL8oVv8RhXN3AGAGwUHJXoW7MVa8TSiFlsdEsrT3+aW8K9jRWJUzSsGtgm+T3P2
	yrrxe2TTqGZl6YCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728049754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQ0mVd/8DvK/zSrxrLHtczEDUgVUMyy7i2d8GwYO9Vg=;
	b=hAZ+aiPiHJTEa/pDSKu/m6doOQKwyL3GrTnSHS0cwC60VVvHJ+pzTzcYxHKd2+K31ECLuv
	78b2bjyO9ZxLKvaULpdfX2ZA30Q+UsyuW4oRvb0phSUV6QMwDEuSH+Ntf3sTA/rDybZ075
	YbHbVSTyYDrsb3ueryRCSHvG+9YBcgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728049754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQ0mVd/8DvK/zSrxrLHtczEDUgVUMyy7i2d8GwYO9Vg=;
	b=0/ozA6IvuL4XM0jzJZfI/f9/Wde6yB2+DywSoz5CyAml9K6jKFsmLdwqoSAMlX+Ew9I7RR
	BAexoGJy31U/EBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E08C213A6E;
	Fri,  4 Oct 2024 13:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ReLMNlry/2bXWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Oct 2024 13:49:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 95C3CA0877; Fri,  4 Oct 2024 15:49:06 +0200 (CEST)
Date: Fri, 4 Oct 2024 15:49:06 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20241004134906.3yrg5y3hritusmel@quack3>
References: <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3>
 <Zv6jV40xKIJYuePA@dread.disaster.area>
 <20241003161731.kwveypqzu4bivesv@quack3>
 <Zv8648YMT10TMXSL@dread.disaster.area>
 <20241004-abgemacht-amortisieren-9d54cca35cab@brauner>
 <Zv_cLNUpBxpLUe1Q@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv_cLNUpBxpLUe1Q@infradead.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,fromorbit.com,suse.cz,vger.kernel.org,linux.dev,linux-foundation.org,linux.microsoft.com,google.com,hallyn.com,chromium.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 04-10-24 05:14:36, Christoph Hellwig wrote:
> On Fri, Oct 04, 2024 at 09:21:19AM +0200, Christian Brauner wrote:
> > > But screwing with LSM instructure looks ....  obnoxiously complex
> > > from the outside...
> > 
> > Imho, please just focus on the immediate feedback and ignore all the
> > extra bells and whistles that we could or should do. I prefer all of
> > that to be done after this series lands.
> 
> For the LSM mess: absolutely.  For fsnotify it seems like Dave has
> a good idea to integrate it, and it removes the somewhat awkward
> need for the reffed flag.  So if that delayed notify idea works out
> I'd prefer to see that in over the flag.

As I wrote in one of the emails in this (now huge) thread, I'm fine with
completely dropping that inode->i_refcount check from the
fsnotify_unmount_inodes(). It made sense when it was called before
evict_inodes() but after 1edc8eb2e931 ("fs: call fsnotify_sb_delete after
evict_inodes") the usefulness of this check is rather doubtful. So we can
drop the awkward flag regardless whether we unify evict_inodes() with
fsnotify_unmount_inodes() or not. I have no strong preference whether the
unification happens as part of this patch set or later on so it's up to
Dave as far as I'm concerned.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

