Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F834CAB66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 18:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiCBRTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 12:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbiCBRTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:19:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78338CCC6E;
        Wed,  2 Mar 2022 09:18:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so2263518pjb.3;
        Wed, 02 Mar 2022 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLz+dn3sEqx6HUS+1nLd4ttPK5v9DscXSXbYEOAfAtM=;
        b=GdqgcQdzmBwJL9T5mPH7O9UBvQvH+jpyaIWKT/0WxFiLppgbDQrdxKGa42ERl5uR6l
         RIuXRcB8hf9MFxbqOd7I7q5UiVgIjAdlgzpJEAWUYa4sz/MUWzWboQhty1USWTMY2ERF
         9x74dw0HtR5vfKnxxqz/rX96GGONM5Bb8hhQAKryXuQQxItfx+35KgZ43u6cgjyb9St3
         TO/QZGUMY0Oi5V9g0h3Gs4IItw3CwsWhd+lOwAp8kqQSbj8vwl916k4VG5bgb3up0mL7
         yNGyglq4SCkbWXIIVrMMRtX3oNJIVjn5prT/C92LOlwgOdP61Igwi4siWNNHMVl7fSas
         p0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLz+dn3sEqx6HUS+1nLd4ttPK5v9DscXSXbYEOAfAtM=;
        b=nyQ6/yPskVln+deeitRblepCBusq0n2sqc5C38GN0bJOnc7TwxNTR2SEfXVhCjiXJU
         5hBo11ccNqzOfrncXo15pi1w+pQVmSYg0NXZS9odJ/RRfb3p7UHI13mXmJHnotR1gDHy
         HRu+I/g0J06ph8O04V84GxjTBxjWIAmglopon6Eum8/6Hf0StU3pNahi7K8Xnat2rm9W
         71Q4X3VVRa/8e3pqlSTp3H6fWtRjGLoOJbXftyNhgsCpBIFbcuCh9Orm2V0rS5udrNwF
         d0PoqTgwqBguDesjIH804u8k6pGojY+7BcecMFwIRVxX6Ty0c4eDMOAAS+1MzAHSiqBU
         O6wA==
X-Gm-Message-State: AOAM531cz+waoafqomNXMv1NgiIp1vjmlHPCSEs2v77NG686A9v+js1r
        0na9m0cvRTjXPi9QnqG/wNHKwmzyZkCqlF63
X-Google-Smtp-Source: ABdhPJyg+01RxgPCsirAMYtoF8etJupvDy3nF7hxoKHMwqsW73bcl/n6nLrHEySpG6rDkqDIT7XPsw==
X-Received: by 2002:a17:902:cec9:b0:151:9b2c:338 with SMTP id d9-20020a170902cec900b001519b2c0338mr2823044plg.164.1646241523931;
        Wed, 02 Mar 2022 09:18:43 -0800 (PST)
Received: from kvigor-fedora-PF399REY.thefacebook.com ([2620:10d:c090:400::5:d6ec])
        by smtp.gmail.com with ESMTPSA id c63-20020a624e42000000b004f414f0a391sm10339965pfb.79.2022.03.02.09.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:18:43 -0800 (PST)
From:   Kevin Vigor <kvigor@gmail.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Vigor <kvigor@gmail.com>
Subject: [RFC PATCH 1/1] FUSE: Add FUSE_TRUST_MAX_RA flag enabling readahead settings >128KB.
Date:   Wed,  2 Mar 2022 10:18:16 -0700
Message-Id: <20220302171816.1170782-2-kvigor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302171816.1170782-1-kvigor@gmail.com>
References: <20220302171816.1170782-1-kvigor@gmail.com>
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

The existing process_init_reply() in fs/fuse/inode.c sets the ra_pages
value to the minimum of the max_readahead value provided by the user
and the pre-existing ra_pages value, which is initialized to
VM_READAHEAD_PAGES. This makes it impossible to increase the readahead
value to larger values.

Add a new flag which causes us to blindly accept the user-provided
value. Note that the existing read_ahead_kb sysfs entry for normal
block devices does the same (simply accepts user-provided values
directly with no checks).

Signed-off-by: Kevin Vigor <kvigor@gmail.com>
---
 fs/fuse/inode.c           | 8 ++++++--
 include/uapi/linux/fuse.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8b89e3ba7df3..81c96c404a76 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1182,8 +1182,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			fc->no_flock = 1;
 		}
 
-		fm->sb->s_bdi->ra_pages =
+		if (arg->flags & FUSE_TRUST_MAX_RA) {
+			fm->sb->s_bdi->ra_pages = ra_pages;
+		} else {
+			fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
+		}
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
 		fc->max_write = max_t(unsigned, 4096, fc->max_write);
@@ -1219,7 +1223,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
-		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT;
+		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_TRUST_MAX_RA;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index a1dc3ee1d17c..df9840f4642f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -341,6 +341,8 @@ struct fuse_file_lock {
  *			write/truncate sgid is killed only if file has group
  *			execute permission. (Same as Linux VFS behavior).
  * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
+ * FUSE_TRUST_MAX_RA:	Accept the user-provided max_readahead value instead
+ *			of clamping to <= VM_READAHEAD_PAGES.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -372,6 +374,7 @@ struct fuse_file_lock {
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
 #define FUSE_SETXATTR_EXT	(1 << 29)
+#define FUSE_TRUST_MAX_RA	(1 << 30)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.33.1

