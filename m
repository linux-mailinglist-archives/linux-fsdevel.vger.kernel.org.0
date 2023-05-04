Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B396F6E22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 16:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjEDOwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjEDOvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 10:51:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C14EF5;
        Thu,  4 May 2023 07:51:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b7b54642cso446620b3a.0;
        Thu, 04 May 2023 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683211885; x=1685803885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9oa+YAIM8kWx6ZHF/yFRSmhk3uXfvF3ZPQSW2wux7c=;
        b=igx5H+/o74yDzyk6KNrljyNrrIt6FfJNMhqJucIQ7SJOcTZENnYG6gzdlMX9GDgxdM
         +d/phhzWAHMoxZMCokJrfbbhi4QJIlOLpMKi/w0I5Hte/k96ugK3PQumYCDVp0WweDbG
         AVbf7wA6+JzGecFLIVRnhxd5Rmf22sZ7qYoVzJFx/wDr2BODNqkwpv5YoTJkxNP9qb7H
         7WVL6Axt4aES7vHOAToOPaOBtoI+W/ryi/Bq+WHz/66gOc5MJwlvHKv/EC6ivr3EYcc7
         U6cdwMx7Id8HOHuTI2RtY15iG25D2JaEZ71kL3neYq9F0KTP3AdYLCveF2rZFdQ/QWQ2
         IuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683211885; x=1685803885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9oa+YAIM8kWx6ZHF/yFRSmhk3uXfvF3ZPQSW2wux7c=;
        b=dIsOUxUPo2R3jQrNGd8vxU2y1xinSPAz6XJ1XETKl4B6TifPKgHMLzzpRjpAz0U/VH
         pFpCOCi0ByDd7lGLmBZZm08o6LlFEJGJkhTcRzWOGrqAemodRis0IbQg0eQnI60O6irD
         1YEUxbkaVw7a7H5Y4QNh54F5j/dsZtxjp7PHW4UrTsTtsx629sYio4pm3GMI2gvECWBQ
         pETeT4dPr8zOYRInCyn2Y4qpTMFVEfA5RkKyXBua0SL5e06XiCHZ00MP13Qd4BfG3v1B
         CbOs9OciNIS/Xx8FqljP9bq4r3W7wbHb/psYxuc7bpea6nZW/l1OabKbvQRZV4IK+vr3
         GLUQ==
X-Gm-Message-State: AC+VfDw584a4Nwnagg+Y5Ftng1lWMsJkBH2fj9lOCl2EIKnMZH3gWTPS
        l0+HPmgHux7F4M3Aix2y6HVahyFvPAs=
X-Google-Smtp-Source: ACHHUZ7Kl4+3HEPH06OeyvcIr81BVvMKhNw27JU/iIIsJYYxhACWbYYimg8e3QRVsmXYv/ArDOL6Jg==
X-Received: by 2002:a05:6a00:1916:b0:63f:1926:5bb8 with SMTP id y22-20020a056a00191600b0063f19265bb8mr3101624pfi.30.1683211885302;
        Thu, 04 May 2023 07:51:25 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:80ba:df67:5773:54c8:514f])
        by smtp.gmail.com with ESMTPSA id z192-20020a6333c9000000b0052c53577756sm3107503pgz.64.2023.05.04.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 07:51:24 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv4 1/3] iomap: Allocate iop in ->write_begin() early
Date:   Thu,  4 May 2023 20:21:07 +0530
Message-Id: <06959535927b4278c3ec7a49aef798db6139d095.1683208091.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683208091.git.ritesh.list@gmail.com>
References: <cover.1683208091.git.ritesh.list@gmail.com>
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

Earlier when the folio is uptodate, we only allocate iop at writeback
time (in iomap_writepage_map()). This is ok until now, but when we are
going to add support for subpage size dirty bitmap tracking in iop, this
could cause some performance degradation. The reason is that if we don't
allocate iop during ->write_begin(), then we will never mark the
necessary dirty bits in ->write_end() call. And we will have to mark all
the bits as dirty at the writeback time, that could cause the same write
amplification and performance problems as it is now (w/o subpage dirty
bitmap tracking in iop).

However, for all the writes with (pos, len) which completely overlaps
the given folio, there is no need to allocate an iop during
->write_begin(). So skip those cases.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6f4c97a6d7e9..e43821bd1ff5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -562,14 +562,31 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	size_t from = offset_in_folio(folio, pos), to = from + len;
 	size_t poff, plen;
 
-	if (folio_test_uptodate(folio))
+	/*
+	 * If the write completely overlaps the current folio, then
+	 * entire folio will be dirtied so there is no need for
+	 * sub-folio state tracking structures to be attached to this folio.
+	 */
+
+	if (pos <= folio_pos(folio) &&
+	    pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;
-	folio_clear_error(folio);
 
 	iop = iomap_page_create(iter->inode, folio, iter->flags);
+
+	/*
+	 * If we don't have an iop and nr_blocks > 1 then return -EAGAIN here
+	 * even though the folio may be uptodate. To ensure we add sub-folio
+	 * state tracking structures to this folio.
+	 */
 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
 
+	if (folio_test_uptodate(folio))
+		return 0;
+	folio_clear_error(folio);
+
+
 	do {
 		iomap_adjust_read_range(iter->inode, folio, &block_start,
 				block_end - block_start, &poff, &plen);
-- 
2.39.2

