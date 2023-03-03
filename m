Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3512B6A912F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 07:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCCGne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 01:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCCGn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:43:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D2C43456;
        Thu,  2 Mar 2023 22:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qukgUsnL0HeweA+cvebxOaoYEWplxTmUTdjr+sGSOeg=; b=l3W1QHi1OdaKVKRklBDMjjhQbY
        HmzPnhRtHxtr+dIyEARLwn/wqx7vxTmOm0BVToG+i7PUA9u6R05Euae9CEcZtgobqoktJc9hNzF2R
        0UGE2x1nZFmtpjUjTCja1QsIsE+SrwxoemZESUUrnDgkiDpaNSmVuSVsAjDC16BfzGXmatB7fZwe/
        ehUkIIeiCOXZxKKORYJbuGnAj7Jm3iTXk1f/Qe0zUb31gj1pw61Ssq6sEZ8jfX2QNyC3bsSB1hQyp
        WizaJv+FkCqfzr5lQWATM27B2Cw4C+f1nqXP/+8xyWyRggqde9OHuq8gaRXhnsQYIwIL4lfGwD7RV
        wTjwN9Hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXz8P-002wO4-A5; Fri, 03 Mar 2023 06:43:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Gao Xiang <xiang@kernel.org>
Subject: [PATCH 0/2] folio_copy_tail
Date:   Fri,  3 Mar 2023 06:43:13 +0000
Message-Id: <20230303064315.701090-1-willy@infradead.org>
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

I'm trying to make it easy & efficient for a filesystem to read its file
tails into a folio.  iomap's implementation was pretty good, but had
some limitations (eg tails couldn't cross a page boundary).

This should be an all-singing, all-dancing implementation which copies
the correct part of the buffer into the correct part of the folio and
zeroes the remainder of the folio.  It should work with highmem, but
the calculations are a bit tricky and I may have got something wrong.

For some reason I'm currently running an XFS test against it, even
though I know XFS doesn't support inline data.  If there's good feedback,
I'll take a look at converting udf_adinicb_readpage() and other similar
functions.

Matthew Wilcox (Oracle) (2):
  filemap: Add folio_copy_tail()
  iomap: Use folio_copy_tail()

 fs/iomap/buffered-io.c  | 23 +++++------------
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 17 deletions(-)

-- 
2.39.1

