Return-Path: <linux-fsdevel+bounces-41144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F78A2B88F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458E01888F71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEE155316;
	Fri,  7 Feb 2025 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZtT9JvPm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rdxilFH/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l0i1NzVA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="603coiC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52A1547C0;
	Fri,  7 Feb 2025 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893730; cv=none; b=evdgPt8FeoAOU/O3Pkn3ToXZoQukTkbu4JvHlsm6BVVvvpSeaW7QjTQsI7aYSaAEIwGS1+6xiAQGOIMHMBS53+KzJcV3TRTEW3g74RNQQlG7dhmyuixStETPDKDpIx7DYDJtB5Ann4KBiTCqodq8P8xYlzLTOgefNRihFVJtG18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893730; c=relaxed/simple;
	bh=sj2MhoHkWmu0YdljeGDkoIORGViWkShGHaxlGXyTG9I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Kf+1MxsvFcO2fxEaLMC7CcQiGbgVIeIJcEJFOoSv2mlJScbUS+4w3xh9alUVMlBL42EcbeXPmgp696kn3/1CN4i2OtcOd1o4+SdX3cvWNEl46Uf8n2/0zvzA1hyhJXuYzMh5a4w+0vMz9J01i/zGBGYWQeZeauL6vFyawusGWyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZtT9JvPm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rdxilFH/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l0i1NzVA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=603coiC/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B576E1F443;
	Fri,  7 Feb 2025 02:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738893726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BT2fQuUIsHJkZn3wx+62+TzEsZgShrHCdJAvMLsWpxo=;
	b=ZtT9JvPmHsTL5JxXqP7Af2A2RJMdjruH2wyiX9M8nGWHJ53HwQszEKLc3+Qh06vaQlMtin
	m+56KvQcO4dR1u0Lk6ppx+enHOry6jOsiSa5qyP2BKhGJTsf+UVuKHB9zlv+5QgcuhiKAg
	zyNH2dIGZymR+IMsPQR9/2hkcz9YIGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738893726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BT2fQuUIsHJkZn3wx+62+TzEsZgShrHCdJAvMLsWpxo=;
	b=rdxilFH/tCrMMXJkbdWscPoj0e3YTHHlMVcNErypQ/pO7u1m9cQ8Xmo7N0aRHF9IF+dlRo
	avjLa0iuvhSFHTBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l0i1NzVA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="603coiC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738893725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BT2fQuUIsHJkZn3wx+62+TzEsZgShrHCdJAvMLsWpxo=;
	b=l0i1NzVAvfiHfIKB1owSJq1paZIGOMQ0h6dH25Q3fi2Tf3MnMbXhucbnnlu8qPGFzGn5Pz
	YdhytTIRxX3bY0DtHgCQNEfb83q84zHLA+vaPN6s9LcpCUeXlpRav8yaF5MuO0297+jqdG
	p9jlWcBQE91QGAvXw98PhlYo3BKdWcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738893725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BT2fQuUIsHJkZn3wx+62+TzEsZgShrHCdJAvMLsWpxo=;
	b=603coiC/fLVODMoMQcPb3gQY+ZVD/hXpbXIb+fksfSNHP30zP88SINQ8YoRWmqGp14JKwj
	EKNY8ZLLsZKz8/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F36A313806;
	Fri,  7 Feb 2025 02:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KyheKZpppWdmZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 02:02:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/19] VFS: introduce inode flags to report locking needs
 for directory ops
