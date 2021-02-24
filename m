Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8DF324260
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBXQqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhBXQpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:45:47 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83699C06178A
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:45:02 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i18so2249337ilq.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4g79Wmg8HssdJE1RJFj1xs5Uw0vA1HddswvKOPj7R1c=;
        b=DkLjVfUkguWaeFLE9AhCxvUdXSBU0OTGcMJaMx+3ID1I9uA7hXf9W9q8nqi7wqtwVF
         /FpzzWFMDl44NRXBrvcwlOnyUE2dsX3rxEBpBDowXWcp87ExSVjSysLiPU5LQHqNBM+Y
         osHATKreCyqupnk3K5AJHzE1y6FFM+yVK5KjxRUA7a4LRSySq27pp9JtLAo/pOuWOAjW
         2C9xLWqtMLKz0icTCYEomt3TkFvmDrT7IxlN3j2yjOD6sV977/2pjpRoi0xBMIiD+3la
         1ufbCW9sMUyxrKXIzujZOdASCb22RjXDLqMumtqUMuRYNXstr/2sBYW7WlLSCGPVVuDg
         qXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4g79Wmg8HssdJE1RJFj1xs5Uw0vA1HddswvKOPj7R1c=;
        b=jdPT2uYQ7gaITwH0JjgTS1IgwDyb1luaWjCUOcgJ9gnLyJ+/wOnew99OOndl2sHGhh
         raHUK1EGUqqxvOsvpTEft0LOsy6xVRo0bQyMKkvTidcugpOQ/NA37ZJMyRvaDUXbrku6
         HLTcdKDwfpM6PRrcWcalr283UI+8lgCMQ5KTMRRNkxm7f4CHl5E4OFEJMnumuYFXI1Rk
         5CosUE+IxlzMXfulk/AoStvndIJ7vDHAE/r7XKfaQ5PTpCSsqs/+Uv8LHuqXq9JS+XOc
         uOpm03oiikqXmyxVxdqJRuiLwYrFtMh2Z6UyM3ZInMUayPcaVGrTvgcPzSmb8XcBngXx
         WWng==
X-Gm-Message-State: AOAM531uttpkKUyo1nQlla3locKycUXsUo2mEziHtLj/cjipWY6PKdNW
        jgrD9SNsCD+3QuhNHNuEycdFhgKPadPcjnGh
X-Google-Smtp-Source: ABdhPJxEPgjN8zxQ212St/12AqeiWIWDjQI3YqfduoU93Dcr2prsac+4S/oGDBcIqaN1gg3rLi2aGg==
X-Received: by 2002:a92:1a4a:: with SMTP id z10mr22531390ill.4.1614185101811;
        Wed, 24 Feb 2021 08:45:01 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f1sm2273652iov.3.2021.02.24.08.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:45:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] iomap: use filemap_range_needs_writeback() for O_DIRECT reads
Date:   Wed, 24 Feb 2021 09:44:55 -0700
Message-Id: <20210224164455.1096727-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210224164455.1096727-1-axboe@kernel.dk>
References: <20210224164455.1096727-1-axboe@kernel.dk>
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
 fs/iomap/direct-io.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e2c4991833b8..8c35a0041f0f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -487,12 +487,28 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (pos >= dio->i_size)
 			goto out_free_dio;
 
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (filemap_range_needs_writeback(mapping, pos, end)) {
+				ret = -EAGAIN;
+				goto out_free_dio;
+			}
+			iomap_flags |= IOMAP_NOWAIT;
+		}
+
 		if (iter_is_iovec(iter))
 			dio->flags |= IOMAP_DIO_DIRTY;
 	} else {
 		iomap_flags |= IOMAP_WRITE;
 		dio->flags |= IOMAP_DIO_WRITE;
 
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (filemap_range_has_page(mapping, pos, end)) {
+				ret = -EAGAIN;
+				goto out_free_dio;
+			}
+			iomap_flags |= IOMAP_NOWAIT;
+		}
+
 		/* for data sync or sync, we need sync completion processing */
 		if (iocb->ki_flags & IOCB_DSYNC)
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
@@ -507,14 +523,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			dio->flags |= IOMAP_DIO_WRITE_FUA;
 	}
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (filemap_range_has_page(mapping, pos, end)) {
-			ret = -EAGAIN;
-			goto out_free_dio;
-		}
-		iomap_flags |= IOMAP_NOWAIT;
-	}
-
 	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
 		ret = -EAGAIN;
 		if (pos >= dio->i_size || pos + count > dio->i_size)
-- 
2.30.0

