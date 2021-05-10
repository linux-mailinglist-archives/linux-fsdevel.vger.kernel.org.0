Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF1377D04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 09:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhEJHWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 03:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhEJHV4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 03:21:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9EE3600CD;
        Mon, 10 May 2021 07:20:45 +0000 (UTC)
Date:   Mon, 10 May 2021 09:20:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20210510072043.lde2n3hbk7lgeddv@wittgenstein>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
 <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
 <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
 <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
 <YJcbkJxrFAheQ5yO@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJcbkJxrFAheQ5yO@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 08, 2021 at 11:15:28PM +0000, Al Viro wrote:
> On Sat, May 08, 2021 at 10:46:23PM +0000, Al Viro wrote:
> > On Sat, May 08, 2021 at 03:17:44PM -0700, Linus Torvalds wrote:
> > > On Sat, May 8, 2021 at 2:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Sat, May 08, 2021 at 01:39:45PM -0700, Linus Torvalds wrote:
> > > >
> > > > > +static inline int prepend_entries(struct prepend_buffer *b, const struct path *path, const struct path *root, struct mount *mnt)
> > > >
> > > > If anything, s/path/dentry/, since vfsmnt here will be equal to &mnt->mnt all along.
> > > 
> > > Too subtle for me.
> > > 
> > > And is it? Because mnt is from
> > > 
> > >      mnt = real_mount(path->mnt);
> > > 
> > > earlier, while vfsmount is plain "path->mnt".
> > 
> > static inline struct mount *real_mount(struct vfsmount *mnt)
> > {
> >         return container_of(mnt, struct mount, mnt);
> > }
> 
> Basically, struct vfsmount instances are always embedded into struct mount ones.
> All information about the mount tree is in the latter (and is visible only if
> you manage to include fs/mount.h); here we want to walk towards root, so...
> 
> Rationale: a lot places use struct vfsmount pointers, but they've no need to
> access all that stuff.  So struct vfsmount got trimmed down, with most of the
> things that used to be there migrating into the containing structure.
> 
> [Christian Browner Cc'd]
> BTW, WTF do we have struct mount.user_ns and struct vfsmount.mnt_userns?
> Can they ever be different?  Christian?

Yes, they can.

> 
> 	Sigh...  Namespace flavours always remind me of old joke -
> Highlander II: There Should've Been Only One...

(I'd prefer if mount propagation would die first.)
