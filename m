Return-Path: <linux-fsdevel+bounces-1471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9A7DA527
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 06:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B279F2827E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 04:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866087FD;
	Sat, 28 Oct 2023 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VX0ENCDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A5387
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 04:46:51 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F1811B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 21:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SpA+rE8p7mmNlDFC4/WwEVr83oI44kkLgXBVqzS5x5E=; b=VX0ENCDhr8Npbk9TloO8GoQ00V
	y7m6MvKumvIb8z/RgByZQeicQfHuONXbwNHJxdfZ7N4yG6LkiR55/peITfMcOJVduOjzXB96XY+6x
	OzCs9llGe7EQhU5Evtj7jv6eQ1TCKgkIRn5Ooe7j/AaLFyTrkuSeStdXVsQym8D55OqvSOtfOO0BI
	x6unkD5Tcj8cgN1BIRR61Gi0QWbHb6eC/LVc1iyVPki7NG7ZfCxQWUbCuqNDBTsuShO9Fc1U1fWDh
	ju+k6yiPKAY5Z54dG8rVOORyXbmHrt9QBasHlyGYlY151DuRsW1gofomUhoYXtsVO4Y8w7xsmc1xg
	NMqYW53Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwbDi-006ssm-0h;
	Sat, 28 Oct 2023 04:46:46 +0000
Date: Sat, 28 Oct 2023 05:46:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	miklos@szeredi.hu, dsingh@ddn.com,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v10 4/8] [RFC] Allow atomic_open() on positive dentry
 (w/o O_CREAT)
Message-ID: <20231028044646.GS800259@ZenIV>
References: <20231023183035.11035-1-bschubert@ddn.com>
 <20231023183035.11035-5-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023183035.11035-5-bschubert@ddn.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 23, 2023 at 08:30:31PM +0200, Bernd Schubert wrote:

> Previous patch allowed atomic-open on a positive dentry when
> O_CREAT was set (in lookup_open). This adds in atomic-open
> when O_CREAT is not set.
> 
> Code wise it would be possible to just drop the dentry in
> open_last_lookups and then fall through to lookup_open.
> But then this would add some overhead for dentry drop,
> re-lookup and actually also call into d_revalidate.
> So as suggested by Miklos, this adds a helper function
> (atomic_revalidate_open) to immediately open the dentry
> with atomic_open.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/namei.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 3 deletions(-)

This is bloody awful.
 
> diff --git a/fs/namei.c b/fs/namei.c
> index ff913e6b12b4..5e2d569ffe38 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1614,10 +1614,11 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
>  }
>  EXPORT_SYMBOL(lookup_one_qstr_excl);
>  
> -static struct dentry *lookup_fast(struct nameidata *nd)
> +static struct dentry *lookup_fast(struct nameidata *nd, bool *atomic_revalidate)

Yechhh...  Note that absolute majority of calls will be nowhere near
the case when that atomic_revalidate thing might possibly be set.

