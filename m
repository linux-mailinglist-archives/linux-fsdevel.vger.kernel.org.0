Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6520C50B6CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447288AbiDVMIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447333AbiDVMHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FEA56C03
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bv19so15948775ejb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qaj4lrOKfv+rBpmhnvH/n5jof4lc8B6eOVAGxEORm8U=;
        b=aIcLOInu94L3bMt3xqWl+79d1lVTT+myNMHCuwyZ8JTreNiVr6FLKPH0KGuGXQiXqU
         G5VFxj2RdHjNXiCAHU7GOLAoUzXl6/sX4jKotRCyaYW4sHh+jEtVzT11Lr7TJqFWmMB4
         hsBbZRLuavDi78zlpFd/v+eVC6ynA09wmx5n9VzVfACcl3RCLR6wna8DT1cOt9b1JHLt
         lrQ6J2r4OM3e80xFFPmiiEoDhha9gfgQVwyv82Q91p5xKaFOz5NkHpkkq48akW4lLZGK
         k9zIBe54j7Q1DFNX0Iz2x9npFKdBhJGVc9tjct35yEclL3uEqeOUMfLB/IADSMqesQm7
         4sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qaj4lrOKfv+rBpmhnvH/n5jof4lc8B6eOVAGxEORm8U=;
        b=4MlXFtm9e/5EdxUngnnOr2lkvgT2jXG9qX30f4dvhxBHJxh+Ufz5r8m1hGzhchXeSG
         Lx2WHtOkj9DiKT8sQnlmQBwp64Kw5FCksisuS0CUlq2Yoo8RmPDpFtiR+bb5kIgdlUg/
         /BS6pmmDmbS3YC/qzu48Kz130wg8SQgGvgh/lpFU7MOz19MgHEV2s2ynMWctibB27JuQ
         NtjnT2fmyG6Hw1Q4W5Uqyt5sCLxyQQYuNLSbnByy95Dm1hlkpQVzGn3xYUINQAb7EpAB
         dwwftFaEDbfpPOkLa3B8U6N5lqwX+dNf7rFScE2/NV/TScnPs5vYn7iEkMKvTNAu3LE4
         PItQ==
X-Gm-Message-State: AOAM533IOZB5EXw95aYsDSnG2xO5pLASMq/SMebQ0sKeZUUArgFzobru
        nsLeTPdXXh0XjI3OCvCdUBg=
X-Google-Smtp-Source: ABdhPJzV5O27bf9S35rRY0IiTH8CqRnYwCSiV2X2wp+lCCRM662Jivdwysp9xNATZ03pps/0b0SDyw==
X-Received: by 2002:a17:906:5d08:b0:6da:b4ea:937 with SMTP id g8-20020a1709065d0800b006dab4ea0937mr3953844ejt.446.1650629024987;
        Fri, 22 Apr 2022 05:03:44 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:44 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 07/16] inotify: use fsnotify group lock helpers
Date:   Fri, 22 Apr 2022 15:03:18 +0300
Message-Id: <20220422120327.3459282-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 146890ecd93a..ed42a189faa2 100644
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

