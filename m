Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA35490C81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 17:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiAQQ3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 11:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiAQQ3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:29:06 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DEC061574;
        Mon, 17 Jan 2022 08:29:06 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9UsG-002bJA-Sc; Mon, 17 Jan 2022 16:28:53 +0000
Date:   Mon, 17 Jan 2022 16:28:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeV+zseKGNqnSuKR@bfoster>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 09:35:58AM -0500, Brian Foster wrote:

> To Al's question, at the end of the day there is no rcu delay involved
> with inode reuse in XFS. We do use call_rcu() for eventual freeing of
> inodes (see __xfs_inode_free()), but inode reuse occurs for inodes that
> have been put into a "reclaim" state before getting to the point of
> freeing the struct inode memory. This lead to the long discussion [1]
> Ian references around ways to potentially deal with that. I think the
> TLDR of that thread is there are various potential options for
> improvement, such as to rcu wait on inode creation/reuse (either
> explicitly or via more open coded grace period cookie tracking), to rcu
> wait somewhere in the destroy sequence before inodes become reuse
> candidates, etc., but none of them seemingly agreeable for varying
> reasons (IIRC mostly stemming from either performance or compexity) [2].
> 
> The change that has been made so far in XFS is to turn rcuwalk for
> symlinks off once again, which looks like landed in Linus' tree as
> commit 7b7820b83f23 ("xfs: don't expose internal symlink metadata
> buffers to the vfs"). The hope is that between that patch and this
> prospective vfs tweak, we can have a couple incremental fixes that at
> least address the practical problem users have been running into (which
> is a crash due to a NULL ->get_link() callback pointer due to inode
> reuse). The inode reuse vs. rcu thing might still be a broader problem,
> but AFAIA that mechanism has been in place in XFS on Linux pretty much
> forever.

My problem with that is that pathname resolution very much relies upon
the assumption that any inode it observes will *not* change its nature
until the final rcu_read_unlock().  Papering over ->i_op->get_link reads
in symlink case might be sufficient at the moment (I'm still not certain
about that, though), but that's rather brittle.  E.g. if some XFS change
down the road adds ->permission() on some inodes, you'll get the same
problem in do_inode_permission().  We also have places where we rely upon
	sample ->d_seq
	fetch ->d_flags
	fetch ->d_inode
	validate ->d_seq
	...
	assume that inode type matches the information in flags

How painful would it be to make xfs_destroy_inode() a ->free_inode() instance?
IOW, how far is xfs_inode_mark_reclaimable() from being callable in RCU
callback context?  Note that ->destroy_inode() is called via

static void destroy_inode(struct inode *inode)
{
	const struct super_operations *ops = inode->i_sb->s_op;

	BUG_ON(!list_empty(&inode->i_lru));
	__destroy_inode(inode);
	if (ops->destroy_inode) {
		ops->destroy_inode(inode);
		if (!ops->free_inode)
			return;
	}
	inode->free_inode = ops->free_inode;
	call_rcu(&inode->i_rcu, i_callback);
}

with

static void i_callback(struct rcu_head *head)
{
        struct inode *inode = container_of(head, struct inode, i_rcu);
	if (inode->free_inode)
		inode->free_inode(inode);
	else   
		free_inode_nonrcu(inode);
}

IOW, ->free_inode() is RCU-delayed part of ->destroy_inode().  If both
are present, ->destroy_inode() will be called synchronously, followed
by ->free_inode() from RCU callback, so you can have both - moving just
the "finally mark for reuse" part into ->free_inode() would be OK.
Any blocking stuff (if any) can be left in ->destroy_inode()...
