Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325153EA0B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhHLIjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 04:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235350AbhHLIiz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:38:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F36466103E;
        Thu, 12 Aug 2021 08:38:28 +0000 (UTC)
Date:   Thu, 12 Aug 2021 10:38:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Questions re the new mount_setattr(2) manual page
Message-ID: <20210812083826.bfuqiwjlshjdwdby@wittgenstein>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
 <d5a8061a-3d8a-6353-5158-8feee0156c6b@gmail.com>
 <20210811104030.in6f25hw5h5cotti@wittgenstein>
 <2f640877-dd82-6827-dfd0-c7f8fd5acbbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f640877-dd82-6827-dfd0-c7f8fd5acbbc@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 07:36:54AM +0200, Michael Kerrisk (man-pages) wrote:
> [CC += Eric, in case he has a comment on the last piece]
> 
> Hi Christian,
> 
> (A few questions below.)
> 
> On 8/11/21 12:40 PM, Christian Brauner wrote:
> > On Wed, Aug 11, 2021 at 12:47:14AM +0200, Michael Kerrisk (man-pages) wrote:
> >> Hi Christian,
> >>
> >> Some further questions...
> >>
> >> In ERRORS there is:
> >>
> >>        EINVAL The underlying filesystem is mounted in a user namespace.
> >>
> >> I don't understand this. What does it mean?
> > 
> > The underlying filesystem has been mounted in a mount namespace that is
> > owned by a non-initial user namespace (Think of sysfs, overlayfs etc.).
> 
> Thanks!
> 
> >> Also, there is this:
> >>
> >>        ENOMEM When  changing  mount  propagation to MS_SHARED, a new peer
> >>               group ID needs to be allocated for  all  mounts  without  a
> >>               peer  group  ID  set.  Allocation of this peer group ID has
> >>               failed.
> >>
> >>        ENOSPC When changing mount propagation to MS_SHARED,  a  new  peer
> >>               group  ID  needs  to  be allocated for all mounts without a
> >>               peer group ID set.  Allocation of this peer  group  ID  can
> >>               fail.  Note that technically further error codes are possi‐
> >>               ble that are specific to the ID  allocation  implementation
> >>               used.
> >>
> >> What is the difference between these two error cases? (That is, in what 
> >> circumstances will one get ENOMEM vs ENOSPC and vice versa?)
> > 
> > I did really wonder whether to even include those errors and I regret
> > having included them because they aren't worth a detailed discussion as
> > I'd consider them kernel internal relevant errors rather than userspace
> > relevant errors. In essence, peer group ids are allocated using the id
> > infrastructure of the kernel. It can fail for two main reasons:
> > 
> > 1. ENOMEM there's not enough memory to allocate the relevant internal
> >    structures needed for the bitmap.
> > 2. ENOSPC we ran out of ids, i.e. someone has somehow managed to
> >    allocate so many peer groups and managed to keep the kernel running
> >    (???) that the ida has ran out of ids.
> > 
> > Feel free to just drop those errors.
> 
> Because they can at least theoretically be visible to user space, I
> prefer to keep them. But I've reworked a bit:
> 
>        ENOMEM When changing mount propagation to MS_SHARED, a new
>               peer group ID needs to be allocated for all mounts
>               without a peer group ID set.  This allocation failed
>               because there was not enough memory to allocate the
>               relevant internal structures.
> 
>        ENOSPC When changing mount propagation to MS_SHARED, a new
>               peer group ID needs to be allocated for all mounts
>               without a peer group ID set.  This allocation failed
>               because the kernel has run out of IDs.
> 
> >> And then:
> >>
> >>        EPERM  One  of  the mounts had at least one of MOUNT_ATTR_NOATIME,
> >>               MOUNT_ATTR_NODEV, MOUNT_ATTR_NODIRATIME, MOUNT_ATTR_NOEXEC,
> >>               MOUNT_ATTR_NOSUID, or MOUNT_ATTR_RDONLY set and the flag is
> >>               locked.  Mount attributes become locked on a mount if:
> >>
> >>               •  A new mount or mount tree is created causing mount prop‐
> >>                  agation  across  user  namespaces.  The kernel will lock
> >>
> >> Propagation is done across mont points, not user namespaces.
> >> should "across user namespaces" be "to a mount namespace owned 
> >> by a different user namespace"? Or something else?
> > 
> > That's really splitting hairs.
> 
> To be clear, I'm not trying to split hairs :-). It's just that
> I'm struggling a little to understand. (In particular, the notion
> of locked mounts is one where my understanding is weak.) 
> 
> And think of it like this: I am the first line of defense for the
> user-space reader. If I am having trouble to understand the text,
> I wont be alone. And often, the problem is not so much that the
> text is "wrong", it's that there's a difference in background
> knowledge between what you know and what the reader (in this case
> me) knows. Part of my task is to fill that gap, by adding info
> that I think is necessary to the page (with the happy side
> effect that I learn along the way.)

