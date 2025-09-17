Return-Path: <linux-fsdevel+bounces-61947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F91B80266
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E463A5738
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5AF3016F4;
	Wed, 17 Sep 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3v7Y7pb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uJJS36Ku";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CCQiHQNN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TgzzG1is"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98572F3C32
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120142; cv=none; b=nblzj4KmwjFDi15XqLA4ZTdQq0Cea4mvqyRZMJHA0FIdCwJaiFuxLgMdfcuk+HkAdapub4FBLgRDAGBS7K7ALPL7CuH5GgX6J4BD65/qtPnAYUDSnbi2QbGxCBtX32E0uVyDcCIaz04QuKxy6nKcqAhWxZjGDTJuUf+v1R8QQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120142; c=relaxed/simple;
	bh=saoZ45JmpjgnTY0sEqow5fI9WFXZe3qIhs+MuwngoNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQzIcNTmFA5CHOY6bkeUxsg+n7istuW0faw/aITo8wBYUFrl5LEdIRCDG0b+rR4ye/o+vMXFlhwzLgU2xeY01FVZ4s0gbpZXntIgnZGfCsXJ12Y9IDHF1vxstuorB00mPXUP+E7HLHXYKMWRVuWL4k9cC9R4vyvNumQEjrWMnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3v7Y7pb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uJJS36Ku; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CCQiHQNN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TgzzG1is; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB51B20666;
	Wed, 17 Sep 2025 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758120137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zw02+LDZHli2japWiKyMvW3fDuB+Hk0zuhBagtt5G8I=;
	b=Y3v7Y7pbbEFF/dy+wzVe4lMKO0184VEQ4ApgLie4fFOJHh+EiERumamZBTZKb0HE+QnqYO
	8KUbQB9c9amCO3MgxkjYfBPIM+m3a8yriPn+NANwQizYO4lR6YA8wh8yb6cRqxt8BGbgo1
	DT4t0MOcf6A7o3rNZ3SNzwB2RsKmVJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758120137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zw02+LDZHli2japWiKyMvW3fDuB+Hk0zuhBagtt5G8I=;
	b=uJJS36KuHnov3QHFokbyUQ2Vn66jSq2D/XK7Qp0dOXOVIpgIecoeCK5MCJ56tWJQcEKKOT
	mGH3C0f6CeuKcCBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758120136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zw02+LDZHli2japWiKyMvW3fDuB+Hk0zuhBagtt5G8I=;
	b=CCQiHQNNS/e6fqSbka2yHa7EUh/GFLWoBZ7yXum2W9aoZsCZDubeALVY0RB8to/p6gJTSv
	qKO3kpUttwfU78nariaMlN0HbQl4wvO0AKpK8hJEYjWkx/xHK4ZsPFb2XYnTRwOt/uj6jP
	IYtfVHt0QBGBWHrkb5fy4c+gDj0ktSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758120136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zw02+LDZHli2japWiKyMvW3fDuB+Hk0zuhBagtt5G8I=;
	b=TgzzG1is3agIUeOMtTIgdvTGyqTvV0ufxVqS8WdSEhhb9a4xDXsGgXwP9RykBr1ALk/oSX
	ea4RXdRFjVX3C6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D15191368D;
	Wed, 17 Sep 2025 14:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GTcRM8jIymgyDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 14:42:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44845A077E; Wed, 17 Sep 2025 16:42:08 +0200 (CEST)
Date: Wed, 17 Sep 2025 16:42:08 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jakub Acs <acsjakub@amazon.de>, 
	linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
Message-ID: <3gpfceywinbzsbgslwsywzv4qqubab6gcftlzag6drhl5vhmb6@iupru3v7wsey>
References: <20250915101510.7994-1-acsjakub@amazon.de>
 <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
 <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
 <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com>
 <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
 <CAOQ4uxhOMcaVupVVGXV2Srz_pAG+BzDc9Gb4hFdwKUtk45QypQ@mail.gmail.com>
 <scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa>
 <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed 17-09-25 13:07:45, Amir Goldstein wrote:
