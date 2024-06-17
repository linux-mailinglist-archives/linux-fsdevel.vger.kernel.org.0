Return-Path: <linux-fsdevel+bounces-21829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9825490B5A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 18:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E717287F86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778D1757E;
	Mon, 17 Jun 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YLmvU5Yt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/1UlUamS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YLmvU5Yt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/1UlUamS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07C1865A;
	Mon, 17 Jun 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639520; cv=none; b=FwYXW17dnqBUJ5kxd3e86jLcsXo0JcoDdFKMqc/GHbT0+iNdilpyj1DDIHKSXBq5Yb0XqHEEPW10FH27yPJzO6A9W3dmbv+Dt96QpQ48gkqV18FC2Bo24fMg75lUo5UB3PtR1O/5zqOhn2tpx8/4t7e/pIIfX3cN6vneI/MwBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639520; c=relaxed/simple;
	bh=VnRW2kGWW7hVs1AuY0hpLXowBfhicjlN5XicW2FYA+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnBREOndQ5kiecuWcEq+iNB6GZ0ajxYnr6BpW9ydrCaYn21UF5rjagbT/TwnciN1gdjWLA6PZGKpUgUbLOy3z1CvGnUoZRp2usrmGOC+J853RNHdHjgh4mthMrHQaHQgMv1pA3Hn1w/vrNW+J+HWKjc8tS05fQ1Nm/wMgjMG4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YLmvU5Yt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/1UlUamS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YLmvU5Yt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/1UlUamS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE3C36030B;
	Mon, 17 Jun 2024 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718639516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3Fue+LKjyO5TsAEr1RuWsw0RHMhvEAhPkjzHF6sfnM=;
	b=YLmvU5Yt6tD7rkbCHhRHJA68PGjyw7L2z15Cxnm/lyGphOJclhgkJgY/O4+WSKppLr03Km
	KOkQgBgkxkMu10TPDlxubhnupIRdZFbhIJBIjpfHuEGRMPBYun4+RFRmxCp2RSr3ySqUHi
	NqlPhDYqpDUhGLKIr+AGz/DHCf0URog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718639516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3Fue+LKjyO5TsAEr1RuWsw0RHMhvEAhPkjzHF6sfnM=;
	b=/1UlUamSzd3ksPvNn1D+TJgERZUeS5WM54FwuAhyJiUuHWbGPv4whdR3bvSBakfNFvMo67
	J88VOS5NVILqCeDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718639516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3Fue+LKjyO5TsAEr1RuWsw0RHMhvEAhPkjzHF6sfnM=;
	b=YLmvU5Yt6tD7rkbCHhRHJA68PGjyw7L2z15Cxnm/lyGphOJclhgkJgY/O4+WSKppLr03Km
	KOkQgBgkxkMu10TPDlxubhnupIRdZFbhIJBIjpfHuEGRMPBYun4+RFRmxCp2RSr3ySqUHi
	NqlPhDYqpDUhGLKIr+AGz/DHCf0URog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718639516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3Fue+LKjyO5TsAEr1RuWsw0RHMhvEAhPkjzHF6sfnM=;
	b=/1UlUamSzd3ksPvNn1D+TJgERZUeS5WM54FwuAhyJiUuHWbGPv4whdR3bvSBakfNFvMo67
	J88VOS5NVILqCeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C34F139AB;
	Mon, 17 Jun 2024 15:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ohweJpxbcGZocwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 15:51:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F252A0887; Mon, 17 Jun 2024 17:51:56 +0200 (CEST)
Date: Mon, 17 Jun 2024 17:51:56 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>, James Clark <james.clark@arm.com>,
	ltp@lists.linux.it, linux-nfs@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
Message-ID: <20240617155156.hdmwworcnqg5pqyw@quack3>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
 <CAOQ4uxiN3JnH-oJTw63rTR_B8oPBfB7hWyun0Hsb3ZX3AORf2g@mail.gmail.com>
 <20240617130739.ki5tpsbgvhumdrla@quack3>
 <CAOQ4uxhGD563ye9F=+m_gcaDuYJPbD1mbwmtm0y476Oxe5fH6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhGD563ye9F=+m_gcaDuYJPbD1mbwmtm0y476Oxe5fH6Q@mail.gmail.com>
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -7.80
X-Spam-Level: 

