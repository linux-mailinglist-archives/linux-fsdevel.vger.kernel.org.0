Return-Path: <linux-fsdevel+bounces-30996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E39990621
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05A41F2345A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE192178EE;
	Fri,  4 Oct 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GA8Y0S03";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="STpRqHtY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GA8Y0S03";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="STpRqHtY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1F7E59A;
	Fri,  4 Oct 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052328; cv=none; b=Mj+ox94rh6bp3D9tHVz0sXTnG0g0qKzAeX/qIffIE+xJRCMFAH483Zv59Ou0yHM9g72mjqV3Cc97M7dl3CJFO5yh0hkBvrFPuBOfuY35DQO3Xiv+F4pYV0Lqkq7hUXYGTTBOnX3lnxazwFOMn+AMA5BuKlQgKPYLvWwd5aCgBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052328; c=relaxed/simple;
	bh=P7d+ajJbfj3Nx30GJ0yVIrrequybML/qpR03+fYZ3Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/KLnJDv94ps/GhPudcHCljHeLAJIrU6LuRl9n4vsNcj9pFpfgTfdgtEYVmti5KP389SA8Ye2J/jnrtwU2sjJZ5Mhk2xpRKTvbwi/AIcCE89SO6MxkZ4HvvUlM15Xt6JJRjE3DO5U3XwWtDztG2rPvh636ij7YYvbfTg2vhIkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GA8Y0S03; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=STpRqHtY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GA8Y0S03; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=STpRqHtY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A317C1FD87;
	Fri,  4 Oct 2024 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728052324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Rhux+R3mY2kPLt5yr85/QSxonjAVE+LGpExp6//qvM=;
	b=GA8Y0S03IDFFoWHK43FlATEuokqFucBCb4DUbqwUXy2Wj9x/MPXVjY9QGKg58DKotm4Azx
	eoN5a0CZqHcMCpuSvvbHw34OcaOdwzOIKlsrtQddUmX0zdenoi19hG3WGUI3/WQETB6LPR
	hvWAr4k2fBZP13t62TOtXJlEeTAx1UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728052324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Rhux+R3mY2kPLt5yr85/QSxonjAVE+LGpExp6//qvM=;
	b=STpRqHtYXRnmbKTzEYPQRtlUkKijj1+UcWyQ1zNBPANAxg7mkYdlYCIfUuIAB2K/hruISN
	lz8GGOCuDywJA2DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GA8Y0S03;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=STpRqHtY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728052324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Rhux+R3mY2kPLt5yr85/QSxonjAVE+LGpExp6//qvM=;
	b=GA8Y0S03IDFFoWHK43FlATEuokqFucBCb4DUbqwUXy2Wj9x/MPXVjY9QGKg58DKotm4Azx
	eoN5a0CZqHcMCpuSvvbHw34OcaOdwzOIKlsrtQddUmX0zdenoi19hG3WGUI3/WQETB6LPR
	hvWAr4k2fBZP13t62TOtXJlEeTAx1UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728052324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Rhux+R3mY2kPLt5yr85/QSxonjAVE+LGpExp6//qvM=;
	b=STpRqHtYXRnmbKTzEYPQRtlUkKijj1+UcWyQ1zNBPANAxg7mkYdlYCIfUuIAB2K/hruISN
	lz8GGOCuDywJA2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D0BE13A6E;
	Fri,  4 Oct 2024 14:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9JRqImT8/2ataQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Oct 2024 14:32:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3C01EA0877; Fri,  4 Oct 2024 16:31:56 +0200 (CEST)
Date: Fri, 4 Oct 2024 16:31:56 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Stancek <jstancek@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	ltp@lists.linux.it, Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <20241004143156.6ihj64d2vj6nqt3n@quack3>
References: <20240805201241.27286-1-jack@suse.cz>
 <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3>
 <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
 <CAASaF6yASRgEKfhAVktFit31Yw5e9gwMD0jupchD0gWK9EppTw@mail.gmail.com>
 <CAOQ4uxjmtv88xoH0-s6D9WzRXv_stMsWB5+x2FMbdjCHyy1rmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjmtv88xoH0-s6D9WzRXv_stMsWB5+x2FMbdjCHyy1rmA@mail.gmail.com>