All very good points.
I didn't mean to complain btw. Sorry that it seemed that way. :)

> 
> > Of course this means that we're
> > propagating into a mount namespace that is owned by a different user
> > namespace though "crossing user namespaces" might have been the better
> > choice.
> 
> This is a perfect example of the point I make above. You say "of course",
> but I don't have the background knowledge that you do :-). From my
> perspective, I want to make sure that I understand your meaning, so
> that that meaning can (IMHO) be made easier for the average reader
> of the manual page.
> 
> >>                  the aforementioned  flags  to  protect  these  sensitive
> >>                  properties from being altered.
> >>
> >>               •  A  new  mount  and user namespace pair is created.  This
> >>                  happens for  example  when  specifying  CLONE_NEWUSER  |
> >>                  CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).  The
> >>                  aforementioned flags become locked to protect user name‐
> >>                  spaces from altering sensitive mount properties.
> >>
> >> Again, this seems imprecise. Should it say something like:
> >> "... to prevent changes to sensitive mount properties in the new 
> >> mount namespace" ? Or perhaps you have a better wording.
> > 
> > That's not imprecise. 
> 
> Okay -- poor choice of wording on my part:
> 
> s/this seems imprecise/I'm having trouble understanding this/
> 
> > What you want to protect against is altering
> > sensitive mount properties from within a user namespace irrespective of
> > whether or not the user namespace actually owns the mount namespace,
> > i.e. even if you own the mount namespace you shouldn't be able to alter
> > those properties. I concede though that "protect" should've been
> > "prevent".
> 
> Can I check my education here please. The point is this:
> 
> * The mount point was created in a mount NS that was owned by
>   a more privileged user NS (e.g., the initial user NS).
> * A CLONE_NEWUSER|CLONE_NEWNS step occurs to create a new (user and) 
>   mount NS.
> * In the new mount NS, the mounts become locked.
> 
> And, help me here: is it correct that the reason the properties
> need to be locked is because they are shared between the mounts?

Yes, basically.
The new mount namespace contains a copy of all the mounts in the
previous mount namespace. So they are separate mounts which you can best
see when you do unshare --mount --propagation=private. An unmount in the
new mount namespace won't affect the mount in the previous mount
namespace. Which can only nicely work if they are separate mounts.
Propagation relies (among other things) on the fact that mount
namespaces have copies of the mounts.

The copied mounts in the new mount namespace will have inherited all
properties they had at the time when copy_namespaces() and specifically
copy_mnt_ns() was called. Which calls into copy_tree() and ultimately
into the appropriately named clone_mnt(). This is the low-level routine
that is responsible for cloning the mounts including their mount
properties.

Some mount properties such as read-only, nodev, noexec, nosuid, atime -
while arguably not per se security mechanisms - are used for protection
or as security measures in userspace applications. The most obvious one
might be the read-only property. One wouldn't want to expose a set of
files as read-only only for someone else to trivially gain write access
to them. An example of where that could happen is when creating a new
mount namespaces and user namespace pair where the new mount namespace
is owned by the new user namespace in which the caller is privileged and
thus the caller would also able to alter the new mount namespace. So
without locking flags all it would take to turn a read-only into a
read-write mount is:
unshare -U --map-root --propagation=private -- mount -o remount,rw /some/mnt
locking such flags prevents that from happening.

