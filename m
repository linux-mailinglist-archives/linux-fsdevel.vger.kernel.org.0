Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B52185BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgGHLMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgGHLMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A1C08E763
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so48464811wrs.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsW8lp7Dft6LsK9pLejDbZ0bzJfNS3UHszpSp8npIxQ=;
        b=mgr5RN4YpRBwnuvc77hsUCP7K0DxILXfRtDoYSmhnms/BwbQYFQPHlnTskESYYhSDg
         FrIXum1hvqG09OduqHqZ8Gla2M+e8eCsQubvC1DqgA7pDAb9i/qJaOLz7hDVE2xoN8Il
         CpEaULxL0Qk8xPgjLJcIzGYsPn2VtJ1BrbfVEGagCArtXyn4p1j6Yl+su8uftuKlqBk0
         9Mg8ya0bXIJak/qQAdmkSn/CW2I8zbsp1yMWAAmhUdkTcC1dZjTn60fN+5v5MEhaaeby
         8fhPHmldiLwyB13keA8rPzEhVtlv5non9YjHay30+KJrWEOOYna1++0IkHnZWibHGyMh
         wMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsW8lp7Dft6LsK9pLejDbZ0bzJfNS3UHszpSp8npIxQ=;
        b=dADyqR/6gHxodaQao+xRdvJ9Vk0CRrbcgkzWaSSRlMK1KxHRKGk//nJMhWAY2wc+VW
         WhxwJdazc/DM++QEsmmF0ouu1uOiLNRKVOuxC+MsbBNz0TTniw04vkp3CQaE5lX7FDY2
         vrj15WQCHhDo1JlLjf/hj3lBznntUixEmx5ti5lb5lEa5cVRkIsX53VJId5jdTkARRmb
         +d+eRK05Ps2M0qxbv71FknlTeIEqYh3IhpXHTS/g4bXgmzbZDHfq043Zj/p9KOD9crQg
         +cvHYuz3xG/LnIQGb0dvz5NATAxW6CR76BeHdQ4V2yKtvJOkg3t3zdtyDMTTRg8rkR8+
         a2Mw==
X-Gm-Message-State: AOAM530a8RFXXDlZ//u3rMNQIIEXYVO30dSYE5OJu1WQ+As/Oqa/pfYN
        rmuBRNPf+7/VmVy/RbxLytWO8DL8
X-Google-Smtp-Source: ABdhPJyeADImyv7hWLOTLkg+CPLRVNYGRvsBLo39Xwo4pi/xyBt/dZA+h0cOHIcXfBTn2YU8hgC+dg==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr24191404wrn.253.1594206749193;
        Wed, 08 Jul 2020 04:12:29 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:28 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 16/20] fanotify: use FAN_EVENT_ON_CHILD as implicit flag on sb/mount/non-dir marks
Date:   Wed,  8 Jul 2020 14:11:51 +0300
Message-Id: <20200708111156.24659-16-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
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

