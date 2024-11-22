Return-Path: <linux-fsdevel+bounces-35557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3ED9D5D8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11C7B2232C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651D51DE2C8;
	Fri, 22 Nov 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RZ0L1i7e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TNGbOB3m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RZ0L1i7e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TNGbOB3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A010A3E;
	Fri, 22 Nov 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273098; cv=none; b=nPpFGDMHQl9BnHKQB3G+CCkC2sVeBuWg5LQynLpRWL22qQzRmHl7/eWAxarlCEXK7xmf3zgvfOrPWPcIGPCX4nZkzpNYanBNqGcdzIeDDQOa5JmRsjprtwkPLC6kcXVuUnYq/0HVuMYi+1KBU9qBJoyyWN43QPFlqxZUXi6rAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273098; c=relaxed/simple;
	bh=lTuCtdw1yZtVO4Upq+2VwYGHbXvp2pZDxQDnF4PHODw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5+Mf7WsNNdGZ+ku7E3AiNwsT91PMhtlkM18q36oW2SkUtvfi3Jm1pkB0D9h/B9hqFBnCh66iBWF8WYB5M3Ws0vLydUuApR/MOhfFq6aiLetsiUA/lSBv0af3FxlT3tyPIpQGUYGOBEl64FZKBX2OEOJvpcAhu/eQsPu/LdSDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RZ0L1i7e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TNGbOB3m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RZ0L1i7e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TNGbOB3m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 415BB211D2;
	Fri, 22 Nov 2024 10:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732273094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmbcIvy8dk8n1UWk8qSIeva1r4pMaVsO6qmP96YgMgg=;
	b=RZ0L1i7e0ckTJakRHfvHzxZWH/peqTawvLvG5xCbMkloqm5N5l+7GLrDm3u1/z22FHqulA
	NhDkn1+wmKRgE/UU7AF3GU4rDGIip64wpS17ix4srUTl8j4MBIzoM6hAbd8uuekkec7Dzr
	0SzjITc3Wxv01r8GOZOkviT6naThMFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732273094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmbcIvy8dk8n1UWk8qSIeva1r4pMaVsO6qmP96YgMgg=;
	b=TNGbOB3mQoHcZDt7OMh1ZkFl00ptwMQEljqrqOQGEFjKyl3MWGZEBEBFl2IdZFDSWEAt1b
	mw5WAf2/9+T/uXCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RZ0L1i7e;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TNGbOB3m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732273094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmbcIvy8dk8n1UWk8qSIeva1r4pMaVsO6qmP96YgMgg=;
	b=RZ0L1i7e0ckTJakRHfvHzxZWH/peqTawvLvG5xCbMkloqm5N5l+7GLrDm3u1/z22FHqulA
	NhDkn1+wmKRgE/UU7AF3GU4rDGIip64wpS17ix4srUTl8j4MBIzoM6hAbd8uuekkec7Dzr
	0SzjITc3Wxv01r8GOZOkviT6naThMFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732273094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmbcIvy8dk8n1UWk8qSIeva1r4pMaVsO6qmP96YgMgg=;
	b=TNGbOB3mQoHcZDt7OMh1ZkFl00ptwMQEljqrqOQGEFjKyl3MWGZEBEBFl2IdZFDSWEAt1b
	mw5WAf2/9+T/uXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 358A8138A7;
	Fri, 22 Nov 2024 10:58:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0YYNDcVjQGcCKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Nov 2024 10:58:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D30A8A08B8; Fri, 22 Nov 2024 11:58:07 +0100 (CET)
Date: Fri, 22 Nov 2024 11:58:07 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 03/19] fsnotify: check if file is actually being watched
 for pre-content events on open
Message-ID: <20241122105807.svnmrwc3db3jqa5s@quack3>
References: <20241121112218.8249-1-jack@suse.cz>
 <20241121112218.8249-4-jack@suse.cz>
 <CAOQ4uxgJiiv2KrEkxwND9zpwYLakAMPX_UruGC_6Zrd5ep7duw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgJiiv2KrEkxwND9zpwYLakAMPX_UruGC_6Zrd5ep7duw@mail.gmail.com>