X-Rspamd-Queue-Id: A317C1FD87
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 04-10-24 15:28:12, Amir Goldstein wrote:
> On Fri, Oct 4, 2024 at 2:50 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > On Fri, Oct 4, 2024 at 2:32 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Mon, Sep 30, 2024 at 1:34 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Mon 30-09-24 12:15:11, Jan Stancek wrote:
> > > > > On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
> > > > > > When the filesystem is mounted with errors=remount-ro, we were setting
> > > > > > SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> > > > > > proper locking (sb->s_umount) and does not go through proper filesystem
> > > > > > remount procedure but it has been the way this worked since early ext2
> > > > > > days and it was good enough for catastrophic situation damage
> > > > > > mitigation. Recently, syzbot has found a way (see link) to trigger
> > > > > > warnings in filesystem freezing because the code got confused by
> > > > > > SB_RDONLY changing under its hands. Since these days we set
> > > > > > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > > > > > filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> > > > > > stop doing that.
> > > > > >
> > > > > > Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
> > > > > > Reported-by: Christian Brauner <brauner@kernel.org>
> > > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > > ---
> > > > > > fs/ext4/super.c | 9 +++++----
> > > > > > 1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > Note that this patch introduces fstests failure with generic/459 test because
> > > > > > it assumes that either freezing succeeds or 'ro' is among mount options. But
> > > > > > we fail the freeze with EFSCORRUPTED. This needs fixing in the test but at this
> > > > > > point I'm not sure how exactly.
> > > > > >
> > > > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > > > index e72145c4ae5a..93c016b186c0 100644
> > > > > > --- a/fs/ext4/super.c
> > > > > > +++ b/fs/ext4/super.c
> > > > > > @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> > > > > >
> > > > > >     ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> > > > > >     /*
> > > > > > -    * Make sure updated value of ->s_mount_flags will be visible before
> > > > > > -    * ->s_flags update
> > > > > > +    * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> > > > > > +    * modifications. We don't set SB_RDONLY because that requires
> > > > > > +    * sb->s_umount semaphore and setting it without proper remount
> > > > > > +    * procedure is confusing code such as freeze_super() leading to
> > > > > > +    * deadlocks and other problems.
> > > > > >      */
> > > > > > -   smp_wmb();
> > > > > > -   sb->s_flags |= SB_RDONLY;
> > > > >
> > > > > Hi,
> > > > >
> > > > > shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the case
> > > > > when user triggers the abort with mount(.., "abort")? Because now we seem
> > > > > to always hit the condition that returns EROFS to user-space.
> > > >
> > > > Thanks for report! I agree returning EROFS from the mount although
> > > > 'aborting' succeeded is confusing and is mostly an unintended side effect
> > > > that after aborting the fs further changes to mount state are forbidden but
> > > > the testcase additionally wants to remount the fs read-only.
> > >
> > > Regardless of what is right or wrong to do in ext4, I don't think that the test
> > > really cares about remount read-only.
> > > I don't see anything in the test that requires it. Gabriel?
> > > If I remove MS_RDONLY from the test it works just fine.
> > >
> > > Any objection for LTP maintainers to apply this simple test fix?
> >
> > Does that change work for you on older kernels? On 6.11 I get EROFS:
> >
> > fanotify22.c:59: TINFO: Mounting /dev/loop0 to
> > /tmp/LTP_fangb5wuO/test_mnt fstyp=ext4 flags=20
> > fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 32,
> > 0x4211ed) failed: EROFS (30)
> >
> 
> Yeh me too, but if you change s/SAFE_MOUNT/mount
> the test works just fine on 6.11 and 6.12-rc1 with or without MS_RDONLY.
> The point of trigger_fs_abort() is to trigger the FS_ERROR event and it
> does not matter whether remount succeeds or not for that matter at all.

Well, the handling of 'abort' option is suboptimal. It gets acted on in the
middle of the remount process so some mount options get applied before it (and can
fail with error which would make 'abort' ignored), some get applied after
it which can fail because the fs is already shutdown.

> So you can either ignore the return value of mount() or assert that it
> can either succeed or get EROFS for catching unexpected errors.

Either that or I'm currently testing ext4 fix which will make 'abort'
handling more consistent.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

