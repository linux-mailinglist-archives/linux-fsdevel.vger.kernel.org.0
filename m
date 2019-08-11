Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0049F8929D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHKQbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 12:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfHKQbm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 12:31:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 631AE2D1EF1;
        Sun, 11 Aug 2019 16:31:41 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-19.ams2.redhat.com [10.36.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E462812A77;
        Sun, 11 Aug 2019 16:31:39 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 resend 0/1] fs: Add VirtualBox guest shared folder (vboxsf)
Date:   Sun, 11 Aug 2019 18:31:33 +0200
Message-Id: <20190811163134.12708-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 11 Aug 2019 16:31:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Everyone,

Here is a second resend of the 12th version of my cleaned-up / refactored
version of the VirtualBox shared-folder VFS driver. It seems that the list
does not like patches being over 100000 char, so this time I've trimmed
the changelog below the --- in the commit messages, if you still want to
see the full changelog, see the end of this coverletter.

This version hopefully addresses all issues pointed out in David Howell's
review of v11 (thank you for the review David):

Changes in v12:
-Move make_kuid / make_kgid calls to option parsing time and add
 uid_valid / gid_valid checks.
-In init_fs_context call current_uid_gid() to init uid and gid
-Validate dmode, fmode, dmask and fmask options during option parsing
-Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
-Some small coding-style tweaks

This version has been used by several distributions (arch, Fedora) for a
while now, so hopefully we can get this upstream soonish, please review.

Regards,

Hans

---

Full changelog:

Changes in v12:
-Move make_kuid / make_kgid calls to option parsing time and add
 uid_valid / gid_valid checks.
-In init_fs_context call current_uid_gid() to init uid and gid
-Validate dmode, fmode, dmask and fmask options during option parsing
-Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
-Some small coding-style tweaks

Changes in v11:
-Convert to the new Documentation/filesystems/mount_api.txt mount API
-Fixed all the function kerneldoc comments to have things in the proper order
-Change type of d_type variable passed as type to dir_emit from int to
 unsigned int
-Replaced the fake-ino overflow test with the one suggested by David Howells
-Fixed various coding style issues

Changes in v10:
-Code-style fixes and remove some unneeded checks as suggested by Al Viro
-Stop handle reuse between sf_create_aux and sf_reg_open, the code for this
 was racy and the re-use meant the O_APPEND was not passed to the host for
 newly created files with O_APPEND set
-Use idr to generate unique inode number, modelled after the kernfs code
-Only read and write the contents of the passed in offset pointer once in
 sf_reg_write
-Keep a list of refcounted open handles in the inode, so that writepage can
 get a writeable handle this way. This replaces the old very racy code which
 was just storing a pointer to the last opened struct file inside the inode.
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
 -Use 0x786f4256 /* 'VBox' little endian */ as super-magic matching upstream
 -Implement AT_STATX_SYNC_TYPE support
 -Properly return -EPERM when symlink creation is not supported

Changes in v8:
-Fix broken error-handling / oops when the vboxsf_map_folder() call fails
-Fix umount using umount.nfs to umount vboxsf mounts
-Prefixed the modules init and exit function names with vboxsf_
-Delay connecting to the vbox hypervisor until the first mount, this fixes
 vboxsf not working when it is builtin (in which case it may be initialized
 before the vboxguest driver has bound to the guest communication PCI device)
-Fix sf_write_end return value, return the number of bytes written or 0 on error:
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
-Address: https://www.virtualbox.org/ticket/819 which really is multiple bugs:
 1) Fix MAP_SHARED not being supported
 2) Fix changes done through regular read/write on the guest side not being
    seen by guest apps using mmap() access
 3) Fix any changes done on the host side not being seen by guest apps using
    mmap() access

Changes in v5:
-Honor CONFIG_NLS_DEFAULT (reported-by michael.thayer@oracle.com)

Changes in v4:
-Drop "name=..." mount option, instead use the dev_name argument to the
 mount syscall, to keep compatibility with existing fstab entries
-Fix "nls=%" match_table_t entry to "nls=%s"

Changes in v3:
-Use text only mount options, instead of a custom data struct
-Stop caching full path in inode data, if parents gets renamed it will change
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

