Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F472414C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbjFFLoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 07:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbjFFLoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:44:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D11E43;
        Tue,  6 Jun 2023 04:44:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b04949e5baso52663075ad.0;
        Tue, 06 Jun 2023 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686051854; x=1688643854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jab6p16he4cD48oIvWzgzNyAp3uY3B9r8JeAYXvFNdU=;
        b=mRxlRwQNPBbo1voVjBBfQJiVIxXNhvT8Va7UHos2fw8K+YftV+mIx8aLrgkUuclPL0
         ZAZuIbfh3vSHBhGdl6k0tjp/6RmpgwbPbuMJ8f5dR3/x6MG7cfWkIWFass7qrmCkdeGJ
         ojuHjexj/J8XFo4x0yIjRmepHxTbN/+obr8DyI3KXo/OntqKPzsSE4hoN9wYwIoYL2W6
         gZeykuz6aULAuSfwSYp/iMULgeB8dt3E9oF+PxBkP64l4qQKiffGok/DlDaivAiAakgQ
         jKP57I6mXm2gT1LcMuA5fmukt8KKv+MiyP12IPv4CznTLiGccnxieHjpXtAHtQFyP+rX
         2XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051854; x=1688643854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jab6p16he4cD48oIvWzgzNyAp3uY3B9r8JeAYXvFNdU=;
        b=kHHNfloFQK1WcbCo/O6bbdC1hlgLUGTbKA0nkix1wIvfOoPJIVqPqQadgGcuFvUvUf
         cEHBQvY5zEmHva8gHWy1Op24ldcRCx2fU72qp4hVvGos47RCBfWYgRKlN+DmrHm1ejtL
         gRGbjUF/e28i0dqF7eWCvAjFOKv1m2Jbz4XqzB6zn5M7c9A85gD9bawsOKIPqzXrDkB1
         SW8BnliSpn5iFxhCc1QdIF5q8cSc17fQJiJNSFNxCqo+zfUaVvK25Z1jbNqOQ6kE0S+j
         7UrSwmAyciMt6TMXg31wi2Tf8pYgfb040uQRxDIyOQm18JoYT12eiYsJPSLGqfQFMlBx
         z8sg==
X-Gm-Message-State: AC+VfDwQX4JtrqJ/zOP0B07rvU7mUPxx95iUjVGxMLJGgVURVc/TGmNe
        6vIqC3g5KdhiSJNOX+LYFLiznnfwJN4=
X-Google-Smtp-Source: ACHHUZ4o6Op8f8+0vzTG08WPlvELUkJ7ruOMzC2+kkA4hdaAT1QeGay+u/SdK3qcG6qZIW3PGMrOag==
X-Received: by 2002:a17:902:ce86:b0:1aa:d545:462e with SMTP id f6-20020a170902ce8600b001aad545462emr2268474plg.13.1686051854535;
        Tue, 06 Jun 2023 04:44:14 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001ab0a30c895sm8325120plb.202.2023.06.06.04.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:44:14 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv8 4/5] iomap: Allocate iof in ->write_begin() early
Date:   Tue,  6 Jun 2023 17:13:51 +0530
Message-Id: <1161fe2bb007361ae47d509e588e7f5b3b819208.1686050333.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686050333.git.ritesh.list@gmail.com>
References: <cover.1686050333.git.ritesh.list@gmail.com>
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

We dont need to allocate an iof in ->write_begin() for writes where the
position and length completely overlap with the given folio.
Therefore, such cases are skipped.

Currently when the folio is uptodate, we only allocate iof at writeback
time (in iomap_writepage_map()). This is ok until now, but when we are
going to add support for per-block dirty state bitmap in iof, this
could cause some performance degradation. The reason is that if we don't
allocate iof during ->write_begin(), then we will never mark the
necessary dirty bits in ->write_end() call. And we will have to mark all
the bits as dirty at the writeback time, that could cause the same write
amplification and performance problems as it is now.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 89489aed49c0..2b72ca3ba37a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -567,14 +567,23 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
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
 
 	iof = iomap_iof_alloc(iter->inode, folio, iter->flags);
 	if ((iter->flags & IOMAP_NOWAIT) && !iof && nr_blocks > 1)
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

