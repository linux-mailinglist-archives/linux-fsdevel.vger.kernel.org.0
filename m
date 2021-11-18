Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C729245536D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 04:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbhKRDfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 22:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbhKRDe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 22:34:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94100C061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 19:31:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso4391907pjb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 19:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dy5ISnOF/LIcctiWr3MH3NHofWp1uRrjBKff/ka6Zc=;
        b=aGmGGQOxst5fIKIjui3eUz3WCTqAi6HUHqYW4+Mkd7gokRKpIA7ifvUDmL4guTQidL
         hsVTfBIcwqs+Uljcb56XrdCAH7m+FuEV2wrGwSEyaK5/ZCbf1B3WTvUYu0hskELk+PDR
         nqlYjYHZwVfUkuRRTefU3Rh2rdHab5a0qf1lMrW6s+XbXESvCL9lqPJoeWcBxEIdkh88
         ZVmch9jwosVyww323FuXkrRXjp+Ok3XuKabIYx/ZxrEP3R5o9b0vW9/Rp5ndGkEqxina
         7rs9HbEBdV2+EgYOVpu0AKJUUPqxqrL0AzzGjpiCZ3m5NHfEIeB0Q+rHi3MnJI1MSYWR
         mtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dy5ISnOF/LIcctiWr3MH3NHofWp1uRrjBKff/ka6Zc=;
        b=sxnpYTq1r1Rw0jusMTqVOyaQCnKKTYH1cacOjIsKXtxA2iz8MrizVprb9ly2TIXnIJ
         oHzJbDwqj/uJ70gbdwKEJH/Zy2qTHsqiG25c9aRNGN/tt/5EfuEL6kX0hCWBbyHIAOcY
         VFI9g10y55WLo5DQBEvI8WOVKBQMcARZCavF+Q0/ALXNBwiGR66O4750rIJxdl/DPPe2
         M3aXSvTz7T3ouxoBp8rDP25dpuopGcXJTUkJg+h2e0XOlGQbHJBTSdmMI7E3O8sIEy8f
         NlbIaVQp2I1V+gyeEYqvQA/JIkten2c2msnN8o0vSubq9aGIkoVwLtVrYK/M7fJELAK0
         I1Kw==
X-Gm-Message-State: AOAM533TESDBoqCVDB0alrzxG0NveoGUfbafJzwallazS5PzzwYm84Dv
        vNKcccaz1F9bZkWSZ12qOXgRFkLvcxLiNA==
X-Google-Smtp-Source: ABdhPJwiKH6w+IyY6+8jlCqxMsMdgFeYQsuTj5BxLT5PAoExxKBv0yjMf+bkIteraaGpp7/r7Iyujw==
X-Received: by 2002:a17:90b:3d3:: with SMTP id go19mr6343846pjb.23.1637206319192;
        Wed, 17 Nov 2021 19:31:59 -0800 (PST)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id 130sm1054217pfu.170.2021.11.17.19.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Nov 2021 19:31:58 -0800 (PST)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH]  fuse: unnecessary fsync for read-only mounts
Date:   Thu, 18 Nov 2021 11:31:22 +0800
Message-Id: <20211118033122.88017-1-flyingpeng@tencent.com>
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

