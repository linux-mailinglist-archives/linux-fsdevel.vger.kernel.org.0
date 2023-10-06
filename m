Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD77BBF0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjJFSxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJFSxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC9AC6
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DaHECssEKXoW7hu/fYmfrh3doxCibaAyOF7u4qbdM4E=;
        b=Bj2HIQJwkidOzL+qAVqipVvGrKq6V85hRBDBWyMg87S0H0X7fNliZNaUsspFd/OhBLV2Bu
        28l4JCvxr8J3qLB0CbTKFUoI06hx2b6S8tUxmQVrfKlUrr0bJMojjiri8i9dFtEsrjVaDA
        bgKKZHBTvNOE/nScMHNl/93b9Irn1Os=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-bLxr1L9TNfucKd74clg-yQ-1; Fri, 06 Oct 2023 14:52:22 -0400
X-MC-Unique: bLxr1L9TNfucKd74clg-yQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso207401466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618341; x=1697223141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaHECssEKXoW7hu/fYmfrh3doxCibaAyOF7u4qbdM4E=;
        b=PJ12Jj1feWnorLLhd2wlxdxIGaejH+T4tK1CMGEywxnzAbqsT2/r78iIiaNML289Zl
         hYhGmXJes8yRmep44DMn9hlpSz3Y7IupbHAURDQc49AigfT0egxfZ8L9W4+ZgshQocEo
         JxGSqTGjua8G514gnPuiJt0zfQIjFnQk0hc+PyRCYd6dNBjwTJHcvZMYvFA7YqWJE6Id
         QE4iFYNF/Iuca7OkZxMlT7u46GF6nyfX5cwCt1yQIS1/X5Q/JqE/LjaHX1Dd4BlbclPB
         a/nq1fGKtz7eJLZcIeKFLQKvS1LdjwcRgAKWYGKmHbQO46Q8eiGhp8ZraLmPFYFfNY90
         ys+w==
X-Gm-Message-State: AOJu0Yznfefg7JnSYwT6978mm2BGP1PMH2quHqESFn6d8k+R47W96VOY
        vqS60zZGc2EFYBkINnTRNGWDNFEALvFYWOpG0t5DZ9XdFFBrTRGK3rlBgTrwIp/ao8OxWeJNjds
        SJwM5R8R0t6ySfNUV1PnR7IVv
X-Received: by 2002:a17:906:74ce:b0:9ba:2a5:75c5 with SMTP id z14-20020a17090674ce00b009ba02a575c5mr2163783ejl.75.1696618341028;
        Fri, 06 Oct 2023 11:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUGUCsuEIbPh9jWoEdfWB/Qb0RFrl18MRQsei0qGzW+4gIMWfP6mWpY/zlfNnJBryOxNnj4Q==
X-Received: by 2002:a17:906:74ce:b0:9ba:2a5:75c5 with SMTP id z14-20020a17090674ce00b009ba02a575c5mr2163772ejl.75.1696618340817;
        Fri, 06 Oct 2023 11:52:20 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:20 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH v3 03/28] xfs: define parent pointer xattr format
Date:   Fri,  6 Oct 2023 20:48:57 +0200
Message-Id: <20231006184922.252188-4-aalbersh@redhat.com>
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

From: Allison Henderson <allison.henderson@oracle.com>

We need to define the parent pointer attribute format before we start
adding support for it into all the code that needs to use it. The EA
format we will use encodes the following information:

        name={parent inode #, parent inode generation, dirent offset}
        value={dirent filename}

The inode/gen gives all the information we need to reliably identify the
parent without requiring child->parent lock ordering, and allows
userspace to do pathname component level reconstruction without the
kernel ever needing to verify the parent itself as part of ioctl calls.

By using the dirent offset in the EA name, we have a method of knowing
the exact parent pointer EA we need to modify/remove in rename/unlink
without an unbound EA name search.

By keeping the dirent name in the value, we have enough information to
be able to validate and reconstruct damaged directory trees. While the
diroffset of a filename alone is not unique enough to identify the
child, the {diroffset,filename,child_inode} tuple is sufficient. That
is, if the diroffset gets reused and points to a different filename, we
can detect that from the contents of EA. If a link of the same name is
created, then we can check whether it points at the same inode as the
parent EA we current have.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_da_format.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index fca622d43a38..307c8cdb6f10 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -862,4 +862,29 @@ static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)
 xfs_failaddr_t xfs_da3_blkinfo_verify(struct xfs_buf *bp,
 				      struct xfs_da3_blkinfo *hdr3);
 
+/*
+ * Parent pointer attribute format definition
+ *
+ * EA name encodes the parent inode number, generation and the offset of
+ * the dirent that points to the child inode. The EA value contains the
+ * same name as the dirent in the parent directory.
+ */
+struct xfs_parent_name_rec {
+	__be64  p_ino;
+	__be32  p_gen;
+	__be32  p_diroffset;
+};
+
+/*
+ * incore version of the above, also contains name pointers so callers
+ * can pass/obtain all the parent pointer information in a single structure
+ */
+struct xfs_parent_name_irec {
+	xfs_ino_t		p_ino;
+	uint32_t		p_gen;
+	xfs_dir2_dataptr_t	p_diroffset;
+	const char		*p_name;
+	uint8_t			p_namelen;
+};
+
 #endif /* __XFS_DA_FORMAT_H__ */
-- 
2.40.1

