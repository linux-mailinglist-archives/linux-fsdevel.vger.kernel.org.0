Return-Path: <linux-fsdevel+bounces-53637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9FAAF156D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8083B79AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8426FDBD;
	Wed,  2 Jul 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs0XXEz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57944231840;
	Wed,  2 Jul 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458686; cv=none; b=WIAlSsc/IPbq5dOUb2aifG0Gwt3jKlfu2OfhiZ/DOXAwCMduo20izSXra8md5MulhcBLwbdIGEGChX9/xmKzVr21TTQjoHQaSADDbmcSwGBykOMdpoRStVACbYsXyLGUFMWQUB7RzeI4EyofbyYRw7p81qJUUBckIfevol6DyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458686; c=relaxed/simple;
	bh=Dc8qX4lpcFmAG+qzkns0uJkrh4zP2tuyNNjsin4sMBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv4t5MgY69rId5M1f8YNQCZXoFkbAd+1e/ReESe59lC5sNXNNlBD0FjlmUXY+9DVoCejrhwFbl/4cbKCUGU9Rz8q3MOAOCJEN7WnHswnQc19avTr3tnBS7dzHrrhSAxOUfOWVjNZ/V97qcGH8VQgV5Dm3qRQ5UtMn/nzuJFifNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs0XXEz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C00C4CEED;
	Wed,  2 Jul 2025 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751458685;
	bh=Dc8qX4lpcFmAG+qzkns0uJkrh4zP2tuyNNjsin4sMBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fs0XXEz8ogrLnZqhtBUpDTw3j/T2VtaXdOgebVYJoX4LvJJ4rDA1omlBl6+FykkdA
	 FpNRhdOR6SbThXPK67EMA7NpXzQ7Ro+shdmSpc82KtObA3bAQ+Cm84ugWau6JNKCdk
	 KyD485WjF5js71EeubzPouYTvAFhjSE+xMxw9BkzQeRF2/FB6z53/YZngdHoZ1xNaO
	 8LZE8K0F74zjw5MY/F0onfuLbjgMDm82eD+Ais7VSMJ5cG7E+j53HLUvjt/kOAbVNX
	 OAuUaJ3JPJ718/TmSj3OodgnW7sRF714t8eyLEf9FDaDMup2r24VBQ56MluUSrho++
	 5zOpIIXPY9GDg==
Date: Wed, 2 Jul 2025 14:17:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, tj@kernel.org, 
	daan.j.demeyer@gmail.com, Will McVicker <willmcvicker@google.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	kernel-team@android.com
Subject: Re: [PATCH v3 bpf-next 1/4] kernfs: remove iattr_mutex
Message-ID: <20250702-hochmoderne-abklatsch-af9c605b57b2@brauner>
References: <20250623063854.1896364-1-song@kernel.org>
 <20250623063854.1896364-2-song@kernel.org>
 <78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uofxditqos5rkz6j"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org>


--uofxditqos5rkz6j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 02, 2025 at 11:47:58AM +0100, André Draszik wrote:
> Hi,
> 
> On Sun, 2025-06-22 at 23:38 -0700, Song Liu wrote:
> > From: Christian Brauner <brauner@kernel.org>
> > 
> > All allocations of struct kernfs_iattrs are serialized through a global
> > mutex. Simply do a racy allocation and let the first one win. I bet most
> > callers are under inode->i_rwsem anyway and it wouldn't be needed but
> > let's not require that.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Song Liu <song@kernel.org>
> 
> On next-20250701, ls -lA gives errors on /sys:
> 
> $ ls -lA /sys/
> ls: /sys/: No data available
> ls: /sys/kernel: No data available
> ls: /sys/power: No data available
> ls: /sys/class: No data available
> ls: /sys/devices: No data available
> ls: /sys/dev: No data available
> ls: /sys/hypervisor: No data available
> ls: /sys/fs: No data available
> ls: /sys/bus: No data available
> ls: /sys/firmware: No data available
> ls: /sys/block: No data available
> ls: /sys/module: No data available
> total 0
> drwxr-xr-x   2 root root 0 Jan  1  1970 block
> drwxr-xr-x  52 root root 0 Jan  1  1970 bus
> drwxr-xr-x  88 root root 0 Jan  1  1970 class
> drwxr-xr-x   4 root root 0 Jan  1  1970 dev
> drwxr-xr-x  11 root root 0 Jan  1  1970 devices
> drwxr-xr-x   3 root root 0 Jan  1  1970 firmware
> drwxr-xr-x  10 root root 0 Jan  1  1970 fs
> drwxr-xr-x   2 root root 0 Jul  2 09:43 hypervisor
> drwxr-xr-x  14 root root 0 Jan  1  1970 kernel
> drwxr-xr-x 251 root root 0 Jan  1  1970 module
> drwxr-xr-x   3 root root 0 Jul  2 09:43 power
> 
> 
> and my bisect is pointing to this commit. Simply reverting it also fixes
> the errors.
> 
> 
> Do you have any suggestions?

Yes, apparently the xattr selftest don't cover sysfs/kernfs. The issue
is that the commit changed listxattr() to skip allocation of the xattr
header and instead just returned ENODATA. We should just allocate like
before tested just now:

