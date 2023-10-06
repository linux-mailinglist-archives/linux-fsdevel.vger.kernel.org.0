Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5C7BBF42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjJFSzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjJFSyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86EB119
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rlF0oL9W0zNtBhbjMTbk37IJ/kLdlHiXudCvThRqlI=;
        b=MNwyH6abjoDB+TRryLeTjOfr8coV4o3x5b0NP3dTtAlFJSTObw8ldRQYgLi3f31QjTtjef
        GQwPOB16gDF8nrJzJUkq7NQ8/bQ6f5R5BhoPJufFqsccp9Jts8roWcEfasYzqki8mtTb8f
        emSGM7eCO+Fq75FsUYvCLb5dVLptjAw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-XMxLhM3NMLGOpkP6aYprEw-1; Fri, 06 Oct 2023 14:52:45 -0400
X-MC-Unique: XMxLhM3NMLGOpkP6aYprEw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b98bbf130cso207033866b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618364; x=1697223164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rlF0oL9W0zNtBhbjMTbk37IJ/kLdlHiXudCvThRqlI=;
        b=dX336QX78Z312DshCb7V6ek43ctYV6R+r7rmsVWKSeAy0043hKk+PptAn+L5uMrKLc
         HV+M9MifZcukvBgkJQ+llpNJZfptmxT2xEftVu4sd7JxNKZH1NO18CDEesMa8P1HOQY6
         MB1c8fSm+jsUEX3NtM2g9K3dbQsyEiSbE6395wyDa/TirA3N3Z+A9J9uRgAxBsb8j6+m
         Rxjn+21Jpt+nArhh2rv2cfXaiJvX+e3zjOyELTyKty7I3SVjjLFaIB6gHKEyYp2165qr
         hxWU1EwE/2Q6BKCvkoCuswgdgtcIU3y0gdMGCXw4PBxuZ1J/CkhUIKH8URHDXlIXR0Ba
         b+SQ==
X-Gm-Message-State: AOJu0Yw+GYuSHgmAQDPnwO/dPNfk+08+uvnxMFGIz/v7+8HyZXiHwAdr
        SOcLSp7v0m3GiUFTmIbMoxOxW9FNtwy8HJRU1qYssYOQdCtVQNS2hw52J42+Yu6CdmzpZI7B7BR
        8fZMLELrqPCjfmDf8MY3TxSl1
X-Received: by 2002:a17:906:3116:b0:9a9:e4ba:2da7 with SMTP id 22-20020a170906311600b009a9e4ba2da7mr8028682ejx.49.1696618364685;
        Fri, 06 Oct 2023 11:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb5yDWscYNSrW67kJ5zHPToh4J20qlMVNuAtELJzCJW/KwyTT1ZP+ogCVKItFg1sfFvDb1pA==
X-Received: by 2002:a17:906:3116:b0:9a9:e4ba:2da7 with SMTP id 22-20020a170906311600b009a9e4ba2da7mr8028667ejx.49.1696618364456;
        Fri, 06 Oct 2023 11:52:44 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:44 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 28/28] xfs: enable ro-compat fs-verity flag
Date:   Fri,  6 Oct 2023 20:49:22 +0200
Message-Id: <20231006184922.252188-29-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
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

Finalize fs-verity integration in XFS by making kernel fs-verity
aware with ro-compat flag.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_format.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index ccb2ae5c2c93..a21612319765 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -355,10 +355,11 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
 #define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
-		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
-		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
-		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		(XFS_SB_FEAT_RO_COMPAT_FINOBT  | \
+		 XFS_SB_FEAT_RO_COMPAT_RMAPBT  | \
+		 XFS_SB_FEAT_RO_COMPAT_REFLINK | \
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT| \
+		 XFS_SB_FEAT_RO_COMPAT_VERITY)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
-- 
2.40.1

