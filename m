Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CE4ED85D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiCaLZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 07:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiCaLZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46CD6177;
        Thu, 31 Mar 2022 04:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 559A7615B1;
        Thu, 31 Mar 2022 11:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE40EC340ED;
        Thu, 31 Mar 2022 11:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648725820;
        bh=oRCBnn7kgkdw7xTjPeB7+5HZ/LNct9wkcy1uiAQq5z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/+3T36UJr+0tqOb8CmWtf+mT+Ppq0B34ZarJVGk2JSrX/0M95d/GzpEO8SunYszg
         4T1t/MQGGyxZ28Ld6Qt5sOoEnUyV/vYdX+ZaVKj4CyXvUEPWkpxn/SiMnqlVlZOAy1
         8WI/zFufJfUIyT32SCMYTM/jnF8CBfVsmIPK4ejwx6AnmQK309Ohg0fE5+V33hnCxF
         YoTJlozaAFom78AzUZ5yyt1FbVqtZnPUXIZmEOOdCcJFRe4TNHgbV3LUR/8h5yVRVd
         eTtXFYMn2F8eYzNUetkp30+LNcIwUv/iloKr5LKa0qnXSocu6Ai01CjqiQE5Zn71zD
         713sTxoi9MV1Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>
Subject: [PATCH v3 01/19] fs: add two trivial lookup helpers
Date:   Thu, 31 Mar 2022 13:22:59 +0200
Message-Id: <20220331112318.1377494-2-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331112318.1377494-1-brauner@kernel.org>
References: <20220331112318.1377494-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5711; h=from:subject; bh=oRCBnn7kgkdw7xTjPeB7+5HZ/LNct9wkcy1uiAQq5z4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS59ovLcu74qJa3e/4D9sSqjEd6k7+lLw7kirq7unSKTPWL s9m/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS18jw36XT7rjG/5xJkdse9Rr3r3 b7pSaiL7fhpHqszdHlTgtnz2X4zcIawF7uuCtU8F3rSZkZKa9Ejjw0P223KJO5NcA/in87KwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to the addition of lookup_one() add a version of
lookup_one_unlocked() and lookup_one_positive_unlocked() that take
idmapped mounts into account. This is required to port overlay to
support idmapped base layers.

Cc: <linux-fsdevel@vger.kernel.org>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
unchanged

/* v3 */
- Christoph Hellwig <hch@lst.de>:
  - Wrap overly long lines.
  - Add kerneldoc for lookup_one_positive_unlocked().
---
 fs/namei.c            | 69 ++++++++++++++++++++++++++++++++++++-------
 include/linux/namei.h |  6 ++++
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..d76f4dde6179 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2768,7 +2768,8 @@ struct dentry *lookup_one(struct user_namespace *mnt_userns, const char *name,
 EXPORT_SYMBOL(lookup_one);
 
 /**
- * lookup_one_len_unlocked - filesystem helper to lookup single pathname component
+ * lookup_one_unlocked - filesystem helper to lookup single pathname component
+ * @mnt_userns:	idmapping of the mount the lookup is performed from
  * @name:	pathname component to lookup
  * @base:	base directory to lookup from
  * @len:	maximum length @len should be interpreted to
@@ -2779,14 +2780,15 @@ EXPORT_SYMBOL(lookup_one);
  * Unlike lookup_one_len, it should be called without the parent
  * i_mutex held, and will take the i_mutex itself if necessary.
  */
-struct dentry *lookup_one_len_unlocked(const char *name,
-				       struct dentry *base, int len)
+struct dentry *lookup_one_unlocked(struct user_namespace *mnt_userns,
+				   const char *name, struct dentry *base,
+				   int len)
 {
 	struct qstr this;
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_common(&init_user_ns, name, base, len, &this);
+	err = lookup_one_common(mnt_userns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2795,6 +2797,58 @@ struct dentry *lookup_one_len_unlocked(const char *name,
 		ret = lookup_slow(&this, base, 0);
 	return ret;
 }
+EXPORT_SYMBOL(lookup_one_unlocked);
+
+/**
+ * lookup_one_positive_unlocked - filesystem helper to lookup single
+ *				  pathname component
+ * @mnt_userns:	idmapping of the mount the lookup is performed from
+ * @name:	pathname component to lookup
+ * @base:	base directory to lookup from
+ * @len:	maximum length @len should be interpreted to
+ *
+ * This helper will yield ERR_PTR(-ENOENT) on negatives. The helper returns
+ * known positive or ERR_PTR(). This is what most of the users want.
+ *
+ * Note that pinned negative with unlocked parent _can_ become positive at any
+ * time, so callers of lookup_one_unlocked() need to be very careful; pinned
+ * positives have >d_inode stable, so this one avoids such problems.
+ *
+ * Note that this routine is purely a helper for filesystem usage and should
+ * not be called by generic code.
+ *
+ * The helper should be called without i_mutex held.
+ */
+struct dentry *lookup_one_positive_unlocked(struct user_namespace *mnt_userns,
+					    const char *name,
+					    struct dentry *base, int len)
+{
+	struct dentry *ret = lookup_one_unlocked(mnt_userns, name, base, len);
+	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
+		dput(ret);
+		ret = ERR_PTR(-ENOENT);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(lookup_one_positive_unlocked);
+
+/**
+ * lookup_one_len_unlocked - filesystem helper to lookup single pathname component
+ * @name:	pathname component to lookup
+ * @base:	base directory to lookup from
+ * @len:	maximum length @len should be interpreted to
+ *
+ * Note that this routine is purely a helper for filesystem usage and should
+ * not be called by generic code.
+ *
+ * Unlike lookup_one_len, it should be called without the parent
+ * i_mutex held, and will take the i_mutex itself if necessary.
+ */
+struct dentry *lookup_one_len_unlocked(const char *name,
+				       struct dentry *base, int len)
+{
+	return lookup_one_unlocked(&init_user_ns, name, base, len);
+}
 EXPORT_SYMBOL(lookup_one_len_unlocked);
 
 /*
@@ -2808,12 +2862,7 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
 struct dentry *lookup_positive_unlocked(const char *name,
 				       struct dentry *base, int len)
 {
-	struct dentry *ret = lookup_one_len_unlocked(name, base, len);
-	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
-		dput(ret);
-		ret = ERR_PTR(-ENOENT);
-	}
-	return ret;
+	return lookup_one_positive_unlocked(&init_user_ns, name, base, len);
 }
 EXPORT_SYMBOL(lookup_positive_unlocked);
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index e89329bb3134..caeb08a98536 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -69,6 +69,12 @@ extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
 struct dentry *lookup_one(struct user_namespace *, const char *, struct dentry *, int);
+struct dentry *lookup_one_unlocked(struct user_namespace *mnt_userns,
+				   const char *name, struct dentry *base,
+				   int len);
+struct dentry *lookup_one_positive_unlocked(struct user_namespace *mnt_userns,
+					    const char *name,
+					    struct dentry *base, int len);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
-- 
2.32.0

