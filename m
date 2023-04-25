Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8346EE2D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjDYNWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjDYNWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:22:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45113F90;
        Tue, 25 Apr 2023 06:22:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2f58125b957so5203824f8f.3;
        Tue, 25 Apr 2023 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682428953; x=1685020953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjLMXge+2mf0xXFP7MCpTynY/YZV3qiu6nTsi+ti2D4=;
        b=d21+AH9HAhSReroXW1vWvpy6mlg7tU4iUA31n9dyh6g/fMA8XyTrMKr96uW5nEEcOa
         +hQbUekY5BUzvT00IZA2maRjfJ1qsTsstQbTsy0We032kEy3d5A5EC9tong3olhtVTQZ
         R/sngae06Mh6UMaMjbS285LhzLgnETantpBE/P8hCl5LDAkjjIpaR6pYqhBmFCGSzUn6
         RAvN5BJb/wiDZinWP6ku3Ua4PWQ2XJmBKp6q5yBcuH0HHSPgKgGZCV0vGjiycHZbNq9q
         62xj0PqjfE5ZtfuTfnc1j21JZOiZrlNGmqFSUEVDZsBBCNNzqZq2vwJpF+JThucqu//D
         VLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428953; x=1685020953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjLMXge+2mf0xXFP7MCpTynY/YZV3qiu6nTsi+ti2D4=;
        b=YOduxwtBUOgwn9sOCSuOCG5Ge3foQ+jQ+V/niWmMMMEBOBdMF8RQA9ytJRNcCI9liZ
         BzM/aiW8/rSAZxYX1xawJX+Yo3O+TME87ygWIeu2/o0NUdU5GF1x/dq1TKwwypt2PyQT
         kJMRFtQWM+2B13mUMV2nva1R4rMCLH2No2zS8VzMweSDivIyrqp7BejodoLkvo8zNepr
         11lG/MVA00FAM/sNVmPLjo/wiUs4xzbgW2pZIRacxELwhcO7YoEXrdaG/+ApxXYs/TQU
         Oz5GOlzxTvXDs8Y7OgG6c2ImMXGuNjKCazERdkxXIskNhM9y84P8LV4QT75Q+D3Yc29e
         0wIQ==
X-Gm-Message-State: AC+VfDxGEfQI4i29sxrlD6veKlblrnq3GkZQoCDlf5r8OyuSitNnWYzK
        2ugkYma4LdyA+gcNoeqx/ec=
X-Google-Smtp-Source: ACHHUZ5h/QFLUb+zWv7UZrV2E5+gv0NX8/EFJlUv5eNCX0UzzCiy849qLC7y68EJJsTtR4hBTFC0Gw==
X-Received: by 2002:adf:ee8a:0:b0:304:8e4f:4666 with SMTP id b10-20020adfee8a000000b003048e4f4666mr1610537wro.7.1682428953218;
        Tue, 25 Apr 2023 06:22:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002f9ff443184sm13076973wrj.24.2023.04.25.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:22:32 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 2/3] ovl: report a per-instance f_fsid by default
Date:   Tue, 25 Apr 2023 16:22:22 +0300
Message-Id: <20230425132223.2608226-3-amir73il@gmail.com>
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

ovl_statfs() reports the f_fsid filled by underlying upper fs.
This fsid is not unique among overlayfs instances on the same upper fs.

Generate a non-persistent uuid per overlayfs instance and use it as the
seed for f_fsid, similar to tmpfs instance uuid/fsid.

The old behavior can be restored with mount option uuid=nogen.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/overlayfs.rst | 10 +++---
 fs/overlayfs/overlayfs.h                |  6 ++++
 fs/overlayfs/ovl_entry.h                |  2 +-
 fs/overlayfs/super.c                    | 46 +++++++++++++++++++++----
 4 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 4c76fda07645..ad48ae9d3c43 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -571,10 +571,12 @@ Note: the mount options index=off,nfs_export=on are conflicting for a
 read-write mount and will result in an error.
 
 Note: the mount option uuid=off can be used to replace UUID of the underlying
-filesystem in file handles with null, and effectively disable UUID checks. This
-can be useful in case the underlying disk is copied and the UUID of this copy
-is changed. This is only applicable if all lower/upper/work directories are on
-the same filesystem, otherwise it will fallback to normal behaviour.
+filesystem in file handles with null, and effectively disable UUID checks.
+This can be useful in case the underlying disk is copied and the UUID of this
+copy is changed.  This is only applicable if all lower/upper/work directories
+are on the same filesystem, otherwise it will fallback to normal behaviour.
+The mount option uuid=nogen can be used to disable UUID generation for the
+overlay filesystem itself.  The two mount options are mutually exclusive.
 
 Volatile mount
 --------------
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87d44b889129..dcdb02d0ddf8 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -63,6 +63,12 @@ enum {
 	OVL_XINO_ON,
 };
 
