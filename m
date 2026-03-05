Return-Path: <linux-fsdevel+bounces-79505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM6TAvOsqWn+CAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:18:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582CB215537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52BC330897B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD63CD8AB;
	Thu,  5 Mar 2026 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BX07VcXQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iTTEwP25";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uqUBFlXp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vyuVI/Go"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB282264AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727273; cv=none; b=ZR88XsLO9S9pxqpbJES72hfuSvsQDnnoyCqJTRcSsSKt+IuIrwvg8tA9Pus/F64wEZpe8nhL5se53KRd//d0t4V32ZY+F8kqk7VZQJbRR+UmuHt3OgGzM/Ulz96Jqs9kOHrbZ11QJx0yFgpyBfFhGP5wR9e7xT1jLOFzW8Zc0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727273; c=relaxed/simple;
	bh=S7Q0zCLhZjFIV0azsMssum+6JtIMRofcD/Dj9VLOgxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=letztu3nMXwRDDMu2jTB4jZl+7htj8XtTBa31sONZb5WvJvAYKd6REt62LgO3jkRSKxgixtJ4R0Uow7VYtSFsHjJ5tCI5Y6tb2sNEh1MI2b9e9fXS05eA2r6MsFZnMGOU2BrRbabu5KPIBiWXi0h4yEQtAgJGxa892wfV1YDsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BX07VcXQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iTTEwP25; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uqUBFlXp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vyuVI/Go; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9C915BD12;
	Thu,  5 Mar 2026 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772727270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvnM65cjCXEooSKUwaNOtAoF/LC/L9IWrl0xNgJk6rE=;
	b=BX07VcXQwIZia0P5p6GHpM0EBtFKfaQ0jZth/SeLcpxbZg4uKczTEFvpbR7NxZNkC6sdA/
	fQyIOS5NjgXOulUYJi4RevwylAgdYI4plQt+g9ffh/YvmIRVBkNgtcqz8++JBFdolvtC3c
	kz6qYGc/1duGHqhQwzujfHFSlMWj2aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772727270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvnM65cjCXEooSKUwaNOtAoF/LC/L9IWrl0xNgJk6rE=;
	b=iTTEwP251IQRkOtNKGf/p9TInPboBn8Peui7YryghXi84naTlDiF5G0VpdyUh3oJhQBEhW
	veDxweUCZmcA5gDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uqUBFlXp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="vyuVI/Go"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772727269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvnM65cjCXEooSKUwaNOtAoF/LC/L9IWrl0xNgJk6rE=;
	b=uqUBFlXpXgHJndfqPcoLTbVduSC85vpkNvKot2CXfFblycPQqQ7hzzUIMTERHcX/4NBJrk
	ZpZbGhcW3GnOkFCua0+/vBj+6ZqbS2iHwCalgQBzU4I0U/goAVU32Aah1n54xNbVJcGjcK
	tzNWOAMZiRK/Y/vPwuF1VXBqu6mRB14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772727269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvnM65cjCXEooSKUwaNOtAoF/LC/L9IWrl0xNgJk6rE=;
	b=vyuVI/Go313y9pxS59lcKV1WYtDbwbPylzegtcr+eJVgX72n9ERc7r/ZLgQVKw6o/Xe9T7
	5Z2aj77Xtq51jSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C52203EA68;
	Thu,  5 Mar 2026 16:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g5wTMOWrqWnLZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 16:14:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D08DA0A8D; Thu,  5 Mar 2026 17:14:29 +0100 (CET)
Date: Thu, 5 Mar 2026 17:14:29 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 16/32] fs: Fold fsync_buffers_list() into
 sync_mapping_buffers()
Message-ID: <ezoc54wmvpxlhlfvl65vmexyla63qo2vfpchbr3yr5tmuguhwc@d4kanjecvky6>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-48-jack@suse.cz>
 <20260304-bildmaterial-deckname-1995a115de52@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-bildmaterial-deckname-1995a115de52@brauner>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 582CB215537
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79505-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kernel.org,kvack.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed 04-03-26 14:38:47, Christian Brauner wrote:
> On Tue, Mar 03, 2026 at 11:34:05AM +0100, Jan Kara wrote:
> > There's only single caller of fsync_buffers_list() so untangle the code
> > a bit by folding fsync_buffers_list() into sync_mapping_buffers(). Also
> > merge the comments and update them to reflect current state of code.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/buffer.c | 180 +++++++++++++++++++++++-----------------------------
> >  1 file changed, 80 insertions(+), 100 deletions(-)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 1c0e7c81a38b..18012afb8289 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -54,7 +54,6 @@
> >  
> >  #include "internal.h"
> >  
> > -static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
> >  static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> >  			  enum rw_hint hint, struct writeback_control *wbc);
> >  
> > @@ -531,22 +530,96 @@ EXPORT_SYMBOL_GPL(inode_has_buffers);
> >   * @mapping: the mapping which wants those buffers written
> >   *
> >   * Starts I/O against the buffers at mapping->i_private_list, and waits upon
> > - * that I/O.
> > + * that I/O. Basically, this is a convenience function for fsync().  @mapping
> > + * is a file or directory which needs those buffers to be written for a
> > + * successful fsync().
> >   *
> > - * Basically, this is a convenience function for fsync().
> > - * @mapping is a file or directory which needs those buffers to be written for
> > - * a successful fsync().
> > + * We have conflicting pressures: we want to make sure that all
> > + * initially dirty buffers get waited on, but that any subsequently
> > + * dirtied buffers don't.  After all, we don't want fsync to last
> > + * forever if somebody is actively writing to the file.
> > + *
> > + * Do this in two main stages: first we copy dirty buffers to a
> > + * temporary inode list, queueing the writes as we go. Then we clean
> > + * up, waiting for those writes to complete. mark_buffer_dirty_inode()
> > + * doesn't touch b_assoc_buffers list if b_assoc_map is not NULL so we
> > + * are sure the buffer stays on our list until IO completes (at which point
> > + * it can be reaped).
> >   */
> >  int sync_mapping_buffers(struct address_space *mapping)
> >  {
> >  	struct address_space *buffer_mapping =
> >  				mapping->host->i_sb->s_bdev->bd_mapping;
> > +	struct buffer_head *bh;
> > +	int err = 0;
> > +	struct blk_plug plug;
> > +	LIST_HEAD(tmp);
> >  
> >  	if (list_empty(&mapping->i_private_list))
> >  		return 0;
> >  
> > -	return fsync_buffers_list(&buffer_mapping->i_private_lock,
> > -					&mapping->i_private_list);
> > +	blk_start_plug(&plug);
> > +
> > +	spin_lock(&buffer_mapping->i_private_lock);
> > +	while (!list_empty(&mapping->i_private_list)) {
> > +		bh = BH_ENTRY(list->next);
> 
> 
> Stray "list" reference? Shouldn't this be
> BH_ENTRY(mapping->i_private_list.next)?

Indeed. It is just a temporary breakage in the series but still. Fixed.
Thanks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

