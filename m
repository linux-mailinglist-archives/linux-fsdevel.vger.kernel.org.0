Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE13E5E07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhHJOdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 10:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhHJOdX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:33:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE6C660560;
        Tue, 10 Aug 2021 14:32:57 +0000 (UTC)
Date:   Tue, 10 Aug 2021 16:32:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Questions re the new mount_setattr(2) manual page
Message-ID: <20210810143255.2tjdskubryir2prp@wittgenstein>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:38:00AM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Christian,
> 
> Thanks for the very nice manual page that you wrote. I have

Thank you!

> made a large number of (mostly trivial) edits. If you could
> read the page closely, to check that I introduced no errors,
> I would appreciate it.

Happy to!

> 
> I have various questions below, marked ???. Could you please take
> a look at these, and I will then make further edits based on your
> answers.

I've answered all questions, I think. Feel free to just reformulate
where my suggestions weren't adequate. Since most things you ask about
are minor adaptions there's no need from my end for you to resend with
those reformulations. You can just make them directly. :) I'll peruse
the man-pages git repo anyway after you apply them and will send changes
if I spot issues.

Thank you for the review!
Christian

> 
> The current version of the page is already pushed to the man-pages
> Git repo.
> 
> >   MOUNT_SETATTR(2)      Linux Programmer's Manual     MOUNT_SETATTR(2)
> >
> >   NAME
> >       mount_setattr - change mount properties of a mount or mount
> 
> ???
> s/mount properties/properties ?
> 
> (Just bcause more concise.)

Sounds good.

> 
> >       tree
> >
> >   SYNOPSIS
> >       #include <linux/fcntl.h> /* Definition of AT_* constants */
> >       #include <linux/mount.h> /* Definition of MOUNT_ATTR_* constants */
> >       #include <sys/syscall.h> /* Definition of SYS_* constants */
> >       #include <unistd.h>
> >
> >       int syscall(SYS_mount_setattr, int dirfd, const char *path,
> >               unsigned int flags, struct mount_attr *attr, size_t size);
> >
> >       Note: glibc provides no wrapper for mount_setattr(),
> >       necessitating the use of syscall(2).
> >
> >   DESCRIPTION
> >       The mount_setattr() system call changes the mount properties
> >       of a mount or an entire mount tree.  If path is a relative
> >       pathname, then it is interpreted relative to the directory
> >       referred to by the file descriptor dirfd.  If dirfd is the
> >       special value AT_FDCWD, then path is interpreted relative to
> >       the current working directory of the calling process.  If
> >       path is the empty string and AT_EMPTY_PATH is specified in
> >       flags, then the mount properties of the mount identified by
> >       dirfd are changed.
> >
> >       The mount_setattr() system call uses an extensible structure
> >       (struct mount_attr) to allow for future extensions.  Any non-
> >       flag extensions to mount_setattr() will be implemented as new
> >       fields appended to the this structure, with a zero value in a
> >       new field resulting in the kernel behaving as though that
> >       extension field was not present.  Therefore, the caller must
> >       zero-fill this structure on initialization.  See the
> >       "Extensibility" subsection under NOTES for more details.
> >
> >       The size argument should usually be specified as
> >       sizeof(struct mount_attr).  However, if the caller does not
> >       intend to make use of features that got introduced after the
> >       initial version of struct mount_attr, it is possible to pass
> >       the size of the initial struct together with the larger
> >       struct.  This allows the kernel to not copy later parts of
> >       the struct that aren't used anyway.  With each extension that
> >       changes the size of struct mount_attr, the kernel will expose
> >       a definition of the form MOUNT_ATTR_SIZE_VERnumber.  For
> >       example, the macro for the size of the initial version of
> >       struct mount_attr is MOUNT_ATTR_SIZE_VER0.
> 
> ???
> I think I understand the above paragraph, but I wonder if it could
> be improved a little. The general principle is that one can always
> pass the size of an earlier, smaller structure to the kernel, right?

Yes.

> My point is that it need not be the size of the initial structure,
> right? So, I wonder whether a little rewording might be need above.

Yes, the initial structure size is just an example because that will be
very common.

> What do you think?

Sure, I'm proposing something here but please, fell free to reformulate
or come up with something completely new:

	[...]
	However, if the caller is using a kernel that supports an
	extended struct mount_attr but the caller does not intend to
	make use of these features they can pass the size of an earlier
	version of the struct together with the extended structure.
	[...]

