Return-Path: <linux-fsdevel+bounces-53978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255C8AF9AD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF555A2DF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665D25DD06;
	Fri,  4 Jul 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mMxAqAoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA521D5AE
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751654238; cv=none; b=VNDrlJoNSYg6kvsM4nqez6enc8oqiLym+Rmg5aYcipa+n6Fj6vWMCq1nsl00OEy2bGLMsXLJFoLBPoKRCu9lOnJ8038Dh2fsXLxoVl0z6koUe0GIuy/y+6T8hLk7CAP7V4au2MRuGrWSxcjeZNTcM6RbHscc3LOfrMaGLVbRsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751654238; c=relaxed/simple;
	bh=5HtNG0MSeW1BujCOgklQGjz5Xi+ba1D+X41TBjJvCAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta48OfECUJGi7y5+iZiF/DC0xCiOrq7mPGZBptovm0ss7yQ0mvTTBSmuxzUtWsxfALqDb1kE9RP+rCwLXt8Bds7VXpTKxjhsE77PkvvfB0Pu9QsZuM5I3dM7Sf/9NyvW1mvOIYZf1QnDQgwCzXhbnFaZWG1DG3MlZfUXag1bxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mMxAqAoV; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bYj6H3rrqztKJ;
	Fri,  4 Jul 2025 20:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1751654231;
	bh=T7orxL5CYqwGPp8kSYq7Zk6BqxK+a3hm4Qvvl9BrI8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMxAqAoV9eiYVyGwIh1CdPZ+8pauk047d3KcViFe7irmxofZI/EzB3C+PK9FaY7Oe
	 jX4qUrZO4CHS+wvCnLalhk1Hfc7qqlMWga5ZVDT/xUf8lAX2D/tJVGvJfIByCBhoSL
	 Q3QX0uroWlrIYQyLeWv2tKNdxxZLJAQplFv/pRxw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bYj6F6Y1wzkvT;
	Fri,  4 Jul 2025 20:37:09 +0200 (CEST)
Date: Fri, 4 Jul 2025 20:37:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>, v9fs@lists.linux.dev, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/6] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <20250704.eek1caeveC0c@digikod.net>
References: <cover.1743971855.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1743971855.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

Hi,

I tested this patch series and I confirm that it fixes the issue for
Landlock.  Tingmao explained that it also fixes other subsystems such as
fanotify, and 9p itself.  I sent a patch to test this fix with Landlock
and I'll merge it once 9p is fixed:
https://lore.kernel.org/all/20250704171345.1393451-1-mic@digikod.net/

Could you please give it a try in linux-next and consider it for the
next merge window?

Regards,
 Mickaël

