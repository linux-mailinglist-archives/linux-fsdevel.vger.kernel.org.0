Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB66C3B77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCUUQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCUUP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:15:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98763EC75
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 13:15:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a9-20020a170902b58900b0019e2eafafddso9318348pls.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679429744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SASYwsYhAQSqNIE6HUln5R808O00UDaM+ugmJxC1i6Y=;
        b=nkDLVeFOEtNHIk2/9xYa/CQ5Y+2ViSmqdwKS37RKpN9fN1MXmDMz1OU9puFW4g8bxR
         vii0vfViksMKRckdTjgGuQRIZo78lhmcmIzghCZBBHxvW/ndiQpVU4djvbvM+g/7wUMs
         +h4BMeKpfniUSkYQ2+iXYK1OzQ6Zixd18XxuCFovZYEJjKkL+JZVoFx8wgMxsnNIhhrW
         cwAnxft2O57Rn97HBOHm6iE115uNcFbAUa0j/WlnnPQnSn42zEaUa3fkNCQ6d75oG0jY
         i+hqkZSaarDOufSFczQvwQKpFfhRDRSFIn/93xiAf3T7ZrsK4NycMXJEfB2VVpheLbup
         9TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SASYwsYhAQSqNIE6HUln5R808O00UDaM+ugmJxC1i6Y=;
        b=ATUqup+Xgc0Au0VTs3EJfnyEtvWn0VRonlwvaI535KNgC9e07SjsKmB3+vmjT51nMf
         wkP86PfiBDWArSgJU9BbchB0+pJrm4x9D9ri7yLhsiQ+z5R3pI+AN2GpIdboxFdQi/Lp
         gjcP97/GQZFh5cQK0lZ/X+xI3Eaqya1eA3X252w7oL2LOrHErZ4M+k9Opg59sgOAa5A3
         XEvpVymUIQc4og3UBDSpk1czndIf0v9NQ4fmWbWuLYQeBBEINnNBfbdwdyfUZ86myDAk
         8RRp8jxrfMfMmnN/wdBJMR4MFFlnqpoK9ttfyD1AGD5rzAkyS1kuFP6OBC7TuNKMYQ1I
         NA1Q==
X-Gm-Message-State: AO0yUKVzq+X6XR8w3DKCFsdy3m70R/1UDZO3QixTdW4CcHuktDy2WQqx
        4b9fc0ElDo/BXxHAwezi8i6Ibpqj0EOAiOlF5A==
X-Google-Smtp-Source: AK7set/HvJzxMftd1uCLemfdr7EZh/avv/uPbf4VraKazWicqnhqmpj6db9AHljzqSRdUL4ivIO6IsbGNBTLA3WbfA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:b612:b0:1a0:51f7:7f5a with
 SMTP id b18-20020a170902b61200b001a051f77f5amr137446pls.13.1679429744410;
 Tue, 21 Mar 2023 13:15:44 -0700 (PDT)
Date:   Tue, 21 Mar 2023 20:15:32 +0000
In-Reply-To: <cover.1679428901.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1679428901.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <6e800e069c7fc400841b75ea49d1227bd101c1cf.1679428901.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 1/2] mm: restrictedmem: Allow userspace to specify
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

This change is modeled after how sys_open() can create an unnamed
temporary file in a given directory with O_TMPFILE.

This will help restrictedmem fds inherit the properties of the
provided tmpfs mounts, for example, hugepage allocation hints, NUMA
binding hints, etc.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/syscalls.h           |  2 +-
 include/uapi/linux/restrictedmem.h |  8 ++++
 mm/restrictedmem.c                 | 63 +++++++++++++++++++++++++++---
 3 files changed, 66 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/restrictedmem.h

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f9e9e0c820c5..a23c4c385cd3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
-asmlinkage long sys_memfd_restricted(unsigned int flags);
+asmlinkage long sys_memfd_restricted(unsigned int flags, int mount_fd);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/restrictedmem.h b/include/uapi/linux/restrictedmem.h
new file mode 100644
index 000000000000..9f108dd1ac4c
--- /dev/null
+++ b/include/uapi/linux/restrictedmem.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_RESTRICTEDMEM_H
+#define _UAPI_LINUX_RESTRICTEDMEM_H
+
+/* flags for memfd_restricted */
+#define RMFD_TMPFILE		0x0001U
+
+#endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index c5d869d8c2d8..4d83b949d84e 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "linux/sbitmap.h"
+#include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/pseudo_fs.h>
 #include <linux/shmem_fs.h>
 #include <linux/syscalls.h>
 #include <uapi/linux/falloc.h>
 #include <uapi/linux/magic.h>
+#include <uapi/linux/restrictedmem.h>
 #include <linux/restrictedmem.h>
 
 struct restrictedmem {
@@ -189,19 +190,20 @@ static struct file *restrictedmem_file_create(struct file *memfd)
 	return file;
 }
 
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
@@ -223,6 +225,55 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
 	return err;
 }
 
+static bool is_shmem_mount(struct vfsmount *mnt)
+{
+	return mnt && mnt->mnt_sb && mnt->mnt_sb->s_magic == TMPFS_MAGIC;
+}
+
+static int restrictedmem_create_from_file(int mount_fd)
+{
+	int ret;
+	struct fd f;
+	struct vfsmount *mnt;
+
+	f = fdget_raw(mount_fd);
+	if (!f.file)
+		return -EBADF;
+
+	mnt = f.file->f_path.mnt;
+	if (!is_shmem_mount(mnt)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = mnt_want_write(mnt);
+	if (unlikely(ret))
+		goto out;
+
+	ret = restrictedmem_create(mnt);
+
+	mnt_drop_write(mnt);
+out:
+	fdput(f);
+
+	return ret;
+}
+
+SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
+{
+	if (flags & ~RMFD_TMPFILE)
+		return -EINVAL;
+
+	if (flags == RMFD_TMPFILE) {
+		if (mount_fd < 0)
+			return -EINVAL;
+
+		return restrictedmem_create_from_file(mount_fd);
+	} else {
+		return restrictedmem_create(NULL);
+	}
+}
+
 int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
 		       struct restrictedmem_notifier *notifier, bool exclusive)
 {
-- 
2.40.0.rc2.332.ga46443480c-goog