> 
> >
> >       The flags argument can be used to alter the path resolution
> >       behavior.  The supported values are:
> >
> >       AT_EMPTY_PATH
> >              If path is the empty string, change the mount
> >              properties on dirfd itself.
> >
> >       AT_RECURSIVE
> >              Change the mount properties of the entire mount tree.
> >
> >       AT_SYMLINK_NOFOLLOW
> >              Don't follow trailing symbolic links.
> >
> >       AT_NO_AUTOMOUNT
> >              Don't trigger automounts.
> >
> >       The attr argument of mount_setattr() is a structure of the
> >       following form:
> >
> >           struct mount_attr {
> >               __u64 attr_set;     /* Mount properties to set */
> >               __u64 attr_clr;     /* Mount properties to clear */
> >               __u64 propagation;  /* Mount propagation type */
> >               __u64 userns_fd;    /* User namespace file descriptor */
> >           };
> >
> >       The attr_set and attr_clr members are used to specify the
> >       mount properties that are supposed to be set or cleared for a
> >       mount or mount tree.  Flags set in attr_set enable a property
> >       on a mount or mount tree, and flags set in attr_clr remove a
> >       property from a mount or mount tree.
> >
> >       When changing mount properties, the kernel will first clear
> >       the flags specified in the attr_clr field, and then set the
> >       flags specified in the attr_set field:
> 
> ???
> I find the following example a bit confusing. See below.
> 
> >
> >           struct mount_attr attr = {
> >               .attr_clr = MOUNT_ATTR_NOEXEC | MOUNT_ATTR_NODEV,
> >               .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
> >           };
> 
> ???
> I *think* that what you are trying to show is that the above initializer
> resuts in the equivalent of the following code. Is that correct? If so, 
> I think the text needs some work to make this clearer. Let me know.

Yes, exactly. Feel free to remove that code and just explain it in text
if that's better.

> 
> >           unsigned int current_mnt_flags = mnt->mnt_flags;
> >
> >           /*
> >            * Clear all flags set in .attr_clr,
> >            * clearing MOUNT_ATTR_NOEXEC and MOUNT_ATTR_NODEV.
> >            */
> >           current_mnt_flags &= ~attr->attr_clr;
> >
> >           /*
> >            * Now set all flags set in .attr_set,
> >            * applying MOUNT_ATTR_RDONLY and MOUNT_ATTR_NOSUID.
> >            */
> >           current_mnt_flags |= attr->attr_set;
> >
> >           mnt->mnt_flags = current_mnt_flags;
> >
> >       As a rsult of this change, the mount or mount tree (a) is

Typo: s/rsult/result/g

