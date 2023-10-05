Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4E57B9EDD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjJEOOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjJEOMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:12:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3624864;
        Thu,  5 Oct 2023 04:16:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so861319f8f.1;
        Thu, 05 Oct 2023 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696504564; x=1697109364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xeKrgt2PObn5BYrkIQTlAAhvL5PwerUzmeVsDKTDmUE=;
        b=Afha9qOj3U8Zm5nXxX+vwj19AxICf4QIeVoVnip40nN40+dXhH4YPbvnFokM6hrKB8
         0snq3lJd7TPE9I1qRbPoOaNCc4ee8BZfK98WbCCqn/GYxUdfvMPARK+OivDIB14TGMQC
         NdzATWnTrX8g1aLO+xE/sLZN9esmYTI7g2W020qRTovO8L8u3K1kZ5AXPuAv58+4q7Vd
         i9oTtgwJWhed/Ydxo50b0oXHbUPr2oHqhtZ3GA3pPuNxKQkiUXNmgCZNgWB5nNcKiPvc
         v4FvJWO02614bFcT8cybewbu25O1KY62cAhOAUwXc1MGNUp1zAABqJN4xu5cEJs4ySIA
         08Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696504564; x=1697109364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeKrgt2PObn5BYrkIQTlAAhvL5PwerUzmeVsDKTDmUE=;
        b=BFZuEbokeghqEQZ7pgu7gg434sf9+QNf5JSmM4Mox5gcgZHxYycr6QQOTU/ygBQRcy
         Z1lG5VXnz1WgOe+VJIXTZnFF4Zlokgis9WwMG7qF7BHoDKwevX5S7wxYhKzRjZ6oXO+U
         u2VFtJDeA/6d9ojU+1gavfvAS2nrYaGnH98DFALxfQs7yTikfgcv+v1FU5b5YBB5vnAE
         GjwKh8R2iofVrVxkffSqgi/t5mpfXEFVSqnVWe4NnRi8Vj+P0BSyFqZ/KYbPBMW+MkzW
         whI8JxhSvn1ji4COupfohAtU2yZPnezXI6UutyaFKUTvLAu7JD6q4eUEgs+CcyHHU4mt
         8x2Q==
X-Gm-Message-State: AOJu0YyEzoVk5Tm13jXKyBOxAT7sgDTVeuQZzPCmnKi93sSwJTTon96o
        6SL9UQtEg6uL+g0CsErVLcY=
X-Google-Smtp-Source: AGHT+IFMA1coSmCYvnBs92G91Z67oy5exgUrf/EGcvBwscocCGaLzGjLCqJ6aspz3E4Rn2zHMXBJGQ==
X-Received: by 2002:adf:edce:0:b0:317:58e4:e941 with SMTP id v14-20020adfedce000000b0031758e4e941mr4679699wro.33.1696504563834;
        Thu, 05 Oct 2023 04:16:03 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d628f000000b003143c9beeaesm1545169wru.44.2023.10.05.04.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 04:16:03 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com
Subject: [PATCH] ima: annotate iint mutex to avoid lockdep false positive warnings
Date:   Thu,  5 Oct 2023 14:15:58 +0300
Message-Id: <20231005111558.1263671-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is not clear that IMA should be nested at all, but as long is it
measures files both on overlayfs and on underlying fs, we need to
annotate the iint mutex to avoid lockdep false positives related to
IMA + overlayfs, same as overlayfs annotates the inode mutex.

Reported-and-tested-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Mimi,

Syzbot finally found a reliable reproducer, so it tested this lockdep
annotation fix and this proves that the warning was a false positive.

Hopefully, this will fix all the different variants of lockdep warnings
that syzbot reported over time.

Thanks,
Amir.

 security/integrity/iint.c | 48 ++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index a462df827de2..27ea19fb1f54 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -66,9 +66,32 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
 	return iint;
 }
 
-static void iint_free(struct integrity_iint_cache *iint)
+#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
+
+/*
+ * It is not clear that IMA should be nested at all, but as long is it measures
+ * files both on overlayfs and on underlying fs, we need to annotate the iint
+ * mutex to avoid lockdep false positives related to IMA + overlayfs.
+ * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ */
+static inline void iint_lockdep_annotate(struct integrity_iint_cache *iint,
+					 struct inode *inode)
+{
+#ifdef CONFIG_LOCKDEP
+	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
+
+	int depth = inode->i_sb->s_stack_depth;
+
+	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
+		depth = 0;
+
+	lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
+#endif
+}
+
+static void iint_init_always(struct integrity_iint_cache *iint,
+			     struct inode *inode)
 {
-	kfree(iint->ima_hash);
 	iint->ima_hash = NULL;
 	iint->version = 0;
 	iint->flags = 0UL;
@@ -80,6 +103,14 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+	mutex_init(&iint->mutex);
+	iint_lockdep_annotate(iint, inode);
+}
+
+static void iint_free(struct integrity_iint_cache *iint)
+{
+	kfree(iint->ima_hash);
+	mutex_destroy(&iint->mutex);
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -104,6 +135,8 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	if (!iint)
 		return NULL;
 
+	iint_init_always(iint, inode);
+
 	write_lock(&integrity_iint_lock);
 
 	p = &integrity_iint_tree.rb_node;
@@ -153,25 +186,18 @@ void integrity_inode_free(struct inode *inode)
 	iint_free(iint);
 }
 
-static void init_once(void *foo)
+static void iint_init_once(void *foo)
 {
 	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
 
 	memset(iint, 0, sizeof(*iint));
-	iint->ima_file_status = INTEGRITY_UNKNOWN;
-	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
-	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_read_status = INTEGRITY_UNKNOWN;
-	iint->ima_creds_status = INTEGRITY_UNKNOWN;
-	iint->evm_status = INTEGRITY_UNKNOWN;
-	mutex_init(&iint->mutex);
 }
 
 static int __init integrity_iintcache_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
-			      0, SLAB_PANIC, init_once);
+			      0, SLAB_PANIC, iint_init_once);
 	return 0;
 }
 DEFINE_LSM(integrity) = {
-- 
2.34.1

