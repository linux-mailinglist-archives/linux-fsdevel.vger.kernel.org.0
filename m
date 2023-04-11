Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23C6DCF47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 03:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDKB3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 21:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjDKB3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:29:40 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E551995
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 18:29:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-246a00d70eeso180907a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 18:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681176578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBCdWjTPDV7u7tywdkOEhqA30FFTo51cVFS76tLVdIk=;
        b=XXnjZgXzwtwzC9wPP7936MOH1Bh6PiD2hqfXsgLbzkeGH7jGOqDvWazEmiyAzxPEXN
         HOXn2bdQRnFFlnJUMCqgw4px9COwSYMyn3YVtfmzMWvKtYBIfUSMShHDLtLIFs/2YTUR
         ZIlb/4bJS9MEL7swsNJzi4YAZKTAsbO10KC0Ds2cNLC22Pg9HmCMPpjEwtsK0gp8xNc3
         mZO89Ov6XW97TbXx3Qad8uCoGve6ai+6KRHCABfhvY1sO8p+sNfAEeAPFhpBXQq5q71+
         Ao9iCqyyDHst/xqAqkZjIbwaUW4f94Yk0iTSASX0LtcD2fSwJLyo8HMt+YM3EG3m5HrO
         XxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681176578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBCdWjTPDV7u7tywdkOEhqA30FFTo51cVFS76tLVdIk=;
        b=L0GPfjPaCM8lrxyzeofhaIRROoYg8ryEyy8Zm7qKFD4wmwpYJfpadzfcl0274QgXEP
         SV2qEZFtp3k4N2M8LIAWFt7CWo6IbmwfIKLOuH6+g58j+g3o4sbA5lopWujNYMX6vUmz
         dWRoKjkgvq+e4MOC1ZOg1dWKqaebt9ietdQOvjwOdJhqykk4KPnivpdx8/3GnsUtMIMA
         nMlfQcZfSWbYT5HqJHvfQliieVm0mqOp/MsGcFLTtuOOZpP4VO2WeS/iW2aboRDs4APy
         uIYvBbgW7uLvwwwBv9YfBYpZQqPX7KbBO6JlGAjfsshyBcQv7b4aP7W84LgKH17Ual6z
         XxcQ==
X-Gm-Message-State: AAQBX9f1w/kW4aoUGC3ZOEtQyFOCPd2QGRGsEq/QSm9/PGvN+0KYwbe8
        J+b1MeSTH4deWz8SJEmU7BAC26nm8ZgVGD0low==
X-Google-Smtp-Source: AKy350aUc53Va1zkms/tZeMPTaKwPOXFpbnBKZFuGedztjHPQD03PotiB50/sPjZNhzfTmekJxf45Wmqylq6+Y7Cgw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:a1b:b0:62d:dade:825 with SMTP
 id p27-20020a056a000a1b00b0062ddade0825mr6152408pfh.3.1681176578151; Mon, 10
 Apr 2023 18:29:38 -0700 (PDT)
