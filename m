Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814733EA6C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhHLOrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbhHLOrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:47:45 -0400
X-Greylist: delayed 2424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Aug 2021 07:47:20 PDT
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F778C061756;
        Thu, 12 Aug 2021 07:47:19 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1mEBLM-0000bf-Sl; Thu, 12 Aug 2021 15:06:00 +0100
Date:   Thu, 12 Aug 2021 15:06:00 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     NeilBrown <neilb@suse.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/4] Attempt to make progress with btrfs dev number
 strangeness.
Message-ID: <20210812140600.GA15870@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>
 <e6496956-0df3-6232-eecb-5209b28ca790@toxicpanda.com>
 <162872000356.22261.854151210687377005@noble.neil.brown.name>
 <6571d3fb-34ea-0f22-4fbe-995e5568e044@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6571d3fb-34ea-0f22-4fbe-995e5568e044@toxicpanda.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 09:54:54AM -0400, Josef Bacik wrote:
> On 8/11/21 6:13 PM, NeilBrown wrote:
> > On Wed, 11 Aug 2021, Josef Bacik wrote:
> > > 
> > > I think this is a step in the right direction, but I want to figure out a way to
> > > accomplish this without magical mount points that users must be aware of.
> > 
> > magic mount *options* ???
> > 
> > > 
> > > I think the stat() st_dev ship as sailed, we're stuck with that.  However
> > > Christoph does have a valid point where it breaks the various info spit out by
> > > /proc.  You've done a good job with the treeid here, but it still makes it
> > > impossible for somebody to map the st_dev back to the correct mount.
> > 
> > The ship might have sailed, but it is not water tight.  And as the world
> > it round, it can still come back to bite us from behind.
> > Anything can be transitioned away from, whether it is devfs or 32-bit
> > time or giving different device numbers to different file-trees.
> > 
> > The linkage between device number and and filesystem is quite strong.
> > We could modified all of /proc and /sys/ and audit and whatever else to
> > report the fake device number, but we cannot get the fake device number
> > into the mount table (without making the mount table unmanageablely
> > large).
> > And if subtrees aren't in the mount-table for the NFS server, I don't
> > think they should be in the mount-table of the NFS client.  So we cannot
> > export them to NFS.
> > 
> > I understand your dislike for mount options.  An alternative with
> > different costs and benefits would be to introduce a new filesystem type
> > - btrfs2 or maybe betrfs.  This would provide numdevs=1 semantics and do
> > whatever we decided was best with inode numbers.  How much would you
> > hate that?
> > 
> 
> A lot more ;).
> 
> > > 
> > > I think we aren't going to solve that problem, at least not with stat().  I
> > > think with statx() spitting out treeid we have given userspace a way to
> > > differentiate subvolumes, and so we should fix statx() to spit out the the super
> > > block device, that way new userspace things can do their appropriate lookup if
> > > they so choose.
> > 
> > I don't think we should normalize having multiple devnums per filesystem
> > by encoding it in statx().  It *would* make sense to add a btrfs ioctl
> > which reports the real device number of a file.  Tools that really need
> > to work with btrfs could use that, but it would always be obvious that
> > it was an exception.
> 
> That's not what I'm saying.  I'm saying that stat() continues to behave the
> way it currently does, for legacy users.
> 
> And then for statx() it returns the correct devnum like any other file
> system, with the augmentation of the treeid so that future userspace
> programs can use the treeid to decide if they want to wander into a
> subvolume.
> 
> This way moving forward we have a way to map back to a mount point because
> statx() will return the actual devnum for the mountpoint, and then we can
> use the treeid to be smart about when we wander into a subvolume.
> 
> And if we're going to add a treeid, I would actually like to add a
> parent_treeid as well so we could tell if we're a snapshot or just a normal
> subvolume.

   Can I make a request to call it something other than a
"parent". There's at least three different usages of "parent" for
three different concepts related to subvolumes in btrfs(*), and it'd
be nice to avoid the inevitable confusion.

(*) 1. "subvolume containing this one",
    2. "subvolume that was snapshotted to make this one", and,
    3. at least informally, "subvolume that was sent/received to make this one"

   Hugo.

[snip to end]

-- 
Hugo Mills             | Reading Mein Kampf won't make you a Nazi. Reading
hugo@... carfax.org.uk | Das Kapital won't make you a communist. But most
http://carfax.org.uk/  | trolls started out with a copy of Lord of the Rings.
PGP: E2AB1DE4          |
