Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD4F83C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 00:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKKXyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 18:54:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:11843 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfKKXyf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:54:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 15:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; 
   d="scan'208";a="234647292"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Nov 2019 15:54:34 -0800
Date:   Mon, 11 Nov 2019 15:54:34 -0800
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
Message-ID: <20191111235433.GA318@iweiny-DESK2.sc.intel.com>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-6-ira.weiny@intel.com>
 <20191021004536.GD8015@dread.disaster.area>
 <20191021224931.GA25526@iweiny-DESK2.sc.intel.com>
 <20191108131238.GK20863@quack2.suse.cz>
 <20191108134606.GL20863@quack2.suse.cz>
 <20191108193612.GA4800@iweiny-DESK2.sc.intel.com>
 <20191111160748.GE13307@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111160748.GE13307@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> > In the general case I don't think that correctly protects against:
> > 
> > 	if (a_ops->call)
> > 		a_ops->call();
> > 
> > Because not all operations are defined in both ext4_aops and
> > ext4_journalled_aops.  Specifically migratepage.
> > 
> > move_to_new_page() specifically follows the pattern above with migratepage.  So
> > is there a bug here?
> 
> Looks like there could be.

Ok I'm going to leave this alone and whatever I come up with try and make sure
that the ext4 journal a_ops fits.

[snip]

> > 
> > However I have been looking at SRCU because we also have patterns like:
> > 
> > 
> > 	generic_file_buffered_read
> > 		if (a_ops->is_partially_uptodate)
> > 			a_ops->is_partially_uptodate()
> > 		page_cache_sync_readahead
> > 			force_page_cache_readahead
> > 				if (!a_ops->readpage && !a_ops->readpages)
> > 					return;
> > 				__do_page_cache_readahead
> > 					read_pages
> > 						if (a_ops->readpages)
> > 							a_ops->readpages()
> > 						a_ops->readpage
> > 
> > 
> > So we would have to pass the a_ops through to use a rwsem.  Where SRCU I
> > think would be fine to just take the SRCU read lock multiple times.  Am I
> > wrong?
> 
> So the idea I had would not solve this issue because we'd release the rwsem
> once we return from ->is_partially_uptodate(). This example shows that we
> actually expect consistency among different aops as they are called in
> sequence and that's much more difficult to achieve than just a consistency
> within single aop call.

I can't be sure but is seems like consistency for an operation is somewhat
important.  OR we have to develop rules around when filesystems can, or can not
change a_ops so that the consistency does not matter.

I think what scares me the most is that I'm not really sure what those rules
are...

> 
> > We also have a 3rd (2nd?) issue.  There are callers who check for the
> > presence of an operation to be used later.  For example do_dentry_open():
> > 
> > do_dentry_open()
> > {
> > ...
> > 	if (<flags> & O_DIRECT)
> > 		if (!<a_ops> || !<a_ops>->direct_IO)
> > 			return -EINVAL;
> > ...
> > }
> > 
> > After this open direct_IO better be there AFAICT so changing the a_ops
> > later would not be good.  For ext4 direct_IO is defined for all the
> > a_ops...  so I guess that is not a big deal.  However, is the user really
> > getting the behavior they expect in this case?
> 
> In this particular case I don't think there's any practical harm for any
> filesystem but in general this is another instance where consistency of
> aops over time is assumed.

Yes...  But this is just a more complex situation to maintain consistency.
Again I don't have any idea if consistency is required.

But the current definition/use of a_ops is very static (with the exception of
the ext4 case you gave), so I'm thinking that much of the code is written with
the assumption that the vectors do not change.

> 
> > I'm afraid of requiring FSs to have to follow rules in defining their a_ops.
> > Because I'm afraid maintaining those rules would be hard and would eventually
> > lead to crashes when someone did it wrong.
> 
> I guess this very much depends on the rules. But yes, anything non-obvious
> or hard to check would quickly lead to bugs, I agree. But IMHO fully
> general solution to above problems would clutter the generic code in rather
> ugly way as well because usage of aops is pretty widespread in mm and fs
> code. It isn't just a few places that call them...

I agree it does clutter the code.  and the patches I have are not pretty and
I'm not even sure they are not broken...  So yea I'm open to ideas!

