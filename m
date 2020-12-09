Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F682D4742
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 17:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgLIQzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 11:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgLIQzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:55:13 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF29C0613CF;
        Wed,  9 Dec 2020 08:54:30 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn2jD-00069h-L7; Wed, 09 Dec 2020 16:54:11 +0000
Date:   Wed, 9 Dec 2020 16:54:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 09/24] file: Replace fcheck_files with
 files_lookup_fd_rcu
Message-ID: <20201209165411.GA16743@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-9-ebiederm@xmission.com>
 <20201207224656.GC4115853@ZenIV.linux.org.uk>
 <20201207224903.GA4117703@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207224903.GA4117703@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[paulmck Cc'd]

On Mon, Dec 07, 2020 at 10:49:04PM +0000, Al Viro wrote:
> On Mon, Dec 07, 2020 at 10:46:57PM +0000, Al Viro wrote:
> > On Fri, Nov 20, 2020 at 05:14:26PM -0600, Eric W. Biederman wrote:
> > 
> > >  /*
> > >   * Check whether the specified fd has an open file.
> > >   */
> > > -#define fcheck(fd)	fcheck_files(current->files, fd)
> > > +#define fcheck(fd)	files_lookup_fd_rcu(current->files, fd)
> > 
> > Huh?
> > fs/file.c:1113: file = fcheck(oldfd);
> > 	dup3(), under ->file_lock, no rcu_read_lock() in sight
> > 
> > fs/locks.c:2548:                f = fcheck(fd);
> > 	fcntl_setlk(), ditto
> > 
> > fs/locks.c:2679:                f = fcheck(fd);
> > 	fcntl_setlk64(), ditto
> > 
> > fs/notify/dnotify/dnotify.c:330:        f = fcheck(fd);
> > 	fcntl_dirnotify(); this one _is_ under rcu_read_lock().
> > 
> > 
> > IOW, unless I've missed something earlier in the series, this is wrong.
> 
> I have missed something, all right.  Ignore that comment...

Actually, I take that back - the use of fcheck() in dnotify _is_ interesting.
At the very least it needs to be commented upon; what that code is trying
to prevent is a race between fcntl_dirnotify() and close(2)/dup2(2) closing
the descriptor in question.  The problem is, dnotify marks are removed
when we detach from descriptor table; that's done by filp_close() calling
dnotify_flush().

Suppose fcntl(fd, F_NOTIFY, 0) in one thread races with close(fd) in another
(both sharing the same descriptor table).  If the former had created and
inserted a mark *after* the latter has gotten past dnotify_flush(), there
would be nothing to evict that mark.

That's the reason that fcheck() is there.  rcu_read_lock() used to be
sufficient, but the locking has changed since then and even if it is
still enough, that's not at all obvious.

Exclusion is not an issue; barriers, OTOH...  Back then we had
->i_lock taken both by dnotify_flush() before any checks and
by fcntl_dirnotify() around the fcheck+insertion.  So on close
side we had
	store NULL into descriptor table
	acquire ->i_lock
	fetch ->i_dnotify
	...
	release ->i_lock
while on fcntl() side we had
	acquire ->i_lock
	fetch from descriptor table, sod off if not our file
	...
	store ->i_dnotify
	...
	release ->i_lock
Storing NULL into descriptor table could get reordered into
->i_lock-protected area in dnotify_flush(), but it could not
get reordered past releasing ->i_lock.  So fcntl_dirnotify()
either grabbed ->i_lock before dnotify_flush() (in which case
missing the store of NULL into descriptor table wouldn't
matter, since dnotify_flush() would've observed the mark
we'd inserted) or it would've seen that store to descriptor
table.

Nowadays it's nowhere near as straightforward; in fcntl_dirnotify()
we have
        /* this is needed to prevent the fcntl/close race described below */
        mutex_lock(&dnotify_group->mark_mutex);
and it would appear to be similar to the original situation, with
->mark_mutex serving in place of ->i_lock.  However, dnotify_flush()
might not take that mutex at all - it has
        fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, dnotify_group);
        if (!fsn_mark)
                return;
before grabbing that thing.  So the things are trickier - we actually
rely upon the barriers in fsnotify_find_mark().  And those are complicated.
The case when it returns non-NULL is not a problem - there we have that
mutex providing the barriers we need.  NULL can be returned in two cases:
	a) ->i_fsnotify_marks is not empty, but it contains no
dnotify marks.  In that case we have ->i_fsnotify_marks.lock acquired
and released.  By the time it gets around to fcheck(), fcntl_dirnotify() has
either found or created and inserted a dnotify mark into that list, with
->i_fsnotify_marks.lock acquired/released around the insertion, so we
are fine - either fcntl_dirnotify() gets there first (in which case
dnotify_flush() will observe it), or release of that lock by
fsnotify_find_mark() called by dnotify_flush() will serve as a barrier,
making sure that store to descriptor table will be observed.
	b) fsnotify_find_mark() (fsnotify_grab_connector() it calls,
actually) finds ->i_fsnotify_marks empty.  That's where the things
get interesting; we have
        idx = srcu_read_lock(&fsnotify_mark_srcu);
        conn = srcu_dereference(*connp, &fsnotify_mark_srcu);
        if (!conn)
                goto out;
on dnotify_flush() side.  The matching store of fcntl_dirnotify()
side would be in fsnotify_attach_connector_to_object(), where
we have
        /*
         * cmpxchg() provides the barrier so that readers of *connp can see
         * only initialized structure
         */
        if (cmpxchg(connp, NULL, conn)) {
                /* Someone else created list structure for us */

So we have
A:
	store NULL to descriptor table
	srcu_read_lock
	srcu_dereference fetches NULL from ->i_fsnotify_marks
vs.
B:
	cmpxchg replaces NULL with non-NULL in ->i_fsnotify_marks
	fetch from descriptor table, can't miss the store done by A

Which might be safe, but the whole thing *RELLY* needs to be discussed
in fcntl_dirnotify() in more details.  fs/notify/* guts are convoluted
enough to confuse anyone unfamiliar with them.
