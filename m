Return-Path: <linux-fsdevel+bounces-26587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C0395A8B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999E6281ECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496310A1C;
	Thu, 22 Aug 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nJOFRe79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64F3FC2
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286174; cv=none; b=iV0zJ74p0CuX4zcaH1d/q0pDJ39DX4VWtyjc3yYhkqXCet7SZTtA65f3j8XvbZ/RZhhqKyacQepAvqT/BRdFZYxHuXOoPYFKFFCk9lUCs3a4GKKSJIYWwND5lR6R3AIL8juxVbmOsb1qBcU/8A9SQnrinTkj7HX3cN/h4/51+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286174; c=relaxed/simple;
	bh=N8hncRBpNrK8c6/8Cd8KjQNfbH+c0Tuuz+AHToCyavQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkQleNW7kMclMW6HoCVDbM0taDQK/4JtZhIyiX5fCm9ceJFawR2Zp60dnxbeqNhTue3wZo4H0UqOsNiCdAsYgx3+q/9JzEXdeXH4WCsf3/BAsR7QqRHqJoJESILKM9Ro1680pGCxvP4OCAsFwFFneLQF9qPqIGJrhies2DFV0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nJOFRe79; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NL0v1YLxYGqNOvNcRhk7CqC99tnFK8AKg4bcf5w4taQ=; b=nJOFRe79k9zERmGG4cNbXixo3H
	+8I27m2qFG1vlSlmB1bZYhV/uYvkkvTJFYsaNyL2IYEl7dbipB0BftTMkSuEFGqb/Y5uvOscW5cz0
	Xd83YSdqhN5BxEx8TzlgeCFsP938jiDTSq7XkiVi3JWub1fwSAfltJ10cjrnkHeU+qUDDom/0p8sU
	MapEjFXmVsTz+r50lKWflWGhWHKmvTYzDc8wRtcaPPzv2s4cj7gXI0Y4KpRu2M7Ql9wyhIzJDTvBv
	QTm4UC0XCGu4a1gQ3ILsGizcGSCVB55scglQG4Yq4wzpPimoHQ/jbVGli3Yv6qP8f3wsbW7QMzqrI
	6wic2s0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbG-00000003w7b-2pTd;
	Thu, 22 Aug 2024 00:22:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 03/12] remove pointless includes of <linux/fdtable.h>
Date: Thu, 22 Aug 2024 01:22:41 +0100
Message-ID: <20240822002250.938396-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
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
index 300e5d9ad913..56262bdbc544 100644
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
index ca7843dde56d..15adc085df4f 100644
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
index 9ec313e9f6e1..cc91977cf202 100644
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
index a5ef2005a2cc..73b502524d1c 100644
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
index 72a1acd03675..d4ecad2b0a2e 100644
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
index 3942db160f18..0b4be6d5edaf 100644
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
index b0ef45db207c..f8b97d8a874a 100644
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
index d6ccf8d00eab..3ea6a7505662 100644
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
index 7430852a8571..d441193a4537 100644
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
2.39.2


