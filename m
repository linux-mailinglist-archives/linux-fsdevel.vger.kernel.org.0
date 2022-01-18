Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A592D491C10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 04:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349620AbiARDNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 22:13:21 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46717 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352933AbiARDAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:00:49 -0500
Received: from dread.disaster.area (pa49-179-45-11.pa.nsw.optusnet.com.au [49.179.45.11])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 80E6562BFEC;
        Tue, 18 Jan 2022 14:00:43 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n9ejh-00180W-6I; Tue, 18 Jan 2022 14:00:41 +1100
Date:   Tue, 18 Jan 2022 14:00:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Brian Foster <bfoster@redhat.com>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <20220118030041.GB59729@dread.disaster.area>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61e62d5f
        a=Eslsx4mF8WGvnV49LKizaA==:117 a=Eslsx4mF8WGvnV49LKizaA==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=ZbRbMrvnt3dbDbI5YVEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:28:52PM +0000, Al Viro wrote:
> On Mon, Jan 17, 2022 at 09:35:58AM -0500, Brian Foster wrote:
> 
> > To Al's question, at the end of the day there is no rcu delay involved
> > with inode reuse in XFS. We do use call_rcu() for eventual freeing of
> > inodes (see __xfs_inode_free()), but inode reuse occurs for inodes that
> > have been put into a "reclaim" state before getting to the point of
> > freeing the struct inode memory. This lead to the long discussion [1]
> > Ian references around ways to potentially deal with that. I think the
> > TLDR of that thread is there are various potential options for
> > improvement, such as to rcu wait on inode creation/reuse (either
> > explicitly or via more open coded grace period cookie tracking), to rcu
> > wait somewhere in the destroy sequence before inodes become reuse
> > candidates, etc., but none of them seemingly agreeable for varying
> > reasons (IIRC mostly stemming from either performance or compexity) [2].
> > 
> > The change that has been made so far in XFS is to turn rcuwalk for
> > symlinks off once again, which looks like landed in Linus' tree as
> > commit 7b7820b83f23 ("xfs: don't expose internal symlink metadata
> > buffers to the vfs"). The hope is that between that patch and this
> > prospective vfs tweak, we can have a couple incremental fixes that at
> > least address the practical problem users have been running into (which
> > is a crash due to a NULL ->get_link() callback pointer due to inode
> > reuse). The inode reuse vs. rcu thing might still be a broader problem,
> > but AFAIA that mechanism has been in place in XFS on Linux pretty much
> > forever.
> 
> My problem with that is that pathname resolution very much relies upon
> the assumption that any inode it observes will *not* change its nature
> until the final rcu_read_unlock().  Papering over ->i_op->get_link reads
> in symlink case might be sufficient at the moment (I'm still not certain
> about that, though), but that's rather brittle.  E.g. if some XFS change
> down the road adds ->permission() on some inodes, you'll get the same
> problem in do_inode_permission().  We also have places where we rely upon
> 	sample ->d_seq
> 	fetch ->d_flags
> 	fetch ->d_inode
> 	validate ->d_seq
> 	...
> 	assume that inode type matches the information in flags
> 
> How painful would it be to make xfs_destroy_inode() a ->free_inode() instance?
> IOW, how far is xfs_inode_mark_reclaimable() from being callable in RCU
> callback context?

AIUI, not very close at all,

I'm pretty sure we can't put it under RCU callback context at all
because xfs_fs_destroy_inode() can take sleeping locks, perform
transactions, do IO, run rcu_read_lock() critical sections, etc.
This means that needs to run an a full task context and so can't run
from RCU callback context at all.

> IOW, ->free_inode() is RCU-delayed part of ->destroy_inode().  If both
> are present, ->destroy_inode() will be called synchronously, followed
> by ->free_inode() from RCU callback, so you can have both - moving just
> the "finally mark for reuse" part into ->free_inode() would be OK.
> Any blocking stuff (if any) can be left in ->destroy_inode()...

Yup, that's pretty much what we already do, except that we run the
RCU-delayed part of freeing the inode once XFS has finished with the
inode internally and the background inode GC reclaims it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
