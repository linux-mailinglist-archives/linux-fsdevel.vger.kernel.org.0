Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C465BB2F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiIPTob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiIPToZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0CB531B
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663357464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qiTxfVmHh638eW+FNltRgNbHhvM4aqPe5D02hCK21mY=;
        b=diRxohcOiyW3Ch/ApkjxDpT/SUs+hVbD3vUhSPOC5sS+LFDRMlntMa1wzl288KhDxlk2N1
        MZdMav2y4m9sO56XaNCTS9OzCj0X0EodMPDa5CpRFWVr5uOjB2IePrus+w3xhy4+pmHPy+
        wZGC07t4PzG97zD7/WHKRH5DRcjhg30=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-qDYRGYO6OMe07pXNi4NhDg-1; Fri, 16 Sep 2022 15:44:23 -0400
X-MC-Unique: qDYRGYO6OMe07pXNi4NhDg-1
Received: by mail-ed1-f70.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so15591348eda.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qiTxfVmHh638eW+FNltRgNbHhvM4aqPe5D02hCK21mY=;
        b=OkRXaU2E3v8yA4w4Pamp+8nMfhWRCNMCzarpOb8KvczAD3vQjcbonKrYhZ9amJrEhF
         3B5b/ri2Ub7NZffFkK1/1pV/SSC2nc8F4YDjeH75tNDgajEKN/dw6ikYJ/pzugAmLWoj
         wVZLovpW1qAYs6PyaFtomPBNptEhvyWYm1Pke7b9Y+W1y0GR7B4aAiL2axHlmgxPJUZI
         DKM7sbli3WerYENr9lUsWbuRVDvPNd7iQdWjFbCgkKJONzdyKySKu9Xo6k0Oo07LoCyb
         rIjHp9GM50rg83BK8X2ZwX5Qnnk2WC/pC5RFVDowasBxRxmYy6sxi7ehKVmCV6C2r3x5
         +XLg==
X-Gm-Message-State: ACrzQf2TuekC5IoQyThc9axnD6GC9kMRffAsWXPiG7RPWwVfo2kROjvU
        LFeTGgOf+TvTRWEsBxB1kEL7TK6dI/BWrp3fvTr9uw6bXE4U4ygJZK9kXQOIgt0NwPVbDu5faGa
        0hKyFXXd5EBvDw5Uum4Jrt6gfa6Vs/tcQhNWHU8jfs2jD1Jdyk+krq6v8mpE8TpljSkcCFSHi94
        NvUA==
X-Received: by 2002:a17:906:5a6b:b0:73c:c9ee:8b5c with SMTP id my43-20020a1709065a6b00b0073cc9ee8b5cmr4508023ejc.310.1663357462048;
        Fri, 16 Sep 2022 12:44:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM55mDTxkaKUHdR6D1Pi3gbJRPbkhJWhHX34ejxsxg+4gk9mKAcFDBcXyodBmW7L9tUJ/fC7/g==
X-Received: by 2002:a17:906:5a6b:b0:73c:c9ee:8b5c with SMTP id my43-20020a1709065a6b00b0073cc9ee8b5cmr4508007ejc.310.1663357461774;
        Fri, 16 Sep 2022 12:44:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-212-116.pool.digikabel.hu. [193.226.212.116])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0077ce503bd77sm8348592eje.129.2022.09.16.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:44:21 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 5/8] vfs: make vfs_tmpfile() static
Date:   Fri, 16 Sep 2022 21:44:13 +0200
Message-Id: <20220916194416.1657716-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916194416.1657716-1-mszeredi@redhat.com>
References: <20220916194416.1657716-1-mszeredi@redhat.com>
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
index 078ecd88f016..eacaf9ccbaa6 100644
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