> >       read-only; (b) blocks the execution of set-user-ID and set-
> >       group-ID programs; (c) allows execution of programs; and (d)
> >       allows access to devices.
> >
> >       Multiple changes with the same set of flags requested in
> >       attr_clr and attr_set are guaranteed to be idempotent after
> >       the changes have been applied.
> >
> >       The following mount attributes can be specified in the
> >       attr_set or attr_clr fields:
> >
> >       MOUNT_ATTR_RDONLY
> >              If set in attr_set, makes the mount read-only.  If set
> >              in attr_clr, removes the read-only setting if set on
> >              the mount.
> >
> >       MOUNT_ATTR_NOSUID
> >              If set in attr_set, causes the mount not to honor the
> >              set-user-ID and set-group-ID mode bits and file
> >              capabilities when executing programs.  If set in
> >              attr_clr, clears the set-user-ID, set-group-ID, and
> >              file capability restriction if set on this mount.
> >
> >       MOUNT_ATTR_NODEV
> >              If set in attr_set, prevents access to devices on this
> >              mount.  If set in attr_clr, removes the restriction
> >              that prevented accessing devices on this mount.
> >
> >       MOUNT_ATTR_NOEXEC
> >              If set in attr_set, prevents executing programs on
> >              this mount.  If set in attr_clr, removes the
> >              restriction that prevented executing programs on this
> >              mount.
> >
> >       MOUNT_ATTR_NOSYMFOLLOW
> >              If set in attr_set, prevents following symbolic links
> >              on this mount.  If set in attr_clr, removes the
> >              restriction that prevented following symbolic links on
> >              this mount.
> >
> >       MOUNT_ATTR_NODIRATIME
> >              If set in attr_set, prevents updating access time for
> >              directories on this mount.  If set in attr_clr,
> >              removes the restriction that prevented updating access
> >              time for directories.  Note that MOUNT_ATTR_NODIRATIME
> >              can be combined with other access-time settings and is
> >              implied by the noatime setting.  All other access-time
> >              settings are mutually exclusive.
> >
> >       MOUNT_ATTR__ATIME - changing access-time settings
> >              In the new mount API, the access-time values are an
> >              enum starting from 0.  Even though they are an enum
> >              (in contrast to the other mount flags such as
> >              MOUNT_ATTR_NOEXEC), they are nonetheless passed in
> >              attr_set and attr_clr for consistency with fsmount(2),
> >              which introduced this behavior.
> >
> >              Note that, since access times are an enum not a bit
> >              map, users wanting to transition to a different
> >              access-time setting cannot simply specify the access-
> >              time setting in attr_set but must also set
> >              MOUNT_ATTR__ATIME in the attr_clr field.  The kernel
> >              will verify that MOUNT_ATTR__ATIME isn't partially set
> >              in attr_clr, and that attr_set doesn't have any
> >              access-time bits set if MOUNT_ATTR__ATIME isn't set in
> >              attr_clr.
> >
> >              MOUNT_ATTR_RELATIME
> >                     When a file is accessed via this mount, update
> >                     the file's last access time (atime) only if the
> >                     current value of atime is less than or equal to
> >                     the file's last modification time (mtime) or
> >                     last status change time (ctime).
> >
> >                     To enable this access-time setting on a mount
> >                     or mount tree, MOUNT_ATTR_RELATIME must be set
> >                     in attr_set and MOUNT_ATTR__ATIME must be set
> >                     in the attr_clr field.
> >
> >              MOUNT_ATTR_NOATIME
> >                     Do not update access times for (all types of)
> >                     files on this mount.
> >
> >                     To enable this access-time setting on a mount
> >                     or mount tree, MOUNT_ATTR_NOATIME must be set
> >                     in attr_set and MOUNT_ATTR__ATIME must be set
> >                     in the attr_clr field.
> >
> >              MOUNT_ATTR_STRICTATIME
> >                     Always update the last access time (atime) when
> >                     files are accessed on this mount.
> >
> >                     To enable this access-time setting on a mount
> >                     or mount tree, MOUNT_ATTR_STRICTATIME must be
> >                     set in attr_set and MOUNT_ATTR__ATIME must be
> >                     set in the attr_clr field.
> >
> >       MOUNT_ATTR_IDMAP
> >              If set in attr_set, creates an ID-mapped mount.  The
> >              ID mapping is taken from the user namespace specified
> 
> In various places, you wrote "idmapping". "idmapped", etc. I've
> changed these to the more natural English "ID mapping" etc.

Sure.

