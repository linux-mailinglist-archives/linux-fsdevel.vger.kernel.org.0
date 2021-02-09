Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6282B31465D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 03:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBICbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 21:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhBICa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:30:57 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61644C06178A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 18:30:17 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id z21so11534057pgj.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 18:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NeAk3PJLifKVqc2Uhcs4FSpHilknKrj5z1MFAaW43Ag=;
        b=1ias4FnzK1VNFg9SZDY3ZUQe4V9wOj9t9t9923MKJpPj4Sogo47GefH2KPemZbZsox
         IfaITZ1qCeBJu/ZhxPyhuFhs9u8v0hk01hGMSC16iv9eahk8oyAZ2xGU1N/IUdxrtQqW
         B+ouKmxnuPJoERPIiXefe6b5cM9xlm6EPqr1aZ5GqG1H5O4bsST+CTLPGrhgkLMRII7P
         3RdnxMkp0b/EFTk7h6S0PVBqf3kRtzEnGoYS5FfdU5d0OO6OaJM9Qrr2Bgyt/+ZDAkmN
         qZMd+smoKKXipq4SNPfR5FGk4iQPca47fR6SipLXy3SCcwBNSE1wslLJ8TUTnN4Ohqm9
         rHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NeAk3PJLifKVqc2Uhcs4FSpHilknKrj5z1MFAaW43Ag=;
        b=BYODn+EmTEQN4Mhlea0P+5jVS95p04EavzjnuB4IzNEfPhkmhmBs+rJ118GZogP/xC
         LfiLm2ifPLAepN1PC1p0CKG1yXP1NiPmHeH34llqCfgDA+m5V8uvcKx3DfsCjJVlVWcu
         XMWkQy5z6VY7gwDQBwVNq3//bm/NNVN7crrO5d2aseSGdvUJLEGI4mkFWYxo4Et1zkAT
         /LIuAhv9eZ41/29WYOKp3zoOc4GbrLuOvprcKz/67hX3wF5KO7zXscXQNdqdCuh+KyoP
         tuqz8DK23pEOLKejiLfZyqgfgeFwnsy/DWsJF4UnmOnhJ6qLINYvXI12v7BOKZcLWDu4
         YjtA==
X-Gm-Message-State: AOAM533XcCUvfa+DIaqa+4EtZHNjnTVUs7cSwn8Q5nlM5lUGw/hbaA61
        dfInZDOA6hYqh85HvavlyZJ2sUTmHTddtA==
X-Google-Smtp-Source: ABdhPJzIodUg5PR3R81qsg3WhYeJzNk6dOAQUyTI4+Gq/PEaHHOneG01zD8/fBvd5h7Imb7eWrJ4vg==
X-Received: by 2002:a05:6a00:a8d:b029:1ba:71d1:fe3c with SMTP id b13-20020a056a000a8db02901ba71d1fe3cmr20553833pfl.51.1612837816706;
        Mon, 08 Feb 2021 18:30:16 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y2sm19070597pfe.118.2021.02.08.18.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:30:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     hch@infradead.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] mm: use filemap_range_needs_writeback() for O_DIRECT reads
Date:   Mon,  8 Feb 2021 19:30:07 -0700
Message-Id: <20210209023008.76263-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209023008.76263-1-axboe@kernel.dk>
References: <20210209023008.76263-1-axboe@kernel.dk>
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
index 6a58d50fbd31..c80acb80e8f7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2643,8 +2643,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		size = i_size_read(inode);
 		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_has_page(mapping, iocb->ki_pos,
-						   iocb->ki_pos + count - 1))
+			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
+							  iocb->ki_pos + count - 1))
 				return -EAGAIN;
 		} else {
 			retval = filemap_write_and_wait_range(mapping,
-- 
2.30.0

