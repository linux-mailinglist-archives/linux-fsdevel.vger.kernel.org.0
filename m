Return-Path: <linux-fsdevel+bounces-14410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6121387C1B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45AD1F21F60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D6D7441F;
	Thu, 14 Mar 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tyHOQG6q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yYUIpdRA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tyHOQG6q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yYUIpdRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668921EB34;
	Thu, 14 Mar 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435502; cv=none; b=e/vM0aLnZ2jAJXw4DnV6z+ZV9yEhbRpOM8UF5HKuhCj1Byudw+JgCJr8tl+Mu+TPt6atwQJeuq6vY/a2+bbnjJhpxZcsty364sh2GEi8QbGnLCyd8Zv9ylui1WaNrltU8+Da+J0oaurGgHa3Pki4wKm83Q1E0URZoIFoXk9MAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435502; c=relaxed/simple;
	bh=QtsX1qLFto0OGSgzHpAdOZ4SpwjCIM7vRMltOostqec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaYZJDrwAPgGZ+ZR/XPXAFEGZCtHvvGhbdfZQRqjeZc4VlKZvQfFV+GiiJ62hcQrhDb+Fy17ck/NSowctJNUDmCL6IqHugS9W/WjxsWyrU/oOAtsj4dkizgS7WYacECkA+pirUZrRUo7zeBCJUkR5Y4tRCXfxbC9nqqlBUxejdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tyHOQG6q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yYUIpdRA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tyHOQG6q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yYUIpdRA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8948E1F889;
	Thu, 14 Mar 2024 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710435498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OLCo7nYaa23ahcpGtoOTcFvKhCyIaoXgRgn5Ti+zZk=;
	b=tyHOQG6qSajUmzGXrc6Z2EBRJFUr3p5e0idaGvLvAueFmq7um4XgkGb56B0PwVQdnB9HV+
	hQt38lQaiQmmLC2bPORwDbRWc59ffAvyggOvMPQ9/YOiongEu+u19aKwlZimHfkg7zE+Cw
	g5JJwR7WkepIrUdIiBqPYsps0HniW9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710435498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OLCo7nYaa23ahcpGtoOTcFvKhCyIaoXgRgn5Ti+zZk=;
	b=yYUIpdRAtubWv+k/34umkd+RJCsBMpx4DXzIfYR/Hgb17LG9vZbW8M4Pis2uW3tmfLrGdH
	IQLdsI0XwTCsomCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710435498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OLCo7nYaa23ahcpGtoOTcFvKhCyIaoXgRgn5Ti+zZk=;
	b=tyHOQG6qSajUmzGXrc6Z2EBRJFUr3p5e0idaGvLvAueFmq7um4XgkGb56B0PwVQdnB9HV+
	hQt38lQaiQmmLC2bPORwDbRWc59ffAvyggOvMPQ9/YOiongEu+u19aKwlZimHfkg7zE+Cw
	g5JJwR7WkepIrUdIiBqPYsps0HniW9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710435498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OLCo7nYaa23ahcpGtoOTcFvKhCyIaoXgRgn5Ti+zZk=;
	b=yYUIpdRAtubWv+k/34umkd+RJCsBMpx4DXzIfYR/Hgb17LG9vZbW8M4Pis2uW3tmfLrGdH
	IQLdsI0XwTCsomCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BB651368C;
	Thu, 14 Mar 2024 16:58:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GiksHqos82WsRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 16:58:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2510BA07D9; Thu, 14 Mar 2024 17:58:14 +0100 (CET)
Date: Thu, 14 Mar 2024 17:58:14 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <20240314165814.tne3leyfmb4sqk2t@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
 <ZfEQQ9jZZVes0WCZ@infradead.org>
 <20240314-anfassen-teilnahm-20890c4a22c3@brauner>
 <20240314-entbehren-folglich-8c8fef0cd49b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-entbehren-folglich-8c8fef0cd49b@brauner>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 14-03-24 15:47:52, Christian Brauner wrote:
> On Thu, Mar 14, 2024 at 12:10:59PM +0100, Christian Brauner wrote:
> > On Tue, Mar 12, 2024 at 07:32:35PM -0700, Christoph Hellwig wrote:
> > > Now that this is in mainline it seems to cause blktests to crash
> > > nbd/003 with a rather non-obvious oops for me:
> > 
> > Ok, will be looking into that next.
> 
> Ok, I know what's going on. Basically, fput() on the block device runs
> asynchronously which means that bdev->bd_holder can still be set to @sb
> after it has already been freed. Let me illustrate what I mean:
> 
> P1                                                 P2
> mount(sb)                                          fd = open("/dev/nbd", ...)
> -> file = bdev_file_open_by_dev(..., sb, ...)
>    bdev->bd_holder = sb;
> 
> // Later on:
> 
> umount(sb)
> ->kill_block_super(sb)
> |----> [fput() -> deferred via task work]
> -> put_super(sb) -> frees the sb via rcu
> |
> |                                                 nbd_ioctl(NBD_CLEAR_SOCK)
> |                                                 -> disk_force_media_change()
> |                                                    -> bdev_mark_dead()
> |                                                       -> fs_mark_dead()
> |                                                          // Finds bdev->bd_holder == sb
> |-> file->release::bdev_release()                          // Tries to get reference to it but it's freed; frees it again
>    bdev->bd_holder = NULL;
> 
> Two solutions that come to my mind:
> 
> [1] Indicate to fput() that this is an internal block devices open and
>     thus just close it synchronously. This is fine. First, because the block
>     device superblock is never unmounted or anything so there's no risk
>     from hanging there for any reason. Second, bdev_release() also ran
>     synchronously so any issue that we'd see from calling
>     file->f_op->release::bdev_release() we would have seen from
>     bdev_release() itself. See [1.1] for a patch.
> 
> (2) Take a temporary reference to the holder when opening the block
>     device. This is also fine afaict because we differentiate between
>     passive and active references on superblocks and what we already do
>     in fs_bdev_mark_dead() and friends. This mean we don't have to mess
>     around with fput(). See [1.2] for a patch.
> 
> (3) Revert and cry. No patch.
> 
> Personally, I think (2) is more desirable because we don't lose the
> async property of fput() and we don't need to have a new FMODE_* flag.
> I'd like to do some more testing with this. Thoughts?

Yeah, 2) looks like the least painful solution to me as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

