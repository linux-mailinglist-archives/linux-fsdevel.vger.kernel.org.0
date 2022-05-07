Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426951E55E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 10:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446041AbiEGIEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiEGIEj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 04:04:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93D0140CA
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 01:00:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso8110505wmh.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+pXIdtlZit2vB0hZe9m6rKYTu5tUPoE+WFGhdHpExLM=;
        b=YoD04nU0AWEXXtFmzGw3uSGp1ImKzzlbPIP3bDuHX5chK5sdvb+GN56KrklN2YOOvt
         hfglTaWU3/RVt33DgZi0w9fszNuUrPxzIueB8cbOJAh1DvLzBPCVKMMocv5Od4PphGDd
         rULWKdoyvj1z9ByS8kPuNvjd52KaTvGXmptQu7Y8ZdhxzyQ14+9jljhmVEeLJJR2hNPz
         FtreV2AfXl3dyXkcZZ6Ib263Ex4rDRk410rx3iQWKtD9cLR3cX8gm2p1+phjbYhHH3Ih
         jfwOMSOZLZlZFPwNLhmG30j/xT2ehu+SCP8PzWfbCQGERGFuqvlwrpPJxGkj1X8HwW77
         eG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+pXIdtlZit2vB0hZe9m6rKYTu5tUPoE+WFGhdHpExLM=;
        b=FkjoFpqSCiijG9fMZWy9LBqJr8kvlgssMV/4y0l8jUwz0ss/XbdvZ4N+sqS+rxWZO/
         19/x3xEDF8r+c5sLHIJwoqPT8zreuvkRRymixbi8QZsWgyreOHGXHbqmNQw+KvvEejAA
         5XGP0eFM5eCD2P/uYGug7Kn6LZvYVmoR2wwSAxXRU90aTun5atwJ9coi+xtpyayOmagi
         3YVpzsWlo7faPLVDZLIb+EPbXBCoHo9YRdzIJ9qt2n53cSxqFRly3cdrK+aPa1vHqfT4
         fKbrYVew0Lc1iOwLByitvVlG5M18xr50NTjS7suIRcr1u86W1AEkuhFnD/zBXNzNiB5m
         mmbg==
X-Gm-Message-State: AOAM533YlfXfsmUtYAApn779Dj4aKaeFWSnMbyIPIpaJ9R0JvmIy3nW0
        IdTNsfWrV86tiBEtjp7mzkg=
X-Google-Smtp-Source: ABdhPJxG9h7rY422Ez2SNDlpy1SrZgWPet4HsFhQdyERo6anKpkSOABbLJSx1F3J6acy1fs7F/qAZA==
X-Received: by 2002:a7b:c419:0:b0:393:fc45:c7ac with SMTP id k25-20020a7bc419000000b00393fc45c7acmr7160563wmi.90.1651910452048;
        Sat, 07 May 2022 01:00:52 -0700 (PDT)
Received: from localhost.localdomain ([77.137.67.34])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003942a244f47sm11910818wmk.32.2022.05.07.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:00:51 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fanotify: do not allow setting dirent events in mask of non-dir
Date:   Sat,  7 May 2022 11:00:28 +0300
Message-Id: <20220507080028.219826-1-amir73il@gmail.com>
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

Dirent events (create/delete/move) are only reported on watched
directory inodes, but in fanotify as well as in legacy inotify, it was
always allowed to set them on non-dir inode, which does not result in
any meaningful outcome.

Until kernel v5.17, dirent events in fanotify also differed from events
"on child" (e.g. FAN_OPEN) in the information provided in the event.
For example, FAN_OPEN could be set in the mask of a non-dir or the mask
of its parent and event would report the fid of the child regardless of
the marked object.
By contrast, FAN_DELETE is not reported if the child is marked and the
child fid was not reported in the events.

Since kernel v5.17, with fanotify group flag FAN_REPORT_TARGET_FID, the
fid of the child is reported with dirent events, like events "on child",
which may create confusion for users expecting the same behavior as
events "on child" when setting events in the mask on a child.

The desired semantics of setting dirent events in the mask of a child
are not clear, so for now, deny this action for a group initialized
with flag FAN_REPORT_TARGET_FID and for the new event FAN_RENAME.
We may relax this restriction in the future if we decide on the
semantics and implement them.

Fixes: d61fd650e9d2 ("fanotify: introduce group flag FAN_REPORT_TARGET_FID")
Fixes: 8cc3b1ccd930 ("fanotify: wire up FAN_RENAME event")
Link: https://lore.kernel.org/linux-fsdevel/20220505133057.zm5t6vumc4xdcnsg@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

Having slept over it, I think we should apply this stronger fix.
I could have done this as an extra patch, but since FAN_RENAME was
merged together with FAN_REPORT_TARGET_FID I did not see the point,
but you could apply this on top of the FAN_RENAME patch if you prefer.

Thanks,
Amir.

Changes since v1:
- Deny all dirent events on non-dir not only FAN_RENAME
- Return -ENOTDIR instead of -EINVAL

 fs/notify/fanotify/fanotify_user.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index edad67d674dc..cf587ba2ba92 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1695,6 +1695,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	else
 		mnt = path.mnt;
 
+	/*
+	 * FAN_RENAME is not allowed on non-dir (for now).
+	 * We shouldn't have allowed setting any dirent events in mask of
+	 * non-dir, but because we always allowed it, error only if group
+	 * was initialized with the new flag FAN_REPORT_TARGET_FID.
+	 */
+	ret = -ENOTDIR;
+	if (inode && !S_ISDIR(inode->i_mode) &&
+	    ((mask & FAN_RENAME) ||
+	     ((mask & FANOTIFY_DIRENT_EVENTS) &&
+	      FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID))))
+		goto path_put_and_out;
+
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
 	if (mnt || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
-- 
2.25.1

