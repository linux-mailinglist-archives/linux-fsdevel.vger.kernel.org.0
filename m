Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7374C1646
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 16:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiBWPPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 10:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbiBWPPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:15:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF2B8B4C
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 07:14:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id x15so5772489wrg.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 07:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDriW4jtg4dEswCsH4zAamLv5xitjEBsco/sIycm1Kk=;
        b=YP1ze4w9KGJCXRm0OEpeJj04AneBr+EwVhXLsICb/R/BseLuutOdTHk2WBSV/r1gbd
         D1w/+h4pVpBINvJJ8DinK4Ie4GCNs/0lzGm8MndxyNq0Sr/deVQtJ0PHcfaKuAwH8NAb
         gRLG2GNXOy7tsAvUy2QqdmB7e8r6GD7xz0HalNWEp50PbT7WYkDlWZfI6Ss0gx/a6hld
         z7LCC0YWtRjbKUDZy53gJPuthwCPzKFqnHd/4ibxR0e1PwD09tsskeE423eCxiHiWzmp
         QTfsIth7WfJlHfFdNRZIh+4ZVjXyjE1ul3shjtfGHqqcGAxLlmVET0HNmfuij0VJ/UYy
         HPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDriW4jtg4dEswCsH4zAamLv5xitjEBsco/sIycm1Kk=;
        b=AzInq/OjLLuUtxRHDKctYUqngZ1PIDJ19uBCMeKVhrr1GsSbxaoAq9isA6XrAtaR70
         l/Tdq5MB3SE4+i1Sna1UwZUASWZWzuji2uv1ZuiQIBjquFDcNXLjy25n9hXmP8MW3Qvs
         2Pm619JXSptl0hGTkpJecp3ieCBjoaQ7Fhmt+h1XT6KpgC6o/rfeNq/bLyynIG0uhAaQ
         B6JVfOPdXL1E/JIZpoMdlE1LWymI/IXdFkfjdac3srfp0o4x8BmKrgbvPQAlNnAj26uE
         bCety0d8aYfZAujU0IPXhdb/XRXQvpt7HVJ7KbaOAGEWFOw9pJo1VxJPICm/3DlTeJfX
         Mh7w==
X-Gm-Message-State: AOAM531Q9DkGRoHYJbajRiV8Knx2RnwZzv4w71xWRHLq0di1moNYfIiD
        OMkV6qih73SZ+6549qi4S+s=
X-Google-Smtp-Source: ABdhPJxrhil1ecJYpP6hmk5pMeFNV1CDy7GG3dBF6XO7To/8etV2yER7Dn5tVC+jiQ76IVHA2cEENg==
X-Received: by 2002:adf:f801:0:b0:1e6:8af8:f475 with SMTP id s1-20020adff801000000b001e68af8f475mr82771wrp.592.1645629285046;
        Wed, 23 Feb 2022 07:14:45 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.153])
        by smtp.gmail.com with ESMTPSA id 3sm57488548wrz.86.2022.02.23.07.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 07:14:44 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] fsnotify: fix merge with parent's ignored mask
Date:   Wed, 23 Feb 2022 17:14:37 +0200
Message-Id: <20220223151438.790268-2-amir73il@gmail.com>
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

fsnotify_parent() does not consider the parent's mark at all unless
the parent inode shows interest in events on children and in the
specific event.

So unless parent added an event to both its mark mask and ignored mask,
the event will not be ignored.

Fix this by declaring the interest of an object in an event when the
event is in either a mark mask or ignored mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 17 +++++++++--------
 fs/notify/mark.c                   |  4 ++--
 include/linux/fsnotify_backend.h   | 15 +++++++++++++++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2ff6bd85ba8f..bd99430a128d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1003,17 +1003,18 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 					    __u32 mask, unsigned int flags,
 					    __u32 umask, int *destroy)
 {
-	__u32 oldmask = 0;
+	__u32 oldmask, newmask;
 
 	/* umask bits cannot be removed by user */
 	mask &= ~umask;
 	spin_lock(&fsn_mark->lock);
+	oldmask = fsnotify_calc_mask(fsn_mark);
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
-		oldmask = fsn_mark->mask;
 		fsn_mark->mask &= ~mask;
 	} else {
 		fsn_mark->ignored_mask &= ~mask;
 	}
+	newmask = fsnotify_calc_mask(fsn_mark);
 	/*
 	 * We need to keep the mark around even if remaining mask cannot
 	 * result in any events (e.g. mask == FAN_ONDIR) to support incremenal
@@ -1023,7 +1024,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 	*destroy = !((fsn_mark->mask | fsn_mark->ignored_mask) & ~umask);
 	spin_unlock(&fsn_mark->lock);
 
-	return mask & oldmask;
+	return oldmask & ~newmask;
 }
 
 static int fanotify_remove_mark(struct fsnotify_group *group,
@@ -1081,23 +1082,23 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 }
 
 static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-				       __u32 mask,
-				       unsigned int flags)
+				       __u32 mask, unsigned int flags)
 {
-	__u32 oldmask = -1;
+	__u32 oldmask, newmask;
 
 	spin_lock(&fsn_mark->lock);
+	oldmask = fsnotify_calc_mask(fsn_mark);
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
-		oldmask = fsn_mark->mask;
 		fsn_mark->mask |= mask;
 	} else {
 		fsn_mark->ignored_mask |= mask;
 		if (flags & FAN_MARK_IGNORED_SURV_MODIFY)
 			fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
 	}
+	newmask = fsnotify_calc_mask(fsn_mark);
 	spin_unlock(&fsn_mark->lock);
 
-	return mask & ~oldmask;
+	return newmask & ~oldmask;
 }
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 9007d6affff3..4853184f7dde 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -127,7 +127,7 @@ static void __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 		return;
 	hlist_for_each_entry(mark, &conn->list, obj_list) {
 		if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED)
-			new_mask |= mark->mask;
+			new_mask |= fsnotify_calc_mask(mark);
 	}
 	*fsnotify_conn_mask_p(conn) = new_mask;
 }
@@ -692,7 +692,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	if (ret)
 		goto err;
 
-	if (mark->mask)
+	if (mark->mask || mark->ignored_mask)
 		fsnotify_recalc_mask(mark->connector);
 
 	return ret;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 790c31844db5..5f9c960049b0 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -601,6 +601,21 @@ extern void fsnotify_remove_queued_event(struct fsnotify_group *group,
 
 /* functions used to manipulate the marks attached to inodes */
 
+/* Get mask for calculating object interest taking ignored mask into account */
+static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
+{
+	__u32 mask = mark->mask;
+
+	if (!mark->ignored_mask)
+		return mask;
+
+	/*
+	 * If mark is interested in ignoring events on children, the object must
+	 * show interest in those events for fsnotify_parent() to notice it.
+	 */
+	return mask | (mark->ignored_mask & ALL_FSNOTIFY_EVENTS);
+}
+
 /* Get mask of events for a list of marks */
 extern __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn);
 /* Calculate mask of events for a list of marks */
-- 
2.25.1

