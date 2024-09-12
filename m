Return-Path: <linux-fsdevel+bounces-29138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1A89764BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 10:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82A71F248DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8A18FDCD;
	Thu, 12 Sep 2024 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/0YPgB7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="baTqS5JT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/0YPgB7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="baTqS5JT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2418BBB6;
	Thu, 12 Sep 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130484; cv=none; b=Jg3Lxl7aNVbAykaaA/Rj7z9yygtQRRqXhpqRS49ZomUugqrAFnMdDFgfjTUcVWpB1Qv8T9ICjEl6AEBxVsxekB7pv/0xtvpDhitb+/kRTgXxXpcI4a7FdbQFDUsYZ1NMdHmlM8IlD1q7x379IOgPtp3xCZyZ1olsnbmNNWRWZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130484; c=relaxed/simple;
	bh=HDmpiqJWxE3CcsqwvGyOKQlQOhV31jiuq5kClwjH4TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdFnt2jyWzx7UVt4XQMSkEpRx5E2pypU+77qw0lEBMoo0ycf2Oa/7fGbf4rW1ZW1oAaHkv0NJ2AwNe8xuKDhZ9VIirOnBcA/shHVna++p2jmpJtPuY34PuITkBKnamn956RrzZPUGmiVeO+ZgtxbkWrhQ3SNVANrDsuFTm7tUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/0YPgB7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=baTqS5JT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/0YPgB7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=baTqS5JT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BB63219F5;
	Thu, 12 Sep 2024 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726130480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0icze6xvbNh67MVPsltGU+LAEvG9jRydlUqHqZcrmI=;
	b=c/0YPgB7pCDL+RnBE9Fn21VedWdTyAPMarIFsnwZHql+n7J6jNuzEQpC2FGAi7NVPLKPny
	LhJpfiWcYT4mdrdF3piLQ5/imv0RMWd/SuUbsyJe+b+ZkxF6Ro2uU/7QfoiMsKzAeIax4d
	ey6ka8g7VVL0Lpo+rd2qch55LSUPrm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726130480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0icze6xvbNh67MVPsltGU+LAEvG9jRydlUqHqZcrmI=;
	b=baTqS5JTo2MgEC4dFhVa6QmOitZr7sPXftOKdLEmmS6tRcUIfmB9tR7+qz0w03CceSB9Hb
	IrR5VzL9IMdwbxCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="c/0YPgB7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=baTqS5JT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726130480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0icze6xvbNh67MVPsltGU+LAEvG9jRydlUqHqZcrmI=;
	b=c/0YPgB7pCDL+RnBE9Fn21VedWdTyAPMarIFsnwZHql+n7J6jNuzEQpC2FGAi7NVPLKPny
	LhJpfiWcYT4mdrdF3piLQ5/imv0RMWd/SuUbsyJe+b+ZkxF6Ro2uU/7QfoiMsKzAeIax4d
	ey6ka8g7VVL0Lpo+rd2qch55LSUPrm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726130480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0icze6xvbNh67MVPsltGU+LAEvG9jRydlUqHqZcrmI=;
	b=baTqS5JTo2MgEC4dFhVa6QmOitZr7sPXftOKdLEmmS6tRcUIfmB9tR7+qz0w03CceSB9Hb
	IrR5VzL9IMdwbxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E7B513AD8;
	Thu, 12 Sep 2024 08:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V/4NFzCp4mZZEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Sep 2024 08:41:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 079C3A08B3; Thu, 12 Sep 2024 10:41:20 +0200 (CEST)
Date: Thu, 12 Sep 2024 10:41:19 +0200
From: Jan Kara <jack@suse.cz>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
Message-ID: <20240912084119.j3oqfikuavymctlm@quack3>
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
 <20240903022902.GP9627@mit.edu>
 <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
 <20240903120840.GD424729@mit.edu>
 <CAGWkznFu1GTB41Vx1_Ews=rNw-Pm-=ACxg=GjVdw46nrpVdO3g@mail.gmail.com>
 <20240904024445.GR9627@mit.edu>
 <CAGWkznFGDJsyMUhn5Y8DPmhba9h4GNkX_CaqEMev4z23xa-s6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznFGDJsyMUhn5Y8DPmhba9h4GNkX_CaqEMev4z23xa-s6g@mail.gmail.com>
