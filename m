Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA65A40D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 03:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiH2B7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 21:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2B7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 21:59:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18CB3AB22;
        Sun, 28 Aug 2022 18:59:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85B6F1FA12;
        Mon, 29 Aug 2022 01:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661738349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3hHsV2Z253OHSvEysyk+EjJWrLGOrbKvEltEwCaY7I=;
        b=QtyicIpYmAgDtuxvdtEhuc6x3j5Ii52vH/Icdpl9E+w5sWP0mKtPgp1i46lyZeEkVxQyy3
        oe+aH6PJlPjPRBfwiZQy8mwMl5W3c1oXQ7mnZPWPNU9nQQnsUXbWGl3M1/jXtjs7wEVj+3
        X2IUHyDXbMK6UZhpdDjYFIgIuca2i3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661738349;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3hHsV2Z253OHSvEysyk+EjJWrLGOrbKvEltEwCaY7I=;
        b=4JZbr5L65gN1Yfgvhh0wqm2nA7Yiw8Ra6za0vFp/uLzkuFPq+nmVzcxMBLBqEHyIVK/n7S
        xda9xE5dl/csNXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E9F51352A;
        Mon, 29 Aug 2022 01:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EKT5EWodDGPXDQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Aug 2022 01:59:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Daire Byrne" <daire@dneg.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
In-reply-to: <YwmS63X3Sm4bhlcT@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984370.25420.13019217727422217511.stgit@noble.brown>,
 <YwmS63X3Sm4bhlcT@ZenIV>
