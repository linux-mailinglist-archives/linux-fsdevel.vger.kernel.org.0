Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4BA11CF63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 15:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfLLOJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 09:09:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31611 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729392AbfLLOJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576159763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xpc4mhkZBpvemSSOMWbkbOh5T9FRjZYZ27bxgcDxrA0=;
        b=Z6QcQhsQdYwRo90D+7TVc+8947snz+6tR5dJDfJSdQA78GiKM8Ogzq8g0uc954/ZuWwQM8
        EpPY0MOsvyzQl61+yFMnzWmyI2rE5kiwvXPAPfTZ5lsJab0nafp5apk4puXOenl/81F2WN
        gODmOCcI1Ys8ctR9iVAIqxi8vy6bLb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-gQtQ5VFZPZirIR6-uQxlIQ-1; Thu, 12 Dec 2019 09:09:21 -0500
X-MC-Unique: gQtQ5VFZPZirIR6-uQxlIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F90100551D;
        Thu, 12 Dec 2019 14:09:17 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2711B5C1C3;
        Thu, 12 Dec 2019 14:09:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 0/1] fs: Add VirtualBox guest shared folder (vboxsf) support
Date:   Thu, 12 Dec 2019 15:09:13 +0100
Message-Id: <20191212140914.21908-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Everyone,

Here is the 19th version of my cleaned-up / refactored version of the
VirtualBox shared-folder VFS driver.=20

This version addresses all remarks from Al Viro's review of v18.

I believe that this is ready for upstream merging now, if this needs
more work please let me know.

Changes in v19:
- Misc. small code tweaks suggested by Al Viro (no functional changes)
- Do not increment dir_context->pos when dir_emit has returned false.
- Add a WARN_ON check for trying to access beyond the end of a
  vboxsf directory buffer, this uses WARN_ON as this means the host has
  given us corrupt data
- Catch the user passing the "nls" opt more then once

Regards,

Hans

---

Full changelog:

Changes in v19:
- Misc. small code tweaks suggested by Al Viro (no functional changes)
- Do not increment dir_context->pos when dir_emit has returned false.
- Add a WARN_ON check for trying to access beyond the end of a
  vboxsf directory buffer, this uses WARN_ON as this means the host has
  given us corrupt data
- Catch the user passing the "nls" opt more then once

Changes in v18:
- Move back to fs/vboxsf for direct submission to Linus
- Squash in a few small fixes done during vboxsf's brief stint in staging
- Add handling of short copies to vboxsf_write_end
- Add a comment about our simple_write_begin usage (Suggested by David Ho=
well)

Changes in v17:
- Submit upstream through drivers/staging as this is not getting any
  traction on the fsdevel list
- Add TODO file
- vboxsf_free_inode uses sbi->idr, call rcu_barrier from put_super to mak=
e
  sure all delayed rcu free inodes are flushed

Changes in v16:
- Make vboxsf_parse_monolithic() static, reported-by: kbuild test robot

Changes in v15:
- Rebase on top of 5.4-rc1

Changes in v14
- Add a commment explaining possible read cache strategies and which one
  has been chosen
- Change pagecache-invalidation on open (inode_revalidate) to use
  invalidate_inode_pages2() so that mmap-ed pages are dropped from
  the cache too
- Add a comment to vboxsf_file_release explaining why the
  filemap_write_and_wait() call is done there
- Some minor code tweaks

Changes in v13
- Add SPDX tag to Makefile, use foo-y :=3D to set objectfile list
- Drop kerneldoc headers stating the obvious from vfs callbacks,
  to avoid them going stale
- Replace sf_ prefix of functions and data-types with vboxsf_
- Use more normal naming scheme for sbi and private inode data:
    struct vboxsf_sbi *sbi =3D VBOXSF_SBI(inode->i_sb);
    struct vboxsf_inode *sf_i =3D VBOXSF_I(inode);
- Refactor directory reading code
- Use goto based unwinding instead of nested if-s in a number of places
- Consolidate dir unlink and rmdir inode_operations into a single functio=
n
- Use the page-cache for regular reads/writes too
- Directly set super_operations.free_inode to what used to be our
  vboxsf_i_callback, instead of setting super_operations.destroy_inode
  to a function which just does: call_rcu(&inode->i_rcu, vboxsf_i_callbac=
k);
- Use spinlock_irqsafe for ino_idr_lock
  vboxsf_free_inode may be called from a RCU callback, and thus from
  softirq context, so we need to use spinlock_irqsafe vboxsf_new_inode.
  On alloc_inode failure vboxsf_free_inode may be called from process
  context, so it too needs to use spinlock_irqsafe.

Changes in v12:
- Move make_kuid / make_kgid calls to option parsing time and add
  uid_valid / gid_valid checks.
- In init_fs_context call current_uid_gid() to init uid and gid
- Validate dmode, fmode, dmask and fmask options during option parsing
- Use correct types for various mount option variables (kuid_t, kgid_t, u=
mode_t)
- Some small coding-style tweaks

