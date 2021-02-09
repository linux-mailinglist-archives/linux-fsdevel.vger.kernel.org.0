Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37D431465E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 03:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhBICbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 21:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhBICbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:31:03 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6466EC06178B
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 18:30:18 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z6so1833276pfq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 18:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3Rk7GfRZkBxeNjU7Kh2bYrh55ud7n78YGybFpQpjSk=;
        b=16kACgxMGBZehZBaxowbj13gbI/eye+R6F4RoVlRlXWybq8eTBEDzKVDtapQgd+H5D
         OB7C2HHew7WFUYVvngutI0mymaHtZF+jhsHiffcBZU69I2hCEUpIsZ8ynEfxcGsEw164
         wAsWCh7DYnRZa/NgROpaa1mNhpO+xI5ZzonDCKEEwO6Yxo9uBPgskUmbfvxr2TkBUSbG
         MsTZFCp6CcDdX/9Ye9U72bkvp2e53t8jBli23b8FFJCVrsCg59rH1PJltCb8jxrap7Cc
         27mdsD3OJzyronye6gaXdow8VcQTC48U4LFruthYCkqis2pv8BY+U6N6LwLCQ8u+8lsx
         2mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3Rk7GfRZkBxeNjU7Kh2bYrh55ud7n78YGybFpQpjSk=;
        b=g0zLDKHggnDVHA9Q7WQWdmZgeDJxBbaoHoB5kB5SnxCwFFv8AvAnbtbzy2//sRXlhI
         UyTNM9GXt1bz4ySdLimxJNDCaQiOkfTZF9S0X5xHpFAQNZzdTTIrZauOVu9nTOZbhusX
         q+B6Z78EY2AWBHei4BxF9ye+mbdd5qfe9/JNSkHvnilZTKKyZNJsO2Ie0SEHsYowy3B9
         ZJ5n97kA+QGw+29brdk2ZHcba+8ULBhXnv0dskAuLA/dh/zpqsZRoNjZ1Ej8khHxGi5t
         08BqOs6HM+oLmEunCciqRed2jrgOlk12uw/rEqtstiZyGBKUBe7sureb0U1CBNv9pkgQ
         gSGg==
X-Gm-Message-State: AOAM532ISQl4jwUTG6cp0Q3sIW2TGGhnhSIzl9PGfq7EQA1YmUsHqbI/
        UIjMF+uSgiTMGrDkMjhaIijHghvWK8pUfg==
X-Google-Smtp-Source: ABdhPJyqaoja4NK3VKz/84pycA5yyMWjTKdCPC0AlBIyGsuH/6UaH2NbIQvUjEEZV3DGm/CWaVMRWw==
X-Received: by 2002:a62:8fd4:0:b029:1de:d484:e1f7 with SMTP id n203-20020a628fd40000b02901ded484e1f7mr5031886pfd.78.1612837817672;
        Mon, 08 Feb 2021 18:30:17 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y2sm19070597pfe.118.2021.02.08.18.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:30:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     hch@infradead.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] iomap: use filemap_range_needs_writeback() for O_DIRECT reads
Date:   Mon,  8 Feb 2021 19:30:08 -0700
Message-Id: <20210209023008.76263-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209023008.76263-1-axboe@kernel.dk>
References: <20210209023008.76263-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For reads, use the better variant of checking for the need to call
filemap_write_and_wait_range() when doing O_DIRECT. This avoids falling
back to the slow path for IOCB_NOWAIT, if there are no pages to wait for
(or write out).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap/direct-io.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..5b111d1635ab 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -458,9 +458,24 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (pos >= dio->i_size)
 			goto out_free_dio;
 
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (filemap_range_needs_writeback(mapping, pos, end)) {
+				ret = -EAGAIN;
+				goto out_free_dio;
+			}
+			flags |= IOMAP_NOWAIT;
+		}
 		if (iter_is_iovec(iter))
 			dio->flags |= IOMAP_DIO_DIRTY;
 	} else {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (filemap_range_has_page(mapping, pos, end)) {
+				ret = -EAGAIN;
+				goto out_free_dio;
+			}
+			flags |= IOMAP_NOWAIT;
+		}
+
 		flags |= IOMAP_WRITE;
 		dio->flags |= IOMAP_DIO_WRITE;
 
@@ -478,14 +493,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			dio->flags |= IOMAP_DIO_WRITE_FUA;
 	}
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (filemap_range_has_page(mapping, pos, end)) {
-			ret = -EAGAIN;
-			goto out_free_dio;
-		}
-		flags |= IOMAP_NOWAIT;
-	}
-
 	ret = filemap_write_and_wait_range(mapping, pos, end);
 	if (ret)
 		goto out_free_dio;
-- 
2.30.0

