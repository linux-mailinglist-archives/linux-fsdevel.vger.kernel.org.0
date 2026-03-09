Return-Path: <linux-fsdevel+bounces-79799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM2DE8nnrmlRKAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:31:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBF23BB3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9484B31087D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2D3DA7E1;
	Mon,  9 Mar 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qsJlM/9C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="89ekJIgO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qsJlM/9C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="89ekJIgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB423DA7D4
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069724; cv=none; b=T+ryNrIhJMBBaDTsdv3PzB0LPGWj2dJlgaJlDkpsHSKAjgFvq/mA1WOoRlWjQ2tzVEi5V2Yr3CWzsBCNUWjhM8G06Ba6ZEx07kfeKRz8dH9mekAy0z1HgkxmBNo9XyHCHfHIcdR7qWsL+JUbOVZW2dWoXzL3w6p5JkEWXx26RAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069724; c=relaxed/simple;
	bh=tuN+j8dF0CpeB+MjvYmUwXBdHk4cPZvKjZpQzLh7VpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J48tphkOjTOxfdm3CBGbkS3S7ZFk87CNdE0wSr3wpMp7rNag2rqAxZAFymZJ3uEbO+H+qu0dh9hxgawCIpNiFmiO885rmHvA/FWHRkW/VA/OEW+ZiNJ6NMOBL4HkWiTIT+9tLxojLwLL2vGIrNh+99rhv8OICbE9nOsu+iPCw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qsJlM/9C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=89ekJIgO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qsJlM/9C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=89ekJIgO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 231385BE4E;
	Mon,  9 Mar 2026 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773069721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMVl6bHSVC8V1c12hajNbXBD7gYHhzudofJq+BOdJ2c=;
	b=qsJlM/9C6Kuaptons2EwDZ4hEIFsKfGVBCnlDv5Q0R571u1NA7t7AW71S21xnpgTEXjUHw
	6zj4eW1kDv8KpOcXnkZg6Nrc+a7jbTCbPpmx4l+f5/ugD69F+8WQW9itEmXDysjzzZJtWQ
	rsbAAm5LTYXZr4VJ1SYskrnS0pMuPtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773069721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMVl6bHSVC8V1c12hajNbXBD7gYHhzudofJq+BOdJ2c=;
	b=89ekJIgOcjwAIYPBAJVtG+U8/qVh5pHcKUJ7Z2RtxjlLdvwO1Lkt3i5YU89ANiWQsInLDR
	p6dOGl8QvFYstsAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qsJlM/9C";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=89ekJIgO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773069721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMVl6bHSVC8V1c12hajNbXBD7gYHhzudofJq+BOdJ2c=;
	b=qsJlM/9C6Kuaptons2EwDZ4hEIFsKfGVBCnlDv5Q0R571u1NA7t7AW71S21xnpgTEXjUHw
	6zj4eW1kDv8KpOcXnkZg6Nrc+a7jbTCbPpmx4l+f5/ugD69F+8WQW9itEmXDysjzzZJtWQ
	rsbAAm5LTYXZr4VJ1SYskrnS0pMuPtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773069721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMVl6bHSVC8V1c12hajNbXBD7gYHhzudofJq+BOdJ2c=;
	b=89ekJIgOcjwAIYPBAJVtG+U8/qVh5pHcKUJ7Z2RtxjlLdvwO1Lkt3i5YU89ANiWQsInLDR
	p6dOGl8QvFYstsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CBFA3EF79;
	Mon,  9 Mar 2026 15:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5isWA5nlrmmoAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Mar 2026 15:22:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B939AA0AD1; Mon,  9 Mar 2026 16:21:52 +0100 (CET)
Date: Mon, 9 Mar 2026 16:21:52 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove externs from fs.h on functions modified
 by i_ino widening
Message-ID: <ct5jiqh3ka24xsxkf4weyevsnrvkifjks7mvgyjg4wbwejehwu@lpfygutfhn6c>
References: <20260307-iino-u64-v2-1-a1a1696e0653@kernel.org>
 <urwtj2zfmxfhksormxkzb2z26a7nt5vesbkuwtow47fflf4u2l@x7cbae5dv7tr>
 <c73452245cd85a75bbfc12b31b940641352fb979.camel@kernel.org>
 <wlwvnfrhpw4yyzdnxte73nv6rs5lh2jilvnfd2mtocyct4jyel@4l4km3lehq2c>
 <214341c4753f7ce61d9b01155e9c493e880b7bbd.camel@kernel.org>
 <mkgjambnzw35slfb3vens5tlsugxpjg7q7cckrmwj426ot4x4b@acvye7cjmzde>
 <8e68da17ad8c9584d8082441331d91ab2d6cbb81.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e68da17ad8c9584d8082441331d91ab2d6cbb81.camel@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: B6FBF23BB3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-79799-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.941];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 09-03-26 10:56:02, Jeff Layton wrote:
