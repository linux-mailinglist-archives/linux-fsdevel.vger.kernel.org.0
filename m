Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9607043FB92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 13:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhJ2LnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 07:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhJ2LnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:43:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0358FC061714
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so15757737wrg.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JiVsObHOj86M/JRQXD1Lj2K+Z/yh5CnYWlRs5cfCeEM=;
        b=jK3y+ZTIdMGaUqjiHib4BCiPOEcRvebSCTLyyd85Kd927HGgi/Muj2C7qUKNR2321j
         o5VlIZG7EUbC1D5t5UrVzap6nJItVklfVxvRXBwilrwax0nW/jVRvDMpO1PmSDRO2vBd
         caAfw8hciGHGWQIfn3TuLLlh97+g4tgBdQijCRxGvOJAxtzEqKjIoGLCJYvRP6ybBjNJ
         VX+CEy1+LfkqA0EvC76lRfp+DgVX8HXxdEwj82EmibBpNXuKWeG4hmvWdGXiMQCfU05M
         Y61A1zcWk6eeig7h/eO8nzUrvRygJmYssBKmf9vSY4sIjsvrM5+hMPo8XH+F7vy9J6yt
         TgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JiVsObHOj86M/JRQXD1Lj2K+Z/yh5CnYWlRs5cfCeEM=;
        b=mz3K4Mt9wI5HaBQtZLEVIdTbmqloI4+Xg/mU2RtCQGCYGdAZ6gFA+7I0Kfr0w4UZ8C
         G9Jpotlg4xIOQxzwsvie5+EAzaYSBsPjn+EvdHt1qxojkevyXdGSUNLCU41BBN7gjWLu
         2SYrCjCothwVr18nKjo6JtrkGJ11xa/fD9ERJ/lOpSSPcNkk/3d2zWe36ipPxIdLLpe8
         XDlHNLnliexvpFqkDosDpkefnaZYcR2YgEb8af0frXL08AeYMsa5BgFH3zyD5UkIOLZu
         mJIiFZf4fanK9Atw7T1W8CbkGzY5v/mI8bwJQeEbSVYaVA7vrIDvh8bE7h4qC3ebV4F3
         3bcA==
X-Gm-Message-State: AOAM530BKL72e10ayAAfpCnFZyfKtc+v7x8JKAHli6vWRZEbvT/Hors0
        ejRfTqill244ZyJ/lelXj+5UI1n8uzM=
X-Google-Smtp-Source: ABdhPJxaUxTaA3fl8KHpp9TmhQClCvPYHEPkYuAKkVM4ZIfh/5XHR04vorPGGeRatoHR21WUERhHTQ==
X-Received: by 2002:adf:fb04:: with SMTP id c4mr13342099wrr.39.1635507639651;
        Fri, 29 Oct 2021 04:40:39 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id t3sm8178643wma.38.2021.10.29.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:40:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] fanotify: enable the FAN_REPORT_TARGET_FID flag
Date:   Fri, 29 Oct 2021 14:40:28 +0300
Message-Id: <20211029114028.569755-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029114028.569755-1-amir73il@gmail.com>
References: <20211029114028.569755-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That will result in reporting of self inode fid in dirent events
and destination dir+name in MOVED_FROM event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 include/linux/fanotify.h           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d6420e10740d..b62218d4aea2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1700,7 +1700,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 616af2ea20f3..25c1894510a0 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,7 +25,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 
 #define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FANOTIFY_PERM_CLASSES)
 
-#define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
+#define FANOTIFY_FID_BITS	(FAN_REPORT_ALL_FIDS | FAN_REPORT_NAME)
 
 #define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
 
-- 
2.33.1

