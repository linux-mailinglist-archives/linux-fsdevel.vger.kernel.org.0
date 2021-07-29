Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AEE3D9B1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 03:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhG2BhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 21:37:06 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44102 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhG2BhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 21:37:00 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 21:37:00 EDT
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9EA3FB0898C; Wed, 28 Jul 2021 21:29:31 -0400 (EDT)
Date:   Wed, 28 Jul 2021 21:29:31 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Neal Gompa <ngompa13@gmail.com>, NeilBrown <neilb@suse.de>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <20210729012931.GK10170@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <20210728191431.GA3152@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728191431.GA3152@fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:14:31PM -0400, J. Bruce Fields wrote:
> On Wed, Jul 28, 2021 at 08:26:12AM -0400, Neal Gompa wrote:
> > I think this is behavior people generally expect, but I wonder what
> > the consequences of this would be with huge numbers of subvolumes. If
> > there are hundreds or thousands of them (which is quite possible on
> > SUSE systems, for example, with its auto-snapshotting regime), this
> > would be a mess, wouldn't it?
> 
> I'm surprised that btrfs is special here.  Doesn't anyone have thousands
> of lvm snapshots?  Or is it that they do but they're not normally
> mounted?

Unprivileged users can't create lvm snapshots as easily or quickly as
using mkdir (well, ok, mkdir and fssync).  lvm doesn't scale very well
past more than a few dozen snapshots of the same original volume, and
performance degrades linearly in the number of snapshots if the original
LV is modified.  btrfs is the opposite:  users can create and delete
as many snapshots as they like, at a cost more expensive than mkdir but
less expensive than 'cp -a', and users only pay IO costs for writes to
the subvols they modify.  So some btrfs users use snapshots in places
where more traditional tools like 'cp -a' or 'git checkout' are used on
other filesystems.

e.g. a build system might make a snapshot of a git working tree containing
a checked out and built baseline revision, and then it might do a loop
where it makes a snapshot, applies one patch from an integration branch
in the snapshot directory, and incrementally builds there.  The next
revision makes a snapshot of its parent revision's subvol and builds
the next patch.  If there are merges in the integration branch, then
the builder can go back to parent revisions, create a new snapshot,
apply the patch, and build in a snapshot on both sides of the merge.
After testing picks a winner, the builder can simply delete all the
snapshots except the one for the version that won testing (there is no
requirement to commit the snapshot to the origin LV as in lvm, either
can be destroyed without requiring action to preserve the other).

You can do a similar thing with overlayfs, but it runs into problems
with all the mount points.  In btrfs, the mount points are persistent
because they're built into the filesystem.  With overlayfs, you have
to save and restore them so they persist across reboots (unless that
feature has been added since I last looked).

I'm looking at a few machines here, and if all the subvols are visible to
'df', its output would be somewhere around 3-5 MB.  That's too much--we'd
have to hack up df to not show the same btrfs twice...as well as every
monitoring tool that reports free space...which sounds similar to the
problems we're trying to avoid.

Ideally there would be a way to turn this on or off.  It is creating a
set of new problems that is the complement of the set we're trying to
fix in this change.

> --b.
