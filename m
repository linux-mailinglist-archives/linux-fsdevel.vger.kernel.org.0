Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C914291822
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfHRRAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46179 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfHRRAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:00:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so5701093pfc.13;
        Sun, 18 Aug 2019 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yus3UESewstQeP6xBqn0c8tU9AnJsLA523aHx91as5s=;
        b=bzG6Ys9MB8EB/SIiNm1O90+0fRmj7AmkXhOlkEZgA2BAesZ0uHBfgMNz1jtKbxVp5g
         36SUBW4JMGzSQyQjYdgSOqYzYlxv+uWeVoEAIG5gmgaPI6uutfmBTGB1pA/qbbuDTfXV
         qKNJ+Fb9016L1xeg3QvFgCIFy4yem+zUSAIbQVVTODOmPQsawouPuRi8aEP5aRVcLDrE
         b3zfL9hDv0DWcJ7p87GiuOFWR86S3tfcu90wsAbuspJa3ux6zdJ6hD75QxDfS//tp3vZ
         RALHTIESSx3hRb/bvcBpZRUNAeq4zz6RqzNLmat+LatBMu+wpsW6a9XtC+pwY3E1N1tK
         FAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yus3UESewstQeP6xBqn0c8tU9AnJsLA523aHx91as5s=;
        b=OJopcZIUkGZQDjNcKceVvTlDNh49d5Kako87RQLXoqLyDIAcKGGhFJLb0r7bjXEzwU
         cqBjOLhdYZ0RCoEn5wv+gp350dzvIvsk1jVDfJJsVkK4+vNWdVcEWcOQbNd+5UvWDqBd
         4pJ774xG/Og7RCFXLC99kiCExMGcm8taCTBSMk10LQKnsbD1h7XMugaiHFYgwkduQ79x
         28ZVIbOyHO5BgayhmZT7Ztk9DdFmSxjI5sSr1t7BDo4OEp6x1vmtq/UMtFh+zuTjCV1F
         0iT17fdwcPfvPg7Dm731J+9Iau0w/KE8uo8u3ls0ELCMBNkeoI1Qm5dNhOfkvOfHKCSc
         1HuQ==
X-Gm-Message-State: APjAAAWqdw+BhSKxVEPu7TJu/xK+XCN1TN5dyGLBv8D1W5babWV45ySp
        Ua/Li7lqxgIV8+00s0QE6Rc=
X-Google-Smtp-Source: APXvYqy2w/ZWdNv7hvowG949tJNK2klBSLXYvs+QyMD1FHMvXxFsOirfLmDtgTaoEtpWAfTbN8Aj6g==
X-Received: by 2002:a65:6415:: with SMTP id a21mr15511088pgv.98.1566147600079;
        Sun, 18 Aug 2019 10:00:00 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:59 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, hch@infradead.org
Subject: [PATCH v8 14/20] fs: sysv: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:11 -0700
Message-Id: <20190818165817.32634-15-deepa.kernel@gmail.com>
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

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: hch@infradead.org
---
 fs/sysv/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index d788b1daa7eb..cc8e2ed155c8 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -368,7 +368,8 @@ static int sysv_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_block_base = 0;
 	mutex_init(&sbi->s_lock);
 	sb->s_fs_info = sbi;
-
+	sb->s_time_min = 0;
+	sb->s_time_max = U32_MAX;
 	sb_set_blocksize(sb, BLOCK_SIZE);
 
 	for (i = 0; i < ARRAY_SIZE(flavours) && !size; i++) {
@@ -487,6 +488,8 @@ static int v7_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_type = FSTYPE_V7;
 	mutex_init(&sbi->s_lock);
 	sb->s_fs_info = sbi;
+	sb->s_time_min = 0;
+	sb->s_time_max = U32_MAX;
 	
 	sb_set_blocksize(sb, 512);
 
-- 
2.17.1

