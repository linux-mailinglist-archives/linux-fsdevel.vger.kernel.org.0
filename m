Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D417A5BCE1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiISOKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiISOKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6332063
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61fGxMQX0SECJ5OtxS6TsO0S1PrbjcjAwRpThQXXzOs=;
        b=GbX2kP4mfMmqGLjq2/Iptf1aJJl7MM0WilO8UlIu8y8FsabFjU0y6MuRdfz4/L+zk5kWqp
        9IoIIifz6zX967DidP7H2fResfgKkdYdoxWNSabG085/RB1uegN/3S9eqfEwHp2uCvpMBv
        YVppPAcKEeugfilf7hhlprYBg+Mk0MU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-267-v4d2ncLHMlu9gCC-ar9J5Q-1; Mon, 19 Sep 2022 10:10:42 -0400
X-MC-Unique: v4d2ncLHMlu9gCC-ar9J5Q-1
Received: by mail-ed1-f72.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so20265281eda.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=61fGxMQX0SECJ5OtxS6TsO0S1PrbjcjAwRpThQXXzOs=;
        b=Z35tfrRSDvnxrJQwGFv0Y6ZmFJPTxnL9QYF/a1tiesAl6nD6HzEnz/SKITQ3GVR9Zf
         V1xI9an2W8P5y56cracC6UMUtGtvDb/wvdv+L6AUrm9T9qQLzM6qohwbS/gm5FI5075p
         okerkqD8XLCqEZfPUjjLrIgoBBlqCkvzJuLrQw5Hfd7CL6Z1GK/x791PlOfMEqyk8p8u
         WZi66NKtUsVBjd/q7NZ+w3I2+ZsjVYFnwRgjcr0bHP8HEj7jPTFYnUPQw6LHry/O0/jC
         slba8+tLtR7hgSgE+bHzkfPDsgx8vB8p3nsi9+pMLRqTr//BQKHXlQpLEOXgBTgLIClM
         zW8A==
X-Gm-Message-State: ACrzQf22PqYdIUGdUBPTzW1gqa5Oa+Skq1wNSeOplnnh6FQl/t42lpmW
        vBEIG4LAG43ENr1L5UR5uE0FGRbvoMLNtkzQBxo1ttVMIMHPjkvdWXJ8tymsDZg8SUgMVJwwPsu
        jJ4+Hm73d0y+msulTtdE+jjGTMwhAa18spMMf4pdhbQyJsnpfB0duAFIRGT4otctkDVo6q8Z5DW
        gNPg==
X-Received: by 2002:a05:6402:1655:b0:44e:b208:746d with SMTP id s21-20020a056402165500b0044eb208746dmr16018090edx.229.1663596641004;
        Mon, 19 Sep 2022 07:10:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ZCYqD3kw8B69W5UngmITdEdOAwVoOp2JGRgF5eyE3NLUUbl52bwI3ECInobDmNk66tIqZlg==
X-Received: by 2002:a05:6402:1655:b0:44e:b208:746d with SMTP id s21-20020a056402165500b0044eb208746dmr16018074edx.229.1663596640679;
        Mon, 19 Sep 2022 07:10:40 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:39 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 5/8] vfs: make vfs_tmpfile() static
Date:   Mon, 19 Sep 2022 16:10:28 +0200
Message-Id: <20220919141031.1834447-6-mszeredi@redhat.com>
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

