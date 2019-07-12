Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0934066FFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfGLN0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 09:26:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38536 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfGLN0T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:26:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlvYf-0008I4-Sv; Fri, 12 Jul 2019 13:25:53 +0000
Date:   Fri, 12 Jul 2019 14:25:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190712132553.GN17978@ZenIV.linux.org.uk>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
 <20190712125552.GL17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712125552.GL17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 01:55:52PM +0100, Al Viro wrote:
> On Fri, Jul 12, 2019 at 01:39:24PM +0100, Al Viro wrote:
> > On Fri, Jul 12, 2019 at 08:57:45PM +1000, Aleksa Sarai wrote:
> > 
> > > > > @@ -2350,9 +2400,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
> > > > >  			s = ERR_PTR(error);
> > > > >  		return s;
> > > > >  	}
> > > > > -	error = dirfd_path_init(nd);
> > > > > -	if (unlikely(error))
> > > > > -		return ERR_PTR(error);
> > > > > +	if (likely(!nd->path.mnt)) {
> > > > 
> > > > Is that a weird way of saying "if we hadn't already called dirfd_path_init()"?
> > > 
> > > Yes. I did it to be more consistent with the other "have we got the
> > > root" checks elsewhere. Is there another way you'd prefer I do it?
> > 
> > "Have we got the root" checks are inevitable evil; here you are making the
> > control flow in a single function hard to follow.
> > 
> > I *think* what you are doing is
> > 	absolute pathname, no LOOKUP_BENEATH:
> > 		set_root
> > 		error = nd_jump_root(nd)
> > 	else
> > 		error = dirfd_path_init(nd)
> > 	return unlikely(error) ? ERR_PTR(error) : s;
> > which should be a lot easier to follow (not to mention shorter), but I might
> > be missing something in all of that.
> 
> PS: if that's what's going on, I would be tempted to turn the entire
> path_init() part into this:
> 	if (flags & LOOKUP_BENEATH)
> 		while (*s == '/')
> 			s++;
> in the very beginning (plus the handling of nd_jump_root() prototype
> change, but that belongs with nd_jump_root() change itself, obviously).
> Again, I might be missing something here...

Argh... I am, at that - you have setting path->root (and grabbing it)
in LOOKUP_BENEATH cases and you do it after dirfd_path_init().  So
how about
	if (flags & LOOKUP_BENEATH)
		while (*s == '/')
			s++;
before the whole thing and
        if (*s == '/') { /* can happen only without LOOKUP_BENEATH */
                set_root(nd);
		error = nd_jump_root(nd);
		if (unlikely(error))
			return ERR_PTR(error);
        } else if (nd->dfd == AT_FDCWD) {
                if (flags & LOOKUP_RCU) {
                        struct fs_struct *fs = current->fs;
                        unsigned seq;

                        do {
                                seq = read_seqcount_begin(&fs->seq);
                                nd->path = fs->pwd;
                                nd->inode = nd->path.dentry->d_inode;
                                nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
                        } while (read_seqcount_retry(&fs->seq, seq));
                } else {
                        get_fs_pwd(current->fs, &nd->path);
                        nd->inode = nd->path.dentry->d_inode;
                }  
        } else {
                /* Caller must check execute permissions on the starting path component */
                struct fd f = fdget_raw(nd->dfd);
                struct dentry *dentry;

                if (!f.file)
                        return ERR_PTR(-EBADF);

                dentry = f.file->f_path.dentry;

                if (*s && unlikely(!d_can_lookup(dentry))) {
                        fdput(f);
                        return ERR_PTR(-ENOTDIR);
                }

                nd->path = f.file->f_path;
                if (flags & LOOKUP_RCU) {
                        nd->inode = nd->path.dentry->d_inode;
                        nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
                } else {
                        path_get(&nd->path);
                        nd->inode = nd->path.dentry->d_inode;
                }
                fdput(f);
        }
	if (flags & LOOKUP_BENEATH) {
		nd->root = nd->path;
		if (!(flags & LOOKUP_RCU))
			path_get(&nd->root);
		else
			nd->root_seq = nd->seq;
	}
	return s;
replacing the part in the end?  Makes for much smaller change; it might
very well still make sense to add dirfd_path_init() as a separate
cleanup (perhaps with the *s == '/' case included), though.
