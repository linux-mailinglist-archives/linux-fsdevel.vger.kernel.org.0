Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C393517D83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiECGoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiECGns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA25BC40
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Cb46T9bc3lbPjQ1ZfXo0xd2btUkN2n8twuieAr/P9UI=; b=vX9sHqUJFhjCFWoJoxW/eZoAF+
        nHK+WCthv6lplqnyyQ2otp8twIwQ0dNTUYhL+lsGtDmUyH9J4X/r/gAMIz1Ka5ltPGxuuYfsddYLO
        CcFINYrLs5o8RFvHoV6U+eJzF5BEJIzqYUcMN12G/gfV8ILMb8TqKdDwKNLLf9Ys51AqiKUGsLyrL
        7/3fWOOrWfKYmgHrsJhkOpmqq1gf0E0yNpriLF7urpD//PiqRiUJ04cuAKKcWnD3IsxzsxnwpSKol
        0l8bNSttu+FAI5rOne564EksnCz94iCdVLbLBMw23yWzk4bpfnit+xB1xlu4ZIWmqpJz37X8wH00Z
        mycj0ptA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCh-00FRxC-JV; Tue, 03 May 2022 06:40:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 00/10] Make O_SYNC writethrough
Date:   Tue,  3 May 2022 07:39:58 +0100
Message-Id: <20220503064008.3682332-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is very much in development and basically untested, but Damian
started describing to me something that he wanted, and I told him he
was asking for the wrong thing, and I already had this patch series
in progress.  If someone wants to pick it up and make it mergable,
that'd be grand.

The idea is that an O_SYNC write is always going to want to write, and
we know that at the time we're storing into the page cache.  So for an
otherwise clean folio, we can skip the part where we dirty the folio,
find the dirty folios and wait for their writeback.  We can just mark the
folio as writeback-in-progress and start the IO there and then (where we
know exactly which blocks need to be written, so possibly a smaller I/O
than writing the entire page).  The existing "find dirty pages, start
I/O and wait on them" code will end up waiting on this pre-started I/O
to complete, even though it didn't start any of its own I/O.

The important part is patch 9.  Everything before it is boring prep work.
I'm in two minds about whether to keep the 'write_through' bool, or
remove it.  So feel to read patches 9+10 squashed together, or as if
patch 10 doesn't exist.  Whichever feels better.

The biggest problem with all this is that iomap doesn't have the necessary
information to cause extent allocation, so if you do an O_SYNC write
to an extent which is HOLE or DELALLOC, we can't do this optimisation.
Maybe that doesn't really matter for interesting applications.  I suspect
it doesn't matter for ZoneFS.

Matthew Wilcox (Oracle) (10):
  iomap: Pass struct iomap to iomap_alloc_ioend()
  iomap: Remove iomap_writepage_ctx from iomap_can_add_to_ioend()
  iomap: Do not pass iomap_writepage_ctx to iomap_add_to_ioend()
  iomap: Accept a NULL iomap_writepage_ctx in iomap_submit_ioend()
  iomap: Allow a NULL writeback_control argument to iomap_alloc_ioend()
  iomap: Pass a length to iomap_add_to_ioend()
  iomap: Reorder functions
  iomap: Reorder functions
  iomap: Add writethrough for O_SYNC
  remove write_through bool

 fs/iomap/buffered-io.c | 492 +++++++++++++++++++++++------------------
 1 file changed, 273 insertions(+), 219 deletions(-)

-- 
2.34.1

