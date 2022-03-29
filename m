Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A24EA8CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiC2Hvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiC2HvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351FC1EA5D8
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h4so23492601wrc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Br1h8G2qXI9ekFcoSJRm2Y+2Hg4qqQhDn83mn5wMdkE=;
        b=SodeooKSCF+qrFCbNYx1+B7rWLAKGibqOh8qbZoY8eITLb96c+SUBf251I85KCnNK4
         T/+AvuCGFGUpHhH7OB1ncAXnv93OWLuUZ7PnMeCk63xRouucC0BNRKjjpRCGPX2J/mU/
         FUedkNFK/p/kaBfUPSzdYWCojU80BcJtI8S0V9jcTRngKo2zOnl9dAnIP8INMT0Vqpxn
         mS3qY/9Nj9vOneGi47K5S0rs1IwwszKjHLSNZxSepDOiPHrn9sZP8yLFXtPiZkVkUlwK
         hdJYzCFQJFUxrl5Qpynr+1fx7aNdq1pnijSds3ymoZWY6NB6tnaCK+j7KtSMLHyUTtLb
         bU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Br1h8G2qXI9ekFcoSJRm2Y+2Hg4qqQhDn83mn5wMdkE=;
        b=Fm1pdAXtPLWdu4tJzdFdBYWHDHbyWj4BmW7xweSZHRjT9xldwMQeM6IkSDbq3DfNzD
         qIKWAj6oe+HzWgDWG+k2Rq5CDyC7VRNkss5xR53OcVzJNY5Z1UAa6Nz3DLjFDJwFIMXp
         SQ//yoQv0OhaNgJrsc3LzKwLazI5/lYTxGTi3QguL5HESuvseQ1/MzHf3xYH8XR82fLy
         Qs0IKpY0SD8YaI51P0sN2jXlEzJ9VsOwQQW2iKqjI4WLfJOY+xWKa/54flzgF/5+A/od
         c/YU3hTgU/QLgOf+js3JHzufA/KOX1cUZDtSkceSdwq15w+aC24JdMNbrORyfZp0/nc1
         RZ9g==
X-Gm-Message-State: AOAM532dxstnAJyk5TA6LT5um94eaeGf4xfwZeezJbcEZjBTC42w7TO5
        YvHf/bEa+VWgbPxzLz3yZPE=
X-Google-Smtp-Source: ABdhPJwaNtS0AmYMFdzufWp+IJ+z54NqzNA4ZrK3/5zRJS6ApmyD1oeXJ/39MU+cr/ceuNmVygBHAg==
X-Received: by 2002:a5d:59a2:0:b0:204:19bc:42ff with SMTP id p2-20020a5d59a2000000b0020419bc42ffmr28959625wrr.687.1648540168726;
        Tue, 29 Mar 2022 00:49:28 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:28 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 14/16] fanotify: add FAN_IOC_SET_MARK_PAGE_ORDER ioctl for testing
Date:   Tue, 29 Mar 2022 10:49:02 +0300
Message-Id: <20220329074904.2980320-15-amir73il@gmail.com>
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

The ioctl can be used to request allocation of marks with large size
and attach them to an object, even if another mark already exists for
the group on the marked object.

These large marks serve no function other than testing direct reclaim
in the context of mark allocation.

Setting the value to 0 restores normal mark allocation.

