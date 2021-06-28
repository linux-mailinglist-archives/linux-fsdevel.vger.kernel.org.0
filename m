Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873903B5E25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhF1Mki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhF1Mki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:40:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978A9C061574;
        Mon, 28 Jun 2021 05:38:11 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v12so8851117plo.10;
        Mon, 28 Jun 2021 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WT6v9uHvNGHnkrWHqw+IXv7PjvRxi0xOsDaWugRiQFY=;
        b=QBNZk2FzsKVZFkEr2ZWCddj45xygaewHlKrtuogtrs9agXtqPkt9I87Pg8ePtRsK86
         4KEp6j8xcsOlWbj+fRie+VbcwEsfUlSm8Vsgl2GVEpbNYZ3XrfE8Q6a0TGPq5Yp6wmqt
         sp8FLOKmtRdqhCAdsdoRPhOzrf8mdLp3v+AG//g5HC9SKt6/KQQtnw9OCXOna1cHHdfm
         wahn2cLq5XCPwGdTgPwa5L/lzgSbnJq7Fs2dZUKPgxuN6DhvqHaWDS6t2UMfwFVkxEDy
         o31Lfac7whjlPs3ig1RDDBaBtd2O36KPpwfRPRrFIuS+enwfsX8ut6XBEwlQi1x3ZgMI
         XYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WT6v9uHvNGHnkrWHqw+IXv7PjvRxi0xOsDaWugRiQFY=;
        b=JMN4iFmCiB03MDfpjaIBklF44yuws6qIpmFgVTY/ukJfYA0B6wZemWg7D464/31s9H
         89eNE6JYPlGM1oQmFejW+tanQV+XWcLrwTSZKMRP5NzrtKZD18k/Im9Jvem2lcvZetxl
         1e94xnTNeMe4HXfZQ/ZgjdTBBfH+CUVR44siwi4ceSIHFzj1ppl4UtwMLot9W3dIgGjR
         5mUGwNyiqw610jfOPXX2XXdpbFdwvl93IUOXhD1fbi9umwGWkyG4LcTLEYYk0rQ4t3ey
         6QD0oXn+cG2c2En2flB+lJ2NC0uIbhPRfmP6cWmAUPgrx9JGVNp4k6+HPvTYf+GY4f39
         Re9w==
X-Gm-Message-State: AOAM530iI/+4S2nVZwpEdSijqEDptSVAKAMtSk0ik5MwA08KTuYKrSbz
        X0xZoRjPBFsq5DouxbYmkGVF6axrB8/4mFFU
X-Google-Smtp-Source: ABdhPJzdkVuvbX+deaYXYvXccVsMs9GcFLfmgAKhU2DOdgfJq1F9YYoem/FHmnOSftHIvwN94oL18A==
X-Received: by 2002:a17:90a:fd11:: with SMTP id cv17mr5786896pjb.8.1624883890837;
        Mon, 28 Jun 2021 05:38:10 -0700 (PDT)
Received: from localhost.localdomain ([36.62.198.29])
        by smtp.gmail.com with ESMTPSA id gl17sm2822835pjb.13.2021.06.28.05.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:38:10 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, wangshilong1991@gmail.com
Subject: [PATCH v2] fs: forbid invalid project ID
Date:   Mon, 28 Jun 2021 08:38:01 -0400
Message-Id: <20210628123801.3511-1-wangshilong1991@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fileattr_set_prepare() should check if project ID
is valid, otherwise dqget() will return NULL for
such project ID quota.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v1->v2: try to fix in the VFS
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1e2204fa9963..5db5b218637b 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -845,6 +845,9 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (fa->fsx_cowextsize == 0)
 		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
 
+	if (!projid_valid(KPROJIDT_INIT(fa->fsx_projid)))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.27.0

