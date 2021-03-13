Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E5339BBB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhCMEit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:38:49 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33520 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhCMEit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:38:49 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw0K-005Nvz-UD; Sat, 13 Mar 2021 04:35:57 +0000
Date:   Sat, 13 Mar 2021 04:35:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC][PATCHSET v2] inode type bits fixes
Message-ID: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
References: <YDqRThxQOVQO9uOx@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDqRThxQOVQO9uOx@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[changes since the first variant: rebased on 5.12-rc2, new helper
for type mismatch (inode_wrong_type()), braino in vboxsf patch fixed]

Once an inode is live, we should never change the type bits of ->i_mode
(bits 12..15), ->i_op or ->i_rdev.  Most of the tree is fine in that
respect, but there are some places that get it wrong - e.g. d_revalidate
or getattr instances blindly assuming that server won't tell us that
regular file has become a directory, etc.

The series below is a result of code audit looking for such bugs.
There are two dubious places left after that - f2fs recover_inode()
might be unsafe in that respect and coda_iget() definitely is unsafe.
I don't know f2fs guts well enough to tell if we can end up with
trouble in there; coda_iget() is obviously wrong, but I'm not
sure if having it fail with ESTALE on type changes would be the
right fix.  The rest of the tree is OK after the series below.

The series lives in vfs.git #work.inode-type-fixes.  Branch is based
at 5.12-rc2 (to avoid the bisect hazard lurking at -rc1).  Individual
patches are in followups; please review.

I'm going to put the beginning of the branch into never-rebased
mode, and if somebody prefers to pull the stuff related to their
filesystem into their tree, I'd rather put that into an immutable
branch as well - there are some followups in the same general area,
and I'd like to avoid the headache with backmerges from individual
filesystems' git trees.

What's in the series:

[1/15] new helper: inode_wrong_type(); rather than open-coding the check
for type mismatch in a lot of places, provide an inlined helper and
convert the existing open-coded instances.

[2/15 and 3/15] ceph: Jeff's patches.  There are some other unpleasant
things in the same area, Jeff apparently has something for those as
well.

[4/15] afs: patch by dhowells.  Server is supposed to return just the
lower 12 bits of mode_t; unfortunately, it gets passed in 16bit field
and we shouldn't assume that the upper 4 bits will be zeroed.  If they
are not, we'll get type bits in ->i_mode screwed and it's not hard to
sanitize the server-reported value anyway.

[5/15] vboxsf: vboxsf_init_inode() is used both for initial setup of
inode and for metadata updates.  And it's too trusting, which can end
up with type of live inode being mangled.

Tell vboxsf_init_inode() if we are dealing with live inode and make it
report failure on type mismatches in that case.  There are two such call
sites - one in ->d_revalidate(), another in remount.  The latter can't
have a type mismatch, but the former needs to treat it as "stale inode,
need to redo lookup".

BTW, some of the things safe for initial setup (when nobody else might
see the struct inode instance) are not safe for live inodes - e.g.
we'd better not form ->i_mode in two steps, first setting permission bits
(with zeroes in type bits), then doing |= S_IF... to set the type bits.
Not a good idea if that thing can be observed in the intermediate state...

[6/15] orangefs: it tries to check for type mismatches; unfortunately,
it has a very odd idea of what the mismatch (and encoding of type)
looks like.  For the record, encoding (in upper 4 bits of mode_t) is
	0001	named pipe
	0010    character device
	0100    directory
	0110	block device
	1000    regular file
	1010	symlink
	1100	socket
orangefs does support regular files, directories and symlinks.	And the
check will cheerfully accept the type change from symlink to regular
files and vice versa.  It's not a bitmap...
	Fortunately, fixing the check is easy.

[7/15] ocfs2: ocfs2_inode_lock_update() and ocfs2_refresh_inode_from_lvb()
trust that type bits won't be screwed by another node in the cluster.
Odd belief, seeing that ocfs2_inode_lock_update() does some sanity
checking.  Make it verify that type does not change on a live inode
(and fail with ESTALE if it tries to).

[8/15] gfs2: gfs2_dinode_in() needs to be careful lest it fucks a live
inode over.  It can report a stale inode, so let it do so on type (and
device number) mismatches.

[9/15] cifs: if ->atomic_open() for non-exclusive create gets told that
the object already exists, it would better *NOT* assign it the mode we
would've used for file creation.  Moreover, in case when we do (creating)
open and subsequent equivalent of lookup as separate requests, there's a
possibility that another client will manage to unlink what we'd created
and mkdir something with the same name.  In that case we'd better leave
the ->i_mode alone, rather than blindly turning e.g. a directory in-core
inode into that of a regular file.

