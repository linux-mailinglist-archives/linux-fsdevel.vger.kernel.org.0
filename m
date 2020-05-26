Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E221DF40F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbgEWBvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 21:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387485AbgEWBvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23AC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so5811645pgl.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VWs0Nj9WGghWnCOq/fSx5SIRlxQxiE9MXDVdkqYQzM=;
        b=HnYcrZsdOxNRPX01BAnp52Y7QAzXP3CsE9SKw6fM2ImM1eIgaLTppeiQWVnE4+11m3
         OejnkqB4kn5KbmRxULadm7opO6Kb+xsQiehV88PQ/0Zt5ygcKMubjp3qUbnsmu8xw1dO
         tUNho/mPqi5E13I6F+oLG00gGtZLIc3imnV22yFOYC9TXgLmfk5T2dygoCfZ7JOJGVAv
         KlhOHI1SnxOsFUv768fRTyN/geFG4DgbMjHnx9M9CqPJYXXVONngEu0cBOr13pfQx7vS
         rJQvZvesC+TDpqUL8Xn8iJylJnj4S66DggYzHPxNJvyUc4XmLS+1qrQd1F9klkosbR5/
         JpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VWs0Nj9WGghWnCOq/fSx5SIRlxQxiE9MXDVdkqYQzM=;
        b=Nh2zXJCQuOymglf37pjvnKmlVYJqgsfKQqlEl5U9W6wYl4uBtdasEEY31r28q8qeL5
         i9sRYYg9Ou31E9Cjp7xiQkwKyLrQEJTxgvMq93omFpnD24Cvn66VxE+JATxiZeSMlm2c
         +E20yKJDSU4J8isFr0N43S393ZiGCyEbSV9Du7haRnv8pye/T9A1uP7DT9Dnnlgy1vqr
         fdky2umoMkOBy8ASqz0ADKM4wozdvLFSbZ35aEXUfj5vLhe5CMIcjwwi4pZkG/f/mOBn
         9Ug0xwpqRgQm/SlKs2leUmT7rwVooPVNceVv2Xn75sKOVxMupL4jHwtjKB5DtbgOtbsC
         lCOg==
X-Gm-Message-State: AOAM531Ro9+mMgend9eyUgeUDEGNp0WzIAkStc6RL0RMDxPmYFYB1iqm
        fRvAxbIE+FqkLS8OQfjxPnjh4g==
X-Google-Smtp-Source: ABdhPJwDt7vAik+XV1ClU0sHBzKsLdX3gET9tONikOf+AYZa2mXQmQJNwaXlM2gsfrr+iZBKtp8bmw==
X-Received: by 2002:aa7:855a:: with SMTP id y26mr6530839pfn.281.1590198663998;
        Fri, 22 May 2020 18:51:03 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] fs: add FMODE_BUF_RASYNC
Date:   Fri, 22 May 2020 19:50:43 -0600
Message-Id: <20200523015049.14808-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
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
index 82b989695ab9..0ef5f5973b1c 100644
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

