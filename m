Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0073DCEE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 05:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhHBDZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 23:25:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40650 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230341AbhHBDZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:25:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1723NGEr019269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 1 Aug 2021 23:23:17 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4BEDF15C3DD2; Sun,  1 Aug 2021 23:23:16 -0400 (EDT)
Date:   Sun, 1 Aug 2021 23:23:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
Subject: Re: [PATCH v27 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <YQdlJM6ngxPoeq4U@mit.edu>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729162459.GA3601405@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729162459.GA3601405@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 09:24:59AM -0700, Darrick J. Wong wrote:
> 
> I have the same (still unanswered) questions as last time:
> 
> 1. What happens when you run ntfs3 through fstests with '-g all'?  I get
> that the pass rate isn't going to be as high with ntfs3 as it is with
> ext4/xfs/btrfs, but fstests can be adapted (see the recent attempts to
> get exfat under test).

Indeed, it's not that hard at all.  I've included a patch to
xfstests-bld[1] so that you can just run "kvm-xfstests -c ntfs3 -g
auto".

Konstantin, I would *strongly* encourage you to try running fstests,
about 60 seconds into a run, we discover that generic/013 will trigger
locking problems that could lead to deadlocks.

The test generic/091 will also trigger kernel NULL dereference BUG:

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 23029 Comm: fsx Not tainted 5.14.0-rc2-xfstests-00010-gdf9570
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/4
RIP: 0010:__bio_add_page+0x46/0x80
Code: 39 47 5a 76 3d 41 89 d0 41 f7 d0 44 39 47 28 77 31 48 89 30 89 48 5
RSP: 0018:ffffa3fa05e13900 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000000
RDX: 0000000000001000 RSI: 0000000000000000 RDI: ffff908b8f930b40
RBP: ffff908b8f930b40 R08: 00000000ffffefff R09: 0000000000000000
R10: ffffffffa4973270 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f04a8ba2740(0000) GS:ffff908bfda00000(0000) knlGS:0000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000010984005 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 bio_add_page+0x62/0x90
 submit_bh_wbc+0xe3/0x190
 ll_rw_block+0xaa/0xb0
 ntfs_get_block_vbo+0x305/0x430
 do_direct_IO+0x3af/0xa20
 do_blockdev_direct_IO+0x2b7/0x960
 ? ntfs_get_block_write_begin+0x20/0x20
 ? ntfs_get_block_write_begin+0x20/0x20
 ? end_buffer_read_nobh+0x30/0x30
 ntfs_direct_IO+0xe5/0x1f0
 ? touch_atime+0x36/0x250
 generic_file_read_iter+0x8c/0x170
 generic_file_splice_read+0xfc/0x1b0
 splice_direct_to_actor+0xc3/0x230
 ? do_splice_to+0xc0/0xc0
 do_splice_direct+0x91/0xd0
 vfs_copy_file_range+0x144/0x450
 __do_sys_copy_file_range+0xc1/0x200
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f04a8c98f59
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 8
RSP: 002b:00007ffc8a2202b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000146
RAX: ffffffffffffffda RBX: 000000000000d000 RCX: 00007f04a8c98f59
RDX: 0000000000000003 RSI: 00007ffc8a220300 RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000000000d000 R09: 0000000000000000
R10: 00007ffc8a220308 R11: 0000000000000246 R12: 00007ffc8a220300
R13: 00007ffc8a220308 R14: 000000000000d000 R15: 000000000004c000
CR2: 0000000000000008
---[ end trace 1412a19831693976 ]---

It should also be noted that there doesn't appear to be an fsck for
ntfs --- there is ntfsfix in the ntfs-3g package but it's a full
replacement for chkdsk, and it will often throw up its hands, and tell
you to boot into Windows and run CHKDSK.  To be fair, this is also
true for the fuse-based ntfs implementation --- but at least the
fuse-based ntfs implementation won't deadlock your kernel or OOPS the
kernel with null pointer dereferences....  :-)

