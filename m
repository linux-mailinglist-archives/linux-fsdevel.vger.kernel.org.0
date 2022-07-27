Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37DC582062
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 08:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiG0GpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 02:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiG0Gor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB9419BA
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id jw17so3116072pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGLiVi9XQM3vyY9yITwEB0JmMmI/TjfPvTsfSo82B+s=;
        b=Q8Ri/ANocPXcmRgdrkKVri46FcK3O3C3JdOPric+SMDZ+Pragy79ydjKbLC6dun3Lm
         H5P25v3IibiUlW3DKE4InnUBqT3rRPR2ee5vmpIaIoJJngMxOTgnk/abbiLGN7SwRKZ6
         TtxaJXZMXXFX1R13s8ztNmXNxqb1L1zFxQ/rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pGLiVi9XQM3vyY9yITwEB0JmMmI/TjfPvTsfSo82B+s=;
        b=W2JkFjPQTW+JffZEdf1G0Ghk4oCyDFzIgQe3k6El3u+RPjb7PoVLqhOJQZSqSnwV3X
         kDO1HBGeq0OzN0p6C3j6+44J6GDwhMvVeV9L2W+Hl+AmW4aYomxVsn9SO2bwem/Zitww
         jyOVDyuTqkS4T33Ki50rOqN6AS6RHPH9saxIvfQ/gEFfa3GOZhPVesKuCCu7vZBTPMti
         /FqSJ7UUdy7rgIYyPNnX1jsovemp0fdgU+MsDxZz/aOgF4uEf+PI0HBqJBfF2pIt2dfd
         D0anZAx0c73REwXDyc/2F8h/bkQzKVNH8zcBU7Ga3uVFVS0I+9gYuQtODijyqWQmHpkA
         uJWQ==
X-Gm-Message-State: AJIora9GRm0uLVVU9GHDOu1Eg5KxCEjt6Nkvg3g72VEMr5aJ2KA469md
        zh5vZyu4MGMo1OEXxGH7vXUH+g==
X-Google-Smtp-Source: AGRyM1tkFYpNmNzxbkSrpQ31JzoVI6BtKahQUmPC06Go6XQSkBdv3w6GTkGVFH0PVlTiR63gAIFoRw==
X-Received: by 2002:a17:90b:198d:b0:1f3:f72:cfdc with SMTP id mv13-20020a17090b198d00b001f30f72cfdcmr530341pjb.237.1658904283540;
        Tue, 26 Jul 2022 23:44:43 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm12627001pln.110.2022.07.26.23.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:44:43 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v5 1/2] fs/super: function to prevent re-use of block-device-based superblocks
Date:   Wed, 27 Jul 2022 16:44:24 +1000
Message-Id: <20220727164328.v5.1.I73b7338e13b233e8b0bf366c753cbc2b360817cb@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220727064425.4144478-1-dlunev@chromium.org>
References: <20220727064425.4144478-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

This patch adds the functionality only for the block-device-based
supers, since the primary use case of the feature is to gracefully
handle force unmount of external devices, mounted with FUSE. This can be
further extended to cover all superblocks, if the need arises.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---

Changes in v5:
- Commit message
- Extended retire_super comment to clarify behaviour.

Changes in v4:
- Simplify condition according to Christoph Hellwig's comments.

Changes in v3:
- Back to state tracking from v1
- Use s_iflag to mark superblocked ignored
- Only unregister private bdi in retire, without freeing

Changes in v2:
- Remove super from list of superblocks instead of using a flag

 fs/super.c         | 32 ++++++++++++++++++++++++++++++--
 include/linux/fs.h |  2 ++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 60f57c7bc0a69..8565fffc9ae31 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -422,6 +422,34 @@ bool trylock_super(struct super_block *sb)
 	return false;
 }
 
+/**
+ *	retire_super	-	prevents superblock from being reused
+ *	@sb: superblock to retire
+ *
+ *	The function marks superblock to be ignored in superblock test, which
+ *	prevents it from being reused for any new mounts. If the superblock has
+ *	a private bdi, it also unregisters it, but doesn't reduce the refcount
+ *	of the superblock to prevent potential races. The refcount is reduced
+ *	by generic_shutdown_super(). The function can not be called concurrently
+ *	with generic_shutdown_super(). It is safe to call the function multiple
+ *	times, subsequent calls have no effect.
+ *
+ *	The marker will affect the re-use only for block-device-based
+ *	superblocks. Other superblocks will still get marked if this function is
+ *	used, but that will not affect their reusability.
+ */
+void retire_super(struct super_block *sb)
+{
+	down_write(&sb->s_umount);
+	if (sb->s_iflags & SB_I_PERSB_BDI) {
+		bdi_unregister(sb->s_bdi);
+		sb->s_iflags &= ~SB_I_PERSB_BDI;
+	}
+	sb->s_iflags |= SB_I_RETIRED;
+	up_write(&sb->s_umount);
+}
+EXPORT_SYMBOL(retire_super);
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -1216,7 +1244,7 @@ static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 
 static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 {
-	return s->s_bdev == fc->sget_key;
+	return !(s->s_iflags & SB_I_RETIRED) && s->s_bdev == fc->sget_key;
 }
 
 /**
@@ -1307,7 +1335,7 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return (void *)s->s_bdev == data;
+	return !(s->s_iflags & SB_I_RETIRED) && (void *)s->s_bdev == data;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae5..246120ee05733 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1412,6 +1412,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
+#define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 
 /* Possible states of 'frozen' field */
 enum {
@@ -2432,6 +2433,7 @@ extern struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
+void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
 void kill_anon_super(struct super_block *sb);
-- 
2.31.0

