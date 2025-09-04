Return-Path: <linux-fsdevel+bounces-60258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7CEB437E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0933C188926D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C982FABFC;
	Thu,  4 Sep 2025 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2RYg/MR+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4GMLhxs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ByCoL6t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6PPhl5uf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A592F6182
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980291; cv=none; b=Dn5TzyxZpKFtKGRGrX3rq3oqZxOFAI6A9My/sxsCN+sdxpueehfllWJlwCd9SH9cGZ9L6Jqf+YpisOWiXxHkwaZ3flNscO7wLgIMLX+ApslE7i3T7gnO5LK+H6AxSG1D3bAiUg60RQjxWS1ELOoVbtOcZADF0FPlhVkkiZ8NRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980291; c=relaxed/simple;
	bh=ahdc3J2puKPyr0NImQJt7HQFyTEYnVU3V4aS1ja1qfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8yqyX02pyTO3JamKrQ+8AvkIY4ZWMlYKPk5AiUteJD54elI/r7cyxJhzXqu05MhyWAEThwKZUUkB8bYZsVilmnk03BuSeb8nEEgxJdgXPNtOQISo5XU/l4ARlS0Q0F5lP+jfpPcpdlq9DVW4DNDRnJZCSE5B0fExEkcAP2I2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2RYg/MR+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4GMLhxs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ByCoL6t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6PPhl5uf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD2095CC72;
	Thu,  4 Sep 2025 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756980287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktdYueKBNyIINKKW4nsszNA5DsjkmAV3KOpm+1dJIVI=;
	b=2RYg/MR+B7TlX01ZjTcRwNS+C7glUoVrQB7+wS5aAZDj1E8tk1yCqftFHSnQ1Elg2kRoY4
	vmv6/9fN2BzGqNzU2cSsdzGCHiPeOY7qCPBiBqIoHfzMtsX3HOQXpxlozqDHe7jRq2fkzt
	jF3oc/Rv3mY4UK79+jRk3Qd7J4DDpok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756980287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktdYueKBNyIINKKW4nsszNA5DsjkmAV3KOpm+1dJIVI=;
	b=R4GMLhxsXP5byIe2Z3NoeAGBVb/I+JFQntVdFHqN8XqQSXZ4BGPXqYVAZ1WjWCF4FKv1PS
	qQqYupOz/cJbx0AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756980286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktdYueKBNyIINKKW4nsszNA5DsjkmAV3KOpm+1dJIVI=;
	b=1ByCoL6tzMuKOayntFRcUyjVYwvLoIGVsqPPqiC4JcXE+BTAfelMBZdEii7Ty08+lYMc8h
	Wcvf8sWVF8GSV7lR9koR4S1u7U/61JyGDUQInFtY8ApzwajC/lzPRUkkreeV1/VsKjK87f
	YPRBRw18IgQIAMHrssWzqfXFL28L/FY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756980286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktdYueKBNyIINKKW4nsszNA5DsjkmAV3KOpm+1dJIVI=;
	b=6PPhl5ufF5101d+JeNH+8URCkKnhGrf7pTUyI+DkelLUgZ6qcISo619avDoSly+/90TVYb
	ms5xB1KKwcvFpxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AED6013AA0;
	Thu,  4 Sep 2025 10:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n/uoKj5kuWhHJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Sep 2025 10:04:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 68F65A0A2D; Thu,  4 Sep 2025 12:04:42 +0200 (CEST)
Date: Thu, 4 Sep 2025 12:04:42 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Mark Tinguely <mark.tinguely@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, ocfs2-devel@lists.linux.dev, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] : Re: [WIP RFC PATCH] fs: retire I_WILL_FREE
Message-ID: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
References: <20250902145428.456510-1-mjguzik@gmail.com>
 <aLe5tIMaTOPEUaWe@casper.infradead.org>
 <d40d8e00-cafb-4b0d-9d5e-f30a05255e5f@oracle.com>
 <CAGudoHE4QqJ-m1puk_vk4mdpMHDiV1gpihE7X8SE=bvbwQyjKg@mail.gmail.com>
 <CAGudoHFKmXJGRPedZ9Fq6jnfbiHzSwezd3Lr0uCbP7izs4dhGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFKmXJGRPedZ9Fq6jnfbiHzSwezd3Lr0uCbP7izs4dhGw@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed 03-09-25 17:19:04, Mateusz Guzik wrote:
