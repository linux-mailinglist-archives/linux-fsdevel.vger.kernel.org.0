Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D517A4154B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 02:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhIWAkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 20:40:21 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:36137 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238709AbhIWAkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:40:20 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 88410FABBF0;
        Thu, 23 Sep 2021 10:38:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mTClA-00FbkM-1x; Thu, 23 Sep 2021 10:38:44 +1000
Date:   Thu, 23 Sep 2021 10:38:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: Alternative project ids and quotas semantics (Was: Shameless
 plug for the FS Track at LPC next week!)
Message-ID: <20210923003844.GV1756565@dread.disaster.area>
References: <20210916013916.GD34899@magnolia>
 <20210917083043.GA6547@quack2.suse.cz>
 <20210917083608.GB6547@quack2.suse.cz>
 <20210917093838.GC6547@quack2.suse.cz>
 <CAOQ4uxg3FYuQ3hrhG5H87Uzd-2gYXbFfUkeTPY7ESsDdjGB5EQ@mail.gmail.com>
 <20210917161217.GB10224@magnolia>
 <20210917231522.GT2361455@dread.disaster.area>
 <CAOQ4uxjGLJNA9p-zDS8F1cnGdxiCXYLO4My=qBMHjOF2B55vrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjGLJNA9p-zDS8F1cnGdxiCXYLO4My=qBMHjOF2B55vrQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=m-ou_RVVpQgPBfTu:21 a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=VbjtGQ0KdMLqzKRi98gA:9 a=CjuIK1q_8ugA:10 a=ns9Za6Vb_figrmUGg2RM:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 10:44:02AM +0300, Amir Goldstein wrote:
> On Sat, Sep 18, 2021 at 2:15 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Sep 17, 2021 at 09:12:17AM -0700, Darrick J. Wong wrote:
> > > On Fri, Sep 17, 2021 at 01:23:08PM +0300, Amir Goldstein wrote:
> > > > On Fri, Sep 17, 2021 at 12:38 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Fri 17-09-21 10:36:08, Jan Kara wrote:
> > > > > > Let me also post Amir's thoughts on this from a private thread:
> > > > >
> > > > > And now I'm actually replying to Amir :-p
> > > > >
> > > > > > On Fri 17-09-21 10:30:43, Jan Kara wrote:
> > > > > > > We did a small update to the schedule:
> > > > > > >
> > > > > > > > Christian Brauner will run the second session, discussing what idmapped
> > > > > > > > filesystem mounts are for and the current status of supporting more
> > > > > > > > filesystems.
> > > > > > >
> > > > > > > We have extended this session as we'd like to discuss and get some feedback
> > > > > > > from users about project quotas and project ids:
> > > > > > >
> > > > > > > Project quotas were originally mostly a collaborative feature and later got
> > > > > > > used by some container runtimes to implement limitation of used space on a
> > > > > > > filesystem shared by multiple containers. As a result current semantics of
> > > > > > > project quotas are somewhat surprising and handling of project ids is not
> > > > > > > consistent among filesystems. The main two contending points are:
> > > > > > >
> > > > > > > 1) Currently the inode owner can set project id of the inode to any
> > > > > > > arbitrary number if he is in init_user_ns. It cannot change project id at
> > > > > > > all in other user namespaces.
> > > > > > >
> > > > > > > 2) Should project IDs be mapped in user namespaces or not? User namespace
> > > > > > > code does implement the mapping, VFS quota code maps project ids when using
> > > > > > > them. However e.g. XFS does not map project IDs in its calls setting them
> > > > > > > in the inode. Among other things this results in some funny errors if you
> > > > > > > set project ID to (unsigned)-1.
> > > > > > >
> > > > > > > In the session we'd like to get feedback how project quotas / ids get used
> > > > > > > / could be used so that we can define the common semantics and make the
> > > > > > > code consistently follow these rules.
> > > > > >
> > > > > > I think that legacy projid semantics might not be a perfect fit for
> > > > > > container isolation requirements. I added project quota support to docker
> > > > > > at the time because it was handy and it did the job of limiting and
> > > > > > querying disk usage of containers with an overlayfs storage driver.
> > > > > >
> > > > > > With btrfs storage driver, subvolumes are used to create that isolation.
> > > > > > The TREE_ID proposal [1] got me thinking that it is not so hard to
> > > > > > implement "tree id" as an extention or in addition to project id.
> > > > > >
> > > > > > The semantics of "tree id" would be:
> > > > > > 1. tree id is a quota entity accounting inodes and blocks
> > > > > > 2. tree id can be changed only on an empty directory
> >
> > Hmmm. So once it's created, it can't be changed without first
> > deleting all the data in the tree?
> 
> That is correct.
> Similar to fscrypt_ioctl_set_policy().
> 
> >
> > > > > > 3. tree id can be set to TID only if quota inode usage of TID is 0
> >
> > What does this mean? Defining behaviour.semantics in terms of it's
> > implementation is ambiguous and open for interpretation.
> >
> 
> You are right. Let me give it a shot:
> 
> For the current use of project quotas in containers as a way to
> limit disk usage of container instance, container managers
> assign a project id with project quota to some directory that is
> going to be used as the root of a bind mount point inside the
> container (e.g. /home).
> 
> With xfs, that means that a user inside the container gets the df
> report on the bind mount based on xfs_qm_statvfs() which provides
> the project quota usage, which is intended to reflect the container's
> disk usage on the xfs filesystem that is shared among containers.
> 
> In practice, the container's disk usage may be contaminated by
> usage of other unrelated subtrees or solo files that have been
> assigned the same project id on purpose or by mistake.