> 
> >              in userns_fd and attached to the mount.
> >
> >              Since it is not supported to change the ID mapping of
> >              a mount after it has been ID mapped, it is invalid to
> >              specify MOUNT_ATTR_IDMAP in attr_clr.
> >
> >              For further details, see the subsection "ID-mapped
> >              mounts" under NOTES.
> >
> >       The propagation field is used to specify the propagation type
> >       of the mount or mount tree.  Mount propagation options are
> >       mutually exclusive; that is, the propagation values behave
> >       like an enum.  The supported mount propagation types are:
> >
> >       MS_PRIVATE
> >              Turn all mounts into private mounts.  Mount and
> >              unmount events do not propagate into or out of this
> >              mount point.
> >
> >       MS_SHARED
> >              Turn all mounts into shared mounts.  Mount points
> >              share events with members of a peer group.  Mount and
> >              unmount events immediately under this mount point will
> >              propagate to the other mount points that are members
> >              of the peer group.  Propagation here means that the
> >              same mount or unmount will automatically occur under
> >              all of the other mount points in the peer group.
> >              Conversely, mount and unmount events that take place
> >              under peer mount points will propagate to this mount
> >              point.
> >
> >       MS_SLAVE
> >              Turn all mounts into dependent mounts.  Mount and
> >              unmount events propagate into this mount point from a
> >              shared peer group.  Mount and unmount events under
> >              this mount point do not propagate to any peer.
> >
> >       MS_UNBINDABLE
> >              This is like a private mount, and in addition this
> >              mount can't be bind mounted.  Attempts to bind mount
> >              this mount will fail.  When a recursive bind mount is
> >              performed on a directory subtree, any bind mounts
> >              within the subtree are automatically pruned (i.e., not
> >              replicated) when replicating that subtree to produce
> >              the target subtree.
> >
> >       For further details on propagation types, see
> >       mount_namespaces(7).
> >
> >   RETURN VALUE
> >       On success, mount_setattr() returns zero.  On error, -1 is
> >       returned and errno is set to indicate the cause of the error.
> >
> >   ERRORS
> >       EBADF  dirfd is not a valid file descriptor.
> >
> >       EBADF  userns_fd is not a valid file descriptor.
> >
> >       EBUSY  The caller tried to change the mount to
> >              MOUNT_ATTR_RDONLY, but the mount still holds files
> >              open for writing.
> >
> >       EINVAL The path specified via the dirfd and path arguments to
> >              mount_setattr() isn't a mount point.
> >
> >       EINVAL An unsupported value was set in flags.
> >
> >       EINVAL An unsupported value was specified in the attr_set
> >              field of mount_attr.
> >
> >       EINVAL An unsupported value was specified in the attr_clr
> >              field of mount_attr.
> >
> >       EINVAL An unsupported value was specified in the propagation
> >              field of mount_attr.
> >
> >       EINVAL More than one of MS_SHARED, MS_SLAVE, MS_PRIVATE, or
> >              MS_UNBINDABLE was set in the the propagation field of
> >              mount_attr.
> >
> >       EINVAL An access-time setting was specified in the attr_set
> >              field without MOUNT_ATTR__ATIME being set in the
> >              attr_clr field.
> >
> >       EINVAL MOUNT_ATTR_IDMAP was specified in attr_clr.
> >
> >       EINVAL A file descriptor value was specified in userns_fd
> >              which exceeds INT_MAX.
> >
> >       EINVAL A valid file descriptor value was specified in
> >              userns_fd, but the file descriptor wasn't a namespace
> >              file descriptor or did not refer to a user namespace.
> 
> ???
> Could the above not be simplified to
> 
>       EINVAL A valid file descriptor value was specified in
>              userns_fd, but the file descriptor did not refer
>              to a user namespace.

Sounds good.

> ?
> 
> >
> >       EINVAL The underlying filesystem does not support ID-mapped
> >              mounts.
> >
> >       EINVAL The mount that is to be ID mapped is not a
> >              detached/anonymous mount; that is, the mount is
> 
> ???
> What is a the distinction between "detached" and "anonymous"?
> Or do you mean them to be synonymous? If so, then let's use
> just one term, and I think "detached" is preferable.

Yes, they are synonymous here. I list both because detached can
potentially be confusing. A detached mount is a mount that has not been
visible in the filesystem. But if you attached it an then unmount it
right after and keep the fd for the mountpoint open it's a detached
mount purely on a natural language level, I'd argue. But it's not a
detached mount from the kernel's view anymore because it has been
exposed in the filesystem and is thus not detached anymore.
But I do prefer "detached" to "anonymous" and that confusion is very
unlikely to occur.

> 
> >              already visible in the filesystem.
> >
> >       EINVAL A partial access-time setting was specified in
> >              attr_clr instead of MOUNT_ATTR__ATIME being set.
> >
> >       EINVAL The mount is located outside the caller's mount
> >              namespace.
> >
> >       EINVAL The underlying filesystem is mounted in a user
> >              namespace.
> >
> >       ENOENT A pathname was empty or had a nonexistent component.
> >
> >       ENOMEM When changing mount propagation to MS_SHARED, a new
> >              peer group ID needs to be allocated for all mounts
> >              without a peer group ID set.  Allocation of this peer
> >              group ID has failed.
> >
> >       ENOSPC When changing mount propagation to MS_SHARED, a new
> >              peer group ID needs to be allocated for all mounts
> >              without a peer group ID set.  Allocation of this peer
> >              group ID can fail.  Note that technically further
> >              error codes are possible that are specific to the ID
> >              allocation implementation used.
> >
> >       EPERM  One of the mounts had at least one of
> >              MOUNT_ATTR_NOATIME, MOUNT_ATTR_NODEV,
> >              MOUNT_ATTR_NODIRATIME, MOUNT_ATTR_NOEXEC,
> >              MOUNT_ATTR_NOSUID, or MOUNT_ATTR_RDONLY set and the
> >              flag is locked.  Mount attributes become locked on a
> >              mount if:
> >
> >              •  A new mount or mount tree is created causing mount
> >                 propagation across user namespaces.  The kernel
> >                 will lock the aforementioned flags to protect these
> >                 sensitive properties from being altered.
> >
> >              •  A new mount and user namespace pair is created.
> >                 This happens for example when specifying
> >                 CLONE_NEWUSER | CLONE_NEWNS in unshare(2),
> >                 clone(2), or clone3(2).  The aforementioned flags
> >                 become locked to protect user namespaces from
> >                 altering sensitive mount properties.
> >
> >       EPERM  A valid file descriptor value was specified in
> >              userns_fd, but the file descriptor refers to the
> >              initial user namespace.
> >
> >       EPERM  An already ID-mapped mount was supposed to be ID
> >              mapped.
> 
> ???
> Better:
>     An attempt was made to add an ID mapping to a mount that is already
>     ID mapped.