> On Wed, Sep 3, 2025 at 5:16 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Wed, Sep 3, 2025 at 4:03 PM Mark Tinguely <mark.tinguely@oracle.com> wrote:
> > >
> > > On 9/2/25 10:44 PM, Matthew Wilcox wrote:
> > > > On Tue, Sep 02, 2025 at 04:54:28PM +0200, Mateusz Guzik wrote:
> > > >> Following up on my response to the refcount patchset, here is a churn
> > > >> patch to retire I_WILL_FREE.
> > > >>
> > > >> The only consumer is the drop inode routine in ocfs2.
> > > >
> > > > If the only consumer is ocfs2 ... then you should cc the ocfs2 people,
> > > > right?
> > > >
> >
> > Fair point, I just copy pasted the list from the patchset, too sloppy.
> >
> > > >> For the life of me I could not figure out if write_inode_now() is legal
> > > >> to call in ->evict_inode later and have no means to test, so I devised a
> > > >> hack: let the fs set I_FREEING ahead of time. Also note iput_final()
> > > >> issues write_inode_now() anyway but only for the !drop case, which is the
> > > >> opposite of what is being returned.
> > > >>
> > > >> One could further hack around it by having ocfs2 return *DON'T* drop but
> > > >> also set I_DONTCACHE, which would result in both issuing the write in
> > > >> iput_final() and dropping. I think the hack I did implement is cleaner.
> > > >> Preferred option is ->evict_inode from ocfs handling the i/o, but per
> > > >> the above I don't know how to do it.
> > >
> > > I am a lurker in this series and ocfs2. My history has been mostly in
> > > XFS/CXFS/DMAPI. I removed the other CC entries because I did not want
> > > to blast my opinion unnecessaially.
> > >
> >
> > Hello Mark,
> >
> > This needs the opinion of the vfs folk though, so I'm adding some of
> > the cc list back. ;)
> >
> > > The flushing in ocfs2_drop_inode() predates the I_DONTCACHE addition.
> > > IMO, it would be safest and best to maintain to let ocfs2_drop_inode()
> > > return 0 and set I_DONTCACHE and let iput_final() do the correct thing.
> > >
> >
> 
> wow, I'm sorry for really bad case of engrish in the mail. some of it
> gets slightly corrected below.
> 
> > For now that would indeed work in the sense of providing the expected
> > behavior, but there is the obvious mismatch of the filesystem claiming
> > the inode should not be dropped (by returning 0) and but using a side
> > indicator to drop it anyway. This looks like a split-brain scenario
> > and sooner or later someone is going to complain about it when they do
> > other work in iput_final(). If I was maintaining the layer I would
> > reject the idea, but if the actual gatekeepers are fine with it...
> >
> > The absolute best thing to do long run is to move the i/o in
> > ->evict_inode, but someone familiar with the APIs here would do the
> > needful(tm) and that's not me.
> 
> I mean the best thing to do in the long run is to move the the write
> to ->evict_inode, but I don't know how to do it and don't have any
> means to test ocfs2 anyway. Hopefully the ocfs2 folk will be willing
> to sort this out?

So doing inode writeback with I_FREEING set is definitely fine and even
necessary in some cases. Now instead of playing games with I_FREEING in
ocfs2_drop_inode() (fs code shouldn't really mess with this flag), I'd move
write_inode_now() call into ocfs2_evict_inode().

Regarding the move of write_inode_now() into ->evict_inode in general I'm
not so sure. It does make some sense and as I mentioned some filesystems
need to writeback inode there anyway (because operations in evict_inode()
could have dirtied the inode) but it adds a boilerplate code into about 45
filesystems...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

