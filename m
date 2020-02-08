Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21E81562CF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 04:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBHDm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 22:42:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53320 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBHDm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 22:42:57 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0H11-009AND-Tc; Sat, 08 Feb 2020 03:42:44 +0000
Date:   Sat, 8 Feb 2020 03:42:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sj1557.seo@samsung.com,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] exfat: update file system parameter handling
Message-ID: <20200208034243.GF23230@ZenIV.linux.org.uk>
References: <297144.1580786668@turing-police>
 <CGME20200204060659epcas1p1968fda93ab3a2cbbdb812b33c12d8a55@epcas1p1.samsung.com>
 <20200204060654.GB31675@lst.de>
 <003701d5db27$d3cd1ce0$7b6756a0$@samsung.com>
 <252365.1580963202@turing-police>
 <20200206065423.GZ23230@ZenIV.linux.org.uk>
 <CAHk-=whniQCaQmduhPedBg6cird8R5GHqfMGQWedYLsV4FpHig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whniQCaQmduhPedBg6cird8R5GHqfMGQWedYLsV4FpHig@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 06:02:19PM -0800, Linus Torvalds wrote:
> On Wed, Feb 5, 2020 at 10:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         The situation with #work.fs_parse is simple: I'm waiting for NFS series
> > to get in (git://git.linux-nfs.org/projects/anna/linux-nfs.git, that is).
> >  As soon as it happens, I'm sending #work.fs_parse + merge with nfs stuff +
> > fixups for said nfs stuff to Linus.
> 
> I've got the nfs pull request and it's merged now.

OK...  Here's what I have:

#work.fs_parse + merge of it with nfs branch + fixups needed for NFS.
The merge is free of textual conflicts, but there are semantical ones,
thus the need of fixups.  That's in #merge.nfs-fs_parse.0, and that's
what had been in -next.

I'm not sure what would be the best course here

1) you could pull #work.fs_parse and fold the fixups (c354ed1dd8f4) into
the merge commit, but... that'll hide them from things like git log -p;
every time I run into somebody doing that I end up very unhappy with
whoever has pulled that crap - usually after an hour of trying to find
out when the hell has that change been done.

2) Another variant is to pull #merge.nfs-fs_parse.0 as-is; no fishiness
in merge commits, but there would be bisect hazard left inside that thing.

3) #merge.nfs-fs_parse.1 - same thing rebased on top of nfs branch; "same"
as in
al@duke:~/linux/trees/vfs$ git cat-file -p merge.nfs-fs_parse.0|grep tree
tree d16f842764297172e6bc3e636109044f59b17b1e
al@duke:~/linux/trees/vfs$ git cat-file -p merge.nfs-fs_parse.1|grep tree
tree d16f842764297172e6bc3e636109044f59b17b1e

That gives no backmerges and no bisect hazards - the fixups are spread
into the series.  A couple of fixes in the end of #work.fs_parse are
also folded in.

My preference would be (3), but if you would rather go for (1) or (2),
it's up to you.  My apologies about the messy branch topology ;-/

Anyway, pull requests would be:
============================================================================
For variant 3:

Saner fs_parser.c guts and data structures; the system-wide registry of
syntax types (string/enum/int32/oct32/.../etc.) is gone and so is the
horror switch() in fs_parse() that would have to grow another case every
time something got added to that system-wide registry.  New syntax
types can be added by filesystems easily now, and their namespace is
that of functions - not of system-wide enum members.  IOW, they can be
shared or kept private and if some turn out to be widely useful, we can
make them common library helpers, etc., without having to do anything
whatsoever to fs_parse() itself.

And we already get that kind of requests - the thing that finally pushed
me into doing that was "oh, and let's add one for timeouts - things like
15s or 2h".  If some filesystem really wants that, let them do it.
Without somebody having to play gatekeeper for the variants blessed by
direct support in fs_parse(), TYVM.

Quite a bit of boilerplate is gone.  And IMO the data structures make
a lot more sense now.  -200LoC, while we are at it.