Sounds good.

> ?
> 
> >
> >       EPERM  The caller does not have CAP_SYS_ADMIN in the initial
> >              user namespace.
> >
> >   VERSIONS
> >       mount_setattr() first appeared in Linux 5.12.
> >
> >   CONFORMING TO
> >       mount_setattr() is Linux-specific.
> >
> >   NOTES
> >   ID-mapped mounts
> >       Creating an ID-mapped mount makes it possible to change the
> >       ownership of all files located under a mount.  Thus, ID-
> >       mapped mounts make it possible to change ownership in a
> >       temporary and localized way.  It is a localized change
> >       because ownership changes are restricted to a specific mount.
> 
> ???
> Would it be clearer to say something like:
> 
>     It is a localized change because ownership changes are
>     visible only via a specific mount.
> ?

Sounds good.

> 
> 
> >       All other users and locations where the filesystem is exposed
> >       are unaffected.  And it is a temporary change because
> >       ownership changes are tied to the lifetime of the mount.
> >
> >       Whenever callers interact with the filesystem through an ID-
> >       mapped mount, the ID mapping of the mount will be applied to
> >       user and group IDs associated with filesystem objects.  This
> >       encompasses the user and group IDs associated with inodes and
> >       also the following xattr(7) keys:
> >
> >       •  security.capability, whenever filesystem capabilities are
> >          stored or returned in the VFS_CAP_REVISION_3 format, which
> >          stores a root user ID alongside the capabilities (see
> >          capabilities(7)).
> >
> >       •  system.posix_acl_access and system.posix_acl_default,
> >          whenever user IDs or group IDs are stored in ACL_USER or
> >          ACL_GROUP entries.
> >
> >       The following conditions must be met in order to create an
> >       ID-mapped mount:
> >
> >       •  The caller must have the CAP_SYS_ADMIN capability in the
> >          initial user namespace.
> >
> >       •  The filesystem must be mounted in the initial user
> >          namespace.
> 
> ???
> Should this rather be written as:
>  
>      The filesystem must be mounted in a mount namespace 
>      that is owned by the initial user namespace.

Sounds good.

> 
> >       •  The underlying filesystem must support ID-mapped mounts.
> >          Currently, the xfs(5), ext4(5), and FAT filesystems
> >          support ID-mapped mounts with more filesystems being
> >          actively worked on.
> >
> >       •  The mount must not already be ID-mapped.  This also
> >          implies that the ID mapping of a mount cannot be altered.
> >
> >       •  The mount must be a detached/anonymous mount; that is, it
> 
> ???
> See the above questionon "detached" vs "anonymous"

Yes, please use "detached" only.

> 
> >          must have been created by calling open_tree(2) with the
> >          OPEN_TREE_CLONE flag and it must not already have been
> >          visible in the filesystem.
> >
> >       ID mappings can be created for user IDs, group IDs, and
> >       project IDs.  An ID mapping is essentially a mapping of a
> >       range of user or group IDs into another or the same range of
> >       user or group IDs.  ID mappings are usually written as three
> >       numbers either separated by white space or a full stop.  The
> >       first two numbers specify the starting user or group ID in
> >       each of the two user namespaces.  The third number specifies
> >       the range of the ID mapping.  For example, a mapping for user
> >       IDs such as 1000:1001:1 would indicate that user ID 1000 in
> >       the caller's user namespace is mapped to user ID 1001 in its
> >       ancestor user namespace.  Since the map range is 1, only user
> >       ID 1000 is mapped.
> 
> ???
> The details above seem wrong. When writing to map files, the
> fields must be white-space separated, AFAIK. But above you mention
> "full stops" and also show an example using colons (:). Those
> both seem wrong and confusing. Am I missing something?

