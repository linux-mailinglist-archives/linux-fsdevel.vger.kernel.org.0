Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B581743854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjF3J2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 05:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjF3J2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:28:03 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D103585;
        Fri, 30 Jun 2023 02:27:59 -0700 (PDT)
X-UUID: 49c20d01bb1742a2929c98f6673a3996-20230630
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:dbfa2abb-c31d-4064-9571-2b6cf7634457,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:25
X-CID-INFO: VERSION:1.1.27,REQID:dbfa2abb-c31d-4064-9571-2b6cf7634457,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:25
X-CID-META: VersionHash:01c9525,CLOUDID:e86f6a0d-26a8-467f-b838-f99719a9c083,B
        ulkID:230630172253SNXIHJA1,BulkQuantity:1,Recheck:0,SF:19|44|38|24|17|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 49c20d01bb1742a2929c98f6673a3996-20230630
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <zenghongling@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 551433021; Fri, 30 Jun 2023 17:27:45 +0800
From:   zenghongling <zenghongling@kylinos.cn>
To:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhongling0719@126.com, zenghongling <zenghongling@kylinos.cn>
Subject: [PATCH] fs: Optimize unixbench's file copy test
Date:   Fri, 30 Jun 2023 17:28:23 +0800
Message-Id: <1688117303-8294-1-git-send-email-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The iomap_set_range_uptodate function checks if the file is a private
mapping,and if it is, it needs to do something about it.UnixBench's
file copy tests are mostly share mapping, such a check would reduce
file copy scores, so we added the unlikely macro for optimization.
and the score of file copy can be improved after branch optimization.
As follows:

./Run -c 8 -i 3 fstime fsbuffer fsdisk

Before the optimization
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
File Copy 1024 bufsize 2000 maxblocks          3960.0     689276.0   1740.6
File Copy 256 bufsize 500 maxblocks            1655.0     204133.0   1233.4
File Copy 4096 bufsize 8000 maxblocks          5800.0    1526945.0   2632.7
                                                                   ========
System Benchmarks Index Score (Partial Only)                         1781.3

After the optimization
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
File Copy 1024 bufsize 2000 maxblocks          3960.0     741524.0   1872.5
File Copy 256 bufsize 500 maxblocks            1655.0     208334.0   1258.8
File Copy 4096 bufsize 8000 maxblocks          5800.0    1641660.0   2830.4
                                                                   ========
System Benchmarks Index Score (Partial Only)                         1882.6

Signed-off-by: zenghongling <zenghongling@kylinos.cn>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 53cd7b2..35a50c2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -148,7 +148,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	if (PageError(page))
 		return;
 
-	if (page_has_private(page))
+	if (unlikely(page_has_private(page)))
 		iomap_iop_set_range_uptodate(page, off, len);
 	else
 		SetPageUptodate(page);
-- 
2.1.0

