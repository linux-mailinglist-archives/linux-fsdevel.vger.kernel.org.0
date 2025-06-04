Return-Path: <linux-fsdevel+bounces-50615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D64ACE033
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356B3168568
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BF42900B7;
	Wed,  4 Jun 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKtxwn2M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K/MAwiOT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="agtQ0R1D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MnhQ3tng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27028C845
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046981; cv=none; b=Qm1L1JPw5yi3VJzhTxPNm7O2HwK3h2cp9UoaSHH8Xpu9ks1vYhr2lF8ZGrzZWkv/95qnvZNvYSLUh5/xQ4/2eHuImiLzpldb6XRKQflmwS0D6TPbufZr3iPKQUHyLkJmkSwFENsu5O61D2eufy4LBKRkJkDK7dB8RXq3hIGuojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046981; c=relaxed/simple;
	bh=wy4PMXA2HnAOIBMPCfn3JRyMRnrGq+OkR8M+vP9lUXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgYo+ag5b1kL3OQbvpz4Fl1rwx72KVM4QoxSU70kAlUSPbRA2V9FxvceFqSeNtZxzwpwjAadhb5OK7K76SjPN7Z0t2wPBLfZQEL8hAwIGcCmB5m3HUfex6lu/05Yf9YYm7DFQhOFELyAXowns0y2hHE47xcpymECQRdgzzeH0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKtxwn2M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K/MAwiOT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=agtQ0R1D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MnhQ3tng; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7458A221F8;
	Wed,  4 Jun 2025 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749046978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1npuHGcOofDD7L2By4sTEzndf+9YF6o38KGoP7SONA=;
	b=iKtxwn2M0D2YTDBg1lvKy08V+y97/vM6zYT2zM5derVQV5Xjj1jRqS4r2W9lRo7B4PEdqZ
	RuNxcP3gG0vTrwCuOaVi+00TVLLVcmgVdvSuvrKKiOAoj/idxPpI/s6aJtaVxWxrM9naAI
	abDW/FEE0pEYnB8675PwY6yGak0XxtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749046978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1npuHGcOofDD7L2By4sTEzndf+9YF6o38KGoP7SONA=;
	b=K/MAwiOT2cUIs3tik7wHVKhgHCcAEGK7fxEX1ZbmO9mGjYgwM7xLREgRFLf1PVU4Rt+U2p
	vCdX40iD6I0TOxBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749046977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1npuHGcOofDD7L2By4sTEzndf+9YF6o38KGoP7SONA=;
	b=agtQ0R1Dl70wVIBuAFE8S8cNsjpPAxZz5pZypICoFQr94isvGCU/gJ7SCM4fAzynDj0ysh
	q/1KkUF6EHlRz+SlbI/MJYnGbecPNw2gIZ4Pz5RzVqnfOMqk2xFXNpHPkQCtmxb0bGd8de
	QTvU4nHtT66TuxERHvb6cuCy3tYXDd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749046977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1npuHGcOofDD7L2By4sTEzndf+9YF6o38KGoP7SONA=;
	b=MnhQ3tngdPWuMWGE0vFIGOfmKIyEv6yup9+FShOoPlKxkLQ0CH7TkdRWUjW6fH2jmRmwvE
	+6vGwmLqYfPm3RCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69BB813A63;
	Wed,  4 Jun 2025 14:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yIvMGcFWQGgWdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Jun 2025 14:22:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 106BEA095C; Wed,  4 Jun 2025 16:22:57 +0200 (CEST)
Date: Wed, 4 Jun 2025 16:22:57 +0200
From: Jan Kara <jack@suse.cz>
To: Parav Pandit <parav@nvidia.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: warning on flushing page cache on block device removal
Message-ID: <z2qpz2g5wq44ubhuezfv3axwx46btx6bqr4k45k3rs3gsc6ezx@psgsxtoeue2v>
References: <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
 <CY8PR12MB7195241146E429EE867BFAF5DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <pkstcm5x54ie466gce7ryaqd6lf767p6r4iin2ufby3swe46sg@3usmpixyeniq>
 <CY8PR12MB7195BADB223A5660E2D029C4DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CY8PR12MB719567D0A9EAE47A41EE3AC4DC6DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719567D0A9EAE47A41EE3AC4DC6DA@CY8PR12MB7195.namprd12.prod.outlook.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,nvidia.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hi!

