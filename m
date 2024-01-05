Return-Path: <linux-fsdevel+bounces-7449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A58251EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 11:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB451C22E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DB62C695;
	Fri,  5 Jan 2024 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQ2VCqnr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAmRRwDV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQ2VCqnr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAmRRwDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6028DDA;
	Fri,  5 Jan 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1B1121F4F;
	Fri,  5 Jan 2024 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704450417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LUH6RqocM03TWTBwRHDFCUItap2jx/cmsqp/TXrIYzQ=;
	b=OQ2VCqnrrdt13RcjXedA7ZO0msKuuQrIC+Z55rJFbfLY1zONbYYQtozOvnlpQl3gwF5lQd
	iqLDaYjiRxh6XkXF54c9YBHEPJ/uwvRFgHGGpc2LJxuXidagFk6A0Ks8ff2101conmDabl
	f0bux88HSIZhWD/o4q5+psJbsTsXNJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704450417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LUH6RqocM03TWTBwRHDFCUItap2jx/cmsqp/TXrIYzQ=;
	b=PAmRRwDV40Wd9q/NmvGMfCJwi0HXhnF+Z6DJqLbBZLJa8TPWiWnLiHdXKz07YBAOWNT/NA
	uommy2Wi1Fev9TBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704450417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LUH6RqocM03TWTBwRHDFCUItap2jx/cmsqp/TXrIYzQ=;
	b=OQ2VCqnrrdt13RcjXedA7ZO0msKuuQrIC+Z55rJFbfLY1zONbYYQtozOvnlpQl3gwF5lQd
	iqLDaYjiRxh6XkXF54c9YBHEPJ/uwvRFgHGGpc2LJxuXidagFk6A0Ks8ff2101conmDabl
	f0bux88HSIZhWD/o4q5+psJbsTsXNJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704450417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LUH6RqocM03TWTBwRHDFCUItap2jx/cmsqp/TXrIYzQ=;
	b=PAmRRwDV40Wd9q/NmvGMfCJwi0HXhnF+Z6DJqLbBZLJa8TPWiWnLiHdXKz07YBAOWNT/NA
	uommy2Wi1Fev9TBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C61B0137E8;
	Fri,  5 Jan 2024 10:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hb9ZMHHZl2VcXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 05 Jan 2024 10:26:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 70F33A07EF; Fri,  5 Jan 2024 11:26:57 +0100 (CET)
Date: Fri, 5 Jan 2024 11:26:57 +0100
From: Jan Kara <jack@suse.cz>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <20240105102657.fwy7uxudqdoyogd5@quack3>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D1B1121F4F
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OQ2VCqnr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PAmRRwDV
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.com:email,infradead.org:email];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]

On Fri 05-01-24 13:13:11, Viacheslav Dubeyko wrote:
> 
> 
> > On Jan 5, 2024, at 12:17 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > This is primarily a _FILESYSTEM_ track topic.  All the work has already
> > been done on the MM side; the FS people need to do their part.  It could
> > be a joint session, but I'm not sure there's much for the MM people
> > to say.
> > 
> > There are situations where we need to allocate memory, but cannot call
> > into the filesystem to free memory.  Generally this is because we're
> > holding a lock or we've started a transaction, and attempting to write
> > out dirty folios to reclaim memory would result in a deadlock.
> > 
> > The old way to solve this problem is to specify GFP_NOFS when allocating
> > memory.  This conveys little information about what is being protected
> > against, and so it is hard to know when it might be safe to remove.
> > It's also a reflex -- many filesystem authors use GFP_NOFS by default
> > even when they could use GFP_KERNEL because there's no risk of deadlock.
> > 
> > The new way is to use the scoped APIs -- memalloc_nofs_save() and
> > memalloc_nofs_restore().  These should be called when we start a
> > transaction or take a lock that would cause a GFP_KERNEL allocation to
> > deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> > can see the nofs situation is in effect and will not call back into
> > the filesystem.
> > 
> > This results in better code within your filesystem as you don't need to
> > pass around gfp flags as much, and can lead to better performance from
> > the memory allocators as GFP_NOFS will not be used unnecessarily.
> > 
> > The memalloc_nofs APIs were introduced in May 2017, but we still have
> > over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
> > really sad).  This session is for filesystem developers to talk about
> > what they need to do to fix up their own filesystem, or share stories
> > about how they made their filesystem better by adopting the new APIs.
> > 
> 
> Many file systems are still heavily using GFP_NOFS for kmalloc and
> kmem_cache_alloc family methods even if  memalloc_nofs_save() and
> memalloc_nofs_restore() pair is used too. But I can see that GFP_NOFS
> is used in radix_tree_preload(), bio_alloc(), posix_acl_clone(),
> sb_issue_zeroout, sb_issue_discard(), alloc_inode_sb(), blkdev_issue_zeroout(),
> blkdev_issue_secure_erase(), blkdev_zone_mgmt(), etc.

Given the nature of the scoped API, the transition has to start in the
leaves (i.e. filesystems itself) and only once all users of say
radix_tree_preload() are converted to the scoped API, we can remove the
GFP_NOFS use from radix_tree_preload() itself. So Matthew is right that we
need to start in the filesystems.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