In practice, this doesn't happen because the admin infrastructure
assigns unique project IDs to each container subtree. We don't allow
users to screw around with project IDs when this accounting
mechanism is in use for precisely this reason.

> The current permission model for changing project id does
> not always align with how container users should be allowed
> to manipulate their own reported disk usage and affect the
> disk usage reported or allowed to other containers.

What does this mean? Container users don't control how disk usage
within their container is reported. That is entirely controlled by
what the kernel returns from statfs() for a given path...

> The proposed alternative semantics for project ids and quotas
> will allow container managers better control over the disk usage
> observed by container users when project quotas are used, by making
> sure that project id represents a single fully connected subtree in
> the context of a single filesystem.

That's something that the admin interface *should* already be doing
with project quotas being used as directory quotas for container
accounting.

I don't see where the treeid quota proposal changes anything
material in the way containers and project quota based directory
quotas actually work together to provide and enforce admin defined
per-container space usage restrictions.

> > I *think* the intent here is that tree ids are unique and can only
> > be applied to a single tree, but...
> >
> You are correct. That is what it means.
> Subtree members on a *single filesystem* are all descendants
> of a single root.
> The subtree root is a directory and it is the only member of the subtree
> whose (sb) parent is not a member of the subtree.
> 
> > And, of course, what happens if we have multiple filesystems? tree
> > IDs are no longer globally unique across the system, right?
> 
> No requirement for tree id to be unique across the system.
> <st_dev, tree_id> should be unique across the system.

Haven't we learnt that lesson from btrfs and subvols yet?  Please
don't use st_dev as part of a unique filesystem object identifier.
We have UUIDs in filesystems for that purpose.

> > > > > > 4. tree id is always inherited from parent
> >
> > What happens as we traverse mount points within a tree? If the quota
> > applies to directory trees, then there are going to be directory
> > tree constructs that don't obviously follow this behaviour. e.g.
> > bind mounts from one directory tree to another, both having
> > different tree IDs.
> 
> We want nothing to do with that.

Yet we have to consider it because it can introduce cycles
in the the directed, uni-directional graph that this tree-id
proposal is based on.

> Quotas and disk usage have always been a filesystem property.
> I see no reason to extend them beyond a single filesystem boundary.

Paths build from directory trees are a VFS property, not a
filesystem property. Subtrees are a path-based mechanism, not an
inode based mechanism.

Indeed, bind mounts can be within a single filesystem. There's nothing
stopping users from binding part of one treeid's subtree into
another treeid's subtree all within the one filesystem. Is the
filesystem aware of this? Hell no - this is all done at the
vfs_mount level.

> Just because Niel chose to use the term "tree" to represent those
> entities, does not mean that they are related to mount trees.
> If the term is confusing then we can use a different term.
> I personally prefer the term "subtree" to represent those entities.

I'm not looking at a "tree". I'm looking at the directory heirachy
the VFS presents to users and how that maps to individual inodes in
a filesystem.

