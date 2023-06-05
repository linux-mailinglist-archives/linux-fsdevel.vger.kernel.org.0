Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302B722CFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjFEQvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjFEQur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:50:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEAA106
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dDFNBT6dk3Yum/aueh1v8IKbB6wtwNZVtVYiiNiWPFo=; b=ajYCn9CXjbYAeVcbDOwXA7qBdc
        u7Vt9kAmaC0s5vU6oO6ODdAtVwn3vugYMT4iYKUWTl8mk41ygxR5VBHR44ShG28XZj+rKWcGeqw8c
        i0hIO74RYJ5QLO4BM7E3PbFK9FTcGHF45a68XKb/vKj9IAOVsuS65zbKGXDuZc/k7xE5KPIyYkDLE
        yuc/0wT+gGwcQX1ofDGeQRJfZxHcf/jq4UwLgzw6jYiHEPLoBAFSLAPf9Gnhf3qo3CaCIWOtcZ7rf
        8NV6QffFWsMpS2hmd3ffOrULv3sr30E13M77sTNDIZvrQo5tn2yrbj+Q729PR7frVU7nsJ+r/hm5b
        84o6itKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6DPa-00CCap-DP; Mon, 05 Jun 2023 16:50:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] ubifs: Convert writeback to use folios
Date:   Mon,  5 Jun 2023 17:50:25 +0100
Message-Id: <20230605165029.2908304-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
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

There are a few transitions going on in the VFS right now.  One is that
we're deprecating and removing ->writepage; all filesystems need to be
converted to ->writepages.  The other is that we're switching filesystems
from using pages to folios so they can support large folios and we can
shrink the size of memmap.

This completely untested series updates ubifs to the current APIs.
You might be able to improve things; for example, it's common for
filesystems to batch up the results of the writepage call and submit
them at the end of the writepages method.  But that would be suitable
for a later patchset.

Matthew Wilcox (Oracle) (4):
  ubifs: Convert from writepage to writepages
  ubifs: Convert ubifs_writepage to use a folio
  ubifs: Use a folio in do_truncation()
  ubifs: Convert do_writepage() to take a folio

 fs/ubifs/file.c | 120 ++++++++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 56 deletions(-)

-- 
2.39.2

