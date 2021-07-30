Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC73DBFDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhG3UeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhG3UeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:34:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93900C06175F;
        Fri, 30 Jul 2021 13:33:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b13so1949258wrs.3;
        Fri, 30 Jul 2021 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qkobvq7Hd4pPLqJEaL5Fbrn7pZXWscENjpBzNmq2/mY=;
        b=jmVDSA9r24qbJ1fGGbG42y/SbrixWvSS96TgLpZRMNqB/zKs0WW1eD2sJZvcPdxKr9
         DswXy3NGiw0NVlGOPMonarwsE/rVoGfKIJp84GB9q7WWQmIr+YIsmMtxnYltk9iehZDO
         lPJsWP5eGolJ1H9fkCheFqW6EOAA0HEH5caa/dYc9ssbJZ8XvZCIhtkZFXsRJ0Tcm17R
         TqqxUoDUjh0jV5JMVRb/ZwfRH0IJ+nYr6bikKvR9L5iyBrv1BodIJmcttLX76XFCNSiS
         6qdaKyzMSp/8dTndu9y3Gu2PZBXKHx5WoL8wPJZbO04CkSIK9vo5kqq6JVVf4auQ3Rk7
         Yh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qkobvq7Hd4pPLqJEaL5Fbrn7pZXWscENjpBzNmq2/mY=;
        b=LPDgqXJWh86Ko4filsCE1og35Sp92N7svyaPAoL4U9cLGpO9C9kFffmBdumzo47c9G
         O4det2FjWhuXg8zLIQpJjb5Gx2MzSCCkRCmzq906aNK1jLLxnKhYezW/t1htynS7jkHb
         sVVcKphgrsbmi8UQLN7+uNe7fYRCQlc9rdVkUilfhAiaOXW3QhrselapMQFhG8SNNtSu
         TAk2tRSvjSp8x9sU0OhZ7FRDYrDsIrvsL2Dg7wtIlV80Fl69kHT9/9I3/vlQa/nKnpkK
         k7w03svVoB5H/Cvvp4nmSNfBjjyxsz2HdnTHJ1UQGjyYU9ndg3n5NwO5TFsvxTqmehkb
         hxzQ==
X-Gm-Message-State: AOAM530CRhYHLqMWwmPIUpw/gLlPX2vIJrT/TFfsyoeHcxV2H/CXA5NL
        9G4pVYiCBTa27IR9uq3Tell4MOqcjBI=
X-Google-Smtp-Source: ABdhPJw8HF/cjS5VndssudRxX31dvWq9yzgzLYEppF9rZCk2YI6wkjvUk29q5DGlqD90A30NO1Qe4Q==
X-Received: by 2002:adf:e507:: with SMTP id j7mr5194675wrm.113.1627677234231;
        Fri, 30 Jul 2021 13:33:54 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id b20sm114161wmj.48.2021.07.30.13.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 13:33:53 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     arnd@arndb.de, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH] fs: block: reduce the stack footprint by using the %pg printk specifier
Date:   Fri, 30 Jul 2021 22:32:05 +0200
Message-Id: <20210730203205.23875-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reduced the stack footprint by using the %pg printk specifier.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
 fs/block_dev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6658f40ae492..765b3a9b328c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -64,10 +64,9 @@ static void bdev_write_inode(struct block_device *bdev)
 		spin_unlock(&inode->i_lock);
 		ret = write_inode_now(inode, true);
 		if (ret) {
-			char name[BDEVNAME_SIZE];
 			pr_warn_ratelimited("VFS: Dirty inode writeback failed "
-					    "for block device %s (err=%d).\n",
-					    bdevname(bdev, name), ret);
+					    "for block device %pg (err=%d).\n",
+					    bdev, ret);
 		}
 		spin_lock(&inode->i_lock);
 	}
-- 
2.29.0.rc1.dirty

