Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25463BABFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfIVWaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Sep 2019 18:30:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49510 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbfIVWao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:30:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iC9QE-0003aU-Bi; Sun, 22 Sep 2019 21:29:34 +0000
Date:   Sun, 22 Sep 2019 22:29:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190922212934.GC29065@ZenIV.linux.org.uk>
References: <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 09:49:21AM -0700, Linus Torvalds wrote:
> On Sat, Sep 14, 2019 at 9:16 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         OK, folks, could you try the following?  It survives the local beating
> > so far.
> 
> This looks like the right solution to me. Keep the locking simple,
> take the dentry refcount as long as we keep a ref to it in "*res".

*grumble*

Example of subtleties in the whole mess: this is safe for mainline
now, but only due to "devpts_pty_kill(): don't bother with d_delete()"
already merged.  Without that, we are risking the following fun:

scan_positive() on devpts: finds a dentry, sees it positive, decides
to grab the sucker.  Refcount is currently 1 (will become 2 after
we grab the reference).

devpts_pty_kill(): d_delete(dentry); on that sucker.  Refcount is
currently (still) 1, so we simply make it negative.

scan_positive(): grabs an extra reference to now negative dentry.

devpts_pty_kill(): dput() drops refcount to 1 (what if it got there
before scan_positive() grabbed a reference?  Nothing, really, since
scan_positive() is holding parent's ->d_lock; dput() wouldn't
have progressed through dentry_kill() until it managed to get
that, and it would've rechecked the refcount.  So that's not
a problem)

scan_positive(): returns a reference to negative dentry to
dcache_readdir().  Which proceeds to oops on
                if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
                              d_inode(next)->i_ino, dt_type(d_inode(next))))
since d_inode(next) is NULL.

With the aforementioned commit it *is* safe, since the dentry remains
positive (and unhashed), so we simply act as if dcache_readdir() has
won the race and emitted a record for the sucker killed by devpts_pty_kill().

IOW, backports will either need to bring that commit in as well, or
they'll need to play silly buggers along the lines of

		if (simple_positive(d) && !--count) {
			spin_lock(&d->d_lock);
			if (likely(simple_positive(d)))
				found = dget_dlock(d);
			spin_unlock(&d->d_lock);
			if (found)
				break;
			count = 1;	// it's gone, keep scanning
                }
Probably the latter, since it's less dependent on some other place
doing what devpts used to do...
