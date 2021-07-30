Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8F3DBDE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhG3RnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 13:43:21 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33036 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhG3RnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 13:43:20 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DF87AB0C43E; Fri, 30 Jul 2021 13:43:13 -0400 (EDT)
Date:   Fri, 30 Jul 2021 13:43:13 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, NeilBrown <neilb@suse.de>,
        Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <20210730174313.GM10170@hungrycats.org>
References: <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org>
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org>
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
 <162762468711.21659.161298577376336564@noble.neil.brown.name>
 <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
 <20210730151748.GA21825@fieldses.org>
 <ae85654d-950f-04a2-8fca-145412b31e57@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae85654d-950f-04a2-8fca-145412b31e57@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:48:15AM -0400, Josef Bacik wrote:
> On 7/30/21 11:17 AM, J. Bruce Fields wrote:
> > On Fri, Jul 30, 2021 at 02:23:44PM +0800, Qu Wenruo wrote:
> > > OK, forgot it's an opt-in feature, then it's less an impact.
> > > 
> > > But it can still sometimes be problematic.
> > > 
> > > E.g. if the user want to put some git code into one subvolume, while
> > > export another subvolume through NFS.
> > > 
> > > Then the user has to opt-in, affecting the git subvolume to lose the
> > > ability to determine subvolume boundary, right?
> > 
> > Totally naive question: is it be possible to treat different subvolumes
> > differently, and give the user some choice at subvolume creation time
> > how this new boundary should behave?
> > 
> > It seems like there are some conflicting priorities that can only be
> > resolved by someone who knows the intended use case.
> > 
> 
> This is the crux of the problem.  We have no real interfaces or anything to
> deal with this sort of paradigm.  We do the st_dev thing because that's the
> most common way that tools like find or rsync use to determine they've
> wandered into a "different" volume.  This exists specifically because of
> usescases like Zygo's, where he's taking thousands of snapshots and manually
> excluding them from find/rsync is just not reasonable.
> 
> We have no good way to give the user information about what's going on, we
> just have these old shitty interfaces.  I asked our guys about filling up
> /proc/self/mountinfo with our subvolumes and they had a heart attack because
> we have around 2-4k subvolumes on machines, and with monitoring stuff in
> place we regularly read /proc/self/mountinfo to determine what's mounted and
> such.
> 
> And then there's NFS which needs to know that it's walked into a new inode space.

NFS somehow works surprisingly well without knowing that.  I didn't know
there was a problem with NFS, despite exporting thousands of btrfs subvols
from a single export point for 7 years.  Maybe I have some non-default
setting in /etc/exports which works around the problems, or maybe I got
lucky, and all my use cases are weirdly specific and evade all the bugs
by accident?

> This is all super shitty, and mostly exists because we don't have a good way
> to expose to the user wtf is going on.
> 
> Personally I would be ok with simply disallowing NFS to wander into
> subvolumes from an exported fs.  If you want to export subvolumes then
> export them individually, otherwise if you walk into a subvolume from NFS
> you simply get an empty directory.

As a present exporter of thousands of btrfs subvols over NFS from single
export points, I'm not a fan of this idea.

> This doesn't solve the mountinfo problem where a user may want to figure out
> which subvol they're in, but this is where I think we could address the
> issue with better interfaces.  Or perhaps Neil's idea to have a common major
> number with a different minor number for every subvol.

It's not hard to figure out what subvol you're in.  There's an ioctl
which tells the subvol ID, and another that tells the name.  The problem
is that it's btrfs-specific, and no existing software knows how and when
to use it (and also it's privileged, but that's easy to fix compared to
the other issues).

> Either way this isn't as simple as shoehorning it into automount and being
> done with it, we need to take a step back and think about how should this
> actually look, taking into account we've got 12 years of having Btrfs
> deployed with existing usecases that expect a certain behavior.  Thanks,

I think if we got into a time machine, went back 12 years, changed
the btrfs behavior, and then returned to the present, in the alternate
history, we would all be here today talking about how mountinfo doesn't
scale up to what btrfs throws at it, and can btrfs opt out of it somehow.

Maybe we could have a system call for mount point discovery?  Right now,
the kernel throws a trail of breadcrumbs into /proc/self/mountinfo,
and users use userspace libraries to translate that text blob into
actionable information.  We could solve problems with scalability and
visibility in mountinfo if we only had to provide the information in
the context of a single inode (i.e. the inode's parent or child mount
points accessible to the caller).

So you'd have a call for "get paths for all the mount points below inode
X" and another for "get paths for all mount points above inode X", and
calls that tell you details about mount points (like what they're mounted
on, which filesystem they are part of, what the mount flags are, etc).

> Josef
