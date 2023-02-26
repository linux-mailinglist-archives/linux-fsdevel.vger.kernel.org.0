Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33616A33BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 20:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBZTnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 14:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZTnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:43:49 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B106CDF9;
        Sun, 26 Feb 2023 11:43:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id bh1so4635301plb.11;
        Sun, 26 Feb 2023 11:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8otH9D0xkr0mctGwVducUHZTnITM9LSk5SlRTLUFUZs=;
        b=DSxLK/+njUj7XZLpIGn0fVX3Vis6N0zDSar28wIBYs7XpeXMESV0nxXpZhi9hEwdrH
         L/wB/O5ggDA+b9l3vXtFQgaE9kV05ZUnE2GR0Qw/2kxvJtW1I3P4vintDDwG0EAJc54q
         al2B6PeJt3nRTkPV59diGaVO9rJKdU1pSk6gG6e1sUEeXPjZtTF3CxTh2kUrxgbq1vd1
         TtKwGBydwjApM6MLkz5B2mRueEA8/hv5R12xDQhZrOnDGzOTadJhtGtpBQADsxgYPggC
         AVSRN4qCxx73wOocJfKFRr6FEPsHUmgtcvebFCFjn03775+RdFleT+Ln7dQhe5Qfh1Dc
         HMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8otH9D0xkr0mctGwVducUHZTnITM9LSk5SlRTLUFUZs=;
        b=dm4X892dJJ5VydWxQfNkRHtMtOVddpjLFXAYceSYYWN2B5kQEFZt03Pc8IrTFMIY3f
         opvtEpNwpGYu+AzpfZS4+56lOC1jRFw0aH/1SM2wMD8f5Kx9wRx5HS0Ye5VPsOO48vDE
         +Gv5eKemj2SvAX9EjI/lzgg4b/aKMWkbRRMPUnqu1CDXALqbD4+bzL/MnpJulkzBd3pR
         dlQ9WK/+rzDZUi91D2oz72Idd3OdHJkAyIWtt4LBI/gGAs8bY3SNDtsC3afOpravEP+/
         M33Gjqj5a0dsf8q9CEMctH2qGihLDbPybXVB2camtfrT5gX/Oel9KeAGPOQsPeMo8joK
         UGCg==
X-Gm-Message-State: AO0yUKV+a0kd2RwHWQ3ioP/hC/6U+aID8/A79s1Wz1B3YfKC11hVaeMH
        7le1zQ1NAdKWlGienCvkPYEYYhPlNKE=
X-Google-Smtp-Source: AK7set/2qsQO/AvEexJffDq+q7q967IwMhoTVloPKClYkwTeVJjzikgY10ab8siuC3Pv1ksRGKoWHw==
X-Received: by 2002:a05:6a20:6a1d:b0:be:e0c3:5012 with SMTP id p29-20020a056a206a1d00b000bee0c35012mr6110610pzk.1.1677440627531;
        Sun, 26 Feb 2023 11:43:47 -0800 (PST)
Received: from rh-tp.. ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id r15-20020a62e40f000000b00582f222f088sm2815606pfh.47.2023.02.26.11.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 11:43:47 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv3 1/3] iomap: Allocate iop in ->write_begin() early
Date:   Mon, 27 Feb 2023 01:13:30 +0530
Message-Id: <34dafb5e15dba3bb0b0e072404ac6fb9f11561b8.1677428794.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677428794.git.ritesh.list@gmail.com>
References: <cover.1677428794.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/iomap/buffered-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 356193e44cf0..c5b51ab1184e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -535,11 +535,16 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	size_t from = offset_in_folio(folio, pos), to = from + len;
 	size_t poff, plen;
 
+	if (pos <= folio_pos(folio) &&
+	    pos + len >= folio_pos(folio) + folio_size(folio))
+		return 0;
+
+	iop = iomap_page_create(iter->inode, folio, iter->flags);
+
 	if (folio_test_uptodate(folio))
 		return 0;
 	folio_clear_error(folio);
 
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
 
-- 
2.39.2

