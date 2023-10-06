Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3AF7BBF56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjJFS4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjJFSzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5F3120
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FacLpp81lSt+NTXvvuxgBTv7hQsOCppHOs10C3hHLzU=;
        b=glBoVREVzaD7+DkIiVRntlPCUhpaxm+IuYElnwy78lf7sANEV2LQOuDKA4l9zg3f3OcFtL
        sAJfHHRiwYtVMUqxm0djXTPEdCVv+3Qg5RD5nZZsp4RHr6r+cfIB46x8mSZSU4E5dcztx/
        u+S+jVeR7ev1vf3/vCI+wck275Tl6CQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-PinFNJjKMIuG9ZXcH0WDKQ-1; Fri, 06 Oct 2023 14:52:35 -0400
X-MC-Unique: PinFNJjKMIuG9ZXcH0WDKQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae0bf9c0a9so189223666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618354; x=1697223154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FacLpp81lSt+NTXvvuxgBTv7hQsOCppHOs10C3hHLzU=;
        b=sM5Dm6JSycoc6I6IqNFiPC5SVyjPOgLVyt79hbAdaoBtmeDbvjQZBXdHWqSm8Jy/9S
         GHWMBM3EF9ZKWsB3o0gUWI3c5aJNRjU5Yl8rdnJLCz17bZYZJE+Sb4HbZw+vhIfKzgYP
         v9c15ndeRPMfI/9wfEjVYIEMIz1DQAoOzPfh5SL1StC138n920LQeKKaauFZrnnGp5gJ
         ft86NsUy2rhUSbW2Ha4EwYu+xH1ftJlauF9s2FXVpims8A+5opNS9878LGc3/FsTBCGm
         3THy77Q6yKPTd4EPWQ64iRPA7Wrc62Bl6qNOntnlHffDqghvvGRUokYV8ZwdMUs02ECa
         T82Q==
X-Gm-Message-State: AOJu0Yygp/nAbp3kND6je+liPGuIqCV/J1AuHTnRkZmEL9UGeYq2H5dq
        +XD8NxD6MdCt9B/24qxUOo1H8xuHoSp5moBJVInFo94U0B707RRb3kYitH3tC9F+QjSnWkuIlie
        H6rrVuGtV80o00TzUCBk+TJCE
X-Received: by 2002:a17:906:32c7:b0:9a3:c4f4:12de with SMTP id k7-20020a17090632c700b009a3c4f412demr7809805ejk.37.1696618354476;
        Fri, 06 Oct 2023 11:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKWZrR/0CaRj96MI7dxLSBRW5Bpl/4ewBkwPmazbEv8rlNH/nLOY8UUhBgrhB9XkE7sr/NkA==
X-Received: by 2002:a17:906:32c7:b0:9a3:c4f4:12de with SMTP id k7-20020a17090632c700b009a3c4f412demr7809795ejk.37.1696618354303;
        Fri, 06 Oct 2023 11:52:34 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:33 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 17/28] xfs: add attribute type for fs-verity
Date:   Fri,  6 Oct 2023 20:49:11 +0200
Message-Id: <20231006184922.252188-18-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The Merkle tree blocks and descriptor are stored in the extended
attributes of the inode. Add new attribute type for fs-verity
metadata. Add XFS_ATTR_INTERNAL_MASK to skip parent pointer and
fs-verity attributes as those are only for internal use. While we're
at it add a few comments in relevant places that internally visible
attributes are not suppose to be handled via interface defined in
xfs_xattr.c.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_da_format.h  | 10 +++++++++-
 fs/xfs/libxfs/xfs_log_format.h |  1 +
 fs/xfs/xfs_ioctl.c             |  5 +++++
 fs/xfs/xfs_trace.h             |  1 +
 fs/xfs/xfs_xattr.c             |  9 +++++++++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 6deefe03207f..b56bdae83563 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -699,14 +699,22 @@ struct xfs_attr3_leafblock {
 #define	XFS_ATTR_ROOT_BIT	1	/* limit access to trusted attrs */
 #define	XFS_ATTR_SECURE_BIT	2	/* limit access to secure attrs */
 #define	XFS_ATTR_PARENT_BIT	3	/* parent pointer attrs */
+#define	XFS_ATTR_VERITY_BIT	4	/* verity merkle tree and descriptor */
 #define	XFS_ATTR_INCOMPLETE_BIT	7	/* attr in middle of create/delete */
 #define XFS_ATTR_LOCAL		(1u << XFS_ATTR_LOCAL_BIT)
 #define XFS_ATTR_ROOT		(1u << XFS_ATTR_ROOT_BIT)
 #define XFS_ATTR_SECURE		(1u << XFS_ATTR_SECURE_BIT)
 #define XFS_ATTR_PARENT		(1u << XFS_ATTR_PARENT_BIT)
+#define XFS_ATTR_VERITY		(1u << XFS_ATTR_VERITY_BIT)
 #define XFS_ATTR_INCOMPLETE	(1u << XFS_ATTR_INCOMPLETE_BIT)
 #define XFS_ATTR_NSP_ONDISK_MASK \
-			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT)
+			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT | \
+			 XFS_ATTR_VERITY)
+
+/*
+ * Internal attributes not exposed to the user
+ */
+#define XFS_ATTR_INTERNAL_MASK (XFS_ATTR_PARENT | XFS_ATTR_VERITY)
 
 /*
  * Alignment for namelist and valuelist entries (since they are mixed
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 0bc1749fb7bb..c42cc58cd152 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -975,6 +975,7 @@ struct xfs_icreate_log {
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
 					 XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 55bb01173cde..3d6d680b6cf3 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -351,6 +351,11 @@ static unsigned int
 xfs_attr_filter(
 	u32			ioc_flags)
 {
+	/*
+	 * Only externally visible attributes should be specified here.
+	 * Internally used attributes (such as parent pointers or fs-verity)
+	 * should not be exposed to userspace.
+	 */
 	if (ioc_flags & XFS_IOC_ATTR_ROOT)
 		return XFS_ATTR_ROOT;
 	if (ioc_flags & XFS_IOC_ATTR_SECURE)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 3926cf7f2a6e..3696709907bf 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -82,6 +82,7 @@ struct xfs_perag;
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
 	{ XFS_ATTR_SECURE,	"SECURE" }, \
+	{ XFS_ATTR_VERITY,	"VERITY" }, \
 	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }
 
 DECLARE_EVENT_CLASS(xfs_attr_list_class,
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index a3975f325f4e..56f7f4122fcb 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -20,6 +20,12 @@
 
 #include <linux/posix_acl_xattr.h>
 
+/*
+ * This file defines interface to work with externally visible extended
+ * attributes, such as those in system or security namespaces. This interface
+ * should not be used for internally used attributes (consider xfs_attr.c).
+ */
+
 /*
  * Get permission to use log-assisted atomic exchange of file extents.
  *
@@ -241,6 +247,9 @@ xfs_xattr_put_listent(
 
 	ASSERT(context->count >= 0);
 
+	if (flags & XFS_ATTR_INTERNAL_MASK)
+		return;
+
 	if (flags & XFS_ATTR_ROOT) {
 #ifdef CONFIG_XFS_POSIX_ACL
 		if (namelen == SGI_ACL_FILE_SIZE &&
-- 
2.40.1

