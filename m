Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300CF362C4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhDQAK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 20:10:57 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35796 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhDQAK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:10:56 -0400
Received: by mail-pg1-f181.google.com with SMTP id q10so20238816pgj.2;
        Fri, 16 Apr 2021 17:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SDRpwdPi3SViEUIM0mIqVQcojr1grrjFmh4YTLnLIhE=;
        b=Wyv0sVAQK+2zy2nv6iEwh/HmEvOx6Dvd7V7/kDtbLJelDQUNXPfTSlHtJVs1qIxxfj
         seanYynaWMS9t+5DXp2GTZaE2+AQdkjs4f66JKyrvhXUljIK2vxLHbgKUjfHZWd0Guyg
         4AXP3W6/w1PA1PiN7sel8e8kjQDmU4Wiz6jzmpFxGXcgzEzdJXJmlF7XDltbchOdNleT
         0MX57eE26xIdrIUsnnMY/RsZIKg054iYaGDdh618hTHgLt4z5t/FjUAFIHXBVfP3s0hy
         kzDA+XzpBO/qFuoLumTH4FjE+C0EFY8WkXPgAZ74BZbVVse1iiHIlBZG0a/kXB2cZTxs
         8oYg==
X-Gm-Message-State: AOAM531p5KxD1Yk4w1WYE3EP+9Ib13wl6looitfSKt9gbb7HTDGESKjI
        ogLFzHOgmRVy0WqhKg5L8HNTpO8wqfCvFQ==
X-Google-Smtp-Source: ABdhPJwPey9RhxkQxLBX2BcxrWPXCPavTWoPaJjHPsui4exAiE5B8jzS0TqWtmCaL1ILgUq/1kWk1Q==
X-Received: by 2002:a62:8804:0:b029:253:6745:908c with SMTP id l4-20020a6288040000b02902536745908cmr9942836pfd.16.1618618229276;
        Fri, 16 Apr 2021 17:10:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x19sm5842867pff.14.2021.04.16.17.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 17:10:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1AF2E4021F; Sat, 17 Apr 2021 00:10:27 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: [RFC v2 1/6] fs: provide unlocked helper for freeze_super()
Date:   Sat, 17 Apr 2021 00:10:21 +0000
Message-Id: <20210417001026.23858-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210417001026.23858-1-mcgrof@kernel.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

freeze_super() holds a write lock, however we wish to also enable
callers which already hold the write lock. To do this provide a helper
and make freeze_super() use it. This way, all that freeze_super() does
now is lock handling and active count management.

This change has no functional changes.

Suggested-by: Dave Chinner <david@fromorbit.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c | 100 +++++++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 11b7e7213fd1..e24d0849d935 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1624,59 +1624,20 @@ static void sb_freeze_unlock(struct super_block *sb)
 		percpu_up_write(sb->s_writers.rw_sem + level);
 }
 
