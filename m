Return-Path: <linux-fsdevel+bounces-46461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10075A89C5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8494A1902FDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943229B76C;
	Tue, 15 Apr 2025 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ay7syMJi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHfYBDIb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ay7syMJi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHfYBDIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCE291170
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716189; cv=none; b=XSe3WzWdmQSlw/Xy76l9djj7NQ/54Q46SAkudRK7C3ecG1GQzFJWV1fe23c06MTCItvjGkC4CMp/QZSIhLeVh4UFDx0A+PRh/FtQlnnum6iEJrhw8QR5qcBHfE4V5O6daTmh1OhRZPyq9oLjCWp9RFmjMXjFgZCSC65Y7MGbCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716189; c=relaxed/simple;
	bh=TiSDvcVwTC+A+fVjqW+gcybnaCT2nXdLCSR7AghQxyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBinOsStfsRdb/3ITByyeKvjgO+OB5N7nguQ5vtMg0qzNC5oGaiqVpAi+2wD/OZ8d+5I6DRRLqT51BQI4bNXh9Q8IyhxH3nqpPRxsL80K+y1phtDA7chIs1z1gXam+Azw4hKjxvle3qhhYuK/ro9T2oS7YKNzNTTjVVUoQD2HSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ay7syMJi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHfYBDIb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ay7syMJi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHfYBDIb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3EBF21165;
	Tue, 15 Apr 2025 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744716184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wix4v6LrgRo48XvjMawpOKewYVjZzdakpjsbPdduIU=;
	b=Ay7syMJi3uN8fO0/Rghxxu+CSIDVhV0yAaSo/oZ+H0bGf0mJ4BWWAvFdowoBjrZi3tDSkQ
	1BJA+4/p9GKx10rXcvKtLfT7OTodbQDrdv7+rgowotAKTLr/FC0cHUUGIMCQcM7JYk+Tcu
	mvWib2kLaBXG6vDceJ1/OBu2tUGw3HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744716184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wix4v6LrgRo48XvjMawpOKewYVjZzdakpjsbPdduIU=;
	b=PHfYBDIbKUsp7yzDxVlmKooxEc2OZaueQiPf7f3JZ91eZT4m4ZwjUQmPRd0iCY+ZLzGwMy
	rVtWoVOLDIubZrAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ay7syMJi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PHfYBDIb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744716184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wix4v6LrgRo48XvjMawpOKewYVjZzdakpjsbPdduIU=;
	b=Ay7syMJi3uN8fO0/Rghxxu+CSIDVhV0yAaSo/oZ+H0bGf0mJ4BWWAvFdowoBjrZi3tDSkQ
	1BJA+4/p9GKx10rXcvKtLfT7OTodbQDrdv7+rgowotAKTLr/FC0cHUUGIMCQcM7JYk+Tcu
	mvWib2kLaBXG6vDceJ1/OBu2tUGw3HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744716184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wix4v6LrgRo48XvjMawpOKewYVjZzdakpjsbPdduIU=;
	b=PHfYBDIbKUsp7yzDxVlmKooxEc2OZaueQiPf7f3JZ91eZT4m4ZwjUQmPRd0iCY+ZLzGwMy
	rVtWoVOLDIubZrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6DAB137A5;
	Tue, 15 Apr 2025 11:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hOm7KJhB/meqewAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 11:23:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55608A0947; Tue, 15 Apr 2025 13:23:00 +0200 (CEST)
Date: Tue, 15 Apr 2025 13:23:00 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net, 
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com, 
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <tb55nsh7sscqq7x7qx2o6tc4gusv6uuledhldjmibi7ga5xgyq@d77ebe7r6s5d>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
X-Rspamd-Queue-Id: B3EBF21165
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,mit.edu,dilger.ca,vger.kernel.org,surriel.com,stgolabs.net,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Mon 14-04-25 14:09:44, Luis Chamberlain wrote:
> On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > > @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> > >  			}
> > >  			bh = bh->b_this_page;
> > >  		} while (bh != head);
> > > +		spin_unlock(&mapping->i_private_lock);
> > 
> > No, you've just broken all simple filesystems (like ext2) with this patch.
> > You can reduce the spinlock critical section only after providing
> > alternative way to protect them from migration. So this should probably
> > happen at the end of the series.
> 
> So you're OK with this spin lock move with the other series in place?

Yes.

> And so we punt the hard-to-reproduce corruption issue as future work
> to do?

Yes, I'm not happy about that but I prefer that over putting band aids
into that code. Even more so because we don't even understand whether they
fix the problem or just make this reproducer stop working...

> Becuase the other alternative for now is to just disable
> migration for jbd2:
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1dc09ed5d403..ef1c3ef68877 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3631,7 +3631,6 @@ static const struct address_space_operations ext4_journalled_aops = {
>  	.bmap			= ext4_bmap,
>  	.invalidate_folio	= ext4_journalled_invalidate_folio,
>  	.release_folio		= ext4_release_folio,
> -	.migrate_folio		= buffer_migrate_folio_norefs,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_folio	= generic_error_remove_folio,
>  	.swap_activate		= ext4_iomap_swap_activate,

This will not disable migration for JBD2 buffers. This will just disable
migration for files with data journalling. See my other reply for details.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

