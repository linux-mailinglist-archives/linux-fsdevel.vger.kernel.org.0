Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E833DAFC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 01:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhG2XUX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 19:20:23 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40860 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhG2XUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 19:20:23 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 502B8B0AA1C; Thu, 29 Jul 2021 19:20:18 -0400 (EDT)
Date:   Thu, 29 Jul 2021 19:20:18 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Neal Gompa <ngompa13@gmail.com>,
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
Message-ID: <20210729232017.GE10106@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org>
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <162752976632.21659.9573422052804077340@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 01:36:06PM +1000, NeilBrown wrote:
> On Thu, 29 Jul 2021, Zygo Blaxell wrote:
> > On Thu, Jul 29, 2021 at 08:50:50AM +1000, NeilBrown wrote:
> > > On Wed, 28 Jul 2021, Neal Gompa wrote:
> > > > On Wed, Jul 28, 2021 at 3:02 AM NeilBrown <neilb@suse.de> wrote:
> > > > >
> > > > > On Wed, 28 Jul 2021, Wang Yugui wrote:
> > > > > > Hi,
> > > > > >
> > > > > > This patchset works well in 5.14-rc3.
> > > > >
> > > > > Thanks for testing.
> > > > >
> > > > > >
> > > > > > 1, fixed dummy inode(255, BTRFS_FIRST_FREE_OBJECTID - 1 )  is changed to
> > > > > > dynamic dummy inode(18446744073709551358, or 18446744073709551359, ...)
> > > > >
> > > > > The BTRFS_FIRST_FREE_OBJECTID-1 was a just a hack, I never wanted it to
> > > > > be permanent.
> > > > > The new number is ULONG_MAX - subvol_id (where subvol_id starts at 257 I
> > > > > think).
> > > > > This is a bit less of a hack.  It is an easily available number that is
> > > > > fairly unique.
> > > > >
> > > > > >
> > > > > > 2, btrfs subvol mount info is shown in /proc/mounts, even if nfsd/nfs is
> > > > > > not used.
> > > > > > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test
> > > > > > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub1
> > > > > > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub2
> > > > > >
> > > > > > This is a visiual feature change for btrfs user.
> > > > >
> > > > > Hopefully it is an improvement.  But it is certainly a change that needs
> > > > > to be carefully considered.
> > > > 
> > > > I think this is behavior people generally expect, but I wonder what
> > > > the consequences of this would be with huge numbers of subvolumes. If
> > > > there are hundreds or thousands of them (which is quite possible on
> > > > SUSE systems, for example, with its auto-snapshotting regime), this
> > > > would be a mess, wouldn't it?
> > > 
> > > Would there be hundreds or thousands of subvols concurrently being
> > > accessed? The auto-mounted subvols only appear in the mount table while
> > > that are being accessed, and for about 15 minutes after the last access.
> > > I suspect that most subvols are "backup" snapshots which are not being
> > > accessed and so would not appear.
> > 
> > bees dedupes across subvols and polls every few minutes for new data
> > to dedupe.  bees doesn't particularly care where the "src" in the dedupe
> > call comes from, so it will pick a subvol that has a reference to the
> > data at random (whichever one comes up first in backref search) for each
> > dedupe call.  There is a cache of open fds on each subvol root so that it
> > can access files within that subvol using openat().  The cache quickly
> > populates fully, i.e. it holds a fd to every subvol on the filesystem.
> > The cache has a 15 minute timeout too, so bees would likely keep the
> > mount table fully populated at all times.
> 
> OK ... that is very interesting and potentially helpful - thanks.
> 
> Localizing these daemons in a separate namespace would stop them from
> polluting the public namespace, but I don't know how easy that would
> be..
> 
> Do you know how bees opens these files?  Does it use path-names from the
> root, or some special btrfs ioctl, or ???

There's a function in bees that opens a subvol root directory by subvol
id.  It walks up the btrfs subvol tree with btrfs ioctls to construct a
path to the root, then down the filesystem tree with other btrfs ioctls
to get filenames for each subvol.  The filenames are fed to openat()
with the parent subvol's fd to get a fd for each child subvol's root
directory along the path.  This is recursive and expensive (the fd
has to be checked to see if it matches the subvol, in case some other
process renamed it) and called every time bees wants to open a file,
so the fd goes into a cache for future open-subvol-by-id calls.

For files, bees calls subvol root open to get a fd for the subvol's root,
then calls the btrfs inode-to-path ioctl on that fd to get a list of
names for the inode, then openat(subvol_fd, inode_to_path(inum), ...) on
each name until a fd matching the target subvol and inode is obtained.
File access is driven by data content, so bees cannot easily predict
which files will need to be accessed again in the near future and which
can be closed.  The fd cache is a brute-force way to reduce the number
of inode-to-path and open calls.

Upper layers of bees use (subvol, inode) pairs to identify files
and request file descriptors.  The lower layers use filenames as an
implementation detail for compatibility with kernel API.

> If path-names are not used, it might be possible to suppress the
> automount. 

A userspace interface to read and dedupe that doesn't use pathnames or
file descriptors (other than one fd to bind the interface to a filesystem)
would be nice!  About half of the bees code is devoted to emulating
that interface using the existing kernel API.

Ideally a dedupe agent would be able to pass two physical offsets and
a length of identical data to the filesystem without ever opening a file.

While I'm in favor of making bees smaller, this seems like an expensive
way to suppress automounts.

> > plocate also uses openat() and it can also be active on many subvols
> > simultaneously, though it only runs once a day, and it's reasonable to
> > exclude all snapshots from plocate for performance reasons.
> > 
> > My bigger concern here is that users on btrfs can currently have private
> > subvols with secret names.  e.g.
> > 
> > 	user$ mkdir -m 700 private
> > 	user$ btrfs sub create private/secret
> > 	user$ cd private/secret
> > 	user$ ...do stuff...
> > 
> > Would "secret" now be visible in the very public /proc/mounts every time
> > the user is doing stuff?
> 
> Yes, the secret would be publicly visible.  Unless we hid it.
> 
> It is conceivable that the content of /proc/mounts could be limited to
> mountpoints where the process reading had 'x' access to the mountpoint. 
> However to be really safe we would want to require 'x' access to all
> ancestors too, and possibly some 'r' access.  That would get
> prohibitively expensive.

And inconsistent, since we don't do that with other mount points, i.e.
outside of btrfs.  But we do hide parts of the path names when the
process's filesystem root or namespace changes, so maybe this is more
of that.

> We could go with "owned by root, or owned by user" maybe.
> 
> Thanks,
> NeilBrown
> 
> 
> > 
> > > > Or can we add a way to mark these things to not show up there or is
> > > > there some kind of behavioral change we can make to snapper or other
> > > > tools to make them not show up here?
> > > 
> > > Certainly it might make sense to flag these in some way so that tools
> > > can choose the ignore them or handle them specially, just as nfsd needs
> > > to handle them specially.  I was considering a "local" mount flag.
> > 
> > I would definitely want an 'off' switch for this thing until the impact
> > is better understood.
> > 
> > > NeilBrown
> > > 
> > > > 
> > > > 
> > > > 
> > > > -- 
> > > > 真実はいつも一つ！/ Always, there's only one truth!
> > > > 
> > > > 
> > 
> > 
> 
