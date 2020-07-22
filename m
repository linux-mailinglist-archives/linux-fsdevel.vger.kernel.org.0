Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809112298CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbgGVM7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732353AbgGVM7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8982AC0619DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so1474123wmg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uOcSKEZdq5c4M49zjYhdnvMf+g+7K75mT6pfhu0KNtI=;
        b=WwU0GeoFS17Z8YniS55vQFieQ55hulHu0zJjHx8zYsXvqIAfdbquL/m+CTkGh2wilr
         qTscUZVn5Vy0UAc65IPEQZvCg9avpilsmYKHdHVRnZzYY0L7zs/VsLlOlRK3+0b0MwtR
         5zZIMPUUI/O6gtqNymtT0EY1iKDnnuJi0KTKtC7ZP6wc9Y3LkbJxdfr9d0ENW7YjQR3g
         G+09hhzpatTvqiAOWriIDeKFBOLTnSs205EEwpW6RCjSsFaJKXq8rvaZ4fiSzZOYmK4f
         xYgh/TBHQFZefeCjOkp6vBTfQRRTamSVMyT2Pq4RvVDppKh+XMOBY4HUDTu8t4Vslg/R
         Hs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uOcSKEZdq5c4M49zjYhdnvMf+g+7K75mT6pfhu0KNtI=;
        b=aWDmaRghF5cLDCaCpjXNmHkFUta+DchZWduuTLhNvYcKvkrcjOVPxfXiBzSkAcLwqX
         h6Fq9ygK77QtsXxBFg4ods0YbQYcjwoO6BU9ccJtedFnNSA8yd4r0CIrVwh2e+pysw1Z
         h3wNwh7PBuMqRdopMeCnYZC7fZjk4M4B/MpnDvHQd0s5S+upmB7E+S4UR4K4ku0JjAyx
         bG3X1rKL9Qw+jNn28nzIHPldJnVoG4aPtAU/c3pVTiJE2T9zo13G5gl+/fD4X8WNRlCU
         ROVMut7HKD0qe2Whfm9L251sv/FLnrOtmwAY8H/43PsuojQv6e/smUd8lhB46lW+bDEo
         Z+6w==
X-Gm-Message-State: AOAM530kSfHOPZPLGsOLPwbFzvoRDVQLeFXGP2uBqWzrsxm7EjcsMO1X
        sPQEwSQtojCXDBSAnDhaOs2QkdOz
X-Google-Smtp-Source: ABdhPJxlfxni5l7PBT8l1RAIHHQwdAmZzb5Z+Xp6jHZIqF+BVeDJ9rksKdUxKM8TOae0PpD4oQhz5A==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr7931092wmh.96.1595422746344;
        Wed, 22 Jul 2020 05:59:06 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:05 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] audit: do not set FS_EVENT_ON_CHILD in audit marks mask
Date:   Wed, 22 Jul 2020 15:58:43 +0300
Message-Id: <20200722125849.17418-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The audit groups marks mask does not contain any events possible on
child,so setting the flag FS_EVENT_ON_CHILD in the mask is counter
productive.

It may lead to the undesired outcome of setting the dentry flag
DCACHE_FSNOTIFY_PARENT_WATCHED on a directory inode even though it is
not watching children, because the audit mark contribute the flag
FS_EVENT_ON_CHILD to the inode's fsnotify_mask and another mark could
be contributing an event that is possible on child to the inode's mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 kernel/audit_fsnotify.c | 2 +-
 kernel/audit_watch.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 30ca239285a3..bd3a6b79316a 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -36,7 +36,7 @@ static struct fsnotify_group *audit_fsnotify_group;
 
 /* fsnotify events we care about. */
 #define AUDIT_FS_EVENTS (FS_MOVE | FS_CREATE | FS_DELETE | FS_DELETE_SELF |\
-			 FS_MOVE_SELF | FS_EVENT_ON_CHILD)
+			 FS_MOVE_SELF)
 
 static void audit_fsnotify_mark_free(struct audit_fsnotify_mark *audit_mark)
 {
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 61fd601f1edf..e23d54bcc587 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -53,7 +53,7 @@ static struct fsnotify_group *audit_watch_group;
 
 /* fsnotify events we care about. */
 #define AUDIT_FS_WATCH (FS_MOVE | FS_CREATE | FS_DELETE | FS_DELETE_SELF |\
-			FS_MOVE_SELF | FS_EVENT_ON_CHILD | FS_UNMOUNT)
+			FS_MOVE_SELF | FS_UNMOUNT)
 
 static void audit_free_parent(struct audit_parent *parent)
 {
-- 
2.17.1

