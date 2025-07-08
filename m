Return-Path: <linux-fsdevel+bounces-54236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D416AFC831
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17421BC1998
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829626A1CF;
	Tue,  8 Jul 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gvcSW/jb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JPeLmiN4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gvcSW/jb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JPeLmiN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B35269B08
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970005; cv=none; b=danZyWiBNl+RT0XdWDSioQAPipM0f8XqvpcBJtst30cywEWmgTbAzsu5Jtz/gKWaz2OcwHk6uVGX1TCXk7I+/9tNjRnvg2wNxLa8e/hgW9ta4ixFgOsFo1ZbewLPuXj/UAeCTqk1KtbRArZvEr0WPOtWITN50MifUx8kJ0H1OL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970005; c=relaxed/simple;
	bh=6F+F/iGv3OA5nxQdu8gCwkz1tTRlsBjIS7mrQcANGjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1KdHUJPUNVIGUCAw8C1vM7cjZOSDWUFsMEJ8ZefKUh3SC1JFt00kZUeDnsikRQRr15ZuSzg6HF9P9+IRKNpPo3zdfMMd1aazB5nA8b5U0PZfkTZc5IcCmynkFyLgyV2wFVqGgeMGOf3Cw02E3DoJ9/TruoBykOeFEBUoZShUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gvcSW/jb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JPeLmiN4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gvcSW/jb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JPeLmiN4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77A321F38D;
	Tue,  8 Jul 2025 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751970001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj1CDaVD+4BtlFnopoRZeD5WKkVDF86m6K5HhWwwKt8=;
	b=gvcSW/jbIbPJe4xojVrkaRri64CmwfkMCivzcOcy7X/5Ulw+aCiQctp3+++b5kqbwtKWfd
	XZQLG1KLyBLvSIpnHoUMBP0JhOPCk/9pWF975zNBS2Z89IyO8R3f1A0MnwdyqV1ahHhof+
	2hJTSd2oiBrpFPJh/W1vOOSMyXPKh1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751970001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj1CDaVD+4BtlFnopoRZeD5WKkVDF86m6K5HhWwwKt8=;
	b=JPeLmiN4a6hJiNlYT+wM83pfzh7kRvuR3E14GWwd7cCJViE7FCdJgiAGCQ4t0tbrbV7KE0
	6is/9OuH+76f87BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="gvcSW/jb";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JPeLmiN4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751970001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj1CDaVD+4BtlFnopoRZeD5WKkVDF86m6K5HhWwwKt8=;
	b=gvcSW/jbIbPJe4xojVrkaRri64CmwfkMCivzcOcy7X/5Ulw+aCiQctp3+++b5kqbwtKWfd
	XZQLG1KLyBLvSIpnHoUMBP0JhOPCk/9pWF975zNBS2Z89IyO8R3f1A0MnwdyqV1ahHhof+
	2hJTSd2oiBrpFPJh/W1vOOSMyXPKh1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751970001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj1CDaVD+4BtlFnopoRZeD5WKkVDF86m6K5HhWwwKt8=;
	b=JPeLmiN4a6hJiNlYT+wM83pfzh7kRvuR3E14GWwd7cCJViE7FCdJgiAGCQ4t0tbrbV7KE0
	6is/9OuH+76f87BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6340A13A54;
	Tue,  8 Jul 2025 10:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9+I3GNHwbGi7eQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Jul 2025 10:20:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA382A098F; Tue,  8 Jul 2025 12:20:00 +0200 (CEST)
