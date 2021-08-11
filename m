Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6333E882A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhHKCsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhHKCsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:48:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F74C061765;
        Tue, 10 Aug 2021 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2XuCxlz/1YTqakbASVBX4xXFDeh/5u+JwQTEabNEucE=; b=bmKKXtsyjI0D7yhF7nLVL5U7Uv
        rnZhA9yupgDi0muRLGZW5tYsGBggZr1saCuQbKCY7yJz4JeeOe7BSpTytIVSpj+hQPBbivgdsjaWl
        DlN0xL0hiOJlwVceOCWLbY+l4D/YI/Q3uMvncML3q/YrahnGOAVI+SMUaDAgEP2uj42DgLSflLFqo
        mIJacEKKAJtf+8dm9sjS4u7OSmZlnXhY27JJNNM253HGtsc3L1TbtImH6q8+5SgNC9yhrpIMkYqB3
        VK87AdQTKOyVynoX08HOXr9HcqhQMV2qrd7iQGH7Ht6GBJOxp7ou9n67GppGz9NMc6gJNCewQ9jNh
        M7NqZfUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeGW-00Cs4P-Ex; Wed, 11 Aug 2021 02:46:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/8] iomap writethrough for O_SYNC writes
Date:   Wed, 11 Aug 2021 03:46:39 +0100
Message-Id: <20210811024647.3067739-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Files opened with O_SYNC (... or similar) are currently handled by writing
to the page, marking it dirty, then finding all dirty pages, clearing
their dirty bit, marking them as writeback and waiting for the writeback
to complete.  This patchset bypasses two of those steps by marking the
pages as writeback from the beginning.  It can also be more precise about
which bytes in the page are dirty, reducing the number of bytes written.

This whole patchset will have to be redone on top of Christoph's recent
iomap_iter patches.  That's OK, but it's partly why I've added some
forward declarations instead of reorganising the file so they're not
needed.

Matthew Wilcox (Oracle) (8):
  iomap: Pass struct iomap to iomap_alloc_ioend()
  iomap: Remove iomap_writepage_ctx from iomap_can_add_to_ioend()
  iomap: Do not pass iomap_writepage_ctx to iomap_add_to_ioend()
  iomap: Accept a NULL iomap_writepage_ctx in iomap_submit_ioend()
  iomap: Pass iomap_write_ctx to iomap_write_actor()
  iomap: Allow a NULL writeback_control argument to iomap_alloc_ioend()
  iomap: Pass a length to iomap_add_to_ioend()
  iomap: Add writethrough for O_SYNC

 fs/iomap/buffered-io.c | 168 +++++++++++++++++++++++++++++------------
 1 file changed, 120 insertions(+), 48 deletions(-)

-- 
2.30.2

