Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8441E4FF30D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiDMJMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiDMJMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDBA1D0E1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q8so421355wmc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MySchIr/iy1RGi+DahX0CMIibknFFN8LqIdUOKRVN4=;
        b=B0ksQiyq6SuxfMHz2oAXPo24IoCbEBOVB18PwFxD8ImgJlr9LtYrhXaHjK0NI5EbD4
         O+2P3az++k1555cZi1PTjV/CsVrO4rh29iHvbfBpp02lBOOMZfSISCaAP2resy6dRkNi
         B776vP0TbqBks0koqX7hfgoRnq6JmIIrS8h4P3u79gaBASbYgg9/WO5qZoecYu9xHd14
         JfJAP/+6aLKFgihyJN7kuKMzRdGhtXWp82vJKgyFmcrQsip6KqYD+yQ0CWiykqC0IYIN
         wV90Mvj/t5Da2Hvd9U6bZ9d6kxfNA6UCap1VuBs4iyq5i3fLFMLRhxs5zrzNfl/oJyP/
         rEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MySchIr/iy1RGi+DahX0CMIibknFFN8LqIdUOKRVN4=;
        b=1KTjgvXz7O8UGJjb7wyaKhM8XLZY0dNQBG9TTLSGuIPz5vZrXBgJ0qWC+9W4zlWS/B
         kpK4MmD22FplCdBv1Ie0RUwnuxJHHahwlPV8CPLyl7GOClDTaBJZ12kJnMSuB0kX2eTi
         YJQRjwoVJ3ZD2DP0caQR4ybQjmEXVjqnGAZ7KXl123LE3JmzrbibAPRWDD2GtIFxgTBU
         AWSuBdmR3i1SBQztGAeACo+AePwrlcqPyZYU1JNBw6Ep+TfPprqud2E4pAyxxR+dy92q
         m4OVSOJUO8Nl+8dSEWaXIz+T4Ld/pDJF5FQSu3PulRnuPKSSIvY0TPQjVyqhVnwJmYYL
         291Q==
X-Gm-Message-State: AOAM532bW1vCl9QVDmkOuY49haBOwgkEWtlIvLTdhYC+oL3ki3v9Ndav
        BfU4ST/oGVcg+L5/qOcB7CVVMVQBdvI=
X-Google-Smtp-Source: ABdhPJxUUMASvTUWq1oDDqh9lJwUkSPGp8P9+NxwLCP+AUNXc+wglKBntdTGHebm7yQigHX5+zE0gw==
X-Received: by 2002:a05:600c:1509:b0:38e:d707:90cb with SMTP id b9-20020a05600c150900b0038ed70790cbmr1611618wmg.120.1649840987744;
        Wed, 13 Apr 2022 02:09:47 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:47 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 07/16] inotify: use fsnotify group lock helpers
Date:   Wed, 13 Apr 2022 12:09:26 +0300
Message-Id: <20220413090935.3127107-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inotify inode marks pin the inode so there is no need to set the
FSNOTIFY_GROUP_NOFS flag.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 65ff637cb4a3..5cdb2f74bca6 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -640,13 +640,13 @@ static int inotify_update_watch(struct fsnotify_group *group, struct inode *inod
 {
 	int ret = 0;
 
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	/* try to update and existing watch with the new arg */
 	ret = inotify_update_existing_watch(group, inode, arg);
 	/* no mark present, try to add a new one */
 	if (ret == -ENOENT)
 		ret = inotify_new_watch(group, inode, arg);
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 
 	return ret;
 }
-- 
2.35.1

