Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0257D4B642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfFSKew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 06:34:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53494 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSKew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:34:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so1168187wmj.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BRqkrcMPs4kuNHnTGeoA0BADPWNw3DxS9bf+PQj9Kcc=;
        b=eLASm0/Z655JJei7qM/MDhhxShsZUpkpWW7oUwcwnvffdHgcNwCW/NxaxEbbdrknbz
         n8Bnyi2RImm4nZdhx55ZqhPM2Y+KLy7JMj669d/5uKZYBG1PYxSeMHkwThLKJsmkg+po
         4AT5R1Z/Qgb+tej1IufuIeW0CgGd2PnsAVXcFKciyW1pfmGZTEqeuepyjvxTajoVN2Ew
         sxy40ntKEL5sfQGCW1HDuh3jX56MYulmJQkwGDeMpGfgCVsp8DmXZeGANZG1KigHX1RJ
         EN5OgI+uthb6e8EfVLaQvlMYqG2hJW52Hp/PcVVFQ/orAzIf3qR2ZbMAlVrWl1YHHTpq
         dTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BRqkrcMPs4kuNHnTGeoA0BADPWNw3DxS9bf+PQj9Kcc=;
        b=umZeTXguCBfr7DvEgXtsIwK4xx0aFKaUPzUiK4T6QOxlMpyrklRoVOioLhX34buspP
         Q/xolF3vqjr3kF4T7oLtKTVIrl7XAIgQvw2/a4KFCyMnb2LeBdH9U724z8SQQJ6xk5sx
         PvY5wo35zlGvGHWqfSvqAMTovokuZifd7jUbbu31HuSS5YrbRetdaGkDQnHMEckTPJZP
         K62iYx7dYeh+HQchLVpfQ4olqBGvuM7IsKK2PIZDbDVhOFPG8SDo+WfWukukJMdic5oo
         hjRiliV4Wuid87bCEBs3zGDHVeMttltojC/E6sWIEIJo3c7AxKTTpKoX6MRPdEHN0usF
         rq4w==
X-Gm-Message-State: APjAAAWdlNCkjhwrbfHiQf0kYkqikFuMrRBbj0VxE9BdmoyBe8ujiCUP
        jk9yr5hQT/dFifnA9UXPZTw=
X-Google-Smtp-Source: APXvYqzi6FDj64dbbdJ5Foja0HAJtY7qFKOa1Ft0oW9772Wu0V/oDoUWanVw5UidQIN0oOCs0zOjtg==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr7706142wmf.19.1560940490130;
        Wed, 19 Jun 2019 03:34:50 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id 66sm1184512wma.11.2019.06.19.03.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 03:34:49 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: update connector fsid cache on add mark
Date:   Wed, 19 Jun 2019 13:34:44 +0300
Message-Id: <20190619103444.26899-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When implementing connector fsid cache, we only initialized the cache
when the first mark added to object was added by FAN_REPORT_FID group.
We forgot to update conn->fsid when the second mark is added by
FAN_REPORT_FID group to an already attached connector without fsid
cache.

Reported-and-tested-by: syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com
Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

This fix has been confirmed by syzbot to fix the issue as well as
by my modification to Matthew's LTP test:
https://github.com/amir73il/ltp/commits/fanotify_dirent

Thanks,
Amir.

 fs/notify/fanotify/fanotify.c    |  4 ++++
 fs/notify/mark.c                 | 14 +++++++++++---
 include/linux/fsnotify_backend.h |  2 ++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e6fde1a5c072..b428c295d13f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -355,6 +355,10 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 		/* Mark is just getting destroyed or created? */
 		if (!conn)
 			continue;
+		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID))
+			continue;
+		/* Pairs with smp_wmb() in fsnotify_add_mark_list() */
+		smp_rmb();
 		fsid = conn->fsid;
 		if (WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
 			continue;
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 25eb247ea85a..99ddd126f6f0 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -482,10 +482,13 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	conn->type = type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
-	if (fsid)
+	if (fsid) {
 		conn->fsid = *fsid;
-	else
+		conn->flags = FSNOTIFY_CONN_FLAG_HAS_FSID;
+	} else {
 		conn->fsid.val[0] = conn->fsid.val[1] = 0;
+		conn->flags = 0;
+	}
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
 		inode = igrab(fsnotify_conn_inode(conn));
 	/*
@@ -560,7 +563,12 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 		if (err)
 			return err;
 		goto restart;
-	} else if (fsid && (conn->fsid.val[0] || conn->fsid.val[1]) &&
+	} else if (fsid && !(conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID)) {
+		conn->fsid = *fsid;
+		/* Pairs with smp_rmb() in fanotify_get_fsid() */
+		smp_wmb();
+		conn->flags |= FSNOTIFY_CONN_FLAG_HAS_FSID;
+	} else if (fsid && (conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID) &&
 		   (fsid->val[0] != conn->fsid.val[0] ||
 		    fsid->val[1] != conn->fsid.val[1])) {
 		/*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a9f9dcc1e515..da181dc05261 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -293,6 +293,8 @@ typedef struct fsnotify_mark_connector __rcu *fsnotify_connp_t;
 struct fsnotify_mark_connector {
 	spinlock_t lock;
 	unsigned int type;	/* Type of object [lock] */
+#define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
+	unsigned int flags;	/* flags [lock] */
 	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
 		/* Object pointer [lock] */
-- 
2.17.1

