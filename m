Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B798B7BBF48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjJFSzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjJFSyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7B9109
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcRVHX8JFurBwxht+2exa+IxBRQV9tLkRgSIzCgziEo=;
        b=Av5eJCpT//MkGXVSTNRa69G3jvlWlU1QMSosM4MpNoPWhN/g5WtyMhsWeHuhZZsgSk2xz6
        RkX1W5akzF2/LbBOOJ4LgmR4yS/uZpHJTMSu9Lu/RRKDGzSNY9CJP6SyQr1XnxFbiIEgXB
        9l3e/e5KY6n8qdp3qxvItT3ZN4P/9lM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686--RtEPhEVNaihncEu27wccA-1; Fri, 06 Oct 2023 14:52:37 -0400
X-MC-Unique: -RtEPhEVNaihncEu27wccA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae0bf9c0a9so189225966b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618356; x=1697223156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcRVHX8JFurBwxht+2exa+IxBRQV9tLkRgSIzCgziEo=;
        b=SvztKWlbYNJMEATILgehm2NB4OPpJ5iL8BSjndw3loWyJC4btT+N0Y1p7/ML1TZ3sb
         /uLnqRB0os4we8soE5ORr/2O5oc1XBc30mo+xrKgnflZeokLWyMN5/MeaLJsZz5ol02V
         eUggjoWPc/ERkWe+WQk79546v8ToJMGJPVErqV5jFrn63GBjxxAtFACEY5IPVYhmExyA
         zKTL6/x6XPd3DHleOXgYGJJx1c3Kwb00N6LF3qEP7ne1C7Fh1c0hp3zH+NdCesln2GVA
         BOT+deZqknyM+T6g4ACLSh5sz+UUsnRG7vrClHt3TFVpUOozqPQpSCjNpIUv3IIskUc0
         hUKg==
X-Gm-Message-State: AOJu0YzRt7lcZZBuTDxFA8KFtv2k4lLpd51ruQ2PTbsZGG1rLKcdzzKa
        uSm1FUbmIyLwkMuuBSPC5xu1ikvXBjgf7oXTTdEopRsiphG4jO1r7zLA8inXvXo9RVkrBEhulIR
        mrQAzJOit4aMpKRYfGUXkOBO20q3vGvpp
X-Received: by 2002:a17:907:77c9:b0:9b2:6d09:847c with SMTP id kz9-20020a17090777c900b009b26d09847cmr7386276ejc.10.1696618356604;
        Fri, 06 Oct 2023 11:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrIQk7NnCDbZwY+PjQ3U9MlJNLuObcZuXDq08LQZ7kco8xmXaUKZy2GLL1ssPfQnC1xSPWLQ==
X-Received: by 2002:a17:907:77c9:b0:9b2:6d09:847c with SMTP id kz9-20020a17090777c900b009b26d09847cmr7386255ejc.10.1696618356021;
        Fri, 06 Oct 2023 11:52:36 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:35 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 19/28] xfs: add XBF_DOUBLE_ALLOC to increase size of the buffer
Date:   Fri,  6 Oct 2023 20:49:13 +0200
Message-Id: <20231006184922.252188-20-aalbersh@redhat.com>
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

For fs-verity integration, XFS needs to supply kaddr'es of Merkle
tree blocks to fs-verity core and track which blocks are already
verified. One way to track verified status is to set xfs_buf flag
(previously added XBF_VERITY_CHECKED). When xfs_buf is evicted from
memory we loose verified status. Otherwise, fs-verity hits the
xfs_buf which is still in cache and contains already verified blocks.

However, the leaf blocks which are read to the xfs_buf contains leaf
headers. xfs_attr_get() allocates new pages and copies out the data
without header. Those newly allocated pages with extended attribute
data are not attached to the buffer anymore.

