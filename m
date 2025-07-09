Return-Path: <linux-fsdevel+bounces-54375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32BEAFEFB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 19:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFDD1C4777D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE822425E;
	Wed,  9 Jul 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrtqxg0H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BcWGmaiw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJoWVpOV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TL+oxa4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B720551C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081791; cv=none; b=Y4N+7CT6R6orTYrnEbp88MKql/yyWiqX8u06nDJps+QddPuwruh3/WllomiaWYyRL/xQN0phPN7Y/o5tuig1+gSEh7IQjCxTnYsnLRQSyXvqS2iHSEOBMOAaTNhUXuYcdir8sOtHKg3wHx+dvOvJURJDgHX9uwy9U3onO0BvF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081791; c=relaxed/simple;
	bh=EnJHYNU6Y50PZt7QUNbTsz9O4daY3cPlwjTtQcl/RqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QMfS3w6usPrLGOM3N9Xa/wgniBr+lHNCUkiYKICDjMmrWNxKOP9UMLmRoEw4ehDS1rbcikvb3sGViOcGkumc2JzMhwPgYF6RCasa1jDTLXg6BCWmU0Is26bP3clQY70xvQCjOjmbKr02ips7eviZOdF5tum4hthmt6znvHNf0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrtqxg0H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BcWGmaiw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJoWVpOV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TL+oxa4x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B22EC2117A;
	Wed,  9 Jul 2025 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752081788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CC+sITaj/SX+l6M3xryuVDKN0uxVFK1sOBgicJxYht8=;
	b=lrtqxg0H1oHdRhpeVDqsfF0jwsTZRp+1UW+HoKB7Ar3SPhbDVX2YWrdqpqp2OahdYFramu
	Cn5jdABzK7odyjvf1dFYABXqHRs4QTi86JTw9pwzP7g5iedq7nX8nzx97GlZNHGD2GrzZj
	hVZYetUA+B3xdI7RiAN7orS+RIaDZOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752081788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CC+sITaj/SX+l6M3xryuVDKN0uxVFK1sOBgicJxYht8=;
	b=BcWGmaiwk5rfrY2cCRW+UhD3p8GJgvAytQYAcd/mkwlrlvCTJyk/Tl/jFpD+V18B+EhTXq
	8m6PspGYMjIIFQBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752081787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CC+sITaj/SX+l6M3xryuVDKN0uxVFK1sOBgicJxYht8=;
	b=AJoWVpOV56vkSVcv6MRSAVnN+fCovzvMso4Gmd7m522WNv6fUyv7PgxY65ajGU28NYMk+Z
	SYmQDI/e7QRKAWiDK23RXqEX9gQrt/v2/GxWoEet2h77Jt0n59A3Jf7s+wOCHonoFjFJgQ
	+lggTc1pTzzQHGAeqRz1scGNTLY0Yws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752081787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CC+sITaj/SX+l6M3xryuVDKN0uxVFK1sOBgicJxYht8=;
	b=TL+oxa4x5HVSeFOOVnZbN20Kr3T/kNhk4mP74dqSzQSbR8Phj9mtdSonllbxlOwKAMwrnP
	yZPrtli/rPlKOdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B43D13757;
	Wed,  9 Jul 2025 17:23:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LVzgJXulbmhoJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Jul 2025 17:23:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D212A09C3; Wed,  9 Jul 2025 19:23:07 +0200 (CEST)
