Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9005BEDDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiITTgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiITTgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC2A760F1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61fGxMQX0SECJ5OtxS6TsO0S1PrbjcjAwRpThQXXzOs=;
        b=SYiDzmXaTmNICixJWL7dFSa02dpgAylpMXz5BjJddOkhAqmHWkM2S/2irpjVBWDFNQqJn1
        U0GLxI0ELKEQLBYcQxepL1qMcZNRtl/FKD70w2efoT+fXXn4beeNaBzCA05xgDCdS0XNty
        MIZ0P+O4pCriGBY/d2WboHEobRRLgwY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-hM_0H9LVOU63-xTX4emmhQ-1; Tue, 20 Sep 2022 15:36:43 -0400
X-MC-Unique: hM_0H9LVOU63-xTX4emmhQ-1
Received: by mail-ed1-f69.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so2610267edb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=61fGxMQX0SECJ5OtxS6TsO0S1PrbjcjAwRpThQXXzOs=;
        b=c1hmaTvEGyQ6VYTq3tFM9zEVaPgbCQneNOscXRkR+Q3gocLDaLg21OIsoHtFbDawUu
         LA17aC8vUd4cM7vUU6pceV0IU/F4otLKdQYwgW7M+GRlcRXYEJr3+nVQGNO63souEY5x
         ZTzXnpM1X0EEVT0ArThOB0soa0f7LwV6AGho4Y6eOCJP4mXeHHz9k099R1ddmYnkVVfY
         f9YGa4A+VrdULnGS413aagVHdLw9sHCVr7P1jRI2FwZ6Lwvp10cxu00TmKw3lYSRnimU
         OkT89rcflnHZwpfWL1DZgbTnLT6AP3qZTFHDi84LjbpcngZG/BzCsso0UqMxDgwryuXL
         3+gg==
X-Gm-Message-State: ACrzQf2ZTv+ySv047LfnA4LH0E0CNpRtQ9XCMFUkArZ0JpykKggdOOjZ
        p3HltKX8BOFYQl5o16aEYN2dA/cIyHPqQCIpHztN3LV2iT1WWyp835F2uOMGH9lFUHhtjvgpI+c
        rc9EsACgF2cgzG3ZBJy8fT8NqKf/Cdqjfv6z0lbXnYSvHYGTaRXEy0DRxhQIjVeIVBD1q3FXRRf
        BB1w==
X-Received: by 2002:a05:6402:4511:b0:43b:a182:8a0a with SMTP id ez17-20020a056402451100b0043ba1828a0amr21392200edb.410.1663702601380;
        Tue, 20 Sep 2022 12:36:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7tuv56iaUCXF4uHZ5i5FXvwo6b1GAZCOY2D1l0sRe8v6NV+Lublxg4loKLDR448FWKiKV3hQ==
X-Received: by 2002:a05:6402:4511:b0:43b:a182:8a0a with SMTP id ez17-20020a056402451100b0043ba1828a0amr21392183edb.410.1663702601182;
        Tue, 20 Sep 2022 12:36:41 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0045184540cecsm391821edq.36.2022.09.20.12.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:36:40 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v3 6/9] vfs: make vfs_tmpfile() static
Date:   Tue, 20 Sep 2022 21:36:29 +0200
Message-Id: <20220920193632.2215598-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920193632.2215598-1-mszeredi@redhat.com>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
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

No callers outside of fs/namei.c anymore.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namei.c         | 3 +--
 include/linux/fs.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5e4a0c59eef6..652d09ae66fb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3583,7 +3583,7 @@ static int do_open(struct nameidata *nd,
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply passs init_user_ns.
  */
-struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
+static struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, umode_t mode, int open_flag)
 {
 	struct dentry *child = NULL;
@@ -3622,7 +3622,6 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	dput(child);
 	return ERR_PTR(error);
 }
-EXPORT_SYMBOL(vfs_tmpfile);
 
 /**
  * tmpfile_open - open a tmpfile for kernel internal use
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 34e7a189565b..a445da4842e0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2004,9 +2004,6 @@ static inline int vfs_whiteout(struct user_namespace *mnt_userns,
 			 WHITEOUT_DEV);
 }
 
-struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
-			   struct dentry *dentry, umode_t mode, int open_flag);
-
 struct file *tmpfile_open(struct user_namespace *mnt_userns,
 			  const struct path *parentpath,
 			  umode_t mode, int open_flag, const struct cred *cred);
-- 
2.37.3

