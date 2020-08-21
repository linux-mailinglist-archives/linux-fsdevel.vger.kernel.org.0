Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B924D141
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 11:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHUJPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 05:15:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53427 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725806AbgHUJPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598001317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UCpFanxaYkwVEZw78JX8DlEMrUVKJsVXAdjpgnuqQek=;
        b=SXb0x+OwXO4hDJQffFass7/qTarVXOCbuGp7th9Xtvx/IfVwABH3iqKVrHO71nRl5AElV4
        HYyGWBZ5fDz8gMwuPG3FV8jzbtz2GvDquGGClDr8WBgaQ968L6dlPA7QTzwrjJAOP2yE7v
        NvmdiBmzCOjfHa0uYXyYoFbmbZxQ6Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-eW0R-OfLPa-FAYTRpw9SDg-1; Fri, 21 Aug 2020 05:15:15 -0400
X-MC-Unique: eW0R-OfLPa-FAYTRpw9SDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F1941007461;
        Fri, 21 Aug 2020 09:15:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06FBE10013C2;
        Fri, 21 Aug 2020 09:15:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix NULL deref in afs_dynroot_depopulate()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     syzbot+c1eff8205244ae7e11a6@syzkaller.appspotmail.com,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Aug 2020 10:15:12 +0100
Message-ID: <159800131226.3756136.4803067554522494205.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an error occurs during the construction of an afs superblock, it's
possible that an error occurs after a superblock is created, but before
we've created the root dentry.  If the superblock has a dynamic root
(ie. what's normally mounted on /afs), the afs_kill_super() will call
afs_dynroot_depopulate() to unpin any created dentries - but this will oops
if the root hasn't been created yet.

Fix this by skipping that bit of code if there is no root dentry.

This leads to an oops looking like:

	general protection fault, ...
	KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
	...
	RIP: 0010:afs_dynroot_depopulate+0x25f/0x529 fs/afs/dynroot.c:385
	...
	Call Trace:
	 afs_kill_super+0x13b/0x180 fs/afs/super.c:535
	 deactivate_locked_super+0x94/0x160 fs/super.c:335
	 afs_get_tree+0x1124/0x1460 fs/afs/super.c:598
	 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
	 do_new_mount fs/namespace.c:2875 [inline]
	 path_mount+0x1387/0x2070 fs/namespace.c:3192
	 do_mount fs/namespace.c:3205 [inline]
	 __do_sys_mount fs/namespace.c:3413 [inline]
	 __se_sys_mount fs/namespace.c:3390 [inline]
	 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
	 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
	 entry_SYSCALL_64_after_hwframe+0x44/0xa9

which is oopsing on this line:

	inode_lock(root->d_inode);

presumably because sb->s_root was NULL.

Fixes: 0da0b7fd73e4 ("afs: Display manually added cells in dynamic root mount")
Reported-by: syzbot+c1eff8205244ae7e11a6@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dynroot.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index b79879aacc02..7b784af604fd 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -382,15 +382,17 @@ void afs_dynroot_depopulate(struct super_block *sb)
 		net->dynroot_sb = NULL;
 	mutex_unlock(&net->proc_cells_lock);
 
-	inode_lock(root->d_inode);
-
-	/* Remove all the pins for dirs created for manually added cells */
-	list_for_each_entry_safe(subdir, tmp, &root->d_subdirs, d_child) {
-		if (subdir->d_fsdata) {
-			subdir->d_fsdata = NULL;
-			dput(subdir);
+	if (root) {
+		inode_lock(root->d_inode);
+
+		/* Remove all the pins for dirs created for manually added cells */
+		list_for_each_entry_safe(subdir, tmp, &root->d_subdirs, d_child) {
+			if (subdir->d_fsdata) {
+				subdir->d_fsdata = NULL;
+				dput(subdir);
+			}
 		}
-	}
 
-	inode_unlock(root->d_inode);
+		inode_unlock(root->d_inode);
+	}
 }