This is more about notational conventions that exist and not about how
they are actually written. That's something I'm not touching on here as
it doesn't belong on this manpage. But feel free to only mention spaces.

> 
> >       It is possible to specify up to 340 ID mappings for each ID
> >       mapping type.  If any user IDs or group IDs are not mapped,
> >       all files owned by that unmapped user or group ID will appear
> >       as being owned by the overflow user ID or overflow group ID
> >       respectively.
> >
> >       Further details and instructions for setting up ID mappings
> >       can be found in the user_namespaces(7) man page.
> >
> >       In the common case, the user namespace passed in userns_fd
> >       together with MOUNT_ATTR_IDMAP in attr_set to create an ID-
> >       mapped mount will be the user namespace of a container.  In
> >       other scenarios it will be a dedicated user namespace
> >       associated with a user's login session as is the case for
> >       portable home directories in systemd-homed.service(8)).  It
> >       is also perfectly fine to create a dedicated user namespace
> >       for the sake of ID mapping a mount.
> >
> >       ID-mapped mounts can be useful in the following and a variety
> >       of other scenarios:
> >
> >       •  Sharing files between multiple users or multiple machines,
> 
> ???
> s/Sharing files/Sharing filesystems/ ?

[1]: But work. But feel free to use "sharing filesystems".

> 
> >          especially in complex scenarios.  For example, ID-mapped
> >          mounts are used to implement portable home directories in
> >          systemd-homed.service(8), where they allow users to move
> >          their home directory to an external storage device and use
> >          it on multiple computers where they are assigned different
> >          user IDs and group IDs.  This effectively makes it
> >          possible to assign random user IDs and group IDs at login
> >          time.
> >
> >       •  Sharing files from the host with unprivileged containers.
> 
> ???
> s/Sharing files/Sharing filesystems/ ?

See [1].

> 
> >          This allows a user to avoid having to change ownership
> >          permanently through chown(2).
> >
> >       •  ID mapping a container's root filesystem.  Users don't
> >          need to change ownership permanently through chown(2).
> >          Especially for large root filesystems, using chown(2) can
> >          be prohibitively expensive.
> >
> >       •  Sharing files between containers with non-overlapping ID
> 
> ???
> s/Sharing files/Sharing filesystems/ ?

See [1].

> 
> >          mappings.
> >
> >       •  Implementing discretionary access (DAC) permission
> >          checking for filesystems lacking a concept of ownership.
> >
> >       •  Efficiently changing ownership on a per-mount basis.  In
> >          contrast to chown(2), changing ownership of large sets of
> >          files is instantaneous with ID-mapped mounts.  This is
> >          especially useful when ownership of an entire root
> >          filesystem of a virtual machine or container is to be
> >          changed as mentioned above.  With ID-mapped mounts, a
> >          single mount_setattr() system call will be sufficient to
> >          change the ownership of all files.
> >
> >       •  Taking the current ownership into account.  ID mappings
> >          specify precisely what a user or group ID is supposed to
> >          be mapped to.  This contrasts with the chown(2) system
> >          call which cannot by itself take the current ownership of
> >          the files it changes into account.  It simply changes the
> >          ownership to the specified user ID and group ID.
> >
> >       •  Locally and temporarily restricted ownership changes.  ID-
> >          mapped mounts make it possible to change ownership
> >          locally, restricting it to specific mounts, and
> 
> ???
> The referent of "it" in the preceding line is not clear.
> Should it be "the ownership changes"? Or something else?

It should refer to ownership changes. I'd appreciate it if you could
reformulate.

