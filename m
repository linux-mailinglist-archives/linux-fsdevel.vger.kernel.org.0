Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8C141019A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 01:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbhIQXQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 19:16:48 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:58646 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232079AbhIQXQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:16:48 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id DF67E10940E;
        Sat, 18 Sep 2021 09:15:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mRN4k-00Dh62-2x; Sat, 18 Sep 2021 09:15:22 +1000
Date:   Sat, 18 Sep 2021 09:15:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: Shameless plug for the FS Track at LPC next week!
Message-ID: <20210917231522.GT2361455@dread.disaster.area>
References: <20210916013916.GD34899@magnolia>
 <20210917083043.GA6547@quack2.suse.cz>
 <20210917083608.GB6547@quack2.suse.cz>
 <20210917093838.GC6547@quack2.suse.cz>
 <CAOQ4uxg3FYuQ3hrhG5H87Uzd-2gYXbFfUkeTPY7ESsDdjGB5EQ@mail.gmail.com>
 <20210917161217.GB10224@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917161217.GB10224@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=m-ou_RVVpQgPBfTu:21 a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=GQkCdkIK5JPku0ffV3gA:9 a=CjuIK1q_8ugA:10 a=ns9Za6Vb_figrmUGg2RM:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:12:17AM -0700, Darrick J. Wong wrote:
> On Fri, Sep 17, 2021 at 01:23:08PM +0300, Amir Goldstein wrote:
> > On Fri, Sep 17, 2021 at 12:38 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 17-09-21 10:36:08, Jan Kara wrote:
> > > > Let me also post Amir's thoughts on this from a private thread:
> > >
> > > And now I'm actually replying to Amir :-p
> > >
> > > > On Fri 17-09-21 10:30:43, Jan Kara wrote:
> > > > > We did a small update to the schedule:
> > > > >
> > > > > > Christian Brauner will run the second session, discussing what idmapped
> > > > > > filesystem mounts are for and the current status of supporting more
> > > > > > filesystems.
> > > > >
> > > > > We have extended this session as we'd like to discuss and get some feedback
> > > > > from users about project quotas and project ids:
> > > > >
> > > > > Project quotas were originally mostly a collaborative feature and later got
> > > > > used by some container runtimes to implement limitation of used space on a
> > > > > filesystem shared by multiple containers. As a result current semantics of
> > > > > project quotas are somewhat surprising and handling of project ids is not
> > > > > consistent among filesystems. The main two contending points are:
> > > > >
> > > > > 1) Currently the inode owner can set project id of the inode to any
> > > > > arbitrary number if he is in init_user_ns. It cannot change project id at
> > > > > all in other user namespaces.
> > > > >
> > > > > 2) Should project IDs be mapped in user namespaces or not? User namespace
> > > > > code does implement the mapping, VFS quota code maps project ids when using
> > > > > them. However e.g. XFS does not map project IDs in its calls setting them
> > > > > in the inode. Among other things this results in some funny errors if you
> > > > > set project ID to (unsigned)-1.
> > > > >
> > > > > In the session we'd like to get feedback how project quotas / ids get used
> > > > > / could be used so that we can define the common semantics and make the
> > > > > code consistently follow these rules.
> > > >
> > > > I think that legacy projid semantics might not be a perfect fit for
> > > > container isolation requirements. I added project quota support to docker
> > > > at the time because it was handy and it did the job of limiting and
> > > > querying disk usage of containers with an overlayfs storage driver.
> > > >
> > > > With btrfs storage driver, subvolumes are used to create that isolation.
> > > > The TREE_ID proposal [1] got me thinking that it is not so hard to
> > > > implement "tree id" as an extention or in addition to project id.
> > > >
> > > > The semantics of "tree id" would be:
> > > > 1. tree id is a quota entity accounting inodes and blocks
> > > > 2. tree id can be changed only on an empty directory

Hmmm. So once it's created, it can't be changed without first
deleting all the data in the tree?

> > > > 3. tree id can be set to TID only if quota inode usage of TID is 0

What does this mean? Defining behaviour.semantics in terms of it's
implementation is ambiguous and open for interpretation.

I *think* the intent here is that tree ids are unique and can only
be applied to a single tree, but...

And, of course, what happens if we have multiple filesystems? tree
IDs are no longer globally unique across the system, right? 

> > > > 4. tree id is always inherited from parent

What happens as we traverse mount points within a tree? If the quota
applies to directory trees, then there are going to be directory
tree constructs that don't obviously follow this behaviour. e.g.
bind mounts from one directory tree to another, both having
different tree IDs.

Which then makes me question: are inodes and inode flags the right
place to track and propagate these tree IDs? Isn't the tree ID as
defined here a property of the path structure rather than a property
of the inode?  Should we actually be looking at a new directory tree
ID tracking behaviour at, say, the vfs-mount+dentry level rather
than the inode level?

> > > > 5. No rename() or link() across tree id (clone should be possible)

The current directory tree quotas disallow this because of
implementation difficulties (e.g. avoiding recursive chproj inside
the kernel as part of rename()) and so would punt the operations too
difficult to do in the kernel back to userspace. They are not
intended to implement container boundaries in any way, shape or
form. Container boundaries need to use a proper access control
mechanism, not rely on side effects of difficult-to-implement low
level accounting mechanisms to provide access restriction.

Indeed, why do we want to place restrictions on moving things across
trees if the filesystem can actually do so correctly? Hence I think
this is somewhat inappropriately be commingling container access
restrictions with usage accounting....

I'm certain there will be filesytsems that do disallow rename and
link to punt the problem back up to userspace, but that's an
implementation detail to ensure accounting for the data movement to
a different tree is correct and not a behavioural or access
restriction...

> > > > AFAIK btrfs subvol meets all the requirements of "tree id".
> > > >
> > > > Implementing tree id in ext4/xfs could be done by adding a new field to
> > > > inode on-disk format and a new quota entity to quota on-disk format and
> > > > quotatools.
> > > >
> > > > An alternative simpler way is to repurpose project id and project quota:
> > > > * Add filesystem feature projid-is-treeid
> > > > * The feature can be enabled on fresh mkfs or after fsck verifies "tree id"
> > > >    rules are followed for all usage of projid
> > > > * Once the feature is enabled, filesystem enforces the new semantics
> > > >   about setting projid and projid_inherit
> 
> I'd probably just repurpose the project quota mechanism, which means
> that the xfs treeid is really just project quotas with somewhat
> different behavior rules that are tailored to modern adversarial usage
> models. ;)

Potentially, yes, though I'm yet not convinced a "tree quota" is
actually something we should track at an individual inode
level...

> IIRC someone asked for some sort of change like this on the xfs list
> some years back.  If memory serves, they wanted to prevent non-admin
> userspace from changing project ids, even in the regular user ns?  It
> never got as far as a formal proposal though.
> 
> I could definitely see a use case for letting admin processes in a
> container change project ids among only the projids that are idmapped
> into the namespace.

Yup, all we need is a solid definition of how it will work, but
that's always been the point where silence has fallen on the
discussion.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