X-Rspamd-Queue-Id: 6BB63219F5
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 14:56:29, Zhaoyang Huang wrote:
> On Wed, Sep 4, 2024 at 10:44 AM Theodore Ts'o <tytso@mit.edu> wrote:
> > On Wed, Sep 04, 2024 at 08:49:10AM +0800, Zhaoyang Huang wrote:
> > > >
> > > > After all, using GFP_MOVEABLE memory seems to mean that the buffer
> > > > cache might get thrashed a lot by having a lot of cached disk buffers
> > > > getting ejected from memory to try to make room for some contiguous
> > > > frame buffer memory, which means extra I/O overhead.  So what's the
> > > > upside of using GFP_MOVEABLE for the buffer cache?
> > >
> > > To my understanding, NO. using GFP_MOVEABLE memory doesn't introduce
> > > extra IO as they just be migrated to free pages instead of ejected
> > > directly when they are the target memory area. In terms of reclaiming,
> > > all migrate types of page blocks possess the same position.
> >
> > Where is that being done?  I don't see any evidence of this kind of
> > migration in fs/buffer.c.
> The journaled pages which carry jh->bh are treated as file pages
> during isolation of a range of PFNs in the callstack below[1]. The bh
> will be migrated via each aops's migrate_folio and performs what you
> described below such as copy the content and reattach the bh to a new
> page. In terms of the journal enabled ext4 partition, the inode is a
> blockdev inode which applies buffer_migrate_folio_norefs as its
> migrate_folio[2].
> 
> [1]
> cma_alloc/alloc_contig_range
>     __alloc_contig_migrate_range
>         migrate_pages
>             migrate_folio_move
>                 move_to_new_folio
> 
> mapping->aops->migrate_folio(buffer_migrate_folio_norefs->__buffer_migrate_folio)
> 
> [2]
> static int __buffer_migrate_folio(struct address_space *mapping,
>                 struct folio *dst, struct folio *src, enum migrate_mode mode,
>                 bool check_refs)
> {
> ...
>         if (check_refs) {
>                 bool busy;
>                 bool invalidated = false;
> 
> recheck_buffers:
>                 busy = false;
>                 spin_lock(&mapping->i_private_lock);
>                 bh = head;
>                 do {
>                         if (atomic_read(&bh->b_count)) {
>           //My case failed here as bh is referred by a journal head.
>                                 busy = true;
>                                 break;
>                         }
>                         bh = bh->b_this_page;
>                 } while (bh != head);

Correct. Currently pages with journal heads attached cannot be migrated
mostly out of pure caution that the generic code isn't sure what's
happening with them. As I wrote in [1] we could make pages with jhs on
checkpoint list only migratable as for them the buffer lock is enough to
stop anybody from touching the bh data. Bhs which are part of a running /
committing transaction are not realistically migratable but then these
states are more shortlived so it shouldn't be a big problem.

> > > > Just curious, because in general I'm blessed by not having to use CMA
> > > > in the first place (not having I/O devices too primitive so they can't
> > > > do scatter-gather :-).  So I don't tend to use CMA, and obviously I'm
> > > > missing some of the design considerations behind CMA.  I thought in
> > > > general CMA tends to used in early boot to allocate things like frame
> > > > buffers, and after that CMA doesn't tend to get used at all?  That's
> > > > clearly not the case for you, apparently?
> > >
> > > Yes. CMA is designed for contiguous physical memory and has been used
> > > via cma_alloc during the whole lifetime especially on the system
> > > without SMMU, such as DRM driver. In terms of MIGRATE_MOVABLE page
> > > blocks, they also could have compaction path retry for many times
> > > which is common during high-order alloc_pages.
> >
> > But then what's the point of using CMA-eligible memory for the buffer
> > cache, as opposed to just always using !__GFP_MOVEABLE for all buffer
> > cache allocations?  After all, that's what is being proposed for
> > ext4's ext4_getblk().  What's the downside of avoiding the use of
> > CMA-eligible memory for ext4's buffer cache?  Why not do this for
> > *all* buffers in the buffer cache?
> Since migration which arised from alloc_pages or cma_alloc always
> happens, we need appropriate users over MOVABLE pages. AFAIU, buffer
> cache pages under regular files are the best candidate for migration
> as we just need to modify page cache and PTE. Actually, all FSs apply
> GFP_MOVABLE on their regular files via the below functions.
> 
> new_inode
>     alloc_inode
>         inode_init_always(struct super_block *sb, struct inode *inode)
>         {
>          ...
>             mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);

Here you speak about data page cache pages. Indeed they can be allocated
from CMA area. But when Ted speaks about "buffer cache" he specifically
means page cache of the block device inode and there I can see:

struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
{
...
        mapping_set_gfp_mask(&inode->i_data, GFP_USER);
...
}

so at this point I'm confused how come you can see block device pages in
CMA area. Are you using data=journal mode of ext4 in your setup by any
chance? That would explain it but then that is a horrible idea as well...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

