Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7CC1DFA7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbgEWS6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgEWS6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F851C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so5761039plr.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VWs0Nj9WGghWnCOq/fSx5SIRlxQxiE9MXDVdkqYQzM=;
        b=VQGxFJ1MxYS+Vw8KoeGE9Yp64TT9Leh+gvBEq3nSUIcV4q11TwCvNdgUOE64d9oXuR
         QwCYzp1XbRjhrfrIYCgDRiI3wNxKaPuOK9MAPnMWA0KnXYiuSAIVl2yI09EhrIdrcrFM
         yXlJUMX6/7/dnLIlxxx71WhbHGAAvf+qPT2dYyKUTUDXmSXge8//q718AUli9iaFfbEC
         dxVqtShxZExPi16L5fD/q3PnmzPb30ALVsAN2nzVeCsEO4ixAEqCTbiC/L3aSva3OchT
         7fmGcoI1vJS88d1J9R3bXQ/OGQQpUX13sIuMZdX3/8Sy5tpafxaH30aJAQrsfvYlh05M
         iYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VWs0Nj9WGghWnCOq/fSx5SIRlxQxiE9MXDVdkqYQzM=;
        b=E8Ycb00nVug6dhsyVwuPSgxUZVlTAFO1WgCItzPmUqxJWvZhgEAywuqoZMX4xqxiOa
         0gtlxV6lrBWej0QQXhR6q2VAC9tTIF9Pxd6ZzVIKTH++0kDeXEgMGRF8ZKvnbge2em81
         oG5px1xJitM6l+5qr5WwrdMkFWwBVdk2pkvHE4FtZutc1Gfys95nXtWVXfwTXHhegG0n
         Z1I3ra5PttmdC+mt15xon2M8k3cawUAw88i9EasqH1Tvw2UvFupv6+bTiPBcJiWtgyrE
         FMf1WBGrKyDI6XROaidKllb3oqYD6wdL2Jbc/SwvcIhvXw6fGHGrPOWQUmoABiHXkAix
         j6TA==
X-Gm-Message-State: AOAM533OV/T5XGzQsqGsQNjs1i4HV+2w3Nf2Ph3uJQ6U79zMVVK+rF06
        lv9UtWwPRsi4am5RgVtGD0eQTg==
X-Google-Smtp-Source: ABdhPJww2IAmo9uAID5Z5Uv4A7c5klKM1alJ3HFIhYmGs43fpfvpJn60oDW0FK4OztR7UWpiSCL/KQ==
X-Received: by 2002:a17:902:7:: with SMTP id 7mr21153561pla.45.1590260287140;
        Sat, 23 May 2020 11:58:07 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/12] fs: add FMODE_BUF_RASYNC
Date:   Sat, 23 May 2020 12:57:49 -0600
Message-Id: <20200523185755.8494-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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

