Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE98C8F5BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 22:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfHOU1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 16:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfHOU1V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:27:21 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3596B2083B;
        Thu, 15 Aug 2019 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565900840;
        bh=J7tGq4AAz4tgbrVras0rrb273H7txqt0QOfmCl0z89M=;
        h=From:To:Cc:Subject:Date:From;
        b=wZT7/y1E/PjvM56TUXiqq7V5lJE5EXmIBAPbCOpjF5eVr7J1kIBKaj0tCPJuI3Dfi
         /s2BFtLtKeWrhL1Z1m9xNKCZVGcWqfcrwZAI5dmfjX9SpbZ7s9frBpFaY++6+3iVI4
         089Q30Pmve4gzkB5J1Rw7hETvUc05h6yYcdlLluo=
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, jack@suse.cz, viro@zeniv.linux.org.uk
Subject: [PATCH] locks: print a warning when mount fails due to lack of "mand" support
Date:   Thu, 15 Aug 2019 16:27:18 -0400
Message-Id: <20190815202718.18595-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since 9e8925b67a ("locks: Allow disabling mandatory locking at compile
time"), attempts to mount filesystems with "-o mand" will fail.
Unfortunately, there is no other indiciation of the reason for the
failure.

Change how the function is defined for better readability. When
CONFIG_MANDATORY_FILE_LOCKING is disabled, printk a warning when
someone attempts to mount with -o mand.

Also, add a blurb to the mandatory-locking.txt file to explain about
the "mand" option, and the behavior one should expect when it is
disabled.

Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/mandatory-locking.txt | 10 ++++++++++
 fs/namespace.c                                  | 11 ++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/mandatory-locking.txt b/Documentation/filesystems/mandatory-locking.txt
index 0979d1d2ca8b..a251ca33164a 100644
--- a/Documentation/filesystems/mandatory-locking.txt
+++ b/Documentation/filesystems/mandatory-locking.txt
@@ -169,3 +169,13 @@ havoc if they lock crucial files. The way around it is to change the file
 permissions (remove the setgid bit) before trying to read or write to it.
 Of course, that might be a bit tricky if the system is hung :-(
 
+7. The "mand" mount option
+--------------------------
+Mandatory locking is disabled on all filesystems by default, and must be
+administratively enabled by mounting with "-o mand". That mount option
+is only allowed if the mounting task has the CAP_SYS_ADMIN capability.
+
+Since kernel v4.5, it is possible to disable mandatory locking
+altogether by setting CONFIG_MANDATORY_FILE_LOCKING to "n". A kernel
+with this disabled will reject attempts to mount filesystems with the
+"mand" mount option with the error status EPERM.
diff --git a/fs/namespace.c b/fs/namespace.c
index 6464ea4acba9..602bd78ba572 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1643,13 +1643,18 @@ static inline bool may_mount(void)
 	return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
+#ifdef	CONFIG_MANDATORY_FILE_LOCKING
 static inline bool may_mandlock(void)
 {
-#ifndef	CONFIG_MANDATORY_FILE_LOCKING
-	return false;
-#endif
 	return capable(CAP_SYS_ADMIN);
 }
+#else
+static inline bool may_mandlock(void)
+{
+	pr_warn("VFS: \"mand\" mount option not supported");
+	return false;
+}
+#endif
 
 /*
  * Now umount can handle mount points as well as block devices.
-- 
2.21.0

