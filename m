Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FAA5BCE1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiISOKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISOKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E83136D
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzsiJLh4qivuvaD01T8k0cktWemsb5i0yo5HxUE+jT4=;
        b=PPlScce04HFIG6QRSHuTlhZBKBNCQqC0pX5i262shvZ7S7SB3qgPH42jbm2/kgNPFd4DG7
        HM3s3BrCHNhZ6cPQzyNqFPafmOdsCk5Vv3afUI6zY31zNSgSjzE/vZU9IzVwqcBnlB3ByQ
        fWsvEU3zmG1ukUO/HeZKzGF9wUoqV5s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-a8lr2fz7MMiKpTRVFQBN7Q-1; Mon, 19 Sep 2022 10:10:37 -0400
X-MC-Unique: a8lr2fz7MMiKpTRVFQBN7Q-1
Received: by mail-ej1-f70.google.com with SMTP id go7-20020a1709070d8700b007793ffa7c44so10660954ejc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PzsiJLh4qivuvaD01T8k0cktWemsb5i0yo5HxUE+jT4=;
        b=AeD1+52B0pGj5i8FtB1FFy1SjDNI7j1KHnggEH66XAHLsVAOMyJWksSe4iTmnDbQJt
         5Pn1c11mbr9GI8tJDM8vYM26TMnyorYxC4pKB5VX2o6rDDL+lTdL6Uz2S8RK5L4sHIdg
         8RykDTqqmuZ0/lpnJlF9smMpHrLmHCskLI/rg/T9KBaSCHUhbhF4Qd4LyW8s38paEtDa
         X2foX9b7WgBDHt1vfL9Z0I+1NVuk8SFo1vrc0mLuVci9UlP6T9WD1+3pOvo7lXy07X5F
         LjgoG4gP1zviP2h9d3qz1HS3oLpJFSeTNx+F7x+l+R7YzNjMIVOATBLFGdIHVAG4hZv0
         I78g==
X-Gm-Message-State: ACrzQf3bOF0Ouptcdp3ym2igfR25H9CPhhDQMP+tupk3QsgF9esOwgUx
        2dzhDEaYE3Mz0BRAvdhUdZUUrj977Zw1Q/KL4Rs1Kg3xPy4J8oaYhJI3cFGv48ebZ1HaMOH8Cn6
        t+Wreu3hRxcAr4cJefZJGuJDhC/4oVkmc8zFCdHO64h8BpsNvY0r0heTdQiOJHPYlpA2sn/gHcS
        uuzA==
X-Received: by 2002:a17:906:fe4a:b0:781:3b6:f8b0 with SMTP id wz10-20020a170906fe4a00b0078103b6f8b0mr7144469ejb.183.1663596635583;
        Mon, 19 Sep 2022 07:10:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM49ZD8FDPG7yWlQMbndETaJ5I7VPYZTyruyRnOhRQY5crmhN6aO/+aVrIRE8qrk1uPISeGOtA==
X-Received: by 2002:a17:906:fe4a:b0:781:3b6:f8b0 with SMTP id wz10-20020a170906fe4a00b0078103b6f8b0mr7144444ejb.183.1663596635380;
        Mon, 19 Sep 2022 07:10:35 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:35 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 1/8] cachefiles: tmpfile error handling cleanup
Date:   Mon, 19 Sep 2022 16:10:24 +0200
Message-Id: <20220919141031.1834447-2-mszeredi@redhat.com>
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

Separate the error labels from the success path and use 'ret' to store the
error value before jumping to the error label.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/cachefiles/namei.c | 55 ++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index facf2ebe464b..d3a5884fe5c9 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -460,31 +460,27 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	path.mnt = cache->mnt;
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
+	if (ret == 0) {
 		path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
-	else
-		path.dentry = ERR_PTR(ret);
-	if (IS_ERR(path.dentry)) {
-		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(path.dentry),
+		ret = PTR_ERR_OR_ZERO(path.dentry);
+	}
+	if (ret) {
+		trace_cachefiles_vfs_error(object, d_inode(fan), ret,
 					   cachefiles_trace_tmpfile_error);
-		if (PTR_ERR(path.dentry) == -EIO)
+		if (ret == -EIO)
 			cachefiles_io_error_obj(object, "Failed to create tmpfile");
-		file = ERR_CAST(path.dentry);
-		goto out;
+		goto err;
 	}
 
 	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
 
-	if (!cachefiles_mark_inode_in_use(object, path.dentry)) {
-		file = ERR_PTR(-EBUSY);
-		goto out_dput;
-	}
+	ret = -EBUSY;
+	if (!cachefiles_mark_inode_in_use(object, path.dentry))
+		goto err_dput;
 
 	ret = cachefiles_ondemand_init_object(object);
-	if (ret < 0) {
-		file = ERR_PTR(ret);
-		goto out_unuse;
-	}
+	if (ret < 0)
+		goto err_unuse;
 
 	ni_size = object->cookie->object_size;
 	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
@@ -499,36 +495,37 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 			trace_cachefiles_vfs_error(
 				object, d_backing_inode(path.dentry), ret,
 				cachefiles_trace_trunc_error);
-			file = ERR_PTR(ret);
-			goto out_unuse;
+			goto err_unuse;
 		}
 	}
 
 	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
 				   d_backing_inode(path.dentry), cache->cache_cred);
+	ret = PTR_ERR(file);
 	if (IS_ERR(file)) {
 		trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
-					   PTR_ERR(file),
-					   cachefiles_trace_open_error);
-		goto out_unuse;
+					   ret, cachefiles_trace_open_error);
+		goto err_unuse;
 	}
+	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
 		fput(file);
 		pr_notice("Cache does not support read_iter and write_iter\n");
-		file = ERR_PTR(-EINVAL);
-		goto out_unuse;
+		goto err_unuse;
 	}
-
-	goto out_dput;
-
-out_unuse:
-	cachefiles_do_unmark_inode_in_use(object, path.dentry);
-out_dput:
 	dput(path.dentry);
 out:
 	cachefiles_end_secure(cache, saved_cred);
 	return file;
+
+err_unuse:
+	cachefiles_do_unmark_inode_in_use(object, path.dentry);
+err_dput:
+	dput(path.dentry);
+err:
+	file = ERR_PTR(ret);
+	goto out;
 }
 
 /*
-- 
2.37.3

