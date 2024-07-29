Return-Path: <linux-fsdevel+bounces-24447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B4193F6A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9001DB21092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C31494BF;
	Mon, 29 Jul 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GOg+Kqte";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mssZc+dW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuU2gCVp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7ekSSZDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B83C24;
	Mon, 29 Jul 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259645; cv=none; b=GaiqhnQYHl/i8lYpUsdcOdQGvqEgWYRxDs+EqTZjEZjQDPWcY+MBCT6RXS7ZRWegxg7kV7HWvbDVSBW/VS6wAoLlx7AWntj7wzFoKNs/LBkyVCCSfWidc3LWCD+h7oRU9gj3JuAgAqdMV+TQlOIL6dG/hukyUKFpHD2x39U22PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259645; c=relaxed/simple;
	bh=Vd5C2W9GOGnPSed/7HofTczD7Y4FK7ENJ3bLnDQRJ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azFw2VOCx5XhQtyN6yHEDp4QtGyKZBPG9dA43XLhszumptP1vs52HN96ZgX49WaOkfhEZav1ULm1v1lqo7oZVs+lLEe6ROoB7J9KBmEmAzmGik7frpGk/yFu+65JRLk/6mtpIsOYufMu/xlFlo7y0qXpvCocKX2KP4HKImrWrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GOg+Kqte; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mssZc+dW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuU2gCVp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7ekSSZDj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E067F21ABC;
	Mon, 29 Jul 2024 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722259642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cA0sKnmcbKHN+5poM2Gwzel0FDApKbV56UYCatcL7bE=;
	b=GOg+KqteQTiABuMLkONHkkQqDi9CWNISiA42PWBd6tBN1LrzZHYSnJIOgfjuI/F4BrAnu4
	PmOZ6aoddmjs4bM27zUbbRtFpHUHn5cMq9uhCSm65Dwsk0ZvsFi+Eev1dq/rmYXlIg9Dvo
	dKrcoDP66XZMp72xHlxRJ5a2eCGTIyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722259642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cA0sKnmcbKHN+5poM2Gwzel0FDApKbV56UYCatcL7bE=;
	b=mssZc+dWsaDWX6G1Z81Z9mVnCMeQIKDBeeN8GeMNSfkrtAVFPI+0ZsaokUtTgcYSe+PPlR
	VfWK/UPBgxDAnyAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722259641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cA0sKnmcbKHN+5poM2Gwzel0FDApKbV56UYCatcL7bE=;
	b=WuU2gCVpi0VpfhEjlPLAEf8P1ZNDFqSTQUD2Msx0Rz9cU/3rWE6Sm086IHeXzTyLdOi6Oi
	ZxJkmkvR/KeysUT+IF5bJa7yRxNOWjnYwnoCxHI1mqdB8iSMRG5Pg6px732y/ihU0sv1Zl
	kWBur90hgwyvMSgEdnPZ9j8AOa2iAUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722259641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cA0sKnmcbKHN+5poM2Gwzel0FDApKbV56UYCatcL7bE=;
	b=7ekSSZDjkiW5NnN+2hwFDBVRJDLREXGvb8S7MhyadF1e1L/sESkskvzc/MxkGKv5ZEQoir
	iJv7SHaOYS0o5mBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D453D1368A;
	Mon, 29 Jul 2024 13:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QJPTM7mYp2aIVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Jul 2024 13:27:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79BC1A099C; Mon, 29 Jul 2024 15:27:21 +0200 (CEST)
Date: Mon, 29 Jul 2024 15:27:21 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>,
	paulmck@kernel.org, Hillf Danton <hdanton@sina.com>,
	rcu@vger.kernel.org, frank.li@vivo.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	Ted Tso <tytso@mit.edu>
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
Message-ID: <20240729132721.hxih6ehigadqf7wx@quack3>
References: <0000000000004ff2dc061e281637@google.com>
 <20240729-himbeeren-funknetz-96e62f9c7aee@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-himbeeren-funknetz-96e62f9c7aee@brauner>
