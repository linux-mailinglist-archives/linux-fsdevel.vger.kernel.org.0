Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED5E32425F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhBXQqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhBXQpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:45:47 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D5C061788
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:45:01 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id a7so2637086iok.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AeRNuJwb26jecYMYshpZyYXTh8+P3sXAHEYap904nwc=;
        b=dBA4tatNquPbOX9jozxTqfDTxIugjGjAaNp/E8p8mGSEaTf5Vqp/X2Sw5upZoy3oDb
         pKdTyXBY9+G1HNiWIozAwLiNrkcVZAbzkYnNk/sNvi4BppTDVq4wssMn69Or3nAZsIlG
         v3LjOfV6S/1W4hQuCoMuHjMsC/pcXEoiiXEULEZz4wS177ArMHr3z3iwb8bRenhSE25f
         eeyzttn95ulHx2s/BeJYlKx5yl+y/Dp8N1ob3lU7vmNhs6JB5t7LrsdLLuCF9YwnNIwe
         jebKdgOpTuYtwITGdHusRTNV4F7qTXbXVTib5OaPnacajl1jSsgrlea0/N6CPKtsbiPm
         WQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeRNuJwb26jecYMYshpZyYXTh8+P3sXAHEYap904nwc=;
        b=EGgTAySgYif9/+MS1E0TDxCtfNmVqRcgpLhg+jl5I5xUwjaw2vM+AeQXw4APjH8myb
         dzua2dOP0twga4YJfwkQmfLozvS+C5eRnYIY7ibB7tT41zlIV1XfbzMabOzJNvXHRCmm
         8zyTzItxQ1EggMe4h0nCSIyAqn3+u+ajxcYFiiWHwiLeH/s3KC6fOeG0Z1zxTa+4BulO
         z0795bcwTwpeWOgb6BWnurOWrFSL8FQSM/K5QnCWc3017KsJ+AyzbFFUo2jAwTONgE+p
         ZI1/IGSMkPHB1OlFghKGyJfHqbdfsK2axmiPY7ILc6kAOtALpaYDqv9oBoyNaaI50sPC
         luFg==
X-Gm-Message-State: AOAM531U778US0Mw1mqUqgNGRHnpE/M7uvTL/ilZb4Ikei9lhCZazi6S
        yhSO3v+7bknAVwP6XuCp0Dl+2tfpIrKJ8AW/
X-Google-Smtp-Source: ABdhPJyu6UQs/JPMF8a5cuR5B6fkZaVUvjWgzmMcs7a1pMpBdTKtP4C9yXuvh99wpYZ8leey8BJdkw==
X-Received: by 2002:a05:6638:22e:: with SMTP id f14mr20097775jaq.96.1614185100654;
        Wed, 24 Feb 2021 08:45:00 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f1sm2273652iov.3.2021.02.24.08.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:45:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] mm: use filemap_range_needs_writeback() for O_DIRECT reads
Date:   Wed, 24 Feb 2021 09:44:54 -0700
Message-Id: <20210224164455.1096727-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210224164455.1096727-1-axboe@kernel.dk>
References: <20210224164455.1096727-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the generic page cache read helper, use the better variant of checking
for the need to call filemap_write_and_wait_range() when doing O_DIRECT
reads. This avoids falling back to the slow path for IOCB_NOWAIT, if there
are no pages to wait for (or write out).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 13338f877677..77f1b527541e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2645,8 +2645,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		size = i_size_read(inode);
 		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_has_page(mapping, iocb->ki_pos,
-						   iocb->ki_pos + count - 1))
+			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
+						iocb->ki_pos + count - 1))
 				return -EAGAIN;
 		} else {
 			retval = filemap_write_and_wait_range(mapping,
-- 
2.30.0