FAN_MARK_REMOVE refers to the first mark of the group on an object, so
the number of FAN_MARK_REMOVE calls need to match the number of large
marks on the object in order to remove all marks from the object or use
FAN_MARK_FLUSH to remove all marks of that object type.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  5 +++-
 fs/notify/fanotify/fanotify_user.c | 42 +++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h   |  2 ++
 include/uapi/linux/fanotify.h      |  4 +++
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 985e995d2a39..02990a6b1b65 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -1075,7 +1075,10 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
 
 static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
 {
-	kmem_cache_free(fanotify_mark_cache, fsn_mark);
+	if (fsn_mark->flags & FSNOTIFY_MARK_FLAG_KMALLOC)
+		kfree(fsn_mark);
+	else
+		kmem_cache_free(fanotify_mark_cache, fsn_mark);
 }
 
 const struct fsnotify_ops fanotify_fsnotify_ops = {
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2c65038da4ce..a3539bd8e443 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -928,6 +928,16 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 		spin_unlock(&group->notification_lock);
 		ret = put_user(send_len, (int __user *) p);
 		break;
+	case FAN_IOC_SET_MARK_PAGE_ORDER:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		mutex_lock(&group->mark_mutex);
+		group->fanotify_data.mark_page_order = (unsigned int)arg;
+		pr_info("fanotify: set mark size page order to %u",
+			group->fanotify_data.mark_page_order);
+		ret = 0;
+		mutex_unlock(&group->mark_mutex);
+		break;
 	}
 
 	return ret;
@@ -1150,6 +1160,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
+	unsigned int order = group->fanotify_data.mark_page_order;
 	struct fsnotify_mark *mark;
 	int ret;
 
@@ -1162,7 +1173,21 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
 
-	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
+	/*
+	 * If requested to test direct reclaim in mark allocation context,
+	 * start by trying to allocate requested page order per mark and
+	 * fall back to allocation size that is likely to trigger direct
+	 * reclaim but not too large to trigger compaction.
+	 */
+	if (order) {
+		mark = kmalloc(PAGE_SIZE << order,
+			       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+		if (!mark && order > PAGE_ALLOC_COSTLY_ORDER)
+			mark = kmalloc(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER,
+				       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	} else {
+		mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
+	}
 	if (!mark) {
 		ret = -ENOMEM;
 		goto out_dec_ucounts;
@@ -1171,6 +1196,15 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	fsnotify_init_mark(mark, group);
 	if (fan_flags & FAN_MARK_EVICTABLE)
 		mark->flags |= FSNOTIFY_MARK_FLAG_NO_IREF;
+	/*
+	 * Allow adding multiple large marks per object for testing.
+	 * FAN_MARK_REMOVE refers to the first mark of the group, so one
+	 * FAN_MARK_REMOVE is needed for every added large mark (or use
+	 * FAN_MARK_FLUSH to remove all marks).
+	 */
+	if (order)
+		mark->flags |= FSNOTIFY_MARK_FLAG_KMALLOC |
+			       FSNOTIFY_MARK_FLAG_ALLOW_DUPS;
 
 	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
 	if (ret) {
@@ -1201,11 +1235,13 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     __u32 mask, unsigned int flags,
 			     __kernel_fsid_t *fsid)
 {
-	struct fsnotify_mark *fsn_mark;
+	struct fsnotify_mark *fsn_mark = NULL;
 	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
-	fsn_mark = fsnotify_find_mark(connp, group);
+	/* Allow adding multiple large marks per object for testing */
+	if (!group->fanotify_data.mark_page_order)
+		fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
 		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, flags,
 						 fsid);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index df58439a86fa..8220cf560c28 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -250,6 +250,7 @@ struct fsnotify_group {
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
 			mempool_t error_events_pool;
+			unsigned int mark_page_order; /* for testing only */
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
@@ -528,6 +529,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_ALLOW_DUPS		0x0040
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
 #define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
+#define FSNOTIFY_MARK_FLAG_KMALLOC		0x0400
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index f1f89132d60e..49cdc9008bf2 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_FANOTIFY_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
 
 /* the following events that user-space can register for */
 #define FAN_ACCESS		0x00000001	/* File was accessed */
@@ -206,4 +207,7 @@ struct fanotify_response {
 				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <= (long)(len))
 
+/* Only for testing. Not useful otherwise */
+#define	FAN_IOC_SET_MARK_PAGE_ORDER	_IOW(0xfa, 1, long)
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
-- 
2.25.1

