Return-Path: <linux-fsdevel+bounces-21423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4D9039A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FA72895F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF517B4E1;
	Tue, 11 Jun 2024 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXY8LbtR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJtPTKBW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXY8LbtR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJtPTKBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3C179951;
	Tue, 11 Jun 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103910; cv=none; b=qysNLkFq8iN56GbOOax9x4q2TK3hoZIKSvFMI4qafm3eMCcJRITU3Qgi6Uf8vUVmpA9/ozrdDFcgf4Dtc1HOwsR1cUNs6k34ROgqV+wjy1t1CxHTVl0ItaaCnoCil+N61HHAwELqgaYUvdSCWIPsnASuIW1CHjt5LBaJwrnqalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103910; c=relaxed/simple;
	bh=0maF6TePGQjOsEHBGqnzTgl9lMhx9NHYxp8R0kLCbHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5cPwT9YICEBmeeW7TT27uik3rUF9WIFKLjVsQEUq11ClLdcmbtOM4zFBTquIvyrY4gFcxYfksVuU9cEvXZtv8B2/WTfwVXhakShkqhONEWlHwaq7QOE0ImnV7oJQ8SE4UkefypdD4IvnMXnb7/z7Q8CNFxwcLcJgTvv9UxBgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXY8LbtR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJtPTKBW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXY8LbtR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJtPTKBW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B98C1F8BA;
	Tue, 11 Jun 2024 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718103906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eLAlMWG8GTaDX9TgGBctJjQr0bAGC82J+5dnZ/RiOk=;
	b=zXY8LbtRdqOCxsHsZtmuWjo/7rj51WhVQVVEXZXDjgOz1LXjGxvI26zoEa03IOsJHPH8v4
	aF+AuXtszD0gpKpfBjRsEP9mTkQPj3BPC+alF6YOIZMKbQ/7BrABeixWeGUb7SYzXXtLWD
	IidmeoGcbk4tAcFGn6z6xEAwVcduBto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718103906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eLAlMWG8GTaDX9TgGBctJjQr0bAGC82J+5dnZ/RiOk=;
	b=MJtPTKBWV4pZLj+TdLvHfGomOUkSAy/BEGfa+zpf/lxfY4e+ewHUMzCW6kTKuWkFL04/3Q
	F6+ops359EzwP/BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718103906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eLAlMWG8GTaDX9TgGBctJjQr0bAGC82J+5dnZ/RiOk=;
	b=zXY8LbtRdqOCxsHsZtmuWjo/7rj51WhVQVVEXZXDjgOz1LXjGxvI26zoEa03IOsJHPH8v4
	aF+AuXtszD0gpKpfBjRsEP9mTkQPj3BPC+alF6YOIZMKbQ/7BrABeixWeGUb7SYzXXtLWD
	IidmeoGcbk4tAcFGn6z6xEAwVcduBto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718103906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eLAlMWG8GTaDX9TgGBctJjQr0bAGC82J+5dnZ/RiOk=;
	b=MJtPTKBWV4pZLj+TdLvHfGomOUkSAy/BEGfa+zpf/lxfY4e+ewHUMzCW6kTKuWkFL04/3Q
	F6+ops359EzwP/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FFBC137DF;
	Tue, 11 Jun 2024 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P3fdA2IvaGZmEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Jun 2024 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7AD3A0880; Tue, 11 Jun 2024 13:05:05 +0200 (CEST)
Date: Tue, 11 Jun 2024 13:05:05 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk,
	david@fromorbit.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: partially sanitize i_state zeroing on inode creation
Message-ID: <20240611110505.udtzfwgj3o4vxrxl@quack3>
References: <20240611041540.495840-1-mjguzik@gmail.com>
 <20240611100222.htl43626sklgso5p@quack3>
 <kge4tzrxi2nxz7zg3j2qxgvnf4fcaywtlckgsc7d52eubvzmj4@zwmwknndha5y>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kge4tzrxi2nxz7zg3j2qxgvnf4fcaywtlckgsc7d52eubvzmj4@zwmwknndha5y>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 11-06-24 12:23:59, Mateusz Guzik wrote:
> On Tue, Jun 11, 2024 at 12:02:22PM +0200, Jan Kara wrote:
> > On Tue 11-06-24 06:15:40, Mateusz Guzik wrote:
> > > new_inode used to have the following:
> > > 	spin_lock(&inode_lock);
> > > 	inodes_stat.nr_inodes++;
> > > 	list_add(&inode->i_list, &inode_in_use);
> > > 	list_add(&inode->i_sb_list, &sb->s_inodes);
> > > 	inode->i_ino = ++last_ino;
> > > 	inode->i_state = 0;
> > > 	spin_unlock(&inode_lock);
> > > 
> > > over time things disappeared, got moved around or got replaced (global
> > > inode lock with a per-inode lock), eventually this got reduced to:
> > > 	spin_lock(&inode->i_lock);
> > > 	inode->i_state = 0;
> > > 	spin_unlock(&inode->i_lock);
> > > 
> > > But the lock acquire here does not synchronize against anyone.
> > > 
> > > Additionally iget5_locked performs i_state = 0 assignment without any
> > > locks to begin with and the two combined look confusing at best.
> > > 
> > > It looks like the current state is a leftover which was not cleaned up.
> > > 
> > > Ideally it would be an invariant that i_state == 0 to begin with, but
> > > achieving that would require dealing with all filesystem alloc handlers
> > > one by one.
> > > 
> > > In the meantime drop the misleading locking and move i_state zeroing to
> > > alloc_inode so that others don't need to deal with it by hand.
> > > 
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > 
> > Good point. But the initialization would seem more natural in
> > inode_init_always(), wouldn't it? And that will also address your "FIXME"
> > comment.
> > 
> 
> My point is that by the time the inode is destroyed some of the fields
> like i_state should be set to a well-known value, this one preferably
> plain 0.

Well, i_state is set to a more or less well defined value but it is not
zero. I don't see a performance difference in whether set it to 0 on
freeing or on allocation and on allocation it is actually much easier to
find when reading the code.

> I did not patch inode_init_always because it is exported and xfs uses it
> in 2 spots, only one of which zeroing the thing immediately after.
> Another one is a little more involved, it probably would not be a
> problem as the value is set altered later anyway, but I don't want to
> mess with semantics of the func if it can be easily avoided.

Well, I'd consider that as another good reason to actually clean this up.
Look, inode_init_always() is used in bcachefs and xfs. bcachefs sets
i_state to 0 just before calling inode_init_always(), xfs just after one
call of inode_init_always() and the call in xfs_reinit_inode() is used
only from xfs_iget_recycle() which sets i_state to I_NEW. So I claim that
moving i_state clearing to inode_init_always() will not cause any issue and
is actually desirable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