The following changes since commit 7dc2993a9e51dd2eee955944efec65bef90265b7:

  NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals (2020-02-04 12:27:55 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git merge.nfs-fs_parse.1

for you to fetch changes up to f35aa2bc809eacc44c3cee41b52cef1c451d4a89:

  tmpfs: switch to use of invalfc() (2020-02-07 14:48:44 -0500)

----------------------------------------------------------------
Al Viro (24):
      Pass consistent param->type to fs_parse()
      fs_parse: get rid of ->enums
      fold struct fs_parameter_enum into struct constant_table
      don't bother with explicit length argument for __lookup_constant()
      get rid of fs_value_is_filename_empty
      get rid of cg_invalf()
      teach logfc() to handle prefices, give it saner calling conventions
      struct p_log, variants of warnf() et.al. taking that one instead
      switch rbd and libceph to p_log-based primitives
      new primitive: __fs_parse()
      ceph_parse_param(), ceph_parse_mon_ips(): switch to passing fc_log
      add prefix to fs_context->log
      fs_parse: fold fs_parameter_desc/fs_parameter_spec
      fs_parse: handle optional arguments sanely
      turn fs_param_is_... into functions
      prefix-handling analogues of errorf() and friends
      ceph: use errorfc() and friends instead of spelling the prefix out
      fuse: switch to use errorfc() et.al.
      gfs2: switch to use of errorfc() et.al.
      cramfs: switch to use of errofc() et.al.
      hugetlbfs: switch to use of invalfc()
      procfs: switch to use of invalfc()
      cgroup1: switch to use of errorfc() et.al.
      tmpfs: switch to use of invalfc()

Eric Sandeen (1):
      fs_parser: remove fs_parameter_description name field

 Documentation/filesystems/mount_api.txt   |  12 +-
 arch/powerpc/platforms/cell/spufs/inode.c |  11 +-
 arch/s390/hypfs/inode.c                   |  11 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  11 +-
 drivers/base/devtmpfs.c                   |   4 +-
 drivers/block/rbd.c                       |  31 +--
 drivers/usb/gadget/function/f_fs.c        |  11 +-
 fs/afs/super.c                            |  32 +--
 fs/ceph/cache.c                           |   4 +-
 fs/ceph/super.c                           |  40 ++-
 fs/cramfs/inode.c                         |  14 +-
 fs/filesystems.c                          |   3 +-
 fs/fs_context.c                           |  79 ++----
 fs/fs_parser.c                            | 447 +++++++++++++-----------------
 fs/fsopen.c                               |  26 +-
 fs/fuse/inode.c                           |  25 +-
 fs/gfs2/ops_fstype.c                      | 103 +++----
 fs/hugetlbfs/inode.c                      |  13 +-
 fs/jffs2/super.c                          |  26 +-
 fs/nfs/fs_context.c                       |  93 ++++---
 fs/proc/root.c                            |  13 +-
 fs/ramfs/inode.c                          |  11 +-
 fs/xfs/xfs_super.c                        |  11 +-
 include/linux/ceph/libceph.h              |   5 +-
 include/linux/fs.h                        |   4 +-
 include/linux/fs_context.h                |  32 ++-
 include/linux/fs_parser.h                 | 101 +++----
 include/linux/ramfs.h                     |   4 +-
 include/linux/shmem_fs.h                  |   3 +-
 kernel/bpf/inode.c                        |  11 +-
 kernel/cgroup/cgroup-internal.h           |   4 +-
 kernel/cgroup/cgroup-v1.c                 |  35 +--
 kernel/cgroup/cgroup.c                    |  13 +-
 mm/shmem.c                                |  40 ++-
 net/ceph/ceph_common.c                    |  41 ++-
 security/selinux/hooks.c                  |  11 +-
 security/smack/smack_lsm.c                |   9 +-
 37 files changed, 562 insertions(+), 782 deletions(-)

============================================================================
For variant 2:

Saner fs_parser.c guts and data structures; the system-wide registry of
syntax types (string/enum/int32/oct32/.../etc.) is gone and so is the
horror switch() in fs_parse() that would have to grow another case every
time something got added to that system-wide registry.  New syntax
types can be added by filesystems easily now, and their namespace is
that of functions - not of system-wide enum members.  IOW, they can be
shared or kept private and if some turn out to be widely useful, we can
make them common library helpers, etc., without having to do anything
whatsoever to fs_parse() itself.

And we already get that kind of requests - the thing that finally pushed
me into doing that was "oh, and let's add one for timeouts - things like
15s or 2h".  If some filesystem really wants that, let them do it.
Without somebody having to play gatekeeper for the variants blessed by
direct support in fs_parse(), TYVM.

Quite a bit of boilerplate is gone.  And IMO the data structures make
a lot more sense now.  -200LoC, while we are at it.

The following changes since commit 7dc2993a9e51dd2eee955944efec65bef90265b7:

  NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals (2020-02-04 12:27:55 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git merge.nfs-fs_parse.0

for you to fetch changes up to c7c780db827b80a219718b662aeded3eb7c65006:

  Merge branch 'work.fs_parse' into merge.nfs-fs_parse.0 (2020-02-07 00:05:57 -0500)

----------------------------------------------------------------
Al Viro (29):
      Pass consistent param->type to fs_parse()
      fs_parse: get rid of ->enums
      fold struct fs_parameter_enum into struct constant_table
      don't bother with explicit length argument for __lookup_constant()
      get rid of fs_value_is_filename_empty
      get rid of cg_invalf()
      teach logfc() to handle prefices, give it saner calling conventions
      struct p_log, variants of warnf() et.al. taking that one instead
      switch rbd and libceph to p_log-based primitives
      new primitive: __fs_parse()
      ceph_parse_param(), ceph_parse_mon_ips(): switch to passing fc_log
      add prefix to fs_context->log
      fs_parse: fold fs_parameter_desc/fs_parameter_spec
      fs_parse: handle optional arguments sanely
      turn fs_param_is_... into functions
      prefix-handling analogues of errorf() and friends
      ceph: use errorfc() and friends instead of spelling the prefix out
      fuse: switch to use errorfc() et.al.
      gfs2: switch to use of errorfc() et.al.
      cramfs: switch to use of errofc() et.al.
      hugetlbfs: switch to use of invalfc()
      procfs: switch to use of invalfc()
      cgroup1: switch to use of errorfc() et.al.
      tmpfs: switch to use of invalfc()
      restore the lost export of lookup_constant()
      Merge branch 'work.fs_parse' into merge.nfs-fs_parse
      nfs: update for fs_parse.c changes
      do not accept empty strings for fsparam_string()
      Merge branch 'work.fs_parse' into merge.nfs-fs_parse.0

Eric Sandeen (1):
      fs_parser: remove fs_parameter_description name field

 Documentation/filesystems/mount_api.txt   |  12 +-
 arch/powerpc/platforms/cell/spufs/inode.c |  11 +-
 arch/s390/hypfs/inode.c                   |  11 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  11 +-
 drivers/base/devtmpfs.c                   |   4 +-
 drivers/block/rbd.c                       |  31 +--
 drivers/usb/gadget/function/f_fs.c        |  11 +-
 fs/afs/super.c                            |  32 +--
 fs/ceph/cache.c                           |   4 +-
 fs/ceph/super.c                           |  40 ++-
 fs/cramfs/inode.c                         |  14 +-
 fs/filesystems.c                          |   3 +-
 fs/fs_context.c                           |  79 ++----
 fs/fs_parser.c                            | 447 +++++++++++++-----------------
 fs/fsopen.c                               |  26 +-
 fs/fuse/inode.c                           |  25 +-
 fs/gfs2/ops_fstype.c                      | 103 +++----
 fs/hugetlbfs/inode.c                      |  13 +-
 fs/jffs2/super.c                          |  26 +-
 fs/nfs/fs_context.c                       |  93 ++++---
 fs/proc/root.c                            |  13 +-
 fs/ramfs/inode.c                          |  11 +-
 fs/xfs/xfs_super.c                        |  11 +-
 include/linux/ceph/libceph.h              |   5 +-
 include/linux/fs.h                        |   4 +-
 include/linux/fs_context.h                |  32 ++-
 include/linux/fs_parser.h                 | 101 +++----
 include/linux/ramfs.h                     |   4 +-
 include/linux/shmem_fs.h                  |   3 +-
 kernel/bpf/inode.c                        |  11 +-
 kernel/cgroup/cgroup-internal.h           |   4 +-
 kernel/cgroup/cgroup-v1.c                 |  35 +--
 kernel/cgroup/cgroup.c                    |  13 +-
 mm/shmem.c                                |  40 ++-
 net/ceph/ceph_common.c                    |  41 ++-
 security/selinux/hooks.c                  |  11 +-
 security/smack/smack_lsm.c                |   9 +-
 37 files changed, 562 insertions(+), 782 deletions(-)
============================================================================

... and variant (1) would be the same summary + the following pull
request, with "please fold the contents of commit c354ed1dd8f4 (nfs:
update for fs_parse.c changes) into your merge commit as (non-textual)
conflict resolution)" appended to it.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fs_parse

