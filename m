Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D835A342A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 05:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbiH0Dn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 23:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH0Dnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 23:43:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89363D87E4;
        Fri, 26 Aug 2022 20:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=05GtvXoqS4aIVpKzXdAUOgzJxImCTAiKDdwQO01zfbE=; b=kZCtU96MDGV/R645euFUW1xoAp
        YvzbRxSY91q5TrBPrL94BIhtuG9eHBoJcr+TjatVMA3o9TQX3LpNZW3ACpxvTanOOot929LjcszHa
        Y4TLOMPESc+onmnKQ/PcqwVp/bAxsArYgr+VyiZ/HxAo+HPIW3HGcRppc/PLQ9EJTEYsoQmr2CAD1
        u2nHoAYG3obVVlP8GYs8RlFUSxJYDVQErd3wPFz43/t/3P53mJr7TCPUrnvCjJ3inssahkCH0hXdx
        cVMi9ievh6SW1ltIMXw8+vNmF+sTomaSAme9Hedz81NGgDkSApicL0K8OLL/OLcex5dpHkdeIrWq+
        OS4b3HVQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRmjT-008rdT-IG;
        Sat, 27 Aug 2022 03:43:39 +0000
Date:   Sat, 27 Aug 2022 04:43:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
Message-ID: <YwmS63X3Sm4bhlcT@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166147984370.25420.13019217727422217511.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:10:43PM +1000, NeilBrown wrote:

> +/**
> + * d_lock_update_nested - lock a dentry before updating
> + * @dentry: the dentry to be locked
> + * @base:   the parent, or %NULL
> + * @name:   the name in that parent, or %NULL
> + * @subclass: lockdep locking class.
> + *
> + * Lock a dentry in a directory on which a shared-lock may be held, and
> + * on which parallel updates are permitted.
> + * If the base and name are given, then on success the dentry will still
> + * have that base and name - it will not have raced with rename.
> + * On success, a positive dentry will still be hashed, ensuring there
> + * was no race with unlink.
> + * If they are not given, then on success the dentry will be negative,
> + * which again ensures no race with rename, or unlink.

I'm not sure it's a good idea to have that in one function, TBH.
Looking at the callers, there are
	* lookup_hash_update()
		lookup_hash_update_len()
			nfsd shite
		filename_create_one()
			filename_create_one_len()
				nfsd shite
			filename_create()
				kern_path_create()
				user_path_create()
				do_mknodat()
				do_mkdirat()
				do_symlinkat()
				do_linkat()
		do_rmdir()
		do_unlinkat()
	* fuckloads of callers in lock_rename_lookup()
	* d_lock_update()
		atomic_open()
		lookup_open()

Only the last two can get NULL base or name.  Already interesting,
isn't it?  What's more, splitup between O_CREATE open() on one
side and everything else that might create, remove or rename on
the other looks really weird.

> +	rcu_read_lock(); /* for d_same_name() */
> +	if (d_unhashed(dentry) && d_is_positive(dentry)) {
> +		/* name was unlinked while we waited */
> +		ret = false;

BTW, what happens if somebody has ->lookup() returning a positive
unhashed?  Livelock on attempt to hit it with any directory-modifying
syscall?  Right now such behaviour is permitted; I don't know if
anything in the tree actually does it, but at the very least it
would need to be documented.

Note that *negative* unhashed is not just permitted, it's
actively used e.g. by autofs.  That really needs to be well
commented...

> +	} else if (base &&
> +		 (dentry->d_parent != base ||
> +		  dentry->d_name.hash != name->hash ||
> +		  !d_same_name(dentry, base, name))) {
> +		/* dentry was renamed - possibly silly-rename */
> +		ret = false;
> +	} else if (!base && d_is_positive(dentry)) {
> +		ret = false;
> +	} else {
> +		dentry->d_flags |= DCACHE_PAR_UPDATE;
> +	}

> + * Parent directory has inode locked exclusive, or possibly shared if wq
> + * is given.  In the later case the fs has explicitly allowed concurrent
> + * updates in this directory.  This is the one and only case
> + * when ->lookup() may be called on a non in-lookup dentry.

What Linus already said about wq...  To add a reason he hadn't mentioned,
the length of call chain one needs to track to figure out whether it's
NULL or not is... excessive.  And I don't mean just "greater than 0".
We have places like that, and sometimes we have to, but it's never a good
thing...

>  static struct dentry *__lookup_hash(const struct qstr *name,
> -		struct dentry *base, unsigned int flags)
> +				    struct dentry *base, unsigned int flags,
> +				    wait_queue_head_t *wq)

> -	dentry = d_alloc(base, name);
> +	if (wq)
> +		dentry = d_alloc_parallel(base, name, wq);
> +	else
> +		dentry = d_alloc(base, name);
>  	if (unlikely(!dentry))
>  		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(dentry))
> +		return dentry;

	BTW, considering the fact that we have 12 callers of d_alloc()
