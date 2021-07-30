Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB653DBE2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhG3SPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 14:15:19 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38704 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhG3SPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:15:19 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0CEB5B0C519; Fri, 30 Jul 2021 14:15:01 -0400 (EDT)
Date:   Fri, 30 Jul 2021 14:15:01 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     NeilBrown <neilb@suse.de>, Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <20210730181501.GN10170@hungrycats.org>
References: <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org>
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org>
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
 <162762468711.21659.161298577376336564@noble.neil.brown.name>
 <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
 <162762802395.21659.5310176078177217626@noble.neil.brown.name>
 <21939589-bd90-116d-7351-b84ba58446b3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21939589-bd90-116d-7351-b84ba58446b3@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:09:12PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/30 下午2:53, NeilBrown wrote:
> > On Fri, 30 Jul 2021, Qu Wenruo wrote:
> > > > 
> > > > You mean like "du -x"?? Yes.  You would lose the misleading illusion
> > > > that there are multiple filesystems.  That is one user-expectation that
> > > > would need to be addressed before people opt-in
> > > 
> > > OK, forgot it's an opt-in feature, then it's less an impact.
> > 
> > The hope would have to be that everyone would eventually opt-in once all
> > issues were understood.
> > 
> > > 
> > > Really not familiar with NFS/VFS, thus some ideas from me may sounds
> > > super crazy.
> > > 
> > > Is it possible that, for nfsd to detect such "subvolume" concept by its
> > > own, like checking st_dev and the fsid returned from statfs().
> > > 
> > > Then if nfsd find some boundary which has different st_dev, but the same
> > > fsid as its parent, then it knows it's a "subvolume"-like concept.
> > > 
> > > Then do some local inode number mapping inside nfsd?
> > > Like use the highest 20 bits for different subvolumes, while the
> > > remaining 44 bits for real inode numbers.
> > > 
> > > Of-course, this is still a workaround...
> > 
> > Yes, it would certainly be possible to add some hacks to nfsd to fix the
> > immediate problem, and we could probably even created some well-defined
> > interfaces into btrfs to extract the required information so that it
> > wasn't too hackish.
> > 
> > Maybe that is what we will have to do.  But I'd rather not hack NFSD
> > while there is any chance that a more complete solution will be found.
> > 
> > I'm not quite ready to give up on the idea of squeezing all btrfs inodes
> > into a 64bit number space.  24bits of subvol and 40 bits of inode?
> > Make the split a mkfs or mount option?
> 
> Btrfs used to have a subvolume number limit in the past, for different
> reasons.
> 
> In that case, subvolume number is limited to 48 bits, which is still too
> large to avoid conflicts.
> 
> For inode number there is really no limit except the 256 ~ (U64)-256 limit.
> 
> Considering all these numbers are almost U64, conflicts would be
> unavoidable AFAIK.
> 
> > Maybe hand out inode numbers to subvols in 2^32 chunks so each subvol
> > (which has ever been accessed) has a mapping from the top 32 bits of the
> > objectid to the top 32 bits of the inode number.
> > 
> > We don't need something that is theoretically perfect (that's not
> > possible anyway as we don't have 64bits of device numbers).  We just
> > need something that is practical and scales adequately.  If you have
> > petabytes of storage, it is reasonable to spend a gigabyte of memory on
> > a lookup table(?).
> 
> Can such squishing-all-inodes-into-one-namespace work to be done in a
> more generic way? e.g, let each fs with "subvolume"-like feature to
> provide the interface to do that.

If you know the highest subvol ID number, you can pack two integers into
one larger integer by reversing the bits of the subvol number and ORing
them with the inode number, i.e. 0x0080000000000300 is subvol 256
inode 768.

The subvol ID's grow left to right while the inode numbers grow right
to left.  You can have billions of inodes in a few subvols, or billions of
subvols with a few inodes each, and neither will collide with the other
until there are billions of both.

If the filesystem tracks the number of bits in the highest subvol ID
and the highest inode number, then the inode numbers can be decoded,
and collisions can be detected.  e.g. if the maximum subvol ID on the
filesystem is below 131072, it will fit in 17 bits, then we know bits
63-47 are the subvol ID and bits 46-0 are the inode..  When subvol 131072
is created, the number of subvol bits increases to 18, but if every inode
fits in less than 46 bits, we know that every existing inode has a 0 in
the 18th subvol ID bit of the inode number, so there is no ambiguity.

If you don't know the maximum subvol ID, you can guess based on the
position of the large run of zero bits in the middle of the integer--not
reliable, but good enough for a guess if you were looking at 'ls -li'
output (and wrote the inode numbers in hex).

In the pathological case (the maximum subvol ID and maximum inode number
require more than 64 total bits) we return ENOSPC.

This can all be done when btrfs fills in an inode struct.  There's no need
to change the on-disk format, other than to track the highest inode and
subvol number.  btrfs can compute the maxima in reasonable but non-zero
time by searching trees on mount, so an incompatible disk format change
would only be needed to avoid making mount slower.

> Despite that I still hope to have a way to distinguish the "subvolume"
> boundary.

Packing the bits into a single uint64 doesn't help with this--it does
the opposite.  Subvol boundaries become harder to see without deliberate
checking (i.e. not the traditional parent.st_dev != child.st_dev test).

Judging from previous btrfs-related complaints, some users do want
"stealth" subvols whose boundaries are not accidentally visible, so the
new behavior could be a feature for someone.

> If completely inside btrfs, it's pretty simple to locate a subvolume
> boundary.
> All subvolume have the same inode number 256.
> 
> Maybe we could reserve some special "squished" inode number to indicate
> boundary inside a filesystem.
> 
> E.g. reserve (u64)-1 as a special indicator for subvolume boundaries.
> As most fs would have reserved super high inode numbers anyway.
> 
> 
> > 
> > If we can make inode numbers unique, we can possibly leave the st_dev
> > changing at subvols so that "du -x" works as currently expected.
> > 
> > One thought I had was to use a strong hash to combine the subvol object
> > id and the inode object id into a 64bit number.  What is the chance of
> > a collision in practice :-)
> 
> But with just 64bits, conflicts will happen anyway...

The collision rate might be low enough that we could just skip over the
colliding numbers, but we'd have to have some kind of in-memory collision
map to avoid slowing down inode creation (currently the next inode number
is more or less "++last_inode_number", and looking up inodes to see if
they exist first would slow down new file creation a lot).

> Thanks,
> Qu
> > 
> > Thanks,
> > NeilBrown
> > 
