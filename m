Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0105E1E2F56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 21:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbgEZTvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 15:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbgEZTvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52416C03E96E
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so10575898pgn.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJi+qFrBerZp7lBzD9z2X8A704PrrK58u6ckL/rX8b0=;
        b=QGGh7eDvuMEBseMP4f9z7p3YtnoMdEdl9ZhyIAyPiRAlOPWyjOt58ZYAEOyE5NGpZ+
         VbiVeaEvFBaRPyUFJs+jXjd5VlpU+FnFUdGnRwd4iM9vS4L8882zLFU0dJLNP83bH/7X
         Hr9aSoECE600nn2BUNPRRieqpYPuc2kJasfGr0Oad4cVuC7JJqYajXm+cBZv+VfHISga
         vLPJeD20yZMDEi0ileA+x1DrR5XEs54TlbjSVb6dXpEJAnHRCLPDGSG+Q65Af5so6wyt
         UoNhrMBuw8SKSezT9NYfONZtHHhz+/qyOtkgNQTZkmJfGXNjvokqDQxWupSNHXy0H+/a
         mcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJi+qFrBerZp7lBzD9z2X8A704PrrK58u6ckL/rX8b0=;
        b=HTQvD0mYF9b27C+s3QiMbol1+hnIVDIPMvDmrjzHblQSnB4TYBjSRT6SPTaEgOOs5A
         lJeaE1Wt6plEfUFR/e4R2OvFHNDmVPbPHHLif8EHcuBrO4hgSPZo3Dy8rWVZXg10s2pE
         jlt9xoG6aYiySR4fRiN+vKCDsbf2Pn0goVqfZ/Qq+cL/X0bQDMnPhYNjt5kN2iqBboIc
         nnsOZnAMm0vTUSJWpOlZhPhiQ1VU0SqU284EgV1P40n+CK1rBlsl9AORegKRNukNfSzP
         9EWDJiKv6889zLHOTD8/L2cABfEr9gl/9/RejF0jnujuiDwiFulDDJP73fIOVk4zj+X8
         qKqw==
X-Gm-Message-State: AOAM533gwQ8LT7yUkESKnQPEYEV1kAbXTJeJCe9KkXdNIP7H2EuzWAiJ
        Y0gKrMMBhNjKgcAWMA3W/TgH5fHQqqfR5g==
X-Google-Smtp-Source: ABdhPJzJqSQxVJW7x8nTJ31d7qT/FMci6We/odd5NaY49/EasjZOkFDNFy9QZL38JZHs/iDqJ2x1gQ==
X-Received: by 2002:a63:5245:: with SMTP id s5mr481181pgl.394.1590522694841;
        Tue, 26 May 2020 12:51:34 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/12] fs: add FMODE_BUF_RASYNC
Date:   Tue, 26 May 2020 13:51:17 -0600
Message-Id: <20200526195123.29053-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If set, this indicates that the file system supports IOCB_WAITQ for
buffered reads.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ba1fff0e7bca..5ffc6d236b01 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File supports async buffered reads */
+#define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
-- 
2.26.2

