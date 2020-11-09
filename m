Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9DE2AB01C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 05:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgKIEAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 23:00:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728038AbgKIEAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604894438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Z+cwdAAPnpskL0iuQ5kmNmib1PUdkspQ4c49HCBuxsU=;
        b=fvTKmH3s5xS+QCZKD/n8N98FXipnsCxu+ehTpoW4/WgNMsKR+/5l5aBNQi3S+RXHxzMlzK
        w7/n9Jhpnqya4Igp6lS/Ns3CLAaTaJRudRIJvVEBEKd3ifPP06pblYGg2rkgOolhpTcAEp
        7jkVmHlxaNlj7N04L7PjxX2n/FIUe2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-MmbR6InWP6mUQ893suAqXg-1; Sun, 08 Nov 2020 23:00:34 -0500
X-MC-Unique: MmbR6InWP6mUQ893suAqXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DE661007460;
        Mon,  9 Nov 2020 04:00:33 +0000 (UTC)
Received: from llong.com (ovpn-113-56.rdu2.redhat.com [10.10.113.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80E7D5B4D0;
        Mon,  9 Nov 2020 04:00:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca BRUNO <lucab@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4] inotify: Increase default inotify.max_user_watches limit to 1048576
Date:   Sun,  8 Nov 2020 22:59:31 -0500
Message-Id: <20201109035931.4740-1-longman@redhat.com>
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
be watched. It also pins the watched inode.

Modeled after the epoll.max_user_watches behavior to adjust the default
value according to the amount of addressable memory available, make
inotify.max_user_watches behave in a similar way to make it use no more
than 1% of addressable memory within the range [8192, 1048576].

For 64-bit archs, inotify_inode_mark plus 2 vfs inode have a size that
is a bit over 1 kbytes (1284 bytes with my x86-64 config).  That means
a system with 128GB or more memory will likely have the maximum value
of 1048576 for inotify.max_user_watches. This default should be big
enough for most use cases.

[v3: increase inotify watch cost as suggested by Amir and Honza]

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/notify/inotify/inotify_user.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 186722ba3894..24d17028375e 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -37,6 +37,15 @@
 
 #include <asm/ioctls.h>
 
+/*
+ * An inotify watch requires allocating an inotify_inode_mark structure as
+ * well as pinning the watched inode. Doubling the size of a VFS inode
+ * should be more than enough to cover the additional filesystem inode
+ * size increase.
+ */
+#define INOTIFY_WATCH_COST	(sizeof(struct inotify_inode_mark) + \
+				 2 * sizeof(struct inode))
+
 /* configurable via /proc/sys/fs/inotify/ */
 static int inotify_max_queued_events __read_mostly;
 
@@ -801,6 +810,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
  */
 static int __init inotify_user_setup(void)
 {
+	unsigned long watches_max;
+	struct sysinfo si;
+
+	si_meminfo(&si);
+	/*
+	 * Allow up to 1% of addressable memory to be allocated for inotify
+	 * watches (per user) limited to the range [8192, 1048576].
+	 */
+	watches_max = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
+			INOTIFY_WATCH_COST;
+	watches_max = clamp(watches_max, 8192UL, 1048576UL);
+
 	BUILD_BUG_ON(IN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(IN_MODIFY != FS_MODIFY);
 	BUILD_BUG_ON(IN_ATTRIB != FS_ATTRIB);
@@ -827,7 +848,7 @@ static int __init inotify_user_setup(void)
 
 	inotify_max_queued_events = 16384;
 	init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
-	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = 8192;
+	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = watches_max;
 
 	return 0;
 }
-- 
2.18.1

