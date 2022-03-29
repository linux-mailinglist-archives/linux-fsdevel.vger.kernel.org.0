Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CEC4EA8CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiC2HvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiC2HvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088851E5A52
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r13so23495326wrr.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqqNHpEqCAgeMCR+4JoMRfMN5/eBIgAPSl5kfRYHVCc=;
        b=BL/xQBAIfzSYsJpUPXp8bV41ULGl7Atg3+RW0w7JlyreFgLY9AKbdv/Jy9/DDUNK4x
         Yu1PPWtxWSLNFreluXvj/+94tiBZQUCR0EyU72/JoAMa1GVST8V9cO36Kb2yQjIgHvS8
         Me3fwdn2u1j2Ne3ONt07UXiPFvnzgBUJ7AufZplP+76tyHyCLEism6F49v1+RS8lzkkb
         UmtUWwWEWeGD+GcO696sKzZjKIDhnygJcr/YL72+ejpiuouuEZF+3/z0zFHX1wvT2orx
         nZ6oEzNZkm/C8xR7jdb4Qngg4ZYwk8JOxdVcDSjsE7vC70k3ZnX4uTXn8FXMcQvrgckU
         lHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqqNHpEqCAgeMCR+4JoMRfMN5/eBIgAPSl5kfRYHVCc=;
        b=FD5FifDSmnrtgl6B94VznUSkM82MOFU8HZk6i/NIfwLEPGkJOm4mzRKedbtZCwF1Kd
         qlODlDJ15Cwke+2gStsJOGMYOt+wDxo6aQCKfBn9nEwckO386xVgA4iTuJgQbCF9+Uc3
         RiRShioBMJTIBIqVtyp+p2ZJNxE1BcknbngskhFiwk7HiXr6AaMqEFGSq41Xmb3Mj6Rp
         hgRqXut9iBrJiaSnFDjsq/LHNOBTssHyfs3AKgP5gGEmgAfwcMfRgwXHeaIRFujBA0RE
         OcI1EtxDuPiF/YZM4ttrLbRotlYaFZ5HTN9OQaLjcLgfgNuArMSQzsMnKNUSABzJVmr2
         012g==
X-Gm-Message-State: AOAM531atoiHRLjWY39z4xOs3fouRIQeCHNxMOY4ut9kXPREop1qgWWR
        dg82JbxsHfVimwftxz1Fo5nulG0lqjk=
X-Google-Smtp-Source: ABdhPJzIeNhMC1s4LY6wtp9H9TNIDx9kRTxsS+UWJQPuVeGcVorPWbBt/7sak993ikNKMiWbY/RUJQ==
X-Received: by 2002:adf:90e9:0:b0:204:2ee:7d5 with SMTP id i96-20020adf90e9000000b0020402ee07d5mr29036409wri.536.1648540159556;
        Tue, 29 Mar 2022 00:49:19 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:19 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/16] inotify: use fsnotify group lock helpers
Date:   Tue, 29 Mar 2022 10:48:55 +0300
Message-Id: <20220329074904.2980320-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
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

inotify inode marks pin the inode so there is no need to use the nofs
lock variants.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 6fc0f598a7aa..060621faa762 100644
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
2.25.1