> 
> But I think we could significantly reduce the problem by looking at what's
> in aops. We have lots of operations there that operate on pages. If we
> mandate that before and during switching of aops, you must make sure
> there's nothing in page cache for the inode, you've already dealt with 90%
> of the problems.

Sounds promising...

But digging into this it looks like we need a similar rule for the DAX side to
have no mappings outstanding.  Perhaps you meant that when you said page cache?

> 
> Beside these we have:
> * write_begin - that creates page in page cache so above rule should stop
>   it as well

Just to make sure I understand, do you propose that we put a check in
pagecache_write_[begin|end]() to protect from these calls while changing?

I just want to be sure because I've wondered if we can get away with minimal
checks, or checks on individual functions, in the generic code.  But that
seemed kind of ugly as well.

> * bmap - honestly I'd be inclined to just move this to inode_operations
>   just like fiemap. There's nothing about address_space in its functionality.

Hmmm...  What about these call paths?

ext4_bmap()
	filemap_write_and_wait()
		filemap_fdatawrite()
			__filemap_fdatawrite()
				__filemap_fdatawrite_range()
					do_writepages()
						a_ops->writepages()

or

xfs_vm_bmap()
	iomap_bmap()
		filemap_write_and_wait()
			...
:-/

maybe we should leave it and have it covered under the page cache rule you
propose?


> * swap_activate / swap_deactivate - Either I'd move these to
>   file_operations (what's there about address_space, right), or since all
>   instances of this only care about the inode, we can as well just pass
>   only inode to the function and move it to inode_operations.

XFS calls iomap_swapfile_activate() which calls vfs_fsync() which needs the
file.  Seems like file_operations would be better.

I like the idea of cleaning this up a lot.  I've gone ahead with a couple of
patches to do this.  At least this simplifies things a little bit...

> 
> And then the really problematic ones:
> * direct_IO - Logically with how the IO path is structured, it belongs in
>   aops so I wouldn't move it. With the advance of iomap it is on its way to
>   being removed altogether but that will take a long time to happen
>   completely. So for now I'd mandate that direct_IO path must be locked out
>   while switching aops.

How do we lock this out between checking for this support on open and using it
later?

I think if we go down this path we have to make a rule that says that direct_IO
must be defined for both a_ops.  Right now for our 2 use case we are lucky that
direct_IO is also defined as the same function.  So there is little danger of
odd behavior.

Let me explore more.

> * readpages - these should be locked out by the rule that page creation is
>   forbidden.

Agreed.  Same question applies here as for pagecache_write_[begin|end]().
Should I special case a check for this?

> * writepages - these need to be locked out when switching aops.

If nothing is in the pagecache could we ignore this as well?

> 
> And that should be it. So I don't think there's a need for reference-counting
> of aops in the generic code, especially since I don't think it can be done
> in an elegant way (but feel free to correct me). I think that just
> providing a way to lock-out above three calls would be enough.

Ok, I've been thinking about this whole email more today.  And what if we add a
couple of FS specific lockout callbacks in struct address_space itself.

If they are defined the FS has dynamic a_ops capability and these 3 functions
will need to be locked out by a rw_sem controlled by the FS.

We can then document the "rules" for dynamic a_ops better for FS's to support
them by referencing the special cases and the fact that dynamic a_ops requires
these callbacks to be defined.

It clutters the generic code a bit, but not as much as my idea.  At the same
time it helps to self document the special cases in both the FS's and the core
code.

[snip]

> > 
> > 
> > I'm still working out the details of using SRCU and a ref count.  I have made
> > at least 1 complete pass of all the a_ops users and I think this would cover
> > them all.
> 
> Well, my concern with the use of interface like this is:
> 
> a) The clutter in the generic code

There is a bit of clutter.  What I'm most concerned about is the amount of
special casing.  I still think it would be cleaner in the long run...  And
force some structure on the use of a_ops.  But after looking at it more there
may be a middle ground.

> b) It's difficult to make this work with SRCU because presumably you want
>    to use synchronize_srcu() while switching aops. But then you have three
>    operations to do:
>    1) switch aops
>    2) set inode flag
>    3) synchronize_srcu
> 
>    and depending on the order in which you do these either "old aops"
>    operations will see inode with a flag or "new aops" will see the inode
>    without a flag and either can confuse those functions...

Yes that might be a challenge.

Ira

