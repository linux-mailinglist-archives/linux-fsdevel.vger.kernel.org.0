Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B14FF30A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiDMJNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiDMJMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0AD27FC3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so3495104wmb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uA5AZngPQPmtnBFYJMCWANv4BTmdB0JIX9A66fXeu0=;
        b=GDj+Bf1JsyHw41RiOfHFyzOPLRqshmkSu2S8QA/QQWhzLUfgziyCZUrW3Qfi+KF7Hj
         OuyrYE0NAVeCznK/DRZklEAqK4vlP2Q86k+8pr5g7EgCQ3hywMSGBykBfj5xD0xpRO6e
         QzyHyPxDat8wOjg+74tD+xrci1E9EniqxU0wAuN8KuCmFE5n3h+RaEbyKgpu6GF6HrYU
         vChgtj/nKlWi2zGq2I20gHw2SqSrLisXpjBE/NY3FsKFIMGa1iL/uYZtO1P7o40AoJ5f
         q3noTIVxDmnkyeFvnJLvI2JJwC13bkfWNhROhigSfTvV6bV9NDmCGMmMlKLsWGTbX7BQ
         jCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uA5AZngPQPmtnBFYJMCWANv4BTmdB0JIX9A66fXeu0=;
        b=IYc6XjAn+GVlTFuNI54QLFRFzB3JBXniRZH6UoZsI4IRW3u2sHopoScea/xouS0qXP
         KW79GekX0Plq++fNyQsy7pxV8p7zW4AjZIPjlNs4qFMhC8liDVf43TKYBf7v5gwoyjIT
         A1n0fvoweUc8YrLQTwDrv5KJ3g0jhN7H87o0QsYpJPGpDtC2u5I/ciSyI+NXWBnRsKg+
         xJEizlObW9C3VnV2ddfbIWCSUYCAIDq6fCuzN5N3sYlHYylmRkzRZ7IXWUYBiGvqNr8b
         xY2n3WYCafP4LAfo8VQnvbbXh/xHdX0VYP5Q9Tr9jvzEUhO0al1eP2NTPyw3AhzeQYPI
         ei8g==
X-Gm-Message-State: AOAM5305JTF6B3t0vgHApBBLL+W/K12n7GRPb714/HZGvKkxmHXHfDPJ
        a2N9QLfMuePa7QVfCfBj+FOe6ZTFlDM=
X-Google-Smtp-Source: ABdhPJy7W0/86CsrHttU8XPHzC82AJVaPW2oxVD7TW3329XDSifuv3w2kfnc//ww8pwhAuwr8xJ7bg==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr7577973wmk.118.1649840995400;
        Wed, 13 Apr 2022 02:09:55 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:54 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/16] fanotify: factor out helper fanotify_mark_update_flags()
Date:   Wed, 13 Apr 2022 12:09:32 +0300
Message-Id: <20220413090935.3127107-14-amir73il@gmail.com>
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

Handle FAN_MARK_IGNORED_SURV_MODIFY flag change in a helper that
is called after updating the mark mask.

Move recalc of object mask inside fanotify_mark_add_to_mask() which
makes the code a bit simpler to follow.

Add also helper to translate fsnotify mark flags to user visible
fanotify mark flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 41 ++++++++++++++++--------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index bf72856da42e..d8d44a5b37e3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1081,42 +1081,48 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 				    flags, umask);
 }
 
-static void fanotify_mark_add_ignored_mask(struct fsnotify_mark *fsn_mark,
-					   __u32 mask, unsigned int flags,
-					   __u32 *removed)
+static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
+				      unsigned int flags, bool *recalc)
 {
-	fsn_mark->ignored_mask |= mask;
-
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
 	 * the removal of the FS_MODIFY bit in calculated mask if it was set
 	 * because of an ignored mask that is now going to survive FS_MODIFY.
 	 */
 	if ((flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	    (flags & FAN_MARK_IGNORED_MASK) &&
 	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
 		if (!(fsn_mark->mask & FS_MODIFY))
-			*removed = FS_MODIFY;
+			*recalc = true;
 	}
+
+	return 0;
 }
 
-static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-				       __u32 mask, unsigned int flags,
-				       __u32 *removed)
+static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
+				     __u32 mask, unsigned int flags)
 {
-	__u32 oldmask, newmask;
+	bool recalc = false;
+	int ret;
 
 	spin_lock(&fsn_mark->lock);
-	oldmask = fsnotify_calc_mask(fsn_mark);
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
 		fsn_mark->mask |= mask;
 	} else {
-		fanotify_mark_add_ignored_mask(fsn_mark, mask, flags, removed);
+		fsn_mark->ignored_mask |= mask;
 	}
-	newmask = fsnotify_calc_mask(fsn_mark);
+
+	recalc = fsnotify_calc_mask(fsn_mark) &
+		~fsnotify_conn_mask(fsn_mark->connector);
+
+	ret = fanotify_mark_update_flags(fsn_mark, flags, &recalc);
 	spin_unlock(&fsn_mark->lock);
 
-	return newmask & ~oldmask;
+	if (recalc)
+		fsnotify_recalc_mask(fsn_mark->connector);
+
+	return ret;
 }
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
@@ -1174,8 +1180,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
-	__u32 added, removed = 0;
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
@@ -1197,9 +1202,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			goto out;
 	}
 
-	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags, &removed);
-	if (removed || (added & ~fsnotify_conn_mask(fsn_mark->connector)))
-		fsnotify_recalc_mask(fsn_mark->connector);
+	ret = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
 
 out:
 	mutex_unlock(&group->mark_mutex);
-- 
2.35.1

