Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6478A64E36B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLOVoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLOVoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E015C76F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TEMZCin7+oHBkvSCHQg6CW2CMjuFdsY2Pu/ShbhbBrM=; b=lsrDnMJ+DImJGiqlTOK7odxsZg
        p4ujuQ1OQOKE+KO5nXp7oxFacdLuPWBc0w23LbXr1XZgOj32iLhSmTZMtePcSx+3FS85bPEQe8vRG
        5/KjW5Xmx1iWHVYzo089t8ZgmIy01k5xrmFJF+vdqKDGPBhNGbVEWnJBYZru+TKNYP/lIiXb0NFGZ
        rRitxigKSDHnfBXwTVrGuihJYRLqPT8cteNta5MxpfOc3O2GCGeGMQ2DKskCAc2eaH10100M9bPNG
        0n7vs5jC1v97IP5JdseBer1ct8MtKgiaGG3oOR5MKLANkfjLhLjQ8QDsehzM1y4mZPJglJB071Zpn
        6ej0mTPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmL6-1g; Thu, 15 Dec 2022 21:44:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/12] Start converting buffer_heads to use folios
Date:   Thu, 15 Dec 2022 21:43:50 +0000
Message-Id: <20221215214402.3522366-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I was hoping that filesystems would convert from buffer_heads to iomap,
but that's not happening particularly quickly.  So the buffer_head
infrastructure needs to be converted from being page-based to being
folio-based.  This is the initial patchset that I hope Andrew will take
for 6.3.  I have a lot of followup patches, but many of them should go
through individual filesystem trees (ext4, f2fs, etc).  They can wait
for 6.4.

Matthew Wilcox (Oracle) (12):
  buffer: Add b_folio as an alias of b_page
  buffer: Replace obvious uses of b_page with b_folio
  buffer: Use b_folio in touch_buffer()
  buffer: Use b_folio in end_buffer_async_read()
  buffer: Use b_folio in end_buffer_async_write()
  page_io: Remove buffer_head include
  buffer: Use b_folio in mark_buffer_dirty()
  gfs2: Replace obvious uses of b_page with b_folio
  jbd2: Replace obvious uses of b_page with b_folio
  nilfs2: Replace obvious uses of b_page with b_folio
  reiserfs: Replace obvious uses of b_page with b_folio
  mpage: Use b_folio in do_mpage_readpage()

 fs/buffer.c                   | 54 +++++++++++++++++------------------
 fs/gfs2/glops.c               |  2 +-
 fs/gfs2/log.c                 |  2 +-
 fs/gfs2/meta_io.c             |  2 +-
 fs/jbd2/commit.c              |  8 ++----
 fs/jbd2/journal.c             |  2 +-
 fs/mpage.c                    |  2 +-
 fs/nilfs2/btnode.c            |  2 +-
 fs/nilfs2/btree.c             |  2 +-
 fs/nilfs2/gcinode.c           |  2 +-
 fs/nilfs2/mdt.c               |  4 +--
 fs/nilfs2/segment.c           |  2 +-
 fs/reiserfs/journal.c         |  4 +--
 fs/reiserfs/tail_conversion.c |  2 +-
 include/linux/buffer_head.h   |  5 +++-
 mm/page_io.c                  |  1 -
 16 files changed, 47 insertions(+), 49 deletions(-)

-- 
2.35.1

