Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA157BBF29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjJFSyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjJFSyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6DF9
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbAra3ZTi+LxukZ164wISWciUbvDI2f96hncpD1Yjx0=;
        b=MjqdRcKgm93A0Dx8SKBTQ/gWZqlATLlTqw1y7B/gxcsOF+8Qb3oqrkRdXZR70SGJe8wFhi
        wkWPjlob2vNfqqNPM9APYiLGmMMoGXuLXMovc2aLITughE8mfgm3vvKMknQUcdH7J5k4J0
        mqYOP2JjQOCK8wxcKN/wagiFH6R7hWI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-oTwkBKHENaG3MPoqT7TgRw-1; Fri, 06 Oct 2023 14:52:32 -0400
X-MC-Unique: oTwkBKHENaG3MPoqT7TgRw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ba0616b761so47961266b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618351; x=1697223151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbAra3ZTi+LxukZ164wISWciUbvDI2f96hncpD1Yjx0=;
        b=wleocTOBio0q2hVgG+NGKPQ95SkFAKkA8aJFCx/32/omsBNKAsQcqUcRmSRtdtBivR
         DqS50tHb1FyYyI3M4MNeOnhKYBKhIrFcfrqSeImoeal9dTCwqtqC2YXqo15H50j83weV
         npFhmKbUuF+w6lafyqla+lhI2Wyj95X+MeFHhCAdAH5De0+Kj+oWITZg0uN1pp96Hzdf
         Hh9f2J0eMxX3Ft9BapelAxgPnnIigrxR/9qZ+j6jLUzKbDjGmSAdAMRnG3xyXaGSD1pG
         YaZRKCzdQGAsd9NBarp+gmzCZHjJbP2waTFzDxK4AM3JFQw6eOjVekIxK9almc052aw6
         1zBg==
X-Gm-Message-State: AOJu0YzL4wOC1S0L/2tgdn4TUo/Xogj+GTwb/JivRfpLJ0UdKmeE1g78
        olOQxoUnaBf7f/B4hvrAg7E8wlosm3VB5r0MzTptsUiblbDeEzhTsZp8Jaay0Jh7ms9OcGQeZCa
        FZjUakfGLkvQEoj7fWcZI8syivTInDz/E
X-Received: by 2002:a17:906:29a:b0:9aa:23c9:aa52 with SMTP id 26-20020a170906029a00b009aa23c9aa52mr8067384ejf.20.1696618350850;
        Fri, 06 Oct 2023 11:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAvtFtJNnveu1/9BEXcBJfWoGBg75gg0idvpFq2vl8+1sN7jevtwQabTLBIM8w3mhGcmlywA==
X-Received: by 2002:a17:906:29a:b0:9aa:23c9:aa52 with SMTP id 26-20020a170906029a00b009aa23c9aa52mr8067378ejf.20.1696618350585;
        Fri, 06 Oct 2023 11:52:30 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:29 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 13/28] xfs: add XBF_VERITY_CHECKED xfs_buf flag
Date:   Fri,  6 Oct 2023 20:49:07 +0200
Message-Id: <20231006184922.252188-14-aalbersh@redhat.com>
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

One of essential ideas of fs-verity is that pages which are already
verified won't need to be re-verified if they still in page cache.

XFS will store Merkle tree blocks in extended attributes. Each
attribute has one Merkle tree block. When read extended attribute
data is put into xfs_buf.

The data in the buffer is not aligned with xfs_buf pages and we
don't have a reference to these pages. Moreover, these pages are
released when value is copied out in xfs_attr code. In other words,
we can not directly mark underlying xfs_buf's pages as verified.

One way to track that these pages were verified is to mark xattr's
buffer as verified instead. If buffer is evicted the incore
XBF_VERITY_CHECKED flag is lost. When the xattr is read again
xfs_attr_get() returns new buffer without the flag. The xfs_buf's
flag is then used to tell fs-verity if it's new page or cached one.

The meaning of the flag is that value of the extended attribute in
the buffer is verified.

Note that, the underlying pages have PageChecked() == false (the way
fs-verity identifies verified pages).

The flag is being used later to SetPageChecked() on pages handed to
the fs-verity.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_buf.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index df8f47953bb4..d0fadb6d4b59 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -24,14 +24,15 @@ struct xfs_buf;
 
 #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
 
-#define XBF_READ	 (1u << 0) /* buffer intended for reading from device */
-#define XBF_WRITE	 (1u << 1) /* buffer intended for writing to device */
-#define XBF_READ_AHEAD	 (1u << 2) /* asynchronous read-ahead */
-#define XBF_NO_IOACCT	 (1u << 3) /* bypass I/O accounting (non-LRU bufs) */
-#define XBF_ASYNC	 (1u << 4) /* initiator will not wait for completion */
-#define XBF_DONE	 (1u << 5) /* all pages in the buffer uptodate */
-#define XBF_STALE	 (1u << 6) /* buffer has been staled, do not find it */
-#define XBF_WRITE_FAIL	 (1u << 7) /* async writes have failed on this buffer */
+#define XBF_READ		(1u << 0) /* buffer intended for reading from device */
+#define XBF_WRITE		(1u << 1) /* buffer intended for writing to device */
+#define XBF_READ_AHEAD		(1u << 2) /* asynchronous read-ahead */
+#define XBF_NO_IOACCT		(1u << 3) /* bypass I/O accounting (non-LRU bufs) */
+#define XBF_ASYNC		(1u << 4) /* initiator will not wait for completion */
+#define XBF_DONE		(1u << 5) /* all pages in the buffer uptodate */
+#define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
+#define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
+#define XBF_VERITY_CHECKED	(1u << 8) /* buffer was verified by fs-verity*/
 
 /* buffer type flags for write callbacks */
 #define _XBF_INODES	 (1u << 16)/* inode buffer */
-- 
2.40.1

