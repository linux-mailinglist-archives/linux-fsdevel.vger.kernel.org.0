Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1303F4130
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhHVTac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 15:30:32 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47960 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHVTab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:30:31 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 75782B425BA; Sun, 22 Aug 2021 15:29:23 -0400 (EDT)
Date:   Sun, 22 Aug 2021 15:29:23 -0400
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
Message-ID: <20210822192917.GF29026@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
 <20210818225454.9558.409509F4@e16-tech.com>
 <162932318266.9892.13600254282844823374@noble.neil.brown.name>
 <20210819021910.GB29026@hungrycats.org>
 <162942805745.9892.7512463857897170009@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162942805745.9892.7512463857897170009@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:54:17PM +1000, NeilBrown wrote:
> On Thu, 19 Aug 2021, Zygo Blaxell wrote:
> > 40 bit inodes would take about 20 years to collide with 24-bit subvols--if
> > you are creating an average of 1742 inodes every second.  Also at the
> > same time you have to be creating a subvol every 37 seconds to occupy
> > the colliding 25th bit of the subvol ID.  Only the highest inode number
> > in any subvol counts--if your inode creation is spread out over several
> > different subvols, you'll need to make inodes even faster.
> > 
> > For reference, my high scores are 17 inodes per second and a subvol
> > every 595 seconds (averaged over 1 year).  Burst numbers are much higher,
> > but one has to spend some time _reading_ the files now and then.
> > 
> > I've encountered other btrfs users with two orders of magnitude higher
> > inode creation rates than mine.  They are barely squeaking under the
> > 20-year line--or they would be, if they were creating snapshots 50 times
> > faster than they do today.
> 
> I do like seeing concrete numbers, thanks.  How many of these inodes and
> subvols remain undeleted?  Supposing inode numbers were reused, how many
> bits might you need?

Number of existing inodes is filesystem size divided by average inode
size, about 30 million inodes per terabyte for build servers, give or
take an order of magnitude per project.  That does put 1 << 32 inodes in
the range of current disk sizes, which motivated the inode_cache feature.

Number of existing subvols stays below 1 << 14.  It's usually some
near-constant multiple of the filesystem age (if it is not limited more
by capacity) because it's not trivial to move a subvol structure from
one filesystem to another.

The main constraint on the product of both numbers is filesystem size.
If that limit is reached, we often see that lower subvol numbers correlate
with higher inode numbers and vice versa; otherwise both keep growing until
they hit the size limit or some user-chosen limit (e.g. "we just don't
need more than the last 300 builds online at any time").

For build and backup use cases (which both heavily use snapshots) there is
no incentive to delete snapshots other than to avoid eventually running
out of space.  There is also no incentive to increase filesystem size
to accommodate extra snapshots, as long as there is room for some minimal
useful number of snapshots, the original subvols, and some free space.

So we get snapshots in numbers that are rougly:

	min(age_of_filesystem * snapshot_creation_rate, filesystem_capacity / average_subvol_unique_data_size)

Subvol IDs are not reusable.  They are embedded in shared object ownership
metadata, and persist for some time after subvols are deleted.

> > > My preference would be for btrfs to start re-using old object-ids and
> > > root-ids, and to enforce a limit (set at mkfs or tunefs) so that the
> > > total number of bits does not exceed 64.  Unfortunately the maintainers
> > > seem reluctant to even consider this.
> > 
> > It was considered, implemented in 2011, and removed in 2020.  Rationale
> > is in commit b547a88ea5776a8092f7f122ddc20d6720528782 "btrfs: start
> > deprecation of mount option inode_cache".  It made file creation slower,
> > and consumed disk space, iops, and memory to run.  Nobody used it.
> > Newer on-disk data structure versions (free space tree, 2015) didn't
> > bother implementing inode_cache's storage requirement.
> 
> Yes, I saw that.  Providing reliable functional certainly can impact
> performance and consume disk-space.  That isn't an excuse for not doing
> it. 
> I suspect that carefully tuned code could result in typical creation
> times being unchanged, and mean creation times suffering only a tiny
> cost.  Using "max+1" when the creation rate is particularly high might
> be a reasonable part of managing costs.
> Storage cost need not be worse than the cost of tracking free blocks
> on the device.

The cost of _tracking_ free object IDs is trivial compared to the cost
of _reusing_ an object ID on btrfs.

If btrfs doesn't reuse object numbers, btrfs can append new objects
to the last partially filled leaf.  If there are shared metadata pages
(i.e. snapshots), btrfs unshares a handful of pages once, and then future
writes use densely packed new pages and delayed allocation without having
to read anything.

If btrfs reuses object numbers, the filesystem has to pack new objects
into random previously filled metadata leaf nodes, so there are a lot
of read-modify-writes scattered over old metadata pages, which spreads
the working set around and reduces cache usage efficiency (i.e. uses
more RAM).  If there are snapshots, each shared page that is modified
for the first time after the snapshot comes with two-orders-of-magnitude
worst-case write multipliers.

The two-algorithm scheme (switching from "reuse freed inode" to "max+1"
under load) would be forced into the "max+1" mode half the time by a
daily workload of alternating git checkouts and builds.  It would save
only one bit of inode namespace over the lifetime of the filesystem.

> "Nobody used it" is odd.  It implies it would have to be explicitly
> enabled, and all it would provide anyone is sane behaviour.  Who would
> imagine that to be an optional extra.

It always had to be explicitly enabled.  It was initially a workaround
for 32-bit ino_t that was limiting a few users, but ino_t got better
and the need for inode_cache went away.

NFS (particularly NFSv2) might be the use case inode_cache has been
waiting for.  btrfs has an i_version field for NFSv4, so it's not like
there's no precedent for adding features in btrfs to support NFS.

On the other hand, the cost of ino_cache gets worse with snapshots,
and the benefit in practice takes years to decades to become relevant.
Users who are exporting snapshots over NFS are likely to be especially
averse to using inode_cache.

> NeilBrown
> 
> 
