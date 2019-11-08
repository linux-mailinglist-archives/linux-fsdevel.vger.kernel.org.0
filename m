Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151CBF57B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 21:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbfKHTgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 14:36:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:54222 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfKHTgP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:36:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 11:36:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="196999801"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2019 11:36:13 -0800
Date:   Fri, 8 Nov 2019 11:36:13 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/xfs: Allow toggle of physical DAX flag
Message-ID: <20191108193612.GA4800@iweiny-DESK2.sc.intel.com>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-6-ira.weiny@intel.com>
 <20191021004536.GD8015@dread.disaster.area>
 <20191021224931.GA25526@iweiny-DESK2.sc.intel.com>
 <20191108131238.GK20863@quack2.suse.cz>
 <20191108134606.GL20863@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108134606.GL20863@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 08, 2019 at 02:46:06PM +0100, Jan Kara wrote:
> On Fri 08-11-19 14:12:38, Jan Kara wrote:
> > On Mon 21-10-19 15:49:31, Ira Weiny wrote:
> > > On Mon, Oct 21, 2019 at 11:45:36AM +1100, Dave Chinner wrote:
> > > > On Sun, Oct 20, 2019 at 08:59:35AM -0700, ira.weiny@intel.com wrote:
> > > > That, fundamentally, is the issue here - it's not setting/clearing
> > > > the DAX flag that is the issue, it's doing a swap of the
> > > > mapping->a_ops while there may be other code using that ops
> > > > structure.
> > > > 
> > > > IOWs, if there is any code anywhere in the kernel that
> > > > calls an address space op without holding one of the three locks we
> > > > hold here (i_rwsem, MMAPLOCK, ILOCK) then it can race with the swap
> > > > of the address space operations.
> > > > 
> > > > By limiting the address space swap to file sizes of zero, we rule
> > > > out the page fault path (mmap of a zero length file segv's with an
> > > > access beyond EOF on the first read/write page fault, right?).
> > > 
> > > Yes I checked that and thought we were safe here...
> > > 
> > > > However, other aops callers that might run unlocked and do the wrong
> > > > thing if the aops pointer is swapped between check of the aop method
> > > > existing and actually calling it even if the file size is zero?
> > > > 
> > > > A quick look shows that FIBMAP (ioctl_fibmap())) looks susceptible
> > > > to such a race condition with the current definitions of the XFS DAX
> > > > aops. I'm guessing there will be others, but I haven't looked
> > > > further than this...
> > > 
> > > I'll check for others and think on what to do about this.  ext4 will have the
> > > same problem I think.  :-(
> > 
> > Just as a datapoint, ext4 is bold and sets inode->i_mapping->a_ops on
> > existing inodes when switching journal data flag and so far it has not
> > blown up. What we did to deal with issues Dave describes is that we
> > introduced percpu rw-semaphore guarding switching of aops and then inside
> > problematic functions redirect callbacks in the right direction under this
> > semaphore. Somewhat ugly but it seems to work.

Ah I am glad you brought this up.  I had not seen this before.

Is that s_journal_flag_rwsem?

In the general case I don't think that correctly protects against:

	if (a_ops->call)
		a_ops->call();

Because not all operations are defined in both ext4_aops and
ext4_journalled_aops.  Specifically migratepage.

move_to_new_page() specifically follows the pattern above with migratepage.  So
is there a bug here?

> 
> Thinking about this some more, perhaps this scheme could be actually
> transformed in something workable. We could have a global (or maybe per-sb
> but I'm not sure it's worth it) percpu rwsem and we could transform aops
> calls into:
> 
> percpu_down_read(aops_rwsem);
> do_call();
> percpu_up_read(aops_rwsem);
> 
> With some macro magic it needn't be even that ugly.

I think this is safer.  And what I have been investigating/coding up.  Because
that also would protect against the above with:

percpu_down_read(aops_rwsem);
	if (a_ops->call)
		a_ops->call();
percpu_up_read(aops_rwsem);

However I have been looking at SRCU because we also have patterns like:


	generic_file_buffered_read
		if (a_ops->is_partially_uptodate)
			a_ops->is_partially_uptodate()
		page_cache_sync_readahead
			force_page_cache_readahead
				if (!a_ops->readpage && !a_ops->readpages)
					return;
				__do_page_cache_readahead
					read_pages
						if (a_ops->readpages)
							a_ops->readpages()
						a_ops->readpage


So we would have to pass the a_ops through to use a rwsem.  Where SRCU I think
would be fine to just take the SRCU read lock multiple times.  Am I wrong?


We also have a 3rd (2nd?) issue.  There are callers who check for the presence
of an operation to be used later.  For example do_dentry_open():

do_dentry_open()
{
...
	if (<flags> & O_DIRECT)
		if (!<a_ops> || !<a_ops>->direct_IO)
			return -EINVAL;
...
}

After this open direct_IO better be there AFAICT so changing the a_ops later
would not be good.  For ext4 direct_IO is defined for all the a_ops...  so I
guess that is not a big deal.  However, is the user really getting the behavior
they expect in this case?

I'm afraid of requiring FSs to have to follow rules in defining their a_ops.
Because I'm afraid maintaining those rules would be hard and would eventually
lead to crashes when someone did it wrong.

:-/

So for this 3rd (2nd) case I think we should simply take a reference to the
a_ops and fail changing the mode.  For the DAX case that means the user is best
served by taking a write lease on the file to ensure there are no other opens
which could cause issues.

Would that work for changing the journaling mode?

And I _think_ this is the only issue we have with this right now. But if other
callers of a_ops needed the pattern of using the a_ops at a time across context
changes they would need to ensure this reference was taken.

What I have come up with thus far is an interface like:

/*
 * as_get_a_ops() -- safely get the a_ops from the address_space specified
 *
 * @as: address space to get a_ops from
 * @ref: used to indicate if a reference is required on this a_ops
 * @tok: srcu token to be returned in as_put_a_ops()
 *
 * The a_ops returned is protected from changing until as_put_a_ops().
 *
 * If ref is specified then ref must also be specified in as_put_a_ops() to
 * release this reference.  In this case a reference is taken on the a_ops
 * which will prevent it from changing until the reference is released.
 *
 * References should _ONLY_ be taken when the a_ops needs to be constant
 * across a user context switch because doing so will block changing the a_ops
 * until that reference is released.
 *
 * Examples of using a reference are checks for specific a_ops pointers which
 * are expected to support functionality at a later date (example direct_IO)
 */
static inline const struct address_space_operations *
as_get_a_ops(struct address_space *as, bool ref, int *tok)
{
	...
}

static inline void
as_assign_a_ops(struct address_space *as,
                const struct address_space_operations *a_ops)
{
	...
}

static inline void as_put_a_ops(struct address_space *as, int tok, bool ref)
{
	...
}


I'm still working out the details of using SRCU and a ref count.  I have made
at least 1 complete pass of all the a_ops users and I think this would cover
them all.

Thoughts?
Ira

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
