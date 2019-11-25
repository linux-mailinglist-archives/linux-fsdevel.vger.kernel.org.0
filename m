Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43C4108F98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 15:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfKYOIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 09:08:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727716AbfKYOIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574690928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r+Gvf1OAJV5NI8Mac0iXBc+74PCvOJEKGWXPCdc50Fs=;
        b=aAbNG+NBE0QdSpF+u2TvoOusCJ+xPfaNdolfJzFaM5dEo5Q1LP4O7ODY9WqbNk6fS4XCeI
        9TSrUDjLputJWapmGJMk+AO0mJzrfkNp8+X7+UU3wokyK8ojl0GjuWmqcUxFPyGrkQTeiv
        2kHISWtmPOnqPpoflSf6IMVN4B3CoDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-qYAEOi0BNUOQ-HxyzAh-xg-1; Mon, 25 Nov 2019 09:08:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E0698C677E;
        Mon, 25 Nov 2019 14:08:43 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AF2360C18;
        Mon, 25 Nov 2019 14:08:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 0/1] fs: Add VirtualBox guest shared folder (vboxsf) support
Date:   Mon, 25 Nov 2019 15:08:38 +0100
Message-Id: <20191125140839.4956-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qYAEOi0BNUOQ-HxyzAh-xg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

As discussed in relation to the brief sting of vboxsf in drivers/staging,
Al Viro seems to be too busy with other things to have time to take this
patch upstream, therefor I'm submitting it directly to you.

Al Viro did do an initial review around v2 or v3 of the patch, which I
believe I have fully addressed.

v10 and v11 have been reviewed by David Howell and all his comments have
been addressed in v12.

v12 and v13 have been reviewed by Christoph Hellwig and all his comments
have been addressed in v14.

Later versions contain some small changes, but have mostly been
resubmissions attempting to get this upstream.

Christoph responded to my v17 submission with:

"Please just send it to Linus directly.  This is the equivalent of
consumer hardware enablement and it is in a state as clean as it gets
for the rather messed up protocol."

And Christoph has given his Acked-by for this v18 submission.

Regards,

Hans

---

Full changelog:

Changes in v18:
- Move back to fs/vboxsf for direct submission to Linus
- Squash in a few small fixes done during vboxsf's brief stint in staging
- Add handling of short copies to vboxsf_write_end
- Add a comment about our simple_write_begin usage (Suggested by David Howe=
ll)

Changes in v17:
- Submit upstream through drivers/staging as this is not getting any
  traction on the fsdevel list
- Add TODO file
- vboxsf_free_inode uses sbi->idr, call rcu_barrier from put_super to make
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
- Consolidate dir unlink and rmdir inode_operations into a single function
- Use the page-cache for regular reads/writes too
- Directly set super_operations.free_inode to what used to be our
  vboxsf_i_callback, instead of setting super_operations.destroy_inode
  to a function which just does: call_rcu(&inode->i_rcu, vboxsf_i_callback)=
;
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
- Use correct types for various mount option variables (kuid_t, kgid_t, umo=
de_t)
- Some small coding-style tweaks

Changes in v11:
- Convert to the new Documentation/filesystems/mount_api.txt mount API
- Fixed all the function kerneldoc comments to have things in the proper or=
der
- Change type of d_type variable passed as type to dir_emit from int to
  unsigned int
- Replaced the fake-ino overflow test with the one suggested by David Howel=
ls
- Fixed various coding style issues

Changes in v10:
-Code-style fixes and remove some unneeded checks as suggested by Al Viro
-Stop handle reuse between sf_create_aux and sf_reg_open, the code for this
 was racy and the re-use meant the O_APPEND was not passed to the host for
 newly created files with O_APPEND set
-Use idr to generate unique inode number, modelled after the kernfs code
-Only read and write the contents of the passed in offset pointer once in
 sf_reg_write
-Keep a list of refcounted open handles in the inode, so that writepage can
 get a writeable handle this way. This replaces the old very racy code whic=
h
 was just storing a pointer to the last opened struct file inside the inode=
.
 This is modelled after how the cifs and fuse code do this

Changes in v9:
-Change license from GPL-2.0 or CDDL-1.0 to MIT, following upstream's
 license change from: https://www.virtualbox.org/changeset/72627/vbox
 I've gotten permission by email from VirtualBox upstream to retro-actively
 apply the license-change to my "fork" of the vboxsf code
-Fix not being able to mount any shared-folders when built with gcc9
-Adjust for recent vboxguest changes
-Fix potential buffer overrun in vboxsf_nlscpy
-Fix build errors in some configs, caught by buildbot
-Fix 3 sparse warnings
-Some changes from upstream VirtualBox svn:
 -Use 0x786f4256 /* 'VBox' little endian */ as super-magic matching upstrea=
m
 -Implement AT_STATX_SYNC_TYPE support
 -Properly return -EPERM when symlink creation is not supported

Changes in v8:
-Fix broken error-handling / oops when the vboxsf_map_folder() call fails
-Fix umount using umount.nfs to umount vboxsf mounts
-Prefixed the modules init and exit function names with vboxsf_
-Delay connecting to the vbox hypervisor until the first mount, this fixes
 vboxsf not working when it is builtin (in which case it may be initialized
 before the vboxguest driver has bound to the guest communication PCI devic=
e)
-Fix sf_write_end return value, return the number of bytes written or 0 on =
error:
 https://github.com/jwrdegoede/vboxsf/issues/2
-Use an ida id in the name passed to super_setup_bdi_name so that the same
 shared-folder can be mounted twice without causing a
 "sysfs: cannot create duplicate filename" error
 https://github.com/jwrdegoede/vboxsf/issues/3

Changes in v7:
-Do not propagate sgid / suid bits between guest-host, note hosts with
 VirtualBox version 5.2.6 or newer will filter these out regardless of what
 we do
-Better error messages when we cannot connect to the VirtualBox guest PCI
 device, which may e.g. happen when trying to use vboxsf outside a vbox vm

Changes in v6:
-Address: https://www.virtualbox.org/ticket/819 which really is multiple bu=
gs:
 1) Fix MAP_SHARED not being supported
 2) Fix changes done through regular read/write on the guest side not being
    seen by guest apps using mmap() access
 3) Fix any changes done on the host side not being seen by guest apps usin=
g
    mmap() access

Changes in v5:
-Honor CONFIG_NLS_DEFAULT (reported-by michael.thayer@oracle.com)

Changes in v4:
-Drop "name=3D..." mount option, instead use the dev_name argument to the
 mount syscall, to keep compatibility with existing fstab entries
-Fix "nls=3D%" match_table_t entry to "nls=3D%s"

Changes in v3:
-Use text only mount options, instead of a custom data struct
-Stop caching full path in inode data, if parents gets renamed it will chan=
ge
-Fixed negative dentries handling
-Dropped the force_reread flag for dirs, not sure what it was actually for
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
=20

