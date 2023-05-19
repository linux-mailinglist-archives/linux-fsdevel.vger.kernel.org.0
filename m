Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E027097CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjESM6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjESM6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B1210D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so31164165e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501034; x=1687093034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaB5/+AIM7tczn1XhOIYJIj64m+p/YSIgSiJfut7EH0=;
        b=Wm34lFiN9qPWful4uJsmcOLdFTWGa3LBPqd682Pj0JE6Cgu44yT0etENp1Cuw4zydx
         d6cS14qWN2Nix2iWeRvtA8bdO0WI4lOYvtEdb7oesJ3HQ72NmubH36RMfooCS83wD/jn
         0B+MkNjpATwGca9IZnoM+6uY8vMRx9uqJ0ON9t//h9FTPcVXPFGAML6IjbfOuCKQFocS
         /sMFw8Of/6JjfyBgbsbN+NLbPZ+2FveFWao/GXJRbS32DC3PZGKAHUSGH3c+vw7v/Wem
         RvjTD1/AvoAmrjysLEEsU4poPcMmFEB9nMnf6CX8Q6oX9NJkjDJUUl0qZEtkWjkt/Odb
         SD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501034; x=1687093034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaB5/+AIM7tczn1XhOIYJIj64m+p/YSIgSiJfut7EH0=;
        b=QNkIPcUcuMZSKKHw0OQNEKVbWqDdKYPjZO79HFVAmJ77xWfdaITIfqlbiMk/QzhiMd
         lK374zz+cavFX7B4+mk2zoZkgZWrZHIMR8oxGXuSjuxFA/1y4aVxgaoQBXfenV7avqFL
         yrY1rfby7ErRevwqhEf9j8ppcDbb3ECb4sx2fdDGX2I9d9pvoq4kFBWCj09H2RcV1Rt+
         AOpGev6hsr6dtKahBQdZTWAvK9BCOnkTCBZVeJXJsQJn9Q/JM8rdknwWhDob4axE9ql/
         iJmQHVMqriq3AV1IpEI4HIoMdK21UsCTqZ+/W8kiNgRg4+oQgVqAr6FBG4DIMMbHk0XM
         uwrg==
X-Gm-Message-State: AC+VfDwSGYAZR8xEVwhw+Oh2ur8sHtcMDV8QEDy1aNMGN/vVnoKdmOpC
        +8xT9L8WVLPPm8vK9asEsH1AY8iiS8o=
X-Google-Smtp-Source: ACHHUZ6FpEF9gI7Tf4nF7zVkylDMSkNHZgVnwdshw9Ru9Nz6jB48PqGHDu7PQIZflBe5rjLhSveG5w==
X-Received: by 2002:adf:fc47:0:b0:309:44ed:cd0d with SMTP id e7-20020adffc47000000b0030944edcd0dmr1670496wrs.64.1684501034345;
        Fri, 19 May 2023 05:57:14 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:13 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 01/10] fs: Generic function to convert iocb to rw flags
Date:   Fri, 19 May 2023 15:56:56 +0300
Message-Id: <20230519125705.598234-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519125705.598234-1-amir73il@gmail.com>
References: <20230519125705.598234-1-amir73il@gmail.com>
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

From: Alessio Balsini <balsini@android.com>

OverlayFS implements its own function to translate iocb flags into rw
flags, so that they can be passed into another vfs call.
With commit ce71bfea207b4 ("fs: align IOCB_* flags with RWF_* flags")
Jens created a 1:1 matching between the iocb flags and rw flags,
simplifying the conversion.

Reduce the OverlayFS code by making the flag conversion function generic
and reusable.

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 23 +++++------------------
 include/linux/fs.h  |  5 +++++
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7c04f033aadd..759893e4da04 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -15,6 +15,8 @@
 #include <linux/fs.h>
 #include "overlayfs.h"
 
+#define OVL_IOCB_MASK (IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
+
 struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
@@ -241,22 +243,6 @@ static void ovl_file_accessed(struct file *file)
 	touch_atime(&file->f_path);
 }
 
-static rwf_t ovl_iocb_to_rwf(int ifl)
-{
-	rwf_t flags = 0;
-
-	if (ifl & IOCB_NOWAIT)
-		flags |= RWF_NOWAIT;
-	if (ifl & IOCB_HIPRI)
-		flags |= RWF_HIPRI;
-	if (ifl & IOCB_DSYNC)
-		flags |= RWF_DSYNC;
-	if (ifl & IOCB_SYNC)
-		flags |= RWF_SYNC;
-
-	return flags;
-}
-
 static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref)) {
@@ -316,7 +302,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	if (is_sync_kiocb(iocb)) {
 		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
-				    ovl_iocb_to_rwf(iocb->ki_flags));
+				    iocb_to_rw_flags(iocb->ki_flags,
+						     OVL_IOCB_MASK));
 	} else {
 		struct ovl_aio_req *aio_req;
 
@@ -380,7 +367,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (is_sync_kiocb(iocb)) {
 		file_start_write(real.file);
 		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
-				     ovl_iocb_to_rwf(ifl));
+				     iocb_to_rw_flags(ifl, OVL_IOCB_MASK));
 		file_end_write(real.file);
 		/* Update size */
 		ovl_copyattr(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..65f0b833cc80 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3028,6 +3028,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	return 0;
 }
 
+static inline rwf_t iocb_to_rw_flags(int ifl, int iocb_mask)
+{
+	return ifl & iocb_mask;
+}
+
 static inline ino_t parent_ino(struct dentry *dentry)
 {
 	ino_t res;
-- 
2.34.1

