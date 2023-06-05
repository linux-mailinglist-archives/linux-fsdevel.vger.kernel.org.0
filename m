Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B57223FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 12:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjFEKzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjFEKzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:55:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CAF11A;
        Mon,  5 Jun 2023 03:55:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b02fcde49aso22701565ad.0;
        Mon, 05 Jun 2023 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962533; x=1688554533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d69PWHaRaZYvBhBWCvONZIqp7N6hQ/icpHNEJwjyDko=;
        b=GTXHUkwAlo5x63tRI0za5+P+gNvokdkwdWawVcMrBFIz2K4FRxNMszwLyxrFTGAfff
         E+9dTzVN89f5Odk+jZWPIJ7DLungw0qPoMt/RlMJ3dyqfijDxCWIZGxmf4w4ceShpbu6
         uuZ0VMpJPVX11JoKKT6ppHWY3VUB3BMzj2VEFTCIl2fgbv1Pek/2tw9T4MxTmqp9qXeU
         H1Sc3iQU+fx+HNQ7/4vRvXDKvYJPetcAdOyK7PkqM+7hJpTyTV+i0AgbIRpD5pTHTstX
         PXTptAwv3nq6t3a1/EYu6zj6cyK7j+knxeIVY/diSCGMBpxX+/OkPmboUvOmMlxHk03m
         UMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962533; x=1688554533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d69PWHaRaZYvBhBWCvONZIqp7N6hQ/icpHNEJwjyDko=;
        b=ZhHZLY2xh5glvrqfwXQ6Rc3wELIUmbB3c/xtsJEj4KoyLh2t4er3y8OTbtcFekzZvF
         q5vzBAC8fTO40xKCQNbfck250xjvobTmbgng2SnCjHNC8aru3saQeMBOxCbeSQpl7zDD
         WCFwHVkGdA6wQ1dh6MYossOLgJ2MAIxI8BQOZYG+aQREavFuwiot/jCkhmk7Y/SsSB8o
         KaoRroyRGlcd9QYSIqzuMbfHk/K68iXeGenFxbGnyZilcqlw95gB72Tsp0137njMlEFv
         h6RW8ENXF6JmQDpgTWnEQ8YpMtLgKXh5D0KEiVs/I+hpBFJVjHUaL4VqA3mNe4pWmi7P
         O/Vg==
X-Gm-Message-State: AC+VfDwxE5XKq/n5XWPmDXNFpCkv8XPELM7o0U5Fc7LiPnublf4UYZr7
        2TVNNnuHtd5hM4rb+2FsPr6kieUQTWM=
X-Google-Smtp-Source: ACHHUZ5S2D4jwQX/6faQFgnLPamvlMXOz4oBslTkLKRw6MOSheIYrzX4vJzUm5nzOvLm5zc01xm3JA==
X-Received: by 2002:a17:903:1252:b0:1ae:50cc:455 with SMTP id u18-20020a170903125200b001ae50cc0455mr3546490plh.39.1685962532819;
        Mon, 05 Jun 2023 03:55:32 -0700 (PDT)
Received: from dw-tp.c4p-in.ibmmobiledemo.com ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0f727bc44sm6266883plh.16.2023.06.05.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:55:32 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv7 5/6] iomap: Allocate iop in ->write_begin() early
Date:   Mon,  5 Jun 2023 16:25:05 +0530
Message-Id: <d2bd912ee7d2bcab0b49a0226496631ed5c82e21.1685962158.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685962158.git.ritesh.list@gmail.com>
References: <cover.1685962158.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We dont need to allocate an iop in ->write_begin() for writes where the
position and length completely overlap with the given folio.
Therefore, such cases are skipped.

Currently when the folio is uptodate, we only allocate iop at writeback
time (in iomap_writepage_map()). This is ok until now, but when we are
going to add support for per-block dirty state bitmap in iop, this
could cause some performance degradation. The reason is that if we don't
allocate iop during ->write_begin(), then we will never mark the
necessary dirty bits in ->write_end() call. And we will have to mark all
the bits as dirty at the writeback time, that could cause the same write
amplification and performance problems as it is now.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f55a339f99ec..2a97d73edb96 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -571,15 +571,24 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	size_t from = offset_in_folio(folio, pos), to = from + len;
 	size_t poff, plen;
 
-	if (folio_test_uptodate(folio))
+	/*
+	 * If the write completely overlaps the current folio, then
+	 * entire folio will be dirtied so there is no need for
+	 * per-block state tracking structures to be attached to this folio.
+	 */
+	if (pos <= folio_pos(folio) &&
+	    pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;
-	folio_clear_error(folio);
 
 	iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
 
 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
 
+	if (folio_test_uptodate(folio))
+		return 0;
+	folio_clear_error(folio);
+
 	do {
 		iomap_adjust_read_range(iter->inode, folio, &block_start,
 				block_end - block_start, &poff, &plen);
-- 
2.40.1

