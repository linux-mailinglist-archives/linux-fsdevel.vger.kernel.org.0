Return-Path: <linux-fsdevel+bounces-21819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B780690AEBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 15:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383091F28F07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE84197A7B;
	Mon, 17 Jun 2024 13:07:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93E19068C;
	Mon, 17 Jun 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629664; cv=none; b=jHdOZN9iRAPB78oG7vR8EK7kbl7HYy9f07DM31kj3WJYLhWb1+8SipVIBHFPRbbFyjk1dpof3HoGUIWu4YNbOedkV3PVlKOdL3D6cyxyFbNXi/QAqdfPmL6ZVGPhY77nFllskzA4kriY7JGKjS75l2HCGFcxSr7urKur3lQbU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629664; c=relaxed/simple;
	bh=f2va808v3JGFDeWjtdT3S0qaFPXhvksnRviISCSHNag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpNK0xgRVDZcJDN/h93WAgxa/WyF23scvIJzI9FivVCS6gASxDdSAM+jYTrxvRCNpBLDxMWiNortz1Mb6by3Bw4S+OKedialleSzQaSoB/4Y919okMrYxxtFXekav+e66x6SHFCajl6V24a8dwM9kaX0Q4ztdVZloxuUbpEv3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8A3C381FC;
	Mon, 17 Jun 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC66213AAA;
	Mon, 17 Jun 2024 13:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cCYSKhs1cGZwPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 13:07:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F1D2A0887; Mon, 17 Jun 2024 15:07:39 +0200 (CEST)
Date: Mon, 17 Jun 2024 15:07:39 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>, James Clark <james.clark@arm.com>,
	ltp@lists.linux.it, linux-nfs@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
Message-ID: <20240617130739.ki5tpsbgvhumdrla@quack3>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
 <CAOQ4uxiN3JnH-oJTw63rTR_B8oPBfB7hWyun0Hsb3ZX3AORf2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiN3JnH-oJTw63rTR_B8oPBfB7hWyun0Hsb3ZX3AORf2g@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: B8A3C381FC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 17-06-24 15:09:09, Amir Goldstein wrote:
> On Mon, Jun 17, 2024 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
> > On Sat 15-06-24 07:35:42, Christian Brauner wrote:
> > > On Wed, 12 Jun 2024 17:09:55 +1000, NeilBrown wrote:
> > > > When a file is opened and created with open(..., O_CREAT) we get
> > > > both the CREATE and OPEN fsnotify events and would expect them in that
> > > > order.   For most filesystems we get them in that order because
> > > > open_last_lookups() calls fsnofify_create() and then do_open() (from
> > > > path_openat()) calls vfs_open()->do_dentry_open() which calls
> > > > fsnotify_open().
> > > >
> > > > [...]
> > >
> > > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > > Patches in the vfs.fixes branch should appear in linux-next soon.
> > >
> > > Please report any outstanding bugs that were missed during review in a
> > > new review to the original patch series allowing us to drop it.
> > >
> > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > patch has now been applied. If possible patch trailers will be updated.
> > >
> > > Note that commit hashes shown below are subject to change due to rebase,
> > > trailer updates or similar. If in doubt, please check the listed branch.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > branch: vfs.fixes
> > >
> > > [1/1] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
> > >       https://git.kernel.org/vfs/vfs/c/7536b2f06724
> >
> > I have reviewed the patch you've committed since I wasn't quite sure which
> > changes you're going to apply after your discussion with Amir. And I have
> > two comments:
> >
> > @@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
> >   */
> >  int vfs_open(const struct path *path, struct file *file)
> >  {
> > +       int ret;
> > +
> >         file->f_path = *path;
> > -       return do_dentry_open(file, NULL);
> > +       ret = do_dentry_open(file, NULL);
> > +       if (!ret)
> > +               /*
> > +                * Once we return a file with FMODE_OPENED, __fput() will call
> > +                * fsnotify_close(), so we need fsnotify_open() here for symmetry.
> > +                */
> > +               fsnotify_open(file);
> 
> Please add { } around multi line indented text.
> 
> > +       return ret;
> >  }
> >
> > AFAICT this will have a side-effect that now fsnotify_open() will be
> > generated even for O_PATH open. It is true that fsnotify_close() is getting
> > generated for them already and we should strive for symmetry. Conceptually
> > it doesn't make sense to me to generate fsnotify events for O_PATH
> > opens/closes but maybe I miss something. Amir, any opinion here?
> 
> Good catch!
> 
> I agree that we do not need OPEN nor CLOSE events for O_PATH.
> I suggest to solve it with:
> 
> @@ -915,7 +929,7 @@ static int do_dentry_open(struct file *f,
>         f->f_sb_err = file_sample_sb_err(f);
> 
>         if (unlikely(f->f_flags & O_PATH)) {
> -               f->f_mode = FMODE_PATH | FMODE_OPENED;
> +               f->f_mode = FMODE_PATH | FMODE_OPENED | __FMODE_NONOTIFY;
>                 f->f_op = &empty_fops;
>                 return 0;
>         }

First I was somewhat nervous about this as it results in returning O_PATH
fd with __FMODE_NONOTIFY to userspace and I was afraid it may influence
generation of events *somewhere*. But checking a bit, we use 'file' for
generating only open, access, modify, and close events so yes, this should
be safe. Alternatively we could add explicit checks for !O_PATH when
generating open / close events.

> > @@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
> >         int acc_mode;
> >         int error;
> >
> > +       if (file->f_mode & FMODE_OPENED)
> > +               fsnotify_open(file);
> > +
> >         if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> >                 error = complete_walk(nd);
> >                 if (error)
> >
> > Frankly, this works but looks as an odd place to put this notification to.
> > Why not just placing it just next to where fsnotify_create() is generated
> > in open_last_lookups()? Like:
> >
> >         if (open_flag & O_CREAT)
> >                 inode_lock(dir->d_inode);
> >         else
> >                 inode_lock_shared(dir->d_inode);
> >         dentry = lookup_open(nd, file, op, got_write);
> > -       if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
> > -               fsnotify_create(dir->d_inode, dentry);
> > +       if (!IS_ERR(dentry)) {
> > +               if (file->f_mode & FMODE_CREATED)
> > +                       fsnotify_create(dir->d_inode, dentry);
> > +               if (file->f_mode & FMODE_OPENED)
> > +                       fsnotify_open(file);
> > +       }
> >         if (open_flag & O_CREAT)
> >                 inode_unlock(dir->d_inode);
> >         else
> >                 inode_unlock_shared(dir->d_inode);
> >
> > That looks like a place where it is much more obvious this is for
> > atomic_open() handling? Now I admit I'm not really closely familiar with
> > the atomic_open() paths so maybe I miss something and do_open() is better.
> 
> It looks nice, but I think it is missing the fast lookup case without O_CREAT
> (i.e. goto finish_lookup).

I don't think so. AFAICT that case will generate the event in vfs_open()
anyway and not in open_last_lookups() / do_open(). Am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

