Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC4E7BBF50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjJFSzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJFSyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F84112
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y62cirHyxw1nxIK5GngI9l6eX0UynAIUbjFVCcsuark=;
        b=HY6pZGhnSJngLJ+Izj+K3xHSNo048xOzDbWkQhXXh9Ydv63Wub9hqRBQm+ctuVL8X4RFbv
        uhEphTe8rb4u1NytWDX65vI1jvGzhducvpYp1l0q8DFYKqF4DT9tS0WIxDdyussEIDwisd
        fOY6NwVsxAReNpXyHyi5sj3S0V1pPn0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-W0XKeqmKMEOssehimltKSQ-1; Fri, 06 Oct 2023 14:52:42 -0400
X-MC-Unique: W0XKeqmKMEOssehimltKSQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso207423666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618361; x=1697223161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y62cirHyxw1nxIK5GngI9l6eX0UynAIUbjFVCcsuark=;
        b=OY34ZVwm088PyRg1YxDMVOmbro0pbaVt1OLOrObYKyrifyfx3ei0L0BwBJXRUw1xEe
         2k/I24xX7dCZh1TrZ5AWUhC83M4ffStMSbbg/Tiae10fiGyjknJOzgSv4F2FIqy41nph
         ibvXSsJAW33l/ZViq7byOXRi12dKPkIop73bC3/DXcDufTK50FmmSDurEs7YDSehCijz
         N1mOJ3SbJyzLUogv/PiosvkK+haoytfaU875UQ/9cwf5qRpL2nPjjiDWBE7QyKsW1OMR
         wDwEr+asH2H9XSRHkNSfLuo2HREd0woja6HyyXCcQzkI+J3U/mdRVgBzIj2xZsbhUVOs
         KrTQ==
X-Gm-Message-State: AOJu0YwpyGntakrJeW1g6BDPjypiQTHUkRgfgNzNnFewLMNvyRsmuF8o
        Ol7d1JMazpYw8Vd4XOGxXXaFaU4vQi0XBN7VQbmqUznewXv0DBE48u5OaqRCCbRZIaTLGYhTuG+
        Ucvac7lhNb9BJ89l93ADw0Vj9
X-Received: by 2002:a17:906:3ca9:b0:9ba:7f5:3602 with SMTP id b9-20020a1709063ca900b009ba07f53602mr583728ejh.60.1696618361040;
        Fri, 06 Oct 2023 11:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVZ+8RYyWx/WXsHj7JKes+e1LLF/dLUz0XxHhOXmY4bfEBU5dLyL1gt2j4iCnrrEatFiiqNw==
X-Received: by 2002:a17:906:3ca9:b0:9ba:7f5:3602 with SMTP id b9-20020a1709063ca900b009ba07f53602mr583721ejh.60.1696618360843;
        Fri, 06 Oct 2023 11:52:40 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:40 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 24/28] xfs: disable direct read path for fs-verity sealed files
Date:   Fri,  6 Oct 2023 20:49:18 +0200
Message-Id: <20231006184922.252188-25-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a92c8197c26a..7363cbdff803 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -244,7 +244,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -297,10 +298,17 @@ xfs_file_read_iter(
 
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
 		ret = xfs_file_dio_read(iocb, to);
-	else
+	else {
+		/*
+		 * In case fs-verity is enabled, we also fallback to the
+		 * buffered read from the direct read path. Therefore,
+		 * IOCB_DIRECT is set and need to be cleared
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
 		ret = xfs_file_buffered_read(iocb, to);
+	}
 
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);
-- 
2.40.1