for you to fetch changes up to 296713d91a7df022b0edf20d55f83554b4f95ba1:

  do not accept empty strings for fsparam_string() (2020-02-07 00:02:11 -0500)

----------------------------------------------------------------
Al Viro (26):
      Pass consistent param->type to fs_parse()
      fs_parse: get rid of ->enums
      fold struct fs_parameter_enum into struct constant_table
      don't bother with explicit length argument for __lookup_constant()
      get rid of fs_value_is_filename_empty
      get rid of cg_invalf()
      teach logfc() to handle prefices, give it saner calling conventions
      struct p_log, variants of warnf() et.al. taking that one instead
      switch rbd and libceph to p_log-based primitives
      new primitive: __fs_parse()
      ceph_parse_param(), ceph_parse_mon_ips(): switch to passing fc_log
      add prefix to fs_context->log
      fs_parse: fold fs_parameter_desc/fs_parameter_spec
      fs_parse: handle optional arguments sanely
      turn fs_param_is_... into functions
      prefix-handling analogues of errorf() and friends
      ceph: use errorfc() and friends instead of spelling the prefix out
      fuse: switch to use errorfc() et.al.
      gfs2: switch to use of errorfc() et.al.
      cramfs: switch to use of errofc() et.al.
      hugetlbfs: switch to use of invalfc()
      procfs: switch to use of invalfc()
      cgroup1: switch to use of errorfc() et.al.
      tmpfs: switch to use of invalfc()
      restore the lost export of lookup_constant()
      do not accept empty strings for fsparam_string()

