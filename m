Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1414D64BB14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiLMRbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiLMRaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3823167
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nn5AV0iauh40sGcbOOXIUaQzVDgF5CNNvId9f7BzBCg=;
        b=cojLhd5zAJMHSNXi1rVZiA5Un1lCpaIyfVNiDQCEj7cXvDh2qlx4pf247P1CTy1lBkt9AI
        L8iSaoZ8lxTYSQ4mj2BZbMAvVSUJnSjTYDYPUdYHeK7oImTfDt8B3dIQl+ehK3tUK8KeI0
        l9yvboS/j69Bv6PrrlfJm/0tT84SOjM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-VkuLXk0lNE6Nl0HrxwdKLA-1; Tue, 13 Dec 2022 12:29:44 -0500
X-MC-Unique: VkuLXk0lNE6Nl0HrxwdKLA-1
Received: by mail-ed1-f69.google.com with SMTP id z16-20020a05640235d000b0046d0912ae25so7687956edc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn5AV0iauh40sGcbOOXIUaQzVDgF5CNNvId9f7BzBCg=;
        b=3skW4p6ZoyYS4h820scU7HDHmFbojVU1KPj54bvEGqIMJtner75tTX6s3SGrUoeal7
         oD4+qb4ybWnOZy3tjPbqp0zmcLdlu8b0kkOaK2fsKwpyb/gQBqwLf1s0VVfy81qsB98h
         RBg0Iid3nO5+SLUk+BF9/jwI+hJmzwTJnChpNXQrFoI7iPM7zW4pQU1dsmp0rHNx+6Jr
         jrz3+clZrrGsbaCM4PRDAV1NpsDPr4tmDuE9I/pKjMXMzHSA2afgxfkAv++w6SDvI9MM
         4/aZSlZOx+wRQTAOYE3SaaxKjy72V2dl7lkGGBYu6+ZbmQ/d7sJEFaGLrYujdMmsgb/5
         v8Vg==
X-Gm-Message-State: ANoB5pnjvtJhENea6f+woOA/fu/aFNyt5Py2x3ozZ8jtdnYcZ5On7KVP
        OWBrthh8oDN50D+htJUwmZpC9/6r7IkwRtK79t4sl2c1nZ24fqOA+Bznww2O/TJbjhNZjTxVOeC
        6Nc0WpXuMf7L+wLNZEWkZhcvu
X-Received: by 2002:a05:6402:e06:b0:461:9764:15f0 with SMTP id h6-20020a0564020e0600b00461976415f0mr18787466edh.38.1670952583168;
        Tue, 13 Dec 2022 09:29:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6qdM1QaM3TVFAFyYeHnK+MxQfi4OtkyAMx8DAcTi2ppVi2HCox+UIpJMvIS8HSe3W6ErI54w==
X-Received: by 2002:a05:6402:e06:b0:461:9764:15f0 with SMTP id h6-20020a0564020e0600b00461976415f0mr18787454edh.38.1670952582994;
        Tue, 13 Dec 2022 09:29:42 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:42 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 05/11] xfs: add inode on-disk VERITY flag
Date:   Tue, 13 Dec 2022 18:29:29 +0100
Message-Id: <20221213172935.680971-6-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add flag to mark inodes which have fs-verity enabled on them (i.e.
descriptor exist and tree is built).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_format.h | 4 +++-
 fs/xfs/xfs_inode.c         | 2 ++
 fs/xfs/xfs_iops.c          | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 2b76e646e6f14..6950a4ef19967 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1073,16 +1073,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+#define XFS_DIFLAG2_VERITY_BIT	5	/* inode sealed by fsverity */
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_VERITY	(1 << XFS_DIFLAG2_VERITY_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_VERITY)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f08a2d5f96ad4..8d9c9697d3619 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -636,6 +636,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+			flags |= FS_VERITY_FL;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 9c90cfcecabc2..b229d25c1c3d6 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1236,6 +1236,8 @@ xfs_diflags_to_iflags(
 		flags |= S_NOATIME;
 	if (init && xfs_inode_should_enable_dax(ip))
 		flags |= S_DAX;
+	if (xflags & FS_VERITY_FL)
+		flags |= S_VERITY;
 
 	/*
 	 * S_DAX can only be set during inode initialization and is never set by
-- 
2.31.1

