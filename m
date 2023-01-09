Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44BA661E53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjAIFSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjAIFSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F4CE19;
        Sun,  8 Jan 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JpiAG5g4jSuC1TENXR2TieCP/vbxO2sPm9LP2RA2O3o=; b=Mal8Bd3GRbqjg5vIbj+VWqPjWx
        alh9hhMGbydpvnDO2DrivhrnhNeQkAc1hvlOtrueBM5JfdQiWIowjkQQR5O0baCYMYumhIfjdAo4z
        zZ/TV4Ij4wZ7gXQzixv4CrdrdvHBX/ocACy9IlIifeTFEnWy1hooc3TfF99cX3sqEQaVBoSPB2GYT
        MStTBFKjAxDov5hTr4TRVTDD3ls460ybY0XkaCUwxS4EuK7OcVZeLtv1DeU65KqFVs05YbwSF0PfT
        C5VunMTKsJIRkJufU/Bl/1Qzcdp0LNTCwqmVLL3UVGuePyHKEoRdcAxLvBN+fiQirZgy0jaeXFej5
        R0S3+1xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYC-0020wk-K7; Mon, 09 Jan 2023 05:18:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 00/11] Remove AS_EIO and AS_ENOSPC
Date:   Mon,  9 Jan 2023 05:18:12 +0000
Message-Id: <20230109051823.480289-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Finish the work of converting every user to the "new" wb_err
infrastructure.  This will clash with Christoph's patch series to remove
folio_write_one(), so I'll redo this after that patch series goes in.

Matthew Wilcox (Oracle) (11):
  memory-failure: Remove comment referencing AS_EIO
  filemap: Remove filemap_check_and_keep_errors()
  f2fs: Convert f2fs_wait_on_node_pages_writeback() to errseq
  fuse: Convert fuse_flush() to use file_check_and_advance_wb_err()
  page-writeback: Convert folio_write_one() to use an errseq
  filemap: Convert filemap_write_and_wait_range() to use errseq
  filemap: Convert filemap_fdatawait_range() to errseq
  cifs: Remove call to filemap_check_wb_err()
  mm: Remove AS_EIO and AS_ENOSPC
  mm: Remove filemap_fdatawait_range_keep_errors()
  mm: Remove filemap_fdatawait_keep_errors()

 block/bdev.c            |   8 +--
 fs/btrfs/extent_io.c    |   6 +--
 fs/cifs/file.c          |   8 ++-
 fs/f2fs/data.c          |   2 +-
 fs/f2fs/node.c          |   4 +-
 fs/fs-writeback.c       |   7 +--
 fs/fuse/file.c          |   3 +-
 fs/jbd2/commit.c        |  12 ++---
 fs/xfs/scrub/bmap.c     |   2 +-
 include/linux/pagemap.h |  23 ++------
 mm/filemap.c            | 113 +++++++---------------------------------
 mm/memory-failure.c     |  28 ----------
 mm/page-writeback.c     |  17 +++---
 13 files changed, 51 insertions(+), 182 deletions(-)

-- 
2.35.1

