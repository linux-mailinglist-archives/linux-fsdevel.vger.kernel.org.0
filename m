Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C64389311
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354189AbhESP5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbhESP5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 11:57:40 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C59C06175F;
        Wed, 19 May 2021 08:56:20 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljOXW-00GH8f-H0; Wed, 19 May 2021 15:55:18 +0000
Date:   Wed, 19 May 2021 15:55:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH 12/14] d_path: prepend_path(): lift the inner loop into a
 new helper
Message-ID: <YKU05k0P7YjH/g6E@zeniv-ca.linux.org.uk>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-12-viro@zeniv.linux.org.uk>
 <YKTHKNsX/cvYwbWj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKTHKNsX/cvYwbWj@smile.fi.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 11:07:04AM +0300, Andy Shevchenko wrote:
> On Wed, May 19, 2021 at 12:48:59AM +0000, Al Viro wrote:
> > ... and leave the rename_lock/mount_lock handling in prepend_path()
> > itself
> 
> ...
> 
> > +			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
> > +				return 1;	// absolute root
> > +			else
> > +				return 2;	// detached or not attached yet
> 
> Would it be slightly better to read
> 
> 			if (IS_ERR_OR_NULL(mnt_ns) || is_anon_ns(mnt_ns))
> 				return 2;	// detached or not attached yet
> 			else
> 				return 1;	// absolute root
> 
> ?
> 
> Oh, I have noticed that it's in the original piece of code (perhaps separate
> change if we ever need it?).

The real readability problem here is not the negations.  There are 4 possible
states for vfsmount encoded via ->mnt_ns:
	1) not attached to any tree, kept alive by refcount alone.
->mnt_ns == NULL.
	2) long-term unattached.  Not a part of any mount tree, but we have
a known holder for it and until that's gone (making ->mnt_ns NULL), refcount
is guaranteed to remain positive.  pipe_mnt is an example of such.
->mnt_ns == MNT_NS_INTERNAL, which is encoded as ERR_PTR(-1), thus the use of
IS_ERR_OR_NULL here (something I'd normally taken out and shot - use of that
primitive is a sign of lousy API or of a cargo-culted "defensive programming").
	3) part of a temporary mount tree; not in anyone's namespace.
->mnt_ns points the tree in question, ->mnt_ns->seq == 0.
	4) belongs to someone's namespace.  ->mnt_ns points to that,
->mnt_ns->seq != 0.  That's what we are looking for here.

	It's kludges all the way down ;-/  Note that temporary tree can't become
a normal one or vice versa - mounts can get transferred to normal namespace,
but they will see ->mnt_ns reassigned to that.  IOW, ->mnt_ns->seq can't
get changed without a change to ->mnt_ns.  I suspect that the right way
to handle that would be to have that state stored as explicit flags.

	All mounts are created (and destroyed) in state (1); state changes:
commit_tree() - (1) or (3) to (3) or (4)
umount_tree() - (3) or (4) to (1)
clone_private_mount() - (1) to (2)
open_detached_copy() - (1) to (3)
copy_mnt_ns() - (1) to (4)
mount_subtree() - (1) to (3)
fsmount() - (1) to (3)
init_mount_tree() - (1) to (4)
kern_mount() - (1) to (2)
kern_unmount{,_array}() - (2) to (1)

	commit_tree() has a pathological call chain that has it
attach stuff to temporary tree; that's basically automount by lookup in
temporary namespace.  It can distinguish it from the usual (adding to
normal namespace) by looking at the state of mountpoint we are attaching
to - or simply describe all cases as "(1) or (3) to whatever state the
mountpoint is".

	One really hot path where we check (1) vs. (2,3,4) is
mntput_no_expire(), which is the initial reason behind the current
representation.  However, read from ->mnt_flags is just as cheap as
that from ->mnt_ns and the same reasons that make READ_ONCE()
legitimate there would apply to ->mnt_flags as well.

	We can't reuse MNT_INTERNAL for that, more's the pity -
it's used to mark the mounts (kern_mount()-created, mostly) that
need to destroyed synchronously on the final mntput(), with no
task_work_add() allowed (think of module_init() failing halfway through,
with kern_unmount() done to destroy the internal mounts already created;
we *really* don't want to delay that filesystem shutdown until insmod(2)
heads out to userland).  Another headache is in LSM shite, as usual...

	Anyway, sorting that out is definitely a separate story.
