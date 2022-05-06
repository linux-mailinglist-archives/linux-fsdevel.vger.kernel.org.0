Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73251CEEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 04:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388079AbiEFBuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 21:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388065AbiEFBuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 21:50:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25861623
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 18:46:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b24so7116307edu.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 May 2022 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6AaRSgDENnrIZxhDeoBGQNYZWanEL+17Ds7WsL0GLM=;
        b=cdFp2hXj6yeR6syCPPBluKU24f6A6Fh/lEiCzmkeHJB1qWNy3CsNKlNUOcFbjRgNiT
         C+iAzUkXoZ0pYp2zpwm9NKJLOJKl7UkKWT2wCdFFDR2Mv6rZ6wGcuMSnh0OFYTcC934w
         IBAjS6wfck8Li/YXc/yogBeSrGkOhMd/tj2FiMNpo8s6C6rFtBC5+OuIiOpqVSsL7EO2
         MFwghkgJBV300FaTkSnRl7l4e9V1JC+3oAoeruMFCBF/EUiLKdTjVrwl8cXF2AvXE94E
         vm2THhUQa2ZyMApjhmkALc2sBn6Wq3KjAVUMFkGWfruI/AJfYUawIcQWaU+xsxccmjnV
         G2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6AaRSgDENnrIZxhDeoBGQNYZWanEL+17Ds7WsL0GLM=;
        b=BwZcksxw5xTzOhr1OncTgUb4O+Z0XmR48AMVNVU1r98wHgSYl1eYRiil/ogQbaE8F6
         fo9g3j8yxeW3aPk50lawAcws8aLjvX1micfnL4sDB14xwQsc4iGMSR0NFKwqmgQ8YtaX
         22C4azLxEeHImxPcR/C3oEd1v4eJVJ8brHq3YDyK6ZZRV44L7WPq1JYtjMA5YLYQekph
         EnqYDcsGzkFTbh85QnXek4en7+ZDa5c6IU6GuSo5x1rTPtRP7HWSHtsKXKJt37my4X1g
         NGjcFup9WkT86dzjAb1oZyRLho10q+DT278X9w3ddZT8X0tcyY1/bwWLr4yGdAxvix8u
         U9Ig==
X-Gm-Message-State: AOAM530D56cKdGJpD1tsK9nhYbg6cRd0Fiw829qYpFLmZ5eESFtHy2c2
        o0/sHrEoBRS5pCz4mBlgMBf1tXmxOQWaBA==
X-Google-Smtp-Source: ABdhPJwxd65u1uH/AfKEVEx1q1YyJCqmg/Aiz9AfgGtXLInSDbwdb/pBAwCJfStv7uZdVcmMbFyO8w==
X-Received: by 2002:a05:6402:370c:b0:425:a9c4:88c4 with SMTP id ek12-20020a056402370c00b00425a9c488c4mr1099400edb.190.1651801593727;
        Thu, 05 May 2022 18:46:33 -0700 (PDT)
Received: from localhost.localdomain ([147.161.9.83])
        by smtp.gmail.com with ESMTPSA id j19-20020aa7c0d3000000b004275cef32efsm1565014edp.6.2022.05.05.18.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 18:46:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: do not allow setting FAN_RENAME on non-dir
Date:   Fri,  6 May 2022 04:46:26 +0300
Message-Id: <20220506014626.191619-1-amir73il@gmail.com>
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

The desired sematics of this action are not clear, so for now deny
this action.  We may relax it when we decide on the semantics and
implement them.

Fixes: 8cc3b1ccd930 ("fanotify: wire up FAN_RENAME event")
Link: https://lore.kernel.org/linux-fsdevel/20220505133057.zm5t6vumc4xdcnsg@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index edad67d674dc..ae0c27fac651 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1695,6 +1695,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	else
 		mnt = path.mnt;
 
+	/* FAN_RENAME is not allowed on non-dir (for now) */
+	ret = -EINVAL;
+	if (inode && (mask & FAN_RENAME) && !S_ISDIR(inode->i_mode))
+		goto path_put_and_out;
+
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
 	if (mnt || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
-- 
2.25.1