> 
> >          temporarily as the ownership changes only apply as long as
> >          the mount exists.  By contrast, changing ownership via the
> >          chown(2) system call changes the ownership globally and
> >          permanently.
> >
> >   Extensibility
> >       In order to allow for future extensibility, mount_setattr()
> >       requires the user-space application to specify the size of
> >       the mount_attr structure that it is passing.  By providing
> >       this information, it is possible for mount_setattr() to
> >       provide both forwards- and backwards-compatibility, with size
> >       acting as an implicit version number.  (Because new extension
> >       fields will always be appended, the structure size will
> >       always increase.)  This extensibility design is very similar
> >       to other system calls such as perf_setattr(2),
> >       perf_event_open(2), clone3(2) and openat2(2).
> >
> >       Let usize be the size of the structure as specified by the
> >       user-space application, and let ksize be the size of the
> >       structure which the kernel supports, then there are three
> >       cases to consider:
> >
> >       •  If ksize equals usize, then there is no version mismatch
> >          and attr can be used verbatim.
> >
> >       •  If ksize is larger than usize, then there are some
> >          extension fields that the kernel supports which the user-
> >          space application is unaware of.  Because a zero value in
> >          any added extension field signifies a no-op, the kernel
> >          treats all of the extension fields not provided by the
> >          user-space application as having zero values.  This
> >          provides backwards-compatibility.
> >
> >       •  If ksize is smaller than usize, then there are some
> >          extension fields which the user-space application is aware
> >          of but which the kernel does not support.  Because any
> >          extension field must have its zero values signify a no-op,
> >          the kernel can safely ignore the unsupported extension
> >          fields if they are all zero.  If any unsupported extension
> >          fields are non-zero, then -1 is returned and errno is set
> >          to E2BIG.  This provides forwards-compatibility.
> >
> >       Because the definition of struct mount_attr may change in the
> >       future (with new fields being added when system headers are
> >       updated), user-space applications should zero-fill struct
> >       mount_attr to ensure that recompiling the program with new
> >       headers will not result in spurious errors at runtime.  The
> >       simplest way is to use a designated initializer:
> >
> >           struct mount_attr attr = {
> >               .attr_set = MOUNT_ATTR_RDONLY,
> >               .attr_clr = MOUNT_ATTR_NODEV
> >           };
> >
> >       Alternatively, the structure can be zero-filled using
> >       memset(3) or similar functions:
> >
> >           struct mount_attr attr;
> >           memset(&attr, 0, sizeof(attr));
> >           attr.attr_set = MOUNT_ATTR_RDONLY;
> >           attr.attr_clr = MOUNT_ATTR_NODEV;
> >
> >       A user-space application that wishes to determine which
> >       extensions the running kernel supports can do so by
> >       conducting a binary search on size with a structure which has
> >       every byte nonzero (to find the largest value which doesn't
> >       produce an error of E2BIG).
> >
> >   EXAMPLES
> 
> ???
> Do you have a (preferably simple) example piece of code
> somewhere for setting up an ID mapped mount?


