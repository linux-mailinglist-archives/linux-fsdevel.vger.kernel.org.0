Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1B7BBF5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjJFS4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjJFSzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2E11D
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etHlCA8T/PaxWUxEWZ1DvVJeeVyrnJ0a0ek/fvsTpN8=;
        b=TBNpFsCFmfMj+x/uu09BGL4A4RGBTUQd0pq4jg0/WGgv2K4FZ6mzPLlGIpMvkDnwxd4+Wf
        BVCYkGmpmZ+3nD7x1c3S4Im1secgoTEoHcVf7jN7TB/cdvLZmDo0XVtTUe6Wjnf6zM8qzu
        zxnZnR3Pj+QLNz2L/m0a8TlZ1CcQEDc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-nx3BStozNgq5I7j4-tObTg-1; Fri, 06 Oct 2023 14:52:40 -0400
X-MC-Unique: nx3BStozNgq5I7j4-tObTg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b65d7079faso190370966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618359; x=1697223159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etHlCA8T/PaxWUxEWZ1DvVJeeVyrnJ0a0ek/fvsTpN8=;
        b=iRahdfkx/hVD9qyWwrtcIKO6pUIrRdXw6pKArpeOwpqIL6vRq0OCn0gTHyFrRVzCQH
         4UR4bpBdCfCxJFlspmMSXcVaPJF86+3MnT1ButTajVbD4xgZTiMRO/Gizp4UWHWA41eP
         ixCPITYCF4x5AvfiqLdQVTsRA+3uNeDODR5TlRrh4ObATZyEVkyMEl9kABIKnVTpGx3V
         VddzeN/03GTPeJ8xlmO6czET/7yk5ErRnaY/vURR46WN2SKmaqeMaCg9FBeHjZSPFlHs
         z9LrD+77DYrcwk5KtKJghMH5pqO6C/ARJ38K8D2p/O+dzSJXVcJoEJIiihZGxPzKD+i3
         I7BQ==
X-Gm-Message-State: AOJu0Yzk6Tg1snGvyicfN+wbQSai+afbFt3hJJG3+E+loLU0CUUqGmkT
        D/Sni7R7d/cUk2xl1zc0ofTMF5uSXmDwuC4naoYAoUczLnWXeIoXamSTCXtZBfNAo5AA+thH34s
        wUYaDW8Z7ttV+tIG3GLE0gIuX
X-Received: by 2002:a17:906:cc53:b0:9ae:5523:3f8e with SMTP id mm19-20020a170906cc5300b009ae55233f8emr8487890ejb.63.1696618359272;
        Fri, 06 Oct 2023 11:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF73s7VGFatKV6LUYuO61TYbYu4BE1wLl/SWf4Vq8QcPJ6yV/S+GMfoQzJ3iL6XWu4mnlQgEg==
X-Received: by 2002:a17:906:cc53:b0:9ae:5523:3f8e with SMTP id mm19-20020a170906cc5300b009ae55233f8emr8487881ejb.63.1696618359073;
        Fri, 06 Oct 2023 11:52:39 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:38 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 22/28] xfs: initialize fs-verity on file open and cleanup on inode destruction
Date:   Fri,  6 Oct 2023 20:49:16 +0200
Message-Id: <20231006184922.252188-23-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 203700278ddb..a92c8197c26a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -31,6 +31,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1191,10 +1192,17 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error = 0;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 3cdb642961f4..6a3b5285044a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -47,6 +47,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -673,6 +674,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 
-- 
2.40.1

