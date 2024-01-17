Return-Path: <linux-fsdevel+bounces-8175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73940830AC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF361F22158
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1DF22EF4;
	Wed, 17 Jan 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jL82kkzP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+go7pg4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jL82kkzP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+go7pg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C62231D;
	Wed, 17 Jan 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508110; cv=none; b=rw4fNLmVlMLRjUk0sMndqCoOdkpUWMH+FiJOoaXzw8MhcGu1uDCvs34rB9io1caZzPIzefLYC77Ru26HpGOM6vHIPWjjOY9hTeCgIEfj0VtnS0mdegVW7OcFg3XpHqOHxPPD0V1WDMAzyaIcmRwbngBnELFBRTXyQpBMInSo9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508110; c=relaxed/simple;
	bh=Wr4SEOySYrGZgnBwtFtoyX8Xf/2R35798/IRO1fsd0Y=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=MYv/FURnf4mwMqx0tCjDus9NKYjX6BES4P/nTmKpErvVsYHDIj3MGXug9/92W1wlS6wsThlQamayhtxIKIrp8ix3ZcTiKsszYas3OTldaZmILw9WDIn5wWbTTN90vQmXVLT2tQlItps+3h5ALRZkgAED+JCGOlwsD4ky+S6o9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jL82kkzP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+go7pg4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jL82kkzP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+go7pg4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEE75221FA;
	Wed, 17 Jan 2024 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705508106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/DWTK3ASPrpOGM4GcgB4X4BejAPplm6u+lsIlTn66i8=;
	b=jL82kkzPFHFOEv0Q/cceKWw8YQtcXSrxv5pq0gQak6n3ftt+YBk54Bnei/0jYVXLttoDCJ
	X4EIm9hS52I4Qdgp7RqjWb0+s89qmlW5GiUmo38Z093kXMnHm2IWuyeko5jV9rlVxyk12f
	Pz93Bh/96XOFtN8IZI8DD4Szl2SMkQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705508106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/DWTK3ASPrpOGM4GcgB4X4BejAPplm6u+lsIlTn66i8=;
	b=n+go7pg4H76ctk3oGZJ0KJDwagn25kc9tKYyLybl+gYpICA3w7GSTcs+ECFnkUBNg1sxyx
	1BMIGh+b+2yKdsDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705508106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/DWTK3ASPrpOGM4GcgB4X4BejAPplm6u+lsIlTn66i8=;
	b=jL82kkzPFHFOEv0Q/cceKWw8YQtcXSrxv5pq0gQak6n3ftt+YBk54Bnei/0jYVXLttoDCJ
	X4EIm9hS52I4Qdgp7RqjWb0+s89qmlW5GiUmo38Z093kXMnHm2IWuyeko5jV9rlVxyk12f
	Pz93Bh/96XOFtN8IZI8DD4Szl2SMkQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705508106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/DWTK3ASPrpOGM4GcgB4X4BejAPplm6u+lsIlTn66i8=;
	b=n+go7pg4H76ctk3oGZJ0KJDwagn25kc9tKYyLybl+gYpICA3w7GSTcs+ECFnkUBNg1sxyx
	1BMIGh+b+2yKdsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F43513751;
	Wed, 17 Jan 2024 16:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t5KPJgr9p2UjKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 16:15:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39BAFA0803; Wed, 17 Jan 2024 17:15:00 +0100 (CET)
Date: Wed, 17 Jan 2024 17:15:00 +0100
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH DRAFT RFC 34/34] buffer: port block device access to
 files and get rid of bd_inode access
Message-ID: <20240117161500.bibuljso32a2a26y@quack3>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>
 <ZZuNgqLNimnMBTIC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZuNgqLNimnMBTIC@dread.disaster.area>
Authentication-Results: smtp-out1.suse.de;
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

On Mon 08-01-24 16:52:02, Dave Chinner wrote:
> On Wed, Jan 03, 2024 at 01:55:32PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  block/fops.c                  |  1 +
> >  drivers/md/md-bitmap.c        |  1 +
> >  fs/affs/file.c                |  1 +
> >  fs/btrfs/inode.c              |  1 +
> >  fs/buffer.c                   | 69 ++++++++++++++++++++++---------------------
> >  fs/direct-io.c                |  2 +-
> >  fs/erofs/data.c               |  7 +++--
> >  fs/erofs/internal.h           |  1 +
> >  fs/erofs/zmap.c               |  1 +
> >  fs/ext2/inode.c               |  8 +++--
> >  fs/ext4/inode.c               |  6 ++--
> >  fs/ext4/super.c               |  6 ++--
> >  fs/f2fs/data.c                |  6 +++-
> >  fs/f2fs/f2fs.h                |  1 +
> >  fs/fuse/dax.c                 |  1 +
> >  fs/gfs2/aops.c                |  1 +
> >  fs/gfs2/bmap.c                |  1 +
> >  fs/hpfs/file.c                |  1 +
> >  fs/jbd2/commit.c              |  1 +
> >  fs/jbd2/journal.c             | 26 +++++++++-------
> >  fs/jbd2/recovery.c            |  6 ++--
> >  fs/jbd2/revoke.c              | 10 +++----
> >  fs/jbd2/transaction.c         |  1 +
> >  fs/mpage.c                    |  5 +++-
> >  fs/nilfs2/btnode.c            |  2 ++
> >  fs/nilfs2/gcinode.c           |  1 +
> >  fs/nilfs2/mdt.c               |  1 +
> >  fs/nilfs2/page.c              |  2 ++
> >  fs/nilfs2/recovery.c          | 20 ++++++-------
> >  fs/nilfs2/the_nilfs.c         |  1 +
> >  fs/ntfs/aops.c                |  3 ++
> >  fs/ntfs/file.c                |  1 +
> >  fs/ntfs/mft.c                 |  2 ++
> >  fs/ntfs3/fsntfs.c             |  8 ++---
> >  fs/ntfs3/inode.c              |  1 +
> >  fs/ntfs3/super.c              |  2 +-
> >  fs/ocfs2/journal.c            |  2 +-
> >  fs/reiserfs/journal.c         |  8 ++---
> >  fs/reiserfs/reiserfs.h        |  6 ++--
> >  fs/reiserfs/tail_conversion.c |  1 +
> >  fs/xfs/xfs_iomap.c            |  7 +++--
> >  fs/zonefs/file.c              |  2 ++
> >  include/linux/buffer_head.h   | 45 +++++++++++++++-------------
> >  include/linux/iomap.h         |  1 +
> >  include/linux/jbd2.h          |  6 ++--
> >  45 files changed, 172 insertions(+), 114 deletions(-)
> > 
> > diff --git a/block/fops.c b/block/fops.c
> > index e831196dafac..6557b71c7657 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -381,6 +381,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >  	loff_t isize = i_size_read(inode);
> >  
> >  	iomap->bdev = bdev;
> > +	BUG_ON(true /* TODO(brauner): This is the only place where we don't go from inode->i_sb->s_f_bdev for obvious reasons. Thoughts? */);
> 
> Maybe block devices should have their own struct file created when the
> block device is instantiated and torn down when the block device is
> trashed?

OK, but is there a problem with I_BDEV() which is currently used in
blkdev_iomap_begin()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

