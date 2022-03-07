Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC634D038F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiCGP7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiCGP7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:59:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039023153E
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 07:58:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b5so24074619wrr.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+o3fRMhYc5bUka8DDTFbEWlfpRNsPHxhCkbroUX0brI=;
        b=Iyb2EY7qYK2Sd/ELFKxNdY4ZvzmNcd7lIyNw62iMuu6WU/wBQfmLIlJjEFkgduNh81
         KVybW44gRDho6QGTwrATkRUQf+bqApuJSfXMjl0tJtzZWIU9dh2B3gJRuTE5tNp/Ongk
         foC0D78MkL8GwngA75B3PjztcDG13GrXVuLwD04F6LEBWFEw3U87AAYO3KvyCFNyPydK
         uHm4mJjAHZQ9QyzO8zrLi55vlWO0iCckyG+mX8U5LT9C2t6/1dR1Z3TL2HIJPsdsS+sX
         0RKo2xOYDPRy4Xm6T8Jup2xHEfErKaXVZA72LcuhseckOdMP4laIgfmPGNe3iNT9weVu
         yeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+o3fRMhYc5bUka8DDTFbEWlfpRNsPHxhCkbroUX0brI=;
        b=3q9/vwO5YEMl3Tgi09hHUIwnMu9E5x+hCM0qxPGT2vO34i5D2d6r2ppvPSJO9nb8vO
         dQoMblNHkCdCnpXeRq89R9TTQfgdkW2a90f7GkxHFtr5zAN2KX+JP9O0lFWAOAQfasBK
         WKOIBgnsT5UPf0hx63Mz6UMV5CZTKDbKwRJHC2YRAWDgptFokWBD5XnorO6a+F2tSeC5
         JqBFz/NAFY8NfZ6XpfpRRx7dfeQ6QcHJtAnDQg5hDKc6L9VfkcIsr/AcOnoYWoAZ7H61
         VezGbva5hxgoS7nkpBjWIMsRjn0DmmkqZ1eQy/FMk9FeurISO9naqO3EWqlu/GLKIUPR
         lbMw==
X-Gm-Message-State: AOAM533ImcdxM2gqbKKcxqfZs5zxBtV0jwYNSY7rgLpURDtonOUIgVXO
        4c9Pp7euUIxqh48VaxHclDU=
X-Google-Smtp-Source: ABdhPJybkKlg9IvDGHV5j2fh2N8bfHcgfSx4mhUQltqLxvTrLUejjxG5UXkRLDdHANHQ6iav/bsePg==
X-Received: by 2002:adf:fd87:0:b0:1ed:e0c3:a2d4 with SMTP id d7-20020adffd87000000b001ede0c3a2d4mr8630629wrr.374.1646668685494;
        Mon, 07 Mar 2022 07:58:05 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm11686591wrv.79.2022.03.07.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:58:05 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] fanotify: add support for "volatile" inode marks
Date:   Mon,  7 Mar 2022 17:57:41 +0200
Message-Id: <20220307155741.1352405-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307155741.1352405-1-amir73il@gmail.com>
References: <20220307155741.1352405-1-amir73il@gmail.com>
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

When an inode mark is created with flag FAN_MARK_VOLATILE, it will not
pin the marked inode to inode cache, so when inode is evicted from cache
due to memory pressure, the mark will be lost.

Volatile inode marks can be used to setup inode marks with ignored mask
to suppress events from uninteresting files or directories in a lazy
manner, upon receiving the first event, without having to iterate all
the uninteresting files or directories before hand.

The volatile inode mark feature allows performing this lazy marks setup
without exhausting the system memory with pinned inodes.

Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 21 ++++++++++++++++++---
 include/linux/fanotify.h           |  1 +
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 99c5ced6abd8..6e9e4020ef40 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1122,11 +1122,14 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
 						   unsigned int obj_type,
+						   unsigned int fan_flags,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
 	struct fsnotify_mark *mark;
 	int ret;
+	unsigned int fsn_flags = (fan_flags & FAN_MARK_VOLATILE) ?
+				 FSNOTIFY_ADD_MARK_NO_IREF : 0;
 
 	/*
 	 * Enforce per user marks limits per user in all containing user ns.
@@ -1144,7 +1147,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	}
 
 	fsnotify_init_mark(mark, group);
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsn_flags, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
 		goto out_dec_ucounts;
@@ -1180,7 +1183,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid);
+		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, flags,
+						 fsid);
 		if (IS_ERR(fsn_mark)) {
 			mutex_unlock(&group->mark_mutex);
 			return PTR_ERR(fsn_mark);
@@ -1604,6 +1608,17 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	    mark_type != FAN_MARK_FILESYSTEM)
 		goto fput_and_out;
 
+	/*
+	 * Volatile is only relevant for inode, because only inode object can be
+	 * evicted on memory pressure.  Inode is pinned when attaching the mark
+	 * to the inode, so require the FAN_MARK_CREATE flag to make sure that
+	 * we are not updating an existing mark on a pinned inode.
+	 */
+	if (flags & FAN_MARK_VOLATILE &&
+	    (!(flags & FAN_MARK_CREATE) ||
+	     mark_type != FAN_MARK_INODE))
+		goto fput_and_out;
+
 	/*
 	 * Events that do not carry enough information to report
 	 * event->fd require a group that supports reporting fid.  Those
@@ -1756,7 +1771,7 @@ static int __init fanotify_user_setup(void)
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 780f4b17d4c9..bf88c547d93f 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -68,6 +68,7 @@
 				 FAN_MARK_ONLYDIR | \
 				 FAN_MARK_IGNORED_MASK | \
 				 FAN_MARK_IGNORED_SURV_MODIFY | \
+				 FAN_MARK_VOLATILE | \
 				 FAN_MARK_CREATE)
 
 /*
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index c41feac21fe9..1a67e6be994e 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -83,6 +83,7 @@
 #define FAN_MARK_FLUSH		0x00000080
 /* FAN_MARK_FILESYSTEM is	0x00000100 */
 #define FAN_MARK_CREATE		0x00000200
+#define FAN_MARK_VOLATILE	0x00000400
 
 /* These are NOT bitwise flags.  Both bits can be used togther.  */
 #define FAN_MARK_INODE		0x00000000
-- 
2.25.1