-/**
- * freeze_super - lock the filesystem and force it into a consistent state
- * @sb: the super to lock
- *
- * Syncs the super to make sure the filesystem is consistent and calls the fs's
- * freeze_fs.  Subsequent calls to this without first thawing the fs will return
- * -EBUSY.
- *
- * During this function, sb->s_writers.frozen goes through these values:
- *
- * SB_UNFROZEN: File system is normal, all writes progress as usual.
- *
- * SB_FREEZE_WRITE: The file system is in the process of being frozen.  New
- * writes should be blocked, though page faults are still allowed. We wait for
- * all writes to complete and then proceed to the next stage.
- *
- * SB_FREEZE_PAGEFAULT: Freezing continues. Now also page faults are blocked
- * but internal fs threads can still modify the filesystem (although they
- * should not dirty new pages or inodes), writeback can run etc. After waiting
- * for all running page faults we sync the filesystem which will clean all
- * dirty pages and inodes (no new dirty pages or inodes can be created when
- * sync is running).
- *
- * SB_FREEZE_FS: The file system is frozen. Now all internal sources of fs
- * modification are blocked (e.g. XFS preallocation truncation on inode
- * reclaim). This is usually implemented by blocking new transactions for
- * filesystems that have them and need this additional guard. After all
- * internal writers are finished we call ->freeze_fs() to finish filesystem
- * freezing. Then we transition to SB_FREEZE_COMPLETE state. This state is
- * mostly auxiliary for filesystems to verify they do not modify frozen fs.
- *
- * sb->s_writers.frozen is protected by sb->s_umount.
- */
-int freeze_super(struct super_block *sb)
+/* Caller takes lock and handles active count */
+static int freeze_locked_super(struct super_block *sb)
 {
 	int ret;
 
-	atomic_inc(&sb->s_active);
-	down_write(&sb->s_umount);
-	if (sb->s_writers.frozen != SB_UNFROZEN) {
-		deactivate_locked_super(sb);
+	if (sb->s_writers.frozen != SB_UNFROZEN)
 		return -EBUSY;
-	}
 
-	if (!(sb->s_flags & SB_BORN)) {
-		up_write(&sb->s_umount);
+	if (!(sb->s_flags & SB_BORN))
 		return 0;	/* sic - it's "nothing to do" */
-	}
 
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-		up_write(&sb->s_umount);
 		return 0;
 	}
 
@@ -1705,7 +1666,6 @@ int freeze_super(struct super_block *sb)
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb);
 			wake_up(&sb->s_writers.wait_unfrozen);
-			deactivate_locked_super(sb);
 			return ret;
 		}
 	}
@@ -1714,9 +1674,59 @@ int freeze_super(struct super_block *sb)
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	return 0;
+}
+
+/**
+ * freeze_super - lock the filesystem and force it into a consistent state
+ * @sb: the super to lock
+ *
+ * Syncs the super to make sure the filesystem is consistent and calls the fs's
+ * freeze_fs.  Subsequent calls to this without first thawing the fs will return
+ * -EBUSY.
+ *
+ * During this function, sb->s_writers.frozen goes through these values:
+ *
+ * SB_UNFROZEN: File system is normal, all writes progress as usual.
+ *
+ * SB_FREEZE_WRITE: The file system is in the process of being frozen.  New
+ * writes should be blocked, though page faults are still allowed. We wait for
+ * all writes to complete and then proceed to the next stage.
+ *
+ * SB_FREEZE_PAGEFAULT: Freezing continues. Now also page faults are blocked
+ * but internal fs threads can still modify the filesystem (although they
+ * should not dirty new pages or inodes), writeback can run etc. After waiting
+ * for all running page faults we sync the filesystem which will clean all
+ * dirty pages and inodes (no new dirty pages or inodes can be created when
+ * sync is running).
+ *
+ * SB_FREEZE_FS: The file system is frozen. Now all internal sources of fs
+ * modification are blocked (e.g. XFS preallocation truncation on inode
+ * reclaim). This is usually implemented by blocking new transactions for
+ * filesystems that have them and need this additional guard. After all
+ * internal writers are finished we call ->freeze_fs() to finish filesystem
+ * freezing. Then we transition to SB_FREEZE_COMPLETE state. This state is
+ * mostly auxiliary for filesystems to verify they do not modify frozen fs.
+ *
+ * sb->s_writers.frozen is protected by sb->s_umount.
+ */
+int freeze_super(struct super_block *sb)
+{
+	int error;
+
+	atomic_inc(&sb->s_active);
+
+	down_write(&sb->s_umount);
+	error = freeze_locked_super(sb);
+	if (error) {
+		deactivate_locked_super(sb);
+		goto out;
+	}
 	lockdep_sb_freeze_release(sb);
 	up_write(&sb->s_umount);
-	return 0;
+
+out:
+	return error;
 }
 EXPORT_SYMBOL(freeze_super);
 
-- 
2.29.2

