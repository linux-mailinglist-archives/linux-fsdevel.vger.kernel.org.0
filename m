Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD0744AA1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGARLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGARLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 13:11:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030951FE8;
        Sat,  1 Jul 2023 10:11:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so28104755e9.1;
        Sat, 01 Jul 2023 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688231500; x=1690823500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=imUps1Wi/n7mbEl2tSzavUqGPJw0gn6T/tuMkDGHceU=;
        b=da7IJMY1PriRs1K2viV/InaIG1mrRK7su2Ebgih+NmyQWuQwcld6R7H2Az8twFZivY
         ABCZfTvSOPcd30xAp+Tu0PBfM74Hd2lUn8m0mV6pP5Z8CtlMQO0KugciTip4IOpuIEbE
         vVXuKDBFsSMubMI50gDQ7JaHo5/d4T32eP7bmXl9H6+ZlT5OybRv43aHyLhPxjSfEQby
         jwUAVzwEWKSBeCfRVj+gX6NxUZ7rBTrL8BhXPdYt8UnGfLi09g5idrLZqYY+/QK9bAD5
         rSZtWNsRhFuZ8XZ3SVfHZUa6keRgUUwvrBx1QPleO8+Adr4ogZ5zgVF1KWUfFEnwF7mx
         /ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688231500; x=1690823500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imUps1Wi/n7mbEl2tSzavUqGPJw0gn6T/tuMkDGHceU=;
        b=cbFMQSOefARC5zoVoa147RBHziVo4ww9FjFTwqJiIWsNwn/vf7oa4Sbcg0gir3UYY2
         CL8RKwkj1u6nCwkc16xhqXurfutxWlKdliEd4FzIC7HRGW0iNZQHHjiB8qU94rKAjXsw
         cx6W9hfWp/Pi9NtetZLlfivMjbb+RN+ZDvthogUkOBHVSjBixFfhGRrgGH1bDmPyiFTv
         lADxZUYhaUd6sF39WUEMSp3j56dGgwtoLwbiVNhED4kdmEMoH60OXb7JZNijq6swmlGf
         xqyEzJ5EYXluQ1NPa4OgJUC7kTIj5jm6/bDv5rdWQPuwXtKYLYpqFylpOaRIRXC2CWwt
         ncCg==
X-Gm-Message-State: AC+VfDy+gwuImzT1XovAFIooIj932z0JDQYjG8Mb/MNbYf/HyEHk7kbT
        m45g+V9CmuPH9A7nNeMosx0=
X-Google-Smtp-Source: ACHHUZ79UKcdE06dSyqtd8amqBvHx4PTTzUeBNoMtN/Y6VPbndJGu8TbGA7KQWcJvP7+6qBzjRgDxg==
X-Received: by 2002:a05:600c:2482:b0:3fb:438f:a6c3 with SMTP id 2-20020a05600c248200b003fb438fa6c3mr4137993wms.5.1688231500149;
        Sat, 01 Jul 2023 10:11:40 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fbb5506e54sm8747499wmj.29.2023.07.01.10.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 10:11:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH] fs: fix invalid-free in init_file()
Date:   Sat,  1 Jul 2023 20:11:34 +0300
Message-Id: <20230701171134.239409-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The use of file_free_rcu() in init_file() to free the struct that was
allocated by the caller was hacky and we got what we desreved.

Let init_file() and its callers take care of cleaning up each after
their own allocated resources on error.

Reported-by: syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com
Fixes: 62d53c4a1dfe ("fs: use backing_file container for internal files with "fake" f_path")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index e06c68e2d757..fc7d677ff5ad 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -160,7 +160,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	f->f_cred = get_cred(cred);
 	error = security_file_alloc(f);
 	if (unlikely(error)) {
-		file_free_rcu(&f->f_rcuhead);
+		put_cred(f->f_cred);
 		return error;
 	}
 
@@ -208,8 +208,10 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 		return ERR_PTR(-ENOMEM);
 
 	error = init_file(f, flags, cred);
-	if (unlikely(error))
+	if (unlikely(error)) {
+		kmem_cache_free(filp_cachep, f);
 		return ERR_PTR(error);
+	}
 
 	percpu_counter_inc(&nr_files);
 
@@ -240,8 +242,10 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 		return ERR_PTR(-ENOMEM);
 
 	error = init_file(f, flags, cred);
-	if (unlikely(error))
+	if (unlikely(error)) {
+		kmem_cache_free(filp_cachep, f);
 		return ERR_PTR(error);
+	}
 
 	f->f_mode |= FMODE_NOACCOUNT;
 
@@ -265,8 +269,10 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 		return ERR_PTR(-ENOMEM);
 
 	error = init_file(&ff->file, flags, cred);
-	if (unlikely(error))
+	if (unlikely(error)) {
+		kfree(ff);
 		return ERR_PTR(error);
+	}
 
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
 	return &ff->file;
-- 
2.34.1

