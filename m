Return-Path: <linux-fsdevel+bounces-61415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D819EB57E65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE3E1894F95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9D931280F;
	Mon, 15 Sep 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D8tfyCfQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9dxU6T2y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ksaiJwzB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UpYpUxCm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF030E0D1
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945244; cv=none; b=Nau9gBDcS24x4TKIUUCjKAZHZL7WG5z3tKkWFFAKhVa8EpkUU1sjiMgx1FJQxH5RrLF6eY+2NOuYIbTrJOYkJhmwT+3CTR8RiQAndH2btEOZoLDcX6+EzN/4eHGZj0nkPqm76eLg8eo90CevywlgvQmNE3xvQ39ktzxQ+hWVMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945244; c=relaxed/simple;
	bh=gfRX9X/1aXyIhSeFPKrPTBcy4cWXlvncvUNvofMbX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRxkXTfHlbIroDBUcjZkjqaS8XyfkYPo2Y9CF0TfPZPyBJ8DUQ5r7SyCwOL3nUIXPc/UjoTgbxINFGjnOvNrJstJyWkwzbG/Jn053q2AhCbqs9kIc+6GT/hBgSPqDPmOrMov1QcXKnlCr7MmVdU6X6pw7+WZoV9zBS4aK+fQChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D8tfyCfQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9dxU6T2y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ksaiJwzB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UpYpUxCm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1DD91FB3B;
	Mon, 15 Sep 2025 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757945241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeFwMh9UwQSuEr83cM3Kb6c9zmrNoDYzIWwjnIlsPAU=;
	b=D8tfyCfQ1SwKRPN5mRs1h3vsgG8uRfhRU6DsoFb3XKs8b2/zHngcRCh853QDmMD85hHzou
	CTU4np0H+v0PkWndKvlBOUCQDmqFQmTlDqURUP5K5Vwatz1d3MN0nIzAYygE3Z5ehfunzV
	JUV2ItM3o/nmbFLutVpEQI6bEvIoXpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757945241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeFwMh9UwQSuEr83cM3Kb6c9zmrNoDYzIWwjnIlsPAU=;
	b=9dxU6T2yL5um/gdbL6topY9yETfgqyl80sqsnAjcHoiuuvtjcZiuMjBX2pApznWUOuGEEj
	f2+MOpDm2S3VscBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ksaiJwzB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UpYpUxCm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757945240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeFwMh9UwQSuEr83cM3Kb6c9zmrNoDYzIWwjnIlsPAU=;
	b=ksaiJwzBsh8NCVShPSkauS+xw0TEDnUIYtU2Ox7HRUDluqGc7/v5YCUCGfxMPt4GpD89pr
	uxWBc4hJXMnS7sOjihXS8E4UiKSB3+JhN7+4IUVFLAre1DzAzgTYI+Muj94qQ9T8TA32r3
	iAWA+e3RqH1FxvR1GttwYG7ST156GWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757945240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeFwMh9UwQSuEr83cM3Kb6c9zmrNoDYzIWwjnIlsPAU=;
	b=UpYpUxCmlp15C2/gd/W36MqXK3ilQGIQwai2bcfk2cfTFzReXu17sMjsCA448jANXJ2Dr+
	f9pOLlYzSAENRBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDFCC1368D;
	Mon, 15 Sep 2025 14:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oMn6MZgdyGg1WgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 14:07:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 63FA1A0A06; Mon, 15 Sep 2025 16:07:15 +0200 (CEST)
Date: Mon, 15 Sep 2025 16:07:15 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jakub Acs <acsjakub@amazon.de>, Jan Kara <jack@suse.cz>, 
	linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
Message-ID: <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
References: <20250915101510.7994-1-acsjakub@amazon.de>
 <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E1DD91FB3B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Mon 15-09-25 15:01:13, Amir Goldstein wrote:
> On Mon, Sep 15, 2025 at 12:15 PM Jakub Acs <acsjakub@amazon.de> wrote:
> >
> > Calling intotify_show_fdinfo() on fd watching an overlayfs inode, while
> > the overlayfs is being unmounted, can lead to dereferencing NULL ptr.
> >
> > This issue was found by syzkaller.
> >
> > Race Condition Diagram:
> >
> > Thread 1                           Thread 2
> > --------                           --------
> >
> > generic_shutdown_super()
> >  shrink_dcache_for_umount
> >   sb->s_root = NULL
> >
> >                     |
> >                     |             vfs_read()
> >                     |              inotify_fdinfo()
> >                     |               * inode get from mark *
> >                     |               show_mark_fhandle(m, inode)
> >                     |                exportfs_encode_fid(inode, ..)
> >                     |                 ovl_encode_fh(inode, ..)
> >                     |                  ovl_check_encode_origin(inode)
> >                     |                   * deref i_sb->s_root *
> >                     |
> >                     |
> >                     v
> >  fsnotify_sb_delete(sb)
> >
> > Which then leads to:
> >
> > [   32.133461] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> > [   32.134438] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> > [   32.135032] CPU: 1 UID: 0 PID: 4468 Comm: systemd-coredum Not tainted 6.17.0-rc6 #22 PREEMPT(none)
> >
> > <snip registers, unreliable trace>
> >
> > [   32.143353] Call Trace:
> > [   32.143732]  ovl_encode_fh+0xd5/0x170
> > [   32.144031]  exportfs_encode_inode_fh+0x12f/0x300
> > [   32.144425]  show_mark_fhandle+0xbe/0x1f0
> > [   32.145805]  inotify_fdinfo+0x226/0x2d0
> > [   32.146442]  inotify_show_fdinfo+0x1c5/0x350
> > [   32.147168]  seq_show+0x530/0x6f0
> > [   32.147449]  seq_read_iter+0x503/0x12a0
> > [   32.148419]  seq_read+0x31f/0x410
> > [   32.150714]  vfs_read+0x1f0/0x9e0
> > [   32.152297]  ksys_read+0x125/0x240
> >
> > IOW ovl_check_encode_origin derefs inode->i_sb->s_root, after it was set
> > to NULL in the unmount path.
> >
> > Minimize the window of opportunity by adding explicit check.
> >
> > Fixes: c45beebfde34 ("ovl: support encoding fid from inode with no alias")
> > Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > ---
> >
> > I'm happy to take suggestions for a better fix - I looked at taking
> > s_umount for reading, but it wasn't clear to me for how long would the
> > fdinfo path need to hold it. Hence the most primitive suggestion in this
> > v1.
> >
> > I'm also not sure if ENOENT or EBUSY is better?.. or even something else?
> >
> >  fs/overlayfs/export.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index 83f80fdb1567..424c73188e06 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -195,6 +195,8 @@ static int ovl_check_encode_origin(struct inode *inode)
> >         if (!ovl_inode_lower(inode))
> >                 return 0;
> >
> > +       if (!inode->i_sb->s_root)
> > +               return -ENOENT;
> 
> For a filesystem method to have to check that its own root is still alive sounds
> like the wrong way to me.
> That's one of the things that should be taken for granted by fs code.
> 
> I don't think this is an overlayfs specific issue, because other fs would be
> happy if encode_fh() would be called with NULL sb->s_root.

Actually, I don't see where that would blow up? Generally references to
sb->s_root in filesystems outside of mount / remount code are pretty rare.
Also most of the code should be unreachable by the time we set sb->s_root
to NULL because there are no open files at that moment, no exports etc. But
as this report shows, there are occasional surprises (I remember similar
issue with ext4 sysfs files handlers using s_root without checking couple
years back).

> Jan,
> 
> Can we change the order of generic_shutdown_super() so that
> fsnotify_sb_delete(sb) is called before setting s_root to NULL?
> 
> Or is there a better solution for this race?

Regarding calling fsnotify_sb_delete() before setting s_root to NULL:
In 2019 (commit 1edc8eb2e9313 ("fs: call fsnotify_sb_delete after
evict_inodes")) we've moved the call after evict_inodes() because otherwise
we were just wasting cycles scanning many inodes without watches. So moving
it earlier wouldn't be great...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