On Sun, Apr 06, 2025 at 09:43:01PM +0100, Tingmao Wang wrote:
> Hi 9p-fs maintainers,
> 
> (CC'ing Landlock and Fanotify/inotify people as this affects both use
> cases, although most of my investigation has been on Landlock)
> 
> Previously [1], I noticed that when using 9pfs filesystems, the Landlock
> LSM is blocking access even for files / directories allowed by rules, and
> that this has something to do with 9pfs creating new inodes despite
> Landlock holding a reference to the existing one.  Because Landlock uses
> inodes' in-memory state (i_security) to identify allowed fs
> objects/hierarchies, this causes Landlock to partially break on 9pfs, at
> least in uncached mode, which is the default:
> 
>     # mount -t 9p -o trans=virtio test /mnt
>     # env LL_FS_RO=/etc:/usr:/bin:/lib:/mnt/readme LL_FS_RW= /sandboxer bash
>     Executing the sandboxed command...
>     bash: cannot set terminal process group (164): Inappropriate ioctl for device
>     bash: no job control in this shell
>     # cat /mnt/readme
>     cat: /mnt/readme: Permission denied
> 
> This, however, works if somebody is holding onto the dentry (and it also
> works with cache=loose), as in both cases the inode is reused:
> 
>     # tail -f /mnt/readme &
>     [1] 196
>     # env LL_FS_RO=/etc:/usr:/bin:/lib:/mnt/readme LL_FS_RW= /sandboxer bash
>     Executing the sandboxed command...
>     bash: cannot set terminal process group (164): Inappropriate ioctl for device
>     bash: no job control in this shell
>     # cat /mnt/readme
>     aa
> 
> It also works on directories if one have a shell that cd into the
> directory.  Note that this means only certain usage of Landlock are
> affected - for example, sandboxing applications that takes a list of files
> to allow, landlocks itself, then evecve.  On the other hand, this does not
> affect applications that opens a file, then Landlocks itself while keeping
> the file it needs open.
> 
> While the above is a very simple example, this is problematic in
> real-world use cases if Landlock is used to sandox applications on system
> that has files mounted via 9pfs, or use 9pfs as the root filesystem.  In
> addition, this also affects fanotify / inotify when using inode mark (for
> local access):
> 
>     root@d8c28a676d72:/# ./fanotify-basic-open /readme & # on virtiofs
>     [1] 173
>     root@d8c28a676d72:/# cat readme
>     aa
>     FAN_OPEN: File /readme
>     root@d8c28a676d72:/# mount -t 9p -o trans=virtio test /mnt
>     root@d8c28a676d72:/# ./fanotify-basic-open /mnt/readme & # on 9pfs
>     [2] 176
>     root@d8c28a676d72:/# cat /mnt/readme
>     aa
>     root@d8c28a676d72:/#
> 
> Same can be demonstrated with inotifywait.  The source code for
> fanotify-basic-open, adopted from the fanotify man page, is available at
> the end of this email.
> 
> Note that this is not a security bug for Landlock since it can only cause
> legitimate access to be denied, but might be a problem for fanotify perm
> (although I do recognize that using perm on individual inodes is already
> perhaps a bit unreliable?)
> 
> It seems that there was an attempt at making 9pfs reuse inodes, based on
> qid.path, however it was reverted [2] due to issues with servers that
> present duplicate qids, for example on a QEMU host that has multiple
> filesystems mounted under a single 9pfs export without multidevs=remap, or
> in the case of other servers that doesn't necessarily support remapping
> qids ([3] and more).  I've done some testing on v6.12-rc4 which has the
> simplified 9pfs inode code before it was reverted, and found that Landlock
> works (however, we of course then have the issue demonstrated in [2]).
> 
> Unrelated to the above problem, it also seems like even with the revert in
> [2], because in cached mode inode are still reused based on qid (and type,
> version (aka mtime), etc), the setup mentioned in [2] still causes
> problems in th latest kernel with cache=loose:
> 
>     host # cd /tmp/linux-test
>     host # mkdir m1 m2
>     host # mount -t tmpfs tmpfs m1
>     host # mount -t tmpfs tmpfs m2
>     host # mkdir m1/dir m2/dir  # needs to be done together so that they have the same mtime
>     host # echo foo > m1/dir/foo
>     host # echo bar > m2/dir/bar
> 
>     guest # mount -t 9p -o trans=virtio,cache=loose test /mnt
>     guest # cd /mnt/m1/dir
>     qemu-system-x86_64: warning: 9p: Multiple devices detected in same VirtFS export, which might lead to file ID collisions and severe misbehaviours on guest! You should either use a separate export for each device shared from host or use virtfs option 'multidevs=remap'!
>     guest # ls
>     foo
>     guest # ls /mnt/m2/dir
>     foo # <- should be bar
>     guest # uname -a
>     Linux d8c28a676d72 6.14.0-dev #92 SMP PREEMPT_DYNAMIC Sun Apr  6 18:47:54 BST 2025 x86_64 GNU/Linux
> 
> With the above in mind, I have a proposal for 9pfs to:
> 1. Reuse inodes even in uncached mode
> 2. However, reuse them based on qid.path AND the actual pathname, by doing
>    the appropriate testing in v9fs_test(_new)?_inode(_dotl)?
> 
> The main problem here is how to store the pathname in a sensible way and
> tie it to the inode.  For now I opted with an array of names acquired with
> take_dentry_name_snapshot, which reuses the same memory as the dcache to
> store the actual strings, but doesn't tie the lifetime of the dentry with
> the inode (I thought about holding a reference to the dentry in the
> v9fs_inode, but it seemed like a wrong approach and would cause dentries
> to not be evicted/released).
> 
> Maybe ideally there could be a general way for filesystems to tell
> VFS/dcache to "pin" a dentry as long as the inode is alive, but still
> allows the dentry and inode to be evicted based on memory pressure?  In
> fact, if the dentry is alive, we might not even need to do this in 9pfs,
> as we will automatically get the same inode pointed to by the dentry.

