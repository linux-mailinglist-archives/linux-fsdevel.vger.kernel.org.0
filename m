Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB493447F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhCVOt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230477AbhCVOtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Su5HH4RiF+W/Zr5XDd86GPqq3KJsWhOK7dETED+hxaI=;
        b=i799UTxEC8iAPs9h7oEzYXAJpzFB+3IpTmd0Ha8n62HlEDtNMlRrHud1sTyLVTxLgS/MeI
        eBEA502GNhxJdRHaZh8Lyy2FMBPjOmGMn84TV1nKWIx7HhwMHZ4ekM+U6d1Q52AU3dQ9AK
        S8MfEZlKc1C+0awg49gPHOiYG1QpNc8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-8OdorIFhNrqJuQ3t2qU--Q-1; Mon, 22 Mar 2021 10:49:22 -0400
X-MC-Unique: 8OdorIFhNrqJuQ3t2qU--Q-1
Received: by mail-ed1-f71.google.com with SMTP id w18so24706766edu.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Su5HH4RiF+W/Zr5XDd86GPqq3KJsWhOK7dETED+hxaI=;
        b=mnw7SbB0ngThNNguqCiFrKUzsoj3eqX8LdWImxZEGfoMIB2gsrRkJqOnFxaumEFp2M
         vJcDrg/HBJkZb8cU8Ii+dz+C/UyjTmO/chrpGR23Fx0YdRNUxMDOg/7d7Pj7xnU0HHOa
         GllEbwULN12wROnaCtbaWt9hNxC5oI8Vf1/z51jFOFYTMveIhtKDHSm97aYjjHI4RUUn
         vzPvnrIcPUWQpEUJD89C/2Qjz3cz5faC1y5sCI8nQZod9XO3KpItRP5RPs7USKRJfusy
         Xpbyfrp91p1TEQv8TWETC0xDAujGTF25qZC5l9n+5opR4eB5JZko83HWR1uy6etnTEdD
         asFw==
X-Gm-Message-State: AOAM532MBKLeEuHDxr5ruqDE6RdKZgY0Z1FPP5J5Zwtoqu8sjyBWM64D
        Ik9P085rz2sx5wC0jy26Q+V5wi86lKZRlRRyxTMUhjivPUPy+M/naeHmMMtM/gtH/XvOiE+oD7H
        c6DNjzzyQ1C4RWu4AY9w7PcgCf1BXon96f2G7xNFFYRVmdtCtSfsR2rs+S8FY3aJJYsv03KJqSv
        QFnA==
X-Received: by 2002:a17:906:51c3:: with SMTP id v3mr65664ejk.497.1616424561580;
        Mon, 22 Mar 2021 07:49:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3OTZYNqLusMjJIntln1ZMQ1gkH4GazIa2cCJ6OLVDvjZ2gcIA2IzzCvXPSaXbODU31M4uvQ==
X-Received: by 2002:a17:906:51c3:: with SMTP id v3mr65645ejk.497.1616424561419;
        Mon, 22 Mar 2021 07:49:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:20 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>
Subject: [PATCH v2 02/18] ecryptfs: stack miscattr ops
Date:   Mon, 22 Mar 2021 15:49:00 +0100
Message-Id: <20210322144916.137245-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add stacking for the miscattr operations.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Tyler Hicks <code@tyhicks.com>
---
 fs/ecryptfs/inode.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 18e9285fbb4c..b7d18583c50f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/fs_stack.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
+#include <linux/miscattr.h>
 #include <asm/unaligned.h>
 #include "ecryptfs_kernel.h"
 
@@ -1118,6 +1119,23 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 	return rc;
 }
 
+static int ecryptfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	return vfs_miscattr_get(ecryptfs_dentry_to_lower(dentry), ma);
+}
+
+static int ecryptfs_miscattr_set(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, struct miscattr *ma)
+{
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	int rc;
+
+	rc = vfs_miscattr_set(&init_user_ns, lower_dentry, ma);
+	fsstack_copy_attr_all(d_inode(dentry), d_inode(lower_dentry));
+
+	return rc;
+}
+
 const struct inode_operations ecryptfs_symlink_iops = {
 	.get_link = ecryptfs_get_link,
 	.permission = ecryptfs_permission,
@@ -1139,6 +1157,8 @@ const struct inode_operations ecryptfs_dir_iops = {
 	.permission = ecryptfs_permission,
 	.setattr = ecryptfs_setattr,
 	.listxattr = ecryptfs_listxattr,
+	.miscattr_get = ecryptfs_miscattr_get,
+	.miscattr_set = ecryptfs_miscattr_set,
 };
 
 const struct inode_operations ecryptfs_main_iops = {
@@ -1146,6 +1166,8 @@ const struct inode_operations ecryptfs_main_iops = {
 	.setattr = ecryptfs_setattr,
 	.getattr = ecryptfs_getattr,
 	.listxattr = ecryptfs_listxattr,
+	.miscattr_get = ecryptfs_miscattr_get,
+	.miscattr_set = ecryptfs_miscattr_set,
 };
 
 static int ecryptfs_xattr_get(const struct xattr_handler *handler,
-- 
2.30.2

