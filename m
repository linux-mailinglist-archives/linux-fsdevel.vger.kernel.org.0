Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19E3774ED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 May 2021 04:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhEICW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 22:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhEICW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 22:22:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F34C061573;
        Sat,  8 May 2021 19:21:23 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lfZ3Y-00Cpon-FP; Sun, 09 May 2021 02:20:32 +0000
Date:   Sun, 9 May 2021 02:20:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
Message-ID: <YJdG8LhKBoFayOc+@zeniv-ca.linux.org.uk>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
 <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 08, 2021 at 01:39:45PM -0700, Linus Torvalds wrote:
> -static int prepend(char **buffer, int *buflen, const char *str, int namelen)
> +struct prepend_buffer {
> +	char *ptr;
> +	int len;
> +};
> +
> +static int prepend(struct prepend_buffer *b, const char *str, int namelen)
>  {
> -	*buflen -= namelen;
> -	if (*buflen < 0)
> +	b->len -= namelen;
> +	if (b->len < 0)
>  		return -ENAMETOOLONG;
> -	*buffer -= namelen;
> -	memcpy(*buffer, str, namelen);
> +	b->ptr -= namelen;
> +	memcpy(b->ptr, str, namelen);
>  	return 0;
>  }

OK, that part is pretty obvious - pointers to a couple of objects in the same
stack frame replaced with a single pointer to structure consisting of those
two objects.  Might actually be an optimization.

> @@ -35,16 +40,16 @@ static int prepend(char **buffer, int *buflen, const char *str, int namelen)
>   *
>   * Load acquire is needed to make sure that we see that terminating NUL.
>   */
> -static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
> +static int prepend_name(struct prepend_buffer *b, const struct qstr *name)
>  {
>  	const char *dname = smp_load_acquire(&name->name); /* ^^^ */
>  	u32 dlen = READ_ONCE(name->len);
>  	char *p;
>  
> -	*buflen -= dlen + 1;
> -	if (*buflen < 0)
> +	b->len -= dlen + 1;
> +	if (b->len < 0)
>  		return -ENAMETOOLONG;
> -	p = *buffer -= dlen + 1;
> +	p = b->ptr -= dlen + 1;
>  	*p++ = '/';
>  	while (dlen--) {
>  		char c = *dname++;

Ditto.

> @@ -55,6 +60,50 @@ static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
>  	return 0;
>  }
>  
> +static inline int prepend_entries(struct prepend_buffer *b, const struct path *path, const struct path *root, struct mount *mnt)
> +{
> +	struct dentry *dentry = path->dentry;
> +	struct vfsmount *vfsmnt = path->mnt;
> +
> +	while (dentry != root->dentry || vfsmnt != root->mnt) {
> +		int error;
> +		struct dentry * parent;
> +
> +		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
> +			struct mount *parent = READ_ONCE(mnt->mnt_parent);
> +			struct mnt_namespace *mnt_ns;
> +
> +			/* Escaped? */
> +			if (dentry != vfsmnt->mnt_root)
> +				return 3;
> +
> +			/* Global root? */
> +			if (mnt != parent) {
> +				dentry = READ_ONCE(mnt->mnt_mountpoint);
> +				mnt = parent;
> +				vfsmnt = &mnt->mnt;
> +				continue;
> +			}
> +			mnt_ns = READ_ONCE(mnt->mnt_ns);
> +			/* open-coded is_mounted() to use local mnt_ns */
> +			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
> +				return 1;	// absolute root
> +
> +			return 2;		// detached or not attached yet
> +			break;
> +		}
> +		parent = dentry->d_parent;
> +		prefetch(parent);
> +		error = prepend_name(b, &dentry->d_name);
> +		if (error)
> +			break;
> +
> +		dentry = parent;
> +	}
> +	return 0;
> +}

See other reply.