Christian, any though?

> 
> Currently this pathname is immutable once attached to an inode, and
> therefore it is not protected by locks or RCU, but this might have to
> change for us to support renames that preserve the inode on next access.
> This is not in this patchset yet.  Also let me know if I've missed any
> locks etc (I'm new to VFS, or for that matter, the kernel).
> 
> Storing one pathname per inode also means we don't reuse the same inode
> for hardlinks -- maybe this can be fixed as well in a future version, if
> this approach sounds good?
> 
> From some QEMU documentation I read [4] it seems like there is a plan to
> resolve these kind of problems in a new version of the protocol, by
> expanding the qid to include the filesystem identifier of a file on the
> host, so maybe this can be disabled after a successful protocol version
> check with the host?  For now this is implemented as a default option,
> inodeident=path, which can be set to 'none' to instead get the previous
> behaviour.
> 
> This patchset is still a bit of a work in progress, and I've not tested
> the performance impact.  It currently uses strncmp to compare paths but
> this might be able to be optimized into a hash comparison first.  It
> should also normally only need to do it for one pair of filenames, as the
> test is only done if qid.path matches in the first place.
> 
> Also, currently the inode is not reused in cached mode if mtime changed
> AND the dentry was evicted -- I considered removing the qid.version test
> in v9fs_test_inode_dotl but I think perhaps care needs to be taken to
> ensure we can refresh an inode that potentially has data cached?  This is
> a TODO for this patchset.
> 
> Another TODO is to maybe add support for case-insensitive matching?
> 
> For this patch series I've tested modifying files on both host and guest,
> changing a file from regular file to dir then back while preserving ino,
> keeping a file open in the guest with a fd, and using Landlock (which
> results in an ihold but does not keep the dentry) then trying to access
> the file from both inside and outside the Landlocked shell.
> 
> Let me know what's your thought on this -- if this is a viable approach
> I'm happy to work on it more and do more testing.  The main motivation
> behind this is getting Landlock to work "out of the box" on 9pfs.
> 
> This patch series was based on, and tested on v6.14 + [5]
> 
> Kind regards,
> Tingmao
> 
> [1]: https://github.com/landlock-lsm/linux/issues/45
> [2]: https://lore.kernel.org/all/20241024-revert_iget-v1-4-4cac63d25f72@codewreck.org/
> [3]: https://lore.kernel.org/all/20240923100508.GA32066@willie-the-truck/
> [4]: https://wiki.qemu.org/Documentation/9p#Protocol_Plans
> [5]: https://lore.kernel.org/all/cover.1743956147.git.m@maowtm.org/
> 
> fanotify-basic-open.c:
> 
>     #define _GNU_SOURCE /* Needed to get O_LARGEFILE definition */
>     #include <errno.h>
>     #include <fcntl.h>
>     #include <limits.h>
>     #include <poll.h>
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <sys/fanotify.h>
>     #include <unistd.h>
> 
>     /* Read all available fanotify events from the file descriptor 'fd'. */
> 
>     static void handle_events(int fd)
>     {
>         const struct fanotify_event_metadata *metadata;
>         struct fanotify_event_metadata buf[200];
>         ssize_t size;
>         char path[PATH_MAX];
>         ssize_t path_len;
>         char procfd_path[PATH_MAX];
>         struct fanotify_response response;
> 
>         for (;;) {
>             size = read(fd, buf, sizeof(buf));
>             if (size == -1 && errno != EAGAIN) {
>                 perror("read");
>                 exit(EXIT_FAILURE);
>             }
> 
>             /* Check if end of available data reached. */
> 
>             if (size <= 0)
>                 break;
> 
>             /* Point to the first event in the buffer. */
> 
>             metadata = buf;
> 
>             /* Loop over all events in the buffer. */
> 
>             while (FAN_EVENT_OK(metadata, size)) {
>                 if (metadata->fd >= 0) {
>                     if (metadata->mask & FAN_OPEN) {
>                         printf("FAN_OPEN: ");
>                     }
> 
>                     /* Retrieve and print pathname of the accessed file. */
> 
>                     snprintf(procfd_path, sizeof(procfd_path),
>                         "/proc/self/fd/%d", metadata->fd);
>                     path_len = readlink(procfd_path, path,
>                                 sizeof(path) - 1);
>                     if (path_len == -1) {
>                         perror("readlink");
>                         exit(EXIT_FAILURE);
>                     }
> 
>                     path[path_len] = '\0';
>                     printf("File %s\n", path);
> 
>                     /* Close the file descriptor of the event. */
> 
>                     close(metadata->fd);
>                 }
> 
>                 /* Advance to next event. */
> 
>                 metadata = FAN_EVENT_NEXT(metadata, size);
>             }
>         }
>     }
> 
>     int main(int argc, char *argv[])
>     {
>         char buf;
>         int fd, poll_num;
>         nfds_t nfds;
>         struct pollfd fds[2];
> 
>         /* Check mount point is supplied. */
> 
>         if (argc != 2) {
>             fprintf(stderr, "Usage: %s FILE\n", argv[0]);
>             exit(EXIT_FAILURE);
>         }
> 
>         fd = fanotify_init(0, O_RDONLY | O_LARGEFILE);
>         if (fd == -1) {
>             perror("fanotify_init");
>             exit(EXIT_FAILURE);
>         }
> 
>         if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_INODE, FAN_OPEN, AT_FDCWD,
>                 argv[1]) == -1) {
>             perror("fanotify_mark");
>             exit(EXIT_FAILURE);
>         }
> 
>         while (1) {
>             handle_events(fd);
>         }
>     }
> 
> Tingmao Wang (6):
>   fs/9p: Add ability to identify inode by path for .L
>   fs/9p: add default option for path-based inodes
>   fs/9p: Hide inodeident=path from show_options as it is the default
>   fs/9p: Add ability to identify inode by path for non-.L
>   fs/9p: .L: Refresh stale inodes on reuse
>   fs/9p: non-.L: Refresh stale inodes on reuse
> 
>  fs/9p/Makefile         |   3 +-
>  fs/9p/ino_path.c       | 114 ++++++++++++++++++++++++++++++++++++++
>  fs/9p/v9fs.c           |  33 ++++++++++-
>  fs/9p/v9fs.h           |  63 +++++++++++++++------
>  fs/9p/vfs_inode.c      | 122 +++++++++++++++++++++++++++++++++++------
>  fs/9p/vfs_inode_dotl.c | 108 +++++++++++++++++++++++++++++++++---
>  fs/9p/vfs_super.c      |  10 +++-
>  7 files changed, 406 insertions(+), 47 deletions(-)
>  create mode 100644 fs/9p/ino_path.c
> 
> 
> base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
> prerequisite-patch-id: 12dc6676db52ff32eed082b1e5d273f297737f61
> prerequisite-patch-id: 93ab54c52a41fa44b8d0baf55df949d0ad27e99a
> prerequisite-patch-id: 5f558bf969e6eaa3d011c98de0806ca8ad369efe
> --
> 2.39.5
> 

