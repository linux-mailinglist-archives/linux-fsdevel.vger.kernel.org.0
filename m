Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3430460CC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 03:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbhK2CoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Nov 2021 21:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhK2CmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Nov 2021 21:42:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6EC061748
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Nov 2021 18:39:05 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id r130so15272882pfc.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Nov 2021 18:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dy5ISnOF/LIcctiWr3MH3NHofWp1uRrjBKff/ka6Zc=;
        b=fa4/ZvhIj31gY07iA+3gaWKU5ttQmbix1nWvC5EXbm7pnt33D4VpgWI3oTEZRJrotM
         2WaihnXXe5FZKb8ErwlDBFrSVKFgfpIZ0uDLUIqQFPMIE+NnwKluj0cipkg4xeBnKQ8x
         gF9Mo5VfsgJBvR02T9MByrWU3Oq+JFVZOIRFiq3Hir2QaOTnVtTA1SEuaU3HHX8VZbVV
         H2C5RPhptzpggkDJCaXRnXQD+9aPqRqNqr2A55q2ddRUQNF95XGgp27lBrQZYqDM4caT
         xUk3V3Tq6FltlDlYDNLC3/7CwFmfv7EAhvOQx2ndDMzXifTBIk3DXhV7hXdgSvDbEpN9
         W+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dy5ISnOF/LIcctiWr3MH3NHofWp1uRrjBKff/ka6Zc=;
        b=HIheGc/SIMcmpZr1B6xxzaDjA0wMdx3uG0LZuN0iQL30yHBLPVw1iL5KgIP+Bqn7De
         ForBAqcqxqS13UOz5Axkn4JuFdF9GfI2IPBFKgOxq5+ek1/tNjhMttg9LGLSZ+4lPym4
         bdmcDYrzcV40suqFoUCGWrZfaeESYkrAUahz24brCElX8DPBewRSntMKmO8ime5GWpCm
         QMBcuZDRdqwPRq/JU2CdZoCRynIuki/e4eU9EaWSvPR9VOOYdJ8ucYyImtEHKo67ptks
         4rNL8XytpTN4RGowCoGL0JQSkLZQ0rQ0h8ppNzhvZiRDq6so1Z+Vg9jUCKpeOUYTJnIp
         JYaA==
X-Gm-Message-State: AOAM533Ayv2SvE74kPzCqm2rCCDwiwkv7fee7Kyv0ZqINVdcof27AO/s
        PpyFL6JWWrGoBMVIJem+H64=
X-Google-Smtp-Source: ABdhPJzwSqWZrYVh4+0vMgPwGWSlph9rdobdsTGeMAHmepDpUCrMZHt+cuoKrh1mgqUY6HnZEjWDFg==
X-Received: by 2002:a62:dd54:0:b0:4a2:93f7:c20a with SMTP id w81-20020a62dd54000000b004a293f7c20amr36177794pff.46.1638153545006;
        Sun, 28 Nov 2021 18:39:05 -0800 (PST)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id j7sm15531449pfc.74.2021.11.28.18.39.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Nov 2021 18:39:04 -0800 (PST)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH]  fuse: unnecessary fsync for read-only mounts
Date:   Mon, 29 Nov 2021 10:38:25 +0800
Message-Id: <20211129023825.45891-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

File/directory fsync is not necessary for read-only mounts.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/fuse/dir.c  | 3 +++
 fs/fuse/file.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921f3506..1d4fed556c93 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1448,6 +1448,9 @@ static int fuse_dir_fsync(struct file *file, loff_t start, loff_t end,
 	if (fc->no_fsyncdir)
 		return 0;
 
+        if (sb_rdonly(inode->i_sb))
+                return 0;
+
 	inode_lock(inode);
 	err = fuse_fsync_common(file, start, end, datasync, FUSE_FSYNCDIR);
 	if (err == -ENOSYS) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d6c5f6361f7..18668fc00c3b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -550,6 +550,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 
 	if (fuse_is_bad(inode))
 		return -EIO;
+	if (sb_rdonly(inode->i_sb))
+		return 0;
 
 	inode_lock(inode);
 
-- 
2.27.0

