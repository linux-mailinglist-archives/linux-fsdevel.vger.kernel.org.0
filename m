Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF57179E47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfG3BvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:51:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39280 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbfG3Bui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so28260864pls.6;
        Mon, 29 Jul 2019 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vRAjF3ngnOVHXNvH9bSrKw90+Pov0J0fPixsHFf+DcE=;
        b=ofUSxfq0NNCSkunC42cARiexTJOCOAZOomxJZm4Gp0xxxyQkU53RfdiYnHVHkcT2ne
         J89UJangegGrtLCIKPd5OMejojIN3HQvLj8YU6WLHj9xwxJOpiZ9v/X8p61RsuUxuoUt
         izdj5rMkVHtk4xFKeiqcAAypx6QKLtKZUjRKUzwaoXO5UQKC0xlzVewiQmz7wHsuU9ZV
         kQGf6DyNv2LRnwXHg+D+mwr75WTAZSi6iE2QXN842Kjhr6Zl4PH0UU2DetlDSMD7sAY4
         VLXDg6awV8iGek2QLKzgMhjuwt5Q4F1Lbtxuzv1OT3JKwwAfWlASLPgWOGVMdFnLd8NU
         vVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vRAjF3ngnOVHXNvH9bSrKw90+Pov0J0fPixsHFf+DcE=;
        b=uLqxFj3KlWFGthO/tKhGldMqUBAnMs7SNTfv1XcCznfWpPwO6Wk0geLiUTVCwwRBsP
         ylz0BS/5XAodWkwe42LxlfyPdTzb9Q/iBmiN2TO2VVXexoT4YxdjRLzfgyL8710KoUEH
         fOk5FxySK57o9Hjymu07oGMT8ZgwDPxYdN9FPpISb982ErryNcDduCwwRH2CNAtEdk1Y
         U3PM9zFtNA/A3dJVltRSdyKFCxw3GGlzkAFbQVkR3DU6eG0mbARYouZnn92aW/aI76Vz
         VYBZXGIQPHWAkc0vwy72Q/oS6+gO38Ju++xfHVeUgGbfU3e29Y1Kv4tdvFJ2D7hcB2PC
         uP/w==
X-Gm-Message-State: APjAAAV12VzW3cVx2rRU0jhgbxfJPlQZ5UewQ/9ja93gWuuVb1Kc8YN1
        sOjMYT2jxKd2/LN9apC1RmQ=
X-Google-Smtp-Source: APXvYqz7D6pDOWc0L3BqSTp+/0hcx3918pfbY+fYng6mc3GNhPDrGfd1ne1TSDjxNaep1J5KAeDX7A==
X-Received: by 2002:a17:902:ff05:: with SMTP id f5mr109207646plj.116.1564451437936;
        Mon, 29 Jul 2019 18:50:37 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:37 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, mikulas@artax.karlin.mff.cuni.cz
Subject: [PATCH 17/20] fs: hpfs: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:21 -0700
Message-Id: <20190730014924.2193-18-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
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

