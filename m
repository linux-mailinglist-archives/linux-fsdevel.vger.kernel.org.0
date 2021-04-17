Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D84D362C4D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhDQAK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 20:10:57 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:42718 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhDQAK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:10:56 -0400
Received: by mail-pl1-f182.google.com with SMTP id v13so1213136ple.9;
        Fri, 16 Apr 2021 17:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIEk/BxgB3u/66Cxsf+2k7kVr1ksGHvZAdsy59J17tY=;
        b=Qz+xyVG8myJJZHkBRlTcOykhJjhOqcZ8S4M75ezAO2lQLYzE1gBqszkPVRbMZd9TWF
         1tQ73/x5qYb8Y0MnmY9DVqI/AvYtnFp+IQhLUKwr6F3PTJMM43nauJuat6e6rGZltXE0
         RrwMQN/cZlY2K1psw0ssRJ6ne6St5w4p83LPndUnaLuIAsMOxxP+LQsIaJCJSGbyjM5w
         6yLJ1JlmKW5l4nMqDp692kw7yoOiseWLU2caaB8IuSZNvZjufjXf4iKUb6hn4ICjEjXK
         dr1AhiWBd3huhKAO0saTj2PDmwSV4LPjQG+/sb5oxQqxk+bGXvY5LqDLb60g0q9cGX4V
         18iA==
X-Gm-Message-State: AOAM531EBDSGalmMZe9Yy+ksUeCZg4/gVW9PRba9CAlakZoivwXOOvUk
        KMKKMbu9TmmVypCJrQOBn30=
X-Google-Smtp-Source: ABdhPJxpT6IF3UyVziSqC2586PjFx6h7S+OkEmHUo+ps3ENQXBDznS2pYL61JRDuR3SWi6SdyyX/Qw==
X-Received: by 2002:a17:90a:c982:: with SMTP id w2mr12719784pjt.35.1618618231161;
        Fri, 16 Apr 2021 17:10:31 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e13sm5582996pfi.199.2021.04.16.17.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 17:10:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2D55241505; Sat, 17 Apr 2021 00:10:27 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 2/6] fs: add frozen sb state helpers
Date:   Sat, 17 Apr 2021 00:10:22 +0000
Message-Id: <20210417001026.23858-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210417001026.23858-1-mcgrof@kernel.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The question of whether or not a superblock is frozen needs to be
augmented in the future to account for differences between a user
initiated freeze and a kernel initiated freeze done automatically
on behalf of the kernel.

Provide helpers so that these can be used instead so that we don't
have to expand checks later in these same call sites as we expand
the definition of a frozen superblock.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/ext4/ext4_jbd2.c |  2 +-
 fs/super.c          |  4 ++--
 fs/xfs/xfs_trans.c  |  3 +--
 include/linux/fs.h  | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index be799040a415..efda50563feb 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -72,7 +72,7 @@ static int ext4_journal_check_start(struct super_block *sb)
 
 	if (sb_rdonly(sb))
 		return -EROFS;
-	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(sb_is_frozen(sb));
 	journal = EXT4_SB(sb)->s_journal;
 	/*
 	 * Special case here: if the journal has aborted behind our
diff --git a/fs/super.c b/fs/super.c
index e24d0849d935..72b445a69a45 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1629,7 +1629,7 @@ static int freeze_locked_super(struct super_block *sb)
 {
 	int ret;
 
-	if (sb->s_writers.frozen != SB_UNFROZEN)
+	if (!sb_is_unfrozen(sb))
 		return -EBUSY;
 
 	if (!(sb->s_flags & SB_BORN))
@@ -1734,7 +1734,7 @@ static int thaw_super_locked(struct super_block *sb)
 {
 	int error;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
+	if (!sb_is_frozen(sb)) {
 		up_write(&sb->s_umount);
 		return -EINVAL;
 	}
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index bcc978011869..b4669dd65c9e 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -272,8 +272,7 @@ xfs_trans_alloc(
 	 * Zero-reservation ("empty") transactions can't modify anything, so
 	 * they're allowed to run while we're frozen.
 	 */
-	WARN_ON(resp->tr_logres > 0 &&
-		mp->m_super->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(resp->tr_logres > 0 && sb_is_frozen(mp->m_super));
 	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) ||
 	       xfs_sb_version_haslazysbcount(&mp->m_sb));
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..3dcf2c1968e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1885,6 +1885,40 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
+/**
+ * sb_is_frozen_by_user - is superblock frozen by a user call
+ * @sb: the super to check
+ *
+ * Returns true if the super freeze was initiated by userspace, for instance,
+ * an ioctl call.
+ */
+static inline bool sb_is_frozen_by_user(struct super_block *sb)
+{
+	return sb->s_writers.frozen == SB_FREEZE_COMPLETE;
+}
+
+/**
+ * sb_is_frozen - is superblock frozen
+ * @sb: the super to check
+ *
+ * Returns true if the super is frozen.
+ */
+static inline bool sb_is_frozen(struct super_block *sb)
+{
+	return sb_is_frozen_by_user(sb);
+}
+
+/**
+ * sb_is_unfrozen - is superblock unfrozen
+ * @sb: the super to check
+ *
+ * Returns true if the super is unfrozen.
+ */
+static inline bool sb_is_unfrozen(struct super_block *sb)
+{
+	return sb->s_writers.frozen == SB_UNFROZEN;
+}
+
 bool inode_owner_or_capable(struct user_namespace *mnt_userns,
 			    const struct inode *inode);
 
-- 
2.29.2