> On Wed, Sep 17, 2025 at 11:25 AM Jan Kara <jack@suse.cz> wrote:
> > On Tue 16-09-25 15:29:35, Amir Goldstein wrote:
> > > On Tue, Sep 16, 2025 at 1:30 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Mon 15-09-25 17:29:40, Amir Goldstein wrote:
> > > > > On Mon, Sep 15, 2025 at 4:07 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > > > > > > > index 83f80fdb1567..424c73188e06 100644
> > > > > > > > --- a/fs/overlayfs/export.c
> > > > > > > > +++ b/fs/overlayfs/export.c
> > > > > > > > @@ -195,6 +195,8 @@ static int ovl_check_encode_origin(struct inode *inode)
> > > > > > > >         if (!ovl_inode_lower(inode))
> > > > > > > >                 return 0;
> > > > > > > >
> > > > > > > > +       if (!inode->i_sb->s_root)
> > > > > > > > +               return -ENOENT;
> > > > > > >
> > > > > > > For a filesystem method to have to check that its own root is still alive sounds
> > > > > > > like the wrong way to me.
> > > > > > > That's one of the things that should be taken for granted by fs code.
> > > > > > >
> > > > > > > I don't think this is an overlayfs specific issue, because other fs would be
> > > > > > > happy if encode_fh() would be called with NULL sb->s_root.
> > > > > >
> > > > > > Actually, I don't see where that would blow up? Generally references to
> > > > > > sb->s_root in filesystems outside of mount / remount code are pretty rare.
> > > > > > Also most of the code should be unreachable by the time we set sb->s_root
> > > > > > to NULL because there are no open files at that moment, no exports etc. But
> > > > > > as this report shows, there are occasional surprises (I remember similar
> > > > > > issue with ext4 sysfs files handlers using s_root without checking couple
> > > > > > years back).
> > > > > >
> > > > >
> > > > > I am not sure that I understand what you are arguing for.
> > > > > I did a very naive grep s_root fs/*/export.c and quickly found:
> > > >
> > > > You're better with grep than me ;). I was grepping for '->s_root' as well
> > > > but all the hits I had looked into were related to mounting and similar and
> > > > eventually I got bored. Restricting the grep to export ops indeed shows
> > > > ceph, gfs2 and overlayfs are vulnerable to this kind of problem.
> 
> As far as I can tell, ceph uses s_root only in decode_fh methods.

True. But ceph also uses d_find_alias() in ceph_encode_snapfh() which could
race with shrink_dcache_for_umount()->do_one_tree() and trigger:

        WARN(1, "BUG: Dentry %p{i=%lx,n=%pd} "
                        " still in use (%d) [unmount of %s %s]\n",

> ovl and gfs2 only want to know for an inode if it is the root inode,
> they do not strictly need to dereference s_root for that purpose.
> (see patch below)
> 
> > So there are not many cases where this can happen but enough that I'd say
> > that handling some events specially to avoid encoding fh on fs while it is
> > unmounted is fragile and prone to breaking again sooner or later.
> >
> > > How about skipping fsnotify_inoderemove() in case sb is in shutdown?
> >
> > Also how would you like to handle that in a race-free manner? We'd need to
> > hold s_umount for that which we cannot really afford in that context. But
> > maybe you have some better idea...
> >
> 
> I was only thinking about this code path:
> 
> generic_shutdown_super()
>   shrink_dcache_for_umount()
>     ...
>       __dentry_kill()
>         dentry_unlink_inode()
> 
> This is supposed to be the last dput of all remaining dentries
> and I don't think a deferred unlink should be expected in that case.

I see.
 
> But I realize now that you mean delayed unlink from another context
> which races with shutdown.

Yes, I've meant that.

> > > > > > > Can we change the order of generic_shutdown_super() so that
> > > > > > > fsnotify_sb_delete(sb) is called before setting s_root to NULL?
> > > > > > >
> > > > > > > Or is there a better solution for this race?
> > > > > >
> > > > > > Regarding calling fsnotify_sb_delete() before setting s_root to NULL:
> > > > > > In 2019 (commit 1edc8eb2e9313 ("fs: call fsnotify_sb_delete after
> > > > > > evict_inodes")) we've moved the call after evict_inodes() because otherwise
> > > > > > we were just wasting cycles scanning many inodes without watches. So moving
> > > > > > it earlier wouldn't be great...
> > > > >
> > > > > Yes, I noticed that and I figured there were subtleties.
> > > >
> > > > Right. After thinking more about it I think calling fsnotify_sb_delete()
> > > > earlier is the only practical choice we have (not clearing sb->s_root isn't
> > > > much of an option - we need to prune all dentries to quiesce the filesystem
> > > > and leaving s_root alive would create odd corner cases). But you don't want
> > > > to be iterating millions of inodes just to clear couple of marks so we'll
> > > > have to figure out something more clever there.
> > >
> > > I think we only need to suppress the fsnotify_inoderemove() call.
> > > It sounds doable and very local to fs/super.c.
> > >
> > > Regarding show_mark_fhandle() WDYT about my suggestion to
> > > guard it with super_trylock_shared()?
> >
> > Yes, super_trylock_shared() for that callsite looks like a fine solution
> > for that call site. Occasional random failures in encoding fh because the
> > trylock fails are unlikely to have any bad consequences there. But I think
> > we need to figure out other possibly racing call-sites as well first.
> >
> 
> Might something naive as this be enough?

It looks like it should be good for the problems with gfs2 & overlayfs but
it doesn't solve the problem with ceph and as Jakub writes there's a question
whether we won't hit more problems later.

I'm sorry for poking holes into your solutions. The more I look into this
the more problems I find :-|

As I'm thinking about it I'm slowly leaning towards implementing a list of
connectors per sb (so that we can quickly reclaim on umount). It seems
stupid just for these corner cases but longer term we can also implement
what Dave once suggested [1] so that fsnotify doesn't need to pin inodes in
memory at all which should more that make up for the additional memory for
inode connector members.

								Honza

[1] https://lore.kernel.org/linux-fsdevel/ZwXDzKGj6Bp28kYe@dread.disaster.area/

> diff --git a/fs/dcache.c b/fs/dcache.c
> index 60046ae23d514..8c9d0d6bb0045 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1999,10 +1999,12 @@ struct dentry *d_make_root(struct inode *root_inode)
> 
>         if (root_inode) {
>                 res = d_alloc_anon(root_inode->i_sb);
> -               if (res)
> +               if (res) {
> +                       root_inode->i_opflags |= IOP_ROOT;
>                         d_instantiate(res, root_inode);
> -               else
> +               } else {
>                         iput(root_inode);
> +               }
>         }
>         return res;
>  }
> diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
> index 3334c394ce9cb..809a09c6a89e0 100644
> --- a/fs/gfs2/export.c
> +++ b/fs/gfs2/export.c
> @@ -46,7 +46,7 @@ static int gfs2_encode_fh(struct inode *inode, __u32
> *p, int *len,
>         fh[3] = cpu_to_be32(ip->i_no_addr & 0xFFFFFFFF);
>         *len = GFS2_SMALL_FH_SIZE;
> 
> -       if (!parent || inode == d_inode(sb->s_root))
> +       if (!parent || is_root_inode(inode))
>                 return *len;
> 
>         ip = GFS2_I(parent);
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb15674..7827c63354ad5 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -199,7 +199,7 @@ static int ovl_check_encode_origin(struct inode *inode)
>          * Root is never indexed, so if there's an upper layer, encode upper for
>          * root.
>          */
> -       if (inode == d_inode(inode->i_sb->s_root))
> +       if (is_root_inode(inode))
>                 return 0;
> 
>         /*
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ec867f112fd5f..ed84379aa06ca 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -665,6 +665,7 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_DEFAULT_READLINK   0x0010
>  #define IOP_MGTIME     0x0020
>  #define IOP_CACHED_LINK        0x0040
> +#define IOP_ROOT       0x0080
>   /*
>   * Keep mostly read-only and often accessed (especially for
> @@ -2713,6 +2714,11 @@ static inline bool is_mgtime(const struct inode *inode)
>         return inode->i_opflags & IOP_MGTIME;
>  }
> 
> +static inline bool is_root_inode(const struct inode *inode)
> +{
> +       return inode->i_opflags & IOP_ROOT;
> +}
> +
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>         int flags, const char *dev_name, void *data,
>         int (*fill_super)(struct super_block *, void *, int));
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

