Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A130D221EAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGPIms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgGPImr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC9AC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so6125889wrl.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VtSI19lVKcekdGv3+3h/X+blWNwMmlEfOOGXPLwnEho=;
        b=ZjXQolMJS/eua0B8JSN7k0Iwpv6evhn7V3taeX7qyO45siRkR5F6hkR1ywXwQIxrqv
         UPY6JXOMHTYfVubWgHDvsI9dY+YfaxGMAmidjiUpbhgPg1RHobNazzOFNWrTmWVKULbN
         9pfIwXgu0srPYddXS+uhZaKSbn3XuKKw0HNW74/tsm2iEMFmZxOSDp99zp7PRoPdpV1i
         NtzevDNrcWbsa6CqBCQmB894ytx9ROe6Grs4M2Xp/o0tKPSvTR/tctnO992kQ85Ss56l
         l1b3XBP/lHekB2qbwrVxlR2qqajimoefUX4hcWFXqXr+TwWcSbIHoXns3udUT4acKdaK
         zRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VtSI19lVKcekdGv3+3h/X+blWNwMmlEfOOGXPLwnEho=;
        b=FZKfhMYO0QVVwDq7yF1yRW5YXXnIFoZ6FvT6B6ofu4RZJUAkEXW6vceD2xeSG/d2z/
         q3w09LpLtluMI5rQMgkF84JAh0/tT/I/sSffmFOmxwueLMVw+idXlATf8+QOXnjFRR7v
         FUNsuRahVTv3qRvEMZ4EIDuekd331cVOv4J8JJXDjIkMcZFA7Oa0cQOBNiO+uBl5kRl7
         yOEpKyOwsWZgxT3+5NJ9QlsbcgK4vfKJWY8YuExr350iWWeLv5zijscKVYjunziHmbZL
         Pd4Iaz1FFce5IgAQWrTu7+JBN1iRals0KdAq6g6N3l4g4JQjvZ3vtb06buTlfxVMXZo/
         OV4A==
X-Gm-Message-State: AOAM531lZ6rkvt0zxB/4r6hN7pLcdOc1TAvfgIoucD4YHHh8hN1fYJE0
        qzCbC4WS5f3Ejw+FYDhW21M=
X-Google-Smtp-Source: ABdhPJx0JFM44ihHtkr77mBsDLKZZ9m6ovbb89Ey/ZLhZXBZybAMqQVN52iShcfPBa6eQjlQ6R/ZKw==
X-Received: by 2002:adf:d842:: with SMTP id k2mr4057218wrl.239.1594888966109;
        Thu, 16 Jul 2020 01:42:46 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:45 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 07/22] fanotify: use FAN_EVENT_ON_CHILD as implicit flag on sb/mount/non-dir marks
Date:   Thu, 16 Jul 2020 11:42:15 +0300
Message-Id: <20200716084230.30611-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Up to now, fanotify allowed to set the FAN_EVENT_ON_CHILD flag on
sb/mount marks and non-directory inode mask, but the flag was ignored.

Mask out the flag if it is provided by user on sb/mount/non-dir marks
and define it as an implicit flag that cannot be removed by user.

This flag is going to be used internally to request for events with
parent and name info.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ab974cd234f7..16d70a8e90f9 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1050,6 +1050,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	bool ignored = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
+	u32 umask = 0;
 	int ret;
 
 	pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
@@ -1167,6 +1168,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	else
 		mnt = path.mnt;
 
+	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
+	if (mnt || !S_ISDIR(inode->i_mode)) {
+		mask &= ~FAN_EVENT_ON_CHILD;
+		umask = FAN_EVENT_ON_CHILD;
+	}
+
 	/* create/update an inode mark */
 	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE)) {
 	case FAN_MARK_ADD:
@@ -1183,13 +1190,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	case FAN_MARK_REMOVE:
 		if (mark_type == FAN_MARK_MOUNT)
 			ret = fanotify_remove_vfsmount_mark(group, mnt, mask,
-							    flags, 0);
+							    flags, umask);
 		else if (mark_type == FAN_MARK_FILESYSTEM)
 			ret = fanotify_remove_sb_mark(group, mnt->mnt_sb, mask,
-						      flags, 0);
+						      flags, umask);
 		else
 			ret = fanotify_remove_inode_mark(group, inode, mask,
-							 flags, 0);
+							 flags, umask);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.17.1

