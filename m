Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6A6F9B33
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjEGT23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 15:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjEGT22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 15:28:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC3AD3C;
        Sun,  7 May 2023 12:28:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115e652eeso30067244b3a.0;
        Sun, 07 May 2023 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683487706; x=1686079706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7Ew7G9qML4pL47doYyM9uniO4TkPYu8HEc43GhrRfs=;
        b=Y1fXpYDrmQDOpCucQG17f3SI7VUw+1cAxe9VZlsLHnI+MAYw0xqIZituSydbpQneZF
         8frr/pP55DbiyVk0XBiTdFeAQ6kUOqLSJeH0WZOSvg9OTX7PJB5Dc+aplC/2lsHQxNKz
         lafx6TiKJEcjIHwRtOcFLIyTFULHFKAOX+jjbrDkTc7dI7+REQv53b+t4zNpGMeO145s
         zy2JlZjTIbTskBNhf+t30SsTrLanz3yfSZhToEj8L3HcUt1uVAA+L6OnQMSJQVoIlO+4
         X/JdY04QNiFjMr0t3TPtcHZUe8nz5oozm841/rWi6dH+9vzFUdnS4NdIWLg5u7V27b9p
         4/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683487706; x=1686079706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7Ew7G9qML4pL47doYyM9uniO4TkPYu8HEc43GhrRfs=;
        b=bld5sBoiof/x33Jg4DIfjNhBxRj6N5X6G5aKIl0+d/QhGkNXo3ozh52riajnGdSTK+
         UA0gQfLKgNG9ati6HLeh5PvYBdIUCBDeFuy6OaJgWLHk7/h5nEznqhqZkHcfj5KPH4aH
         +DX5/1nao7AFFW2aNB4B15xILYdtoOEI4YHoVzIXtS6rfBaWTq8P7c9KbpzXD9AdUFEP
         t4LNwqdWb9TSiJbgp41OAS4WI1k67xjn8acupPS0otVoWdPIqomfk8W5Ifk9z/k4i6X6
         8GR9TMLYIuGk+5hAxUg2kphppeSkw1JZJzzjCk+ErwXVhYs5q/d9YpvtXDwtHc1qyBEA
         YxzA==
X-Gm-Message-State: AC+VfDwvGY/0DaxQKB/CN0p/xd2f2VJYip4IRhh2JK+6sdOW+BQuIEqt
        nDi4tjTc92CXuIGSHvYJpIHijTzP6js=
X-Google-Smtp-Source: ACHHUZ7lkhpxpTrP4UX4grM7UTazzg62oQk25zG0/f4SeQogZXZSUoJxHCatJCFHYVUhF6a1gp/iYA==
X-Received: by 2002:a17:903:338e:b0:1a1:cb18:7f99 with SMTP id kb14-20020a170903338e00b001a1cb187f99mr6984133plb.30.1683487706362;
        Sun, 07 May 2023 12:28:26 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:80ba:4cb4:7226:d064:79aa])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001a505f04a06sm5485624plb.190.2023.05.07.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 12:28:26 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv5 4/5] iomap: Allocate iop in ->write_begin() early
Date:   Mon,  8 May 2023 00:57:59 +0530
Message-Id: <e8401f45b8e441dc70effdb6b71fb67a3c92f837.1683485700.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683485700.git.ritesh.list@gmail.com>
References: <cover.1683485700.git.ritesh.list@gmail.com>
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
going to add support for per-block dirty state bitmap in iop, this
could cause some performance degradation. The reason is that if we don't
allocate iop during ->write_begin(), then we will never mark the
necessary dirty bits in ->write_end() call. And we will have to mark all
the bits as dirty at the writeback time, that could cause the same write
amplification and performance problems as it is now.

However, for all the writes with (pos, len) which completely overlaps
the given folio, there is no need to allocate an iop during
->write_begin(). So skip those cases.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5103b644e115..25f20f269214 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -599,15 +599,25 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
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
 
 	iop = iop_alloc(iter->inode, folio, iter->flags);
 
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

