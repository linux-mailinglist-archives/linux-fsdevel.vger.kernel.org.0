Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1AD1794A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgCDQMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:12:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:35594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDQMt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:12:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B028CAD2A;
        Wed,  4 Mar 2020 16:12:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] vfs: Remove duplicated d_mountpoint check in __is_local_mountpoint
Date:   Wed,  4 Mar 2020 18:12:45 +0200
Message-Id: <20200304161245.27122-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function acts as an out-of-line helper for is_local_mountpoint
is only called after the latter verifies the dentry is not a mountpoint.
There's no semantic changes and the resulting object code is smaller:

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-26 (-26)
Function                                     old     new   delta
__is_local_mountpoint                        147     121     -26
Total: Before=34161, After=34135, chg -0.08%

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
Al,

I experimented with adding likely in the inline helper but this didn't change the
generated code for me so simply removing the check is sufficient.

 fs/namespace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7bea82e..07b5fbe513ec 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -669,9 +669,6 @@ bool __is_local_mountpoint(struct dentry *dentry)
 	struct mount *mnt;
 	bool is_covered = false;

-	if (!d_mountpoint(dentry))
-		goto out;
-
 	down_read(&namespace_sem);
 	list_for_each_entry(mnt, &ns->list, mnt_list) {
 		is_covered = (mnt->mnt_mountpoint == dentry);
@@ -679,7 +676,7 @@ bool __is_local_mountpoint(struct dentry *dentry)
 			break;
 	}
 	up_read(&namespace_sem);
-out:
+
 	return is_covered;
 }

--
2.17.1

