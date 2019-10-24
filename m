Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5374E3719
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503336AbfJXPyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:25 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54412 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409835AbfJXPyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:24 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsNg5026823
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:23 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsIgd021338
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:23 -0400
Received: by mail-qk1-f200.google.com with SMTP id z136so7386749qkb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zUGAOh/GAteO6zvZvvY5cTNeZU5s4fMdWwFbCvuXq0c=;
        b=gX5nUfQ0WBFSUsylDASpNo8Xcmdl9S3AFFWLnx1lmtKRnRXlzRthz0ZHBV3EPde4Ts
         8IYvbgdBb0LRNHQH0uKU6nZfrxlYC+2eR5lEW6qRfOxANkQiedxpoYs7bx+/HxM9HwbJ
         LpFboYm1HXRvUAluyDn9qT4nQJjBZLNjO/c1Uv/6bYNXB4/hWITiEKGzc2HUqv+r01Zh
         3RGo2bkiFf8cMpn9PR/JeNhZKJiGd3wrzim00j8F4BfgrpxOkjZLlgsgKeXQXhhQs/9z
         +QS208kCwPPlVlr66T49Vu7FGRe6PpLQeoD61MSHFHK/6wf/fg5TTSoC9Raw21NPE2Fd
         QSRg==
X-Gm-Message-State: APjAAAUAraaPIatw6dUTIxEROTHxyLRQkic8gcvIPqTw5LAmMzuhxpzH
        5vCjkqT7jr3oKfc/nREn3g2bPloKRSp5BuWATLk7fYIFJY1mAzx0rvqqi0nulHb8T6qX85BKAMU
        5oKfXqUOjdGc8Yc3d4VbHcxyCzwpJogUoRpcB
X-Received: by 2002:a05:620a:2144:: with SMTP id m4mr3441282qkm.226.1571932457888;
        Thu, 24 Oct 2019 08:54:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbLMNY04ECnlnj33HTLJXy7DWyauisrTQfb1G5d+sgpaJQG7/tZjo3ugMJbOpSBCXQtPufYQ==
X-Received: by 2002:a05:620a:2144:: with SMTP id m4mr3441251qkm.226.1571932457601;
        Thu, 24 Oct 2019 08:54:17 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:16 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] staging: exfat: Clean up return codes - FFS_NAMETOOLONG
Date:   Thu, 24 Oct 2019 11:53:16 -0400
Message-Id: <20191024155327.1095907-6-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_NOTNAMETOOLONG to -ENAMETOOLONG

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 1 -
 drivers/staging/exfat/exfat_super.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 86bdcf222a5a..a2b865788697 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -221,7 +221,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
 #define FFS_MEMORYERR           17
-#define FFS_NAMETOOLONG		18
 #define FFS_ERROR               19
 
 #define NUM_UPCASE              2918
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index fd5d8ba0d8bc..eb3c3642abca 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2362,7 +2362,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 			err = -EEXIST;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
-		else if (err == FFS_NAMETOOLONG)
+		else if (err == -ENAMETOOLONG)
 			err = -ENAMETOOLONG;
 		else
 			err = -EIO;
@@ -2643,7 +2643,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 			err = -EEXIST;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
-		else if (err == FFS_NAMETOOLONG)
+		else if (err == -ENAMETOOLONG)
 			err = -ENAMETOOLONG;
 		else
 			err = -EIO;
-- 
2.23.0

