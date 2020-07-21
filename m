Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614F722854C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgGUQ2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgGUQ23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8140C061794;
        Tue, 21 Jul 2020 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OcSSjx97fwoZC4nhn07d+eqA+7PeJMhHbLVmJrKte/4=; b=RCKVwb23G5tMsdVaSYXYEn8cRi
        gapiaPvQDrM0STAn+lc5PvvrmQfo/UKf+CMmkO37ePt8WB+q6btgK3J4pyOBBWXS1KQbJFWu6ddFh
        RoEQm1SRh1ul6mOB7vW4KESKzhKb+GqoGcCXTDBPIxrEC3Kq9qFSuJjlBXAmP+xGPbhGdCuLdVUvB
        R8FKGYYLzL1+pFy2VXA0UOSSHN65PkM52yhfOzuL+U8uhIDYoHGyRnkM87hJcfI4nglMlHN4kd432
        VUOf1TbMNf8zz87QyOYcBcZe3v0d7RHqB4hNJFr9zOtluBuLHp19FyTAlHcQPm/Gq53oZw/xECTAa
        3GTIrdbw==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv7y-0007S1-0t; Tue, 21 Jul 2020 16:28:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 05/24] devtmpfs: open code ksys_chdir and ksys_chroot
Date:   Tue, 21 Jul 2020 18:27:59 +0200
Message-Id: <20200721162818.197315-6-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

devtmpfs is the only non-early init caller of ksys_chdir and ksys_chroot
with kernel pointers.  Just open code the two operations which only
really need a single path lookup anyway in devtmpfs_setup instead.
The open coded verson doesn't need any of the stale dentry revalidation
logic from the full blown version as those can't happen on tmpfs and
ramfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/devtmpfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 5e8d677ee783bc..f798d3976b4052 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/fs_struct.h>
 #include <uapi/linux/mount.h>
 #include "base.h"
 
@@ -393,6 +394,7 @@ static int handle(const char *name, umode_t mode, kuid_t uid, kgid_t gid,
 
 static int devtmpfs_setup(void *p)
 {
+	struct path path;
 	int err;
 
 	err = ksys_unshare(CLONE_NEWNS);
@@ -401,8 +403,16 @@ static int devtmpfs_setup(void *p)
 	err = devtmpfs_do_mount("/");
 	if (err)
 		goto out;
-	ksys_chdir("/.."); /* will traverse into overmounted root */
-	ksys_chroot(".");
+
+	/* traverse into overmounted root and then chroot to it */
+	if (!kern_path("/..", LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path) &&
+	    !inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR) &&
+	    ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
+	    !security_path_chroot(&path)) {
+		set_fs_pwd(current->fs, &path);
+		set_fs_root(current->fs, &path);
+	}
+	path_put(&path);
 out:
 	*(int *)p = err;
 	complete(&setup_done);
-- 
2.27.0