>  {
>  	struct dentry *dentry, *parent = nd->path.dentry;
>  	int status = 1;
> +	*atomic_revalidate = false;
>  
>  	/*
>  	 * Rename seqlock is not required here because in the off chance
> @@ -1659,6 +1660,10 @@ static struct dentry *lookup_fast(struct nameidata *nd)
>  		dput(dentry);
>  		return ERR_PTR(status);
>  	}
> +
> +	if (status == D_REVALIDATE_ATOMIC)
> +		*atomic_revalidate = true;
> +
>  	return dentry;
>  }

 
> @@ -1984,6 +1989,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
>  static const char *walk_component(struct nameidata *nd, int flags)
>  {
>  	struct dentry *dentry;
> +	bool atomic_revalidate;
>  	/*
>  	 * "." and ".." are special - ".." especially so because it has
>  	 * to be able to know about the current root directory and
> @@ -1994,7 +2000,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
>  			put_link(nd);
>  		return handle_dots(nd, nd->last_type);
>  	}
> -	dentry = lookup_fast(nd);
> +	dentry = lookup_fast(nd, &atomic_revalidate);
>  	if (IS_ERR(dentry))
>  		return ERR_CAST(dentry);
>  	if (unlikely(!dentry)) {
> @@ -2002,6 +2008,9 @@ static const char *walk_component(struct nameidata *nd, int flags)
>  		if (IS_ERR(dentry))
>  			return ERR_CAST(dentry);
>  	}
> +
> +	WARN_ON_ONCE(atomic_revalidate);
> +
>  	if (!(flags & WALK_MORE) && nd->depth)
>  		put_link(nd);
>  	return step_into(nd, flags, dentry);
> @@ -3383,6 +3392,42 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
>  	return dentry;
>  }
  
> +static struct dentry *atomic_revalidate_open(struct dentry *dentry,
> +					     struct nameidata *nd,
> +					     struct file *file,
> +					     const struct open_flags *op,
> +					     bool *got_write)
> +{
> +	struct mnt_idmap *idmap;
> +	struct dentry *dir = nd->path.dentry;
> +	struct inode *dir_inode = dir->d_inode;
> +	int open_flag = op->open_flag;
> +	umode_t mode = op->mode;
> +
> +	if (unlikely(IS_DEADDIR(dir_inode)))
> +		return ERR_PTR(-ENOENT);

What's the point of doing that check when there's nothing to stop
directory from being removed right under you?  Note that similar
check in lookup_open() is done after the caller has locked the
damn thing.

> +	file->f_mode &= ~FMODE_CREATED;
> +
> +	if (WARN_ON_ONCE(open_flag & O_CREAT))
> +		return ERR_PTR(-EINVAL);

Really.  With the only caller being under

        int open_flag = op->open_flag;
	...
	if (!(open_flag & O_CREAT)) {

> +
> +	if (open_flag & (O_TRUNC | O_WRONLY | O_RDWR))
> +		*got_write = !mnt_want_write(nd->path.mnt);
> +	else
> +		*got_write = false;
> +
> +	if (!*got_write)
> +		open_flag &= ~O_TRUNC;
> +
> +	inode_lock_shared(dir->d_inode);
> +	dentry = atomic_open(nd, dentry, file, open_flag, mode);
> +	inode_unlock_shared(dir->d_inode);

What will happen if you get that thing called with NULL ->i_op->atomic_open()?
> +
> +	return dentry;
> +
> +}
> +
>  /*
>   * Look up and maybe create and open the last component.
>   *
> @@ -3527,12 +3572,26 @@ static const char *open_last_lookups(struct nameidata *nd,
>  	}
>  
>  	if (!(open_flag & O_CREAT)) {
> +		bool atomic_revalidate;
> +
>  		if (nd->last.name[nd->last.len])
>  			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>  		/* we _can_ be in RCU mode here */
> -		dentry = lookup_fast(nd);
> +		dentry = lookup_fast(nd, &atomic_revalidate);
>  		if (IS_ERR(dentry))
>  			return ERR_CAST(dentry);
> +		if (dentry && unlikely(atomic_revalidate)) {
> +			/* The file system shall not claim to support atomic
> +			 * revalidate in RCU mode
> +			 */
> +			if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU)) {
> +				dput(dentry);

dput() under rcu_read_lock()?  For one thing, it's completely wrong
as far as recovery strategy goes; we do *NOT* grab references under
LOOKUP_RCU, so whatever we got here is not a counting reference.
What's more, your comment is actively misleading - you set that
atomic_revalidate thing in the very end of lookup_fast() and
there is no way to get there with LOOKUP_RCU.  Look:

static struct dentry *lookup_fast(struct nameidata *nd)
{
        ...
        if (nd->flags & LOOKUP_RCU) {
		...
                status = d_revalidate(dentry, nd->flags);
                if (likely(status > 0))
                        return dentry;
That's where we leave if we'd found and successfully
revalidated a dentry in RCU mode.
                if (!try_to_unlazy_next(nd, dentry))
                        return ERR_PTR(-ECHILD);
... and this is where we'd already left the RCU mode.
                if (status == -ECHILD)
                        /* we'd been told to redo it in non-rcu mode */
                        status = d_revalidate(dentry, nd->flags);
	} else {
here we hadn't been in RCU mode to start with and we *never*
switch from non-RCU to RCU.
		...
	}
	// and here you set that flag of yours.

So no matter what your ->d_revalidate() returns, you are
not going to see atomic_... shite set in RCU mode.  It's not
a matter of filesystem behaviour, contrary to your comment.

> +				return ERR_PTR(-ECHILD);
> +			}
> +			dentry = atomic_revalidate_open(dentry, nd, file, op,
> +							&got_write);
> +			goto drop_write;
> +		}
>  		if (likely(dentry))
>  			goto finish_lookup;
>  
> @@ -3569,6 +3628,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  	else
>  		inode_unlock_shared(dir->d_inode);
>  
> +drop_write:
>  	if (got_write)
>  		mnt_drop_write(nd->path.mnt);

That helper of yours is a bad idea.  Control flow in that area is
messy and hard to follow as it is, and we had _MANY_ bugs stemming
from that.  You are making it harder to follow; this stuff really
should've gone into lookup_open().

And I really hate that 'atomic_revalidate' thing of yours.
Especially since the reader gets to do major head-scratching about
the WARN_ON_ONCE(atomic_revalidate) in walk_component().  Takes
guessing that it's probably a matter of LOOKUP_OPEN *not* being
there in walk_component() and always being there in the
open_last_lookups() (we never get there for O_PATH opens, so
op->intent will have it).  So at a guess you mean to have
->d_revalidate() only return that magical value if LOOKUP_OPEN
is present in flags.  Which seems to be the case, judging by
the subsequent patches in the series.

_IF_ we want to go in that direction, at least make it
	if (status == THAT_MAGIC_VALUE) {
		if (unlikely(!atomic_revalidate)) {
			if (WARN_ON_ONCE(nd->flags & LOOKUP_OPEN))
				// insane caller
				;
			else
				// insane ->d_revalidate() instance
				WARN_ON_ONCE(1);
		} else {
			*atomic_revalidate = true;
		}
	}
and pass it NULL when calling it from walk_component().

Again, I'm not at all sure it's a good idea to start with.  Hard to
tell without seeing how it'll look after massage that would move
that new call of atomic_open() down into lookup_open().

