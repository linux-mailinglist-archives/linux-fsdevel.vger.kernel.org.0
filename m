Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445344EAB59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 12:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiC2Kh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 06:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiC2Kh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:37:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E791379;
        Tue, 29 Mar 2022 03:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B65B816D4;
        Tue, 29 Mar 2022 10:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929E4C340ED;
        Tue, 29 Mar 2022 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648550171;
        bh=9Plb9VhvUpoxgMdSbUmt2WT8UKpSaH0M5soUNOsiWMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYG138Ozwb3KXensR/PV1+rFP1VkQY1XrmWKosQIrPOFu/QdOoURuWbx20/WgSUlD
         lrO64LTyrvpke29s2qnqIg18xPLfREYzT8z8FAhCXgzoJ6vSw1JmheNUF++qi2LdFK
         2CdRF1h6EspUpZpt97+xHZsFGh50tFZgW1rDcYNdDmxm8DF0Jyazhx3uK1cA1gjgN2
         A955rrKsNqlhJ8f0uHOV3cGBrmSZg6jSZueMPzblUJCb2gMTsXMUMeoeWVK6Pg3ROf
         QcsvbENFoRx4xN/TFrmkSWKX+dQlYHk4fOFzF7AIr1QdRPk6n0aKTKAKRrVAnEWt7s
         zOCTsDSg4UOAg==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigoca@microsoft.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>
Subject: [PATCH 01/18] fs: add two trivial lookup helpers
Date:   Tue, 29 Mar 2022 12:35:08 +0200
Message-Id: <20220329103526.1207086-2-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329103526.1207086-1-brauner@kernel.org>
References: <20220329103526.1207086-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4623; h=from:subject; bh=9Plb9VhvUpoxgMdSbUmt2WT8UKpSaH0M5soUNOsiWMA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ5Pdjz7LZIl9RX1YMVu3f6pB1eOb/93JOvnOlcD/ZMf8na NrvhXUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEbN8wMixfrV2x3GfalnV3j4bNPW 3YGSv0xbR2SZjV7pcvlFjtAjcw/DO/8TGOh+/q4uotbOWSfAz6jZnWD/lsdDVs/M+Ev1tsyAIA
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
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/namei.c            | 52 ++++++++++++++++++++++++++++++++++---------
 include/linux/namei.h |  2 ++
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..ca2a490a1f6b 100644
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
 
@@ -2795,6 +2797,41 @@ struct dentry *lookup_one_len_unlocked(const char *name,
 		ret = lookup_slow(&this, base, 0);
 	return ret;
 }
+EXPORT_SYMBOL(lookup_one_unlocked);
+
+/*
+ * Like lookup_positive_unlocked() but takes a mount's idmapping into account.
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
@@ -2808,12 +2845,7 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
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
index e89329bb3134..759b996b9e1a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -69,6 +69,8 @@ extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
 struct dentry *lookup_one(struct user_namespace *, const char *, struct dentry *, int);
+struct dentry *lookup_one_unlocked(struct user_namespace *, const char *, struct dentry *, int);
+struct dentry *lookup_one_positive_unlocked(struct user_namespace *, const char *, struct dentry *, int);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
-- 
2.32.0

