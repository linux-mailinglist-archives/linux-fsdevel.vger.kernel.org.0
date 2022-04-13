Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18D4FF310
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiDMJNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiDMJMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADB205EF
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r7so654058wmq.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZfDOJDN+f6HlsMcD0ehVtQsF1UIr7uk2DkRuU+2Oys=;
        b=oAymXG22XnMlEQtmUOKZrg6+rPND9YkUF/KliX5DA+O8XsoeeLI0rXgPt7twN7A9RR
         eGDvEwpji2nnBUlBwpqBvObPuPrMJY+3pVNWo87ECK4aPzfhwJtfjvrT5eq2oSzljsls
         0vKcpthR/onNQEGY2R+KNHY7qk8a0LQGNfqoqtIvlwsYIUrA8UMjo/qJLwKlCA7VQEFq
         FC4GeYbjiazct2sKHukmHL3v6dO9YCaRDGv8raRVBPnP6CtWsmdbU8qUb0o1Oaec5/fO
         vx3fdbJY0szCTibRcUOSOun/RGaNnQd7nZPygp504i6kWwYNvbRE8xCtLmb0s25rlMHx
         hPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZfDOJDN+f6HlsMcD0ehVtQsF1UIr7uk2DkRuU+2Oys=;
        b=TBrJV9qnLWe6yhqymBcI2NiozLGyErk4K4IRq3H2dZdIm6y2Ib8OeVZqHfA/8WUftX
         ut+EsUeym1w8u8vrWkV3LTx21QO3paiW+PPxeUaLYGflOpzx3DH4Zwd7qb9kI1pX7Ig3
         IlVN5FmyTqcW4zwmhph+5zq5VfOte9VGKpHd2PWefWJWyCTXW141hJg771zijCbfBLwA
         qQrEeRZ4At+o5KKe+LZAI34MMEwJ7pJYLyk3isf3BYam5JPJbLwwaSf+ilWGDc1bVhed
         1MAtBhkKdS/ozSzroBMWn4mALghZhgf9Hd4/Po/WO5avN2RJdYbOEjPFVLgAXY/fgeKr
         iiow==
X-Gm-Message-State: AOAM530sJw5H1clB3NtF31XVLhOWOtKu/bPwSAP1NlKYFIQTexfxhbGN
        /MBv4SSUP/PZ7yVp09OTiFw=
X-Google-Smtp-Source: ABdhPJysvdoiWyRERFbG9dmJfRGwWwYo8ZHJ+Lu6VZ7X7cC2XAfLpZ9jSzuwEb3JLksvijLUdzrH5Q==
X-Received: by 2002:a05:600c:2113:b0:38e:bc71:2b0 with SMTP id u19-20020a05600c211300b0038ebc7102b0mr7539880wml.153.1649840994059;
        Wed, 13 Apr 2022 02:09:54 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:53 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 12/16] fanotify: create helper fanotify_mark_user_flags()
Date:   Wed, 13 Apr 2022 12:09:31 +0300
Message-Id: <20220413090935.3127107-13-amir73il@gmail.com>
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

To translate from fsnotify mark flags to user visible flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h | 10 ++++++++++
 fs/notify/fdinfo.c            |  6 ++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a3d5b751cac5..87142bc0131a 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -490,3 +490,13 @@ static inline unsigned int fanotify_event_hash_bucket(
 {
 	return event->hash & FANOTIFY_HTABLE_MASK;
 }
+
+static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
+{
+	unsigned int mflags = 0;
+
+	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
+		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
+
+	return mflags;
+}
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 1f34c5c29fdb..59fb40abe33d 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -14,6 +14,7 @@
 #include <linux/exportfs.h>
 
 #include "inotify/inotify.h"
+#include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
 
@@ -103,12 +104,9 @@ void inotify_show_fdinfo(struct seq_file *m, struct file *f)
 
 static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 {
-	unsigned int mflags = 0;
+	unsigned int mflags = fanotify_mark_user_flags(mark);
 	struct inode *inode;
 
-	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
-		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
-
 	if (mark->connector->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = igrab(fsnotify_conn_inode(mark->connector));
 		if (!inode)
-- 
2.35.1