> 
> >       /*
> >        * This program allows the caller to create a new detached mount
> >        * and set various properties on it.
> >        */
> >       #define _GNU_SOURCE
> >       #include <errno.h>
> >       #include <fcntl.h>
> >       #include <getopt.h>
> >       #include <linux/mount.h>
> >       #include <linux/types.h>
> >       #include <stdbool.h>
> >       #include <stdio.h>
> >       #include <stdlib.h>
> >       #include <string.h>
> >       #include <sys/syscall.h>
> >       #include <unistd.h>
> >
> >       static inline int
> >       mount_setattr(int dirfd, const char *path, unsigned int flags,
> >                     struct mount_attr *attr, size_t size)
> >       {
> >           return syscall(SYS_mount_setattr, dirfd, path, flags,
> >                          attr, size);
> >       }
> >
> >       static inline int
> >       open_tree(int dirfd, const char *filename, unsigned int flags)
> >       {
> >           return syscall(SYS_open_tree, dirfd, filename, flags);
> >       }
> >
> >       static inline int
> >       move_mount(int from_dirfd, const char *from_pathname,
> >                  int to_dirfd, const char *to_pathname,
> >                  unsigned int flags)
> >       {
> >           return syscall(SYS_move_mount, from_dirfd, from_pathname,
> >                          to_dirfd, to_pathname, flags);
> >       }
> >
> >       static const struct option longopts[] = {
> >           {"map-mount",       required_argument,  NULL,  'a'},
> >           {"recursive",       no_argument,        NULL,  'b'},
> >           {"read-only",       no_argument,        NULL,  'c'},
> >           {"block-setid",     no_argument,        NULL,  'd'},
> >           {"block-devices",   no_argument,        NULL,  'e'},
> >           {"block-exec",      no_argument,        NULL,  'f'},
> >           {"no-access-time",  no_argument,        NULL,  'g'},
> >           { NULL,             0,                  NULL,   0 },
> >       };
> >
> >       #define exit_log(format, ...)  do           \
> >       {                                           \
> >           fprintf(stderr, format, ##__VA_ARGS__); \
> >           exit(EXIT_FAILURE);                     \
> >       } while (0)
> >
> >       int
> >       main(int argc, char *argv[])
> >       {
> >           struct mount_attr *attr = &(struct mount_attr){};
> >           int fd_userns = -EBADF;
> 
> ???
> Why this magic initializer here? Why not just "-1"?
> Using -EBADF makes it look this is value specifically is
> meaningful, although I don't think that's true.

[2]: I always use -EBADF to initialize fds in all my code. It makes it
pretty easy to grep for fd initialization etc. So it's pure visual
convenience. Freel free to just use -1.

> 
> >           bool recursive = false;
> >           int index = 0;
> >           int ret;
> >
> >           while ((ret = getopt_long_only(argc, argv, "",
> >                                          longopts, &index)) != -1) {
> >               switch (ret) {
> >               case 'a':
> >                   fd_userns = open(optarg, O_RDONLY | O_CLOEXEC);
> >                   if (fd_userns == -1)
> >                       exit_log("%m - Failed top open %s\n", optarg);
> >                   break;
> >               case 'b':
> >                   recursive = true;
> >                   break;
> >               case 'c':
> >                   attr->attr_set |= MOUNT_ATTR_RDONLY;
> >                   break;
> >               case 'd':
> >                   attr->attr_set |= MOUNT_ATTR_NOSUID;
> >                   break;
> >               case 'e':
> >                   attr->attr_set |= MOUNT_ATTR_NODEV;
> >                   break;
> >               case 'f':
> >                   attr->attr_set |= MOUNT_ATTR_NOEXEC;
> >                   break;
> >               case 'g':
> >                   attr->attr_set |= MOUNT_ATTR_NOATIME;
> >                   attr->attr_clr |= MOUNT_ATTR__ATIME;
> >                   break;
> >               default:
> >                   exit_log("Invalid argument specified");
> >               }
> >           }
> >
> >           if ((argc - optind) < 2)
> >               exit_log("Missing source or target mount point\n");
> >
> >           const char *source = argv[optind];
> >           const char *target = argv[optind + 1];
> >
> >           int fd_tree = open_tree(-EBADF, source,
> >                        OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC |
> >                        AT_EMPTY_PATH | (recursive ? AT_RECURSIVE : 0));
> 
> ???
> What is the significance of -EBADF here? As far as I can tell, it
> is not meaningful to open_tree()?

I always pass -EBADF for similar reasons to [2]. Feel free to just use -1.

> 
> 
> >           if (fd_tree == -1)
> >               exit_log("%m - Failed to open %s\n", source);
> >
> >           if (fd_userns >= 0) {
> >               attr->attr_set  |= MOUNT_ATTR_IDMAP;
> >               attr->userns_fd = fd_userns;
> >           }
> >
> >           ret = mount_setattr(fd_tree, "",
> >                       AT_EMPTY_PATH | (recursive ? AT_RECURSIVE : 0),
> >                       attr, sizeof(struct mount_attr));
> >           if (ret == -1)
> >               exit_log("%m - Failed to change mount attributes\n");
> >
> >           close(fd_userns);
> >
> >           ret = move_mount(fd_tree, "", -EBADF, target,
> >                            MOVE_MOUNT_F_EMPTY_PATH);
> 
> ???
> What is the significance of -EBADF here? As far as I can tell, it
> is not meaningful to move_mount()?

See [2].

> 
> >           if (ret == -1)
> >               exit_log("%m - Failed to attach mount to %s\n", target);
> >
> >           close(fd_tree);
> >
> >           exit(EXIT_SUCCESS);
> >       }
> >
> >   SEE ALSO
> >       newuidmap(1), newgidmap(1), clone(2), mount(2), unshare(2),
> >       proc(5), mount_namespaces(7), capabilities(7),
> >       user_namespaces(7), xattr(7)
> 
> Thanks,
> 
> Michael
