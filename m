Return-Path: <linux-fsdevel+bounces-17144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE808A850D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11326281998
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C813FD85;
	Wed, 17 Apr 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJV/Gm1m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OhQ0RcqQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJV/Gm1m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OhQ0RcqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43D13C8FB;
	Wed, 17 Apr 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361396; cv=none; b=fAjGhYFdWr+ixwdBe9148zJM7NU50Kft0qBLgLay6pcILzptBMbAafiYt6g4zidUXYPh9SD8T43dTlVY8xUvMgdYZnDudWkd090eKWjU5gOQH8QHO8VS2K67QDoREKVbkuQ94hYQUaP9sClSQYWwUdrk/NvZDp+4AuVUF7rTlqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361396; c=relaxed/simple;
	bh=3H4ANiCsN9vuljSv/DqAZaqSlensjliUrkwh8tlFjp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt2NXuUr9RaQdPJ14ovV4Y4yH48oOl2PloP9V+WaFFhI8sgCULbPjy/VTV74hx5e0i9obfsnwmnnRu1Mt6UNtVJjDfd3zoSwmJKeElWgmDfMRBr+bQmNEPTPwc3SbsyFHtTcFC1peTHJuVMm2p2X10H0yn7PjFC7ZMPIxhxTwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJV/Gm1m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OhQ0RcqQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJV/Gm1m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OhQ0RcqQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4890E33D09;
	Wed, 17 Apr 2024 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713361393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l93s1tMIBD4qUa8mQMUmv38tl90X6yeBgo1RaoSIoi4=;
	b=SJV/Gm1mQ+RdB8s7p7OUH2nXpmsDfiGhS9dVvxMad4xpbYHVagIZLHrssNe6EPgZCzB10B
	K/wcA3hvaZ7N5N4kIrWx7MfjCbXUM8MgYMk4nAQPhXcQDVtn0JJmd5KElEGs0WCHYp8qq7
	MW0DVMqwDgk8kvVPYPBch9FXtcWjFfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713361393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l93s1tMIBD4qUa8mQMUmv38tl90X6yeBgo1RaoSIoi4=;
	b=OhQ0RcqQaScpZ32zgS+P8RrogShR5G0SWFIuICpo2L6QAx1usP9T3IWpo9xhDQYroWIqJy
	XNyZ1S4urS1eaGCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713361393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l93s1tMIBD4qUa8mQMUmv38tl90X6yeBgo1RaoSIoi4=;
	b=SJV/Gm1mQ+RdB8s7p7OUH2nXpmsDfiGhS9dVvxMad4xpbYHVagIZLHrssNe6EPgZCzB10B
	K/wcA3hvaZ7N5N4kIrWx7MfjCbXUM8MgYMk4nAQPhXcQDVtn0JJmd5KElEGs0WCHYp8qq7
	MW0DVMqwDgk8kvVPYPBch9FXtcWjFfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713361393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l93s1tMIBD4qUa8mQMUmv38tl90X6yeBgo1RaoSIoi4=;
	b=OhQ0RcqQaScpZ32zgS+P8RrogShR5G0SWFIuICpo2L6QAx1usP9T3IWpo9xhDQYroWIqJy
	XNyZ1S4urS1eaGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32FCA13957;
	Wed, 17 Apr 2024 13:43:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CoRyDPHRH2aXOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Apr 2024 13:43:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA9FCA082E; Wed, 17 Apr 2024 15:43:12 +0200 (CEST)
Date: Wed, 17 Apr 2024 15:43:12 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240417134312.mntxg6iju4aalxpy@quack3>
References: <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
 <20240412112919.GN2118490@ZenIV>
 <20240413-hievt-zweig-2e40ac6443aa@brauner>
 <20240415204511.GV2118490@ZenIV>
 <20240416063253.GA2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416063253.GA2118490@ZenIV>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 16-04-24 07:32:53, Al Viro wrote:
> On Mon, Apr 15, 2024 at 09:45:11PM +0100, Al Viro wrote:
> > On Sat, Apr 13, 2024 at 05:25:01PM +0200, Christian Brauner wrote:
> > 
> > > > It also simplifies the hell out of the patch series - it's one obviously
> > > > safe automatic change in a single commit.
> > > 
> > > It's trivial to fold the simple file_mapping() conversion into a single
> > > patch as well.
> > 
> > ... after a bunch of patches that propagate struct file to places where
> > it has no business being.  Compared to a variant that doesn't need those
> > patches at all.
> > 
> > > It's a pure artifact of splitting the patches per
> > > subsystem/driver.
> > 
> > No, it is not.  ->bd_mapping conversion can be done without any
> > preliminaries.  Note that it doesn't need messing with bdev_read_folio(),
> > it doesn't need this journal->j_fs_dev_file thing, etc.
> > 
> > One thing I believe is completely wrong in this series is bdev_inode()
> > existence.  It (and equivalent use of file_inode() on struct file is
> > even worse) is papering over the real interface deficiencies.  And
> > extra file_inode() uses are just about impossible to catch ;-/
> > 
> > IMO we should *never* use file_inode() on opened block devices.
> > At all.  It's brittle, it's asking for trouble as soon as somebody
> > passes a normally opened struct file to one of the functions using it
> > and it papers over the missing primitives.
> 
> BTW, speaking of the things where opened struct file would be a good
> idea - set_blocksize() should take an opened struct file, and it should
> have non-NULL ->private_data.
> 
> Changing block size under e.g. a mounted filesystem should never happen;
> doing that is asking for serious breakage.
> 
> Looking through the current callers (mainline), most are OK (and easy
> to switch).  However,
> 	
> drivers/block/pktcdvd.c:2285:           set_blocksize(disk->part0, CD_FRAMESIZE);
> drivers/block/pktcdvd.c:2529:   set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
> 	Might be broken; pktcdvd.c being what it is...
> 
> drivers/md/bcache/super.c:2558: if (set_blocksize(file_bdev(bdev_file), 4096))
> 	Almost certainly broken; hit register_bcache() with pathname of a mounted
> block device, and if the block size on filesystem in question is not 4K, the things
> will get interesting.

Agreed. Furthermore that set_blocksize() seems to be completely pointless
these days AFAICT because we use read_cache_page_gfp() to read in the data
from the device. Sure we may be creating more bhs per page than necessary
but who cares?

> fs/btrfs/volumes.c:485: ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
> 	Some of the callers do not bother with exclusive open;
> in particular, if btrfs_get_dev_args_from_path() ever gets a pathname
> of a mounted device with something other than btrfs on it, it won't
> be pretty.

Yeah and frankly reading through btrfs_read_dev_super() I'm not sure which
code needs the block size set either. We use read_cache_page_gfp() for the
IO there as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

