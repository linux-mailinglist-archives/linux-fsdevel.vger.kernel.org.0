Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12A2990DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783637AbgJZPTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 11:19:02 -0400
Received: from casper.infradead.org ([90.155.50.34]:43578 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783631AbgJZPTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tJdlcdGVmO5hb1GVldhbnE4FaImFjKkuAuz1KFFasXY=; b=DWQfni3dYUpdPMXkGjThM7VqH8
        6kijMsd/J434O8lkAqUkW9kCPSPbHrN1t2J6mQuPrQo+69/7r63fSVEopoRZjxYjNoCPGVGD6AJfO
        Ox/o4C++Xv0glhBB/Ytl/w2piiG5HglNneRFupXuwvlhVXrikRPSjwp105nFcZ9T1vLh3r8mrH5jQ
        gjh439PddBlQm1htBsBE0zPyc820WMwlf6W7PZXnZk9TOoO2/HSUKazSvfSsNy7QZu6JE+sIjR59w
        HuGHnbL0JYFjoWziJtq74gxzTxqYFPMQ85HIhnw5xIFRm5yGKl4j4Z7DVhXnn+9X05Ir+8fobVEkJ
        crWmwBWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX4Gp-0006Jr-3D; Mon, 26 Oct 2020 15:18:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 0/4] Remove nrexceptional tracking
Date:   Mon, 26 Oct 2020 15:18:45 +0000
Message-Id: <20201026151849.24232-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We actually use nrexceptional for very little these days.  It's a minor
pain to keep in sync with nrpages, but the pain becomes much bigger
with the THP patches because we don't know how many indices a shadow
entry occupies.  It's easier to just remove it than keep it accurate.

Also, we save 8 bytes per inode which is nothing to sneeze at; on my
laptop, it would improve shmem_inode_cache from 22 to 23 objects per
16kB, and inode_cache from 26 to 27 objects.  Combined, that saves
a megabyte of memory from a combined usage of 25MB for both caches.
Unfortunately, ext4 doesn't cross a magic boundary, so it doesn't save
any memory for ext4.

Matthew Wilcox (Oracle) (4):
  mm: Introduce and use mapping_empty
  mm: Stop accounting shadow entries
  dax: Account DAX entries as nrpages
  mm: Remove nrexceptional from inode

 fs/block_dev.c          |  2 +-
 fs/dax.c                |  8 ++++----
 fs/gfs2/glock.c         |  3 +--
 fs/inode.c              |  2 +-
 include/linux/fs.h      |  2 --
 include/linux/pagemap.h |  5 +++++
 mm/filemap.c            | 16 ----------------
 mm/swap_state.c         |  4 ----
 mm/truncate.c           | 19 +++----------------
 mm/workingset.c         |  1 -
 10 files changed, 15 insertions(+), 47 deletions(-)

-- 
2.28.0

