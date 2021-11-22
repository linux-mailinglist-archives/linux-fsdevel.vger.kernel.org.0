Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB09458B0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 10:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbhKVJKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 04:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbhKVJKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:10:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C59C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 01:07:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso14788090pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 01:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHzk4hkj4PeRgDHzcs4O/TMu1fu4teuasWWYIuJwtxs=;
        b=u2stvX/mOb5xLAWkH6XPOyCJu0P++JrHLUoaCs9ceIZcXeC0dIPgiTvWgute+ztGyl
         Lpc+MSyL10zAhsnftUu7CF5rwS1twzLgQBJ+vfK0Ms4S/3xOaV0BsxhR9YABVaz4seBX
         3wbXXXGj4cGlkjaUTDPgAv+yTg8sqBP2B/F5v0W9RPcV6dJnUf/UjURI89E45wfq73au
         OtWl4CbHpKsxMOfiya3NvUEUAosLX29aAh5bVBuIK2dI/7ZqpVI5suikGdIs/bTDIWcl
         KLk74WTjKLe2UmEJd15iGdpO9KuNS2RWLmenM4GUU6x8wUVr4cvo7yeHMXwiLJB+NOfg
         qyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHzk4hkj4PeRgDHzcs4O/TMu1fu4teuasWWYIuJwtxs=;
        b=BRZInFCX9HQPUDJ8MKL3FHiSodZ2LCHyCa3u6K0azZPsEzBIQdajd5paBnKM/Cph/C
         ZN6y+07baAI0rBbt4bsj0nwOFwTAVpwg4LyMYE+Ac82wbXjjxdmILj/2XyKTQYYwJz/M
         ocqvw46FinRVhOONNuGKmYdCi/mNPSRIHOiVYFl/u54aNpoCJLusEmZgQD9rizRNVVhr
         DWe9VqikTPtVhs+I/Ou1mwhHB13xEysJGrscqgPVmdvshjsK30O3QhntfSj4YZGHxEWB
         ngBQxPyHCPOAgDG7Z3cF92kZ3mnHwINFewR6MMX704vFRC/XvHGhs9c7fLS9lfD4gvVy
         zilA==
X-Gm-Message-State: AOAM531UJeRPrZynLjOph43wFvI/vDehBV9aPrh8099b+lRsrOMB9A/T
        ynCG604ilxtI9IPbt0gGWZarxIgtu+8+
X-Google-Smtp-Source: ABdhPJzA1WGI+fvicf8ocAD7yrMYlT5+v+JY4JaYHJYi0wYA/3aMIFg7HHXpsFFCjSg2X/8q8hE1QA==
X-Received: by 2002:a17:902:b94b:b0:143:d3bc:9d83 with SMTP id h11-20020a170902b94b00b00143d3bc9d83mr62573803pls.6.1637572036521;
        Mon, 22 Nov 2021 01:07:16 -0800 (PST)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id d12sm5663031pgf.19.2021.11.22.01.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 01:07:16 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: Pass correct lend value to filemap_write_and_wait_range()
Date:   Mon, 22 Nov 2021 17:05:31 +0800
Message-Id: <20211122090531.91-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The acceptable maximum value of lend parameter in
filemap_write_and_wait_range() is LLONG_MAX rather
than -1. And there is also some logic depending on
LLONG_MAX check in write_cache_pages(). So let's
pass LLONG_MAX to filemap_write_and_wait_range()
in fuse_writeback_range() instead.

Fixes: 59bda8ecee2f ("fuse: flush extending writes")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d6c5f6361f7..df81768c81a7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2910,7 +2910,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static int fuse_writeback_range(struct inode *inode, loff_t start, loff_t end)
 {
-	int err = filemap_write_and_wait_range(inode->i_mapping, start, -1);
+	int err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
 
 	if (!err)
 		fuse_sync_writes(inode);
-- 
2.11.0

