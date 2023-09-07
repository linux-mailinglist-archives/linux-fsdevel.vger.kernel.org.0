Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD97975E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbjIGQAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjIGP5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:57:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A13A5E8;
        Thu,  7 Sep 2023 08:45:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3E1C43395;
        Thu,  7 Sep 2023 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101421;
        bh=gPv1hrWujrYrqcEzo6YrUNSY/Ae1f3uO3rmjz4i7sUY=;
        h=From:To:Cc:Subject:Date:From;
        b=jPF3cRxboKs/FmnIXmlF95nO9MrK9e2kAZ1S5CZQpQdz1yvhZI3SBDBwlgMCqeRm2
         BOSgmsMLMMRaHvIyZ4GEiZxqrt1X2U4rSb1CpSkwNy9BaZmnzfzYuecZLLTJjIjcwi
         /4IbyiuOMdS1l+bXgu/5bhLvqBj4XA348ZrEIGscf/XxVeJrcFfhysNkEo6z/awCcL
         Y0Stt4UKPGsQtSW3beMMxjF3a03tvhD8bLOjQBw1V8VgEAe1SKJcBQVEjjWL2BQEYj
         hB9zRUgWRbWDNplGWRu99SbRgEzKyw/yWGjNE8lXEu1vRSQPdGKMNmm6H4ADjjRPUw
         zKT77vhV9Fn0Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 1/6] iomap: Fix possible overflow condition in iomap_write_delalloc_scan
Date:   Thu,  7 Sep 2023 11:43:32 -0400
Message-Id: <20230907154338.3421582-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

[ Upstream commit eee2d2e6ea5550118170dbd5bb1316ceb38455fb ]

folio_next_index() returns an unsigned long value which left shifted
by PAGE_SHIFT could possibly cause an overflow on 32-bit system. Instead
use folio_pos(folio) + folio_size(folio), which does this correctly.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index aa8967cca1a31..4dc4bbc4be10a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -932,7 +932,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 			 * the end of this data range, not the end of the folio.
 			 */
 			*punch_start_byte = min_t(loff_t, end_byte,
-					folio_next_index(folio) << PAGE_SHIFT);
+					folio_pos(folio) + folio_size(folio));
 		}
 
 		/* move offset to start of next folio in range */
-- 
2.40.1

