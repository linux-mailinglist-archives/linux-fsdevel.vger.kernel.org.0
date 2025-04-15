Return-Path: <linux-fsdevel+bounces-46460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9263EA89BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5903BC631
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D48B2957D0;
	Tue, 15 Apr 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVw1bluX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AwZv7N+J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVw1bluX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AwZv7N+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9432951B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715857; cv=none; b=nhgEZqYY6AAExZqs7sCM7P3XcxH9F9IFRCCA+gxNd9uwBEcykJfBJ/RemmO/N8MkGyC0CRu0gs+UqCa0Qi924Ee24OG/fvbeN5Iy0gXqR2+r8scF0NgZPu/UZLb3NQNlk3Dr1Za30gi9hdcx3i3APzXTHJw1IfY5kGIk6GH1Iq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715857; c=relaxed/simple;
	bh=gKt5vJHXItGejc3TgLF+N+FjzdN0cQp+ncdZceXYcFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy6mYYgpQvdLirpIVmLNC3pRY1VRWGABj9Rpf7WD8iZyV1+H8fxzFs93SSXOkb1ZE40PCpsL+HUZ2/AQet+T5AekBd8V/MRRQRRwjRuopGR3Z1U3khUUE+dn9IMzUp336p6iHG8I29zn6UjDCX3nhwgE5uwKXRgsA9QEemcfYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yVw1bluX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AwZv7N+J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yVw1bluX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AwZv7N+J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2F161F38D;
	Tue, 15 Apr 2025 11:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744715852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GvslLrS6yzAU1HTA1lFcJoSPQOpIR7dPkztEx/wErA=;
	b=yVw1bluXlIPW04+c0uRSmRxLmU/S5ps6gxL/BXeGQIJAsYRYnu8J6t48a7oP3zbR1oDC2U
	ZlR3I9/U6JrA93d6AtmXvjA351LV/N1yEzAFhJ4QCx63+x1JAB8IZBmMlt/O3TGntGIeQy
	WKJIMlJt3oxSZnhDYsWCP3ybsw4r6nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744715852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GvslLrS6yzAU1HTA1lFcJoSPQOpIR7dPkztEx/wErA=;
	b=AwZv7N+JXO9aMqVwoSYYuvg+sjJ8dw9wMYZbwgqFZckyoBFHWXb95x4bubtDhQeRjes/ml
	rFvYsBbphrY5hRDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744715852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GvslLrS6yzAU1HTA1lFcJoSPQOpIR7dPkztEx/wErA=;
	b=yVw1bluXlIPW04+c0uRSmRxLmU/S5ps6gxL/BXeGQIJAsYRYnu8J6t48a7oP3zbR1oDC2U
	ZlR3I9/U6JrA93d6AtmXvjA351LV/N1yEzAFhJ4QCx63+x1JAB8IZBmMlt/O3TGntGIeQy
	WKJIMlJt3oxSZnhDYsWCP3ybsw4r6nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744715852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GvslLrS6yzAU1HTA1lFcJoSPQOpIR7dPkztEx/wErA=;
	b=AwZv7N+JXO9aMqVwoSYYuvg+sjJ8dw9wMYZbwgqFZckyoBFHWXb95x4bubtDhQeRjes/ml
	rFvYsBbphrY5hRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1917137A5;
	Tue, 15 Apr 2025 11:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8R9tJ0xA/mfreQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 11:17:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57650A0947; Tue, 15 Apr 2025 13:17:28 +0200 (CEST)
Date: Tue, 15 Apr 2025 13:17:28 +0200
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
Message-ID: <6qzm6z64hcrhbapzekg2eil5poi34tngghrumwoiaz2x25ogce@gatjy6egc2n3>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
 <Z_2J9bxCqAUPgq42@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_2J9bxCqAUPgq42@bombadil.infradead.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,mit.edu,dilger.ca,vger.kernel.org,surriel.com,stgolabs.net,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com,syzkaller.appspotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 14-04-25 15:19:33, Luis Chamberlain wrote:
> On Mon, Apr 14, 2025 at 02:09:46PM -0700, Luis Chamberlain wrote:
> > On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > > > @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> > > >  			}
> > > >  			bh = bh->b_this_page;
> > > >  		} while (bh != head);
> > > > +		spin_unlock(&mapping->i_private_lock);
> > > 
> > > No, you've just broken all simple filesystems (like ext2) with this patch.
> > > You can reduce the spinlock critical section only after providing
> > > alternative way to protect them from migration. So this should probably
> > > happen at the end of the series.
> > 
> > So you're OK with this spin lock move with the other series in place?
> > 
> > And so we punt the hard-to-reproduce corruption issue as future work
> > to do? Becuase the other alternative for now is to just disable
> > migration for jbd2:
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 1dc09ed5d403..ef1c3ef68877 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3631,7 +3631,6 @@ static const struct address_space_operations ext4_journalled_aops = {
> >  	.bmap			= ext4_bmap,
> >  	.invalidate_folio	= ext4_journalled_invalidate_folio,
> >  	.release_folio		= ext4_release_folio,
> > -	.migrate_folio		= buffer_migrate_folio_norefs,
> >  	.is_partially_uptodate  = block_is_partially_uptodate,
> >  	.error_remove_folio	= generic_error_remove_folio,
> >  	.swap_activate		= ext4_iomap_swap_activate,
> 
> BTW I ask because.. are your expectations that the next v3 series also
> be a target for Linus tree as part of a fix for this spinlock
> replacement?

I have no problem with this (the use of data=journal mode is rare) but I
suspect this won't fix the corruption you're seeing because that happens in
the block device mapping. So to fix that you'd have to disable page
migration for block device mappings (i.e., do the above with def_blk_aops)
and *that* will make a lot of people unhappy.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

