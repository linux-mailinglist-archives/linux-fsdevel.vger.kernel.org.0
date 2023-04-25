Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172436EE2D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjDYNWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjDYNWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:22:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B709313F85;
        Tue, 25 Apr 2023 06:22:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2fc3f1d6f8cso3618953f8f.3;
        Tue, 25 Apr 2023 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682428952; x=1685020952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxHAMcex7ExkBOux68mKM0Mp8PcsMmJKuPrg3j/J8cM=;
        b=H6fUAq0kD9vkk1JlH97nIr6veo6dCAlwtG5imBNgXb8OS0po49+i8KfP92/VsfOyyO
         ESQ+WYQanBjtass5pedR2no66HWTeTx7PsvmOpqh23OLxOdVrLC3VYpVUEJoFHaKN4h2
         Zz9Sgd2L8S8FOQqc8dwuRisZe63r46TRcAs/DYLUt0h3aQFD+4ZLU4HJ5W+1TcTI1X21
         U6keHZ6i24TGya4rZfRM/2HanZOWs/dCkt2aNCL2Zx0yWbCJAx4ZvVCJRdSwoE7GpGH/
         Q/Bn4ye+aJPahe8a/JgqChmW8onr0wZCEMFi/wv58nKSwjsdm1L8GxdujvgWIOgLSkot
         A1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428952; x=1685020952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxHAMcex7ExkBOux68mKM0Mp8PcsMmJKuPrg3j/J8cM=;
        b=Q+p0whgxWYGlI/76voCt7AEo6bw3u/620+7vfCo8edj83ZAt1Cwbi5fTw/COOJxxTI
         pXgEqz7CL6WDHhbns3DMWNdLW1T/jF//XdSk0gUZNTbP1hxolV12rmN+CRPh9vrqet1p
         9vptwAXVfJEO5lxN2KfXGKrTDZ287volTPvmUpq+FzgvD+bBDFDWBgarmoEONLf96+ka
         RTaa+auVFvO+4+QsbY8d9d4uDJ2Mk8RDDT2FIU+Awd9hhG5Xiiv98pg/X4zYruV173Dh
         GF17j6VQjwuwX71WPqJdkhLYWwSHseyq6mROrAHcYGfFIahO24kdWwuUEygetPCwHkoU
         kEWA==
X-Gm-Message-State: AAQBX9dhUUJni3undmuhvLA1GjFPgFF+7xprBxTuwTl303o0+04vEhlk
        Ub23je5afNu9UpbLxRczA+I=
X-Google-Smtp-Source: AKy350ZrvBXpACYLVvJCbArs/YCUXaxVmF2E0SAGbzn8ElZ9+FHLeB/DfLOKmouOPPeGIHd7OCXHXA==
X-Received: by 2002:a5d:58e3:0:b0:2ee:da1c:381a with SMTP id f3-20020a5d58e3000000b002eeda1c381amr11551623wrd.69.1682428951909;
        Tue, 25 Apr 2023 06:22:31 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002f9ff443184sm13076973wrj.24.2023.04.25.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:22:31 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 1/3] ovl: support encoding non-decodeable file handles
Date:   Tue, 25 Apr 2023 16:22:21 +0300
Message-Id: <20230425132223.2608226-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425132223.2608226-1-amir73il@gmail.com>
References: <20230425132223.2608226-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When all layers support file handles, we support encoding non-decodeable
file handles (a.k.a. fid) even with nfs_export=off.

When file handles do not need to be decoded, we do not need to copy up
redirected lower directories on encode, and we encode also non-indexed
upper with lower file handle, so fid will not change on copy up.

This enables reporting fanotify events with file handles on overlayfs
with default config/mount options.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/export.c    | 26 ++++++++++++++++++++------
 fs/overlayfs/inode.c     |  2 +-
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/super.c     |  9 +++++++++
 5 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index defd4e231ad2..dfd05ad2b722 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -173,28 +173,37 @@ static int ovl_connect_layer(struct dentry *dentry)
  * U = upper file handle
  * L = lower file handle
  *
- * (*) Connecting an overlay dir from real lower dentry is not always
+ * (*) Decoding a connected overlay dir from real lower dentry is not always
  * possible when there are redirects in lower layers and non-indexed merge dirs.
  * To mitigate those case, we may copy up the lower dir ancestor before encode
