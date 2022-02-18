Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214B4BBC3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 16:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiBRPdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 10:33:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiBRPdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:33:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 303032B2C4F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 07:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645198376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sUbPt0+M3tFg2selMU0RHNVFhnfbBV39GeSnzrCNho0=;
        b=HcYU7jXkePRWFCfqgN6UT8AhMG+9Spo6ehoTymUVIfapZBZyBUynxy2QglMozScvZ9hJaj
        p7WPc4G8zXNclLh9OpWmWv5rw+UYvBP411hNlq80MFG6jrMIPfuMBK43jJxUWJYHD2ClzU
        IJiRqFXdmMu9+o5dmUU1prZjOY/t2pc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-0yyh43b5OGKiP8dMxpX_WA-1; Fri, 18 Feb 2022 10:32:55 -0500
X-MC-Unique: 0yyh43b5OGKiP8dMxpX_WA-1
Received: by mail-ed1-f72.google.com with SMTP id m11-20020a056402430b00b00410678d119eso5689802edc.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 07:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUbPt0+M3tFg2selMU0RHNVFhnfbBV39GeSnzrCNho0=;
        b=FNpS/2cF4O7qvs33gGBzAMj8calYgbv3ZF+JAsbW3NSzAuIbldgjW0FcE7gHg7CplO
         0XVe7XHs/gldNy62ttI5igwBrLce1SqZd4DEmNM+NniQlORkoiIUP2fE3WbtB8/bS4kp
         V1jpagPGf5/C0AcXa9AsCnPGBRz5+7afyI92NP3zjRDpcMp4S3tyF18noshMQyFbaqz6
         RpdZ908S5yxObUbPh0qibKQOeXDWscLn2nyHjAtwqox6rSlYws7hdD36w6r/oI8ZjA1p
         2De6Fw15BH7OUnKKQSe3F+teCA37A9/TbbOXIwu2KfK8tOYgCmYBOqt65J9yKET5744+
         h+8w==
X-Gm-Message-State: AOAM533YZa2QYh/6EIBhrPkrTGWrlCFMTPMHx8vruznLkDK0ynbc3dV0
        Eb2+lMP789FcFrbplN4v6Xvkl5pULRxlnWhphf2OnlxiFtmayt7J2dnE4dl3ZYSiIqwF0wRohgO
        OSWObBdwe44BT6vTUJX1p5JE+/A==
X-Received: by 2002:a17:906:f18b:b0:6d0:4fa4:8c2d with SMTP id gs11-20020a170906f18b00b006d04fa48c2dmr6732741ejb.122.1645198373494;
        Fri, 18 Feb 2022 07:32:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCSqI0LFcuV/b37zRb4tpeNQeUebfYbvAvZ+Ee4ZGejKsUuff4vrv7aMLqe5Nti9K4AKWa9Q==
X-Received: by 2002:a17:906:f18b:b0:6d0:4fa4:8c2d with SMTP id gs11-20020a170906f18b00b006d04fa48c2dmr6732721ejb.122.1645198373242;
        Fri, 18 Feb 2022 07:32:53 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id v18sm2421035ejk.125.2022.02.18.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:32:52 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: fix link vs. rename race
Date:   Fri, 18 Feb 2022 16:32:49 +0100
Message-Id: <20220218153249.406028-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There has been a longstanding race condition between rename(2) and link(2),
when those operations are done in parallel:

1. Moving a file to an existing target file (eg. mv file target)
2. Creating a link from the target file to a third file (eg. ln target
   link)

By the time vfs_link() locks the target inode, it might already be unlinked
by rename.  This results in vfs_link() returning -ENOENT in order to
prevent linking to already unlinked files.  This check was introduced in
v2.6.39 by commit aae8a97d3ec3 ("fs: Don't allow to create hardlink for
deleted file").

This breaks apparent atomicity of rename(2), which is described in
standards and the man page:

    "If newpath already exists, it will be atomically replaced, so that
     there is no point at which another process attempting to access
     newpath will find it missing."

The simplest fix is to exclude renames for the complete link operation.

This patch introduces a global rw_semaphore that is locked for read in
rename and for write in link.  To prevent excessive contention, do not take
the lock in link on the first try.  If the source of the link was found to
be unlinked, then retry with the lock held.

Reproducer can be found at:

  https://lore.kernel.org/all/20220216131814.GA2463301@xavier-xps/

Reported-by: Xavier Roche <xavier.roche@algolia.com>
Link: https://lore.kernel.org/all/20220214210708.GA2167841@xavier-xps/
Fixes: aae8a97d3ec3 ("fs: Don't allow to create hardlink for deleted file")
Tested-by: Xavier Roche <xavier.roche@algolia.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namei.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..dd6908cee49d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -122,6 +122,8 @@
  * PATH_MAX includes the nul terminator --RR.
  */
 
+static DECLARE_RWSEM(link_rwsem);
+
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
 struct filename *
@@ -2961,6 +2963,8 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;
 
+	down_read(&link_rwsem);
+
 	if (p1 == p2) {
 		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
 		return NULL;
@@ -2995,6 +2999,8 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 		inode_unlock(p2->d_inode);
 		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
 	}
+
+	up_read(&link_rwsem);
 }
 EXPORT_SYMBOL(unlock_rename);
 
@@ -4456,6 +4462,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	struct path old_path, new_path;
 	struct inode *delegated_inode = NULL;
 	int how = 0;
+	bool lock = false;
 	int error;
 
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0) {
@@ -4474,10 +4481,13 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
+retry_lock:
+	if (lock)
+		down_write(&link_rwsem);
 retry:
 	error = filename_lookup(olddfd, old, how, &old_path, NULL);
 	if (error)
-		goto out_putnames;
+		goto out_unlock_link;
 
 	new_dentry = filename_create(newdfd, new, &new_path,
 					(how & LOOKUP_REVAL));
@@ -4511,8 +4521,16 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 		how |= LOOKUP_REVAL;
 		goto retry;
 	}
+	if (!lock && error == -ENOENT) {
+		path_put(&old_path);
+		lock = true;
+		goto retry_lock;
+	}
 out_putpath:
 	path_put(&old_path);
+out_unlock_link:
+	if (lock)
+		up_write(&link_rwsem);
 out_putnames:
 	putname(old);
 	putname(new);
-- 
2.34.1

