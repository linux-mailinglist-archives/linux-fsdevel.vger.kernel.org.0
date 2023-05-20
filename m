Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8370A939
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjETQgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 12:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETQgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 12:36:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BE4121;
        Sat, 20 May 2023 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lPT5qkiZdP/vagSUo2nsVy6eL2HpLq2sYCMYtk+ODB0=; b=JqrjPdb95axZbIdlkMu0GvjmPl
        P0q+/NYppQGiBPpXlisro4aEUN1g1SCRG9uH+P6YRAmhzfEbDqfZBAZiB1Cm3N9xbVwSeUf3UP9Cv
        2VB8wMUbxI0WJqsxcGjDaLmYbSGX6/7RK3WnmgbuO3wTdrSuXYgTM4nfsjyHLy6DZDo+EDclU38kt
        3Y4Lx0FAUbOjTRpZ7s908Rrc+7Aanm2sahl1jHZpbWwsNFs93dvVVt5O+ldH6AOB9FbylDIXWzPWP
        tSgcX56jSrb6ZwlArpv5jBo9UrcgDt6cv3PvezteMXSGS5nVPZX/WHuT6h+C98FHre8ch+br/6/C4
        9fwgLINQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0PYr-007Wlz-8u; Sat, 20 May 2023 16:36:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 0/3] Create large folios in iomap buffered write path
Date:   Sat, 20 May 2023 17:36:00 +0100
Message-Id: <20230520163603.1794256-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wang Yugui has a workload which would be improved by using large folios.
Until now, we've only created large folios in the readahead path,
but this workload writes without reading.  The decision of what size
folio to create is based purely on the size of the write() call (unlike
readahead where we keep history and can choose to create larger folios
based on that history even if individual reads are small).

The third patch looks like it's an optional extra but is actually needed
for the first two patches to work in the write path, otherwise it limits
the length that iomap_get_folio() sees to PAGE_SIZE.

Matthew Wilcox (Oracle) (3):
  filemap: Allow __filemap_get_folio to allocate large folios
  iomap: Create large folios in the buffered write path
  iomap: Copy larger chunks from userspace

 fs/gfs2/bmap.c          |  2 +-
 fs/iomap/buffered-io.c  | 32 ++++++++++++++++++------------
 include/linux/iomap.h   |  2 +-
 include/linux/pagemap.h | 29 ++++++++++++++++++++++++---
 mm/filemap.c            | 44 ++++++++++++++++++++++++++++-------------
 mm/folio-compat.c       |  2 +-
 mm/readahead.c          | 13 ------------
 7 files changed, 78 insertions(+), 46 deletions(-)

-- 
2.39.2

