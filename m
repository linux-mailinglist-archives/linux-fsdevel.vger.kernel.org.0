Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB95BB2F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIPToY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIPToW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B0FB40F4
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663357460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PzsiJLh4qivuvaD01T8k0cktWemsb5i0yo5HxUE+jT4=;
        b=iPyfuAIcTuU3EQkpzMbafwEIQ5wTzrfFmQysrtTCq4WDV0hDBAwXDqfmysO467WiQVKCi5
        TH3QtIHz58u/Li88z2rdXz3+XiMPxuHGONaTFtzaKiaNJLpYQb55cCG7asY8OpjFFOUzbS
        4P9TehpUwuQoMckHsr3jjMu/YyemNBw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-494--B0G-7oLM7qFdljfAPsTHw-1; Fri, 16 Sep 2022 15:44:19 -0400
X-MC-Unique: -B0G-7oLM7qFdljfAPsTHw-1
Received: by mail-ed1-f71.google.com with SMTP id m3-20020a056402430300b004512f6268dbso14856856edc.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PzsiJLh4qivuvaD01T8k0cktWemsb5i0yo5HxUE+jT4=;
        b=bvmNC2uXp0qunyQ4m8Km9QbmvXOro4BN2qHAmnjB2cvlEugBWz9qSV9VE3ERjBD8A8
         7OOcIP2jwHcqSqWsiS1g62KZuN6J/F/4EHh9UR1kd9IusjI9Fz2M3h4NAKlZ0QP/wWeU
         K0RHDTf9AQtpGmNfT0y76br+q5hOpt1fj4V1ucJibmt6M26oogHGU6oeogMdqX+8O1ou
         firwVyu0rYxdRBzHkUZEs3QdIgJ9r46wsaSd6ZKpxg4pFWPJaxu0xJkV67t2kOGSq8T8
         KemlObmUvrbtANJghV7hh8iay6/kCrUXiWgIoJ2iehVjSLr55a5pVwgjnxycs+5CNdot
         52RQ==
X-Gm-Message-State: ACrzQf1ssfyK5YK4feV8WSaLIidAX9ejUEQHLQBoguT1QHMpj/3f5N3u
        qHFawAp3vOCCzhfrbWbmz5R2t4XtsxPqrJs+bDQrJCErGxVQFGQAZbrm261Cv4yDZuOB1WHGNb4
        6wT2JU0m0Rrv3sGAx4jTQRbDsS3kVKGSA47+8aoLswReUzFUwfsm0RsUwbbCWwYomQhTLZhUdpb
        fiAw==
X-Received: by 2002:a05:6402:5488:b0:443:39c5:5347 with SMTP id fg8-20020a056402548800b0044339c55347mr5331247edb.204.1663357457894;
        Fri, 16 Sep 2022 12:44:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7lpPgPBrZ7yRkhF8x7hAC4HtGKse5Ni+xK2oD4tG1gGBDrSQZh9GLa8EMdojYr2nbOnGmpQA==
X-Received: by 2002:a05:6402:5488:b0:443:39c5:5347 with SMTP id fg8-20020a056402548800b0044339c55347mr5331227edb.204.1663357457638;
        Fri, 16 Sep 2022 12:44:17 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-212-116.pool.digikabel.hu. [193.226.212.116])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0077ce503bd77sm8348592eje.129.2022.09.16.12.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:44:17 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 1/8] cachefiles: tmpfile error handling cleanup
Date:   Fri, 16 Sep 2022 21:44:09 +0200
Message-Id: <20220916194416.1657716-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
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

