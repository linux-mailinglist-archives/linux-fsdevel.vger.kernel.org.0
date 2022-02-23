Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60824C1647
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 16:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiBWPPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 10:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiBWPPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:15:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E59B8B4C
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 07:14:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v21so4890436wrv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 07:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JA+YCYSKBdXF2hiPyVbTrCvSQl4TP8LW0eEb2Bit87w=;
        b=bqOPOgV/+EhcK2SWB16gY4FAYJZSI1MRUv6sCkR7+N3l2FXopfKl0aIytMqzdBDsn3
         BOwcSLprZNSLvtlx57J71VLFXzl2G2eM9s5L++YNFVFYrm89lwRbaycDUn/J+I8GKleG
         be4/OTH1ahex7U5INPTOdPEEFAp3quD76Zwe9XS2IkhNrcmaooH3zKrdtGzF4dK+R8kR
         r7BxhPLO6fFPqzv+MdkZ9abD/GpcLn3EtqKC/emE02iX4J1INIxVHXbrp1ICTREK2cgm
         O4mcVUpTqa1JBxLVsE1VlVy8/aMHKFarFSg0R4h+GfZwQYRUJMAR0oLGUOMSuub4K5no
         Ithg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JA+YCYSKBdXF2hiPyVbTrCvSQl4TP8LW0eEb2Bit87w=;
        b=OX5VmEPOZtzH+oO2B5hzvHcpNlEWCfcOMvRx9KwU1nPKEkJ6Ixv2zXEnWU01UnWY1g
         b0VAy/nrlMC+yEp1WVubfY4q5moCHw1BIulLc6waNj0ridEIaH9g2f6CNp2Q8SNuu3lx
         UiNe/yiApZFZYIyRZ0N0Bz+6ePj2Lh9DcFkRlQX7er3UaAzTASJXsTxize1+iSwNM2zz
         x/QM3vS0zq+xlYiG559V54lGFJInHBw1rK/wTB+PTMapQYY91mjfSqyFiYFvsx7jDpnJ
         4NWjRJhmXbAOkLaKZIEgaHTJqlGjb6Y2C9bgd2KLx+bVaIHq/g+8R4S4Hk0wAtaFtsDW
         bnQA==
X-Gm-Message-State: AOAM532vrO62bNJVVlmGluDSSo1RZnivDSw4PpU80np/42DqFZyST0t8
        CPN9aMACycmvB8u168KxkQ0=
X-Google-Smtp-Source: ABdhPJy0Ft9yG7xe22FCDkXRK3kWMRJrsW5l+dpL9kN8NDaM4dhaZw+Xf/plMGMpCEYekPOMUPS1bg==
X-Received: by 2002:adf:e8c5:0:b0:1e4:7c8a:21a7 with SMTP id k5-20020adfe8c5000000b001e47c8a21a7mr88516wrn.516.1645629286186;
        Wed, 23 Feb 2022 07:14:46 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.153])
        by smtp.gmail.com with ESMTPSA id 3sm57488548wrz.86.2022.02.23.07.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 07:14:45 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] fsnotify: optimize FS_MODIFY events with no ignored masks
Date:   Wed, 23 Feb 2022 17:14:38 +0200
Message-Id: <20220223151438.790268-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223151438.790268-1-amir73il@gmail.com>
References: <20220223151438.790268-1-amir73il@gmail.com>
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

fsnotify() treats FS_MODIFY events specially - it does not skip them
even if the FS_MODIFY event does not apear in the object's fsnotify
mask.  This is because send_to_group() checks if FS_MODIFY needs to
clear ignored mask of marks.

The common case is that an object does not have any mark with ignored
mask and in particular, that it does not have a mark with ignored mask
and without the FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag.

Set FS_MODIFY in object's fsnotify mask during fsnotify_recalc_mask()
if object has a mark with an ignored mask and without the
FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag and remove the special
treatment of FS_MODIFY in fsnotify(), so that FS_MODIFY events could
be optimized in the common case.

Call fsnotify_recalc_mask() from fanotify after adding or removing an
ignored mask from a mark without FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY
or when adding the FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag to a mark
with ignored mask (the flag cannot be removed by fanotify uapi).

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 32 +++++++++++++++++++++++-------
 fs/notify/fsnotify.c               |  8 +++++---
 include/linux/fsnotify_backend.h   |  4 ++++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index bd99430a128d..9b32b76a9c30 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1081,8 +1081,28 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 				    flags, umask);
 }
 
+static void fanotify_mark_add_ignored_mask(struct fsnotify_mark *fsn_mark,
+					   __u32 mask, unsigned int flags,
+					   __u32 *removed)
+{
+	fsn_mark->ignored_mask |= mask;
+
+	/*
+	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
+	 * the removal of the FS_MODIFY bit in calculated mask if it was set
+	 * because of an ignored mask that is now going to survive FS_MODIFY.
+	 */
+	if ((flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
+		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
+		if (!(fsn_mark->mask & FS_MODIFY))
+			*removed = FS_MODIFY;
+	}
+}
+
 static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-				       __u32 mask, unsigned int flags)
+				       __u32 mask, unsigned int flags,
+				       __u32 *removed)
 {
 	__u32 oldmask, newmask;
 
@@ -1091,9 +1111,7 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
 		fsn_mark->mask |= mask;
 	} else {
-		fsn_mark->ignored_mask |= mask;
-		if (flags & FAN_MARK_IGNORED_SURV_MODIFY)
-			fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
+		fanotify_mark_add_ignored_mask(fsn_mark, mask, flags, removed);
 	}
 	newmask = fsnotify_calc_mask(fsn_mark);
 	spin_unlock(&fsn_mark->lock);
@@ -1156,7 +1174,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
-	__u32 added;
+	__u32 added, removed = 0;
 	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
@@ -1179,8 +1197,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			goto out;
 	}
 
-	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
-	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
+	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags, &removed);
+	if (removed || (added & ~fsnotify_conn_mask(fsn_mark->connector)))
 		fsnotify_recalc_mask(fsn_mark->connector);
 
 out:
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index ab81a0776ece..494f653efbc6 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -531,11 +531,13 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 
 
 	/*
-	 * if this is a modify event we may need to clear the ignored masks
-	 * otherwise return if none of the marks care about this type of event.
+	 * If this is a modify event we may need to clear some ignored masks.
+	 * In that case, the object with ignored masks will have the FS_MODIFY
+	 * event in its mask.
+	 * Otherwise, return if none of the marks care about this type of event.
 	 */
 	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
-	if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
+	if (!(test_mask & marks_mask))
 		return 0;
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 5f9c960049b0..0805b74cae44 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -609,6 +609,10 @@ static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 	if (!mark->ignored_mask)
 		return mask;
 
+	/* Interest in FS_MODIFY may be needed for clearing ignored mask */
+	if (!(mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
+		mask |= FS_MODIFY;
+
 	/*
 	 * If mark is interested in ignoring events on children, the object must
 	 * show interest in those events for fsnotify_parent() to notice it.
-- 
2.25.1

