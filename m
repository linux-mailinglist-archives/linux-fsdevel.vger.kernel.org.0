Return-Path: <linux-fsdevel+bounces-16613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA789FEB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ED81F22463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5717F38E;
	Wed, 10 Apr 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wo/su6ux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pwQ8usD0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wo/su6ux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pwQ8usD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED11779B4;
	Wed, 10 Apr 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770571; cv=none; b=ufmzr/kxYKt4NTP9Vv/eyTUSMaAz2nDiGNT+ZRYVTmMm1G/mQsE14HMOrFdWgvhHIM5FJDKArOnrFEXbSj0bgtL4EKpga4XvUrbH1K7UQLRwes1vtQswpNIqRC9ztZKUYjB7XbjU8znidFZTGR/kkgr3JHiRrWt6kt9tmREXylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770571; c=relaxed/simple;
	bh=s7AlPHnjW1gFs3weqR//JnIAW3hG+/Mp+aTuvYmxgTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2+x3X32CoKrZ801XtkYFNGmkdaDWfFjB3IA9loQOFj+haLX+43yX/Qrqx0UVHKz2mKYkJhVdUEuz67bSAPtr4mMpb+FH5h03XTzcdKa4Z0aPLJ98l6kBSsGYiWHwwnMnpqbGgQrgr1WO8tVj0ye7KrJMr1S9CA6R6ITlRItAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wo/su6ux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pwQ8usD0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wo/su6ux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pwQ8usD0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3395033A89;
	Wed, 10 Apr 2024 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712770567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZHHE5aOwQ1Ezn/ab1buAuDtcCLPcpIIchKLIUxoBbM=;
	b=Wo/su6uxAz3KDCet7sG1IMbLmZNu/s492NxBN+stUG6oo2qYtuABn+4iFfLZA7KwEty81H
	IdrOqxowTjwdMcGmvVJuVhd3KhUwlHGwlvUKUWet7620GxVeKx3CiehY9/HodlAMarXBGu
	QKA3ILsUtN07gfz8aoS5W8ffx3zw7mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712770567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZHHE5aOwQ1Ezn/ab1buAuDtcCLPcpIIchKLIUxoBbM=;
	b=pwQ8usD0NAyGD6U1k6UXV+bVfsviAAMcwHC0rXMTXFxYTDSQht5I5OMD0LYFtofyWnG5ZB
	JIolcEC5hlnuCvCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712770567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZHHE5aOwQ1Ezn/ab1buAuDtcCLPcpIIchKLIUxoBbM=;
	b=Wo/su6uxAz3KDCet7sG1IMbLmZNu/s492NxBN+stUG6oo2qYtuABn+4iFfLZA7KwEty81H
	IdrOqxowTjwdMcGmvVJuVhd3KhUwlHGwlvUKUWet7620GxVeKx3CiehY9/HodlAMarXBGu
	QKA3ILsUtN07gfz8aoS5W8ffx3zw7mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712770567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZHHE5aOwQ1Ezn/ab1buAuDtcCLPcpIIchKLIUxoBbM=;
	b=pwQ8usD0NAyGD6U1k6UXV+bVfsviAAMcwHC0rXMTXFxYTDSQht5I5OMD0LYFtofyWnG5ZB
	JIolcEC5hlnuCvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFAAD13691;
	Wed, 10 Apr 2024 17:36:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 20hgOgbOFmZrWQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Apr 2024 17:36:06 +0000
Date: Wed, 10 Apr 2024 19:28:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>,
	axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.com, konishi.ryusuke@gmail.com,
	akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-nilfs@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v3 for-6.8/block 09/17] btrfs: use bdev apis
Message-ID: <20240410172837.GO3492@suse.cz>
Reply-To: dsterba@suse.cz
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-10-yukuai1@huaweicloud.com>
 <ZYcZi5YYvt5QHrG9@casper.infradead.org>
 <20240104114958.f3cit5q7syp3tn3a@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104114958.f3cit5q7syp3tn3a@quack3>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.50
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[49];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtpaten8pmzgjg419jubxqoa7)];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,huaweicloud.com,kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Thu, Jan 04, 2024 at 12:49:58PM +0100, Jan Kara wrote:
> On Sat 23-12-23 17:31:55, Matthew Wilcox wrote:
> > On Thu, Dec 21, 2023 at 04:57:04PM +0800, Yu Kuai wrote:
> > > @@ -3674,16 +3670,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> > >  		 * Drop the page of the primary superblock, so later read will
> > >  		 * always read from the device.
> > >  		 */
> > > -		invalidate_inode_pages2_range(mapping,
> > > -				bytenr >> PAGE_SHIFT,
> > > +		invalidate_bdev_range(bdev, bytenr >> PAGE_SHIFT,
> > >  				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
> > >  	}
> > >  
> > > -	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> > > -	if (IS_ERR(page))
> > > -		return ERR_CAST(page);
> > > +	nofs_flag = memalloc_nofs_save();
> > > +	folio = bdev_read_folio(bdev, bytenr);
> > > +	memalloc_nofs_restore(nofs_flag);
> > 
> > This is the wrong way to use memalloc_nofs_save/restore.  They should be
> > used at the point that the filesystem takes/releases whatever lock is
> > also used during reclaim.  I don't know btrfs well enough to suggest
> > what lock is missing these annotations.
> 
> In principle I agree with you but in this particular case I agree the ask
> is just too big. I suspect it is one of btrfs btree locks or maybe
> chunk_mutex but I doubt even btrfs developers know and maybe it is just a
> cargo cult. And it is not like this would be the first occurence of this
> anti-pattern in btrfs - see e.g. device_list_add(), add_missing_dev(),
> btrfs_destroy_delalloc_inodes() (here the wrapping around
> invalidate_inode_pages2() looks really weird), and many others...

The pattern is intentional and a temporary solution before we could
implement the scoped NOFS. Functions calling allocations get converted
from GFP_NOFS to GFP_KERNEL but in case they're called from a context
that either holds big locks or can recursively enter the filesystem then
it's protected by the memalloc calls. This should not be surprising.
What may not be obvious is which locks or kmalloc calling functions it
could be, this depends on the analysis of the function call chain and
usually there's enough evidence why it's needed.

