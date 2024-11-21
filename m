Return-Path: <linux-fsdevel+bounces-35396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4AB9D494D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6EC284383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F17E1CEAAF;
	Thu, 21 Nov 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uJ9rSuTw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tKV06pKx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uJ9rSuTw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tKV06pKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040B1CD1F3;
	Thu, 21 Nov 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179270; cv=none; b=DbobWVI8UTy73FAYC8Mtm6KkaVWLNEUzrtlAPZDovVmccsTCLmRggbFTALmYEaM6Tk84rFB/kZpP4H2eCxLUgs12P3AGj4OXJcnHTVl7T9416gxaBWm0Al0oS22TaEH05fp1E755YdbKspvhI9l/3i+b/BTuMRupEiMsovs/B4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179270; c=relaxed/simple;
	bh=TwzpGNcP8sBopTqZejLvIXwRObHW9PYvsMVU2F3rJu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2Cx/584YYMFTjsXLzYgzZ+Cw+aGLXSTBA/xNTLpIBICC4yZQgs+3X8Vc8uHtZXTcUV7BkG1CbM2RTpHcZ+JEr/qyQ2X4ZpmBMNlNWaz9hTjJIREhg3WWxdmdR5GqbBsqk70lQPditoojWvY/cvJQEIOBbfl2xZK3UJGjs5FV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uJ9rSuTw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tKV06pKx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uJ9rSuTw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tKV06pKx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78A88211BB;
	Thu, 21 Nov 2024 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732179265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9QDYFVgK18ikztR1aFCMrX/3aAhs0bWXjPhxnlRZtE=;
	b=uJ9rSuTwHq42Q9eV0Pm3KewVmcTElVkYABQedvIts4bOr9jE3bLJrPbvz8D5Rd72op769r
	D7hlLV2vCSExFT7xyg96dZnT7ugJoY+s2sae2a3czx8qSallOh1s+L6JdqkLWv5J/7yngC
	pJ4kj2KZPPBGrpJrFfgkxPnSCLc0t24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732179265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9QDYFVgK18ikztR1aFCMrX/3aAhs0bWXjPhxnlRZtE=;
	b=tKV06pKxDviRzPYcFgiT/BAb1ygh8vMnho6u2rZfPiQVKd8sSUv3Vw29/qRKVTtrUHuJJq
	kc+z72YKxb8ircAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uJ9rSuTw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tKV06pKx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732179265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9QDYFVgK18ikztR1aFCMrX/3aAhs0bWXjPhxnlRZtE=;
	b=uJ9rSuTwHq42Q9eV0Pm3KewVmcTElVkYABQedvIts4bOr9jE3bLJrPbvz8D5Rd72op769r
	D7hlLV2vCSExFT7xyg96dZnT7ugJoY+s2sae2a3czx8qSallOh1s+L6JdqkLWv5J/7yngC
	pJ4kj2KZPPBGrpJrFfgkxPnSCLc0t24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732179265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9QDYFVgK18ikztR1aFCMrX/3aAhs0bWXjPhxnlRZtE=;
	b=tKV06pKxDviRzPYcFgiT/BAb1ygh8vMnho6u2rZfPiQVKd8sSUv3Vw29/qRKVTtrUHuJJq
	kc+z72YKxb8ircAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59C57137CF;
	Thu, 21 Nov 2024 08:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VuebFUH1PmdBTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 08:54:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEDF3A089E; Thu, 21 Nov 2024 09:54:20 +0100 (CET)
Date: Thu, 21 Nov 2024 09:54:20 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 03/19] fsnotify: add helper to check if file is
 actually being watched
Message-ID: <20241121085420.lpsvkixshtuju23i@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <2ddcc9f8d1fde48d085318a6b5a889289d8871d8.1731684329.git.josef@toxicpanda.com>
 <20241120160247.sdvonyxkpmf4wnt2@quack3>
 <CAOQ4uxj4pwH2hfmNL0N=q8-rOF6d=-Z_yWLEwHQ671t1EvRn6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj4pwH2hfmNL0N=q8-rOF6d=-Z_yWLEwHQ671t1EvRn6A@mail.gmail.com>
