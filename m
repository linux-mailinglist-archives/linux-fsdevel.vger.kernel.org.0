Return-Path: <linux-fsdevel+bounces-31237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F24993543
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CAB2849BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B41DDC22;
	Mon,  7 Oct 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dnTy4vDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC391DDA08
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323043; cv=none; b=gA1Ldocfsg1RFhj53gbmFvBi5DcL+CDZ+HwiieoX4oqRfB5wtKmPYKOvdFaZlmfoSeo5oKMuejYwpr5rjE8beRoxh8Jtf2PSnYH1To9WIzGzoo1I9W7uZuAA/6zAEk61DkwTGTjHrHtsSc60tZYrYSBkm1rbONcj0hXKPVOM+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323043; c=relaxed/simple;
	bh=YSKlppPkVarwDGc/JLuKJeR3UiL8Yqq0Pfh/FNvDpjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYYp3KmFRXK1QcwAJmacAkqpt/36+d8K3V1D93qdWjTMMMoVaZKkw054qLjQP5MFk/KRWohGRIdmQhHUMFSWuKa44c5K3tlM5Hg6OU1sj83KcuLoITN7o84nN0+gUHKhXvpiF4UhPvAbqcs6PB36m65KRvbUcZxmgg4kqIq+NaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dnTy4vDu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fUe7R4Y3PT6rWhXJr9WFW1kE6NvhktotQteo14XCKuc=; b=dnTy4vDuh36qrBOqd8YGygquKt
	j7XIU2vTif9uIfigIVV0xSAJxOyhhfWPGjInDeTy8qepEisnOVcTG6hb9Gkbhc+9SSpYa736ZjMo8
	9vAeujvIWY0a9pt0HufFUtuUIGWy9hEN/+hHJMBdwFjkLm/5VpvW6K4agq10+rNnfOb3mhOJmmB7C
	Z48JsIbapvUe8INWCrJjcJ2nQNPeP0HC4+eI1d3C58G069NveduRlmWdnafokPCFjByuFnFwkChbK
	9j0JyVauhPheuRfZudoOnCLFr1mtEf5109X9EJgVHl3YLoL8Nrf1Sn2EqbUN4dWlti+Crj2uR3ky7
	LU6OK9Fg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrm2-00000001f35-4BM0;
	Mon, 07 Oct 2024 17:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH v3 02/11] remove pointless includes of <linux/fdtable.h>
Date: Mon,  7 Oct 2024 18:43:49 +0100
Message-ID: <20241007174358.396114-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007174358.396114-1-viro@zeniv.linux.org.uk>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

some of those used to be needed, some had been cargo-culted for
no reason...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fcntl.c                         | 1 -
 fs/file_table.c                    | 1 -
 fs/notify/fanotify/fanotify.c      | 1 -
 fs/notify/fanotify/fanotify_user.c | 1 -
 fs/overlayfs/copy_up.c             | 1 -
 fs/proc/base.c                     | 1 -
 io_uring/io_uring.c                | 1 -
 kernel/bpf/bpf_inode_storage.c     | 1 -
 kernel/bpf/bpf_task_storage.c      | 1 -
 kernel/bpf/token.c                 | 1 -
 kernel/exit.c                      | 1 -
 kernel/module/dups.c               | 1 -
 kernel/module/kmod.c               | 1 -
 kernel/umh.c                       | 1 -
 net/handshake/request.c            | 1 -
 security/apparmor/domain.c         | 1 -
 16 files changed, 16 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 22dd9dcce7ec..8928874c8a2e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -12,7 +12,6 @@
 #include <linux/fs.h>
 #include <linux/filelock.h>
 #include <linux/file.h>
-#include <linux/fdtable.h>
 #include <linux/capability.h>
 #include <linux/dnotify.h>
 #include <linux/slab.h>
diff --git a/fs/file_table.c b/fs/file_table.c
index eed5ffad9997..9e46fd4336b0 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -9,7 +9,6 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/file.h>
-#include <linux/fdtable.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs.h>
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 224bccaab4cc..24c7c5df4998 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fanotify.h>
-#include <linux/fdtable.h>
 #include <linux/fsnotify_backend.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9644bc72e457..61b83039771e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fanotify.h>
 #include <linux/fcntl.h>
-#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/anon_inodes.h>
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 2ed6ad641a20..ee2cbd044ce6 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -16,7 +16,6 @@
 #include <linux/sched/signal.h>
 #include <linux/cred.h>
 #include <linux/namei.h>
-#include <linux/fdtable.h>
 #include <linux/ratelimit.h>
 #include <linux/exportfs.h>
 #include "overlayfs.h"
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b31283d81c52..e9d7ddc52f69 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -58,7 +58,6 @@
 #include <linux/init.h>
 #include <linux/capability.h>
 #include <linux/file.h>
-#include <linux/fdtable.h>
 #include <linux/generic-radix-tree.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index b2736e3491b8..5a1676bab998 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -51,7 +51,6 @@
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
 #include <linux/file.h>
-#include <linux/fdtable.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/percpu.h>
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 29da6d3838f6..e16e79f8cd6d 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -16,7 +16,6 @@
 #include <uapi/linux/btf.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
-#include <linux/fdtable.h>
 #include <linux/rcupdate_trace.h>
 
 DEFINE_BPF_STORAGE_CACHE(inode_cache);
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index adf6dfe0ba68..1eb9852a9f8e 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -16,7 +16,6 @@
 #include <linux/filter.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
-#include <linux/fdtable.h>
 #include <linux/rcupdate_trace.h>
 
 DEFINE_BPF_STORAGE_CACHE(task_cache);
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index dcbec1a0dfb3..26057aa13503 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -1,6 +1,5 @@
 #include <linux/bpf.h>
 #include <linux/vmalloc.h>
-#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..1dcddfe537ee 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -25,7 +25,6 @@
 #include <linux/acct.h>
 #include <linux/tsacct_kern.h>
 #include <linux/file.h>
-#include <linux/fdtable.h>
 #include <linux/freezer.h>
 #include <linux/binfmts.h>
 #include <linux/nsproxy.h>
diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 9a92f2f8c9d3..bd2149fbe117 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -18,7 +18,6 @@
 #include <linux/completion.h>
 #include <linux/cred.h>
 #include <linux/file.h>
-#include <linux/fdtable.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
 #include <linux/mount.h>
diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index 0800d9891692..25f253812512 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -15,7 +15,6 @@
 #include <linux/completion.h>
 #include <linux/cred.h>
 #include <linux/file.h>
-#include <linux/fdtable.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
 #include <linux/mount.h>
diff --git a/kernel/umh.c b/kernel/umh.c
index ff1f13a27d29..be9234270777 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -13,7 +13,6 @@
 #include <linux/completion.h>
 #include <linux/cred.h>
 #include <linux/file.h>
-#include <linux/fdtable.h>
 #include <linux/fs_struct.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 94d5cef3e048..274d2c89b6b2 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/inet.h>
-#include <linux/fdtable.h>
 #include <linux/rhashtable.h>
 
 #include <net/sock.h>
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 571158ec6188..2bc34dce9a46 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/errno.h>
-#include <linux/fdtable.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/mount.h>
-- 
2.39.5


