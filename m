Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6F64BB13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiLMRbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiLMRai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705CC23170
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpUw5Y2TLDVtTXCSF2V9Ww7xiFXDGmNlxyIGTd/fNF8=;
        b=gVaJ6cdtj8d9Q9J0BAwIHzjSRcHrhV1QV42UfL3dM+RdSu0JqXlckgWOO1tUHSSBeHXtRi
        tSGt/yIFAzpQEMkPnF0FXblXiTsSWld2unXlYEUt9Y63gJIk51Z+0HNjupZANPLHR1PtX/
        FSqkFWc+dYNXCfoJ3292OyNGABdztVk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-EPT1BlQxOtqmflzdfRbwVQ-1; Tue, 13 Dec 2022 12:29:43 -0500
X-MC-Unique: EPT1BlQxOtqmflzdfRbwVQ-1
Received: by mail-ej1-f70.google.com with SMTP id ga21-20020a1709070c1500b007c171be7cd7so4134223ejc.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpUw5Y2TLDVtTXCSF2V9Ww7xiFXDGmNlxyIGTd/fNF8=;
        b=YvcEJZRVLB2Vv72zQzFc0zCmaO8kXet3ol5w+BsB/sm9H00InZB7p+GFeIVqA0bWyU
         /wvCvCQW7gSMOp6UtMIp7L8+Ajuzws/7SeaGDEcCHU8Sns6oJ6Tdg3OQYTbuvRvkDx6W
         iyZrOvfWns25HNOv+vi9haPpdDwyym60rVklwe4VYZZDwNadQG0st2FI38ry++nuFXfF
         6Z5BlvQZQMmMnCc9KP1tdIcDooH3H/Xx5ElyCceSgWZ+xlRuHkGV72gM2ekJKPwjuTbF
         wSA7gUthl9eo+SM5lF35k5Bw5kbqBVb6JRsha5hlYMzw0vMyvoeUc0uXZxk+8d31bvBo
         5SSg==
X-Gm-Message-State: ANoB5pmpB6XKiPmTUT2knKDLuhiaNa64jGflUmLq8+4gUuCf8oXcxoY1
        OVokBvX4ZxJ8wmSr0vm4u0Cm88n4ILjdq++x+ToPvvlv+LBfp59qNYY0nTg9fhoZSjrrswiDlPN
        g4IvlA582tjyjAvFVuidekaOu
X-Received: by 2002:aa7:d814:0:b0:46f:d952:a0c with SMTP id v20-20020aa7d814000000b0046fd9520a0cmr8877986edq.20.1670952582278;
        Tue, 13 Dec 2022 09:29:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7PlCjp9cbbaShxk8BtTSop2M36G/FuymBo9yWHBHKi3JC/lYLxCB5Njfs0kRqD07nB5KwLEQ==
X-Received: by 2002:aa7:d814:0:b0:46f:d952:a0c with SMTP id v20-20020aa7d814000000b0046fd9520a0cmr8877979edq.20.1670952582152;
        Tue, 13 Dec 2022 09:29:42 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:41 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 04/11] xfs: add fs-verity ro-compat flag
Date:   Tue, 13 Dec 2022 18:29:28 +0100
Message-Id: <20221213172935.680971-5-aalbersh@redhat.com>
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

To mark inodes sealed with fs-verity the new XFS_DIFLAG2_VERITY flag
will be added in further patch. This requires ro-compat flag to let
older kernels know that fs with fs-verity can not be modified.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_format.h | 10 ++++++----
 fs/xfs/libxfs/xfs_sb.c     |  2 ++
 fs/xfs/xfs_mount.h         |  2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index f413819b2a8aa..2b76e646e6f14 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,11 +353,13 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
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
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index a59bf09495b1d..5c975879f5664 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -161,6 +161,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 8aca2cc173ac1..3da28271011d1 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -279,6 +279,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_VERITY		(1ULL << 27)	/* fs-verity */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -342,6 +343,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(verity, VERITY)
 
 /*
  * Mount features
-- 
2.31.1