Date: Tue, 8 Jul 2025 12:20:00 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Dave Chinner <david@fromorbit.com>, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <2dm6bsup7vxwl4vwmllkvt5erncirr272bov4ehd5gix7n2vnw@bkagb26tjtj5>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708004532.GA2672018@frogsfrogsfrogs>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,fromorbit.com,suse.com,vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,lists.sourceforge.net,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 77A321F38D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon 07-07-25 17:45:32, Darrick J. Wong wrote:
> On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
> > 在 2025/7/8 08:32, Dave Chinner 写道:
> > > On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
> > > > Currently all the filesystems implementing the
> > > > super_opearations::shutdown() callback can not afford losing a device.
> > > > 
> > > > Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> > > > involved filesystem.
> > > > 
> > > > But it will no longer be the case, with multi-device filesystems like
> > > > btrfs and bcachefs the filesystem can handle certain device loss without
> > > > shutting down the whole filesystem.
> > > > 
> > > > To allow those multi-device filesystems to be integrated to use
> > > > fs_holder_ops:
> > > > 
> > > > - Replace super_opearation::shutdown() with
> > > >    super_opearations::remove_bdev()
> > > >    To better describe when the callback is called.
> > > 
> > > This conflates cause with action.
> > > 
> > > The shutdown callout is an action that the filesystem must execute,
> > > whilst "remove bdev" is a cause notification that might require an
> > > action to be take.
> > > 
> > > Yes, the cause could be someone doing hot-unplug of the block
> > > device, but it could also be something going wrong in software
> > > layers below the filesystem. e.g. dm-thinp having an unrecoverable
> > > corruption or ENOSPC errors.
> > > 
> > > We already have a "cause" notification: blk_holder_ops->mark_dead().
> > > 
> > > The generic fs action that is taken by this notification is
> > > fs_bdev_mark_dead().  That action is to invalidate caches and shut
> > > down the filesystem.
> > > 
> > > btrfs needs to do something different to a blk_holder_ops->mark_dead
> > > notification. i.e. it needs an action that is different to
> > > fs_bdev_mark_dead().
> > > 
> > > Indeed, this is how bcachefs already handles "single device
> > > died" events for multi-device filesystems - see
> > > bch2_fs_bdev_mark_dead().
> > 
> > I do not think it's the correct way to go, especially when there is already
> > fs_holder_ops.
> > 
> > We're always going towards a more generic solution, other than letting the
> > individual fs to do the same thing slightly differently.
> 
> On second thought -- it's weird that you'd flush the filesystem and
> shrink the inode/dentry caches in a "your device went away" handler.
> Fancy filesystems like bcachefs and btrfs would likely just shift IO to
> a different bdev, right?  And there's no good reason to run shrinkers on
> either of those fses, right?

I agree it is awkward and bcachefs avoids these in case of removal it can
handle gracefully AFAICS.

> > Yes, the naming is not perfect and mixing cause and action, but the end
> > result is still a more generic and less duplicated code base.
> 
> I think dchinner makes a good point that if your filesystem can do
> something clever on device removal, it should provide its own block
> device holder ops instead of using fs_holder_ops.  I don't understand
> why you need a "generic" solution for btrfs when it's not going to do
> what the others do anyway.

Well, I'd also say just go for own fs_holder_ops if it was not for the
awkward "get super from bdev" step. As Christian wrote we've encapsulated
that in fs/super.c and bdev_super_lock() in particular but the calling
conventions for the fs_holder_ops are not very nice (holding
bdev_holder_lock, need to release it before grabbing practically anything
else) so I'd have much greater peace of mind if this didn't spread too
much. Once you call bdev_super_lock() and hold on to sb with s_umount held,
things are much more conventional for the fs land so I'd like if this
step happened before any fs hook got called. So I prefer something like
Qu's proposal of separate sb op for device removal over exporting
bdev_super_lock(). Like:

static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
{
        struct super_block *sb;

        sb = bdev_super_lock(bdev, false);
        if (!sb)
                return;

	if (sb->s_op->remove_bdev) {
		sb->s_op->remove_bdev(sb, bdev, surprise);
		return;
	}

	if (!surprise)
		sync_filesystem(sb);
	shrink_dcache_sb(sb);
	evict_inodes(sb);
	if (sb->s_op->shutdown)
		sb->s_op->shutdown(sb);

	super_unlock_shared(sb);
}

> As an aside:
> 'twould be nice if we could lift the *FS_IOC_SHUTDOWN dispatch out of
> everyone's ioctl functions into the VFS, and then move the "I am dead"
> state into super_block so that you could actually shut down any
> filesystem, not just the seven that currently implement it.

Yes, I should find time to revive that patch series... It was not *that*
hard to do.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