(including this one) and 28 callers of its wrapper (d_alloc_name()), I
would seriously consider converting d_alloc() from "NULL or new dentry"
to "ERR_PTR(-ENOMEM) or new dentry".  Especially since quite a few of
those callers will be happier that way.  Grep and you'll see...  As a
side benefit, if (unlikely(!dentry)) turns into if (IS_ERR(dentry)).

> +static struct dentry *lookup_hash_update(
> +	const struct qstr *name,
> +	struct dentry *base, unsigned int flags,
> +	wait_queue_head_t *wq)
> +{
> +	struct dentry *dentry;
> +	struct inode *dir = base->d_inode;
> +	int err;
> +
> +	if (wq && IS_PAR_UPDATE(dir))
> +		inode_lock_shared_nested(dir, I_MUTEX_PARENT);
> +	else
> +		inode_lock_nested(dir, I_MUTEX_PARENT);
> +
> +retry:
> +	dentry = __lookup_hash(name, base, flags, wq);
> +	if (IS_ERR(dentry)) {
> +		err = PTR_ERR(dentry);
> +		goto out_err;
> +	}
> +	if (!d_lock_update_nested(dentry, base, name, I_MUTEX_PARENT)) {
> +		/*
> +		 * Failed to get lock due to race with unlink or rename
> +		 * - try again
> +		 */
> +		d_lookup_done(dentry);

When would we get out of __lookup_hash() with in-lookup dentry?
Confused...

> +struct dentry *lookup_hash_update_len(const char *name, int nlen,
> +				      struct path *path, unsigned int flags,

	const struct path *, damnit...

> +				      wait_queue_head_t *wq)
> +{
> +	struct qstr this;
> +	int err = lookup_one_common(mnt_user_ns(path->mnt), name,
> +				    path->dentry, nlen, &this);
> +	if (err)
> +		return ERR_PTR(err);
> +	return lookup_hash_update(&this, path->dentry, flags, wq);
> +}
> +EXPORT_SYMBOL(lookup_hash_update_len);

Frankly, the calling conventions of the "..._one_len" family is something
I've kept regretting for a long time.  Oh, well...

> +static void done_path_update(struct path *path, struct dentry *dentry,
> +			     bool with_wq)
> +{
> +	struct inode *dir = path->dentry->d_inode;
> +
> +	d_lookup_done(dentry);
> +	d_unlock_update(dentry);
> +	if (IS_PAR_UPDATE(dir) && with_wq)
> +		inode_unlock_shared(dir);
> +	else
> +		inode_unlock(dir);
> +}

const struct path *, again...

> @@ -3400,6 +3499,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  			dentry = res;
>  		}
>  	}
> +	/*
> +	 * If dentry is negative and this is a create we need to get
> +	 * DCACHE_PAR_UPDATE.
> +	 */
> +	if ((open_flag & O_CREAT) && !dentry->d_inode)
> +		have_par_update = d_lock_update(dentry, NULL, NULL);
>  
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {

Fold the above here, please.  What's more, losing the flag would've
made it much easier to follow...

> @@ -3419,9 +3524,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		error = create_error;
>  		goto out_dput;
>  	}
> +	if (have_par_update)
> +		d_unlock_update(dentry);
>  	return dentry;
>  
>  out_dput:
> +	if (have_par_update)
> +		d_unlock_update(dentry);


> @@ -3821,27 +3962,28 @@ struct dentry *kern_path_create(int dfd, const char *pathname,
>  				struct path *path, unsigned int lookup_flags)

BTW, there's 9 callers of that sucker in the entire tree, along with
3 callers of user_path_create() and 14 callers of done_path_create().
Not a big deal to add the wq in those, especially since it can be easily
split into preparatory patch (with wq passed, but being unused).

> -void done_path_create(struct path *path, struct dentry *dentry)
> +void done_path_create_wq(struct path *path, struct dentry *dentry, bool with_wq)

Why "with_wq" and not the wq itself?

> - * The caller must hold dir->i_mutex.
> + * The caller must either hold a write-lock on dir->i_rwsem, or
> + * a have atomically set DCACHE_PAR_UPDATE, or both.

???

> + * If the filesystem permits (IS_PAR_UPDATE()), we take a shared lock on the
> + * directory and set DCACHE_PAR_UPDATE to get exclusive access to the dentry.

The latter happens unconditionally here, unless I'm misreading the code (as well
as your cover letter).  It does *NOT* happen on rename(), though, contrary to
the same.  And while your later patch adds it in lock_rename_lookup(), existing
lock_rename() callers do not get that at all.  Likely to be a problem...

> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -13,7 +13,9 @@
>  #include <linux/rcupdate.h>
>  #include <linux/lockref.h>
>  #include <linux/stringhash.h>
> +#include <linux/sched.h>

Bloody hell, man...

> +static inline void d_unlock_update(struct dentry *dentry)
> +{
> +	if (IS_ERR_OR_NULL(dentry))
> +		return;

Do explain...  When could we ever get NULL or ERR_PTR() passed to that?


BTW, I would seriously look into splitting the "let's add a helper
that combines locking parent with __lookup_hash()" into a preliminary
patch.  Would be easier to follow.
