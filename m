Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAC79E3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfG3Buh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40770 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfG3Bug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so28939008pfp.7;
        Mon, 29 Jul 2019 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yus3UESewstQeP6xBqn0c8tU9AnJsLA523aHx91as5s=;
        b=SEiA+6DXUY8nU4JxxRcvILAhfCyQ812nRVCkzqt6XOkyQhJUxSD9nZOCDqD09aXxnP
         8R9W+2OaX65xIoHL7hc89glmAE+6JmpxEhamDtnMtuxBqI41Ve4dY8vwevEuvYidaP5H
         dVdhr9c2V45rbKJF8LjovcLCNUc8ix+/hS+hN8isukEoIIjSR6KxuQvBwB/pOAOQa7g7
         kypBuCvFNYFZV8nOxcjFPButxRxD4V3m/kwIF0gdHPMDjcCD+eluBD7penp75YA/GaeC
         3fTE8s3nUCTR/b403KpScgWpdbP11kRswyt/ElBYo5dd1JjF8qR7vzPU4iPwKETBehhK
         nsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yus3UESewstQeP6xBqn0c8tU9AnJsLA523aHx91as5s=;
        b=OW1o94OoznGeDYbHFbc5NU0/wbNt7hYTuZGRryDjiinG5P0Uw+h4qnJ09f6JBGS/sS
         /UqPfoGYNsOlCrToU6VnUg5nhMGV2bUjZq2qZLNqrYPPcJwxkSnIa3wrMmBbnx1701+0
         x8GOVRDp9fi8T+ku5njVkpHJoCliOU1nwVX0dTj38LyKpk9MTpfynLSSB09Q3WdxWlqQ
         GqRO69RN/uu7JRQg+eSTAPPd1DsHU8VhYQE6m5jp4aBJEstHoOeJ1eZWoUDoSwCdioRB
         Zom5FQz1Uj5/bSlXAePctzhxMAKBvzbrWFuuzCja9SavJC8c90UBlY967Rf6BjHMan6K
         3YfQ==
X-Gm-Message-State: APjAAAWaY3CfyUfnc+E/a91bShwRWttqaBvN4AJVw7FRzCLLXnx8Oe7a
        F2XVUZKTK0YvMlghHIszK8M=
X-Google-Smtp-Source: APXvYqy5JQbCWDUYQpBFr2nhGCvc2pEAyEn23IjvOJzC/OFOcCnF/y/pvQmApBMVM5vLDLwlxUTQbA==
X-Received: by 2002:a62:27c2:: with SMTP id n185mr30133871pfn.79.1564451435056;
        Mon, 29 Jul 2019 18:50:35 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:34 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, hch@infradead.org
Subject: [PATCH 14/20] fs: sysv: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:18 -0700
Message-Id: <20190730014924.2193-15-deepa.kernel@gmail.com>
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

