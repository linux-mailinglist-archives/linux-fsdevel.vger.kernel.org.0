Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CC256B0F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgH3Bb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 21:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgH3BbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:31:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1E3C061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 18:31:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p65so2467724qtd.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 18:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oTXPJKxAg5XxTQVL81YppTbJbKKdp2qoMjgryaZThzc=;
        b=snIHPNItiSzMiNbfMvHkwKcuLJe8cG++Oz2ae8qgnrH1ekSHdofCVjHTa1VxsLoeYQ
         kY0fJQw17HrhhvbknPyQU/+X2QJodjqBIL7rjSl0u+38tvX6s4n2Wla57G/6YcU1Q4YG
         yY4w0S5FAIv+SbABcIvu/T4WSScBA/64RzO6UC6leqD4skku42yNm9Tf5qF4sXguMP9D
         dJtoK1aXxn5zgfJIREsXq9lAZ7QcP/JT+MFLzFUBdHDorjQyScUo8DvQuM/mAj2K6Sel
         s4KotxmA3eplfUQ2FecY/AX3Pma+7DhPYL2MATUNCQDeCb4Ax5fxktpf6dLOQiHay9Yp
         NJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oTXPJKxAg5XxTQVL81YppTbJbKKdp2qoMjgryaZThzc=;
        b=HYntaUKhu3RGEEfqm4M1HLW2gAv9lJJaH7xbJQOW6klfMPH31N8X4xV+9ChG8U8VJ0
         4kCmLivQzjSo+AxOQbzD/nX8Fn5FlQRsUEjz+tExwJfSloKVb9QO+lT6NvIvMHnOQ2On
         67t4nSxzDd/cAz6Ncm4N4WnlXewigCZHKw9o09qgC96khtc/uA8QHq8H0pYpqfN5gjrr
         C/n0uidftLF9NYBDqpGO74UTZ8NvvDfYCdXxkHbnz1OLwfJY9WbwIv9Ykr8yUfqZzvsE
         FYwoj/BjfPWUa6LFaeePpyibJ3YjytvNNainYhyVR66OeKv2fV6kq5uVYA6j5Jv8pcLY
         M0TQ==
X-Gm-Message-State: AOAM5308dO4SWFo+fKEK4L6qboG6VFS0+wEjr3shJ6fzjcWQQJi7dj48
        xMYMFY1cg/qNv/B8jaSq+eKN5g==
X-Google-Smtp-Source: ABdhPJzwUsBp/+777eFsa+X2LXOqWrmMmxFxP7fZxqjoql/YJZT6UN4uCbSqzHfAc+XBjx1QqoB52g==
X-Received: by 2002:ac8:2baa:: with SMTP id m39mr7636519qtm.204.1598751080998;
        Sat, 29 Aug 2020 18:31:20 -0700 (PDT)
Received: from localhost.localdomain.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e21sm4017553qkl.88.2020.08.29.18.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 18:31:20 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] iomap: fix WARN_ON_ONCE() from unprivileged users
Date:   Sat, 29 Aug 2020 21:30:57 -0400
Message-Id: <20200830013057.14664-1-cai@lca.pw>
X-Mailer: git-send-email 2.18.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
unprivileged users which would taint the kernel, or worse - panic if
panic_on_warn or panic_on_taint is set. Hence, just convert it to
pr_warn_ratelimited() to let users know their workloads are racing.
Thanks Dave Chinner for the initial analysis of the racing reproducers.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 fs/iomap/direct-io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..6a6b4bc13269 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -389,7 +389,14 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 	case IOMAP_INLINE:
 		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
 	default:
-		WARN_ON_ONCE(1);
+		/*
+		 * DIO is not serialised against mmap() access at all, and so
+		 * if the page_mkwrite occurs between the writeback and the
+		 * iomap_apply() call in the DIO path, then it will see the
+		 * DELALLOC block that the page-mkwrite allocated.
+		 */
+		pr_warn_ratelimited("page_mkwrite() is racing with DIO read (iomap->type = %u).\n",
+				    iomap->type);
 		return -EIO;
 	}
 }
-- 
2.18.4

