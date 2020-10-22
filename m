Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906E0296687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372263AbgJVVWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897748AbgJVVWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:22:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E405C0613D2;
        Thu, 22 Oct 2020 14:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/G6plsTDuLLi41lWwfSKsVW5KJYWwk8QiIuvJmYW4EE=; b=o06/f9QvYVKSEgEE6eVUb3zkXe
        95w1+d+U9YL2cmW3VGydPZjeh1XGu7Bex8YVd11m7tNBge/S6CH6MF0XuWCpj4fOocm4ZQTgJPz9v
        U1hRS4O2yA4PbvlxaqvC9Qb+UmIGsvsRUdfq/xh1gbn3znx5S2FnyOTTpwdWsuA3LuKUXoehYOjNg
        CP7fowiv+vy2jJ/cCV4b2RKVYZnUucdYwr94XC2VtORxS5Yw7g4g0/9MZWj5GzIf+GN9ZDEO+t97X
        h0jN9egTDojBTvM0xogn2XcPj8y/bdo2p6t/46W9HbvYI11K1DY2y7X4PJBPXQ6PWelUtyYfzpbbr
        82bSsL/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVi2X-00046C-Bg; Thu, 22 Oct 2020 21:22:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/6] Make block_read_full_page synchronous
Date:   Thu, 22 Oct 2020 22:22:22 +0100
Message-Id: <20201022212228.15703-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset does I/Os in larger chunks, if the blocks are adjacent.
More importantly, it returns the actual error from ->readpage for
filesystems which use block_read_full_page().  Unless fscrypt returns
an error, in which case it turns into EIO because it has to roundtrip
through bi_status.

I don't have a system with fscrypt enabled, so I'd appreciate some
testing from the fscrypt people.

Matthew Wilcox (Oracle) (6):
  block: Add blk_completion
  fs: Return error from block_read_full_page
  fs: Convert block_read_full_page to be synchronous
  fs: Hoist fscrypt decryption to bio completion handler
  fs: Turn decrypt_bh into decrypt_bio
  fs: Convert block_read_full_page to be synchronous with fscrypt
    enabled

 block/blk-core.c    |  61 +++++++++
 fs/buffer.c         | 304 ++++++++++++++++++++++----------------------
 include/linux/bio.h |  11 ++
 3 files changed, 226 insertions(+), 150 deletions(-)

-- 
2.28.0