Changes in v11:
- Convert to the new Documentation/filesystems/mount_api.txt mount API
- Fixed all the function kerneldoc comments to have things in the proper =
order
- Change type of d_type variable passed as type to dir_emit from int to
  unsigned int
- Replaced the fake-ino overflow test with the one suggested by David How=
ells
- Fixed various coding style issues

Changes in v10:
-Code-style fixes and remove some unneeded checks as suggested by Al Viro
-Stop handle reuse between sf_create_aux and sf_reg_open, the code for th=
is
 was racy and the re-use meant the O_APPEND was not passed to the host fo=
r
 newly created files with O_APPEND set
-Use idr to generate unique inode number, modelled after the kernfs code
-Only read and write the contents of the passed in offset pointer once in
 sf_reg_write
-Keep a list of refcounted open handles in the inode, so that writepage c=
an
 get a writeable handle this way. This replaces the old very racy code wh=
ich
 was just storing a pointer to the last opened struct file inside the ino=
de.
 This is modelled after how the cifs and fuse code do this

Changes in v9:
-Change license from GPL-2.0 or CDDL-1.0 to MIT, following upstream's
 license change from: https://www.virtualbox.org/changeset/72627/vbox
 I've gotten permission by email from VirtualBox upstream to retro-active=
ly
 apply the license-change to my "fork" of the vboxsf code
-Fix not being able to mount any shared-folders when built with gcc9
-Adjust for recent vboxguest changes
-Fix potential buffer overrun in vboxsf_nlscpy
-Fix build errors in some configs, caught by buildbot
-Fix 3 sparse warnings
-Some changes from upstream VirtualBox svn:
 -Use 0x786f4256 /* 'VBox' little endian */ as super-magic matching upstr=
eam
 -Implement AT_STATX_SYNC_TYPE support
 -Properly return -EPERM when symlink creation is not supported

Changes in v8:
-Fix broken error-handling / oops when the vboxsf_map_folder() call fails
-Fix umount using umount.nfs to umount vboxsf mounts
-Prefixed the modules init and exit function names with vboxsf_
-Delay connecting to the vbox hypervisor until the first mount, this fixe=
s
 vboxsf not working when it is builtin (in which case it may be initializ=
ed
 before the vboxguest driver has bound to the guest communication PCI dev=
ice)
-Fix sf_write_end return value, return the number of bytes written or 0 o=
n error:
 https://github.com/jwrdegoede/vboxsf/issues/2
-Use an ida id in the name passed to super_setup_bdi_name so that the sam=
e
 shared-folder can be mounted twice without causing a
 "sysfs: cannot create duplicate filename" error
 https://github.com/jwrdegoede/vboxsf/issues/3

Changes in v7:
-Do not propagate sgid / suid bits between guest-host, note hosts with
 VirtualBox version 5.2.6 or newer will filter these out regardless of wh=
at
 we do
-Better error messages when we cannot connect to the VirtualBox guest PCI
 device, which may e.g. happen when trying to use vboxsf outside a vbox v=
m

Changes in v6:
-Address: https://www.virtualbox.org/ticket/819 which really is multiple =
bugs:
 1) Fix MAP_SHARED not being supported
 2) Fix changes done through regular read/write on the guest side not bei=
ng
    seen by guest apps using mmap() access
 3) Fix any changes done on the host side not being seen by guest apps us=
ing
    mmap() access

Changes in v5:
-Honor CONFIG_NLS_DEFAULT (reported-by michael.thayer@oracle.com)

Changes in v4:
-Drop "name=3D..." mount option, instead use the dev_name argument to the
 mount syscall, to keep compatibility with existing fstab entries
-Fix "nls=3D%" match_table_t entry to "nls=3D%s"

Changes in v3:
-Use text only mount options, instead of a custom data struct
-Stop caching full path in inode data, if parents gets renamed it will ch=
ange
-Fixed negative dentries handling
-Dropped the force_reread flag for dirs, not sure what it was actually fo=
r
 but it is no good, doing a re-read on unlink of a file will lead to
 another file being skipped if the caller has already iterated over the
 entry for the unlinked file.
-Use file_inode(), file_dentry() and d_inode() helpers
-Prefix any non object-private symbols with vboxsf_ so as to not pollute
 the global namespace when builtin
-Add MAINTAINERS entry
-Misc. cleanups

Changes in v2:
-Removed various unused wrapper functions
-Don't use i_private, instead defined alloc_inode and destroy_inode
 methods and use container_of.
-Drop obsolete comment referencing people to
 http://www.atnf.csiro.au/people/rgooch/linux/vfs.txt
-move the single symlink op of from lnkops.c to file.c
-Use SPDX license headers
-Replace SHFLROOT / SHFLHANDLE defines with normal types
-Removed unnecessary S_ISREG checks
-Got rid of bounce_buffer in regops, instead add a "user" flag to
 vboxsf_read / vboxsf_write, re-using the existing __user address support
 in the vboxguest module
-Make vboxsf_wrappers return regular linux errno values
-Use i_size_write to update size on writing
-Convert doxygen style comments to kerneldoc style comments