In-reply-to: <20250206-gasversorger-flugbereit-9eed46e951f9@brauner>
References: <>, <20250206-gasversorger-flugbereit-9eed46e951f9@brauner>
Date: Fri, 07 Feb 2025 13:01:59 +1100
Message-id: <173889371961.22054.1232506757563289828@noble.neil.brown.name>
X-Rspamd-Queue-Id: B576E1F443
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 07 Feb 2025, Christian Brauner wrote:
> On Thu, Feb 06, 2025 at 04:42:47PM +1100, NeilBrown wrote:
> > If a filesystem supports _async ops for some directory ops we can take a
> > "shared" lock on i_rwsem otherwise we must take an "exclusive" lock.  As
> > the filesystem may support some async ops but not others we need to
> > easily determine which.
> >=20
> > With this patch we group the ops into 4 groups that are likely be
> > supported together:
> >=20
> > CREATE: create, link, mkdir, mknod
> > REMOVE: rmdir, unlink
> > RENAME: rename
> > OPEN: atomic_open, create
> >=20
> > and set S_ASYNC_XXX for each when the inode in initialised.
> >=20
> > We also add a LOOKUP_REMOVE intent flag which will be used by locking
> > interfaces to help know which group is being used.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/dcache.c           | 24 ++++++++++++++++++++++++
> >  include/linux/fs.h    |  5 +++++
> >  include/linux/namei.h |  5 +++--
> >  3 files changed, 32 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index e49607d00d2d..37c0f655166d 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -384,6 +384,27 @@ static inline void __d_set_inode_and_type(struct den=
try *dentry,
> >  	smp_store_release(&dentry->d_flags, flags);
> >  }
> > =20
> > +static void set_inode_flags(struct inode *inode)
> > +{
> > +	const struct inode_operations *i_op =3D inode->i_op;
> > +
> > +	lockdep_assert_held(&inode->i_lock);
> > +	if ((i_op->create_async || !i_op->create) &&
> > +	    (i_op->link_async || !i_op->link) &&
> > +	    (i_op->symlink_async || !i_op->symlink) &&
> > +	    (i_op->mkdir_async || !i_op->mkdir) &&
> > +	    (i_op->mknod_async || !i_op->mknod))
> > +		inode->i_flags |=3D S_ASYNC_CREATE;
> > +	if ((i_op->unlink_async || !i_op->unlink) &&
> > +	    (i_op->mkdir_async || !i_op->mkdir))
> > +		inode->i_flags |=3D S_ASYNC_REMOVE;
> > +	if (i_op->rename_async)
> > +		inode->i_flags |=3D S_ASYNC_RENAME;
> > +	if (i_op->atomic_open_async ||
> > +	    (!i_op->atomic_open && i_op->create_async))
> > +		inode->i_flags |=3D S_ASYNC_OPEN;
> > +}
>=20
> I think this is unpleasant. As I said we should fold _async into the
> normal methods. Then we can add:
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index be3ad155ec9f..1d19f72448fc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2186,6 +2186,7 @@ int wrap_directory_iterator(struct file *, struct dir=
_context *,
>         { return wrap_directory_iterator(file, ctx, x); }
>=20
>  struct inode_operations {
> +       iop_flags_t iop_flags;
>         struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned=
 int);
>         const char * (*get_link) (struct dentry *, struct inode *, struct d=
elayed_call *);
>         int (*permission) (struct mnt_idmap *, struct inode *, int);
>=20
> which is similar to what I did for
>=20
> struct file_operations {
>         struct module *owner;
>         fop_flags_t fop_flags;
>=20
> and introduce
>=20
> IOP_ASYNC_CREATE
> IOP_ASYNC_OPEN
>=20

Ahh - I see where you are going.  Interesting.
The iop_flags effectively provides versioning for the functions so we
don't have to embed the version in the name.  That would work.

I guess we would handle the mkdir change by changing every current mkdir
to return ERR_PTR() of the current return value and the vfs_mkdir_xx
caller checks if that is NULL and the original dentry is still negative,
and then performs the lookup.

Thanks,
NeilBrown


> etc and then filesystems can just do:
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index df9669d4ded7..90c7aeb49466 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10859,6 +10859,7 @@ static void nfs4_disable_swap(struct inode *inode)
>  }
>=20
>  static const struct inode_operations nfs4_dir_inode_operations =3D {
> +       .iop_flags      =3D IOP_ASYNC_CREATE | IOP_ASYNC_OPEN,
>         .create         =3D nfs_create,
>         .lookup         =3D nfs_lookup,
>         .atomic_open    =3D nfs_atomic_open,
>=20
> and then you can raise S_ASYNC_OPEN and so on based on the flags, not
> the individual methods.
>=20
> > +
> >  static inline void __d_clear_type_and_inode(struct dentry *dentry)
> >  {
> >  	unsigned flags =3D READ_ONCE(dentry->d_flags);
> > @@ -1893,6 +1914,7 @@ static void __d_instantiate(struct dentry *dentry, =
struct inode *inode)
> >  	raw_write_seqcount_begin(&dentry->d_seq);
> >  	__d_set_inode_and_type(dentry, inode, add_flags);
> >  	raw_write_seqcount_end(&dentry->d_seq);
> > +	set_inode_flags(inode);
> >  	fsnotify_update_flags(dentry);
> >  	spin_unlock(&dentry->d_lock);
> >  }
> > @@ -1999,6 +2021,7 @@ static struct dentry *__d_obtain_alias(struct inode=
 *inode, bool disconnected)
> > =20
> >  		spin_lock(&new->d_lock);
> >  		__d_set_inode_and_type(new, inode, add_flags);
> > +		set_inode_flags(inode);
> >  		hlist_add_head(&new->d_u.d_alias, &inode->i_dentry);
> >  		if (!disconnected) {
> >  			hlist_bl_lock(&sb->s_roots);
> > @@ -2701,6 +2724,7 @@ static inline void __d_add(struct dentry *dentry, s=
truct inode *inode)
> >  		raw_write_seqcount_begin(&dentry->d_seq);
> >  		__d_set_inode_and_type(dentry, inode, add_flags);
> >  		raw_write_seqcount_end(&dentry->d_seq);
> > +		set_inode_flags(inode);
> >  		fsnotify_update_flags(dentry);
> >  	}
> >  	__d_rehash(dentry);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e414400c2487..9a9282fef347 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2361,6 +2361,11 @@ struct super_operations {
> >  #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
> >  #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/=
cachefiles) */
> > =20
> > +#define S_ASYNC_CREATE	BIT(18)	/* create, link, symlink, mkdir, mknod al=
l _async */
> > +#define S_ASYNC_REMOVE	BIT(19)	/* unlink, mkdir both _async */
> > +#define S_ASYNC_RENAME	BIT(20) /* rename_async supported */
> > +#define S_ASYNC_OPEN	BIT(21) /* atomic_open_async or create_async suppor=
ted */
> > +
> >  /*
> >   * Note that nosuid etc flags are inode-specific: setting some file-syst=
em
> >   * flags just means all the inodes inherit those flags by default. It mi=
ght be
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 76c587a5ec3a..72e351640406 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -40,10 +40,11 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> >  #define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
> >  #define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
> >  #define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
> > +#define LOOKUP_REMOVE		BIT(20)	/* ... in target of object removal */
> > =20
> >  #define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |=
	\
> > -				 LOOKUP_RENAME_TARGET)
> > -/* 4 spare bits for intent */
> > +				 LOOKUP_RENAME_TARGET | LOOKUP_REMOVE)
> > +/* 3 spare bits for intent */
> > =20
> >  /* Scoping flags for lookup. */
> >  #define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
> > --=20
> > 2.47.1
> >=20
>=20