> 
> In case you're wondering why I ask these questions, my motivation is
> in figuring out how easy it will be to extend QA coverage to the
> community supported QA suite (fstests) so that people making treewide
> and vfs level changes can check that their changes don't bitrot your
> driver, and vice-versa.  My primary interest leans towards convincing
> everyone to value QA and practice it regularly (aka sharing the load so
> it's not entirely up to the maintainer to catch all problems) vs.
> finding every coding error as a gate condition for merging.

There are some changes that I've identified to make fstests support
fstests more cleanly.  But the real problem is the very weak level of
userspace tools available for NTFS today.  Is this something that
Paragon Software is planning on remedying?

						- Ted

Note: this isn't ready for prime-time yet, since the way I've hacked
up /sbin/mkfs.ntfs3 causes gce-xfstests to fail.  So this isn't going
to be going to xfsteests-bld upstream just yet.  But it's good enough
to make kvm-xfstests work....

Support for the fuse-based ntfs is also not complete for kvm-xfstests,
although the config files for ntfs didn't take that much time to do at
the same time.  Support for the fuse-based ntfs will require some
changes to _fs_type in common/rc so that fstests won't barf because
when you mount -t ntfs, /proc/mounts and df -T show a file system type
of "fuseblk".  What I've done so far was just a quick hack, because I
was curious how ready for prime-time ntfs3 might currently be.  :-)
But it does demonstrate how easy it is to run fstests on ntfs3.  The
hard part will be fixing all of the bugs that it uncovers --- but
better that you discover them now, rather than your customers (not to
mention the customers for all of us who work for various Linux
distributions and hyperscale cloud companies!).


