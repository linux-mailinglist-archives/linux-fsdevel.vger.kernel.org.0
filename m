Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4735137741B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhEHVHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEHVHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 17:07:30 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E13C061574;
        Sat,  8 May 2021 14:06:28 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lfU8u-00Cktr-Je; Sat, 08 May 2021 21:05:44 +0000
Date:   Sat, 8 May 2021 21:05:44 +0000
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
Message-ID: <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
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

> +static inline int prepend_entries(struct prepend_buffer *b, const struct path *path, const struct path *root, struct mount *mnt)

If anything, s/path/dentry/, since vfsmnt here will be equal to &mnt->mnt all along.

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

?

> +		}
> +		parent = dentry->d_parent;
> +		prefetch(parent);
> +		error = prepend_name(b, &dentry->d_name);
> +		if (error)
> +			break;

return error, surely?

> +		dentry = parent;
> +	}
> +	return 0;
> +}

FWIW, if we go that way, I would make that

	while (dentry != root->dentry || &mnt->mnt != root->mnt) {
		int error;
		struct dentry *parent = READ_ONCE(dentry->d_parent);

		if (unlikely(dentry == mnt->mnt.mnt_root)) {
			struct mount *m = READ_ONCE(mnt->mnt_parent);

			/* Global root? */
			if (unlikely(mnt == m) {
				struct mnt_namespace *mnt_ns;

				mnt_ns = READ_ONCE(mnt->mnt_ns);
				/* open-coded is_mounted() to use local mnt_ns */
				if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
					return 1;	// absolute root
				else
					return 2;	// detached or not attached yet
			}
			// cross into whatever it's mounted on
			dentry = READ_ONCE(mnt->mnt_mountpoint);
			mnt = m;
			continue;
		}

		/* Escaped? */
		if (unlikely(dentry == parent))
			return 3;

		prefetch(parent);
		error = prepend_name(b, &dentry->d_name);
		if (error)
			return error;
		dentry = parent;
	}
	return 0;
