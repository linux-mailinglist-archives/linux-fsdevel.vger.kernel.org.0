Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5518C362C4F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhDQAK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 20:10:59 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:44771 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbhDQAK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:10:58 -0400
Received: by mail-pg1-f175.google.com with SMTP id y32so20231910pga.11;
        Fri, 16 Apr 2021 17:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTrvFs3AKaFZ3If0goY3Q3QD+4hQVrUThGZhfCkTlf8=;
        b=ILQZDD6SSgJC8BFN30IfA3WnAERaeQMbX2P3x7ucnfZkN+xFZdDX1F/vglTJ9IICM4
         4LpXYWUV6MZPC7tFgJHLdps65p8bx+ZTLzCAO1RjFXZflCxzCO14mQHGOTapaCpJCseK
         U2HIUTAD9CwloXWtkdCF9CJpBy02UW0IY8RxPAVf/yfnmkd4DmNVK9FXO+SDmNoY497i
         ZicBbJHOQzl2Hsx52RansVk6bRlqcLapj/UMC+VtNLWi4AxwJnFxD7hwcg3kf5sbbOSJ
         YxH8YMXFX17Xbw3f9nj22MtegpVp1bG8562zsXI/VhPphopksZKnCC/yCWvF7Jg0sqB/
         5HkA==
X-Gm-Message-State: AOAM530CsNsuSaVFSzN+/0obItaxaYs8dhFceJp7afUs2VDZQkcYkffs
        mz59uYTJ7SyOj1F/wF+LWB7NPl0c5/kuIg==
X-Google-Smtp-Source: ABdhPJwgcO//uvySmzn6mD09Opo4L8sxOdiYl8ld3iDq4PqiNUqHfwIk35P8U271Vs3cJRmYFW9Cxg==
X-Received: by 2002:a63:d009:: with SMTP id z9mr1360081pgf.16.1618618231911;
        Fri, 16 Apr 2021 17:10:31 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p15sm3223905pfo.187.2021.04.16.17.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 17:10:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 33B65419AC; Sat, 17 Apr 2021 00:10:27 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 3/6] fs: add a helper for thaw_super_locked() which does not unlock
Date:   Sat, 17 Apr 2021 00:10:23 +0000
Message-Id: <20210417001026.23858-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210417001026.23858-1-mcgrof@kernel.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The thaw_super_locked() expects the caller to hold the sb->s_umount
semaphore. It also handles the unlocking of the semaphore for you.
Allow for cases where the caller will do the unlocking of the semaphore.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 72b445a69a45..744b2399a272 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1730,14 +1730,13 @@ int freeze_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(freeze_super);
 
-static int thaw_super_locked(struct super_block *sb)
+/* Caller deals with the sb->s_umount */
+static int __thaw_super_locked(struct super_block *sb)
 {
 	int error;
 
-	if (!sb_is_frozen(sb)) {
-		up_write(&sb->s_umount);
+	if (!sb_is_frozen(sb))
 		return -EINVAL;
-	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
@@ -1752,7 +1751,6 @@ static int thaw_super_locked(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
-			up_write(&sb->s_umount);
 			return error;
 		}
 	}
@@ -1761,10 +1759,25 @@ static int thaw_super_locked(struct super_block *sb)
 	sb_freeze_unlock(sb);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
-	deactivate_locked_super(sb);
 	return 0;
 }
 
+/* Handles unlocking of sb->s_umount for you */
+static int thaw_super_locked(struct super_block *sb)
+{
+	int error;
+
+	error = __thaw_super_locked(sb);
+	if (error) {
+		up_write(&sb->s_umount);
+		return error;
+	}
+
+	deactivate_locked_super(sb);
+
+	return 0;
+ }
+
 /**
  * thaw_super -- unlock filesystem
  * @sb: the super to thaw
-- 
2.29.2