Date: Wed, 9 Jul 2025 19:23:07 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <343vlonfhw76mnbjnysejihoxsjyp2kzwvedhjjjml4ccaygbq@72m67s3e2ped>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	FAKE_REPLY(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmx.com,suse.com,vger.kernel.org,zeniv.linux.org.uk,suse.cz,lists.sourceforge.net,lists.linux.dev,linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Bcc:
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Reply-To:
In-Reply-To: <aG2i3qP01m-vmFVE@dread.disaster.area>

On Wed 09-07-25 08:59:42, Dave Chinner wrote:
> On Tue, Jul 08, 2025 at 09:55:14AM +0200, Christian Brauner wrote:
> > On Mon, Jul 07, 2025 at 05:45:32PM -0700, Darrick J. Wong wrote:
> > > On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
> > > > 在 2025/7/8 08:32, Dave Chinner 写道:
> > > > > On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
> > > > > > Currently all the filesystems implementing the
> > > > > > super_opearations::shutdown() callback can not afford losing a device.
> > > > > > 
> > > > > > Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> > > > > > involved filesystem.
> > > > > > 
> > > > > > But it will no longer be the case, with multi-device filesystems like
> > > > > > btrfs and bcachefs the filesystem can handle certain device loss without
> > > > > > shutting down the whole filesystem.
> > > > > > 
> > > > > > To allow those multi-device filesystems to be integrated to use
> > > > > > fs_holder_ops:
> > > > > > 
> > > > > > - Replace super_opearation::shutdown() with
> > > > > >    super_opearations::remove_bdev()
> > > > > >    To better describe when the callback is called.
> > > > > 
> > > > > This conflates cause with action.
> > > > > 
> > > > > The shutdown callout is an action that the filesystem must execute,
> > > > > whilst "remove bdev" is a cause notification that might require an
> > > > > action to be take.
> > > > > 
> > > > > Yes, the cause could be someone doing hot-unplug of the block
> > > > > device, but it could also be something going wrong in software
> > > > > layers below the filesystem. e.g. dm-thinp having an unrecoverable
> > > > > corruption or ENOSPC errors.
> > > > > 
> > > > > We already have a "cause" notification: blk_holder_ops->mark_dead().
> > > > > 
> > > > > The generic fs action that is taken by this notification is
> > > > > fs_bdev_mark_dead().  That action is to invalidate caches and shut
> > > > > down the filesystem.
> > > > > 
> > > > > btrfs needs to do something different to a blk_holder_ops->mark_dead
> > > > > notification. i.e. it needs an action that is different to
> > > > > fs_bdev_mark_dead().
> > > > > 
> > > > > Indeed, this is how bcachefs already handles "single device
> > > > > died" events for multi-device filesystems - see
> > > > > bch2_fs_bdev_mark_dead().
> > > > 
> > > > I do not think it's the correct way to go, especially when there is already
> > > > fs_holder_ops.
> > > > 
> > > > We're always going towards a more generic solution, other than letting the
> > > > individual fs to do the same thing slightly differently.
> > > 
> > > On second thought -- it's weird that you'd flush the filesystem and
> > > shrink the inode/dentry caches in a "your device went away" handler.
> > > Fancy filesystems like bcachefs and btrfs would likely just shift IO to
> > > a different bdev, right?  And there's no good reason to run shrinkers on
> > > either of those fses, right?
> > > 
> > > > Yes, the naming is not perfect and mixing cause and action, but the end
> > > > result is still a more generic and less duplicated code base.
> > > 
> > > I think dchinner makes a good point that if your filesystem can do
> > > something clever on device removal, it should provide its own block
> > > device holder ops instead of using fs_holder_ops.  I don't understand
> > > why you need a "generic" solution for btrfs when it's not going to do
> > > what the others do anyway.
> > 
> > I think letting filesystems implement their own holder ops should be
> > avoided if we can. Christoph may chime in here. I have no appettite for
> > exporting stuff like get_bdev_super() unless absolutely necessary. We
> > tried to move all that handling into the VFS to eliminate a slew of
> > deadlocks we detected and fixed. I have no appetite to repeat that
> > cycle.
> 
> Except it isn't actually necessary.
> 
> Everyone here seems to be assuming that the filesystem *must* take
> an active superblock reference to process a device removal event,
> and that is *simply not true*.
> 
> bcachefs does not use get_bdev_super() or an active superblock
> reference to process ->mark_dead events.
>
> It has it's own internal reference counting on the struct bch_fs
> attached to the bdev that ensures the filesystem structures can't go
> away whilst ->mark_dead is being processed.  i.e. bcachefs is only
> dependent on the bdev->bd_holder_lock() being held when
> ->mark_dead() is called and does not rely on the VFS for anything.

Right, they have their own refcount which effectively blocks umount
in .put_super AFAICS and they use it instead of VFS refcounts for this.

> This means that device removal processing can be performed
> without global filesystem/VFS locks needing to be held. Hence issues
> like re-entrancy deadlocks when there are concurrent/cascading
> device failures (e.g. a HBA dies, taking out multiple devices
> simultaneously) are completely avoided...

Funnily enough how about:

bch2_fs_bdev_mark_dead()		umount()
  bdev_get_fs()
    bch2_ro_ref_tryget() -> grabs bch_fs->ro_ref
    mutex_unlock(&bdev->bd_holder_lock);
					deactivate_super()
					  down_write(&sb->s_umount);
					  deactivate_locked_super()
					    bch2_kill_sb()
					      generic_shutdown_super()
					        bch2_put_super()
						  __bch2_fs_stop()
						    bch2_ro_ref_put()
						    wait_event(c->ro_ref_wait, !refcount_read(&c->ro_ref));
  sb = c->vfs_sb;
  down_read(&sb->s_umount); -> deadlock

Which is a case in point why I would like to have a shared infrastructure
for bdev -> sb transition that's used as widely as possible. Because it
isn't easy to get the lock ordering right given all the constraints in the
VFS and block layer code paths for this transition that's going contrary to
the usual ordering sb -> bdev. And yes I do realize bcachefs grabs s_umount
not because it itself needs it but because it calls some VFS helpers
(sync_filesystem()) which expect it to be held so the pain is inflicted
by VFS here but that just demostrates the fact that VFS and FS locking are
deeply intertwined and you can hardly avoid dealing with VFS locking rules
in the filesystem itself.

> It also avoids the problem of ->mark_dead events being generated
> from a context that holds filesystem/vfs locks and then deadlocking
> waiting for those locks to be released.
> 
> IOWs, a multi-device filesystem should really be implementing
> ->mark_dead itself, and should not be depending on being able to
> lock the superblock to take an active reference to it.
> 
> It should be pretty clear that these are not issues that the generic
> filesystem ->mark_dead implementation should be trying to
> handle.....

Well, IMO every fs implementation needs to do the bdev -> sb transition and
make sb somehow stable. It may be that grabbing s_umount and active sb
reference is not what everybody wants but AFAIU btrfs as the second
multi-device filesystem would be fine with that and for bcachefs this
doesn't work only because they have special superblock instantiation
behavior on mount for independent reasons (i.e., not because active ref
+ s_umount would be problematic for them) if I understand Kent right.
So I'm still not fully convinced each multi-device filesystem should be
shipping their special method to get from device to stable sb reference.

> > The shutdown method is implemented only by block-based filesystems and
> > arguably shutdown was always a misnomer because it assumed that the
> > filesystem needs to actually shut down when it is called.
> 
> Shutdown was not -assumed- as the operation that needed to be
> performed. That was the feature that was *required* to fix
> filesystem level problems that occur when the device underneath it
> disappears.
> 
> ->mark_dead() is the abstract filesystem notification from the block
> device, fs_bdfev_mark_dead() is the -generic implementation- of the
> functionality required by single block device filesystems. Part of
> that functionality is shutting down the filesystem because it can
> *no longer function without a backing device*.
> 
> multi-block device filesystems require compeltely different
> implementations, and we already have one that -does not use active
> superblock references-. IOWs, even if we add ->remove_bdev(sb)
> callout, bcachefs will continue to use ->mark_dead() because low
> level filesystem device management isn't (and shouldn't be!)
> dependent on high level VFS structure reference counting....

I have to admit I don't get why device management shouldn't be dependent on
VFS refcounts / locking. IMO it is often dependent although I agree with
multiple devices you likely have to do *additional* locking. And yes, I can
imagine VFS locking could get in your way but the only tangible example we
have is bcachefs and btrfs seems to be a counter example showing even multi
device filesystem can live with VFS locking. So I don't think the case is
as clear as you try to frame it.

So conceptually I agree making filesystems as bdev holders implement their
own holder ops makes a lot of sense but because of lock ordering rules it
is not quite practical or easily maintainable choice I'm afraid.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

