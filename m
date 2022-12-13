Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC964BB0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbiLMRbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiLMRaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E183023381
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0lyKZLytTPe2tgsoK8ec8CNBM0ybARfQleJk6OVIIM=;
        b=FTWI/44Yv8CWHo51W0omCQAVQQwlYEzZbbQFYXYdumFcXwA0YsDJOW0ZdkPswuwYtm/WOQ
        i4k/jw1/mvwo/2BJAruohVo6bgxI8PJkeuqvqzejVz369GR16Xo6L2HN6h9C/lT7K8/L9h
        X7L3mD5wUQHia2q1+LKMTSe3vJZA9EU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-IoF2YPiuObyTZou2fvpgZw-1; Tue, 13 Dec 2022 12:29:47 -0500
X-MC-Unique: IoF2YPiuObyTZou2fvpgZw-1
Received: by mail-ej1-f69.google.com with SMTP id nb4-20020a1709071c8400b007c18ba778e9so1881041ejc.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0lyKZLytTPe2tgsoK8ec8CNBM0ybARfQleJk6OVIIM=;
        b=3kJeTSgla9WoOQsfqhYDZkDvvlRtDQRqRIrwE3IcKpjeWCPLUVTYPxgy42fTD8mR/c
         Zh7EmoOvCoD2l1I+GnlG/F3Psw1hw1HVI1s4nv+Ih4Y3xgaDFTnPyGWGwvAXNIJ/TYdF
         xpT0Zzi7J9VU+UhQDRVMlrg/8WF54JOQDOA8ljQG78yCLiV/pOv3PIspTWD5nsQI4SPM
         ndS9LCzcwLaDtjCZfrpbrvn7yM2ciIfDfIdA+tf4sRTV1CfHMG6OqkO8aTxPBFqHbfaA
         vEi/EgUPES9HTsL+UU0ktMfId35HCRG+ET9UX+UZ3qwIAWYw1QptPWGNjll9WfbRtG/0
         jhlQ==
X-Gm-Message-State: ANoB5pny2+h2eTb2O0/XmJFtP09AZ1tGHrjPYqHOZ6NqLO+fNDiMOB79
        uUxPPVHGVPdYKPz1qPESNz6JusvoAUadr0iXdr10pitdKp7FoRApAc15h5yMZeMqZsfUtDYrETL
        NBwlARpRBg9+PUI4afWlx9ckL
X-Received: by 2002:a05:6402:5389:b0:461:fc07:b9a7 with SMTP id ew9-20020a056402538900b00461fc07b9a7mr22768384edb.2.1670952586865;
        Tue, 13 Dec 2022 09:29:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4MMVU2ZSTGshSUNs1Im4i1IYGnQpezMKu2iDzHR1GIoaE/NP6NezsSzt33Apg0fNAeBJPfMA==
X-Received: by 2002:a05:6402:5389:b0:461:fc07:b9a7 with SMTP id ew9-20020a056402538900b00461fc07b9a7mr22768369edb.2.1670952586679;
        Tue, 13 Dec 2022 09:29:46 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:46 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 08/11] xfs: don't enable large folios on fs-verity sealed inode
Date:   Tue, 13 Dec 2022 18:29:32 +0100
Message-Id: <20221213172935.680971-9-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs-verity doesn't work with large folios. Don't enable large folios
on those inode which are already sealed with fs-verity (indicated by
diflag).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_iops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index b229d25c1c3d6..a4c8db588690e 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1294,7 +1294,12 @@ xfs_setup_inode(
 	gfp_mask = mapping_gfp_mask(inode->i_mapping);
 	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));
 
-	mapping_set_large_folios(inode->i_mapping);
+	/*
+	 * As fs-verity doesn't support folios so far, we won't enable them on
+	 * sealed inodes
+	 */
+	if (!IS_VERITY(inode))
+		mapping_set_large_folios(inode->i_mapping);
 
 	/*
 	 * If there is no attribute fork no ACL can exist on this inode,
-- 
2.31.1

