Return-Path: <linux-fsdevel+bounces-25636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1290494E701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2D7282CA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB721534E6;
	Mon, 12 Aug 2024 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="v1PthMFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCD14C585
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445071; cv=none; b=PGWVjG1WWmKeiTn6xmMh2nSC69HQpQWLnErvL0nArhLZfXmzKdH4Kl4yhdpsPQ2ln4Ew9bG/gYJD1fzSKL8HWbATAdENGcPoh3LPpwll2nsEqIpLx33d11/kYtVgBDu6rsaAUkbPLVDlPouE5iftsCog/PuA5h9cEs+UlMCxAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445071; c=relaxed/simple;
	bh=85MePcVqBl1NN+297UkqVpTPY5RIYmY9q83bG9KpOG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2gRl8sTDuF7I9qYdpwFrxyW0qAMPEoHD7qqj+QJ0KXOvaJoK4dmPKhujI4gN9HBpFhI2vdeUHFAj1m0MNPhgKgHnQyxoHwcP/1CbM15WiOUCQo3ljrrf85LS9wmm/kiG4FVcgiLQ1kHhGMnE5bUKJ4NZ7Da3Fx64eB6fDRru1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=v1PthMFW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eYCys/js9QFJsuVAHMhWh06euzYWM0+Vx1YDZviUSTg=; b=v1PthMFWNfsjrxOqS5IE3INVvP
	MH/1PwVZAgnTB79Gf6ag4WCC7Uq2wc/AIHdWlV+R3qDaIiDvM4YAyw8CVjSrEhlzSrQsOr5t5agX2
	a8P0y86ZaC7CLn1/8gFbNHDuR/06BVjEYA9KcE7u087UPkDlksKICyOxMZryvoCKwFCBFp2Jxv8qF
	Fqj1aSUfJfHG+BC6T4GTuKsGQIN6k+7hZvjdRcz9Ku1Gb4YDme5jWvb+3A9BZX3sEwPyi//VhmmKm
	pIG+fabkdPDn0jAZrO/uywm7ypA90KL5sGAsrEEFRZ7eCesZOlDxgDroxaTkneqmc2rbtz6RkaVuS
	Y/OMsOCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn5-000000010UB-2GHl;
	Mon, 12 Aug 2024 06:44:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/11] remove pointless includes of <linux/fdtable.h>
Date: Mon, 12 Aug 2024 07:44:18 +0100
Message-ID: <20240812064427.240190-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812064427.240190-1-viro@zeniv.linux.org.uk>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
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


