Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C9D50B6CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447282AbiDVMIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447345AbiDVMHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46D456C0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g20so10164484edw.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbFlN4Wo5ETNLfbBFk4QHb/5NerGwM19Z9xSpL4Jqlc=;
        b=i/XcnFREiv4lQjKEcE7Inxakliyjl8Xi6JJYNJPHMIhXUghYtj5HVszSI7N9+wnJT5
         /+Boq9R4suBvQgWHUh3FtVQLJMbTO6unsQ71jAzqFb7i1tYR32R+irbey578tr1aAD9H
         nVmaefDMl5pRi7Yq40PU9LeLa/ItiOL8EHS0V3Itd2b4MK4e102T4jKi0JrCnDcQqnoZ
         EF5SgCalRXcmo1exKRLdDZyFJHMhixaJ/P/VAQ+zLT2z+aUQm87MrDR6++2+DlXij683
         z8og2PoJSpvvfzw9kW8sQRFGbZ3dZ3gTJ14h/FIFlDWVuDNt13tlDkhSyLrPYAZHorYl
         CsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbFlN4Wo5ETNLfbBFk4QHb/5NerGwM19Z9xSpL4Jqlc=;
        b=w6U1qNy4+xkc8Tdm2FBoAoaP2Tc6FMuRWmb3f9Gicc8buGIFQdzH7y6g4vOuBh2dLJ
         TUYM52EQQtmXuPF+iUYgwYDZ0JN7MdXNtao1LSsX9OB4T0vvVvi8noKzDDR1etNIHOHs
         e+BI/OtYrvUeME82fLaq3+1N7sFNe6PeQkw3Wl/sJLhwTdbhQNO3guomloD0d1W62b2/
         cis1JzxgW+Y5r6pdtrCYyOsbwCE6SXlDLLIQFbjl96PsoW7M7h0Y40ZL/6NTJuyl9J6V
         2BlZSi2BKYkMquJIEuW5SSYwTfDbDDqdSHwTkFE71FOt/uhAUToyWok+YRf2TvIcgS7m
         xzvA==
X-Gm-Message-State: AOAM5324QqBsQKK6Atxz/4UmT7LU2kSBen03wX3e0k1YPC2E5qETHnmu
        Af/wrFizSmSDAHbYX1S7JwE=
X-Google-Smtp-Source: ABdhPJyAmnak7LUc3pGhRWCQjn8bCxOCykhhqzh5k4unyT23W3d/qrQy8iZ21Zyiwi+csxVb4kkOeQ==
X-Received: by 2002:a05:6402:4246:b0:423:ee59:1cd9 with SMTP id g6-20020a056402424600b00423ee591cd9mr4541987edb.376.1650629033471;
        Fri, 22 Apr 2022 05:03:53 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:53 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 13/16] fanotify: factor out helper fanotify_mark_update_flags()
Date:   Fri, 22 Apr 2022 15:03:24 +0300
Message-Id: <20220422120327.3459282-14-amir73il@gmail.com>
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

Handle FAN_MARK_IGNORED_SURV_MODIFY flag change in a helper that
is called after updating the mark mask.

Replace the added and removed return values and help variables with
bool recalc return values and help variable, which makes the code a
bit easier to follow.

Rename flags argument to fan_flags to emphasize the difference from
mark->flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 47 ++++++++++++++++--------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3649c99b3e45..4005ee8e6e2c 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1081,42 +1081,45 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 				    flags, umask);
 }
 
-static void fanotify_mark_add_ignored_mask(struct fsnotify_mark *fsn_mark,
-					   __u32 mask, unsigned int flags,
-					   __u32 *removed)
+static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
+				       unsigned int fan_flags)
 {
-	fsn_mark->ignored_mask |= mask;
+	bool recalc = false;
 
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
 	 * the removal of the FS_MODIFY bit in calculated mask if it was set
 	 * because of an ignored mask that is now going to survive FS_MODIFY.
 	 */
-	if ((flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	if ((fan_flags & FAN_MARK_IGNORED_MASK) &&
+	    (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
 	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
 		if (!(fsn_mark->mask & FS_MODIFY))
-			*removed = FS_MODIFY;
+			recalc = true;
 	}
+
+	return recalc;
 }
 
-static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-				       __u32 mask, unsigned int flags,
-				       __u32 *removed)
+static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
+				      __u32 mask, unsigned int fan_flags)
 {
-	__u32 oldmask, newmask;
+	bool recalc;
 
 	spin_lock(&fsn_mark->lock);
-	oldmask = fsnotify_calc_mask(fsn_mark);
-	if (!(flags & FAN_MARK_IGNORED_MASK)) {
+	if (!(fan_flags & FAN_MARK_IGNORED_MASK))
 		fsn_mark->mask |= mask;
-	} else {
-		fanotify_mark_add_ignored_mask(fsn_mark, mask, flags, removed);
-	}
-	newmask = fsnotify_calc_mask(fsn_mark);
+	else
+		fsn_mark->ignored_mask |= mask;
+
+	recalc = fsnotify_calc_mask(fsn_mark) &
+		~fsnotify_conn_mask(fsn_mark->connector);
+
+	recalc |= fanotify_mark_update_flags(fsn_mark, fan_flags);
 	spin_unlock(&fsn_mark->lock);
 
-	return newmask & ~oldmask;
+	return recalc;
 }
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
@@ -1170,11 +1173,11 @@ static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 
 static int fanotify_add_mark(struct fsnotify_group *group,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     __u32 mask, unsigned int flags,
+			     __u32 mask, unsigned int fan_flags,
 			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
-	__u32 added, removed = 0;
+	bool recalc;
 	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
@@ -1191,14 +1194,14 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	 * Error events are pre-allocated per group, only if strictly
 	 * needed (i.e. FAN_FS_ERROR was requested).
 	 */
-	if (!(flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
+	if (!(fan_flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
 		ret = fanotify_group_init_error_pool(group);
 		if (ret)
 			goto out;
 	}
 
-	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags, &removed);
-	if (removed || (added & ~fsnotify_conn_mask(fsn_mark->connector)))
+	recalc = fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
+	if (recalc)
 		fsnotify_recalc_mask(fsn_mark->connector);
 
 out:
-- 
2.35.1

