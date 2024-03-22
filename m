Return-Path: <linux-fsdevel+bounces-15078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE285886C9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F078DB21F97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADDE4596E;
	Fri, 22 Mar 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jDvpeu/g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XP3LWBfP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jDvpeu/g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XP3LWBfP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAD44C84;
	Fri, 22 Mar 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113034; cv=none; b=B7jw3+fgGX+50QhKerborjt45ABDvh55yBZacgPRaYnNObKCu9i73Q5K2Qdq3ugKBRKODOa0mwWyFpu7Dh7ZLBCzXUZv06N/MNiOti3kG+rPtw/Fkm8TEhxv7rhMXLBautgCuNt+BsqY8nZ5ABqCDvVrlIrktwBdKYjh0fuha8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113034; c=relaxed/simple;
	bh=PMwSjZ2xGj8wS5SHtETxDpsVMIk1wFKNcXwMEcCSoLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcfiU3jvyA8aiVa1ybz/4IV6GfqGS7Dc7dNmbxIAPK/zzaxo699VXNILR4XAGzy/jhJQphzrFrFF3y2PJ752lt85ZO/cyU6oqKm+kBd3c8yNQh0hazzRQHpwPX1p91yZg8hcwja31hNplFD6jLRYMSYBJhQtQQ+dEdmmtjDh/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jDvpeu/g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XP3LWBfP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jDvpeu/g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XP3LWBfP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C39A720B50;
	Fri, 22 Mar 2024 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711113030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UfWyvZQjI4GX4Qm7y6ahYaanXwjIwpg8fLMJ/Xxvrc=;
	b=jDvpeu/guIu9HAjsbZe0ceLbBcAOJVbalrzwm7STgo0MfggscOMFrsOvhS7wdDQyO0gggj
	rXj5xjGx5+tJd3O3PEiVE7V0AN+Cs4EjKBVJAbxoX67YHaYz9cfafm9A5pFDY+t1UAEYEd
	x2K85zWvq2bWPdrHfLQIL7CU1EBtBjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711113030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UfWyvZQjI4GX4Qm7y6ahYaanXwjIwpg8fLMJ/Xxvrc=;
	b=XP3LWBfPBS7I0HdBpybUN3GTdaxlTE1fuGViHgshDDFMUPcPaYHPm1zWlsVriJIvdkF/ys
	zGoU8jum49x1dsBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711113030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UfWyvZQjI4GX4Qm7y6ahYaanXwjIwpg8fLMJ/Xxvrc=;
	b=jDvpeu/guIu9HAjsbZe0ceLbBcAOJVbalrzwm7STgo0MfggscOMFrsOvhS7wdDQyO0gggj
	rXj5xjGx5+tJd3O3PEiVE7V0AN+Cs4EjKBVJAbxoX67YHaYz9cfafm9A5pFDY+t1UAEYEd
	x2K85zWvq2bWPdrHfLQIL7CU1EBtBjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711113030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UfWyvZQjI4GX4Qm7y6ahYaanXwjIwpg8fLMJ/Xxvrc=;
	b=XP3LWBfPBS7I0HdBpybUN3GTdaxlTE1fuGViHgshDDFMUPcPaYHPm1zWlsVriJIvdkF/ys
	zGoU8jum49x1dsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA4ED136AD;
	Fri, 22 Mar 2024 13:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h1WMKUaD/WWhFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Mar 2024 13:10:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3E29EA0806; Fri, 22 Mar 2024 14:10:30 +0100 (CET)
Date: Fri, 22 Mar 2024 14:10:30 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
	jack@suse.cz, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322131030.pxbvtubien2t27zw@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240322063346.GB3404528@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322063346.GB3404528@ZenIV>
X-Spam-Score: 3.49
X-Spam-Flag: NO
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="jDvpeu/g";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XP3LWBfP
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.35%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: ***
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C39A720B50

On Fri 22-03-24 06:33:46, Al Viro wrote:
> On Tue, Mar 19, 2024 at 04:26:19PM +0800, Yu Kuai wrote:
> 
> > +void put_bdev_file(struct block_device *bdev)
> > +{
> > +       struct file *file = NULL;
> > +       struct inode *bd_inode = bdev_inode(bdev);
> > +
> > +       mutex_lock(&bdev->bd_disk->open_mutex);
> > +       file = bd_inode->i_private;
> > +
> > +       if (!atomic_read(&bdev->bd_openers))
> > +               bd_inode->i_private = NULL;
> > +
> > +       mutex_unlock(&bdev->bd_disk->open_mutex);
> > +
> > +       fput(file);
> > +}
> 
> Locking is completely wrong here.  The only thing that protects
> ->bd_openers is ->open_mutex.  atomic_read() is obviously a red
> herring.
> 
> Suppose another thread has already opened the same sucker
> with bdev_file_open_by_dev().
> 
> Now you are doing the same thing, just as the other guy is
> getting to bdev_release() call.
> 
> The thing is, between your get_bdev_file() and increment of ->bd_openers
> (in bdev_open()) there's a window when bdev_release() of the old file
> could've gotten all the way through the decrement of ->bd_openers
> (to 0, since our increment has not happened yet) and through the
> call of put_bdev_file(), which ends up clearing ->i_private.
> 
> End result:
> 
> * old ->i_private leaked (already grabbed by your get_bdev_file())
> * ->bd_openers at 1 (after your bdev_open() gets through)
> * ->i_private left NULL.
> 
> Christoph, could we please get rid of that atomic_t nonsense?
> It only confuses people into brainos like that.  It really
> needs ->open_mutex for any kind of atomicity.

Well, there are a couple of places where we end up reading bd_openers
without ->open_mutex. Sure these places are racy wrt other opens / closes
so they need to be careful but we want to make sure we read back at least
some sane value which is not guaranteed with normal int and compiler
possily playing weird tricks when updating it. But yes, we could convert
the atomic_t to using READ_ONCE + WRITE_ONCE in appropriate places to avoid
these issues and make it more obvious bd_openers are not really handled in
an atomic way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

