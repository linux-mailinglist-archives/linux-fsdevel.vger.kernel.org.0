Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360827447CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjGAHgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGAHfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:35:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BA5E5C;
        Sat,  1 Jul 2023 00:35:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76731802203so235082185a.3;
        Sat, 01 Jul 2023 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688196944; x=1690788944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgq6MS9CqB7Jw3ef4fl/DnYThdTWoNrF7yr1DYSnI3I=;
        b=HQLJx/AvTAaY6LRfSwGVCdK3+cawzGhTkx9wnFTwdSvq2908mu8BKamD0vMQ1v4x4/
         fvamADPfdtsWI9W/Wmpqxa8ZJzhYG/6tDWPAixXEXGCei1irJBPEJ8tXpwiHCCQKLoba
         MY7ZbaNu9Urv2rSmenU0m39ZAaAgQwnaLEvBIjXz5AhSlTpmc/kcqPLy+Cao+EDYhWht
         aJvPnCezuXw5+mGL4fpJ038x2DGfujPqvLq42sp5tDy7HlXSjgiItQ16ZC6uabiWrf5p
         l4di8RraIpoeDf+hFVZXsqIr3743sz6V4rKsJLNigDg9lWAV/uXY4Eu6BrsjilX+wpLq
         YdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196944; x=1690788944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgq6MS9CqB7Jw3ef4fl/DnYThdTWoNrF7yr1DYSnI3I=;
        b=kORSTGzXr+vlJkym4duq1t7a+qYyz5pZM7a6f2qal9MlhT/DRtEJP3C9glqGgs8QQn
         n3CGddtBOXEyOX3FfLDxQ+BQjDitTXLYlMmFcKAdMsJev4vSwbF8pRXANO2/aDxBtDqI
         3HT1yzTiTp0/1PQowQsTqQyCWTzeyEw+rxkIXlmXHEIq3Gtvrke/Jtfn/WAlgxXJuweI
         RytXDiqpGoAGolcDN7fNw99wOUtqn3cWEFsYBkuHS2BQL0/8jrw5ijZuKSz7zsCWgS/L
         OHFA7R9Bmo3Sz4uILYmJB8LaiESOb/Wu2LpyJQ2afWlSRGCj1nBIghpKK06WpUnkQcym
         Klvg==
X-Gm-Message-State: AC+VfDzTOeinfvmf7N2Q3bAYy0SY7eDLwG209mC1Sy1wtWPob+wSN/MM
        ueEmRYR0XfCQhPtgKF4njON7f9vcswY=
X-Google-Smtp-Source: ACHHUZ4cwF/WU6hg1VJFXy+pZqM3Jx0Em66Mmig2DNTqBGw2xmsb3KvUeHLiUwYZJuHDwZhfmTQG1Q==
X-Received: by 2002:a05:620a:8d8c:b0:767:1c73:69fc with SMTP id rc12-20020a05620a8d8c00b007671c7369fcmr3925950qkn.27.1688196943889;
        Sat, 01 Jul 2023 00:35:43 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b0063aa1763146sm8603414pfo.17.2023.07.01.00.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 00:35:43 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv11 7/8] iomap: Allocate ifs in ->write_begin() early
Date:   Sat,  1 Jul 2023 13:04:40 +0530
Message-Id: <62b33ebf74e876a0430e32940a7bc0f4868a5e5e.1688188958.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1688188958.git.ritesh.list@gmail.com>
References: <cover.1688188958.git.ritesh.list@gmail.com>
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
index 6abe19c41b30..fb6c2b6a4358 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -561,14 +561,23 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
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
 
 	ifs = ifs_alloc(iter->inode, folio, iter->flags);
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

