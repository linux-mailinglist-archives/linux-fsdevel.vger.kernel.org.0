Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617373A865D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFOQ1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOQ1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:27:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2CC061574;
        Tue, 15 Jun 2021 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hoq0JoTPz7p7CotYaN2gPzifXVA9YFY41r8VJShbg1w=; b=VCKPt1yAPXlhTOt1jSQCoiIFD4
        CmB795grsvoik5GzignNpSKEy2HWZz1tX8LVNU4d6lnO+XH/GDaRj+iXTG2thqk5vP5KB23YbCOhE
        d+IrWqtZAHK4rW+5EEcRNUKSnsjySYDx3+wjbFDw+vwS7AyKXC1c8a7PDCnbVKBw+Mdrfj8Y8K0B/
        VTVuy/5zYDp7pmgis/nCJ7Tp4b547XKjxIK2lkB6zBNBIYD5Hilp9+qG8zTXk/EUo3DsmnkrimyF3
        wpagSHmmyBpFBnS9SVKBEnIWv9EDk7DzZsWc5W5uH5S6iyPZ07JrOq7qaj43bX9xtnH8Kz6cwDjcR
        UU2VBL8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltBqt-0070I8-Tx; Tue, 15 Jun 2021 16:23:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/6] Further set_page_dirty cleanups
Date:   Tue, 15 Jun 2021 17:23:36 +0100
Message-Id: <20210615162342.1669332-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prompted by Christoph's recent patches, here are some more patches to
improve the state of set_page_dirty().  They're all from the folio tree,
so they've been tested to a certain extent.

Matthew Wilcox (Oracle) (6):
  mm/writeback: Move __set_page_dirty() to core mm
  mm/writeback: Use __set_page_dirty in __set_page_dirty_nobuffers
  iomap: Use __set_page_dirty_nobuffers
  fs: Remove anon_set_page_dirty()
  fs: Remove noop_set_page_dirty()
  mm: Move page dirtying prototypes from mm.h

 drivers/dax/device.c    |  2 +-
 fs/buffer.c             | 24 ------------------------
 fs/ext2/inode.c         |  2 +-
 fs/ext4/inode.c         |  2 +-
 fs/fuse/dax.c           |  3 ++-
 fs/gfs2/aops.c          |  2 +-
 fs/iomap/buffered-io.c  | 27 +--------------------------
 fs/libfs.c              | 27 +--------------------------
 fs/xfs/xfs_aops.c       |  4 ++--
 fs/zonefs/super.c       |  4 ++--
 include/linux/fs.h      |  1 -
 include/linux/iomap.h   |  1 -
 include/linux/mm.h      |  4 ----
 include/linux/pagemap.h |  4 ++++
 mm/page-writeback.c     | 37 +++++++++++++++++++++++++++----------
 15 files changed, 43 insertions(+), 101 deletions(-)

-- 
2.30.2