On Mon 17-06-24 16:49:55, Amir Goldstein wrote:
> On Mon, Jun 17, 2024 at 4:07 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 17-06-24 15:09:09, Amir Goldstein wrote:
> > > On Mon, Jun 17, 2024 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Sat 15-06-24 07:35:42, Christian Brauner wrote:
> > > > > On Wed, 12 Jun 2024 17:09:55 +1000, NeilBrown wrote:
> > > > > > When a file is opened and created with open(..., O_CREAT) we get
> > > > > > both the CREATE and OPEN fsnotify events and would expect them in that
> > > > > > order.   For most filesystems we get them in that order because
> > > > > > open_last_lookups() calls fsnofify_create() and then do_open() (from
> > > > > > path_openat()) calls vfs_open()->do_dentry_open() which calls
> > > > > > fsnotify_open().
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > > > > Patches in the vfs.fixes branch should appear in linux-next soon.
> > > > >
> > > > > Please report any outstanding bugs that were missed during review in a
> > > > > new review to the original patch series allowing us to drop it.
> > > > >
> > > > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > > > patch has now been applied. If possible patch trailers will be updated.
> > > > >
> > > > > Note that commit hashes shown below are subject to change due to rebase,
> > > > > trailer updates or similar. If in doubt, please check the listed branch.
> > > > >
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > > > branch: vfs.fixes
> > > > >
> > > > > [1/1] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
> > > > >       https://git.kernel.org/vfs/vfs/c/7536b2f06724
> > > >
> > > > I have reviewed the patch you've committed since I wasn't quite sure which
> > > > changes you're going to apply after your discussion with Amir. And I have
> > > > two comments:
> > > >
> > > > @@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
> > > >   */
> > > >  int vfs_open(const struct path *path, struct file *file)
> > > >  {
> > > > +       int ret;
> > > > +
> > > >         file->f_path = *path;
> > > > -       return do_dentry_open(file, NULL);
> > > > +       ret = do_dentry_open(file, NULL);
> > > > +       if (!ret)
> > > > +               /*
> > > > +                * Once we return a file with FMODE_OPENED, __fput() will call
> > > > +                * fsnotify_close(), so we need fsnotify_open() here for symmetry.
> > > > +                */
> > > > +               fsnotify_open(file);
> > >
> > > Please add { } around multi line indented text.
> > >
> > > > +       return ret;
> > > >  }
> > > >
> > > > AFAICT this will have a side-effect that now fsnotify_open() will be
> > > > generated even for O_PATH open. It is true that fsnotify_close() is getting
> > > > generated for them already and we should strive for symmetry. Conceptually
> > > > it doesn't make sense to me to generate fsnotify events for O_PATH
> > > > opens/closes but maybe I miss something. Amir, any opinion here?
> > >
> > > Good catch!
> > >
> > > I agree that we do not need OPEN nor CLOSE events for O_PATH.
> > > I suggest to solve it with:
> > >
> > > @@ -915,7 +929,7 @@ static int do_dentry_open(struct file *f,
> > >         f->f_sb_err = file_sample_sb_err(f);
> > >
> > >         if (unlikely(f->f_flags & O_PATH)) {
> > > -               f->f_mode = FMODE_PATH | FMODE_OPENED;
> > > +               f->f_mode = FMODE_PATH | FMODE_OPENED | __FMODE_NONOTIFY;
> > >                 f->f_op = &empty_fops;
> > >                 return 0;
> > >         }
> >
> > First I was somewhat nervous about this as it results in returning O_PATH
> > fd with __FMODE_NONOTIFY to userspace and I was afraid it may influence
> > generation of events *somewhere*.
> 
> It influences my POC code of future lookup permission event:
> https://github.com/amir73il/linux/commits/fan_lookup_perm/
> which is supposed to generate events on lookup with O_PATH fd.
> 
> > But checking a bit, we use 'file' for
> > generating only open, access, modify, and close events so yes, this should
> > be safe. Alternatively we could add explicit checks for !O_PATH when
> > generating open / close events.
> >
> 
> So yeh, this would be better:
> 
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -112,7 +112,7 @@ static inline int fsnotify_file(struct file *file,
> __u32 mask)
>  {
>         const struct path *path;
> 
> -       if (file->f_mode & FMODE_NONOTIFY)
> +       if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
>                 return 0;
> 
>         path = &file->f_path;
> --
> 
> It is a dilemma, if this patch should be separate.
> On the one hand it fixes unbalanced CLOSE events on O_PATH fd,
> so it is an independent fix.
> OTOH, it is a requirement for moving fsnotify_open() out of
> do_dentry_open(), so not so healthy to separate them, when it is less clear
> that they need to be backported together.

Yeah, I guess a separate patch would be better because it also needs a good
changelog explaining this.

> > > > @@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
> > > >         int acc_mode;
> > > >         int error;
> > > >
> > > > +       if (file->f_mode & FMODE_OPENED)
> > > > +               fsnotify_open(file);
> > > > +
> > > >         if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> > > >                 error = complete_walk(nd);
> > > >                 if (error)
> > > >
> > > > Frankly, this works but looks as an odd place to put this notification to.
> > > > Why not just placing it just next to where fsnotify_create() is generated
> > > > in open_last_lookups()? Like:
> > > >
> > > >         if (open_flag & O_CREAT)
> > > >                 inode_lock(dir->d_inode);
> > > >         else
> > > >                 inode_lock_shared(dir->d_inode);
> > > >         dentry = lookup_open(nd, file, op, got_write);
> > > > -       if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
> > > > -               fsnotify_create(dir->d_inode, dentry);
> > > > +       if (!IS_ERR(dentry)) {
> > > > +               if (file->f_mode & FMODE_CREATED)
> > > > +                       fsnotify_create(dir->d_inode, dentry);
> > > > +               if (file->f_mode & FMODE_OPENED)
> > > > +                       fsnotify_open(file);
> > > > +       }
> > > >         if (open_flag & O_CREAT)
> > > >                 inode_unlock(dir->d_inode);
> > > >         else
> > > >                 inode_unlock_shared(dir->d_inode);
> > > >
> > > > That looks like a place where it is much more obvious this is for
> > > > atomic_open() handling? Now I admit I'm not really closely familiar with
> > > > the atomic_open() paths so maybe I miss something and do_open() is better.
> > >
> > > It looks nice, but I think it is missing the fast lookup case without O_CREAT
> > > (i.e. goto finish_lookup).
> >
> > I don't think so. AFAICT that case will generate the event in vfs_open()
> > anyway and not in open_last_lookups() / do_open(). Am I missing something?
> 
> No. I am. This code is hard to follow.
> I am fine with your variant, but maybe after so many in-tree changes
> including the extra change of O_PATH, perhaps it would be better
> to move this patch to your fsnotify tree?

I don't care much which tree this goes through as the actual amount of
context is minimal. But I definitely want to send another version of the
series out to the tree. I guess I'll do it because Neil might have trouble
justifying the O_PATH change in the changelog :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

