Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570884D645F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348632AbiCKPPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345301AbiCKPPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:15:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D4FABCE;
        Fri, 11 Mar 2022 07:14:11 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n15so7927897plh.2;
        Fri, 11 Mar 2022 07:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qILzzZN75wb/+HhDdXfmwqE1bkEAAPAtDiWzOp2CaE=;
        b=HpUsvML7LuYvRnyLiEdnGhzYvfoIHk2y1pfsJz4MHZnWqJ/YL9QWz5ykrfflxQbBMz
         LKtVgAUnLGiy3m0ceNrv1VcAr8+6ugEjvJigvHPp/1FfvIProTOWji9qaqGXzDevDBHG
         phGrA6fS8Fa69019jjPi/NR/f9xR1XtUrfstJxRxeMGg09Va5EQyZbsytlwlr4qZJmj7
         W5mPXfXFFk0ix1441/Mn74sODt52mPBkyPDyFeYv7Z9LYodiTPbOd3fDJ3Q4JzL1+haT
         xwW0FMkWm9e7NLe29VYVxP4sKVkFTccrKujF7AidtIQg44S8pK7oMfZFqgGhdCWYd1V3
         ic7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qILzzZN75wb/+HhDdXfmwqE1bkEAAPAtDiWzOp2CaE=;
        b=LPy+MN+klmSQ1A4ZoBuwPvrAO/wpJh0i5xkyVn0RskivF5t3sQQKVCklPURzDkXs5x
         mb01rMMYtLaZDIoP8XCcBJfX60kB/2VBAS9OVeff1CQxsbHkx+l1JT5ZA7qcXMkhgCVI
         r/UJJ54D0rqXjlUbCt0unq/56bOtW70GXPV/veYWQk5J3Q5D0jutcFfNMrMXgMr5fQzI
         E1PWCEfN5dgNW2TC43vCqHwztmu1kxubHREcraMIpjzdJ2vPRapAp8jlWV2mTUfJHq00
         aWTmjNloQvEb0l5E22lusNogHOM5dqAB7xL/jL/rkOMBpPvCBvvnTfaAbtJSsZEyCybe
         XNoQ==
X-Gm-Message-State: AOAM533t7tiekG/EM9lXdqpVJ7xsBb8/YjK26mxVbWx6OV8VKAgGoFuw
        sYVbkX+Ah51/H73pGsT6Jg40R6ASZIG/4Ff6
X-Google-Smtp-Source: ABdhPJwGQ0EP6Yj2FK8898SgnCrqYphdvuxmlBZ9ZYQ73kIJ65hRHgYCf0eot1PvlAsN9z9YZNrugw==
X-Received: by 2002:a17:90b:3e88:b0:1bf:3a96:54c1 with SMTP id rj8-20020a17090b3e8800b001bf3a9654c1mr11214716pjb.244.1647011650641;
        Fri, 11 Mar 2022 07:14:10 -0800 (PST)
Received: from localhost.localdomain ([119.3.102.56])
        by smtp.gmail.com with ESMTPSA id j7-20020a637a47000000b003803fbcc005sm8888025pgn.59.2022.03.11.07.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:14:09 -0800 (PST)
From:   Bang Li <libang.linuxer@gmail.com>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bang Li <libang.linuxer@gmail.com>
Subject: [PATCH] fsnotify: remove redundant parameter judgment
Date:   Fri, 11 Mar 2022 23:12:40 +0800
Message-Id: <20220311151240.62045-1-libang.linuxer@gmail.com>
X-Mailer: git-send-email 2.25.1
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

iput() has already judged the incoming parameter, so there is no need to
repeat the judgment here.

Signed-off-by: Bang Li <libang.linuxer@gmail.com>
---
 fs/notify/fsnotify.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 494f653efbc6..70a8516b78bc 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -70,8 +70,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
-		if (iput_inode)
-			iput(iput_inode);
+		iput(iput_inode);
 
 		/* for each watch, send FS_UNMOUNT and then remove it */
 		fsnotify_inode(inode, FS_UNMOUNT);
@@ -85,8 +84,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 	}
 	spin_unlock(&sb->s_inode_list_lock);
 
-	if (iput_inode)
-		iput(iput_inode);
+	iput(iput_inode);
 }
 
 void fsnotify_sb_delete(struct super_block *sb)
-- 
2.25.1

