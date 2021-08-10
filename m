Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69673E59A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbhHJMIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 08:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239048AbhHJMIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628597295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZnHDMvqEZ3ftoZn+MNpXng+uKmXTfsGKZSP1UG7OKw=;
        b=MQQtSX6CLgun5ZW/LSYevbeS7XRCeCac082yldnVegovFlbYqN8HSBaUIbGcRqti1oAV8e
        m+f6YrGzPAZAb/9/3ziUJrW/12xNEov7TMZv4Inhd8oqJJSkREoFWcwBu6KSOwrGGi6INi
        dJbLKBkMnew2x9hVTGsolWRr16BdyrM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Mqu3IbfvPw2WET6UoNHeDw-1; Tue, 10 Aug 2021 08:08:13 -0400
X-MC-Unique: Mqu3IbfvPw2WET6UoNHeDw-1
Received: by mail-ed1-f69.google.com with SMTP id u25-20020aa7d8990000b02903bb6a903d90so10670771edq.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 05:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZnHDMvqEZ3ftoZn+MNpXng+uKmXTfsGKZSP1UG7OKw=;
        b=CdZOSgIW7eU+/ODcPwzFvGrMLeeN/cuGOn/c0jJv/XIJ7V0YYvPIhhCqTHEhD62xXa
         3Rrh4gfQ3W96+spG76P5Af/KGDvRFAiaPer2Z9c7LeHsm2Rj7+OttgknP5rX69ieUdsQ
         ovwM9bNL544ee39r9EJ77ZKAO4cLwC+q+Ya0cHNqxyIuesuISPYrJITt4qwRdIM1F3tg
         xlAH/LdS50lPcqe8sY+DDBaf12Km5M8fN3yKCYn5L/E4g3PxR8ybfqZHH0HZMPyYrIx8
         8ERuD9liTZOiZdXH2KlFMcVZ5z/K23nci4okA75uQPU3SRQnzAN1GIqvjQmYVQK9yvS3
         lFQQ==
X-Gm-Message-State: AOAM532S3K4i0xZq7fj4k7RA2Rh1LEihE+ITlmLeEE+nvO4ylOFkw02+
        4TxXmyGjRGGXesovi0i4jFKCXZZkXc5NGHWEmFTrZ7Zb7bYjLk2yggSVMi4AgNJ0tHygpZTqq3W
        3p9nbzca1QY+Q91twbEv2v1lNAA==
X-Received: by 2002:aa7:c9d8:: with SMTP id i24mr4569641edt.79.1628597292400;
        Tue, 10 Aug 2021 05:08:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjiMeijZd9bsMjJ5xH+LY03YRHw4EuD9qOp1nZXwEbgue3oFf7aoDljP+KM73PQAFXm+EYWQ==
X-Received: by 2002:aa7:c9d8:: with SMTP id i24mr4569622edt.79.1628597292216;
        Tue, 10 Aug 2021 05:08:12 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id p5sm6804900ejl.73.2021.08.10.05.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 05:08:11 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        garyhuang <zjh.20052005@163.com>
Subject: [PATCH 2/2] ovl: enable RCU'd ->get_acl()
Date:   Tue, 10 Aug 2021 14:08:07 +0200
Message-Id: <20210810120807.456788-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810120807.456788-1-mszeredi@redhat.com>
References: <20210810120807.456788-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs does not cache ACL's (to avoid double caching).  Instead it just
calls the underlying filesystem's i_op->get_acl(), which will return the
cached value, if possible.

In rcu path walk, however, get_cached_acl_rcu() is employed to get the
value from the cache, which will fail on overlayfs resulting in dropping
out of rcu walk mode.  This can result in a big performance hit in certain
situations.

Fix by calling ->get_acl() with LOOKUP_RCU flag in case of ACL_DONT_CACHE
(which indicates pass-through)

Reported-by: garyhuang <zjh.20052005@163.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/inode.c | 7 ++++---
 fs/posix_acl.c       | 8 +++++++-
 include/linux/fs.h   | 5 +++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 727154a1d3ce..6a55231b262a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -13,6 +13,7 @@
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
 #include <linux/security.h>
+#include <linux/namei.h>
 #include "overlayfs.h"
 
 
@@ -454,12 +455,12 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, int flags)
 	const struct cred *old_cred;
 	struct posix_acl *acl;
 
-	if (flags)
-		return ERR_PTR(-EINVAL);
-
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
 		return NULL;
 
+	if (flags & LOOKUP_RCU)
+		return get_cached_acl_rcu(realinode, type);
+
 	old_cred = ovl_override_creds(inode->i_sb);
 	acl = get_acl(realinode, type);
 	revert_creds(old_cred);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 6b7f793e2b6f..4d1c6c266cf0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -22,6 +22,7 @@
 #include <linux/xattr.h>
 #include <linux/export.h>
 #include <linux/user_namespace.h>
+#include <linux/namei.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
 {
@@ -56,7 +57,12 @@ EXPORT_SYMBOL(get_cached_acl);
 
 struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type)
 {
-	return rcu_dereference(*acl_by_type(inode, type));
+	struct posix_acl *acl = rcu_dereference(*acl_by_type(inode, type));
+
+	if (acl == ACL_DONT_CACHE)
+		acl = inode->i_op->get_acl(inode, type, LOOKUP_RCU);
+
+	return acl;
 }
 EXPORT_SYMBOL(get_cached_acl_rcu);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1c56d4fc4efe..20b7db2d0a85 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -581,6 +581,11 @@ static inline void mapping_allow_writable(struct address_space *mapping)
 
 struct posix_acl;
 #define ACL_NOT_CACHED ((void *)(-1))
+/*
+ * ACL_DONT_CACHE is for stacked filesystems, that rely on underlying fs to
+ * cache the ACL.  This also means that ->get_acl() can be called in RCU mode
+ * with the LOOKUP_RCU flag.
+ */
 #define ACL_DONT_CACHE ((void *)(-3))
 
 static inline struct posix_acl *
-- 
2.31.1

