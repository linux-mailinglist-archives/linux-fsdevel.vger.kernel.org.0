Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C675229F05C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 16:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgJ2PqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 11:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbgJ2PqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603986367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aZLvO3nbOlkXX/aM7Y/NB8twNOJTe+bO3XbdsHV0Mgw=;
        b=aufhR5QM9VXYiIPnhmthrlqu+fSiYl1drxkWYk55/xdegqMdOwYByy3Y7B6+noj+w8WrHf
        epoYAqwRATk+02wS4gKuRrF01Rn2ZJpUW9BvlOG27q0aTAuInJyoTHAeISwGWLum/ZVNTs
        KD+GoUfPMaB+SYiaHSTRMfiUWi4ilW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-JWRKCyrPMGiGHv9J8shMMw-1; Thu, 29 Oct 2020 11:46:03 -0400
X-MC-Unique: JWRKCyrPMGiGHv9J8shMMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE2EA186DD24;
        Thu, 29 Oct 2020 15:46:00 +0000 (UTC)
Received: from llong.com (ovpn-116-17.rdu2.redhat.com [10.10.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9CC25B4B9;
        Thu, 29 Oct 2020 15:45:53 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca BRUNO <lucab@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] inotify: Increase default inotify.max_user_watches limit to 1048576
Date:   Thu, 29 Oct 2020 11:45:35 -0400
Message-Id: <20201029154535.2074-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The default value of inotify.max_user_watches sysctl parameter was set
to 8192 since the introduction of the inotify feature in 2005 by
commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
small for many modern usage. As a result, users have to explicitly set
it to a larger value to make it work.

After some searching around the web, these are the
inotify.max_user_watches values used by some projects:
 - vscode:  524288
 - dropbox support: 100000
 - users on stackexchange: 12228
 - lsyncd user: 2000000
 - code42 support: 1048576
 - monodevelop: 16384
 - tectonic: 524288
 - openshift origin: 65536

Each watch point adds an inotify_inode_mark structure to an inode to
be watched. It also pins the watched inode as well as an inotify fdinfo
procfs file.

Modeled after the epoll.max_user_watches behavior to adjust the default
value according to the amount of addressable memory available, make
inotify.max_user_watches behave in a similar way to make it use no more
than 1% of addressable memory within the range [8192, 1048576].

For 64-bit archs, inotify_inode_mark plus 2 inode have a size close
to 2 kbytes. That means a system with 196GB or more memory should have
the maximum value of 1048576 for inotify.max_user_watches. This default
should be big enough for most use cases.

With my x86-64 config, the size of xfs_inode, proc_inode and
inotify_inode_mark is 1680 bytes. The estimated INOTIFY_WATCH_COST is
1760 bytes.

[v2: increase inotify watch cost as suggested by Amir and Honza]

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/notify/inotify/inotify_user.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 186722ba3894..37d9f09c226f 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -37,6 +37,16 @@
 
 #include <asm/ioctls.h>
 
+/*
+ * An inotify watch requires allocating an inotify_inode_mark structure as
+ * well as pinning the watched inode and adding inotify fdinfo procfs file.
+ * The increase in size of a filesystem inode versus a VFS inode varies
+ * depending on the filesystem. An extra 512 bytes is added as rough
+ * estimate of the additional filesystem inode cost.
+ */
+#define INOTIFY_WATCH_COST	(sizeof(struct inotify_inode_mark) + \
+				 2 * sizeof(struct inode) + 512)
+
 /* configurable via /proc/sys/fs/inotify/ */
 static int inotify_max_queued_events __read_mostly;
 
@@ -801,6 +811,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
  */
 static int __init inotify_user_setup(void)
 {
+	unsigned int watches_max;
+	struct sysinfo si;
+
+	si_meminfo(&si);
+	/*
+	 * Allow up to 1% of addressible memory to be allocated for inotify
+	 * watches (per user) limited to the range [8192, 1048576].
+	 */
+	watches_max = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
+			INOTIFY_WATCH_COST;
+	watches_max = min(1048576U, max(watches_max, 8192U));
+
 	BUILD_BUG_ON(IN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(IN_MODIFY != FS_MODIFY);
 	BUILD_BUG_ON(IN_ATTRIB != FS_ATTRIB);
@@ -827,7 +849,7 @@ static int __init inotify_user_setup(void)
 
 	inotify_max_queued_events = 16384;
 	init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
-	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = 8192;
+	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = watches_max;
 
 	return 0;
 }
-- 
2.18.1

