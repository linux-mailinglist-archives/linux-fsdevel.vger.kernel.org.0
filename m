Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601CD299825
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 21:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgJZUot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 16:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJZUot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603745088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=JB8IelFUdHYx6FcbDlk23KKu8O+uAJKCTr7eR6lhytw=;
        b=LcBPIp5UBeAZWZwKtgMAsAoGWkKWpb6ZWcUEwMafGga3bD7tppQWcSU1roMx++hmjevEe1
        WaW1i3BdRt5Bvs7p0NV5vW+JUZKthBxYwbhI0NGzG8EvCELbPFUS1bM4mDXoTI0BywIOhY
        IepsaTzCJySzHMYlmOYuC+W1+HOHzGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-NE68nPDhMIuKJv3P-HnPdA-1; Mon, 26 Oct 2020 16:44:46 -0400
X-MC-Unique: NE68nPDhMIuKJv3P-HnPdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20BD0107B476;
        Mon, 26 Oct 2020 20:44:45 +0000 (UTC)
Received: from llong.com (ovpn-118-122.rdu2.redhat.com [10.10.118.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B08636EF46;
        Mon, 26 Oct 2020 20:44:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca BRUNO <lucab@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH] inotify: Increase default inotify.max_user_watches limit to 1048576
Date:   Mon, 26 Oct 2020 16:44:18 -0400
Message-Id: <20201026204418.23197-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Each watch point adds an inotify_inode_mark structure to an inode to be
watched. Modeled after the epoll.max_user_watches behavior to adjust the
default value according to the amount of addressable memory available,
make inotify.max_user_watches behave in a similar way to make it use
no more than 1% of addressable memory within the range [8192, 1048576].

For 64-bit archs, inotify_inode_mark should have a size of 80 bytes. That
means a system with 8GB or more memory will have the maximum value of
1048576 for inotify.max_user_watches. This default should be big enough
for most of the use cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/notify/inotify/inotify_user.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 186722ba3894..2da8b7a84b12 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -801,6 +801,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
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
+			sizeof(struct inotify_inode_mark);
+	watches_max = min(1048576U, max(watches_max, 8192U));
+
 	BUILD_BUG_ON(IN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(IN_MODIFY != FS_MODIFY);
 	BUILD_BUG_ON(IN_ATTRIB != FS_ATTRIB);
@@ -827,7 +839,7 @@ static int __init inotify_user_setup(void)
 
 	inotify_max_queued_events = 16384;
 	init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
-	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = 8192;
+	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = watches_max;
 
 	return 0;
 }
-- 
2.18.1