Date:   Mon, 29 Aug 2022 11:59:02 +1000
Message-id: <166173834258.27490.151597372187103012@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Aug 2022, Al Viro wrote:
> On Fri, Aug 26, 2022 at 12:10:43PM +1000, NeilBrown wrote:
>=20
> > +/**
> > + * d_lock_update_nested - lock a dentry before updating
> > + * @dentry: the dentry to be locked
> > + * @base:   the parent, or %NULL
> > + * @name:   the name in that parent, or %NULL
> > + * @subclass: lockdep locking class.
> > + *
> > + * Lock a dentry in a directory on which a shared-lock may be held, and
> > + * on which parallel updates are permitted.
> > + * If the base and name are given, then on success the dentry will still
> > + * have that base and name - it will not have raced with rename.
> > + * On success, a positive dentry will still be hashed, ensuring there
> > + * was no race with unlink.
> > + * If they are not given, then on success the dentry will be negative,
> > + * which again ensures no race with rename, or unlink.
>=20
> I'm not sure it's a good idea to have that in one function, TBH.
> Looking at the callers, there are
> 	* lookup_hash_update()
> 		lookup_hash_update_len()
> 			nfsd shite
> 		filename_create_one()
> 			filename_create_one_len()
> 				nfsd shite
> 			filename_create()
> 				kern_path_create()
> 				user_path_create()
> 				do_mknodat()
> 				do_mkdirat()
> 				do_symlinkat()
> 				do_linkat()
> 		do_rmdir()
> 		do_unlinkat()
> 	* fuckloads of callers in lock_rename_lookup()
> 	* d_lock_update()
> 		atomic_open()
> 		lookup_open()
>=20
> Only the last two can get NULL base or name.  Already interesting,
> isn't it?  What's more, splitup between O_CREATE open() on one
> side and everything else that might create, remove or rename on
> the other looks really weird.

Well, O_CREATE is a bit weird.
But I can see that it would be cleaner to pass the dir/name into those
two calls that currently get NULL - then remove the handling of NULL.
Thanks.

>=20
> > +	rcu_read_lock(); /* for d_same_name() */
> > +	if (d_unhashed(dentry) && d_is_positive(dentry)) {
> > +		/* name was unlinked while we waited */
> > +		ret =3D false;
>=20
> BTW, what happens if somebody has ->lookup() returning a positive
> unhashed?  Livelock on attempt to hit it with any directory-modifying
> syscall?  Right now such behaviour is permitted; I don't know if
> anything in the tree actually does it, but at the very least it
> would need to be documented.
>=20
> Note that *negative* unhashed is not just permitted, it's
> actively used e.g. by autofs.  That really needs to be well
> commented...

I hadn't thought that ->lookup() could return anything unhashed.  I'll
look into that - thanks.

>=20
> > +	} else if (base &&
> > +		 (dentry->d_parent !=3D base ||
> > +		  dentry->d_name.hash !=3D name->hash ||
> > +		  !d_same_name(dentry, base, name))) {
> > +		/* dentry was renamed - possibly silly-rename */
> > +		ret =3D false;
> > +	} else if (!base && d_is_positive(dentry)) {
> > +		ret =3D false;
> > +	} else {
> > +		dentry->d_flags |=3D DCACHE_PAR_UPDATE;
> > +	}
>=20
> > + * Parent directory has inode locked exclusive, or possibly shared if wq
> > + * is given.  In the later case the fs has explicitly allowed concurrent
> > + * updates in this directory.  This is the one and only case
> > + * when ->lookup() may be called on a non in-lookup dentry.
>=20
> What Linus already said about wq...  To add a reason he hadn't mentioned,
> the length of call chain one needs to track to figure out whether it's
> NULL or not is... excessive.  And I don't mean just "greater than 0".
> We have places like that, and sometimes we have to, but it's never a good
> thing...
>=20
> >  static struct dentry *__lookup_hash(const struct qstr *name,
> > -		struct dentry *base, unsigned int flags)
> > +				    struct dentry *base, unsigned int flags,
> > +				    wait_queue_head_t *wq)
>=20
> > -	dentry =3D d_alloc(base, name);
> > +	if (wq)
> > +		dentry =3D d_alloc_parallel(base, name, wq);
> > +	else
> > +		dentry =3D d_alloc(base, name);
> >  	if (unlikely(!dentry))
> >  		return ERR_PTR(-ENOMEM);
> > +	if (IS_ERR(dentry))
> > +		return dentry;
>=20
> 	BTW, considering the fact that we have 12 callers of d_alloc()
> (including this one) and 28 callers of its wrapper (d_alloc_name()), I
> would seriously consider converting d_alloc() from "NULL or new dentry"
> to "ERR_PTR(-ENOMEM) or new dentry".  Especially since quite a few of
> those callers will be happier that way.  Grep and you'll see...  As a
> side benefit, if (unlikely(!dentry)) turns into if (IS_ERR(dentry)).
>=20
> > +static struct dentry *lookup_hash_update(
> > +	const struct qstr *name,
> > +	struct dentry *base, unsigned int flags,
> > +	wait_queue_head_t *wq)
> > +{
> > +	struct dentry *dentry;
> > +	struct inode *dir =3D base->d_inode;
> > +	int err;
> > +
> > +	if (wq && IS_PAR_UPDATE(dir))
> > +		inode_lock_shared_nested(dir, I_MUTEX_PARENT);
> > +	else
> > +		inode_lock_nested(dir, I_MUTEX_PARENT);
> > +
> > +retry:
> > +	dentry =3D __lookup_hash(name, base, flags, wq);
> > +	if (IS_ERR(dentry)) {
> > +		err =3D PTR_ERR(dentry);
> > +		goto out_err;
> > +	}
> > +	if (!d_lock_update_nested(dentry, base, name, I_MUTEX_PARENT)) {
> > +		/*
> > +		 * Failed to get lock due to race with unlink or rename
> > +		 * - try again
> > +		 */
> > +		d_lookup_done(dentry);
>=20
> When would we get out of __lookup_hash() with in-lookup dentry?
> Confused...

Whenever wq is passed in and ->lookup() decides, based on the flags, to do
nothing.
NFS does this for LOOKUP_CREATE|LOOKUP_EXCL and for LOOKUP_RENAME_TARGET

>=20
> > +struct dentry *lookup_hash_update_len(const char *name, int nlen,
> > +				      struct path *path, unsigned int flags,
>=20
> 	const struct path *, damnit...

Sorry....

>=20
> > +				      wait_queue_head_t *wq)
> > +{
> > +	struct qstr this;
> > +	int err =3D lookup_one_common(mnt_user_ns(path->mnt), name,
> > +				    path->dentry, nlen, &this);
> > +	if (err)
> > +		return ERR_PTR(err);
> > +	return lookup_hash_update(&this, path->dentry, flags, wq);
> > +}
> > +EXPORT_SYMBOL(lookup_hash_update_len);
>=20
> Frankly, the calling conventions of the "..._one_len" family is something
> I've kept regretting for a long time.  Oh, well...
>=20
> > +static void done_path_update(struct path *path, struct dentry *dentry,
> > +			     bool with_wq)
> > +{
> > +	struct inode *dir =3D path->dentry->d_inode;
> > +
> > +	d_lookup_done(dentry);
> > +	d_unlock_update(dentry);
> > +	if (IS_PAR_UPDATE(dir) && with_wq)
> > +		inode_unlock_shared(dir);
> > +	else
> > +		inode_unlock(dir);
> > +}
>=20
> const struct path *, again...
>=20
> > @@ -3400,6 +3499,12 @@ static struct dentry *lookup_open(struct nameidata=
 *nd, struct file *file,
> >  			dentry =3D res;
> >  		}
> >  	}
> > +	/*
> > +	 * If dentry is negative and this is a create we need to get
> > +	 * DCACHE_PAR_UPDATE.
> > +	 */
> > +	if ((open_flag & O_CREAT) && !dentry->d_inode)
> > +		have_par_update =3D d_lock_update(dentry, NULL, NULL);
> > =20
> >  	/* Negative dentry, just create the file */
> >  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
>=20
> Fold the above here, please.  What's more, losing the flag would've
> made it much easier to follow...

Yes, that can certainly be tided up - thanks.

>=20
> > @@ -3419,9 +3524,13 @@ static struct dentry *lookup_open(struct nameidata=
 *nd, struct file *file,
> >  		error =3D create_error;
> >  		goto out_dput;
> >  	}
> > +	if (have_par_update)
> > +		d_unlock_update(dentry);
> >  	return dentry;
> > =20
> >  out_dput:
> > +	if (have_par_update)
> > +		d_unlock_update(dentry);
>=20
>=20
> > @@ -3821,27 +3962,28 @@ struct dentry *kern_path_create(int dfd, const ch=
ar *pathname,
> >  				struct path *path, unsigned int lookup_flags)
>=20
> BTW, there's 9 callers of that sucker in the entire tree, along with
> 3 callers of user_path_create() and 14 callers of done_path_create().
> Not a big deal to add the wq in those, especially since it can be easily
> split into preparatory patch (with wq passed, but being unused).
>=20
> > -void done_path_create(struct path *path, struct dentry *dentry)
> > +void done_path_create_wq(struct path *path, struct dentry *dentry, bool =
with_wq)
>=20
> Why "with_wq" and not the wq itself?
>=20

I did that at first.  However when I did silly rename in NFS I found
that I wanted to call the 'done' thing when I didn't still have the wq.
...which might mean I have a bug.

And the done_path_create_wq() doesn't do anything with the wq so ...

I'll look at that again - thanks.


> > - * The caller must hold dir->i_mutex.
> > + * The caller must either hold a write-lock on dir->i_rwsem, or
> > + * a have atomically set DCACHE_PAR_UPDATE, or both.
>=20
> ???

That's a hangover from an earlier version where I didn't set
DCACHE_PAR_UPDATE when we had an exclusive lock.  Will fix.


>=20
> > + * If the filesystem permits (IS_PAR_UPDATE()), we take a shared lock on=
 the
> > + * directory and set DCACHE_PAR_UPDATE to get exclusive access to the de=
ntry.
>=20
> The latter happens unconditionally here, unless I'm misreading the code (as=
 well
> as your cover letter).  It does *NOT* happen on rename(), though, contrary =
to
> the same.  And while your later patch adds it in lock_rename_lookup(), exis=
ting
> lock_rename() callers do not get that at all.  Likely to be a problem...

Between the patch were DCACHE_PAR_UPDATE is added and the patch were
lock_rename_lookup() is added, all filesystems use exclusive locks and
none of them check DCACHE_PAR_UPDATE.  So how can there be a problem?


>=20
> > --- a/include/linux/dcache.h
> > +++ b/include/linux/dcache.h
> > @@ -13,7 +13,9 @@
> >  #include <linux/rcupdate.h>
> >  #include <linux/lockref.h>
> >  #include <linux/stringhash.h>
> > +#include <linux/sched.h>
>=20
> Bloody hell, man...
>=20

I wonder what that was for .... removed.


> > +static inline void d_unlock_update(struct dentry *dentry)
> > +{
> > +	if (IS_ERR_OR_NULL(dentry))
> > +		return;
>=20
> Do explain...  When could we ever get NULL or ERR_PTR() passed to that?

Another hangover from earlier iterations - removed.  Thanks.

>=20
>=20
> BTW, I would seriously look into splitting the "let's add a helper
> that combines locking parent with __lookup_hash()" into a preliminary
> patch.  Would be easier to follow.
>=20
Will look into that.

Thanks a lot for the thorough review!

NeilBrown
