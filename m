Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA28C1381
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2019 07:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfI2F3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Sep 2019 01:29:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45158 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfI2F3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Sep 2019 01:29:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iERm2-0000VV-2n; Sun, 29 Sep 2019 05:29:36 +0000
Date:   Sun, 29 Sep 2019 06:29:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     zhengbin <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, linux-btrfs@vger.kernel.org,
        "Yan, Zheng" <zyan@redhat.com>, linux-cifs@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190929052934.GY26530@ZenIV.linux.org.uk>
References: <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
 <20190924025215.GA9941@ZenIV.linux.org.uk>
 <CAHk-=wiJ1eY7y6r_cFNRPCqD+BJZS7eJeQFO6OrXxRFjDAipsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJ1eY7y6r_cFNRPCqD+BJZS7eJeQFO6OrXxRFjDAipsQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 09:55:06AM -0700, Linus Torvalds wrote:
> [ Sorry for html, I'm driving around ]
> 
> On Mon, Sep 23, 2019, 19:52 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> >
> > Argh...  The things turned interesting.  The tricky part is
> > where do we handle switching cursors away from something
> > that gets moved.
> >
> 
> I forget why we do that. Remind me?
> 
> Anyway, I think to a first approximation, we should probably first just see
> if the "remove cursors from the end" change already effectively makes most
> of the regression go away.
> 
> Because with that change, if you just readdir() things with a sufficiently
> big buffer, you'll never have the cursor hang around over several system
> calls.
> 
> Before, you'd do a readdir, add the cursor, return to user space, then do
> another readdir just to see the EOF, and then do the close().
> 
> So it used to leave the cursor in place over those two final system calls,
> and now it's all gone.
> 
> I'm sure that on the big systems you can still trigger the whole d_lock
> contention on the parent, but I wonder if it's all that much of a problem
> any more in practice with your other change..

If nothing else, it's DoSable right now.  And getting rid of that would
reduce the memory footprint, while we are at it.

In any case, it looks like btrfs really wants an empty directory there,
i.e. the right thing to do would be simple_lookup() for ->lookup.

CIFS is potentially trickier.  AFAICS, what's going on is
	* Windows has a strange export, called IPC$.  Looks like it
was (still is?) the place where they export their named pipes.  From
what I'd been able to figure out, it's always there and allows for
some other uses - it can be used to get the list of exports.  Whether
the actual named pipes are seen there these days... no idea.
	* there seems to be nothing to prevent a server (modified
samba, for example) from exporting whatever it wants under that
name.
	* IF it can be non-empty, mounting it will end up with
root directory where we can do lookups for whatever is there.
getdents() on that root will show what's currently in dcache
(== had been looked up and still has not been evicted by
memory pressure).  Mainline can get seriously buggered if
dcache_readdir() steps into something that is going away.  With the
patches in this series that's no longer a problem.  HOWEVER, if
lookup in one subdirectory picks an alias for another subdirectory
of root, we will be really screwed - shared lock on parent
won't stop d_splice_alias() from moving the alias, and that can
bloody well lead to freeing the original name.  From under
copy_to_user()...  And grabbing a reference to dentry obviously
doesn't prevent that - dentry itself won't get freed, but
external name very well might be.

Again, I don't know CIFS well enough to tell how IPC$ is really
used.  If it doesn't normally contain anything but named pipes,
we can simply have cifs_lookup() refuse to return subdirectories
on such mounts, with solves any problems with d_splice_alias().
If it's always empty - better yet.  If the impressions above
(and that's all those are) are correct, we might have a problem
in mainline with bogus/malicious servers.

That's independent from what we do with the cursors.  I asked
around a bit; no luck so far.  It would be really nice if
some CIFS folks could give a braindump on that thing...
