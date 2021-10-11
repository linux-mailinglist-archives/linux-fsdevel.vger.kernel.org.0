Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8742895F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhJKJJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhJKJJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:09:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99660C061570
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 02:07:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 133so10236176pgb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/BS1KLWHU3eexYt4d9sALzr3TgXzB88anOg00tKazI=;
        b=N+K8DV1xsD7rJlAU14Hc28V7mPt3jQDARsEYP9trBHnKcHwn/fkiOMPUJwah1sXtHz
         yNx5L9Z634pbiu8E+rCbFq6xeHXcGqmAZqtDDw6VdGLLadEaXaR018KmcXhIbtznVeAC
         QxJlk2eeDy5M8KK7+0xuqCxK8oc9qqltFFQ7Ti9pQ71KICtvfv8Y/k0dOnPcmkWtVnmo
         KyffMirHhv2cCMVGa5ScV+zrrckLfpm9KI4Y/+jhK551Oh2d+fC8U6heSyDMaNvbaBuf
         d4ssvWJRMmsmQbSaYazeeRn8Nv8Q/K50qjEqg8oBjJCF6bR/9fTjMdwgRh9RZIGHoLp3
         tBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/BS1KLWHU3eexYt4d9sALzr3TgXzB88anOg00tKazI=;
        b=6ighc/FrCeXd1eT073Wn19J5Lj69yqJMwzeooJ3NQjIR79WsUJWMj7MrPfbkllVtTY
         +oJ6mMT//WkikEIaVF0oJpO9QD7+tC/5voGJ3qBc0G7B3DIxYoycImVftXymw/SPDNbe
         dJL1NMo4Dced5zPSYO2W6LGBM8e6hz6UawbcO/vKuvQyvL8YLxzEx/sHU2lduV4aiUiD
         jnJ+wqcahECdDCrOXb0t/0PPiHb8qN9MpNokW8VhEbhBjhy426YK+/FE4pRXEubeyShf
         m09uwTzfTOOwCt9Tb/oYJWssiOKKQLMLSQ9Bj9LllaAg1vl1QxRLIu1CDpa3wfF6HVq2
         cYWg==
X-Gm-Message-State: AOAM533BQiJIrlR+q34Z8OGkO/FMqnI64znkecmeJJXUTeO4+XXhCbyE
        cMvz2akGIGkuk88S0RLYoWJ371oD51nV
X-Google-Smtp-Source: ABdhPJwn4B3ZXApbyaxwBZSymbZmyd2O0TLjvrtdYTHQ1cGo2p1JeYfrmiUkp6VWMJ3PFJCrG2WD/A==
X-Received: by 2002:a05:6a00:1748:b0:44c:ca52:b261 with SMTP id j8-20020a056a00174800b0044cca52b261mr22153628pfc.17.1633943236043;
        Mon, 11 Oct 2021 02:07:16 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id p4sm7252503pgc.15.2021.10.11.02.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:07:15 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, zhangjiachen.jaycee@bytedance.com
Subject: [RFC] fuse: Avoid invalidating attrs if writeback_cache enabled
Date:   Mon, 11 Oct 2021 17:02:40 +0800
Message-Id: <20211011090240.97-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently we found the performance of small direct writes is bad
when writeback_cache enabled. This is because we need to get
attrs from userspace in fuse_update_get_attr() on each write.
The timeout for the attributes doesn't work since every direct write
will invalidate the attrs in fuse_direct_IO().

To fix it, this patch tries to avoid invalidating attrs if writeback_cache
is enabled since we should trust local size/ctime/mtime in this case.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/fuse/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 11404f8c21c7..5561d4cc735c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2868,8 +2868,11 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	if (iov_iter_rw(iter) == WRITE) {
+		struct fuse_conn *fc = get_fuse_conn(inode);
+
 		ret = fuse_direct_io(io, iter, &pos, FUSE_DIO_WRITE);
-		fuse_invalidate_attr(inode);
+		if (!fc->writeback_cache)
+			fuse_invalidate_attr(inode);
 	} else {
 		ret = __fuse_direct_read(io, iter, &pos);
 	}
-- 
2.11.0

