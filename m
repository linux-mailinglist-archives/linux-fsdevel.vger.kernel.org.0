Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514053883E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbhESAqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbhESAqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:46:02 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B6AC06175F;
        Tue, 18 May 2021 17:44:44 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAIt-00G48Y-QL; Wed, 19 May 2021 00:43:15 +0000
Date:   Wed, 19 May 2021 00:43:15 +0000
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
Subject: [PATCHSET] d_path cleanups
Message-ID: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
 <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
 <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
 <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
 <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk>
 <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	First of all, apologies for delays (one of the disks on the main
devel/testing box has become an ex-parrot, with... interesting recovery).

	Here's what I've got for carve-up of cleanups.  This stuff lives
in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.d_path,
individual patches in followups.  14 commits, all changes are to fs/d_path.c,
total being +133/-191.  Moderately tested, seems to work here.  Review
and testing would be welcome...

	Part 1: trivial preliminary cleanup

1/14) d_path: "\0" is {0,0}, not {0}
	A bunch of places used "\0" as a literal for 1-element array consisting
of NULs.  That should've been "", obviously...

	Part 2: untangling __dentry_path()

2/14) d_path: saner calling conventions for __dentry_path()
	__dentry_path() used to copy the calling conventions for dentry_path().
That was fine for use in dentry_path_raw(), but it created a lot of headache
in dentry_path(), since we might need a suffix (//deleted) in there, without
NUL between it and the pathname itself.  So we had to
	1) (possibly) put /deleted into buffer and remember where it went
	2) let __dentry_path() prepend NUL-terminated pathname
	3) override NUL with / if we had done (1)
Life becomes much easier if __dentry_path() does *NOT* put NUL in there.
Then dentry_path_raw() becomes 'put "" into buffer, then __dentry_path()'
and dentry_path() - 'put "" or "//deleted" into buffer, then __dentry_path()'.

Additionally, we switch the way buffer information is passed to one similar
to what we do in prepend()/prepend_name()/etc., i.e. pass the pointer to the
end of buffer instead of that to beginning.  That's what we'd been using
in __dentry_path() all along, and now that the callers are doing some prepend()
before calling __dentry_path(), they that value already on hand.

3/14)  d_path: regularize handling of root dentry in __dentry_path()
	All path-forming primitives boil down to sequence of prepend_name()
on dentries encountered along the way toward root.  Each time we prepend
/ + dentry name to the buffer.  Normally that does exactly what we want,
but there's a corner case when we don't call prepend_name() at all (in case
of __dentry_path() that happens if we are given root dentry).  We obviously
want to end up with "/", rather than "", so this corner case needs to be
handled.
	__dentry_path() used to manually put '/' in the end of buffer before
doing anything else, to be overwritten by the first call of prepend_name()
if one happens and to be left in place if we don't call prepend_name() at
all.  That required manually checking that we had space in the buffer
(prepend_name() and prepend() take care of such checks themselves) and lead
to clumsy keeping track of return value.
	A better approach is to check if the main loop has added anything
into the buffer and prepend "/" if it hasn't.  A side benefit of using prepend()
is that it does the right thing if we'd already run out of buffer, making
the overflow-handling logics simpler.

NB: the above might be worth putting into commit message.

	Part 3: overflow handling cleanups

We have an overcomplicated handling of overflows.  Primitives (prepend() and
prepend_name()) check if we'd run out of space and return -ENAMETOOLONG.
Then it's propagated all the way out by call chain.  However, the same
primitives are safe to call in case we'd *already* run out of space and
that condition is easily checked at any level of callchain.  The next
5 commits use that to simplify the control flow.

4/14)  d_path: get rid of path_with_deleted()
	expand into the sole caller, rearrange the suffix handing
along the lines of dentry_path().

5/14)  getcwd(2): saner logics around prepend_path() call
	Turn
		prepend_path()
		if it says it has run out of space, fail with ENAMETOOLONG
		if it wants "(unreachable) " prepended
			do so
			if that says it has run out of space, fail with ENAMETOOLONG
	into
		prepend_path()
		if it wants "(unreachable) " prepended
			do so
		if we see we'd run out of space at some point
			fail with ENAMETOOLONG

6/14)  d_path: don't bother with return value of prepend()
	Almost nothing is looking at return value of prepend() and it's
easy to get rid of the last stragglers...

7/14)  d_path: lift -ENAMETOOLONG handling into callers of prepend_path()
	It's easier to have prepend_path() return 0 on overflow and
check for overflow in the callers.  The logics is the same for all callers
(ran out of space => ERR_PTR(-ENAMETOOLONG)), so we get a bit of boilerplate,
but even with that the callers become simpler.  Added boilerplate will be
dealt with a couple of commits down the road.

8/14)  d_path: make prepend_name() boolean
	Unlike the case of prepend(), callers of prepend_name() really want
to see whether it has run out of space - the loops it's called in are
lockless and we could, in principle, end up spinning there for indetermined
amount of iterations.  Dropping out of loop if we run out of space in the
buffers serves as a backstop for (very unlikely) cases.
	However, all we care about is success/failure - we generate
ENAMETOOLONG in the callers, if not callers of callers, so we can bloody well
make it return bool.

	Part 4: introduction of prepend_buffer

9/14)  d_path: introduce struct prepend_buffer
	We've a lot of places where we have pairs of form (pointer to end
of buffer, amount of space left in front of that).  These sit in pairs of
variables located next to each other and usually passed by reference.
Turn those into instances of new type (struct prepend_buffer) and pass
reference to the pair instead of pairs of references to its fields.

Initialization (of form {buf + len, len}) turned into a macro (DECLARE_BUF),
to avoid brainos.  Extraction of string (buffer contents if we hadn't run
out of space, ERR_PTR(-ENAMETOOLONG) otherwise) is done by extract_string();
that eats the leftover boilerplate from earlier in the series.

	Part 5: extracting the lockless part of prepend_path()
The thing that started the entire mess had been an attempt to use d_path
machinery for vsprintf(); that can't grab rename_lock and mount_lock,
so we needed a variant of prepend_path() that would try to go without
those locks.  The obvious approach is to lift the internal loop of
prepend_path() into a new primitive.  However, that needs some massage
first to separate local variables - otherwise we end up with the
argument list from hell.

10/14) d_path: prepend_path(): get rid of vfsmnt
	redundant - we maintain mnt and vfsmnt through the loop,
with the latter being a pointer to mnt->mnt all along.
11/14) d_path: prepend_path(): lift resetting b in case when we'd return 3 out of loop
	the only place in the inner loop where we need p; we use it
to reset b in case we would return 3.  We can easily check that error is 3
after the loop and do resetting there.  Note that we only need that after
the *outer* loop - the body of that starts with assignment to b anyway.
12/14) d_path: prepend_path(): lift the inner loop into a new helper
	ta-da

	Part 6: followups

13/14) d_path: prepend_path() is unlikely to return non-zero
t14/14) getcwd(2): clean up error handling