Add new XBF_DOUBLE_ALLOC which makes xfs_buf allocates x2 memory for
the buffer. Additional memory will be used for a copy of the
attribute data but without any headers. Also, make
xfs_attr_rmtval_get() to copy data to the buffer itself if XFS asked
for fs-verity block.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr_remote.c | 27 +++++++++++++++++++++++++--
 fs/xfs/xfs_buf.c                |  7 ++++++-
 fs/xfs/xfs_buf.h                |  1 +
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 5762135dc2a6..7657daf7cff3 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -392,12 +392,22 @@ xfs_attr_rmtval_get(
 	int			blkcnt = args->rmtblkcnt;
 	int			i;
 	int			offset = 0;
+	int			flags = 0;
+	void			*addr;
 
 	trace_xfs_attr_rmtval_get(args);
 
 	ASSERT(args->valuelen != 0);
 	ASSERT(args->rmtvaluelen == args->valuelen);
 
+	/*
+	 * We also check for _OP_BUFFER as we want to trigger on
+	 * verity blocks only, not on verity_descriptor
+	 */
+	if (args->attr_filter & XFS_ATTR_VERITY &&
+			args->op_flags & XFS_DA_OP_BUFFER)
+		flags = XBF_DOUBLE_ALLOC;
+
 	valuelen = args->rmtvaluelen;
 	while (valuelen > 0) {
 		nmap = ATTR_RMTVALUE_MAPSIZE;
@@ -417,13 +427,25 @@ xfs_attr_rmtval_get(
 			dblkno = XFS_FSB_TO_DADDR(mp, map[i].br_startblock);
 			dblkcnt = XFS_FSB_TO_BB(mp, map[i].br_blockcount);
 			error = xfs_buf_read(mp->m_ddev_targp, dblkno, dblkcnt,
-					0, &bp, &xfs_attr3_rmt_buf_ops);
+					flags, &bp, &xfs_attr3_rmt_buf_ops);
 			if (error)
 				return error;
 
+			/*
+			 * For fs-verity we allocated more space. That space is
+			 * filled with the same xattr data but without leaf
+			 * headers. Point args->value to that data
+			 */
+			if (flags & XBF_DOUBLE_ALLOC) {
+				addr = xfs_buf_offset(bp, BBTOB(bp->b_length));
+				args->value = addr;
+				dst = addr;
+			}
+
 			error = xfs_attr_rmtval_copyout(mp, bp, args->dp->i_ino,
 							&offset, &valuelen,
 							&dst);
+
 			xfs_buf_unlock(bp);
 			/* must be released by the caller */
 			if (args->op_flags & XFS_DA_OP_BUFFER)
@@ -521,7 +543,8 @@ xfs_attr_rmtval_set_value(
 		dblkno = XFS_FSB_TO_DADDR(mp, map.br_startblock),
 		dblkcnt = XFS_FSB_TO_BB(mp, map.br_blockcount);
 
-		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, 0, &bp);
+		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt,
+				XBF_DOUBLE_ALLOC, &bp);
 		if (error)
 			return error;
 		bp->b_ops = &xfs_attr3_rmt_buf_ops;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index c1ece4a08ff4..c5071a970596 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -328,6 +328,9 @@ xfs_buf_alloc_kmem(
 	xfs_km_flags_t	kmflag_mask = KM_NOFS;
 	size_t		size = BBTOB(bp->b_length);
 
+	if (flags & XBF_DOUBLE_ALLOC)
+		size *= 2;
+
 	/* Assure zeroed buffer for non-read cases. */
 	if (!(flags & XBF_READ))
 		kmflag_mask |= KM_ZERO;
@@ -358,6 +361,7 @@ xfs_buf_alloc_pages(
 {
 	gfp_t		gfp_mask = __GFP_NOWARN;
 	long		filled = 0;
+	int		mul = (flags & XBF_DOUBLE_ALLOC) ? 2 : 1;
 
 	if (flags & XBF_READ_AHEAD)
 		gfp_mask |= __GFP_NORETRY;
@@ -365,7 +369,8 @@ xfs_buf_alloc_pages(
 		gfp_mask |= GFP_NOFS;
 
 	/* Make sure that we have a page list */
-	bp->b_page_count = DIV_ROUND_UP(BBTOB(bp->b_length), PAGE_SIZE);
+	bp->b_page_count = DIV_ROUND_UP(BBTOB(bp->b_length*mul), PAGE_SIZE);
+
 	if (bp->b_page_count <= XB_PAGES) {
 		bp->b_pages = bp->b_page_array;
 	} else {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index e79bfe548952..8e3272fb6e65 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -33,6 +33,7 @@ struct xfs_buf;
 #define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
 #define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
 #define XBF_VERITY_CHECKED	(1u << 8) /* buffer was verified by fs-verity*/
+#define XBF_DOUBLE_ALLOC	(1u << 9) /* double allocated space */
 
 /* buffer type flags for write callbacks */
 #define _XBF_INODES	 (1u << 16)/* inode buffer */
-- 
2.40.1

