Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3229977764F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjHJK4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHJK4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1B268A
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691664909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfJH3noYbWyg5mwtDgx4Z5kj3eCpv/dKZ/d4TuLP0Yc=;
        b=LP0vlNl3hr9pNxgfLShQDf37Nw8xmiDtQt8nNGmx6mNQWv04X4CVj6h+L07KxU7gcWTdHK
        W6cuoIpN9PrHLvTKY8TxWeCeNOfkvkZ+ilIfK+lPluhNVYQP9+7V3Q2bZ8+oi9oEx1ETKw
        R6gYFIgFfFF3Eo0LKq8qG45hBa2cH6k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-6V2vaXgIOBClHFwHCJDc-A-1; Thu, 10 Aug 2023 06:55:07 -0400
X-MC-Unique: 6V2vaXgIOBClHFwHCJDc-A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe7546f2a7so775254e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664905; x=1692269705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfJH3noYbWyg5mwtDgx4Z5kj3eCpv/dKZ/d4TuLP0Yc=;
        b=HVlb3qUeixdLvHluwokAgUxDQbLWk5a5BC3tppcBr0iWiehyvkVYyLWtKbk8dsbPpq
         tDiyWuvqpUHGU1ui4ByvIaawn/Pa48IwXAbRWxJodzCkFbZVRS7pDud15zIZe+ufr73V
         a8Cy/vGzHGVq/0xAYBdZ1uu67vKjHd+xKgFzr7mKHw0HXblxrGubPkQpeDQwY0aUUi2f
         ZP5I3aCsAKk58Hl8DBV9jvHx7PFzDuFJFHEPFmvsFrBi/WHittMh4ojAlrk+Ya0Cg+Z/
         vdSauxnFiYObgWdD9phfvOby2/u1RFand4eBr+lz2qbTUEOpREn9UjG3i6R5dADRa4wb
         29KQ==
X-Gm-Message-State: AOJu0YxJTVA+XWfnS1vIvnZxxPLeB10iJjWnXTm7qaXSndjv9jISVdSM
        PNFcjjb+wydTWrVmzk4DR2qqL6oPj27GIsF228v9/PVhbIULiVmARNrkEmi6sPeZMC4UxlKr6/N
        n2g33AjPNqU9gLo1rIVKdzerB8W22jGB8QoX4m8pvIVkAdNWoCniN258ovdNRM0cMqXJ/vdbtfi
        9BJbEGMygwXw==
X-Received: by 2002:ac2:5e70:0:b0:4f8:661f:60a4 with SMTP id a16-20020ac25e70000000b004f8661f60a4mr1345653lfr.41.1691664905131;
        Thu, 10 Aug 2023 03:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7GxqJXA2cePG8IGrxbzknyDxGlhlrTIntijSq8/dSqIIoMteFEGSHaAFE1+hQs9SuoD2yQ==
X-Received: by 2002:ac2:5e70:0:b0:4f8:661f:60a4 with SMTP id a16-20020ac25e70000000b004f8661f60a4mr1345637lfr.41.1691664904860;
        Thu, 10 Aug 2023 03:55:04 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-246-142.pool.digikabel.hu. [193.226.246.142])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7cd54000000b005231f324a0bsm643732edw.28.2023.08.10.03.55.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:55:04 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] fuse: add STATX request
Date:   Thu, 10 Aug 2023 12:54:58 +0200
Message-Id: <20230810105501.1418427-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810105501.1418427-1-mszeredi@redhat.com>
References: <20230810105501.1418427-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the same structure as statx.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/uapi/linux/fuse.h | 56 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b3fcab13fcd3..fe700b91b33b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -207,6 +207,9 @@
  *  - add FUSE_EXT_GROUPS
  *  - add FUSE_CREATE_SUPP_GROUP
  *  - add FUSE_HAS_EXPIRE_ONLY
+ *
+ *  7.39
+ *  - add FUSE_STATX and related structures
  */
 
 #ifndef _LINUX_FUSE_H
@@ -242,7 +245,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 38
+#define FUSE_KERNEL_MINOR_VERSION 39
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -269,6 +272,40 @@ struct fuse_attr {
 	uint32_t	flags;
 };
 
+/*
+ * The following structures are bit-for-bit compatible with the statx(2) ABI in
+ * Linux.
+ */
+struct fuse_sx_time {
+	int64_t		tv_sec;
+	uint32_t	tv_nsec;
+	int32_t		__reserved;
+};
+
+struct fuse_statx {
+	uint32_t	mask;
+	uint32_t	blksize;
+	uint64_t	attributes;
+	uint32_t	nlink;
+	uint32_t	uid;
+	uint32_t	gid;
+	uint16_t	mode;
+	uint16_t	__spare0[1];
+	uint64_t	ino;
+	uint64_t	size;
+	uint64_t	blocks;
+	uint64_t	attributes_mask;
+	struct fuse_sx_time	atime;
+	struct fuse_sx_time	btime;
+	struct fuse_sx_time	ctime;
+	struct fuse_sx_time	mtime;
+	uint32_t	rdev_major;
+	uint32_t	rdev_minor;
+	uint32_t	dev_major;
+	uint32_t	dev_minor;
+	uint64_t	__spare2[14];
+};
+
 struct fuse_kstatfs {
 	uint64_t	blocks;
 	uint64_t	bfree;
@@ -575,6 +612,7 @@ enum fuse_opcode {
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
+	FUSE_STATX		= 52,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -639,6 +677,22 @@ struct fuse_attr_out {
 	struct fuse_attr attr;
 };
 
+struct fuse_statx_in {
+	uint32_t	getattr_flags;
+	uint32_t	reserved;
+	uint64_t	fh;
+	uint32_t	sx_flags;
+	uint32_t	sx_mask;
+};
+
+struct fuse_statx_out {
+	uint64_t	attr_valid;	/* Cache timeout for the attributes */
+	uint32_t	attr_valid_nsec;
+	uint32_t	flags;
+	uint64_t	spare[2];
+	struct fuse_statx stat;
+};
+
 #define FUSE_COMPAT_MKNOD_IN_SIZE 8
 
 struct fuse_mknod_in {
-- 
2.40.1