commit c2899d9c0251078d9088b44cc7c583c192edd8a4
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sun Aug 1 20:47:35 2021 -0400

    test-appliance: add support for ntfs and ntfs3 file systems
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ntfs/cfg/all.list b/kvm-xfstests/test-appliance/files/root/fs/ntfs/cfg/all.list
new file mode 100644
index 0000000..4ad96d5
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ntfs/cfg/all.list
@@ -0,0 +1 @@
+default
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ntfs/cfg/default b/kvm-xfstests/test-appliance/files/root/fs/ntfs/cfg/default
new file mode 100644
index 0000000..8280c69
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ntfs/cfg/default
@@ -0,0 +1,4 @@
+SIZE=small
+export MKFS_OPTIONS=""
+export NTFS_MOUNT_OPTIONS=""
+TESTNAME="ntfs"
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ntfs/config b/kvm-xfstests/test-appliance/files/root/fs/ntfs/config
new file mode 100644
index 0000000..bee23a5
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ntfs/config
@@ -0,0 +1,64 @@
+#
+# Configuration file for ntfs
+#
+
+DEFAULT_MKFS_OPTIONS=""
+
+function check_filesystem()
+{
+    local dev="$1"
+    local ret
+
+    /bin/ntfsfix "$dev"
+    ret="$?"
+    echo ntfsfix exited with status "$ret"
+    return "$ret"
+}
+
+function format_filesystem()
+{
+    local dev="$1"
+    local opts="$2"
+    local ret
+
+    /sbin/mkfs.ntfs -f $opts "$dev"
+    ret="$?"
+    return "$ret"
+}
+
+function setup_mount_opts()
+{
+    if test -n "$MNTOPTS" ; then
+	if test -n "$NTFS_MOUNT_OPTIONS" ; then
+            export NTFS_MOUNT_OPTIONS="$MOUNT_OPTIONS,$MNTOPTS"
+	else
+	    export NTFS_MOUNT_OPTIONS="-o $MNTOPTS"
+	fi
+    fi
+}
+
+function get_mkfs_opts()
+{
+    echo "$NTFS_MKFS_OPTIONS"
+}
+
+function show_mkfs_opts()
+{
+    echo NTFS_MKFS_OPTIONS: "$NTFS_MKFS_OPTIONS"
+}
+
+function show_mount_opts()
+{
+    echo NTFS_MOUNT_OPTIONS: "NTFS_MOUNT_OPTIONS"
+}
+
+function test_name_alias()
+{
+    echo "$1"
+}
+
+function reset_vars()
+{
+    unset NTFS_MOUNT_OPTIONS
+    unset MKFS_OPTIONS
+}
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ntfs3/cfg/all.list b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/cfg/all.list
new file mode 100644
index 0000000..4ad96d5
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/cfg/all.list
@@ -0,0 +1 @@
+default
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ntfs3/cfg/default b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/cfg/default
new file mode 100644
index 0000000..8ba5d07
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/cfg/default
@@ -0,0 +1,4 @@
+SIZE=small
+export MKFS_OPTIONS=""
+export NTFS3_MOUNT_OPTIONS=""
+TESTNAME="ntfs3"
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ntfs3/config b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/config
new file mode 100644
index 0000000..6f67e12
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/config
@@ -0,0 +1,64 @@
+#
+# Configuration file for ntfs3
+#
+
+DEFAULT_MKFS_OPTIONS=""
+
+function check_filesystem()
+{
+    local dev="$1"
+    local ret
+
+    /bin/ntfsfix "$dev"
+    ret="$?"
+    echo ntfsfix exited with status "$ret"
+    return "$ret"
+}
+
+function format_filesystem()
+{
+    local dev="$1"
+    local opts="$2"
+    local ret
+
+    /sbin/mkfs.ntfs -f $opts "$dev"
+    ret="$?"
+    return "$ret"
+}
+
+function setup_mount_opts()
+{
+    if test -n "$MNTOPTS" ; then
+	if test -n "$NTFS3_MOUNT_OPTIONS" ; then
+            export NTFS3_MOUNT_OPTIONS="$MOUNT_OPTIONS,$MNTOPTS"
+	else
+	    export NTFS3_MOUNT_OPTIONS="-o $MNTOPTS"
+	fi
+    fi
+}
+
+function get_mkfs_opts()
+{
+    echo "$NTFS3_MKFS_OPTIONS"
+}
+
+function show_mkfs_opts()
+{
+    echo NTFS3_MKFS_OPTIONS: "$NTFS3_MKFS_OPTIONS"
+}
+
+function show_mount_opts()
+{
+    echo NTFS3_MOUNT_OPTIONS: "NTFS3_MOUNT_OPTIONS"
+}
+
+function test_name_alias()
+{
+    echo "$1"
+}
+
+function reset_vars()
+{
+    unset NTFS3_MOUNT_OPTIONS
+    unset MKFS_OPTIONS
+}
diff --git a/kvm-xfstests/test-appliance/files/sbin/mkfs.ntfs3 b/kvm-xfstests/test-appliance/files/sbin/mkfs.ntfs3
new file mode 100755
index 0000000..f6657a6
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/sbin/mkfs.ntfs3
@@ -0,0 +1,2 @@
+#!/bin/sh
+/sbin/mkfs.ntfs -f $*
diff --git a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
index befb105..48ce713 100644
--- a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
+++ b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
@@ -73,6 +73,7 @@ PACKAGES="bash-completion \
 	nbd-server \
 	nfs-common \
 	nfs-kernel-server \
+	ntfs-3g \
 	nvme-cli \
 	openssl \
 	pciutils \
diff --git a/kvm-xfstests/test-appliance/xfstests-packages b/kvm-xfstests/test-appliance/xfstests-packages
index 85ca6a6..6bb8432 100644
--- a/kvm-xfstests/test-appliance/xfstests-packages
+++ b/kvm-xfstests/test-appliance/xfstests-packages
@@ -33,6 +33,7 @@ mtd-utils
 multipath-tools
 nbd-client
 nbd-server
+ntfs-3g
 nvme-cli
 parted
 perl
