Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375FF524058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348824AbiEKWgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 18:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348781AbiEKWgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 18:36:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02296344CA
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 15:36:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so3204304plk.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LgIZ0Arn9MkMe+G5lqDiZbm3hHu7bc+acHfe0jeV+M=;
        b=VDy+LOB5Z24b+YX3YR2qPfyhpZhwjj+zl5gA8W9DjUbiPmsJqFeCNh/FEGU8is2nZS
         5T0Gv1b++G/SOWBt0QZk8VTs3b059pW74ffkw7bsAiVHm4MPNXY91nbWtfv4R2tDA8QD
         4aUV7TV2Z62wth/sY1QRDONqUhpGeoInAeU4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LgIZ0Arn9MkMe+G5lqDiZbm3hHu7bc+acHfe0jeV+M=;
        b=zuIh/3sQgJZjosveR4/wWYbEFxeoqDtbdm+RpYovWGpXYnnkaYopBwZvXR7sW0CtmT
         kaeOaWfhGZYOPohO5sRW1kQLJ2fMKbhabAZoZtx3qBuPfxkSjIgHCqrdtFjLBhYe3Zd0
         VPN2KpAV+ryTDRauJWyKkClW1qdoGIQwxBBFNtc+SkT0TjIDRQcem4u3TELY6nT7tgKz
         oSFbukoA7DZVFm2KsBXKzWwPsFbtoRRAKbVXG665jiFmKmwvtMUCnlrXbQ09iktQTYT5
         nQySrpcxwDClzQcPjMPZss8rqn5BIJJcJNSTTI8vk3qxnrExKDsJ4DwBy+MIgd8xaVLC
         Lb5A==
X-Gm-Message-State: AOAM533FDdYuznbaxd90HYbHW7f2DfGgpbPzt6U3fC3S3p+xPQqUdR7W
        4/K36l/25mks3NL2lAgFDUbKPgvSDQxvyQ==
X-Google-Smtp-Source: ABdhPJx6vfq7aEC09BQ58hiwA5FJut82riYhIGIWThRCuhraVQ0ru9FIWmizgQdmmiA3pDWV6KGEVQ==
X-Received: by 2002:a17:90a:bf0a:b0:1db:d98d:7ce9 with SMTP id c10-20020a17090abf0a00b001dbd98d7ce9mr7562374pjs.155.1652308601400;
        Wed, 11 May 2022 15:36:41 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b0015e8d4eb1d2sm2391855pld.28.2022.05.11.15.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:36:41 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, fuse-devel@lists.sourceforge.net, tytso@mit.edu,
        miklos@szeredi.hu, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v2 1/2] fs/super: function to prevent super re-use
Date:   Thu, 12 May 2022 08:29:09 +1000
Message-Id: <20220512082832.v2.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220511222910.635307-1-dlunev@chromium.org>
References: <20220511222910.635307-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function is called from generic_shutdown_super upon super
destruction, but also can be called by a filesystem during unmount to
ensure a new superblock is created upon the next mount. This is
necessary for the cases, where force unmount of a filesystem renders
superblock disfunctional, in a state that can not be re-used (e.g. FUSE
severes the connection of the userspace daemon to the superblock which
prevents any further communications between them).

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

Changes in v2:
- Remove super from list of superblocks instead of using a flag

 fs/super.c         | 51 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h |  1 +
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f1d4a193602d6..f23e45434de15 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -422,6 +422,45 @@ bool trylock_super(struct super_block *sb)
 	return false;
 }
 
+/**
+ *	retire_locked_super	-	prevent superblock from re-use
+ *	@sb: superblock that shouldn't be re-used
+ *
+ *	retire_locked_super excludes the super from the list of superblocks and
+ *	removes the link between superblock and it bdi. After a call to this
+ *	function, any subsequent mount will allocate a new superblock, even if
+ *	the retired one would have been re-used otherwise. It is safe to call
+ *	the function multiple times for the same superblock, any subsequent
+ *	invocations after the first one have no effect.
+ */
+static void retire_locked_super(struct super_block *sb)
+{
+	spin_lock(&sb_lock);
+	hlist_del_init(&sb->s_instances);
+	spin_unlock(&sb_lock);
+	up_write(&sb->s_umount);
+	if (sb->s_bdi != &noop_backing_dev_info) {
+		if (sb->s_iflags & SB_I_PERSB_BDI)
+			bdi_unregister(sb->s_bdi);
+		bdi_put(sb->s_bdi);
+		sb->s_bdi = &noop_backing_dev_info;
+	}
+}
+
+/**
+ *	retire_super	-	prevent superblock from re-use
+ *	@sb: superblock that shouldn't be re-used
+ *
+ *	Variant of retire_locked_super, except that superblock is *not* locked
+ *	by caller.
+ */
+void retire_super(struct super_block *sb)
+{
+	down_write(&sb->s_umount);
+	retire_locked_super(sb);
+}
+EXPORT_SYMBOL(retire_super);
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -467,17 +506,7 @@ void generic_shutdown_super(struct super_block *sb)
 			   sb->s_id);
 		}
 	}
-	spin_lock(&sb_lock);
-	/* should be initialized for __put_super_and_need_restart() */
-	hlist_del_init(&sb->s_instances);
-	spin_unlock(&sb_lock);
-	up_write(&sb->s_umount);
-	if (sb->s_bdi != &noop_backing_dev_info) {
-		if (sb->s_iflags & SB_I_PERSB_BDI)
-			bdi_unregister(sb->s_bdi);
-		bdi_put(sb->s_bdi);
-		sb->s_bdi = &noop_backing_dev_info;
-	}
+	retire_locked_super(sb);
 }
 
 EXPORT_SYMBOL(generic_shutdown_super);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23a..dc9151b7f0102 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2424,6 +2424,7 @@ extern struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
+void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
 void kill_anon_super(struct super_block *sb);
-- 
2.31.0

