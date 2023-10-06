Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737127BBF4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjJFSzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjJFSyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C3C113
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/AveBNSqmjIJtYI3+6LuAlhQmhnFexTVHM7C0k2E9s=;
        b=am8/Y8V/hwobRPd1KA+6npyXDHxN9o+6dKBg89lHZg7BgpPh4zyPr+L3INi7cpmQHA+Qzz
        Ov11LPoZCN3x92mpwHWxTS01WD3B4V06p3ukf2vepZHx7Itd3c2TODfQAFIU3Q1/cbjAnQ
        rAWMIFw2CesT0sohkoAJqflSue3mh4k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-leEQT97FPPemFmWaxGa10g-1; Fri, 06 Oct 2023 14:52:37 -0400
X-MC-Unique: leEQT97FPPemFmWaxGa10g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a9e3f703dfso197034666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618355; x=1697223155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/AveBNSqmjIJtYI3+6LuAlhQmhnFexTVHM7C0k2E9s=;
        b=hjdXP/gQrIpMhz1QHVWhFGhRQ1zG0UH6EPvaDkVjBxGnu/NEWOywmjBYMh4imbCtTI
         Cq/4YZJGd6DhC+dfNnoaDIt55FC5+A04nrl1HFarQTx+97gnt1PnluYPGHVxxyqiBzkY
         m1eA7i6CDGgXidL4YapyrmdyX/dE0uWwxUCnQt3pMMKd7iy+V4vb0MK4p3CX1iSiM7A8
         slp9NWDHzbLxo0pNTLpTIGFMpOOWbnl+ycXH2Yqr6Qd7VWBq11wv6URz0/6CSvKGJC/j
         n/MPx6gnkk/FS7eR46wEp8bHFBJe8HdkumPg0tD1zl9EulbrVGLfYqiMGx9vsqs+YBGe
         QDww==
X-Gm-Message-State: AOJu0YzC3jBNdob8Za/h2AGSy+otmOeeQvVgNhcDDawDO88VqIqCfbhN
        LaLMwfANfd3TL6T/ZKY9w5/5FufeE2SnUVSK+b9ileLHXgTygXm6gJ2Nx93Zb8lWFvs1QoZLruL
        pibUtedOFvzeraogDrNbmmfQW
X-Received: by 2002:a17:906:9c1:b0:9ae:5aa4:9fa with SMTP id r1-20020a17090609c100b009ae5aa409famr8090648eje.42.1696618355322;
        Fri, 06 Oct 2023 11:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOVx3rLvVBE5QUfisMFkx2Pla6kAmWa2HIAK3od296Wuq43rVklqeW33wJg0+k4bCeT0eC3A==
X-Received: by 2002:a17:906:9c1:b0:9ae:5aa4:9fa with SMTP id r1-20020a17090609c100b009ae5aa409famr8090638eje.42.1696618355160;
        Fri, 06 Oct 2023 11:52:35 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:34 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 18/28] xfs: make xfs_buf_get() to take XBF_* flags
Date:   Fri,  6 Oct 2023 20:49:12 +0200
Message-Id: <20231006184922.252188-19-aalbersh@redhat.com>
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

Allow passing XBF_* buffer flags from xfs_buf_get(). This will allow
fs-verity to specify flag for increased buffer size.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr_remote.c | 2 +-
 fs/xfs/libxfs/xfs_sb.c          | 2 +-
 fs/xfs/xfs_buf.h                | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 72908e0e1c86..5762135dc2a6 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -521,7 +521,7 @@ xfs_attr_rmtval_set_value(
 		dblkno = XFS_FSB_TO_DADDR(mp, map.br_startblock),
 		dblkcnt = XFS_FSB_TO_BB(mp, map.br_blockcount);
 
-		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, &bp);
+		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, 0, &bp);
 		if (error)
 			return error;
 		bp->b_ops = &xfs_attr3_rmt_buf_ops;
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 6264daaab37b..4191da4fb669 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1096,7 +1096,7 @@ xfs_update_secondary_sbs(
 
 		error = xfs_buf_get(mp->m_ddev_targp,
 				 XFS_AG_DADDR(mp, pag->pag_agno, XFS_SB_DADDR),
-				 XFS_FSS_TO_BB(mp, 1), &bp);
+				 XFS_FSS_TO_BB(mp, 1), 0, &bp);
 		/*
 		 * If we get an error reading or writing alternate superblocks,
 		 * continue.  xfs_repair chooses the "best" superblock based
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d0fadb6d4b59..e79bfe548952 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -243,11 +243,12 @@ xfs_buf_get(
 	struct xfs_buftarg	*target,
 	xfs_daddr_t		blkno,
 	size_t			numblks,
+	xfs_buf_flags_t		flags,
 	struct xfs_buf		**bpp)
 {
 	DEFINE_SINGLE_BUF_MAP(map, blkno, numblks);
 
-	return xfs_buf_get_map(target, &map, 1, 0, bpp);
+	return xfs_buf_get_map(target, &map, 1, flags, bpp);
 }
 
 static inline int
-- 
2.40.1

