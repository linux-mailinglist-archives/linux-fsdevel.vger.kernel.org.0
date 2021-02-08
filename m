Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD33142BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 23:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBHWTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 17:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhBHWTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:19:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587EEC06178B
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 14:18:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cv23so385650pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtwT2ZfoQKaKnaabpu4kFZ0j7fEVsXXg7Hy23jxR6Pw=;
        b=XmLr2CKghggmDeCSd5heWb4BPbgYpjgCBFjyGVpMGkKuw0vapjlCDgYeqtIhPGAjCK
         BZAQRcsiw03nXg8BtJvGnPx/CUYZd6jfu9/uaQtm5Mclrkp2RIBtUYf7NowfHS24NOp6
         waPVpXtm1hKAoNMLw9gcuEueTXC6+inn1ZAA5pxKhoOu9vO2hpVPsVc9GsNF/21E/ksG
         kmb7ZvR98qkO16507A7eSSoPpV9y+rdXNpy56tRsXuNyrsWkTjDbTV+VTmV7kub+F6+3
         CIc6+3PGNpOMC+RjKBwVyObhxtDFvP740bOfwpEkkTFDU/8HXbTNmldZoANNV734U1t7
         ZEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtwT2ZfoQKaKnaabpu4kFZ0j7fEVsXXg7Hy23jxR6Pw=;
        b=H+b88KyQ7RCNX7jgFu5/dafFLdDDOINR3y33IMg1tI6UFIavuVLGNZYPGw2biUBsGc
         EAx5FXYLAx+Pwpyei5c6A0nY0/r+LzvdoHLRN7EXuqq7uxr5NxtMM+DNenXnZxMD64Uf
         rfdxJbesni47ds4XlT2199xEMe0Q6lXVzBQInCy9fqU5hV2zb801iqawamZvGhNFITZn
         2bm+I38cvn5J35mo+UCf57zjTzgzDE2Zt7ALMq7RZ+B8Lfts/vea/dEKvV43tObOxFvp
         /6ZdF6iOpUwIjWwfBljjG/fbuh0PrtctlT2wwHQ9UaPGXOe/uoVmgASs/nmVz1bLfV1j
         XWoA==
X-Gm-Message-State: AOAM533By9YwU5jrUnYABZxEJ7AK5gbld1bCoupOL+/OxiqOD7vVySmh
        CnegAkP7pcOd2uPZXYIJ8VKND4Gm8tRtFqI+
X-Google-Smtp-Source: ABdhPJxOdCSPAs/K5CvefCqaIjsci+duFqzpTsXJG3UqGOHWM/ef3x/ClRU21S5b0HiKKoAX3OYAKw==
X-Received: by 2002:a17:90a:d3d5:: with SMTP id d21mr893477pjw.228.1612822719725;
        Mon, 08 Feb 2021 14:18:39 -0800 (PST)
Received: from localhost.localdomain ([2600:380:4a36:d38a:f60:a5d4:5474:9bbc])
        by smtp.gmail.com with ESMTPSA id o10sm19324472pfp.87.2021.02.08.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:18:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     hch@infradead.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] iomap: use filemap_range_needs_writeback() for O_DIRECT IO
Date:   Mon,  8 Feb 2021 15:18:29 -0700
Message-Id: <20210208221829.17247-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208221829.17247-1-axboe@kernel.dk>
References: <20210208221829.17247-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the generic page cache read/write helpers, use the better variant
of checking for the need to call filemap_write_and_wait_range() when
doing O_DIRECT reads or writes. This avoids falling back to the slow
path for IOCB_NOWAIT, if there are no pages to wait for (or write out).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap/direct-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..2561e50c763a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -479,17 +479,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (filemap_range_has_page(mapping, pos, end)) {
+		if (filemap_range_needs_writeback(mapping, pos, end)) {
 			ret = -EAGAIN;
 			goto out_free_dio;
 		}
 		flags |= IOMAP_NOWAIT;
+	} else {
+		ret = filemap_write_and_wait_range(mapping, pos, end);
+		if (ret)
+			goto out_free_dio;
 	}
 
-	ret = filemap_write_and_wait_range(mapping, pos, end);
-	if (ret)
-		goto out_free_dio;
-
 	if (iov_iter_rw(iter) == WRITE) {
 		/*
 		 * Try to invalidate cache pages for the range we are writing.
-- 
2.30.0

