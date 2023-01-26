Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16067D600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjAZUNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjAZUND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:13:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE0759994
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 12:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Q95PJ/HsnVy3AYjq8GVq9vgQLW9v8UMWZb9EKREwNC0=; b=kBMK9zaWFzObrWzPVnRPhGp347
        FT4s4WRO6FhtclsQwj13tuBrepuFCU6FMdtMzGQUkQz8lek6iG7FZVA1LFrKuxVDRuYVzD642+AxI
        ixrsn8+JGg2JWVXzt+1fgkq2P8NN44fwRiSzyBqHhNaNK3n+QS0ul7wFsbjPxofPD4v1PjB3pE2ZY
        d571kHAus9M3Jb9LYVxd2m9jdSNKx5PNaBFzGX+jFRPUD3iFkLC24tXNvGXXa9VcNWAUfL27UTC8X
        0otsdzAT2oLk9E2ERv3XgI5f43RnDgPmU5kI2rxyOZCKzy0eyLFUOoXtxRgAcRwX5kTYSUiqwWf5o
        VZNHAkBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8cD-0073M6-BX; Thu, 26 Jan 2023 20:12:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/2] Convert writepage_t to use a folio
Date:   Thu, 26 Jan 2023 20:12:53 +0000
Message-Id: <20230126201255.1681189-1-willy@infradead.org>
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

Against next-20230125.  More folioisation.  I split out the mpage
work from everything else because it completely dominated the patch,
but some implementations I just converted outright.

Matthew Wilcox (Oracle) (2):
  fs: Convert writepage_t callback to pass a folio
  mpage: Convert __mpage_writepage() to use a folio more fully

 fs/cifs/file.c            |  8 +++----
 fs/ext4/inode.c           |  4 ++--
 fs/ext4/super.c           |  6 ++---
 fs/fuse/file.c            | 18 +++++++--------
 fs/iomap/buffered-io.c    |  5 ++---
 fs/mpage.c                | 46 +++++++++++++++++++--------------------
 fs/nfs/write.c            |  7 +++---
 fs/ntfs3/inode.c          |  6 ++---
 fs/orangefs/inode.c       | 23 ++++++++++----------
 include/linux/writeback.h |  2 +-
 mm/page-writeback.c       |  6 ++---
 11 files changed, 64 insertions(+), 67 deletions(-)

-- 
2.35.1

