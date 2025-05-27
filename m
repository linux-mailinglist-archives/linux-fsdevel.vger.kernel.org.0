Return-Path: <linux-fsdevel+bounces-49914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9AAC50B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 16:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645293A9467
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9227027700B;
	Tue, 27 May 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0zM9SZu1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kuuxuAGd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rP+YF/Sn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vxdtcbch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960919CD16
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355665; cv=none; b=TOKB2cT6fHFqftuJVd3uARCiooDlflHalN8b/FroqYdmn49Voar0x6Ua4G/DTqWhYgvG9wa/iJpn4eoVbFK7f35hJ9YaK2UesPkAAokTfQooQ6f+1D69xOILo5/nIwGBAdfjmW8FUWJX4R14Hky2GN1stSKKVaH9jMPqvpG6Apo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355665; c=relaxed/simple;
	bh=KcMv3Xgw7hqgnDYDyzD38r1s5XVzz3Cjh/ZttPOCTnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8ze9Saz2JFHazRKuhbSp+UpwWoSd6mjr8HFLatwYrQmAPK21r0T8pC0L7QyHVmuNl+3YdIbA8hrT1s6kvK9IhZf2kRnGmdKvG2cjtcabJnC7p99AgUWCnJLqZJ9/iZClBIjoo7ZWuiRND3J5l35GQVN7CTYvFvG2XH/ASQTz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0zM9SZu1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kuuxuAGd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rP+YF/Sn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vxdtcbch; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABAD321CCD;
	Tue, 27 May 2025 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748355660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVPbgkQNBewDwfjZQJhl7iJrA9cr59Ay9C7YiqMgTgw=;
	b=0zM9SZu1GBZKTCsRG70gl9Gfz1CVvVuwvIhEs2QSrhK4odGXJhBI1HiZsCqN8AJ5zCiSGX
	neK1G/bCuYgDAL3FzjraXoq7UM+KXzmQHFIocuWD3eqjdELgDcKRg+LG+KIp7vMtO5mkBP
	DMcdnamLL1pqHeYLQgsF/URzBViaom8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748355660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVPbgkQNBewDwfjZQJhl7iJrA9cr59Ay9C7YiqMgTgw=;
	b=kuuxuAGdYvkKRnAFMznb0UuwIy4WjwEmNiNlMJAezLL2w8SzKg2rGXi+s5NewThyOiznWc
	wc3kQrKjiVwtYaBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748355659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVPbgkQNBewDwfjZQJhl7iJrA9cr59Ay9C7YiqMgTgw=;
	b=rP+YF/SnNmlo/rHlWM6Lqp+PpeO2miC+d0sxEJyzospqWayUrCnvfUg0M8SapY0j+xsQiL
	EOilfZIvwhhJZej+BbcliOcTfuohwYribSL58tzwdj5hzIstmL8pdvJIZpl/9rPsjnXdYt
	TA6m02zBp6ugGXPSgZI2HQ19pkrsX/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748355659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVPbgkQNBewDwfjZQJhl7iJrA9cr59Ay9C7YiqMgTgw=;
	b=Vxdtcbchr8moYxproyc3Ti+g8FcZGPzQkwiO/U+0++fWdHp0M1yM6TRcnjDsWF7zFH7irS
	jQwCz1iu0dEpEBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99548136E0;
	Tue, 27 May 2025 14:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CRRiJUvKNWgOOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 May 2025 14:20:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1CE20A0951; Tue, 27 May 2025 16:20:55 +0200 (CEST)
Date: Tue, 27 May 2025 16:20:55 +0200
From: Jan Kara <jack@suse.cz>
To: Parav Pandit <parav@nvidia.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: warning on flushing page cache on block device removal
Message-ID: <pkstcm5x54ie466gce7ryaqd6lf767p6r4iin2ufby3swe46sg@3usmpixyeniq>
References: <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
 <CY8PR12MB7195241146E429EE867BFAF5DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195241146E429EE867BFAF5DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Level: 

On Tue 27-05-25 12:07:20, Parav Pandit wrote:
> > From: Jan Kara <jack@suse.cz>
> > Sent: Tuesday, May 27, 2025 5:27 PM
> > 
> > On Tue 27-05-25 11:00:56, Parav Pandit wrote:
> > > > From: Jan Kara <jack@suse.cz>
> > > > Sent: Monday, May 26, 2025 10:09 PM
> > > >
> > > > Hello!
> > > >
> > > > On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> > > > > I am running a basic test of block device driver unbind, bind
> > > > > while the fio is running random write IOs with direct=0.  The test
> > > > > hits the WARN_ON assert on:
> > > > >
> > > > > void pagecache_isize_extended(struct inode *inode, loff_t from,
> > > > > loff_t
> > > > > to) {
> > > > >         int bsize = i_blocksize(inode);
> > > > >         loff_t rounded_from;
> > > > >         struct folio *folio;
> > > > >
> > > > >         WARN_ON(to > inode->i_size);
> > > > >
> > > > > This is because when the block device is removed during driver
> > > > > unbind, the driver flow is,
> > > > >
> > > > > del_gendisk()
> > > > >     __blk_mark_disk_dead()
> > > > >             set_capacity((disk, 0);
> > > > >                 bdev_set_nr_sectors()
> > > > >                     i_size_write() -> This will set the inode's
> > > > > isize to 0, while the
> > > > page cache is yet to be flushed.
> > > > >
> > > > > Below is the kernel call trace.
> > > > >
> > > > > Can someone help to identify, where should be the fix?
> > > > > Should block layer to not set the capacity to 0?
> > > > > Or page catch to overcome this dynamic changing of the size?
> > > > > Or?
> > > >
> > > > After thinking about this the proper fix would be for i_size_write()
> > > > to happen under i_rwsem because the change in the middle of the
> > > > write is what's confusing the iomap code. I smell some deadlock
> > > > potential here but it's perhaps worth trying :)
> > > >
> > > Without it, I gave a quick try with inode_lock() unlock() in
> > > i_size_write() and initramfs level it was stuck.  I am yet to try with
> > > LOCKDEP.
> > 
> > You definitely cannot put inode_lock() into i_size_write(). i_size_write() is
> > expected to be called under inode_lock. And bdev_set_nr_sectors() is
> > breaking this rule by not holding it. So what you can try is to do
> > inode_lock() in bdev_set_nr_sectors() instead of grabbing bd_size_lock.
> >
> Ok. will try this.
> I am off for few days on travel, so earliest I can do is on Sunday.
>  
> > > I was thinking, can the existing sequence lock be used for 64-bit case
> > > as well?
> > 
> > The sequence lock is about updating inode->i_size value itself. But we need
> > much larger scale protection here - we need to make sure write to the block
> > device is not happening while the device size changes. And that's what
> > inode_lock is usually used for.
> > 
> Other option to explore (with my limited knowledge) is, 
> When the block device is removed, not to update the size,
> 
> Because queue dying flag and other barriers are placed to prevent the IOs entering lower layer or to fail them.
> Can that be the direction to fix?

Well, that's definitely one line of defense and it's enough for reads but
for writes you don't want them to accumulate in the page cache (and thus
consume memory) when you know you have no way to write them out. So there
needs to be some way for buffered writes to recognize the backing store is
gone and stop them before dirtying pages. Currently that's achieved by
reducing i_size, we can think of other mechanisms but reducing i_size is
kind of elegant if we can synchronize that properly...

								Honza 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

