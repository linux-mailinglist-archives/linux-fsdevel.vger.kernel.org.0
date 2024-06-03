Return-Path: <linux-fsdevel+bounces-20774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4168D7A95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 05:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6207B20E2B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1910962;
	Mon,  3 Jun 2024 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D121vgT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B058FBED
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717386801; cv=none; b=qw29gfVeTyeLUsNH52RTRmBvD42MwGuczfXfrUsnCWUSH9Fgg1x1fRhHt3KxEuHz3sKNvlTd4TbHowMQ1BVW63hSkNy3hWt6sIceTaO+1UNzoPQPFuPwFuUZz9YP1/viEZJ60H7TYn2dc/zTBev7r2zehW4b0YOpM41LAoy1cOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717386801; c=relaxed/simple;
	bh=2zp6IqV35Q9OxQ4ndzn0Shl0nPKp+sxZ/X/UE+DPhLo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X3mbjJGBpDhh/zD6S+Z5kHSJYlGngVCGSYZxgQlEUhlpuEW+42gheYKrJWFblSTGkvtj7Aw2K8kgJWPnD6stQ+tpHchxbs5d9uyIVyMU3Xxg0DEB2hnoKzwIZTo66DHaUF8jyQqMA1Uoz0Azl81EG7KC8Ae314AS/yaVRaCeOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D121vgT+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=r5vSD74z2699XYy56x0qv+P/5F74uIq7Vmsbwk6kRWI=; b=D121vgT+cVyYlf8gw0df9l/qsz
	rzkhmQp3MScqe7Dx6F17UjuQ55+xt0H584n37EV1mAQr5XP79UOJBE5IyztQzhEUUjGtJiZn0hciI
	eYW873OYVyfUHMgPU3YvU9lVhXuLaS+z4YFAGJddrbHwfPTOzjbWiuibYj2gpN326gII/gw4YYJZF
	PA5Po0WVp2I8fBCjAuag7Y8RMMFqkhHTlBhXrbjN+SJQa8xJdFJ+84n97EbR5hXg1aTrZ2C1nQ94b
	9x6je5ec9WvRxBMoY/Cf/bV0n+AMU8iEZz2W4dUBnnqJxYaSLxB6y1ZQ8gLGtzVYDfm+4l7PYkna0
	vOkgzwZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDyl2-00BM2G-2T
	for linux-fsdevel@vger.kernel.org;
	Mon, 03 Jun 2024 03:53:16 +0000
Date: Mon, 3 Jun 2024 04:53:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH] remove pointless includes of <linux/fdtable.h>
Message-ID: <20240603035316.GJ1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[in viro/vfs.git#work.misc; will be in for-next if nobody yells]

some of those used to be needed, some had been cargo-culted for
no reason...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
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
index 4f03beed4737..ff6397b7a2e7 100644
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
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 816e93e7f949..3dccffb5b641 100644
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
index f95a2c1338a8..3c09325bf80f 100644
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
index 598b3ffe1522..0c4b4ecc7916 100644
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