[10/15] cifs again: there's a counterpart of the same race for mkdir -
another client might've done rmdir+create between subdirectory creation
and getting its metadata.  If we run into that, don't try to mangle
i_mode, just nod politely, report success and do *not* hash the dentry.
That way the next lookup will pick whatever has ended up created in
that place.  ->mkdir() callers are ready to handle that case (e.g. NFS
has it happen on a regular basis).  ->create() and ->atomic_open() ones
are not, so we couldn't have used that approach for the previous problem.

[11/15] cifs: ->i_mode can be set by cifs_fattr_to_inode().  Some of its
callers check for type mismatches, some forget to do so.  Better have
it done in cifs_fattr_to_inode() itself.

[12/15] hostfs: in mknod() we end up with double call of
init_special_inode() - once in simulated lookup after creating the
object, once (pointlessly) before object creation.  Theoretically could
be a problem if object gets removed (by host) and then e.g. a regular
file is created in its place.  In any case, the call before do_mknod()
is useless and can be simply removed, getting rid of the problem.

[13/15] openpromfs: better set the inode up before unlocking it.  Not a
problem unless something's screwing OBP right under us (in which case
we are FUBAR), but getting that right is not hard and code is actually
cleaner that way.  Leave unlocking to the callers of openprom_iget(),
do not mess with live inode if ->lookup() finds one in icache.

[14/15] 9p: problem with inode type changes had been spotted there back
in 2011 and mostly fixed.  One case had been missed...

[15/15] spufs: only tangentially related to all this, but that's a place
where ->i_mode assignment is clearly bogus.  S_ISGID means "have child
inherit GID from parent and have it get S_ISGID as well"; it does *NOT*
mean "have all mode bits except S_ISGID cleared".

Shortlog:
Al Viro (12):
      new helper: inode_wrong_type()
      vboxsf: don't allow to change the inode type
      orangefs_inode_is_stale(): i_mode type bits do *not* form a bitmap...
      ocfs2_inode_lock_update(): make sure we don't change the type bits of i_mode
      gfs2: be careful with inode refresh
      do_cifs_create(): don't set ->i_mode of something we had not created
      cifs: have ->mkdir() handle race with another client sanely
      cifs: have cifs_fattr_to_inode() refuse to change type on live inode
      hostfs_mknod(): don't bother with init_special_inode()
      openpromfs: don't do unlock_new_inode() until the new inode is set up
      9p: missing chunk of "fs/9p: Don't update file type when updating file attributes"
      spufs: fix bogosity in S_ISGID handling

David Howells (1):
      afs: Fix updating of i_mode due to 3rd party change

Jeff Layton (2):
      ceph: fix up error handling with snapdirs
      ceph: don't allow type or device number to change on non-I_NEW inodes

Diffstat:
 arch/powerpc/platforms/cell/spufs/inode.c | 10 +----
 fs/9p/vfs_inode.c                         |  4 +-
 fs/9p/vfs_inode_dotl.c                    | 14 +++----
 fs/afs/inode.c                            |  6 +--
 fs/ceph/caps.c                            |  8 +++-
 fs/ceph/dir.c                             |  2 +
 fs/ceph/export.c                          |  9 ++--
 fs/ceph/inode.c                           | 41 ++++++++++++++++---
 fs/cifs/cifsproto.h                       |  2 +-
 fs/cifs/dir.c                             | 19 +++++----
 fs/cifs/file.c                            |  2 +-
 fs/cifs/inode.c                           | 57 ++++++++++++--------------
 fs/cifs/readdir.c                         |  4 +-
 fs/fuse/dir.c                             |  6 +--
 fs/fuse/inode.c                           |  2 +-
 fs/fuse/readdir.c                         |  2 +-
 fs/gfs2/glops.c                           | 22 ++++++----
 fs/hostfs/hostfs_kern.c                   |  1 -
 fs/nfs/inode.c                            |  6 +--
 fs/nfsd/nfsproc.c                         |  2 +-
 fs/ocfs2/dlmglue.c                        | 12 +++++-
 fs/openpromfs/inode.c                     | 67 +++++++++++++++---------------
 fs/orangefs/orangefs-utils.c              |  2 +-
 fs/overlayfs/namei.c                      |  4 +-
 fs/vboxsf/dir.c                           |  4 +-
 fs/vboxsf/super.c                         |  4 +-
 fs/vboxsf/utils.c                         | 68 +++++++++++++++++++------------
 fs/vboxsf/vfsmod.h                        |  4 +-
 include/linux/fs.h                        |  5 +++
 29 files changed, 225 insertions(+), 164 deletions(-)
