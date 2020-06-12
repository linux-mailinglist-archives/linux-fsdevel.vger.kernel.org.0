Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AE1F7615
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgFLJe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgFLJeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:23 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF84C03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:23 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w7so5962387edt.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsW8lp7Dft6LsK9pLejDbZ0bzJfNS3UHszpSp8npIxQ=;
        b=Uk1R8WfiVcIW8bHYTlMMJyv8sZjdzTCQCSXitfIgl7y0k5BSdWxNQSsHTyyKP79y1z
         1GR0jWfqhu0DidMOoiyqNaamZEZmf4C/3W8VIhu84LcoEckuZ4zdYBl42orbBrOFA0Gk
         wpO5bzjXKh8p6HiVbPydT53RWJLRPcEZKSk3/zF/iVBcjpOuhK/qKB75wUavyj1WNCs9
         0HGziTSgttjLX0OPZVQ6r99QEdI/v/69/bE8xbkCoSS2Rm0rqYYtQ7mnr9hlINZ/exvL
         339c8CIpNh27QHbCcbO1NQ2kf4evWpyg90LsqiW1/NtCiOlzslSZdUeXXSyC0Q1/kzx2
         SjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsW8lp7Dft6LsK9pLejDbZ0bzJfNS3UHszpSp8npIxQ=;
        b=kpUPwDiBcnlC8xpaNj0aHDklZEU3UhDAXLfUgRuBXM9n2VrRqN+w7uJd44n3ypQXMY
         Suh6HqS9NNAmrdthL3L4luMxRpsy7b+JTjjmYxtKeAKbWMW1y8MN/OOPkTP7B/JNUl1t
         9J/qZ/QOGs9yPUDm9rEWd6zaEiBaV8wPtBzT+wzM88XH+ZVRph9+R/BZXr6xU/RhgHOq
         97Kbob0g67jTsMkrZJmPUaHEJRPnQHbDC+EBaywDzh2dNgRrL9ICReYStH/gp99xfzYz
         GurjQ4fFBp52KTclsgGU+CcB8vVP6aJ6kieg7/C77ZRDo6oSsCqHga5U1H9LB7A2Ramx
         ptwA==
X-Gm-Message-State: AOAM531ivMIKyi823tpoZSjsaI0cNigQscoAvLauwguN2+089Dzo4E8k
        EVEZWGsa0TnsvryZ8NfgVBo=
X-Google-Smtp-Source: ABdhPJwF512FbkZ9Cv+CBDnlUkcD3HVn59WcJB54DKJ+7fWh8wwGDQooYHThBoixHWV0norahSrm6w==
X-Received: by 2002:a50:cfc4:: with SMTP id i4mr10583068edk.252.1591954461880;
        Fri, 12 Jun 2020 02:34:21 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/20] fanotify: use FAN_EVENT_ON_CHILD as implicit flag on sb/mount/non-dir marks
Date:   Fri, 12 Jun 2020 12:33:39 +0300
Message-Id: <20200612093343.5669-17-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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
index 66d663baa4a6..42b8cc51cb3f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1045,6 +1045,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	bool ignored = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
+	u32 umask = 0;
 	int ret;
 
 	pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
@@ -1162,6 +1163,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
@@ -1178,13 +1185,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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

