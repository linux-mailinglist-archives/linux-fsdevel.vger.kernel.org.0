Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9F734A44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjFSC32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjFSC31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3AE49;
        Sun, 18 Jun 2023 19:29:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666683eb028so1464079b3a.0;
        Sun, 18 Jun 2023 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141765; x=1689733765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avYaHpRrNXBTBhOS3iew364J6rgNtP8dJzHXxbv0G/s=;
        b=WirzkyTrrRuOs/txJ6VhSCPkRu1BBkPQS0WjnOYST30Bc8p21h+G/10hWQ0SxZtena
         edLRLdEWROAW02bYQmk/oLwMiALkQcSegSzPIxtPQwucdupHSL7Cd9ZXWfU8sP+Vc9wQ
         2w1oP3OfE7YlEFm3VXNV0UPz+NUwMFVgKEOd2MH+zukx2O8ociScjKHAiSt0q6l6rWYC
         2BAEpFHHJjGYp2W2j//dkI+oBG5vqSfDBWwoBTb/kb/KOdVXw9RtomEAFKo8YbaxY/CT
         wWYZXvVjEcFHz/wlLGSuICaxr4XuFBNTSH3swFao8Ppy7kiVWh8Yze6hMxjo9DA2+DV4
         Jpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141765; x=1689733765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avYaHpRrNXBTBhOS3iew364J6rgNtP8dJzHXxbv0G/s=;
        b=Jl7B/AwOfeLzSd8UcbjC8Bg1sQl+uaXaKtt5cWhqoPdRFJuHOMqv6ZlLSl0dCgGFNP
         kvQ7J5MRXCZPFSQnvTdvm9HEJGClyyL8s+OZ9DHpI3HHOvA1EZjWDt8jc8uziLnNTL3d
         CJ8kEy/YS7PWVK2ECFqp5D0SGHz1kG8Lv+2Nr72Jsy5T/sCX5kkL0v7HRniut3z+g5eq
         RSrBz2AGR2QTlaFLUspzfkwwkyCuSFpBhGPRQqE3gSP/pzqFXjUiYHG+w9dSrphB87uS
         V20Ysqqoz7kH7i6kPkDlun7o0P3GZLhEj3It2YpY5UFhA/YwXXmLQZAykhy7HHVvoDCC
         xXDA==
X-Gm-Message-State: AC+VfDzr/XfbYPkQNwtLvBGJ1mZo9HwFUdKqxEyqXorTyb1VcH3Nphd+
        r1Ax0E+WUZnuoTCpWBM4nHb46OtSsw0=
X-Google-Smtp-Source: ACHHUZ5GyfNaCMcyjkbFcM/T9XDWgBWjEdBVvPZj2gDiQkPZHAJPGTEfm0G2LYGzyJBkdwf1U0k5Kg==
X-Received: by 2002:a05:6a00:2342:b0:668:71a1:2e68 with SMTP id j2-20020a056a00234200b0066871a12e68mr1451293pfj.11.1687141765332;
        Sun, 18 Jun 2023 19:29:25 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:29:24 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv10 7/8] iomap: Allocate ifs in ->write_begin() early
Date:   Mon, 19 Jun 2023 07:58:50 +0530
Message-Id: <cf54798bfcc720c70b489ff859e9a1672f57c064.1687140389.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687140389.git.ritesh.list@gmail.com>
References: <cover.1687140389.git.ritesh.list@gmail.com>
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
index 2d79061022d8..391d918ddd22 100644
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

