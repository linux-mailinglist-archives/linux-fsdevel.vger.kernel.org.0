Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150AA5E5DC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiIVIpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiIVIo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC7A00E1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1pR2BYypep7fpfPKTSIp9hGnNDl6nJRFYw8u5/Oigo=;
        b=VMYNtugNiA3EY0uOitwKxAh6ZbNk1UyHj9ePyML+dGEx/bkpKmH79e5oLGHTsgZOU+e/f7
        DrnJU956cywpkTugToVd/0kNUY4Pn3YlOsA1uCT8xu8CX9gcLKYgH9jrdx9UG7Bp/hPB2s
        JiIRxhX+5CcSsE16uO0aflMvVYONtSM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-hB8jw7QkPWu8PjWth57cpg-1; Thu, 22 Sep 2022 04:44:51 -0400
X-MC-Unique: hB8jw7QkPWu8PjWth57cpg-1
Received: by mail-ej1-f70.google.com with SMTP id sa15-20020a1709076d0f00b00781d793f51fso1340081ejc.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=K1pR2BYypep7fpfPKTSIp9hGnNDl6nJRFYw8u5/Oigo=;
        b=VljOH3NKAAobpotmlNS1ILDk3ItIQyiJfQG7m5wAbNjcnXKn2G+6TQdTSbvQZk6/tB
         e3Yzwkh9MURsOiwv+QgY3sKX9B09NWQEVe3cjwhqiLEWryH7uD0uxU0ZaPKF77+c/p+0
         ghNWHsqpaZ/m1VWOX5e6vFkMGysm+A/dYae/VqOKS5fDomylPNDSwzP7hKb6xuwHZ/Fb
         9yuF0W1kTvK9lF9LGWaQEl1ugKO1CEjjgWGSIOZ/XNNQHAgdJqF5Z8gzI4b4Fh96lIzN
         CXGPMD7EMGjlMBbccuyGkWceKuGdxPiH8EAX6F1jDt6oHROhrGEfZRqqnuQIOWcpUo63
         Vazw==
X-Gm-Message-State: ACrzQf3DRC/fXSEFcXk2B7FXuc79ftaXjJBggHxFEm3iRnhbHqvnl46x
        rgAnogced7HVYySa/0O+cjZCbcu+mVDpkCVZtnhidjgtB/R7Jw5M44RgDMA0B+sAQzrxjGTu5Mu
        rKeIY5j8bDjrJNcjf4Ug26IsdA1cNstnerqD5Z7aXk7QbOTmQlPlXf9WGxZTryl7+7IFQe8fQI1
        PYtg==
X-Received: by 2002:a17:907:97cd:b0:780:6829:cb9d with SMTP id js13-20020a17090797cd00b007806829cb9dmr1923918ejc.344.1663836290152;
        Thu, 22 Sep 2022 01:44:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7JJW4IRkVzDZsjbqAsH4ChxfLNwqDIITtK4puuJWwHSJhBuG9Auerz/4iSSDAD6oR6P0BTTg==
X-Received: by 2002:a17:907:97cd:b0:780:6829:cb9d with SMTP id js13-20020a17090797cd00b007806829cb9dmr1923892ejc.344.1663836289856;
        Thu, 22 Sep 2022 01:44:49 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:49 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 05/10] cachefiles: use vfs_tmpfile_open() helper
Date:   Thu, 22 Sep 2022 10:44:37 +0200
Message-Id: <20220922084442.2401223-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922084442.2401223-1-mszeredi@redhat.com>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the vfs_tmpfile_open() helper instead of doing tmpfile creation and
opening separately.

The only minor difference is that previously no permission checking was
done, while vfs_tmpfile_open() will call may_open() with zero access mask
(i.e. no access is checked).  Even if this would make a difference with
callers caps (don't see how it could, even in the LSM codepaths) cachfiles
raises caps before performing the tmpfile creation, so this extra
permission check will not result in any regression.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/cachefiles/namei.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 4d04f5fb49f3..622d7c644bd4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -446,18 +446,19 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	const struct cred *saved_cred;
 	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
 	struct file *file;
-	struct path path;
+	const struct path parentpath = { .mnt = cache->mnt, .dentry = fan };
 	uint64_t ni_size;
 	long ret;
 
 
 	cachefiles_begin_secure(cache, &saved_cred);
 
-	path.mnt = cache->mnt;
 	ret = cachefiles_inject_write_error();
 	if (ret == 0) {
-		path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
-		ret = PTR_ERR_OR_ZERO(path.dentry);
+		file = vfs_tmpfile_open(&init_user_ns, &parentpath, S_IFREG,
+					O_RDWR | O_LARGEFILE | O_DIRECT,
+					cache->cache_cred);
+		ret = PTR_ERR_OR_ZERO(file);
 	}
 	if (ret) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), ret,
@@ -467,10 +468,10 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		goto err;
 	}
 
-	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
+	trace_cachefiles_tmpfile(object, file_inode(file));
 
 	/* This is a newly created file with no other possible user */
-	if (!cachefiles_mark_inode_in_use(object, d_inode(path.dentry)))
+	if (!cachefiles_mark_inode_in_use(object, file_inode(file)))
 		WARN_ON(1);
 
 	ret = cachefiles_ondemand_init_object(object);
@@ -481,27 +482,19 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 
 	if (ni_size > 0) {
-		trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
+		trace_cachefiles_trunc(object, file_inode(file), 0, ni_size,
 				       cachefiles_trunc_expand_tmpfile);
 		ret = cachefiles_inject_write_error();
 		if (ret == 0)
-			ret = vfs_truncate(&path, ni_size);
+			ret = vfs_truncate(&file->f_path, ni_size);
 		if (ret < 0) {
 			trace_cachefiles_vfs_error(
-				object, d_backing_inode(path.dentry), ret,
+				object, file_inode(file), ret,
 				cachefiles_trace_trunc_error);
 			goto err_unuse;
 		}
 	}
 
-	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   d_backing_inode(path.dentry), cache->cache_cred);
-	ret = PTR_ERR(file);
-	if (IS_ERR(file)) {
-		trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
-					   ret, cachefiles_trace_open_error);
-		goto err_unuse;
-	}
 	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
@@ -509,14 +502,13 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		pr_notice("Cache does not support read_iter and write_iter\n");
 		goto err_unuse;
 	}
-	dput(path.dentry);
 out:
 	cachefiles_end_secure(cache, saved_cred);
 	return file;
 
 err_unuse:
-	cachefiles_do_unmark_inode_in_use(object, d_inode(path.dentry));
-	dput(path.dentry);
+	cachefiles_do_unmark_inode_in_use(object, file_inode(file));
+	fput(file);
 err:
 	file = ERR_PTR(ret);
 	goto out;
-- 
2.37.3