If we want functionality that defines an exclusive path based
subtree, behaviour and properties need to be defined, enforced and
propagated at the vfsmount level, not at the filesytem inode level.
The persistent information needed for this construct might be stored
in an inode that is used as the root of that subtree, but other than
that the functionality needs to be defined and managed at the path
level...

> Mind you, the STATX_TREE_ID proposal and the project id proposal
> that I derived from it are based on current btrfs subvol semantics.

Which doesn't actually have anything to do with exclusive accounting
for directory trees. It has to do with identifying inodes on
subvolumes uniquely, not whether the _paths to any specific inode_
are unique and exclusive.

> One difference between xfs/ext4 subtree quota and btrfs subvol
> is that subvol is also an isolated inode number namespace.
> Another difference is that currently, btrfs subvol has a unique
> st_dev, but Neil has proposed some designs to change that.

It seems to me that this is conflating unrelated issues.

> > Which then makes me question: are inodes and inode flags the right
> > place to track and propagate these tree IDs? Isn't the tree ID as
> > defined here a property of the path structure rather than a property
> > of the inode?  Should we actually be looking at a new directory tree
> > ID tracking behaviour at, say, the vfs-mount+dentry level rather
> > than the inode level?
> 
> That was not my intention with this proposal.

Sure, but it's the basic problem with the tree ID proposal - tree id
based quota require exclusive, single path access to inodes for
correct behaviour, and *filesystems* are not aware of VFS path
constructs.

> > > > > > 5. No rename() or link() across tree id (clone should be possible)
> >
> > The current directory tree quotas disallow this because of
> > implementation difficulties (e.g. avoiding recursive chproj inside
> > the kernel as part of rename()) and so would punt the operations too
> > difficult to do in the kernel back to userspace. They are not
> > intended to implement container boundaries in any way, shape or
> > form. Container boundaries need to use a proper access control
> > mechanism, not rely on side effects of difficult-to-implement low
> > level accounting mechanisms to provide access restriction.
> >
> > Indeed, why do we want to place restrictions on moving things across
> > trees if the filesystem can actually do so correctly? Hence I think
> > this is somewhat inappropriately be commingling container access
> > restrictions with usage accounting....
> >
> > I'm certain there will be filesytsems that do disallow rename and
> > link to punt the problem back up to userspace, but that's an
> > implementation detail to ensure accounting for the data movement to
> > a different tree is correct and not a behavioural or access
> > restriction...
> >
> 
> I did not list the no-cross rename()/link() requirement because
> of past project id behavior or because of filesystem implementation
> challenges.
> 
> I listed it because of the single-fully-connected-subtree requirement.
> rename()/link() across subtree boundaries would cause multiple roots
> of the same subtree id.

Why would rename even do that? The tree id would change with move to
the new location. i.e. rename from tree X to tree Y is just "sub
from quota X, add to quota Y". That is, the -tree id of the inode
changes- with a move to a different sub-tree. If you can do a manual
"copy from tree X to Y, unlink from X", then there is no valid
reason for explicitly preventing rename() from being used to do that
same operation. Whether a filesystem can implement that operation in
rename is another matter, but it's not a reason for preventing
rename across subtree that exist in the same filesystem.

Remember, quotas are for accounting resource usage, not for
restricting access or controlling what operations can be performed
on user data. That's what permissions are for. IOWs, if we want
"tree ids" to be able to prevent moving data from one sub tree to
another, we need to add those as access controls to the VFS, not
hide them deep down in the quota implementations in each filesystem.

> Sorry, Dave, for not writing a mathematical definition of a
> singly-connected-subtree-whatever, but by now,
> I hope you all understand very well what this beast is.
> It is really not that complicated (?).

It's not very complicated, but it is flawed. The premise is based on
a tree id that provides path based access restrictions but is
implemented at a layer that knows nothing about VFS paths or how
those paths are constructed by the user.

It really seems like treeid should be a property of a vfs mount,
not filesystem inodes...

> The reason I started the discussion with implementation rules
> is *because* they are so simple to understand, so I figured

Please don't assume that "simple rules" means the concept is simple
or that the implementation is simple. "Simple" often means "this
hasn't been though through fully yet" and it's not until somebody
else starts trying to understand why it is "simple" that all the
"not simple" issues with the proposal are documented...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