> +
>  /**
>   * prepend_path - Prepend path string to a buffer
>   * @path: the dentry/vfsmount to report
> @@ -74,15 +123,12 @@ static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
>   */
>  static int prepend_path(const struct path *path,
>  			const struct path *root,
> -			char **buffer, int *buflen)
> +			struct prepend_buffer *orig)
>  {
> -	struct dentry *dentry;
> -	struct vfsmount *vfsmnt;
>  	struct mount *mnt;
>  	int error = 0;
>  	unsigned seq, m_seq = 0;
> -	char *bptr;
> -	int blen;
> +	struct prepend_buffer b;
>  
>  	rcu_read_lock();
>  restart_mnt:
> @@ -90,50 +136,12 @@ static int prepend_path(const struct path *path,
>  	seq = 0;
>  	rcu_read_lock();
>  restart:
> -	bptr = *buffer;
> -	blen = *buflen;
> -	error = 0;
> -	dentry = path->dentry;
> -	vfsmnt = path->mnt;
> -	mnt = real_mount(vfsmnt);
> +	b = *orig;
> +	mnt = real_mount(path->mnt);
>  	read_seqbegin_or_lock(&rename_lock, &seq);
> -	while (dentry != root->dentry || vfsmnt != root->mnt) {
> -		struct dentry * parent;
>  
> -		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
> -			struct mount *parent = READ_ONCE(mnt->mnt_parent);
> -			struct mnt_namespace *mnt_ns;
> +	error = prepend_entries(&b, path, root, mnt);
>  
> -			/* Escaped? */
> -			if (dentry != vfsmnt->mnt_root) {
> -				bptr = *buffer;
> -				blen = *buflen;
> -				error = 3;
> -				break;
> -			}
> -			/* Global root? */
> -			if (mnt != parent) {
> -				dentry = READ_ONCE(mnt->mnt_mountpoint);
> -				mnt = parent;
> -				vfsmnt = &mnt->mnt;
> -				continue;
> -			}
> -			mnt_ns = READ_ONCE(mnt->mnt_ns);
> -			/* open-coded is_mounted() to use local mnt_ns */
> -			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
> -				error = 1;	// absolute root
> -			else
> -				error = 2;	// detached or not attached yet
> -			break;
> -		}
> -		parent = dentry->d_parent;
> -		prefetch(parent);
> -		error = prepend_name(&bptr, &blen, &dentry->d_name);
> -		if (error)
> -			break;
> -
> -		dentry = parent;
> -	}
>  	if (!(seq & 1))
>  		rcu_read_unlock();
>  	if (need_seqretry(&rename_lock, seq)) {
> @@ -150,14 +158,17 @@ static int prepend_path(const struct path *path,
>  	}
>  	done_seqretry(&mount_lock, m_seq);
>  
> -	if (error >= 0 && bptr == *buffer) {
> -		if (--blen < 0)
> +	// Escaped? No path
> +	if (error == 3)
> +		b = *orig;
> +
> +	if (error >= 0 && b.ptr == orig->ptr) {
> +		if (--b.len < 0)
>  			error = -ENAMETOOLONG;
>  		else
> -			*--bptr = '/';
> +			*--b.ptr = '/';
>  	}
> -	*buffer = bptr;
> -	*buflen = blen;
> +	*orig = b;
>  	return error;
>  }
>  
> @@ -181,34 +192,34 @@ char *__d_path(const struct path *path,
>  	       const struct path *root,
>  	       char *buf, int buflen)
>  {
> -	char *res = buf + buflen;
> +	struct prepend_buffer b = { buf + buflen, buflen };
>  	int error;
>  
> -	prepend(&res, &buflen, "\0", 1);
> -	error = prepend_path(path, root, &res, &buflen);
> +	prepend(&b, "\0", 1);
> +	error = prepend_path(path, root, &b);

Minor yuck: that should be "", 1 (in the original as well).  Same below...
Fairly subtle point: we do *not* need to check for failures here, since
prepend_path() will attempt to produce at least something.  And we'll
catch that failure just fine.  However, we do depend upon buflen being
non-negative here.  If we ever called that (or any other in that family,
really) with buflen == MIN_INT, we'd get seriously unpleasant results.
No such callers exist, thankfully.

>  char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> -	char *end = buffer + buflen;
> +	struct prepend_buffer b = { buffer + buflen, buflen };
> +
>  	/* these dentries are never renamed, so d_lock is not needed */
> -	if (prepend(&end, &buflen, " (deleted)", 11) ||
> -	    prepend(&end, &buflen, dentry->d_name.name, dentry->d_name.len) ||
> -	    prepend(&end, &buflen, "/", 1))  
> -		end = ERR_PTR(-ENAMETOOLONG);
> -	return end;
> +	if (prepend(&b, " (deleted)", 11) ||
> +	    prepend(&b, dentry->d_name.name, dentry->d_name.len) ||
> +	    prepend(&b, "/", 1))
> +		return ERR_PTR(-ENAMETOOLONG);
> +	return b.ptr;
>  }

Umm...  Interesting, especially considering the way dyname_dname() looks like.
char *dynamic_dname(struct dentry *dentry, char *buffer, int buflen,
                        const char *fmt, ...)
{
        va_list args;
        char temp[64];
        int sz;

        va_start(args, fmt);
        sz = vsnprintf(temp, sizeof(temp), fmt, args) + 1;
        va_end(args);

        if (sz > sizeof(temp) || sz > buflen)
                return ERR_PTR(-ENAMETOOLONG);

        buffer += buflen - sz;
        return memcpy(buffer, temp, sz);
}

Looks like there's a piece of prepend() open-coded in it.  And
since all ->d_dname() instances are either simple_dname() or end up
with call of dynamic_dname()...

Might make sense to turn that method into
	int (*d_dname)(struct dentry *, struct prepend_buffer *);

Followup patch, obviously, but it might be worth looking into.

Another thing that keeps bugging me about prepend_path() is the
set of return values.  I mean, 0/1/2/3/-ENAMETOOLONG, and all
except 0 are unlikely?  Might as well make that 0/1/2/3/-1, if
not an outright 0/1/2/3/4.  And prepend() could return bool, while
we are at it (true - success, false - overflow)...