X-Spam-Level: *
X-Spamd-Result: default: False [1.90 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[20d7e439f76bbbd863a7];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,lists.sourceforge.net,syzkaller.appspotmail.com,redhat.com,gmail.com,sina.com,vger.kernel.org,vivo.com,suse.cz,googlegroups.com,zeniv.linux.org.uk,mit.edu];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 1.90

On Mon 29-07-24 11:10:09, Christian Brauner wrote:
> On Fri, Jul 26, 2024 at 08:23:02AM GMT, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit b62e71be2110d8b52bf5faf3c3ed7ca1a0c113a5
> > Author: Chao Yu <chao@kernel.org>
> > Date:   Sun Apr 23 15:49:15 2023 +0000
> > 
> >     f2fs: support errors=remount-ro|continue|panic mountoption
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119745f1980000
> > start commit:   1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=139745f1980000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=159745f1980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1237a1f1980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115edac9980000
> > 
> > Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
> > Fixes: b62e71be2110 ("f2fs: support errors=remount-ro|continue|panic mountoption")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Thanks to Paul and Oleg for point me in the right direction and
> explaining that rcu sync warning.
> 
> That patch here is remounting a superblock read-only directly by raising
> SB_RDONLY without the involvement of the VFS at all. That's pretty
> broken and is likely to cause trouble if done wrong. The rough order of
> operations to transition rw->ro usualy include checking that the
> filsystem is unfrozen, and marking all mounts read-only, then calling
> into the filesystem so it can do whatever it wants to do.

Yeah, this way of handling filesystem errors dates back to days when the
world was much simpler :) It has been always a bit of a hack (but when you
try to limit damage from corrupted on-disk data structures, a bit of
hackiness is acceptable) but it is doubly so these days.

> In any case, all of this requires holding sb->s_umount. Not holding
> sb->s_umount will end up confusing freeze_super() (Thanks to Oleg for
> noticing!). When freeze_super() is called on a non-ro filesystem it will
> acquire
> percpu_down_write(SB_FREEZE_WRITE+SB_FREEZE_PAGEFAULT+SB_FREEZE_FS) and
> thaw_super() needs to call
> sb_freeze_unlock(SB_FREEZE_FS+SB_FREEZE_PAGEFAULT+SB_FREEZE_WRITE) but
> because you just raise SB_RDONLY you end up causing thaw_super() to skip
> that step causing the bug in rcu_sync_dtor() to be noticed.

Yeah, good spotting.

> Btw, ext4 has similar logic where it raises SB_RDONLY without checking
> whether the filesystem is frozen.
> 
> So I guess, this is technically ok as long as that emergency SB_RDONLY raising
> in sb->s_flags is not done while the fs is already frozen. I think ext4 can
> probably never do that. Jan?

You'd wish (or maybe I'd wish ;) No, ext4 can hit it in the same way f2fs
can. All it takes is for ext4 to hit some metadata corruption on read from
disk while the filesystem is frozen.

> My guess is that something in f2fs can end up raising SB_RDONLY after
> the filesystem is frozen and so it causes this bug. I suspect this is coming
> from the gc_thread() which might issue a f2fs_stop_checkpoint() while the fs is
> already about to be frozen but before the gc thread is stopped as part of the
> freeze.

So in ext4 we have EXT4_FLAGS_SHUTDOWN flag which we now use internally
instead of SB_RDONLY flag for checking whether the filesystem was shutdown
(because otherwise races between remount and hitting fs error were really
messy). However we still *also* set SB_RDONLY so that VFS bails early from
some paths which generally results in less error noise in kernel logs and
also out of caution of not breaking something in this path. That being said
we also support EXT4_IOC_SHUTDOWN ioctl for several years and in that path
we set EXT4_FLAGS_SHUTDOWN without setting SB_RDONLY and nothing seems to
have blown up. So I'm inclined to belive we could remove setting of
SB_RDONLY from ext4 error handling. Ted, what do you think?

Also as the "filesystem shutdown" is spreading across multiple filesystems,
I'm playing with the idea that maybe we could lift a flag like this to VFS
so that we can check it in VFS paths and abort some operations early.  But
so far I'm not convinced the gain is worth the need to iron out various
subtle semantical differences of "shutdown" among filesystems.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

