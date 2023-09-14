Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9364E7A0856
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbjINPAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbjINPAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:00:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6058C1FC2;
        Thu, 14 Sep 2023 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/PUYrMbpW5so2WH0/IzeL++7YJb9b4afMmUYKTd+Jog=; b=l/trSs8W5Wg0NkK4LQIWJB2VhJ
        9+HKX34Cws3o7HmPUQcA5SmAsGs9pRYqAyreiB8cd4r32janHkBqx/9KY5LDUWEXtPaVTszMk51z6
        V4lLzNXvrdwu2C1ZA8CbPDQMczLSFKGZNzwztSxgvIIV/AMv3QLjQSfXbY9r6HQvmEEGGqw8CT++2
        QonhERFPgEsagksjbEiOtjnNR0btRu3pBTs84T8aY/7OBFRfthsX/JSfUWMVuBnqUrPt8+X396C8m
        lPo18e3oSX30h6KaYZCf7G5KH0d+b6xXqIjzEyeQJvpjYH9XibnmiKPyPRrm+2jEGc0Rp+98u7q/N
        9Tx3A9Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgnpF-003XOH-E8; Thu, 14 Sep 2023 15:00:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 0/8] Add and use bdev_getblk()
Date:   Thu, 14 Sep 2023 16:00:03 +0100
Message-Id: <20230914150011.843330-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series fixes a bug reported by Hui Zhu; see proposed
patches v1 and v2:
https://lore.kernel.org/linux-fsdevel/20230811035705.3296-1-teawaterz@linux.alibaba.com/
https://lore.kernel.org/linux-fsdevel/20230811071519.1094-1-teawaterz@linux.alibaba.com/

I decided to go in a rather different direction for this fix, and
fix a related problem at the same time.  I don't think there's any
urgency to rush this into Linus' tree, nor have I marked it for stable.
Reasonable people may disagree.

For v2, I fixed a bug around the use of __GFP_ACCOUNT, and Jan Kara
pushed me into making __getblk_gfp() disappear entirely (patches 5-8).
It's currently churning through xfstests and has got up to generic/048.

Matthew Wilcox (Oracle) (8):
  buffer: Pass GFP flags to folio_alloc_buffers()
  buffer: Hoist GFP flags from grow_dev_page() to __getblk_gfp()
  ext4: Use bdev_getblk() to avoid memory reclaim in readahead path
  buffer: Use bdev_getblk() to avoid memory reclaim in readahead path
  buffer: Convert getblk_unmovable() and __getblk() to use bdev_getblk()
  buffer: Convert sb_getblk() to call __getblk()
  ext4: Call bdev_getblk() from sb_getblk_gfp()
  buffer: Remove __getblk_gfp()

 fs/buffer.c                 | 79 ++++++++++++++++++++-----------------
 fs/ext4/super.c             | 13 ++++--
 include/linux/buffer_head.h | 53 ++++++++++++++-----------
 3 files changed, 83 insertions(+), 62 deletions(-)

-- 
2.40.1