user1@localhost:~$ sudo ls -al /sys/kernel/
total 0
drwxr-xr-x  17 root root    0 Jul  2 13:41 .
dr-xr-xr-x  12 root root    0 Jul  2 13:41 ..
-r--r--r--   1 root root 4096 Jul  2 13:41 address_bits
drwxr-xr-x   3 root root    0 Jul  2 13:41 boot_params
drwxr-xr-x   2 root root    0 Jul  2 13:41 btf
drwxr-xr-x   2 root root    0 Jul  2 13:41 cgroup
drwxr-xr-x   2 root root    0 Jul  2 13:41 config
-r--r--r--   1 root root 4096 Jul  2 13:41 cpu_byteorder
-r--r--r--   1 root root 4096 Jul  2 13:41 crash_elfcorehdr_size
drwx------  34 root root    0 Jul  2 13:41 debug
-r--r--r--   1 root root 4096 Jul  2 13:41 fscaps
-r--r--r--   1 root root 4096 Jul  2 13:41 hardlockup_count
drwxr-xr-x   2 root root    0 Jul  2 13:41 iommu_groups
drwxr-xr-x 344 root root    0 Jul  2 13:41 irq
-r--r--r--   1 root root 4096 Jul  2 13:41 kexec_crash_loaded
-rw-r--r--   1 root root 4096 Jul  2 13:41 kexec_crash_size
-r--r--r--   1 root root 4096 Jul  2 13:41 kexec_loaded
drwxr-xr-x   9 root root    0 Jul  2 13:41 mm
-r--r--r--   1 root root   84 Jul  2 13:41 notes
-r--r--r--   1 root root 4096 Jul  2 13:41 oops_count
-rw-r--r--   1 root root 4096 Jul  2 13:41 profiling
-rw-r--r--   1 root root 4096 Jul  2 13:41 rcu_expedited
-rw-r--r--   1 root root 4096 Jul  2 13:41 rcu_normal
-r--r--r--   1 root root 4096 Jul  2 13:41 rcu_stall_count
drwxr-xr-x   2 root root    0 Jul  2 13:41 reboot
drwxr-xr-x   2 root root    0 Jul  2 13:41 sched_ext
drwxr-xr-x   4 root root    0 Jul  2 13:41 security
drwxr-xr-x 190 root root    0 Jul  2 13:41 slab
-r--r--r--   1 root root 4096 Jul  2 13:41 softlockup_count
drwxr-xr-x   2 root root    0 Jul  2 13:41 software_nodes
drwxr-xr-x   4 root root    0 Jul  2 13:41 sunrpc
drwxr-xr-x   6 root root    0 Jul  2 13:41 tracing
-r--r--r--   1 root root 4096 Jul  2 13:41 uevent_seqnum
-r--r--r--   1 root root 4096 Jul  2 13:41 vmcoreinfo
-r--r--r--   1 root root 4096 Jul  2 13:41 warn_count

I'm folding:

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3c293a5a21b1..457f91c412d4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -142,9 +142,9 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
        struct kernfs_node *kn = kernfs_dentry_node(dentry);
        struct kernfs_iattrs *attrs;

-       attrs = kernfs_iattrs_noalloc(kn);
+       attrs = kernfs_iattrs(kn);
        if (!attrs)
-               return -ENODATA;
+               return -ENOMEM;

        return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
 }

which brings it back to the old behavior.

I'm also adding a selftest for this behavior. Patch appended.

--uofxditqos5rkz6j
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-selftests-kernfs-test-xattr-retrieval.patch"

From c20804314ae1ca5678e6b135b0ab1bc54fb3e410 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 2 Jul 2025 13:53:21 +0200
Subject: [PATCH] selftests/kernfs: test xattr retrieval

Make sure that listxattr() returns zero and that getxattr() returns
ENODATA when no extended attributs are set. Use /sys/kernel/warn_count
as that always exists and is a read-only file.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/filesystems/.gitignore  |  1 +
 tools/testing/selftests/filesystems/Makefile  |  2 +-
 .../selftests/filesystems/kernfs_test.c       | 38 +++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/kernfs_test.c

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 7afa58e2bb20..fcbdb1297e24 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -3,3 +3,4 @@ dnotify_test
 devpts_pts
 file_stressor
 anon_inode_test
+kernfs_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index b02326193fee..73d4650af1a5 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test
+TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/kernfs_test.c b/tools/testing/selftests/filesystems/kernfs_test.c
new file mode 100644
index 000000000000..16538b3b318e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/kernfs_test.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/xattr.h>
+
+#include "../kselftest_harness.h"
+#include "wrappers.h"
+
+TEST(kernfs_listxattr)
+{
+	int fd;
+
+	/* Read-only file that can never have any extended attributes set. */
+	fd = open("/sys/kernel/warn_count", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(flistxattr(fd, NULL, 0), 0);
+	EXPECT_EQ(close(fd), 0);
+}
+
+TEST(kernfs_getxattr)
+{
+	int fd;
+	char buf[1];
+
+	/* Read-only file that can never have any extended attributes set. */
+	fd = open("/sys/kernel/warn_count", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_LT(fgetxattr(fd, "user.foo", buf, sizeof(buf)), 0);
+	ASSERT_EQ(errno, ENODATA);
+	EXPECT_EQ(close(fd), 0);
+}
+
+TEST_HARNESS_MAIN
+
-- 
2.47.2


--uofxditqos5rkz6j--

