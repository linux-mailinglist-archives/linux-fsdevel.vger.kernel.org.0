Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6530872AB35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjFJLjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjFJLjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:39:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCECE1;
        Sat, 10 Jun 2023 04:39:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b065154b79so12848835ad.1;
        Sat, 10 Jun 2023 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686397176; x=1688989176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyPzAEGGPRspXW63qviQl5WaHG4admX+rKhNWOPMKZ4=;
        b=IPfqVdqC8nEEH9U/D/1dQLnY/PXx4eBDeA7Gf1SaGqYSLQGW27I0GT6y4wCS6ueIGQ
         iatCuRkPh5/Q1f6svIL8QD7qO2Rqv2Q+bIF7sA3dS+CX8vo1STBA5AtVKb0wfoOK42wR
         a75jVFsCQdPLBppKAhES+iIojW0u6gQ/DR7dmWhDN/Ff+1LHVe8Pm0wmxQ2i0X+McNP0
         XXncXkzdXj4SmrfJjvnUXrw0swSCkw8ZwmQX+93/ERDmoGs4ZnQgEqbVk12OHpGywQA7
         3Mk5Sh1tCg/AlDUxcVtFijTWXo7ptWMMbN/4qJr0TkMVcPHoihl1sr3QGaGQLlET9BT6
         GauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686397176; x=1688989176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyPzAEGGPRspXW63qviQl5WaHG4admX+rKhNWOPMKZ4=;
        b=hh26NtUD5pHdKQkqkg6ZK9xfyd4tzWxiYFyBajilDr41jCHxVdvvfTsUgYezU/kNnJ
         1zACcuvYoUjFwDICzuYSo74m1VEGTLWVu6/r0MExs7yZSlD+eUrtvbuAyd1mmfUD1YAR
         0MlS+tDVR2YkVdCwxSd8bgX+layjq8FCvdwOGm9CwQPuXmHtXsu0CWg2pwvQ7Qp9EGhH
         Vbh1Wwcei+0zudpYmy+U/6sKCt9QAcwJVupgLx1E+H8DUcytMdzRF0GVdcj+UrFZQZzo
         f1NpAzlhzP7iSLroqqsTJqhicZmEX6w9P6AHtKCoc3G1iLp9JNHSJivgey2rxiEjMnnZ
         dOYw==
X-Gm-Message-State: AC+VfDyAubSHwpTaDADVEb5lM/O6QTlwcDclPD/ItQYkwcWwsA5hBxcK
        icRrK7QmGAeXNvkb/INGAu2X6SvYkys=
X-Google-Smtp-Source: ACHHUZ4+1uFpqiGwuS4o3sdBdHVs98XMNBhtbt3aD85AiRfAL5m21n35GTBRi4VdVzQj/Q0S0TVkqw==
X-Received: by 2002:a17:902:d486:b0:1a6:9762:6eed with SMTP id c6-20020a170902d48600b001a697626eedmr1895866plg.22.1686397175689;
        Sat, 10 Jun 2023 04:39:35 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001aaf5dcd762sm4753698plf.214.2023.06.10.04.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:39:35 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv9 5/6] iomap: Allocate ifs in ->write_begin() early
Date:   Sat, 10 Jun 2023 17:09:06 +0530
Message-Id: <a9d8c7e355b7471f34ac98567014fde1a5afbbda.1686395560.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686395560.git.ritesh.list@gmail.com>
References: <cover.1686395560.git.ritesh.list@gmail.com>
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

We dont need to allocate an ifs in ->write_begin() for writes where the
position and length completely overlap with the given folio.
Therefore, such cases are skipped.

Currently when the folio is uptodate, we only allocate ifs at writeback
time (in iomap_writepage_map()). This is ok until now, but when we are
going to add support for per-block dirty state bitmap in ifs, this
could cause some performance degradation. The reason is that if we don't
allocate ifs during ->write_begin(), then we will never mark the
necessary dirty bits in ->write_end() call. And we will have to mark all
the bits as dirty at the writeback time, that could cause the same write
amplification and performance problems as it is now.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1261f26479af..c6dcb0f0d22f 100644
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
 
 	ifs = iomap_ifs_alloc(iter->inode, folio, iter->flags);
 	if ((iter->flags & IOMAP_NOWAIT) && !ifs && nr_blocks > 1)
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

