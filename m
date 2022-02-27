Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06B4C5A40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 10:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiB0Jfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 04:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiB0Jf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:35:29 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF483AA69;
        Sun, 27 Feb 2022 01:34:53 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f18so6513806qtb.3;
        Sun, 27 Feb 2022 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzSg76ac6SX33uvAxMIqRNwFLbBvgCZfP9HnkSBqBXk=;
        b=QElJKo+jzPOXMMwQ05T0aZ9Dq+Kvu0K78b2J4HE8GzpiJ9OsxoVlgSb7OTHjLRFlbO
         hfstUvFFX3Wq8mrLlJUFci1T5XCppas8fx4HA7pTXVd6wen3pGaXgeDJghJJivrehVxE
         rnE6hQDNtZ63MA1OiEp56hEM1HVRVcewvUsUfa+Fw2I8VbDc2IUInGqVJgG0fLdqwTdp
         OourRBKBgdM7trbKTSRWNrAmdEcCO4d+m0SRLRArbvKBgxMOrVMSGBW771qiupDxE0oE
         Zo14yyY2Kz3hbKxgYVFTBhs31cDGrmuHAUlUCoKEiV8o3xTgaU3clrT/ohOSsFvdl1fH
         nJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzSg76ac6SX33uvAxMIqRNwFLbBvgCZfP9HnkSBqBXk=;
        b=LBKgWKP9f+w12SQ4dwU09D5o4dexU7bSqadSyMARsVgJa+VKoxgeYm6W/wSvCFjOQw
         s8WbpfZhGoOEmnDb5cJGSZR60ZAw3EUyn3HMhGH+KKutw5CjBCwIwYKmu8xc62zyWhPH
         wvHfzKYP30hv7LZtgqg0ngNYNtiiaeqkvGJu4/kCzPnzbZxtT+vr31WbBLMARc49HW8K
         ixTq7pRB+2/WUTHTFqImKdTgYFouE44knhxo5QognX7Uv9Lix3NBDICqfOJtBPDnL8KK
         JkkEiBnh/M34GmzV7CpLDv9/CFfFWJzK4z4wFoWqgDvirwr3vYUaWbV4FPOf5jui7B7c
         MAXg==
X-Gm-Message-State: AOAM532FjqyCOYffDGyMJTX8lOhinzxaJ9tNuu/e8ufQ2e/IkmjlgRAf
        kMlRpftHkdbRQH1QcxHt0DA=
X-Google-Smtp-Source: ABdhPJyXNsyLxx3dgqMS1QCzsXJ4My1SC/a0A27ijb8+418Y5b2C8EQuXVl4YQq8TZrWVjwY6HfYnw==
X-Received: by 2002:ac8:5e4b:0:b0:2dd:dc99:d22b with SMTP id i11-20020ac85e4b000000b002dddc99d22bmr12694439qtx.165.1645954492201;
        Sun, 27 Feb 2022 01:34:52 -0800 (PST)
Received: from sandstorm.attlocal.net (76-242-90-12.lightspeed.sntcca.sbcglobal.net. [76.242.90.12])
        by smtp.gmail.com with ESMTPSA id h3-20020a05622a170300b002e008a93f8fsm469815qtk.91.2022.02.27.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 01:34:51 -0800 (PST)
From:   jhubbard.send.patches@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Date:   Sun, 27 Feb 2022 01:34:33 -0800
Message-Id: <20220227093434.2889464-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227093434.2889464-1-jhubbard@nvidia.com>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Convert nfs-direct to use pin_user_pages_fast(), and unpin_user_pages(),
in place of get_user_pages_fast() and put_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/nfs/direct.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index eabfdab543c8..42111a75c0f7 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -177,13 +177,6 @@ ssize_t nfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	return nfs_file_direct_write(iocb, iter);
 }
 
-static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
-{
-	unsigned int i;
-	for (i = 0; i < npages; i++)
-		put_page(pages[i]);
-}
-
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
 			      struct nfs_direct_req *dreq)
 {
@@ -367,7 +360,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 		size_t pgbase;
 		unsigned npages, i;
 
-		result = iov_iter_get_pages_alloc(iter, &pagevec, 
+		result = iov_iter_pin_pages_alloc(iter, &pagevec,
 						  rsize, &pgbase);
 		if (result < 0)
 			break;
@@ -398,7 +391,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			pos += req_len;
 			dreq->bytes_left -= req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		unpin_user_pages(pagevec, npages);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
@@ -811,7 +804,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 		size_t pgbase;
 		unsigned npages, i;
 
-		result = iov_iter_get_pages_alloc(iter, &pagevec, 
+		result = iov_iter_pin_pages_alloc(iter, &pagevec,
 						  wsize, &pgbase);
 		if (result < 0)
 			break;
@@ -850,7 +843,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			pos += req_len;
 			dreq->bytes_left -= req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		unpin_user_pages(pagevec, npages);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
-- 
2.35.1

