Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4825BCE1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiISOKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiISOKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2114131EF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsXdvDdXKGBsyyVjzb1UKYoyRx8HM75Tqi022HaH4Io=;
        b=bGiTFG4zXcRcY1E/kGgOC9WEN7e7N7pmazChuhR9ayn4OBa+FrbnSMtSHxJhZ566SctcG1
        F111+SbAVPqa0Yam7KtgXmYbskxi+2O2gm3Ii6Ogt4wK4bTXyu6nnhK8o4+Qt5uWuJV62m
        FUfnPGO+Q43Mnb5JkoDbc+iAlRW02Gc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-207-AFha9x9FNWuNqh4r_JtrPQ-1; Mon, 19 Sep 2022 10:10:39 -0400
X-MC-Unique: AFha9x9FNWuNqh4r_JtrPQ-1
Received: by mail-ed1-f71.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so20220812edc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BsXdvDdXKGBsyyVjzb1UKYoyRx8HM75Tqi022HaH4Io=;
        b=zAVAJKzMQ4O/Zg2k1521estapQT+VTKmLPRA7uQtGo7iVY+iaQQO6eaH67/hCvuaJ4
         l5f0UqqSyW5Nr34gGe1Z8M2t+gW3fxvkgIv/fJzgSaAgInzQrMHQQRCU0DIzlVQumvBj
         yMumQNcUhBS4rPLxGlXB1kGG47Pivyx4GT9uiXmeqacwagP7t/oxNo8qM74thwBr4iRO
         il6bolv4WbFtb0vx1cqA55/weTW5JIdeRfCQsiW+N4HPadeU9vZEyfsSvN+dyji1kp5W
         sNRsySt0zqAgIRqofM9aMIl033ktlScKrGN/Nos+HQeb9drGPGUunkcHZk1rOcwfIYu4
         d8sQ==
X-Gm-Message-State: ACrzQf0L4VuEK7VQ+bVuYxinUzINU/yD1xpfbGxd4a/0dNygInvEBZqs
        fIw+vxa4P/cZiBgMkpQjisWUL1j/J5GUT6qJWm79I/3+9FbJ4VM4g93K4Bjim+56w3Z+fv0UiwD
        yoCkAgcHxPKfAZewd4QdEqJMmre90PAWhd/itYvZvyoJCkFHk4FIm0IJoJQJdGVE5Jm+p59bNm7
        EMmQ==
X-Received: by 2002:a17:907:9714:b0:77b:e7a8:2f66 with SMTP id jg20-20020a170907971400b0077be7a82f66mr13272989ejc.107.1663596638220;
        Mon, 19 Sep 2022 07:10:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7uXI9H+uNxeq9FKnN99bzt71LLpGwB7rQAC0KMU6V9zJ675V7HrLHvOdTvw/Fj+j2OVmYrNA==
X-Received: by 2002:a17:907:9714:b0:77b:e7a8:2f66 with SMTP id jg20-20020a170907971400b0077be7a82f66mr13272966ejc.107.1663596637962;
        Mon, 19 Sep 2022 07:10:37 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:37 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 3/8] cachefiles: use tmpfile_open() helper
Date:   Mon, 19 Sep 2022 16:10:26 +0200
Message-Id: <20220919141031.1834447-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919141031.1834447-1-mszeredi@redhat.com>
References: <20220919141031.1834447-1-mszeredi@redhat.com>
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

Use the tmpfile_open() helper instead of doing tmpfile creation and opening
separately.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/cachefiles/namei.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d3a5884fe5c9..44f575328af4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -451,18 +451,19 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	const struct cred *saved_cred;
 	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
 	struct file *file;
-	struct path path;
+	struct path path = { .mnt = cache->mnt, .dentry = fan };
 	uint64_t ni_size;
 	long ret;
 
 
 	cachefiles_begin_secure(cache, &saved_cred);
 
-	path.mnt = cache->mnt;
 	ret = cachefiles_inject_write_error();
 	if (ret == 0) {
-		path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
-		ret = PTR_ERR_OR_ZERO(path.dentry);
+		file = tmpfile_open(&init_user_ns, &path, S_IFREG,
+				    O_RDWR | O_LARGEFILE | O_DIRECT,
+				    cache->cache_cred);
+		ret = PTR_ERR_OR_ZERO(file);
 	}
 	if (ret) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), ret,
@@ -471,12 +472,14 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 			cachefiles_io_error_obj(object, "Failed to create tmpfile");
 		goto err;
 	}
+	/* From now path refers to the tmpfile */
+	path.dentry = file->f_path.dentry;
 
 	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
 
 	ret = -EBUSY;
 	if (!cachefiles_mark_inode_in_use(object, path.dentry))
-		goto err_dput;
+		goto err_fput;
 
 	ret = cachefiles_ondemand_init_object(object);
 	if (ret < 0)
@@ -499,14 +502,6 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
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
@@ -514,15 +509,14 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		pr_notice("Cache does not support read_iter and write_iter\n");
 		goto err_unuse;
 	}
-	dput(path.dentry);
 out:
 	cachefiles_end_secure(cache, saved_cred);
 	return file;
 
 err_unuse:
 	cachefiles_do_unmark_inode_in_use(object, path.dentry);
-err_dput:
-	dput(path.dentry);
+err_fput:
+	fput(file);
 err:
 	file = ERR_PTR(ret);
 	goto out;
-- 
2.37.3

