Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46C91825
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfHRRAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38345 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfHRRAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:00:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so5724800pfg.5;
        Sun, 18 Aug 2019 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vRAjF3ngnOVHXNvH9bSrKw90+Pov0J0fPixsHFf+DcE=;
        b=jZjJ6zS+ULCgVMeHvDCf3yU13Ae3QSfVl/zvJ/2eHjA8kLF9bQNf7JvTz/+hZ32HUy
         wwAXN8raBp0z94UCaXzJTCqVwa3fCMwb9ayUJ2msB37464FHIzljIU48spnNf9REpiVY
         9uVoNAPH0OBHPw7KlQA1Up26mukmknakJneUIhI/3F/xCwVpjqhZSOyP2V2Coe0/X1wY
         HIyZnLfASnAhl3O61I6vx6bafabaXCWwrdSjfOU1uGfeJDPU44yvkzAO/Vq8M8jP1Z/8
         cUKEzS2Rz8d5zgIYVZ+TaP0C3VZUmaNX0uXIGns1H4iBy4GR6gVHMYWxatXWcug9Ukq9
         JDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vRAjF3ngnOVHXNvH9bSrKw90+Pov0J0fPixsHFf+DcE=;
        b=Y/2oCxFj3a1locjHK3qEYm1SagigZ/ZD9j7O2o5YMrqx/PYNNZK2wOBgjFh8ueT4zE
         wj9hMzUaW0cAbS5WobYLxX1U1cj6F7W5/6zW+Jo8kpVgyqeFOkYHfpug2JRv5PFlVxrz
         3mxxkIYwgQRCfTc7zyqqhoh90lXHcBZTrAhM3YMoaQH/VrEAcyCTmYw++qTuf1anRaxq
         xnOAB2L4VxcHsLQLXcadRWLaoZ0aCovV1++T2BPVmRReA6wbFi1dlZcZIPPW5j1xzwGg
         IrlzBe/BFjG3Z2u85IXMEzNop7PDx523YFeuDiM8FsyRtnI2SP7VXneMoPjm43vOvD3q
         jz/w==
X-Gm-Message-State: APjAAAVILT4m2EKC82kYbk477v/WX/6Ge89ILBwX+2UdLX75xhYNOswB
        K63PlOYlsSJYki85iZKitPYM7W6F
X-Google-Smtp-Source: APXvYqzBbzIf1WjL+vgTd3SN1/9RA4tXcLk9JxU7E8lP/B3k/UqoQUrEA68hdqfsMXcmRqL++75ixA==
X-Received: by 2002:a17:90a:630a:: with SMTP id e10mr6112550pjj.25.1566147604015;
        Sun, 18 Aug 2019 10:00:04 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 10:00:03 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, mikulas@artax.karlin.mff.cuni.cz
Subject: [PATCH v8 17/20] fs: hpfs: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:14 -0700
Message-Id: <20190818165817.32634-18-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Also change the local_to_gmt() to use time64_t instead
of time32_t.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: mikulas@artax.karlin.mff.cuni.cz
---
 fs/hpfs/hpfs_fn.h | 6 ++----
 fs/hpfs/super.c   | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index ab2e7cc2ff33..1cca83218fb5 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -334,7 +334,7 @@ long hpfs_ioctl(struct file *file, unsigned cmd, unsigned long arg);
  * local time (HPFS) to GMT (Unix)
  */
 
-static inline time64_t local_to_gmt(struct super_block *s, time32_t t)
+static inline time64_t local_to_gmt(struct super_block *s, time64_t t)
 {
 	extern struct timezone sys_tz;
 	return t + sys_tz.tz_minuteswest * 60 + hpfs_sb(s)->sb_timeshift;
@@ -343,9 +343,7 @@ static inline time64_t local_to_gmt(struct super_block *s, time32_t t)
 static inline time32_t gmt_to_local(struct super_block *s, time64_t t)
 {
 	extern struct timezone sys_tz;
-	t = t - sys_tz.tz_minuteswest * 60 - hpfs_sb(s)->sb_timeshift;
-
-	return clamp_t(time64_t, t, 0, U32_MAX);
+	return t - sys_tz.tz_minuteswest * 60 - hpfs_sb(s)->sb_timeshift;
 }
 
 static inline time32_t local_get_seconds(struct super_block *s)
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 9db6d84f0d62..0a677a9aaf34 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -614,6 +614,8 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 	s->s_magic = HPFS_SUPER_MAGIC;
 	s->s_op = &hpfs_sops;
 	s->s_d_op = &hpfs_dentry_operations;
+	s->s_time_min =  local_to_gmt(s, 0);
+	s->s_time_max =  local_to_gmt(s, U32_MAX);
 
 	sbi->sb_root = le32_to_cpu(superblock->root);
 	sbi->sb_fs_size = le32_to_cpu(superblock->n_sectors);
-- 
2.17.1

