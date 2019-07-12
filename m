Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE26657C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 06:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfGLEPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 00:15:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60074 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfGLEPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 00:15:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlmxT-000330-0Q; Fri, 12 Jul 2019 04:14:55 +0000
Date:   Fri, 12 Jul 2019 05:14:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 01/10] namei: obey trailing magic-link DAC permissions
Message-ID: <20190712041454.GG17978@ZenIV.linux.org.uk>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-2-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706145737.5299-2-cyphar@cyphar.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 07, 2019 at 12:57:28AM +1000, Aleksa Sarai wrote:

> @@ -514,7 +516,14 @@ static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
>  	p->stack = p->internal;
>  	p->dfd = dfd;
>  	p->name = name;
> -	p->total_link_count = old ? old->total_link_count : 0;
> +	p->total_link_count = 0;
> +	p->acc_mode = 0;
> +	p->opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE;
> +	if (old) {
> +		p->total_link_count = old->total_link_count;
> +		p->acc_mode = old->acc_mode;
> +		p->opath_mask = old->opath_mask;
> +	}

Huh?  Could somebody explain why traversals of NFS4 referrals should inherit
->acc_mode and ->opath_mask?

>  static __always_inline
> -const char *get_link(struct nameidata *nd)
> +const char *get_link(struct nameidata *nd, bool trailing)
>  {
>  	struct saved *last = nd->stack + nd->depth - 1;
>  	struct dentry *dentry = last->link.dentry;
> @@ -1081,6 +1134,44 @@ const char *get_link(struct nameidata *nd)
>  		} else {
>  			res = get(dentry, inode, &last->done);
>  		}
> +		/* If we just jumped it was because of a magic-link. */
> +		if (unlikely(nd->flags & LOOKUP_JUMPED)) {

That's not quite guaranteed (it is possible to bind a symlink on top
of a regular file, and you will get LOOKUP_JUMPED on the entry into
trailing_symlink() when looking the result up).  Moreover, why bother
with LOOKUP_JUMPED here?  See that
	nd->last_type = LAST_BIND;
several lines prior?  That's precisely to be able to recognize those
suckers.

And _that_ would've avoided another piece of ugliness - your LOOKUP_JUMPED
kludge forces you to handle that cra^Wsclero^Wvaluable security hardening
in get_link(), instead of trailing_symlink() where you apparently want
it to be.  Simply because nd_jump_root() done later in get_link() will set
LOOKUP_JUMPED for absolute symlinks, confusing your test.

Moreover, I'm not sure that trailing_symlink() is the right place for
that either - I would be rather tempted to fold do_o_path() into
path_openat(), inline path_lookupat() there (as in
        s = path_init(nd, flags);

        while (!(error = link_path_walk(s, nd))
                && ((error = lookup_last(nd)) > 0)) {
                s = trailing_symlink(nd);
        }
        if (!error)
                error = complete_walk(nd);
        if (!error && nd->flags & LOOKUP_DIRECTORY)
                if (!d_can_lookup(nd->path.dentry))
                        error = -ENOTDIR;
        if (!error) {
                audit_inode(nd->name, nd->path.dentry, 0);
                error = vfs_open(&nd->path, file);
        }
        terminate_walk(nd);
- we don't need LOOKUP_DOWN there) and then we only care about the
two callers of trailing_symlink() that are in path_openat().  Which
is where you have your ->acc_mode and ->opath_mask without the need
to dump them into nameidata.  Or to bring that mess into the
things like stat(2) et.al. - it simply doesn't belong there.

In any case, this "bool trailing" is completely wrong; whether that
check belongs in trailing_symlink() or (some of) its callers, putting
it into get_link() is a mistake, forced by kludgy check for procfs-style
symlinks.