> On Mon, 2026-03-09 at 15:46 +0100, Jan Kara wrote:
> > On Mon 09-03-26 09:27:47, Jeff Layton wrote:
> > > On Mon, 2026-03-09 at 13:27 +0100, Jan Kara wrote:
> > > > On Mon 09-03-26 07:53:51, Jeff Layton wrote:
> > > > > On Mon, 2026-03-09 at 11:02 +0100, Jan Kara wrote:
> > > > > > On Sat 07-03-26 14:54:31, Jeff Layton wrote:
> > > > > > > Christoph says, in response to one of the patches in the i_ino widening
> > > > > > > series, which changes the prototype of several functions in fs.h:
> > > > > > > 
> > > > > > >     "Can you please drop all these pointless externs while you're at it?"
> > > > > > > 
> > > > > > > Remove extern keyword from functions touched by that patch (and a few
> > > > > > > that happened to be nearby). Also add missing argument names to
> > > > > > > declarations that lacked them.
> > > > > > > 
> > > > > > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ...
> > > > > > > -extern void inode_init_once(struct inode *);
> > > > > > > -extern void address_space_init_once(struct address_space *mapping);
> > > > > > > -extern struct inode * igrab(struct inode *);
> > > > > > > -extern ino_t iunique(struct super_block *, ino_t);
> > > > > > > -extern int inode_needs_sync(struct inode *inode);
> > > > > > > -extern int inode_just_drop(struct inode *inode);
> > > > > > > +void inode_init_once(struct inode *inode);
> > > > > > > +void address_space_init_once(struct address_space *mapping);
> > > > > > > +struct inode *igrab(struct inode *inode);
> > > > > > > +ino_t iunique(struct super_block *sb, ino_t max_reserved);
> > > > > > 
> > > > > > I've just noticed that we probably forgot to convert iunique() to use u64
> > > > > > for inode numbers... Although the iunique() number allocator might prefer
> > > > > > to stay within 32 bits, the interfaces should IMO still use u64 for
> > > > > > consistency.
> > > > > > 
> > > > > 
> > > > > I went back and forth on that one, but I left iunique() changes off
> > > > > since they weren't strictly required. Most filesystems that use it
> > > > > won't have more than 2^32 inodes anyway.
> > > > > 
> > > > > If they worked before with iunique() limited to 32-bit values, they
> > > > > should still after this. After the i_ino widening we could certainly
> > > > > change it to return a u64 though.
> > > > 
> > > > Yes, it won't change anything wrt functionality. I just think that if we go
> > > > for "ino_t is the userspace API type and kernel-internal inode numbers
> > > > (i.e.  what gets stored in inode->i_ino) are passed as u64", then this
> > > > place should logically have u64...
> > > > 
> > > 
> > > I think we'll need a real plan for this.
> > 
> > <snip claude analysis>
> >  
> > > It certainly wouldn't hurt to make these functions return a u64 type,
> > > but I worry a little about letting them return values bigger than
> > > UINT_MAX:
> > > 
> > > One of my very first patches was 866b04fccbf1 ("inode numbering: make
> > > static counters in new_inode and iunique be 32 bits"), and it made
> > > get_next_ino() and iunique() always return 32 bit values. 
> > > 
> > > At the time, 32-bit machines and legacy binaries were a lot more
> > > prevalent than they are today and this was real problem. I'm guessing
> > > it's not so much today, so we could probably make them return real 64-
> > > bit values. That might also obviate the need for locking in these
> > > functions too.
> > 
> > Hum, I think I still didn't express myself clearly enough. I *don't* want
> > to change values returned from get_next_ino() or iunique(). I would leave
> > that for the moment when someone comes with a need for more than 4 billions
> > of inodes in a filesystem using these (which I think is still quite a few
> > years away). All I want is that in-kernel inode number is consistently
> > passed as u64 and not as ino_t. So all I ask for is this diff:
> > 
> > - ino_t iunique(struct super_block *sb, ino_t max_reserved)
> > + u64 iunique(struct super_block *sb u64 max_reserved)
> > ...
> >  	static unsigned int counter;
> > -	ino_t res;
> > +	u64 res;
> > 
> > and that's it. I.e., the 'counter' variable that determines max value of
> > returned number stays as unsigned int.
> 
> Sure, that's simple enough, though I wonder whether it's the right
> thing to do:
> 
> Both these functions return a max values of UINT_MAX, so maybe they
> should return u32 instead? If you make them return u64, then this
> limitation isn't evident unless you look at the function itself.

Well, that limitation wasn't evident with ino_t either :). The kernel doc
comment for the function should mention this, that's true. I don't think
the type of the return value is a very explicit way of expressing that
either (I'd say you often don't notice). If you want to make that more
explicit besides the kernel doc comment, then I'd suggest to call the
function iunique32().

> I'm also wondering whether we should just go ahead and revamp them to
> return real 64-bit values. When the collision risk goes away, then we
> don't need the spinlock in iunique(), for instance. We could just make
> that use an atomic64_t (or do something creative with percpu values).

Yes, that would be interesting optimization, I think someone was already
wanting to do something like that, but I agree we need to be careful about
userspace regressions there and probably transition users one by one.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

