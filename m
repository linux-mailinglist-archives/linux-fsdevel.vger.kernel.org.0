Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA58B25810E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgHaSYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbgHaSYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:24:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55447C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 11:24:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n129so7060805qkd.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Hv640m4QkJdkTl9Q76dQvaUvN3yaHlXk40EdjG2dAxU=;
        b=kYW61x2zxq/v2MAjtM1SNuP5dO2xGEionNS42MAxP4Ma8vuz/TuCLOA2zrC1SLEsU8
         mqr0GxH5Mz5wcxZYWwXCNE9hs3XryDoF/Xm2gxhzowNNk0bjU1fO0gVSyh4jTJA7tCoY
         NiFP+T+sZg5gVrG/kUsNAkBGWDGtSm+H4E1hejCX2Q350AyDjtCuJyVA5zXpIkCxFUeR
         yWS/J7YoYyvAL9ARO3Ld57mG2/F7X7oW+pOUjWf+LNIWJJyGU3PX/bJy77Oft7Q+RWIp
         xTwf+3cwAiJ3rBz0Jaevclu5sJRuKNyDM4SL1SU5Q2PthC2gHXYk0e0PdczyTHY70UIC
         NTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hv640m4QkJdkTl9Q76dQvaUvN3yaHlXk40EdjG2dAxU=;
        b=KKt62tF4od17O/OT8w9HSXKKXj+fiGv9DEwnvOSS0bLLLYtvcOz8k/TFOFGwdFmbFJ
         gQxLWA3k62B7hOEhZ0bIFWtSR9F3a8g9uQRPqbRI03foUb8wO7XWfhlmx0/a5IM/eczr
         3x9vmj1QUUk0OugniviKkdV9m5ZqSB1VSqzL//Esy+qP/bM31PDoR5gF/VR0E4pO5uv+
         K7taCVSkDKiRsjzYUBsl2MzSd/uf+tRCdSbzqtUfq4MqMGsCqbnIUT9pVwC6EtHv3uBt
         wlXgDigncnhaSw3MoOh8f5Xa/KyqTtxSRzDRkcRG9r/6LGmb/csyUqaBqTIZRzjCM2Mq
         8Hkg==
X-Gm-Message-State: AOAM532nArQhAFFoQJvDUnTyY1LRRRHzTNtHYjtVmSiH1HTlkmiZLvMO
        q+Zi7+NAK8YUCb1zbGm1Sl/ttg==
X-Google-Smtp-Source: ABdhPJyV6ew6dwpr4lrBr5AcKDSn1rykBLekoGp72e7NKLLUDp5XJXZwZCR1f2xKU5oO/2sXd3E2Yw==
X-Received: by 2002:a05:620a:1257:: with SMTP id a23mr2322807qkl.207.1598898290431;
        Mon, 31 Aug 2020 11:24:50 -0700 (PDT)
Received: from localhost.localdomain.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e9sm3352144qkb.8.2020.08.31.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:24:49 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v4] iomap: fix WARN_ON_ONCE() from unprivileged users
Date:   Mon, 31 Aug 2020 14:23:53 -0400
Message-Id: <20200831182353.14593-1-cai@lca.pw>
X-Mailer: git-send-email 2.18.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
unprivileged users which would taint the kernel, or worse - panic if
panic_on_warn or panic_on_taint is set. Hence, just convert it to
pr_warn_ratelimited() to let users know their workloads are racing.
Thank Dave Chinner for the initial analysis of the racing reproducers.

Signed-off-by: Qian Cai <cai@lca.pw>
---
v4: use %pD4.
v3: Keep the default case and update the message.
v2: Record the path, pid and command as well.

 fs/iomap/direct-io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..9519113ebc35 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -388,6 +388,16 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
 	case IOMAP_INLINE:
 		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
+	case IOMAP_DELALLOC:
+		/*
+		 * DIO is not serialised against mmap() access at all, and so
+		 * if the page_mkwrite occurs between the writeback and the
+		 * iomap_apply() call in the DIO path, then it will see the
+		 * DELALLOC block that the page-mkwrite allocated.
+		 */
+		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD4 Comm: %.20s\n",
+				    dio->iocb->ki_filp, current->comm);
+		return -EIO;
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
-- 
2.18.4

