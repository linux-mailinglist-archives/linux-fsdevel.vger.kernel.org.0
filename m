Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8691418E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 19:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgARSJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 13:09:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51438 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgARSJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:09:55 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1issXV-00B1Vm-HC; Sat, 18 Jan 2020 18:09:41 +0000
Date:   Sat, 18 Jan 2020 18:09:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        quae@daurnimator.com, dev@opencontainers.org,
        containers@lists.linux-foundation.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] openat2: minor uapi cleanups
Message-ID: <20200118180941.GT8904@ZenIV.linux.org.uk>
References: <20200115144831.GJ8904@ZenIV.linux.org.uk>
 <20200118120800.16358-1-cyphar@cyphar.com>
 <20200118152833.GS8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118152833.GS8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 18, 2020 at 03:28:33PM +0000, Al Viro wrote:

> #work.openat2 updated, #for-next rebuilt and force-pushed.  There's
> a massive update of #work.namei as well, also pushed out; not in
> #for-next yet, will post the patch series for review later today.

BTW, looking through that code again, how could this
static bool legitimize_root(struct nameidata *nd)
{
        /*
         * For scoped-lookups (where nd->root has been zeroed), we need to
         * restart the whole lookup from scratch -- because set_root() is wrong
         * for these lookups (nd->dfd is the root, not the filesystem root).
         */
        if (!nd->root.mnt && (nd->flags & LOOKUP_IS_SCOPED))
                return false;

possibly trigger?  The only things that ever clean ->root.mnt are

	1) failing legitimize_path(nd, &nd->root, nd->root_seq) in
legitimize_root() itself.  If *ANY* legitimize_path() has failed,
we are through - RCU pathwalk is given up.  In particular, if you
look at the call chains leading to legitimize_root(), you'll see
that it's called by unlazy_walk() or unlazy_child() and failure
has either of those buggger off immediately.  The same goes for
their callers; fail any of those and we are done; the very next
thing that will be done with that nameidata is going to be
terminate_walk().  We don't look at its fields, etc. - just return
to the top level ASAP and call terminate_walk() on it.  Which is where
we run into
                if (nd->flags & LOOKUP_ROOT_GRABBED) {
                        path_put(&nd->root);
                        nd->flags &= ~LOOKUP_ROOT_GRABBED;
                }
paired with setting LOOKUP_ROOT_GRABBED just before the attempt
to legitimize in legitimize_root().  The next thing *after*
terminate_walk() is either path_init() or the end of life for
that struct nameidata instance.
	This is really, really fundamental for understanding the whole
thing - a failure of unlazy_walk/unlazy_child means that we are through
with that attempt.

	2) complete_walk() doing
                if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
                        nd->root.mnt = NULL;   
Can't happen with LOOKUP_IS_SCOPED in flags, obviously.

	3) path_init().  Where it's followed either by leaving through
        if (*s == '/' && !(flags & LOOKUP_IN_ROOT)) {
		....
        }
(and LOOKUP_IS_SCOPED includes LOOKUP_IN_ROOT) or with a failure exit
(no calls of *anything* but terminate_walk() after that or with
        if (flags & LOOKUP_IS_SCOPED) {
                nd->root = nd->path;
... and that makes damn sure nd->root.mnt is not NULL.

And neither of the LOOKUP_IS_SCOPED bits ever gets changed in nd->flags -
they remain as path_init() has set them.

The same, BTW, goes for the check you've added in the beginning of
set_root() - set_root() is called only with NULL nd->root.mnt (trivial to
prove) and that is incompatible with LOOKUP_IS_SCOPED.  I'm kinda-sorta
OK with having WARN_ON() there for a while, but IMO the check in the
beginning of legitimize_root() should go away - this kind of defensive
programming only makes harder to reason about the behaviour of the
entire thing.  And fs/namei.c is too convoluted as it is...