+enum {
+	OVL_UUID_OFF,
+	OVL_UUID_NOGEN,
+	OVL_UUID_ON,
+};
+
 /*
  * The tuple (fh,uuid) is a universal unique identifier for a copy up origin,
  * where:
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 5cc0b6e65488..4f396b1ce2fb 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -14,7 +14,7 @@ struct ovl_config {
 	bool redirect_follow;
 	const char *redirect_mode;
 	bool index;
-	bool uuid;
+	int uuid;
 	bool nfs_export;
 	int xino;
 	bool metacopy;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5ed8c2650293..ad2250f98b38 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -317,6 +317,7 @@ static int ovl_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
 	struct dentry *root_dentry = dentry->d_sb->s_root;
+	uuid_t *uuid = &dentry->d_sb->s_uuid;
 	struct path path;
 	int err;
 
@@ -326,6 +327,8 @@ static int ovl_statfs(struct dentry *dentry, struct kstatfs *buf)
 	if (!err) {
 		buf->f_namelen = ofs->namelen;
 		buf->f_type = OVERLAYFS_SUPER_MAGIC;
+		if (!uuid_is_null(uuid))
+			buf->f_fsid = uuid_to_fsid(uuid->b);
 	}
 
 	return err;
@@ -353,6 +356,25 @@ static inline int ovl_xino_def(void)
 	return ovl_xino_auto_def ? OVL_XINO_AUTO : OVL_XINO_OFF;
 }
 
+static const char * const ovl_uuid_str[] = {
+	"off",
+	"nogen",
+	"on",
+};
+
+/* XXX: do we need a config for this? */
+static const bool ovl_uuid_gen_def = true;
+
+static inline int ovl_uuid_def(void)
+{
+	return ovl_uuid_gen_def ? OVL_UUID_ON : OVL_UUID_NOGEN;
+}
+
+static inline int ovl_want_uuid_gen(struct ovl_fs *ofs)
+{
+	return ofs->config.uuid != OVL_UUID_NOGEN;
+}
+
 /**
  * ovl_show_options
  * @m: the seq_file handle
@@ -377,8 +399,8 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 		seq_printf(m, ",redirect_dir=%s", ofs->config.redirect_mode);
 	if (ofs->config.index != ovl_index_def)
 		seq_printf(m, ",index=%s", ofs->config.index ? "on" : "off");
-	if (!ofs->config.uuid)
-		seq_puts(m, ",uuid=off");
+	if (ofs->config.uuid != ovl_uuid_def())
+		seq_printf(m, ",uuid=%s", ovl_uuid_str[ofs->config.uuid]);
 	if (ofs->config.nfs_export != ovl_nfs_export_def)
 		seq_printf(m, ",nfs_export=%s", ofs->config.nfs_export ?
 						"on" : "off");
@@ -437,6 +459,7 @@ enum {
 	OPT_INDEX_OFF,
 	OPT_UUID_ON,
 	OPT_UUID_OFF,
+	OPT_UUID_NOGEN,
 	OPT_NFS_EXPORT_ON,
 	OPT_USERXATTR,
 	OPT_NFS_EXPORT_OFF,
@@ -460,6 +483,7 @@ static const match_table_t ovl_tokens = {
 	{OPT_USERXATTR,			"userxattr"},
 	{OPT_UUID_ON,			"uuid=on"},
 	{OPT_UUID_OFF,			"uuid=off"},
+	{OPT_UUID_NOGEN,		"uuid=nogen"},
 	{OPT_NFS_EXPORT_ON,		"nfs_export=on"},
 	{OPT_NFS_EXPORT_OFF,		"nfs_export=off"},
 	{OPT_XINO_ON,			"xino=on"},
@@ -581,11 +605,15 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			break;
 
 		case OPT_UUID_ON:
-			config->uuid = true;
+			config->uuid = OVL_UUID_ON;
 			break;
 
 		case OPT_UUID_OFF:
-			config->uuid = false;
+			config->uuid = OVL_UUID_OFF;
+			break;
+
+		case OPT_UUID_NOGEN:
+			config->uuid = OVL_UUID_NOGEN;
 			break;
 
 		case OPT_NFS_EXPORT_ON:
@@ -1924,7 +1952,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	ofs->share_whiteout = true;
 
 	ofs->config.index = ovl_index_def;
-	ofs->config.uuid = true;
+	ofs->config.uuid = ovl_uuid_def();
 	ofs->config.nfs_export = ovl_nfs_export_def;
 	ofs->config.xino = ovl_xino_def();
 	ofs->config.metacopy = ovl_metacopy_def;
@@ -2019,10 +2047,14 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_flags |= SB_RDONLY;
 
 	if (!ofs->config.uuid && ofs->numfs > 1) {
-		pr_warn("The uuid=off requires a single fs for lower and upper, falling back to uuid=on.\n");
-		ofs->config.uuid = true;
+		ofs->config.uuid = ovl_uuid_def();
+		pr_warn("The uuid=off requires a single fs for lower and upper, falling back to uuid=%s.\n",
+			ovl_uuid_str[ofs->config.uuid]);
 	}
 
+	if (ovl_want_uuid_gen(ofs))
+		uuid_gen(&sb->s_uuid);
+
 	if (!ovl_force_readonly(ofs) && ofs->config.index) {
 		err = ovl_get_indexdir(sb, ofs, oe, &upperpath);
 		if (err)
-- 
2.34.1

