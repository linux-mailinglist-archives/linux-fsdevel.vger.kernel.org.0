Return-Path: <linux-fsdevel+bounces-61723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF7B59534
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B22A1BC80BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC502F6587;
	Tue, 16 Sep 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+KteQDS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2HYnNweU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C2YrNbPC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P80PGseX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510F2E8B86
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022258; cv=none; b=kMesvAE53Ke58vhQT1BPxyuFwAwghC2j0bIEiN0W0Mxia9LRCsA31VOT6dEShVAi8cnI4HufQ5wqOQbtXJaimTpOU/nkn5H5PiLOcvhZsZzkEqyfsGBQyaBDpH8jDY4bvxHRcjsOdxaYsZWSC54X96PZECcyX4nBDAE1g2GSYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022258; c=relaxed/simple;
	bh=32dkxhu6HAIEJvzNQhoowNml5eGueKq/8PzdYr2S9Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmTv79+y9Jtp+iRjeQAlWRtFp8ziJdOzhmy8NhxzhFV5s8oD/QCijcL45BLcDVv1TKHtG9tk958rsSc+Pw/6a7PqBr5D4wlLJuQ7XDxRph9gO8eL5m9e0XxVaF/kYu+asnQ3xepJo3iL2uoDj9n3aB3GMxMnPMLCctN3Rc8rE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+KteQDS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2HYnNweU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C2YrNbPC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P80PGseX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D156F1F7E7;
	Tue, 16 Sep 2025 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758022255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZi2f1CBEBptehyfy3qkarMRPDwbc/rWar+FgCxqvMQ=;
	b=K+KteQDSKf8IsG3uOwQ0HI3VKeMlPnxjvhs2zFYfvcYwqltHVn8uu3sCgCpQOCqGx2JD3y
	/Ltr8/4XZ4Y9a0HlQ2S6qIrYOwZPHu8JIhpT1Jy2pZV4kO3hbPwBYqIzmw9qm2KeMIKTcW
	hebhRV64eWqTWEkKmUUH1DE0fmq5lQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758022255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZi2f1CBEBptehyfy3qkarMRPDwbc/rWar+FgCxqvMQ=;
	b=2HYnNweUFk8LZUijfjj6klmqAUE83RkQVtUmRo6YqCRwEuht8dBdu0cgI+fABbhT64WKKg
	HpkgcGkBKY6o0dAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758022254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZi2f1CBEBptehyfy3qkarMRPDwbc/rWar+FgCxqvMQ=;
	b=C2YrNbPCJgZVyvW01AxrfbMoCsRKcx0pG8PXSk0T2Y+lco6umc5acktS/zGE647YMOK/CV
	mVblxMVniZzoxwEBtgrC/uSijzWfboIsvTYnr81nezJniQv46tdS/K4zQEwMLOeDf0bArb
	qJp9j+HM/sxJ9zefrGHbin+n4ApImXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758022254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZi2f1CBEBptehyfy3qkarMRPDwbc/rWar+FgCxqvMQ=;
	b=P80PGseXB7KGB2c7EEkrdGLUPK7RjxJlT4t5M2QwTES4YV8Fci5Uwq2UJKvnEXDxP+whSR
	dY9DgOpCgOGj6eDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6FDA13ACD;
	Tue, 16 Sep 2025 11:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zw2TMG5KyWg/ZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Sep 2025 11:30:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A962A0A56; Tue, 16 Sep 2025 13:30:39 +0200 (CEST)
Date: Tue, 16 Sep 2025 13:30:39 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jakub Acs <acsjakub@amazon.de>, 
	linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
Message-ID: <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
References: <20250915101510.7994-1-acsjakub@amazon.de>
 <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
 <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
 <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon 15-09-25 17:29:40, Amir Goldstein wrote:
> On Mon, Sep 15, 2025 at 4:07 PM Jan Kara <jack@suse.cz> wrote:
> > > > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > > > index 83f80fdb1567..424c73188e06 100644
> > > > --- a/fs/overlayfs/export.c
> > > > +++ b/fs/overlayfs/export.c
> > > > @@ -195,6 +195,8 @@ static int ovl_check_encode_origin(struct inode *inode)
> > > >         if (!ovl_inode_lower(inode))
> > > >                 return 0;
> > > >
> > > > +       if (!inode->i_sb->s_root)
> > > > +               return -ENOENT;
> > >
> > > For a filesystem method to have to check that its own root is still alive sounds
> > > like the wrong way to me.
> > > That's one of the things that should be taken for granted by fs code.
> > >
> > > I don't think this is an overlayfs specific issue, because other fs would be
> > > happy if encode_fh() would be called with NULL sb->s_root.
> >
> > Actually, I don't see where that would blow up? Generally references to
> > sb->s_root in filesystems outside of mount / remount code are pretty rare.
> > Also most of the code should be unreachable by the time we set sb->s_root
> > to NULL because there are no open files at that moment, no exports etc. But
> > as this report shows, there are occasional surprises (I remember similar
> > issue with ext4 sysfs files handlers using s_root without checking couple
> > years back).
> >
> 
> I am not sure that I understand what you are arguing for.
> I did a very naive grep s_root fs/*/export.c and quickly found:

You're better with grep than me ;). I was grepping for '->s_root' as well
but all the hits I had looked into were related to mounting and similar and
eventually I got bored. Restricting the grep to export ops indeed shows
ceph, gfs2 and overlayfs are vulnerable to this kind of problem.

> static int gfs2_encode_fh(struct inode *inode, __u32 *p, int *len,
>                           struct inode *parent)
> {
> ...
>         if (!parent || inode == d_inode(sb->s_root))
>                 return *len;
> 
> So it's not an overlayfs specific issue, just so happens that zysbot
> likes to test overlayfs.
> 
> Are you suggesting that we fix all of those one by one?

No. I agree we need to figure out a way to make sure export ops are not
called on a filesystem being unmounted. Standard open_by_handle() or NFS
export cannot race with generic_shutdown_super() (they hold the fs mounted)
so fsnotify is a special case here.

I actually wonder if fanotify event (e.g. from inode deletion postponed to
some workqueue or whatever) cannot race with umount as well and cause the
same problem...

> > > Can we change the order of generic_shutdown_super() so that
> > > fsnotify_sb_delete(sb) is called before setting s_root to NULL?
> > >
> > > Or is there a better solution for this race?
> >
> > Regarding calling fsnotify_sb_delete() before setting s_root to NULL:
> > In 2019 (commit 1edc8eb2e9313 ("fs: call fsnotify_sb_delete after
> > evict_inodes")) we've moved the call after evict_inodes() because otherwise
> > we were just wasting cycles scanning many inodes without watches. So moving
> > it earlier wouldn't be great...
> 
> Yes, I noticed that and I figured there were subtleties.

Right. After thinking more about it I think calling fsnotify_sb_delete()
earlier is the only practical choice we have (not clearing sb->s_root isn't
much of an option - we need to prune all dentries to quiesce the filesystem
and leaving s_root alive would create odd corner cases). But you don't want
to be iterating millions of inodes just to clear couple of marks so we'll
have to figure out something more clever there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

