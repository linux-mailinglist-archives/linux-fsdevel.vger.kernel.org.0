Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1794FDC54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 12:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfKOLdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 06:33:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38589 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfKOLdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:33:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so10036872wmk.3;
        Fri, 15 Nov 2019 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SjsBoxZpnXuWdt5imWu8R6Un/MP6XwVLVHRk4CSDF/M=;
        b=tdUiHY5SmMTUG2L3aFxXNDKQdhB7lnfDGZsDbsWLGlrr8d4u+1+RmtqCU529gizxfP
         oxEaEUPR2nfi5KfBqm+Ix1qdIZdyYS1YIwTC9Nr6t/b6/r9k4q/YkKHR4sTYM5LIepX4
         TdyTU3TZfV7PuddDi9LsKrFPaHzz6ogIn6AjV20fbW4SmQr0SqXj4lFKRiGsYsTPfhpr
         Tz1/g8UvEY8QnXr+xISfTjx8f37/TXjZhN5zvG1OmHgODHVxXM915EYW2krCCO5+t+fI
         iym2fe4Ib6xzGbT/zZegL68rL0zirpJyd1JW1cUKochKXUtjWgYXxvy+szcT6OH+VMRt
         EQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SjsBoxZpnXuWdt5imWu8R6Un/MP6XwVLVHRk4CSDF/M=;
        b=ZW4XXVbB1FCvHnqnmVMr/NwbWpcQwrav9PBlKH6KLhGfjmJA1UkeZqHYzaygGEqv++
         ygF5MfM3t/ad91CDT0U8A71eCAoEFkpU3XtmWFmdRIemnerothFuH1RpB9/mNg8wjEJ2
         baDPra8U4+QqQLQC0u0paePaDHz3CHE6xL9apU7kOquHgNXoZI6HAkVFglOFdJWmR2As
         ycx9jH+GhFBZAVxVjKWNhPNYEUBaBmDH6avl+hzait27EcbtPf8DhW+8IdRO5fTOG5UA
         L4aL/R4N975A9KiyxyqtzE9wE1nVijlTqY37te0xQUv9zDKF8o9L7rrI8n1j85up7vmm
         Xbgw==
X-Gm-Message-State: APjAAAVkh2AdxV6CYJWAuokrsFC+VwggIkNnfi2SxcVMMr8Pdtl/tyOd
        URPwzBTA8JLr0rzxHItKFN4=
X-Google-Smtp-Source: APXvYqwKaHpwCHnWS2MrArQV7wV0TaKtxj+KHQFJd8QT+3u5XoweyB8dRbd5Sp6Uh31le+1N0TIi0w==
X-Received: by 2002:a1c:410a:: with SMTP id o10mr14092912wma.117.1573817594193;
        Fri, 15 Nov 2019 03:33:14 -0800 (PST)
Received: from localhost.localdomain ([94.230.83.228])
        by smtp.gmail.com with ESMTPSA id l4sm9225181wme.4.2019.11.15.03.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 03:33:13 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] ovl: don't use a temp buf for encoding real fh
Date:   Fri, 15 Nov 2019 13:33:04 +0200
Message-Id: <20191115113304.16209-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115113304.16209-1-amir73il@gmail.com>
References: <20191115113304.16209-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can allocate maximum fh size and encode into it directly.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7f744a9541e5..6220642fe113 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -227,13 +227,17 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
 struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 {
 	struct ovl_fh *fh;
-	int fh_type, fh_len, dwords;
-	void *buf;
+	int fh_type, dwords;
 	int buflen = MAX_HANDLE_SZ;
 	uuid_t *uuid = &real->d_sb->s_uuid;
+	int err;
 
-	buf = kmalloc(buflen, GFP_KERNEL);
-	if (!buf)
+	/* Make sure the real fid stays 32bit aligned */
+	BUILD_BUG_ON(OVL_FH_FID_OFFSET % 4);
+	BUILD_BUG_ON(MAX_HANDLE_SZ + OVL_FH_FID_OFFSET > 255);
+
+	fh = kzalloc(buflen + OVL_FH_FID_OFFSET, GFP_KERNEL);
+	if (!fh)
 		return ERR_PTR(-ENOMEM);
 
 	/*
@@ -242,24 +246,14 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 	 * the price or reconnecting the dentry.
 	 */
 	dwords = buflen >> 2;
-	fh_type = exportfs_encode_fh(real, buf, &dwords, 0);
+	fh_type = exportfs_encode_fh(real, (void *)fh->fb.fid, &dwords, 0);
 	buflen = (dwords << 2);
 
-	fh = ERR_PTR(-EIO);
+	err = -EIO;
 	if (WARN_ON(fh_type < 0) ||
 	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
 	    WARN_ON(fh_type == FILEID_INVALID))
-		goto out;
-
-	/* Make sure the real fid stays 32bit aligned */
-	BUILD_BUG_ON(OVL_FH_FID_OFFSET % 4);
-	BUILD_BUG_ON(MAX_HANDLE_SZ + OVL_FH_FID_OFFSET > 255);
-	fh_len = OVL_FH_FID_OFFSET + buflen;
-	fh = kzalloc(fh_len, GFP_KERNEL);
-	if (!fh) {
-		fh = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+		goto out_err;
 
 	fh->fb.version = OVL_FH_VERSION;
 	fh->fb.magic = OVL_FH_MAGIC;
@@ -273,13 +267,14 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 	 */
 	if (is_upper)
 		fh->fb.flags |= OVL_FH_FLAG_PATH_UPPER;
-	fh->fb.len = fh_len - OVL_FH_WIRE_OFFSET;
+	fh->fb.len = sizeof(fh->fb) + buflen;
 	fh->fb.uuid = *uuid;
-	memcpy(fh->fb.fid, buf, buflen);
 
-out:
-	kfree(buf);
 	return fh;
+
+out_err:
+	kfree(fh);
+	return ERR_PTR(err);
 }
 
 int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
-- 
2.17.1