X-Rspamd-Queue-Id: 415BB211D2
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
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 21-11-24 17:01:13, Amir Goldstein wrote:
> On Thu, Nov 21, 2024 at 12:22 PM Jan Kara <jack@suse.cz> wrote:
> >
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > So far, we set FMODE_NONOTIFY_ flags at open time if we know that there
> > are no permission event watchers at all on the filesystem, but lack of
> > FMODE_NONOTIFY_ flags does not mean that the file is actually watched.
> >
> > For pre-content events, it is possible to optimize things so that we
> > don't bother trying to send pre-content events if file was not watched
> > (through sb, mnt, parent or inode itself) on open. Set FMODE_NONOTIFY_
> > flags according to that.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Link: https://patch.msgid.link/2ddcc9f8d1fde48d085318a6b5a889289d8871d8.1731684329.git.josef@toxicpanda.com
> > ---
> >  fs/notify/fsnotify.c             | 27 +++++++++++++++++++++++++--
> >  include/linux/fsnotify_backend.h |  3 +++
> >  2 files changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 569ec356e4ce..dd1dffd89fd6 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -193,7 +193,7 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
> >         return mask & marks_mask;
> >  }
> >
> > -/* Are there any inode/mount/sb objects that are interested in this event? */
> > +/* Are there any inode/mount/sb objects that watch for these events? */
> >  static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
> >                                            __u32 mask)
> >  {
> > @@ -632,7 +632,9 @@ EXPORT_SYMBOL_GPL(fsnotify);
> >   */
> >  void file_set_fsnotify_mode(struct file *file)
> >  {
> > -       struct super_block *sb = file->f_path.dentry->d_sb;
> > +       struct dentry *dentry = file->f_path.dentry, *parent;
> > +       struct super_block *sb = dentry->d_sb;
> > +       __u32 mnt_mask, p_mask;
> >
> >         /* Is it a file opened by fanotify? */
> >         if (FMODE_FSNOTIFY_NONE(file->f_mode))
> > @@ -658,6 +660,27 @@ void file_set_fsnotify_mode(struct file *file)
> >                 file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> >                 return;
> >         }
> 
> This was lost in translation:
> 
> @@ -672,8 +672,10 @@ void file_set_fsnotify_mode(struct file *file)
>         /*
>          * If there are permission event watchers but no pre-content event
>          * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
> +        * Pre-content events are only reported for regular files and dirs.
>          */
> -       if (likely(!fsnotify_sb_has_priority_watchers(sb,
> +       if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
> +           likely(!fsnotify_sb_has_priority_watchers(sb,
>                                                 FSNOTIFY_PRIO_PRE_CONTENT))) {
>                 file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
>                 return;

Right. Specifically the (!d_is_dir(dentry) && !d_is_reg(dentry)) got lost,
likely when I moved stuff between different commits and then was resolving
patch conflicts. I'll add it back. Thanks for finding this!

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
> 
> inlining broke the logic and your branch fails the new PRE_ACCESS
> test cases of fanotify03 LTP test (now pushed to branch fan_hsm).
> 
> Specifically in the test case that fails, parent is not watching and
> inode is watching pre-content and your code gets to the p_mask
> test and marks this file as no-pre-content watchers.
> 
> This passes the test:
> 
> @@ -684,17 +686,18 @@ void file_set_fsnotify_mode(struct file *file)
>          * watching for pre-content events on *this* file.
>          */
>         mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
> -       if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
> -           !fsnotify_object_watched(d_inode(dentry), mnt_mask,
> -                                    FSNOTIFY_PRE_CONTENT_EVENTS))) {
> -               file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> +       if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
> +                                            FSNOTIFY_PRE_CONTENT_EVENTS))) {
>                 return;
>         }
> 
>         /* Even parent is not watching for pre-content events on this file? */
> -       parent = dget_parent(dentry);
> -       p_mask = fsnotify_inode_watches_children(d_inode(parent));
> -       dput(parent);
> +       p_mask = 0;
> +       if (unlikely(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) {
> +               parent = dget_parent(dentry);
> +               p_mask = fsnotify_inode_watches_children(d_inode(parent));
> +               dput(parent);
> +       }
>         if (!(p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
>                 file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
>                 return;

Right. I've fixed that up. Thanks!

LTP from your fan_hsm branch is now passing so I've re-pushed the current
state to my fsnotify_hsm branch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

