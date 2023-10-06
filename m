Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18E7BBF59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjJFS4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjJFSzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4E011F
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+hERDddpeeIHe4DM9B5TqIjpvoGQYj+Dd7I5rMKZNk=;
        b=IU6PD6w6/98OoEyyvctEV/RqNXkJUk7FhDSRQA8Dh/ESJ3QnEolJbDJYoLuiAi6Gez3+1f
        VfneSVqTAD7qg5n5+zh/Ngnr5tFau4t5CfIWf2p+fBxmVyuPq4zLCucsWQxy5eaUD2nGmv
        NxTP6RhMaSOeevQP/3PjEuWoTAkJr4o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-XGLxdIIwNNa6Onv7AhjvtA-1; Fri, 06 Oct 2023 14:52:45 -0400
X-MC-Unique: XGLxdIIwNNa6Onv7AhjvtA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae7663e604so206211066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618363; x=1697223163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+hERDddpeeIHe4DM9B5TqIjpvoGQYj+Dd7I5rMKZNk=;
        b=wFK5hkx/vFaJWy9ebuQX7Yavzr63KlPExKp0b5jPMNh5FSb5NDCNGCmgB/xfLOLiO0
         Ca90Fq8UCgcC73Ocz4s6zWIp06cW8baOcspmEsVq8VI2w2u70jNFdYw6qi/5n3rLR7Cf
         H1qnOAT1RRgMfDwY66RYbghi2WM1r5s/NgyjxiojWuLVyD1SdfIypoPx/Jqd37hwTscb
         wts3NWRyzj4XkS1okIhoMpdoUm9Z1+1ujoToL2U3817jvsKVpL7CDQZm9qCh8dCJaIJz
         LHzTLE42zaR7eveJhNHKGzgYmQlApWLHBWJecPRNEuF5aegtRayJwztiKrq0CFjWEZs7
         lCyQ==
X-Gm-Message-State: AOJu0Yzs2ryy4a86TfOnH3p+OoRn6OnBf0a0kimnJH78568EXaqyBwTv
        nZTAqTENP98uK4G8VfpqB9wLfJaKyQDfOf09sah6iyDHyMh+Pak7gSda7GuKkNZkXpoW2vi5KGy
        T2fdySDFCpF08Fs8LDWOssW2K
X-Received: by 2002:a17:906:31c7:b0:9ae:673a:88c8 with SMTP id f7-20020a17090631c700b009ae673a88c8mr8463909ejf.21.1696618363792;
        Fri, 06 Oct 2023 11:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj4mxEdfFg60CQgUH6Kl9WUvjEgQ0RS1ocFOzUW2NWuCD/0V4jWL98MJ2Rk4lHCKYOiP5xjQ==
X-Received: by 2002:a17:906:31c7:b0:9ae:673a:88c8 with SMTP id f7-20020a17090631c700b009ae673a88c8mr8463904ejf.21.1696618363632;
        Fri, 06 Oct 2023 11:52:43 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:43 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 27/28] xfs: add fs-verity ioctls
Date:   Fri,  6 Oct 2023 20:49:21 +0200
Message-Id: <20231006184922.252188-28-aalbersh@redhat.com>
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

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_ioctl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 3d6d680b6cf3..ffa04f0aed4a 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2154,6 +2155,22 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, (const void __user *)arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, (void __user *)arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp,
+						    (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.40.1