Date:   Tue, 11 Apr 2023 01:29:32 +0000
In-Reply-To: <cover.1681176340.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1681176340.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <ef48935e5e6f947f6f0c6d748232b14ef5d5ad70.1681176340.git.ackerleytng@google.com>
Subject: [RFC PATCH v4 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By default, the backing shmem file for a restrictedmem fd is created
on shmem's kernel space mount.

With this patch, an optional tmpfs mount can be specified via an fd,
which will be used as the mountpoint for backing the shmem file
associated with a restrictedmem fd.

This will help restrictedmem fds inherit the properties of the
provided tmpfs mounts, for example, hugepage (THP) allocation hints,
NUMA binding hints, etc.

Permissions for the fd passed to memfd_restricted() is modeled after
the openat() syscall, since both of these allow creation of a file
upon a mount/directory.

Permission to reference the mount the fd represents is checked upon fd
creation by other syscalls (e.g. fsmount(), open(), or open_tree(),
etc) and any process that can present memfd_restricted() with a valid
fd is expected to have obtained permission to use the mount
represented by the fd. This behavior is intended to parallel that of
the openat() syscall.

memfd_restricted() will check that the tmpfs superblock is
writable, and that the mount is also writable, before attempting to
create a restrictedmem file on the mount.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/syscalls.h           |  2 +-
 include/uapi/linux/restrictedmem.h |  8 ++++
 mm/restrictedmem.c                 | 73 ++++++++++++++++++++++++++++--
 3 files changed, 77 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/restrictedmem.h

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 660be0bf89d5..90c73b9e14e5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1058,7 +1058,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
-asmlinkage long sys_memfd_restricted(unsigned int flags);
+asmlinkage long sys_memfd_restricted(unsigned int flags, int mount_fd);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/restrictedmem.h b/include/uapi/linux/restrictedmem.h
new file mode 100644
index 000000000000..73e31bce73dc
--- /dev/null
+++ b/include/uapi/linux/restrictedmem.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_RESTRICTEDMEM_H
+#define _UAPI_LINUX_RESTRICTEDMEM_H
+
+/* flags for memfd_restricted */
+#define MEMFD_RSTD_USERMNT		0x0001U
+
+#endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index 55e99e6c09a1..032ad1f15138 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -6,6 +6,7 @@
 #include <linux/syscalls.h>
 #include <uapi/linux/falloc.h>
 #include <uapi/linux/magic.h>
+#include <uapi/linux/restrictedmem.h>
 #include <linux/restrictedmem.h>
 
 struct restrictedmem {
@@ -250,19 +251,20 @@ static struct address_space_operations restricted_aops = {
 #endif
 };
 
-SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
+static int restrictedmem_create(struct vfsmount *mount)
 {
 	struct file *file, *restricted_file;
 	int fd, err;
 
-	if (flags)
-		return -EINVAL;
-
 	fd = get_unused_fd_flags(0);
 	if (fd < 0)
 		return fd;
 
-	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
+	if (mount)
+		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0, VM_NORESERVE);
+	else
+		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
+
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		goto err_fd;
@@ -286,6 +288,67 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
 	return err;
 }
 
+static struct vfsmount *restrictedmem_get_user_mount(struct file *file)
+{
+	int ret;
+	struct vfsmount *mnt;
+	struct path *path;
+
+	path = &file->f_path;
+	if (path->dentry != path->mnt->mnt_root)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Disallow bind-mounts that aren't bind-mounts of the whole
+	 * filesystem
+	 */
+	mnt = path->mnt;
+	if (mnt->mnt_root != mnt->mnt_sb->s_root)
+		return ERR_PTR(-EINVAL);
+
+	if (mnt->mnt_sb->s_magic != TMPFS_MAGIC)
+		return ERR_PTR(-EINVAL);
+
+	ret = mnt_want_write(mnt);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return mnt;
+}
+
+SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
+{
+	int ret;
+	struct fd f = {};
+	struct vfsmount *mnt = NULL;
+
+	if (flags & ~MEMFD_RSTD_USERMNT)
+		return -EINVAL;
+
+	if (flags & MEMFD_RSTD_USERMNT) {
+		f = fdget_raw(mount_fd);
+		if (!f.file)
+			return -EBADF;
+
+		mnt = restrictedmem_get_user_mount(f.file);
+		if (IS_ERR(mnt)) {
+			ret = PTR_ERR(mnt);
+			goto out;
+		}
+	}
+
+	ret = restrictedmem_create(mnt);
+
+	if (mnt)
+		mnt_drop_write(mnt);
+
+out:
+	if (f.file)
+		fdput(f);
+
+	return ret;
+}
+
 int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
 		       struct restrictedmem_notifier *notifier, bool exclusive)
 {
-- 
2.40.0.577.gac1e443424-goog

