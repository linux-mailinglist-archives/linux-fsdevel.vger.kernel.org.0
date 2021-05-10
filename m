Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1484E378F2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbhEJNeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 09:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240116AbhEJMxD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 08:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2040611BD;
        Mon, 10 May 2021 12:51:50 +0000 (UTC)
Date:   Mon, 10 May 2021 14:51:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
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
Message-ID: <20210510125147.tkgeurcindldiwxg@wittgenstein>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
 <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
 <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
 <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
 <YJcbkJxrFAheQ5yO@zeniv-ca.linux.org.uk>
 <m1r1ifzf8x.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m1r1ifzf8x.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 09, 2021 at 05:58:22PM -0500, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Sat, May 08, 2021 at 10:46:23PM +0000, Al Viro wrote:
> >> On Sat, May 08, 2021 at 03:17:44PM -0700, Linus Torvalds wrote:
> >> > On Sat, May 8, 2021 at 2:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> > >
> >> > > On Sat, May 08, 2021 at 01:39:45PM -0700, Linus Torvalds wrote:
> >> > >
> >> > > > +static inline int prepend_entries(struct prepend_buffer *b, const struct path *path, const struct path *root, struct mount *mnt)
> >> > >
> >> > > If anything, s/path/dentry/, since vfsmnt here will be equal to &mnt->mnt all along.
> >> > 
> >> > Too subtle for me.
> >> > 
> >> > And is it? Because mnt is from
> >> > 
> >> >      mnt = real_mount(path->mnt);
> >> > 
> >> > earlier, while vfsmount is plain "path->mnt".
> >> 
> >> static inline struct mount *real_mount(struct vfsmount *mnt)
> >> {
> >>         return container_of(mnt, struct mount, mnt);
> >> }
> >
> > Basically, struct vfsmount instances are always embedded into struct mount ones.
> > All information about the mount tree is in the latter (and is visible only if
> > you manage to include fs/mount.h); here we want to walk towards root, so...
> >
> > Rationale: a lot places use struct vfsmount pointers, but they've no need to
> > access all that stuff.  So struct vfsmount got trimmed down, with most of the
> > things that used to be there migrating into the containing structure.
> >
> > [Christian Browner Cc'd]
> > BTW, WTF do we have struct mount.user_ns and struct vfsmount.mnt_userns?
> > Can they ever be different?  Christian?
> 
> I presume you are asking about struct mnt_namespace.user_ns and
> struct vfsmount.mnt_userns.
> 
> That must the idmapped mounts work.
> 
> In short mnt_namespace.user_ns is the user namespace that owns
> the mount namespace.
> 
> vfsmount.mnt_userns functionally could be reduced to just some struct
> uid_gid_map structures hanging off the vfsmount.  It's purpose is

No. The userns can in the future be used for permission checking when
delegating features per mount.

> to add a generic translation of uids and gids on from the filesystem
> view to the what we want to show userspace.
> 
> That code could probably benefit from some refactoring so it is clearer,
> and some serious fixes.  I reported it earlier but it looks like there
> is some real breakage in chown if you use idmapped mounts.

You mentioned something about chown already some weeks ago here [1] and
never provided any details or reproducer for it. This code is
extensively covered by xfstests and systemd and others are already using
it so far without any issues reported by users. If there is an issue,
it'd be good to fix them and see the tests changed to cover that
particular case.

[1]: https://lore.kernel.org/lkml/20210213130042.828076-1-christian.brauner@ubuntu.com/T/#m3a9df31aa183e8797c70bc193040adfd601399ad
