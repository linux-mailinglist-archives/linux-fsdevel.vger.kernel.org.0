Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A406E2D1631
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 17:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgLGQef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727713AbgLGQef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrGV7hqd0sY6Ndza0dri1YXg1lEmApvh0CGfKm2LK30=;
        b=V2C5ccZj7xTdg3kudkH7ULUEZX/BLHwmPm/Qx+FSIlMO5QP4FhDp3i1Tyz11yYlT9KAX8U
        mgOm64Hb+NQpKutPQUpnrTCaMEs95dKBe4x89JBjdvgX4OP3qgWG+KKdm/2M+P4AKsc+xF
        JYFPZMXG4rIGLBV5tIRP60qdt9n1wH4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-jWYaef1UNCip-PaJrhi8vQ-1; Mon, 07 Dec 2020 11:33:02 -0500
X-MC-Unique: jWYaef1UNCip-PaJrhi8vQ-1
Received: by mail-ej1-f70.google.com with SMTP id k15so4058327ejg.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrGV7hqd0sY6Ndza0dri1YXg1lEmApvh0CGfKm2LK30=;
        b=aVF7dSlrgteLV9rjudxDt9yfFO2q07qtLyMrX9nSmF8peClXgjMgRHnSZ6gFUhV6Au
         yPx331a5UGdh0oItOPsRI3pr62mNpkVPYpF7+3MwOaDIF9COZGHYU+5+j3+eIcxkaiHX
         TUihOnzl/y5gPnDNTYgBisYNtzo+uNHJRJZYmi30UtmWgpp7MUNNzCoUjDshUBo/XAEn
         IIB5bcctC+TvuSDHwFUEL1L57z/x8yeLHtc3qRt/AxLyhOXVnfPKQ02oS7ZMrLleF2zX
         RpJju9osuq5SED3NZZwdvwSIyzCNy/spEreg8FBQO8SNz81UjTO1A9HbvyIRfE7PrFnl
         kWeA==
X-Gm-Message-State: AOAM530eOYWMhsq25/5r7EzPkV17QgmVcaBGlay3XBVOy82lQBbq3DF+
        Y4iDTXEX/JZOy5sgUg+3CwtKUiAiGAx1oclbpLqqww9KlyZUGI3z633vvg76D6Q9SZ73wVy2Bmu
        GkGoLraecKxMAwgKUUv/dOlWq4w==
X-Received: by 2002:a50:a694:: with SMTP id e20mr20629147edc.261.1607358781218;
        Mon, 07 Dec 2020 08:33:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzacwDTqVI9lhkLtXTTX/Z6WL5s00t1gChOyqFQ1tlVS8dmeqyNuXCDk11RK7mg8BFu3gh98Q==
X-Received: by 2002:a50:a694:: with SMTP id e20mr20629136edc.261.1607358781059;
        Mon, 07 Dec 2020 08:33:01 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:00 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
Date:   Mon,  7 Dec 2020 17:32:46 +0100
Message-Id: <20201207163255.564116-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cap_convert_nscap() does permission checking as well as conversion of the
xattr value conditionally based on fs's user-ns.

This is needed by overlayfs and probably other layered fs (ecryptfs) and is
what vfs_foo() is supposed to do anyway.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/xattr.c                 | 17 +++++++++++------
 include/linux/capability.h |  2 +-
 security/commoncap.c       |  3 +--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index cd7a563e8bcd..fd57153b1f61 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -276,8 +276,16 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
+	const void  *orig_value = value;
 	int error;
 
+	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
+		error = cap_convert_nscap(dentry, &value, size);
+		if (error < 0)
+			return error;
+		size = error;
+	}
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
@@ -289,6 +297,9 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		if (!error)
 			goto retry_deleg;
 	}
+	if (value != orig_value)
+		kfree(value);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_setxattr);
@@ -537,12 +548,6 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
 			posix_acl_fix_xattr_from_user(kvalue, size);
-		else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
-			error = cap_convert_nscap(d, &kvalue, size);
-			if (error < 0)
-				goto out;
-			size = error;
-		}
 	}
 
 	error = vfs_setxattr(d, kname, kvalue, size, flags);
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 1e7fe311cabe..b2f698915c0f 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,6 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
-extern int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size);
+extern int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 59bf3c1674c8..bacc1111d871 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -473,7 +473,7 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
  *
  * If all is ok, we return the new size, on error return < 0.
  */
-int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
+int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size)
 {
 	struct vfs_ns_cap_data *nscap;
 	uid_t nsrootid;
@@ -516,7 +516,6 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 	nscap->magic_etc = cpu_to_le32(nsmagic);
 	memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 
-	kvfree(*ivalue);
 	*ivalue = nscap;
 	return newsize;
 }
-- 
2.26.2

