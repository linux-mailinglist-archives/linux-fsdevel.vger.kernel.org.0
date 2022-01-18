Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E039492E57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 20:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbiARTUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 14:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348346AbiARTUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:20:46 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACDAC061574;
        Tue, 18 Jan 2022 11:20:46 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9u1z-002tBd-OQ; Tue, 18 Jan 2022 19:20:35 +0000
Date:   Tue, 18 Jan 2022 19:20:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YecTA9nclOowdDEu@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
 <YeXIIf6/jChv7JN6@zeniv-ca.linux.org.uk>
 <YeYYp89adipRN64k@zeniv-ca.linux.org.uk>
 <YebFCeLcbziyMjbA@bfoster>
 <YecGC06UrGrfonS0@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YecGC06UrGrfonS0@bfoster>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 01:25:15PM -0500, Brian Foster wrote:

> If I go back to the inactive -> reclaimable grace period variant and
> also insert a start_poll_synchronize_rcu() and
> poll_state_synchronize_rcu() pair across the inactive processing
> sequence, I start seeing numbers closer to ~36k cycles. IOW, the
> xfs_inodegc_inactivate() helper looks something like this:
> 
>         if (poll_state_synchronize_rcu(ip->i_destroy_gp))
>                 xfs_inodegc_set_reclaimable(ip);
>         else
>                 call_rcu(&VFS_I(ip)->i_rcu, xfs_inodegc_set_reclaimable_callback);
> 
> ... to skip the rcu grace period if one had already passed while the
> inode sat on the inactivation queue and was processed.
> 
> However my box went haywire shortly after with rcu stall reports or
> something if I let that continue to run longer, so I'll probably have to
> look into that lockdep splat (complaining about &pag->pag_ici_lock in
> rcu context, perhaps needs to become irq safe?) or see if something else
> is busted..

Umm...  Could you (or Dave) describe where does the mainline do the
RCU delay mentioned several times in these threads, in case of
	* unlink()
	* overwriting rename()
	* open() + unlink() + close() (that one, obviously, for regular files)

The thing is, if we already do have an RCU delay in there, there might be
a better solution - making sure it happens downstream of d_drop() (in case
when dentry has other references) or dentry going negative (in case we are
holding the sole reference to it).

If we can do that, RCU'd dcache lookups won't run into inode reuse at all.
Sure, right now d_delete() comes last *and* we want the target inode to stay
around past the call of ->unlink().  But if you look at do_unlinkat() you'll
see an interesting-looking wart with ihold/iput around vfs_unlink().  Not
sure if you remember the story on that one; basically, it's "we'd rather
have possible IO on inode freeing to happen outside of the lock on parent".

nfsd and mqueue do the same thing; ksmbd does not.  OTOH, ksmbd appears to
force the "make victim go unhashed, sole reference or not".  ecryptfs
definitely does that forcing (deliberately so).

That area could use some rethinking, and if we can deal with the inode reuse
delay while we are at it...

Overwriting rename() is also interesting in that respect, of course.

I can go and try to RTFS my way through xfs iget-related code, but I'd
obviously prefer to do so with at least some overview of that thing
from the folks familiar with it.  Seeing that it's a lockless search
structure, missing something subtle there is all too easy, especially
with the lookup-by-fhandle stuff in the mix...