Eric Sandeen (1):
      fs_parser: remove fs_parameter_description name field

 Documentation/filesystems/mount_api.txt   |  12 +-
 arch/powerpc/platforms/cell/spufs/inode.c |  11 +-
 arch/s390/hypfs/inode.c                   |  11 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  11 +-
 drivers/base/devtmpfs.c                   |   4 +-
 drivers/block/rbd.c                       |  31 +--
 drivers/usb/gadget/function/f_fs.c        |  11 +-
 fs/afs/super.c                            |  32 +--
 fs/ceph/cache.c                           |   4 +-
 fs/ceph/super.c                           |  40 ++-
 fs/cramfs/inode.c                         |  14 +-
 fs/filesystems.c                          |   3 +-
 fs/fs_context.c                           |  79 ++----
 fs/fs_parser.c                            | 447 +++++++++++++-----------------
 fs/fsopen.c                               |  26 +-
 fs/fuse/inode.c                           |  25 +-
 fs/gfs2/ops_fstype.c                      | 103 +++----
 fs/hugetlbfs/inode.c                      |  13 +-
 fs/jffs2/super.c                          |  26 +-
 fs/proc/root.c                            |  13 +-
 fs/ramfs/inode.c                          |  11 +-
 fs/xfs/xfs_super.c                        |  11 +-
 include/linux/ceph/libceph.h              |   5 +-
 include/linux/fs.h                        |   4 +-
 include/linux/fs_context.h                |  32 ++-
 include/linux/fs_parser.h                 | 101 +++----
 include/linux/ramfs.h                     |   4 +-
 include/linux/shmem_fs.h                  |   3 +-
 kernel/bpf/inode.c                        |  11 +-
 kernel/cgroup/cgroup-internal.h           |   4 +-
 kernel/cgroup/cgroup-v1.c                 |  35 +--
 kernel/cgroup/cgroup.c                    |  13 +-
 mm/shmem.c                                |  40 ++-
 net/ceph/ceph_common.c                    |  41 ++-
 security/selinux/hooks.c                  |  11 +-
 security/smack/smack_lsm.c                |   9 +-
 36 files changed, 514 insertions(+), 737 deletions(-)