- * a lower dir file handle.
+ * of a decodeable file handle for non-upper dir.
  *
  * Return 0 for upper file handle, > 0 for lower file handle or < 0 on error.
  */
 static int ovl_check_encode_origin(struct dentry *dentry)
 {
 	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	bool decodeable = ofs->config.nfs_export;
+
+	/* Lower file handle for non-upper non-decodeable */
+	if (!ovl_dentry_upper(dentry) && !decodeable)
+		return 0;
 
 	/* Upper file handle for pure upper */
 	if (!ovl_dentry_lower(dentry))
 		return 0;
 
 	/*
-	 * Upper file handle for non-indexed upper.
-	 *
 	 * Root is never indexed, so if there's an upper layer, encode upper for
 	 * root.
 	 */
-	if (ovl_dentry_upper(dentry) &&
+	if (dentry == dentry->d_sb->s_root)
+		return 0;
+
+	/*
+	 * Upper decodeable file handle for non-indexed upper.
+	 */
+	if (ovl_dentry_upper(dentry) && decodeable &&
 	    !ovl_test_flag(OVL_INDEX, d_inode(dentry)))
 		return 0;
 
@@ -204,7 +213,7 @@ static int ovl_check_encode_origin(struct dentry *dentry)
 	 * ovl_connect_layer() will try to make origin's layer "connected" by
 	 * copying up a "connectable" ancestor.
 	 */
-	if (d_is_dir(dentry) && ovl_upper_mnt(ofs))
+	if (d_is_dir(dentry) && ovl_upper_mnt(ofs) && decodeable)
 		return ovl_connect_layer(dentry);
 
 	/* Lower file handle for indexed and non-upper dir/non-dir */
@@ -875,3 +884,8 @@ const struct export_operations ovl_export_operations = {
 	.get_name	= ovl_get_name,
 	.get_parent	= ovl_get_parent,
 };
+
+/* encode_fh() encodes non-decodeable file handles with nfs_export=off */
+const struct export_operations ovl_export_fid_operations = {
+	.encode_fh	= ovl_encode_fh,
+};
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 541cf3717fc2..b6bec4064390 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1304,7 +1304,7 @@ static bool ovl_hash_bylower(struct super_block *sb, struct dentry *upper,
 		return false;
 
 	/* No, if non-indexed upper with NFS export */
-	if (sb->s_export_op && upper)
+	if (ofs->config.nfs_export && upper)
 		return false;
 
 	/* Otherwise, hash by lower inode for fsnotify */
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4d0b278f5630..87d44b889129 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -734,3 +734,4 @@ int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
 
 /* export.c */
 extern const struct export_operations ovl_export_operations;
+extern const struct export_operations ovl_export_fid_operations;
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index fd11fe6d6d45..5cc0b6e65488 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -67,6 +67,7 @@ struct ovl_fs {
 	const struct cred *creator_cred;
 	bool tmpfile;
 	bool noxattr;
+	bool nofh;
 	/* Did we take the inuse lock? */
 	bool upperdir_locked;
 	bool workdir_locked;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f1d9f75f8786..5ed8c2650293 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -954,6 +954,7 @@ static int ovl_lower_dir(const char *name, struct path *path,
 		pr_warn("fs on '%s' does not support file handles, falling back to index=off,nfs_export=off.\n",
 			name);
 	}
+	ofs->nofh |= !fh_type;
 	/*
 	 * Decoding origin file handle is required for persistent st_ino.
 	 * Without persistent st_ino, xino=auto falls back to xino=off.
@@ -1391,6 +1392,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		ofs->config.index = false;
 		pr_warn("upper fs does not support file handles, falling back to index=off.\n");
 	}
+	ofs->nofh |= !fh_type;
 
 	/* Check if upper fs has 32bit inode numbers */
 	if (fh_type != FILEID_INO32_GEN)
@@ -2049,8 +2051,15 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		ofs->config.nfs_export = false;
 	}
 
+	/*
+	 * Support encoding decodeable file handles with nfs_export=on
+	 * and encoding non-decodeable file handles with nfs_export=off
+	 * if all layers support file handles.
+	 */
 	if (ofs->config.nfs_export)
 		sb->s_export_op = &ovl_export_operations;
+	else if (!ofs->nofh)
+		sb->s_export_op = &ovl_export_fid_operations;
 
 	/* Never override disk quota limits or use reserved space */
 	cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
-- 
2.34.1

