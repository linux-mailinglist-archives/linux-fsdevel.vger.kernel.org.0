Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEEF55E0D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiF0Rrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiF0RrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:47:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A95D111;
        Mon, 27 Jun 2022 10:47:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n1so14091374wrg.12;
        Mon, 27 Jun 2022 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOCbRiGco+YfRqC1w9613TFGz7Y3t1xnJZfGUpwKtA4=;
        b=pR8VovPaQp9kJM+hngqNGLnYCASmzmW+Xhz0gY6EhAlKS2dY96uYFYIQfl4xx9HQT1
         QE6ClMjLH1liPn0Nt8SIB9eE4Zhn0Z3PZKt3zcKe4mqE6swUeOY8Vop7THqgv+AKneWM
         w3t1ixPpVCpriUNpCCNkiEOWCyZsOpikY19EpGtz+2oQAwPEUqkrekI6xZnJxQbdpYOa
         z1O2OqiJEQIBky5mNuXigYZmPbvFwuJhGpaoaQzVCAUymDh7FaiJsHH4VLj+dTiEFg64
         75B2Y9Dzn/BSsSmn7fU/rKIBFRYIIYNHSvGwlUygF3HqzMIlLCPkKBL6Q4WysYTuxzf6
         gWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOCbRiGco+YfRqC1w9613TFGz7Y3t1xnJZfGUpwKtA4=;
        b=mu9MPhsBBKUtSVqW5gXILlARUFAWrcJrbbbhAAosl0OYfSPSLP3nAsGvg2usn7IyeS
         F8zwlEpcXzCCOOqmuGMWKy8JJILkqz/BEArvOBxsSdmZoiA/lOiOy9asRIqKiJmSDwwL
         vl/CKtiE9b7i0I150q2lfydOkmSwxed0htR7awc9CcgmHM7lsFdrUmZKETL3bOHwC8hx
         yBPGEKtj5KASQWdNz7tropQT7Nugoza0+9mKDfodjFXa3BM0k4y0XHIwkgrMrfrcCC38
         i0MloxbsXRWZxhd9DYPekBZ+sshlRiUoA/jF7qNFK0In+HH2S/b4szyQJrpsjczkKPPO
         rkgw==
X-Gm-Message-State: AJIora+MEuotmKAM1hYTRLWfzHc9FUuEZc9SbfR7pzoJPk2wWodHduVG
        iO1nvT7l9xYKfzkFGaOVtzc=
X-Google-Smtp-Source: AGRyM1vHfCaH8R2gCzYxurXJlR9USnPS5EC5blYHQgEIHpULF9sa2va4Za8Tj39yZC+BdnxW4oLRRA==
X-Received: by 2002:adf:dbcd:0:b0:21b:868a:4cbe with SMTP id e13-20020adfdbcd000000b0021b868a4cbemr13078118wrj.522.1656352042687;
        Mon, 27 Jun 2022 10:47:22 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c365500b003a0426fae52sm9593003wmq.24.2022.06.27.10.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:47:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH] fanotify: refine the validation checks on non-dir inode mask
Date:   Mon, 27 Jun 2022 20:47:19 +0300
Message-Id: <20220627174719.2838175-1-amir73il@gmail.com>
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

Commit ceaf69f8eadc ("fanotify: do not allow setting dirent events in
mask of non-dir") added restrictions about setting dirent events in the
mask of a non-dir inode mark, which does not make any sense.

For backward compatibility, these restictions were added only to new
(v5.17+) APIs.

It also does not make any sense to set the flags FAN_EVENT_ON_CHILD or
FAN_ONDIR in the mask of a non-dir inode.  Add these flags to the
dir-only restriction of the new APIs as well.

Move the check of the dir-only flags for new APIs into the helper
fanotify_events_supported(), which is only called for FAN_MARK_ADD,
because there is no need to error on an attempt to remove the dir-only
flags from non-dir inode.

Fixes: ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
Link: https://lore.kernel.org/linux-fsdevel/20220627113224.kr2725conevh53u4@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Jan,

Here is the retroactive API fix that we dicussed merging to v5.19.

There is an LTP test [1] and an update for the man page patch of
FAN_REPORT_TARGET_FID [2], which is still in review.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fan_enotdir
[2] https://github.com/amir73il/man-pages/commits/fanotify_target_fid


 fs/notify/fanotify/fanotify_user.c | 34 +++++++++++++++++-------------
 include/linux/fanotify.h           |  4 ++++
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c2255b440df9..b08ce0d821a7 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1513,8 +1513,15 @@ static int fanotify_test_fid(struct dentry *dentry)
 	return 0;
 }
 
-static int fanotify_events_supported(struct path *path, __u64 mask)
+static int fanotify_events_supported(struct fsnotify_group *group,
+				     struct path *path, __u64 mask,
+				     unsigned int flags)
 {
+	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
+	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
+				 (mask & FAN_RENAME);
+
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
 	 * files. For them fanotify permission events have high chances of
@@ -1526,6 +1533,16 @@ static int fanotify_events_supported(struct path *path, __u64 mask)
 	if (mask & FANOTIFY_PERM_EVENTS &&
 	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
 		return -EINVAL;
+
+	/*
+	 * We shouldn't have allowed setting dirent events and the directory
+	 * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inode,
+	 * but because we always allowed it, error only when using new APIs.
+	 */
+	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
+	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+		return -ENOTDIR;
+
 	return 0;
 }
 
@@ -1672,7 +1689,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	if (flags & FAN_MARK_ADD) {
-		ret = fanotify_events_supported(&path, mask);
+		ret = fanotify_events_supported(group, &path, mask, flags);
 		if (ret)
 			goto path_put_and_out;
 	}
@@ -1695,19 +1712,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	else
 		mnt = path.mnt;
 
-	/*
-	 * FAN_RENAME is not allowed on non-dir (for now).
-	 * We shouldn't have allowed setting any dirent events in mask of
-	 * non-dir, but because we always allowed it, error only if group
-	 * was initialized with the new flag FAN_REPORT_TARGET_FID.
-	 */
-	ret = -ENOTDIR;
-	if (inode && !S_ISDIR(inode->i_mode) &&
-	    ((mask & FAN_RENAME) ||
-	     ((mask & FANOTIFY_DIRENT_EVENTS) &&
-	      FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID))))
-		goto path_put_and_out;
-
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
 	if (mnt || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index edc28555814c..e517dbcf74ed 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -111,6 +111,10 @@
 					 FANOTIFY_PERM_EVENTS | \
 					 FAN_Q_OVERFLOW | FAN_ONDIR)
 
+/* Events and flags relevant only for directories */
+#define FANOTIFY_DIRONLY_EVENT_BITS	(FANOTIFY_DIRENT_EVENTS | \
+					 FAN_EVENT_ON_CHILD | FAN_ONDIR)
+
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
-- 
2.25.1

