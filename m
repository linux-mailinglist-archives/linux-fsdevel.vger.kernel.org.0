Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EBD537356
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiE3Bkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 May 2022 21:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiE3Bkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 May 2022 21:40:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC53EB95
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 18:40:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b5so9017853plx.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AWJBJ3LOOu4SnET4tN5DM1OiJ2Kf/NcSkZ8EqxUPWQQ=;
        b=i/nKgztGfbo1Ha0TGaQGtTWebzP0RkhfYfOWIrMpkDcpKgQ0xz7xFDJfHj5z632fqx
         VnCVYvugwfgIRCxp5d6bbSGc+L1cmWrGQErLvJ42xVd/M+UcjtxIxgHjOahCVCrS+E5n
         9WgTp5FmhdWAGeCFwg+GHj/RUeM9SfYRkCoPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AWJBJ3LOOu4SnET4tN5DM1OiJ2Kf/NcSkZ8EqxUPWQQ=;
        b=OQfN6pPK6UYOR6ZoaI5HpTwFzsNkj42rX5/u94vMGw3BRFg6el0aK2LAlkSmUOP3zK
         /w60mJaA5YwGFEmGwHjpkvVJ9vAuhD9ZvtdNmSYxlfwRfS9+P7QGMCPuH/Z/pRcIbuox
         b9Rufe7EaOcvdlldQWMifFYoQUk067SNwvVKN2OSHwd/TY33Q5xywa4SuSaXx1Ry7T4A
         3y0JDhNPRiGc/WhHEjF8ivzeLkkShWodAjz7hx+xI06q0/NnhHTHAYMgGuoTGnbEX/8S
         15dxg/ANj8bTi+A+wjOmr4JGGxRIE5CzON0eli9067Gq9mESPs1qLag/QVy/LJUTFL1r
         2tjw==
X-Gm-Message-State: AOAM530v7BjSjd27Lb5PDFZ35M+lZQ6MbE4nUKZv3TLEsCc0IaPd/YK3
        /QJs4twruFDh3YiXYBHl267divknNh2XWQ==
X-Google-Smtp-Source: ABdhPJy6vgmM6oCmbiKRZKfOhfYOuU4pUrtx9loEVpyc7jhHu6V7fiQ0+dSGnc4Njs/M/G4TYHUBzA==
X-Received: by 2002:a17:902:ebc8:b0:15f:3f5d:9d08 with SMTP id p8-20020a170902ebc800b0015f3f5d9d08mr53509172plg.121.1653874840928;
        Sun, 29 May 2022 18:40:40 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902eb0900b0015f2d549b46sm662285plb.237.2022.05.29.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 18:40:40 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v3 1/2] fs/super: function to prevent super re-use
Date:   Mon, 30 May 2022 11:39:57 +1000
Message-Id: <20220530113953.v3.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220530013958.577941-1-dlunev@chromium.org>
References: <20220530013958.577941-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function is to be called from filesystem-specific code to mark a
superblock to be ignored by superblock test and thus never re-used. The
function also unregisters bdi if the bdi is per-superblock to avoid
collision if a new superblock is created to represent the filesystem.
generic_shutdown_super() skips unregistering bdi for a retired
superlock as it assumes retire function has already done it.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

Changes in v3:
- Back to state tracking from v1
- Use s_iflag to mark superblocked ignored
- Only unregister private bdi in retire, without freeing

Changes in v2:
- Remove super from list of superblocks instead of using a flag

 fs/super.c         | 32 ++++++++++++++++++++++++++++----
 include/linux/fs.h |  2 ++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f1d4a193602d6..cb092fc6d6d34 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -422,6 +422,30 @@ bool trylock_super(struct super_block *sb)
 	return false;
 }
 
+/**
+ *	retire_super	-	prevernts superblock from being reused
+ *	@sb: superblock to retire
+ *
+ *	The function marks superblock to be ignored in superblock test, which
+ *	prevents it from being reused for any new mounts. If the superblock has
+ *	a private bdi, it also unregisters it, but doesn't reduce the refcount
+ *	of the superblock to prevent potential races. The refcount is reduced
+ *	by generic_shutdown_super(). The function can not be called concurrently
+ *	with generic_shutdown_super(). It is safe to call the function multiple
+ *	times, subsequent calls have no effect.
+ */
+void retire_super(struct super_block *sb)
+{
+	down_write(&sb->s_umount);
+	if (sb->s_bdi != &noop_backing_dev_info) {
+		if (sb->s_iflags & SB_I_PERSB_BDI && !(sb->s_iflags & SB_I_RETIRED))
+			bdi_unregister(sb->s_bdi);
+	}
+	sb->s_iflags |= SB_I_RETIRED;
+	up_write(&sb->s_umount);
+}
+EXPORT_SYMBOL(retire_super);
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -468,12 +492,12 @@ void generic_shutdown_super(struct super_block *sb)
 		}
 	}
 	spin_lock(&sb_lock);
-	/* should be initialized for __put_super_and_need_restart() */
 	hlist_del_init(&sb->s_instances);
 	spin_unlock(&sb_lock);
 	up_write(&sb->s_umount);
 	if (sb->s_bdi != &noop_backing_dev_info) {
-		if (sb->s_iflags & SB_I_PERSB_BDI)
+		/* retire should have already unregistered bdi */
+		if (sb->s_iflags & SB_I_PERSB_BDI && !(sb->s_iflags & SB_I_RETIRED))
 			bdi_unregister(sb->s_bdi);
 		bdi_put(sb->s_bdi);
 		sb->s_bdi = &noop_backing_dev_info;
@@ -1216,7 +1240,7 @@ static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 
 static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 {
-	return s->s_bdev == fc->sget_key;
+	return !(s->s_iflags & SB_I_RETIRED) && s->s_bdev == fc->sget_key;
 }
 
 /**
@@ -1307,7 +1331,7 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return (void *)s->s_bdev == data;
+	return !(s->s_iflags & SB_I_RETIRED) && (void *)s->s_bdev == data;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23a..ef392fd2361bd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1411,6 +1411,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
+#define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 
 /* Possible states of 'frozen' field */
 enum {
@@ -2424,6 +2425,7 @@ extern struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
+void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
 void kill_anon_super(struct super_block *sb);
-- 
2.31.0

