Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07F2698960
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 01:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBPAln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 19:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPAlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:41:36 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1943456
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 16:41:34 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id k23-20020a63ff17000000b004fbb61bfcfeso144209pgi.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 16:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFJSOOgmL/+0yEbfXc6ryYjQyU1/3hcKBEe5blgULG8=;
        b=cINlnclit+qIhReE+Kd7SxHPyCpYVP+gHpr/lFZIYMsvtqPRMGMguGhZ+AmtA8dFRc
         Djw+CXsM0iFzwsMurICuBsTP1scpM+tCEPKY9d7bDxdD5YrTS/xTPWBYVcL8YG0s8lEx
         aufd0oD+1ETay2cKPepbBkhK2DjZdGGh9+sIqO+Vcbz+DiP+awtJagXFXVVgNQbNgyf4
         dLNAd50vYgR4BhTu4f/JtATvZK4wp3PfCPiwj0DiDlPx+B7yfpqr/PRhgYcbi/fNtz/R
         06dsNug5WVXeH5PztldqJP7IVZaS+IwS51Y4HyfEGNLXO726iXRISqbDJTUc9PcT6yga
         oL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFJSOOgmL/+0yEbfXc6ryYjQyU1/3hcKBEe5blgULG8=;
        b=gW3r+CyFJO0XU+q/FUMATA7SIeJ+96xe/WTmxiXYbbavsHbtwsmi2/+Un81fkwYMJs
         Si+dPSE80tQk+ysBV9P78iDu8hb2LN/eIIgIP/SZ3yYYBPBV+SfpHGMlIZfoZkL9agqj
         5embP+8ng8/09GPsKoQwVEQT+WyilnQcdkO4mEx+dG13RVd7nAF3iO3VQ2VMSc4x5slz
         nmT77quarN4cDejKb6pAtVQYr4wsSompDWR/Fm4qdBN5OJOfSnzggaGB5ymNiFOa7rKn
         MSN4782qdAjxEENDrvwAriPjV+q0rYtP8hOGSmyL7NfT3L1B7pSUyg2lhiQtjo5Gq6mF
         kwLQ==
X-Gm-Message-State: AO0yUKV2mthhA4ULFcbKGd2zBHUVSh2d356dEZ2kfVPUOzR0iosfQRkH
        bFdaESmgZ3zJ1YbCsFVl/sWjXRh9ypB0X7K5qg==
X-Google-Smtp-Source: AK7set92BIhFB8ochMzD8hkP3RpOuPg2nKV+W2zZrkSmVY9pLWldFkNDjP8CHQ6b9e/hAQ6o5kRRc8iwgxT607mX7Q==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a63:33ce:0:b0:4e7:79c5:d682 with SMTP
 id z197-20020a6333ce000000b004e779c5d682mr625417pgz.9.1676508094293; Wed, 15
 Feb 2023 16:41:34 -0800 (PST)
Date:   Thu, 16 Feb 2023 00:41:16 +0000
In-Reply-To: <cover.1676507663.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1676507663.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
Message-ID: <176081a4817e492965a864a8bc8bacb7d2c05078.1676507663.git.ackerleytng@google.com>
Subject: [RFC PATCH 1/2] mm: restrictedmem: Allow userspace to specify
 mount_path for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     chao.p.peng@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, corbet@lwn.net,
        dave.hansen@intel.com, david@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, luto@kernel.org, mail@maciej.szmigiero.name,
        mhocko@suse.com, michael.roth@amd.com, mingo@redhat.com,
        naoya.horiguchi@nec.com, pbonzini@redhat.com, qperret@google.com,
        rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
        steven.price@arm.com, tabba@google.com, tglx@linutronix.de,
        vannapurve@google.com, vbabka@suse.cz, vkuznets@redhat.com,
        wanpengli@tencent.com, wei.w.wang@intel.com, x86@kernel.org,
        yu.c.zhang@linux.intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By default, the backing shmem file for a restrictedmem fd is created
on shmem's kernel space mount.

With this patch, an optional tmpfs mount can be specified, which will
be used as the mountpoint for backing the shmem file associated with a
restrictedmem fd.

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
index f9e9e0c820c5..4b8efe9a8680 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
-asmlinkage long sys_memfd_restricted(unsigned int flags);
+asmlinkage long sys_memfd_restricted(unsigned int flags, const char __user *mount_path);
 
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
index c5d869d8c2d8..97f3e2159e8b 100644
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
+	return mnt->mnt_sb->s_magic == TMPFS_MAGIC;
+}
+
+static int restrictedmem_create_from_path(const char __user *mount_path)
+{
+	int ret;
+	struct path path;
+
+	ret = user_path_at(AT_FDCWD, mount_path,
+			   LOOKUP_FOLLOW | LOOKUP_MOUNTPOINT,
+			   &path);
+	if (ret)
+		return ret;
+
+	if (!is_shmem_mount(path.mnt)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = mnt_want_write(path.mnt);
+	if (unlikely(ret))
+		goto out;
+
+	ret = restrictedmem_create(path.mnt);
+
+	mnt_drop_write(path.mnt);
+out:
+	path_put(&path);
+
+	return ret;
+}
+
+SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, const char __user *, mount_path)
+{
+	if (flags & ~RMFD_TMPFILE)
+		return -EINVAL;
+
+	if (flags == RMFD_TMPFILE) {
+		if (!mount_path)
+			return -EINVAL;
+
+		return restrictedmem_create_from_path(mount_path);
+	} else {
+		return restrictedmem_create(NULL);
+	}
+}
+
 int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
 		       struct restrictedmem_notifier *notifier, bool exclusive)
 {
-- 
2.39.1.637.g21b0678d19-goog