X-Rspamd-Queue-Id: 78A88211BB
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 20-11-24 17:42:18, Amir Goldstein wrote:
> On Wed, Nov 20, 2024 at 5:02 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 15-11-24 10:30:16, Josef Bacik wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > So far, we set FMODE_NONOTIFY_ flags at open time if we know that there
> > > are no permission event watchers at all on the filesystem, but lack of
> > > FMODE_NONOTIFY_ flags does not mean that the file is actually watched.
> > >
> > > To make the flags more accurate we add a helper that checks if the
> > > file's inode, mount, sb or parent are being watched for a set of events.
> > >
> > > This is going to be used for setting FMODE_NONOTIFY_HSM only when the
> > > specific file is actually watched for pre-content events.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I did some changes here as well. See below:
> >
> > > -/* Are there any inode/mount/sb objects that are interested in this event? */
> > > -static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
> > > -                                        __u32 mask)
> > > +/* Are there any inode/mount/sb objects that watch for these events? */
> > > +static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
> > > +                                         __u32 events_mask)
> > >  {
> > >       __u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
> > >                          READ_ONCE(inode->i_sb->s_fsnotify_mask);
> > >
> > > -     return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
> > > +     return events_mask & marks_mask;
> > >  }
> > >
> > > +/* Are there any inode/mount/sb/parent objects that watch for these events? */
> > > +__u32 fsnotify_file_object_watched(struct file *file, __u32 events_mask)
> > > +{
> > > +     struct dentry *dentry = file->f_path.dentry;
> > > +     struct dentry *parent;
> > > +     __u32 marks_mask, mnt_mask =
> > > +             READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
> > > +
> > > +     marks_mask = fsnotify_object_watched(d_inode(dentry), mnt_mask,
> > > +                                          events_mask);
> > > +
> > > +     if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)))
> > > +             return marks_mask;
> > > +
> > > +     parent = dget_parent(dentry);
> > > +     marks_mask |= fsnotify_inode_watches_children(d_inode(parent));
> > > +     dput(parent);
> > > +
> > > +     return marks_mask & events_mask;
> > > +}
> > > +EXPORT_SYMBOL_GPL(fsnotify_file_object_watched);
> >
> > I find it confusing that fsnotify_object_watched() does not take parent
> > into account while fsnotify_file_object_watched() does. Furthermore the
> > naming doesn't very well reflect the fact we are actually returning a mask
> > of events. I've ended up dropping this helper (it's used in a single place
> > anyway) and instead doing the same directly in file_set_fsnotify_mode().
> >
> > @@ -658,6 +660,27 @@ void file_set_fsnotify_mode(struct file *file)
> >                 file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> >                 return;
> >         }
> > +
> > +       /*
> > +        * OK, there are some pre-content watchers. Check if anybody can be
> > +        * watching for pre-content events on *this* file.
> > +        */
> > +       mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
> > +       if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
> > +           !fsnotify_object_watched(d_inode(dentry), mnt_mask,
> > +                                    FSNOTIFY_PRE_CONTENT_EVENTS))) {
> > +               file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> > +               return;
> > +       }
> > +
> > +       /* Even parent is not watching for pre-content events on this file? */
> > +       parent = dget_parent(dentry);
> > +       p_mask = fsnotify_inode_watches_children(d_inode(parent));
> > +       dput(parent);
> > +       if (!(p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
> > +               file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> > +               return;
> > +       }
> >  }
> >
> 
> Nice!
> 
> Note that I had a "hidden motive" for future optimization when I changed
> return value of fsnotify_object_watched() to a mask -
> 
> I figured that while we are doing the checks above, we can check for the
> same price the mask ALL_FSNOTIFY_PERM_EVENTS
> then we get several answers for the same price:
> 1. Is the specific file watched by HSM?
> 2. Is the specific file watched by open permission events?
> 3. Is the specific file watched by post-open FAN_ACCESS_PERM?
> 
> If the answers are No, No, No, we get some extra optimization
> in the (uncommon) use case that there are permission event watchers
> on some random inodes in the filesystem.
> 
> If the answers are Yes, Yes, No, or No, Yes, No we can return a special
> value from file_set_fsnotify_mode() to indicate that permission events
> are needed ONLY for fsnotify_open_perm() hook, but not thereafter.
> 
> This would implement the semantic change of "respect FAN_ACCESS_PERM
> only if it existed at open time" that can save a lot of unneeded cycles in
> the very hot read/write path, for example, when watcher only cares about
> FAN_OPEN_EXEC_PERM.
> 
> I wasn't sure that any of this was worth the effort at this time, but
> just in case this gives you ideas of other useful optimizations we can do
> with the object combined marks_mask if we get it for free.

OK, I'm not opposed to returning the combined mask in principle. Just I'd
pick somewhat different function name and it didn't quite make sense to me
in the context of this series. If we decide to implement the optimizations
you describe above, then I have no problem with tweaking the helpers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

