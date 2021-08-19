Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2934E3F1044
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 04:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhHSCTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 22:19:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40412 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbhHSCTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:19:48 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0FBA7B3967D; Wed, 18 Aug 2021 22:19:10 -0400 (EDT)
Date:   Wed, 18 Aug 2021 22:19:10 -0400
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
Message-ID: <20210819021910.GB29026@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
 <20210818225454.9558.409509F4@e16-tech.com>
 <162932318266.9892.13600254282844823374@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162932318266.9892.13600254282844823374@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 07:46:22AM +1000, NeilBrown wrote:
> On Thu, 19 Aug 2021, Wang Yugui wrote:
> > Hi,
> > 
> > We use  'swab64' to combinate 'subvol id' and 'inode' into 64bit in this
> > patch.
> > 
> > case1:
> > 'subvol id': 16bit => 64K, a little small because the subvol id is
> > always increase?
> > 'inode':	48bit * 4K per node, this is big enough.
> > 
> > case2:
> > 'subvol id': 24bit => 16M,  this is big enough.
> > 'inode':	40bit * 4K per node => 4 PB.  this is a little small?
> 
> I don't know what point you are trying to make with the above.
> 
> > 
> > Is there a way to 'bit-swap' the subvol id, rather the current byte-swap?
> 
> Sure:
>    for (i=0; i<64; i++) {
>         new = (new << 1) | (old & 1)
>         old >>= 1;
>    }
> 
> but would it gain anything significant?
> 
> Remember what the goal is.  Most apps don't care at all about duplicate
> inode numbers - only a few do, and they only care about a few inodes.
> The only bug I actually have a report of is caused by a directory having
> the same inode as an ancestor.  i.e.  in lots of cases, duplicate inode
> numbers won't be noticed.

rsync -H and cpio's hardlink detection can be badly confused.  They will
think distinct files with the same inode number are hardlinks.  This could
be bad if you were making backups (though if you're making backups over
NFS, you are probably doing something that could be done better in a
different way).

> The behaviour of btrfs over NFS RELIABLY causes exactly this behaviour
> of a directory having the same inode number as an ancestor.  The root of
> a subtree will *always* do this.  If we JUST changed the inode numbers
> of the roots of subtrees, then most observed problems would go away.  It
> would change from "trivial to reproduce" to "rarely happens".  The patch
> I actually propose makes it much more unlikely than that.  Even if
> duplicate inode numbers do happen, the chance of them being noticed is
> infinitesimal.  Given that, there is no point in minor tweaks unless
> they can make duplicate inode numbers IMPOSSIBLE.

That's a good argument.  I have a different one with the same conclusion.

40 bit inodes would take about 20 years to collide with 24-bit subvols--if
you are creating an average of 1742 inodes every second.  Also at the
same time you have to be creating a subvol every 37 seconds to occupy
the colliding 25th bit of the subvol ID.  Only the highest inode number
in any subvol counts--if your inode creation is spread out over several
different subvols, you'll need to make inodes even faster.

For reference, my high scores are 17 inodes per second and a subvol
every 595 seconds (averaged over 1 year).  Burst numbers are much higher,
but one has to spend some time _reading_ the files now and then.

I've encountered other btrfs users with two orders of magnitude higher
inode creation rates than mine.  They are barely squeaking under the
20-year line--or they would be, if they were creating snapshots 50 times
faster than they do today.

Use cases that have the highest inode creation rates (like /tmp) tend
to get more specialized storage solutions (like tmpfs).

Cloud fleets do have higher average inode creation rates, but their
filesystems have much shorter lifespans than 20 years, so the delta on
both sides of the ratio cancels out.

If this hack is only used for NFS, it gives us some time to come up
with a better solution.  (On the other hand, we had 14 years already,
and here we are...)

> > If not, maybe it is a better balance if we combinate 22bit subvol id and
> > 42 bit inode?
> 
> This would be better except when it is worse.  We cannot know which will
> happen more often.
> 
> As long as BTRFS allows object-ids and root-ids combined to use more
> than 64 bits there can be no perfect solution.  There are many possible
> solutions that will be close to perfect in practice.  swab64() is the
> simplest that I could think of.  Picking any arbitrary cut-off (22/42,
> 24/40, ...) is unlikely to be better, and could is some circumstances be
> worse.
> 
> My preference would be for btrfs to start re-using old object-ids and
> root-ids, and to enforce a limit (set at mkfs or tunefs) so that the
> total number of bits does not exceed 64.  Unfortunately the maintainers
> seem reluctant to even consider this.

It was considered, implemented in 2011, and removed in 2020.  Rationale
is in commit b547a88ea5776a8092f7f122ddc20d6720528782 "btrfs: start
deprecation of mount option inode_cache".  It made file creation slower,
and consumed disk space, iops, and memory to run.  Nobody used it.
Newer on-disk data structure versions (free space tree, 2015) didn't
bother implementing inode_cache's storage requirement.

> NeilBrown