> 
> > You could probably say:
> > 
> > 	A  new  mount  and user namespace pair is created.  This
> > 	happens for  example  when  specifying  CLONE_NEWUSER  |
> > 	CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).
> > 	The aforementioned flags become locked in the new mount
> > 	namespace to prevent sensitive mount properties from being
> > 	altered.
> > 	Since the newly created mount namespace will be owned by the
> > 	newly created user namespace a caller privileged in the newly
> > 	created user namespace would be able to alter senstive
> > 	mount properties. For example, without locking the read-only
> > 	property for the mounts in the new mount namespace such a caller
> > 	would be able to remount them read-write.
> 
> So, I've now made the text:
> 
>        EPERM  One of the mounts had at least one of MOUNT_ATTR_NOATIME,
>               MOUNT_ATTR_NODEV, MOUNT_ATTR_NODIRATIME, MOUNT_ATTR_NOEXEC,
>               MOUNT_ATTR_NOSUID, or MOUNT_ATTR_RDONLY set and the flag is
>               locked.  Mount attributes become locked on a mount if:
> 
>               •  A new mount or mount tree is created causing mount
>                  propagation across user namespaces (i.e., propagation to
>                  a mount namespace owned by a different user namespace).
>                  The kernel will lock the aforementioned flags to prevent
>                  these sensitive properties from being altered.
> 
>               •  A new mount and user namespace pair is created.  This
>                  happens for example when specifying CLONE_NEWUSER |
>                  CLONE_NEWNS in unshare(2), clone(2), or clone3(2).  The
>                  aforementioned flags become locked in the new mount
>                  namespace to prevent sensitive mount properties from
>                  being altered.  Since the newly created mount namespace
>                  will be owned by the newly created user namespace, a
>                  calling process that is privileged in the new user
>                  namespace would—in the absence of such locking—be able
>                  to alter senstive mount properties (e.g., to remount a
>                  mount that was marked read-only as read-write in the new
>                  mount namespace).
> 
> Okay?

Sounds good.

> 
> > (Fwiw, in this scenario there's a bit of (moderately sane) strangeness.
> >  A CLONE_NEWUSER | CLONE_NEWMNT will cause even stronger protection to
> >  kick in. For all mounts not marked as expired MNT_LOCKED will be set
> >  which means that a umount() on any such mount copied from the previous
> >  mount namespace will yield EINVAL implying from userspace' perspective
> >  it's not mounted - granted EINVAL is the ioctl() of multiplexing errnos
> >  - whereas a remount to alter a locked flag will yield EPERM.)
> 
> Thanks for educating me! So, is that what we are seeing below?
> 
> $ sudo umount /mnt/m1
> $ sudo mount -t tmpfs none /mnt/m1
> $ sudo unshare -pf -Ur -m --mount-proc strace -o /tmp/log umount /mnt/m1
> umount: /mnt/m1: not mounted.
> $ grep ^umount /tmp/log
> umount2("/mnt/m1", 0)                   = -1 EINVAL (Invalid argument)
> 
> The mount_namespaces(7) page has for a log time had this text:
> 
>        *  Mounts that come as a single unit from a more privileged mount
>           namespace are locked together and may not be separated in a
>           less privileged mount namespace.  (The unshare(2) CLONE_NEWNS
>           operation brings across all of the mounts from the original
>           mount namespace as a single unit, and recursive mounts that
>           propagate between mount namespaces propagate as a single unit.)
> 
> I have had trouble understanding that. But maybe you just helped.
> Is that text relevant to what you just wrote above? In particular,
> I have trouble understanding what "separated" means. But, perhaps

The text gives the "how" not the "why".
Consider a more elaborate mount tree where e.g., you have bind-mounted a
mount over a subdirectory of another mount:

sudo mount -t tmpfs /mnt
sudo mkdir /mnt/my-dir/
sudo touch /mnt/my-dir/my-file
sudo mount --bind /opt /mnt/my-dir

The files underneath /mnt/my-dir are now hidden. Consider what would
happen if one would allow to address those mounts separately. A user
could then do:

unshare -U --map-root --mount
umount /mnt/my-dir
cat /mnt/my-dir/my-file

giving them access to what's in my-dir.

Treating such mount trees as a unit in less privileged mount namespaces
(cf. [1]) prevents that, i.e., prevents revealing files and directories
that were overmounted.

Treating such mounts as a unit is also relevant when e.g. bind-mounting
a mount tree containing locked mounts. Sticking with the example above:

unshare -U --map-root --mount

# non-recursive bind-mount will fail
mount --bind /mnt /tmp

# recursive bind-mount will succeed
mount --rbind /mnt /tmp

The reason is again that the mount tree at /mnt is treated as a mount
unit because it is locked. If one were to allow to non-recursively
bind-mountng /mnt somewhere it would mean revealing what's underneath
the mount at my-dir (This is in some sense the inverse of preventing a
filesystem from being mounted that isn't fully visible, i.e. contains
hidden or over-mounted mounts.).

These semantics, in addition to being security relevant, also allow a
more privileged mount namespace to create a restricted view of the
filesystem hierarchy that can't be circumvented in a less privileged
mount namespace (Otherwise pivot_root would have to be used which can
also be used to guarantee a restriced view on the filesystem hierarchy
especially when combined with a separate rootfs.).

Christian

[1]: I'll avoid jumping through the hoops of speaking about ownership
     all the time now for the sake of brevity. Otherwise I'll still sit
     here at lunchtime.
