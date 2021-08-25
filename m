Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A299D3F6D4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 04:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhHYCHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 22:07:52 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38354 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbhHYCHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:07:51 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 74DE1B47F3B; Tue, 24 Aug 2021 22:06:56 -0400 (EDT)
Date:   Tue, 24 Aug 2021 22:06:56 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <20210825020655.GH29026@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
 <20210818225454.9558.409509F4@e16-tech.com>
 <162932318266.9892.13600254282844823374@noble.neil.brown.name>
 <20210819021910.GB29026@hungrycats.org>
 <162942805745.9892.7512463857897170009@noble.neil.brown.name>
 <20210822192917.GF29026@hungrycats.org>
 <162976092544.9892.3996716616493030747@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162976092544.9892.3996716616493030747@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 09:22:05AM +1000, NeilBrown wrote:
> On Mon, 23 Aug 2021, Zygo Blaxell wrote:
> ...
> > 
> > Subvol IDs are not reusable.  They are embedded in shared object ownership
> > metadata, and persist for some time after subvols are deleted.
> ...
> > 
> > The cost of _tracking_ free object IDs is trivial compared to the cost
> > of _reusing_ an object ID on btrfs.
> 
> One possible approach to these two objections is to decouple inode
> numbers from object ids.

This would be reasonable for subvol IDs (I thought of it earlier in this
thread, but didn't mention it because I wasn't going to be the first to
open that worm can ;).

There aren't very many subvol IDs and they're not used as frequently
as inodes, so a lookup table to remap them to smaller numbers to save
st_ino bit-space wouldn't be unreasonably expensive.  If we stop right
here and use the [some_zeros:reversed_subvol:inode] bit-packing scheme
you proposed for NFS, that seems like a reasonable plan.  It would have
48 bits of usable inode number space, ~440000 file creates per second
for 20 years with up to 65535 snapshots, the same number of bits that
ZFS has in its inodes.

Once that subvol ID mapping tree exists, it could also map subvol inode
numbers to globally unique numbers.  Each tree item would contain a map of
[subvol_inode1..subvol_inode2] that maps the inode numbers in the subvol
into the global inode number space at [global_inode1..global_inode2].
When a snapshot is created, the snapshot gets a copy of all the origin
subvol's inode ranges, but with newly allocated base offsets.  If the
original subvol needs new inodes, it gets a new chunk from the global
inode allocator.  If the snapshot subvol needs new inodes, it gets a
different new chunk from the global allocator.  The minimum chunk might
be a million inodes or so to avoid having to allocate new chunks all the
time, but not so high to make the code completely untested (or testers
just set the minchunk to 1000 inodes).

The question I have (and why I didn't propose this earlier) is whether
this scheme is any real improvement over dividing the subvol:inode space
by bit packing.  If you have one subvol that has 3 billion existing inodes
in it, every snapshot of that subvol is going to burn up roughly 2^-32 of
the available globally unique inode numbers.  If we burn 3 billion inodes
instead of 4 billion per subvol, it only gets 25% more lifespan for the
filesystem, and the allocation of unique inode spaces and tracking inode
space usage will add cost to every single file creation and snapshot
operation.  If your oldest/biggest subvol only has a million inodes in
it, all of the above is pure cost:  you can create billions of snapshots,
never repeat any object IDs, and never worry about running out.

I'd want to see cost/benefit simulations of:

	this plan,

	the simpler but less efficient bit-packing plan,

	'cp -a --reflink' to a new subvol and start over every 20 years
	when inodes run out,

	and online garbage-collection/renumbering schemes that allow
	users to schedule the inode renumbering costs in overnight
	batches instead of on every inode create.

> The inode number becomes just another piece of metadata stored in the
> inode.
> struct btrfs_inode_item has four spare u64s, so we could use one of
> those.
> struct btrfs_dir_item would need to store the inode number too.  What
> is location.offset used for?  Would a diritem ever point to a non-zero
> offset?  Could the 'offset' be used to store the inode number?

Offset is used to identify subvol roots at the moment, but so far that
means only values 0 and UINT64_MAX are used.  It seems possible to treat
all other values as inode numbers.  Don't quote me on that--I'm not an
expert on this structure.

> This could even be added to existing filesystems I think.  It might not
> be easy to re-use inode numbers smaller than the largest at the time the
> extension was added, but newly added inode numbers could be reused after
> they were deleted.

We'd need a structure to track reusable inode numbers and it would have to
be kept up to date to work, so this feature would necessarily come with an
incompat bit.  Whether you borrow bits from existing structures or make
extended new structures doesn't matter at that point, though obviously
for something as common as inodes it would be bad to make them bigger.

Some of the btrfs userspace API uses inode numbers, but unless I missed
something, it could all be converted to use object numbers directly
instead.

> Just a thought...
> 
> NeilBrown
