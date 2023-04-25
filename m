Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665946EE2D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjDYNWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjDYNWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:22:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390AE13C1F;
        Tue, 25 Apr 2023 06:22:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2febac9cacdso3498551f8f.1;
        Tue, 25 Apr 2023 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682428954; x=1685020954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8rtXwAOvwWhj9+w9vh8bXBpUv7WQrAKy9uaYdSbf6A=;
        b=RPQ6oXXsgdWvs7D+BjdFHSuDeQ1Dbgow1h5nMxjk0T2CbxxVVh1QwmBW5jPblCUFzx
         vmY8H6j0SazAHG4OBsGbHBwMZ2AB2RyrZwCgKcJa78m2UHqtwthqq1LIp7+DBmV7wtcJ
         E9rtEbuicAdxL5j1KBGsk/BoBornD0mrA3cVb8ysfdxI3AVmuDpAEI5idnyU1g5pYSED
         C23KsIZQIoke1BTexVKXjM53JxFN7VSKPHonT6/stwf0ZkQSP8DxlYu3PB9NJiG9S+FZ
         cwnH63j3C50P+or2JLWweC84XhKvUkMa+564bFC95zH2kUXUSVUEiY4X0P/hjhAEQGQU
         obbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428954; x=1685020954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8rtXwAOvwWhj9+w9vh8bXBpUv7WQrAKy9uaYdSbf6A=;
        b=mF1FOt9LbLoAUQyhqc7lZFIJ29jdrMnTJokhjlI9mnx0OXZMGCucev5f5E7NXSniu6
         hKKX/nQQL/m/+p/wU95DxVxzIqiHwjKkovk6kUbU6xzTYblxSyORV8NDzvSwEwi4nREq
         4uM6EZAqO/28SqQ9C13VQl6nzBNPzjVEgKwADCJ8hEc9+bowlg4BUDBDd02CYYp5zMSd
         Y4CtZEqRaA6WEfUqCNiG8nqFm9CYuow9MMY0FTc5ByAelc1D5hb4WEMXJBtVq5r5uEV3
         njxqNLTsp94pb+EFA0Bq547kQTluDF4zWX4Tr/ZL0Cbf5AqCd7TRRy3oldyz4ro9XXp/
         RVzA==
X-Gm-Message-State: AAQBX9cPiNklr50OrH1GWEKo5+xqp+9nd8EpHskjPdYC1SjOQJ4LVYR7
        LLGw3iTiOZdWDei9H9MKpFY=
X-Google-Smtp-Source: AKy350aSWuoVwaSqvDF5d2453qX5a9nWQuRqywd1cdA4dJP7+UHHSbA8FVTFftepust71sSTaMoBcw==
X-Received: by 2002:a5d:4acb:0:b0:2f7:80d9:bb2f with SMTP id y11-20020a5d4acb000000b002f780d9bb2fmr11945213wrs.22.1682428954431;
        Tue, 25 Apr 2023 06:22:34 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002f9ff443184sm13076973wrj.24.2023.04.25.06.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:22:34 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 3/3] ovl: use persistent s_uuid with index=on
Date:   Tue, 25 Apr 2023 16:22:23 +0300
Message-Id: <20230425132223.2608226-4-amir73il@gmail.com>
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

With index=on, overlayfs instances are non-migratable, meaning that
the layers cannot be copied without breaking the index.

So when indexdir exists, store a persistent uuid in xattr on the
indexdir to give the overlayfs instance a persistent identifier.

This also makes f_fsid persistent and more reliable for reporting
fid info in fanotify events.

With mount option uuid=nogen, a persistent uuid is not be initialized
on indexdir, but if a persistent uuid already exists, it will be used.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/overlayfs.h |  3 +++
 fs/overlayfs/super.c     |  7 +++++++
 fs/overlayfs/util.c      | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index dcdb02d0ddf8..9927472a3aaa 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -36,6 +36,7 @@ enum ovl_xattr {
 	OVL_XATTR_IMPURE,
 	OVL_XATTR_NLINK,
 	OVL_XATTR_UPPER,
+	OVL_XATTR_UUID,
 	OVL_XATTR_METACOPY,
 	OVL_XATTR_PROTATTR,
 };
@@ -431,6 +432,8 @@ bool ovl_already_copied_up(struct dentry *dentry, int flags);
 bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
 			      enum ovl_xattr ox);
 bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct path *path);
+bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
+			 struct dentry *upperdentry, bool set);
 
 static inline bool ovl_check_origin_xattr(struct ovl_fs *ofs,
 					  struct dentry *upperdentry)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ad2250f98b38..8364620e8722 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1535,6 +1535,9 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 		if (err)
 			pr_err("failed to verify index dir 'upper' xattr\n");
 
+		/* Best effort get or set persistent uuid */
+		ovl_init_uuid_xattr(sb, ofs, ofs->indexdir, true);
+
 		/* Cleanup bad/stale/orphan index entries */
 		if (!err)
 			err = ovl_indexdir_cleanup(ofs);
@@ -2052,6 +2055,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 			ovl_uuid_str[ofs->config.uuid]);
 	}
 
+	/*
+	 * This uuid may be overridden by a persistent uuid stored in xattr on
+	 * index dir and it may be persisted in xattr on first index=on mount.
+	 */
 	if (ovl_want_uuid_gen(ofs))
 		uuid_gen(&sb->s_uuid);
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 923d66d131c1..8902db4b2975 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -589,6 +589,45 @@ bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct path *path)
 	return false;
 }
 
+/*
+ * Load persistent uuid from xattr into s_uuid if found, possibly overriding
+ * the random generated value in s_uuid.
+ * Otherwise, if @set is true and s_uuid contains a valid value, store this
+ * value in xattr.
+ */
+bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
+			 struct dentry *upperdentry, bool set)
+{
+	struct path path = {
+		.dentry = upperdentry,
+		.mnt = ovl_upper_mnt(ofs),
+	};
+	uuid_t uuid;
+	int res;
+
+	res = ovl_path_getxattr(ofs, &path, OVL_XATTR_UUID, uuid.b, UUID_SIZE);
+	if (res == UUID_SIZE) {
+		uuid_copy(&sb->s_uuid, &uuid);
+		return true;
+	}
+
+	if (res == -ENODATA) {
+		if (!set || uuid_is_null(&sb->s_uuid))
+			return false;
+
+		res = ovl_setxattr(ofs, upperdentry, OVL_XATTR_UUID,
+				   sb->s_uuid.b, UUID_SIZE);
+		if (res == 0)
+			return true;
+	} else {
+		set = false;
+	}
+
+	pr_warn("failed to %s uuid (%pd2, err=%i)\n",
+		set ? "set" : "get", upperdentry, res);
+	return false;
+}
+
 bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
 			       enum ovl_xattr ox)
 {
@@ -611,6 +650,7 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
 #define OVL_XATTR_IMPURE_POSTFIX	"impure"
 #define OVL_XATTR_NLINK_POSTFIX		"nlink"
 #define OVL_XATTR_UPPER_POSTFIX		"upper"
+#define OVL_XATTR_UUID_POSTFIX		"uuid"
 #define OVL_XATTR_METACOPY_POSTFIX	"metacopy"
 #define OVL_XATTR_PROTATTR_POSTFIX	"protattr"
 
@@ -625,6 +665,7 @@ const char *const ovl_xattr_table[][2] = {
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_IMPURE),
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_NLINK),
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_UPPER),
+	OVL_XATTR_TAB_ENTRY(OVL_XATTR_UUID),
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_METACOPY),
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_PROTATTR),
 };
-- 
2.34.1

