Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938364BB17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiLMRbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiLMRan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEFE2338C
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMVdYEIjGzzgVCYG3YnfAdNBSxBfSOUyway7T/qxVAM=;
        b=EPPcIlxEx/API2vsSodwikaOvjd5ittuUfdOaebZuJLy8sxwkiDhrgQVtMNhFRyMZ2vJIf
        xldeGkDbEsnXUpcmZ2JANokqpezVc/CubbmTgQqbU7hrynlQPSghALcfQIsOsJwwABVBYj
        0lIdzbY0+WyCkgi1CDxEsXsdE+hXPX4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-iXwPUxe7NkmLoqvCpmsDwA-1; Tue, 13 Dec 2022 12:29:46 -0500
X-MC-Unique: iXwPUxe7NkmLoqvCpmsDwA-1
Received: by mail-ej1-f70.google.com with SMTP id qb2-20020a1709077e8200b007bf01e43797so9793459ejc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMVdYEIjGzzgVCYG3YnfAdNBSxBfSOUyway7T/qxVAM=;
        b=b31+fe9ZI2qUrezgXyiwvvDH7YLfSf7iET+Sgo9tFMsqqXyo3vyrxMmRo1RLzvQOFp
         dyiELxH1BTwQlnM/Sje5ZS7a+62qVzWOOfSwEAmBVmt0fVvhaPmrmTwwlX/FOZ/4qTJo
         gcIy+px8hQ3GuOoGYt5XzgH78rmiLB9RWCt0FJ7fnMoL+qQr9S364/t4gCbWEBoMKGIK
         QXw5vWs1VHddsZ4rjyLUQMVCWBJhQ5qCWl+Zec4ECiQ6kaeW3fDhgFXzKMVwyweq0xBr
         LbfX2j+rjD1J/42so3jmv1vYfyeGubvqehIGEopZPN19tVoyLQT044CX9tWMA7Keg45W
         LF5g==
X-Gm-Message-State: ANoB5pkQ4rvENMa6YrlFKhgDuarMz/m2YC3Gc2dTlPbNqjVbJhBLj7Bk
        vUFdnWY3huqUHhkGRffSUNe+gqEGJ4pdHQWfDLOrzFqADoa01udMdeJCAeaSx5mjovqO4+XqROl
        Q2xMw0hxznrv24eOAjjW0Y8Lr
X-Received: by 2002:a05:6402:f19:b0:46f:7453:a999 with SMTP id i25-20020a0564020f1900b0046f7453a999mr17902901eda.39.1670952584654;
        Tue, 13 Dec 2022 09:29:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5dpb+BtrXOV48EoDvxcYKIw/k9+7UnUHv1T33vANcGszfmmkbpje/gNx4hIvVmQXcwPVhXtQ==
X-Received: by 2002:a05:6402:f19:b0:46f:7453:a999 with SMTP id i25-20020a0564020f1900b0046f7453a999mr17902886eda.39.1670952584513;
        Tue, 13 Dec 2022 09:29:44 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:43 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 06/11] xfs: initialize fs-verity on file open and cleanup on inode destruction
Date:   Tue, 13 Dec 2022 18:29:30 +0100
Message-Id: <20221213172935.680971-7-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 242165580e682..5eadd9a37c50e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -32,6 +32,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1170,9 +1171,16 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error = 0;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8f1e9b9ed35d9..50c2c819ba940 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -45,6 +45,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -647,6 +648,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 
-- 
2.31.1