On Tue 03-06-25 13:33:02, Parav Pandit wrote:
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Tuesday, May 27, 2025 7:55 PM
> > 
> > 
> > > From: Jan Kara <jack@suse.cz>
> > > Sent: Tuesday, May 27, 2025 7:51 PM
> > >
> > > On Tue 27-05-25 12:07:20, Parav Pandit wrote:
> > > > > From: Jan Kara <jack@suse.cz>
> > > > > Sent: Tuesday, May 27, 2025 5:27 PM
> > > > >
> > > > > On Tue 27-05-25 11:00:56, Parav Pandit wrote:
> > > > > > > From: Jan Kara <jack@suse.cz>
> > > > > > > Sent: Monday, May 26, 2025 10:09 PM
> > > > > > >
> > > > > > > Hello!
> > > > > > >
> > > > > > > On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> > > > > > > > I am running a basic test of block device driver unbind,
> > > > > > > > bind while the fio is running random write IOs with
> > > > > > > > direct=0.  The test hits the WARN_ON assert on:
> > > > > > > >
> > > > > > > > void pagecache_isize_extended(struct inode *inode, loff_t
> > > > > > > > from, loff_t
> > > > > > > > to) {
> > > > > > > >         int bsize = i_blocksize(inode);
> > > > > > > >         loff_t rounded_from;
> > > > > > > >         struct folio *folio;
> > > > > > > >
> > > > > > > >         WARN_ON(to > inode->i_size);
> > > > > > > >
> > > > > > > > This is because when the block device is removed during
> > > > > > > > driver unbind, the driver flow is,
> > > > > > > >
> > > > > > > > del_gendisk()
> > > > > > > >     __blk_mark_disk_dead()
> > > > > > > >             set_capacity((disk, 0);
> > > > > > > >                 bdev_set_nr_sectors()
> > > > > > > >                     i_size_write() -> This will set the
> > > > > > > > inode's isize to 0, while the
> > > > > > > page cache is yet to be flushed.
> > > > > > > >
> > > > > > > > Below is the kernel call trace.
> > > > > > > >
> > > > > > > > Can someone help to identify, where should be the fix?
> > > > > > > > Should block layer to not set the capacity to 0?
> > > > > > > > Or page catch to overcome this dynamic changing of the size?
> > > > > > > > Or?
> > > > > > >
> > > > > > > After thinking about this the proper fix would be for
> > > > > > > i_size_write() to happen under i_rwsem because the change in
> > > > > > > the middle of the write is what's confusing the iomap code. I
> > > > > > > smell some deadlock potential here but it's perhaps worth
> > > > > > > trying :)
> > > > > > >
> > > > > > Without it, I gave a quick try with inode_lock() unlock() in
> > > > > > i_size_write() and initramfs level it was stuck.  I am yet to
> > > > > > try with LOCKDEP.
> > > > >
> > > > > You definitely cannot put inode_lock() into i_size_write().
> > > > > i_size_write() is expected to be called under inode_lock. And
> > > > > bdev_set_nr_sectors() is breaking this rule by not holding it. So
> > > > > what you can try is to do
> > > > > inode_lock() in bdev_set_nr_sectors() instead of grabbing bd_size_lock.
> > > > >
> 
> I replaced the bd_size_lock with inode_lock().
> Was unable to reproduce the issue yet with the fix.
> 
> However, it right away breaks the Atari floppy driver who invokes
> set_capacity() in queue_rq() at [1]. !!
> 
> [1] https://elixir.bootlin.com/linux/v6.15/source/drivers/block/ataflop.c#L1544

Yeah, that's somewhat unexpected. Anyway, Atari floppy driver isn't exactly
a reliable source of proper locking...

> With my limited knowledge I find the fix risky as bottom block layer is
> invoking upper FS layer inode lock.  I suspect it may lead to A->B, B->A
> locking in some path.

Well, I'm suspecting that as well. That's why I've asked you to test it :)
Are you running with lockdep enabled? Because I'd expect it to complain
rather quickly. Possibly run blktests as well to exercise various
not-so-usual paths so that lockdep learns about various lock dependencies.

> Other than Atari floppy driver, I didn't find any other offending driver,
> but its hard to say, its safe from A->B, B->A deadlock.
> A = inode lock
> B = block driver level lock

								Honza

> > > > Ok. will try this.
> > > > I am off for few days on travel, so earliest I can do is on Sunday.
> > > >
> > > > > > I was thinking, can the existing sequence lock be used for
> > > > > > 64-bit case as well?
> > > > >
> > > > > The sequence lock is about updating inode->i_size value itself.
> > > > > But we need much larger scale protection here - we need to make
> > > > > sure write to the block device is not happening while the device
> > > > > size changes. And that's what inode_lock is usually used for.
> > > > >
> > > > Other option to explore (with my limited knowledge) is, When the
> > > > block device is removed, not to update the size,
> > > >
> > > > Because queue dying flag and other barriers are placed to prevent
> > > > the IOs
> > > entering lower layer or to fail them.
> > > > Can that be the direction to fix?
> > >
> > > Well, that's definitely one line of defense and it's enough for reads
> > > but for writes you don't want them to accumulate in the page cache
> > > (and thus consume memory) when you know you have no way to write
> > them
> > > out. So there needs to be some way for buffered writes to recognize
> > > the backing store is gone and stop them before dirtying pages.
> > > Currently that's achieved by reducing i_size, we can think of other
> > > mechanisms but reducing i_size is kind of elegant if we can synchronize that
> > properly...
> > >
> > The block device notifies the bio layer by calling
> > blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue); Maybe we can come
> > up with notification method that updates some flag to page cache layer to
> > drop buffered writes to floor.
> > 
> > Or other direction to explore, if the WAR_ON() is still valid, as it can change
> > anytime?
> > 
> > > 								Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

