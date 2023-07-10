Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3974D6D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjGJNES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjGJNEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:04:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B14F2123;
        Mon, 10 Jul 2023 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=r795vGm91lvykHKzEm1Ts4A5WyyKNMg9Cr/ucWaUEaY=; b=bGm7hB1vQZAoOtIR434uLuIR+Q
        hSecTGhXtPdju6a+Ems4UA4mANFkcxJEt8b/3rJQuBhDJOrljpxcn0iQWWtybb+7GELRmTnqxSSiz
        Fsqgf49CPxie90LHsQiZXoAwjr7a6UGYTQXMfoIzCpYgXJOJ9oWNEK76YMGvWl3Gv+J5yTTH3Xq06
        VzjlSu7tKSfyIhJKuDwMU/mdl+Yp5gvo1Yw8kh6UcRNCGpxQX0SUb6gQxp29ZWQUcJWEfuHFCdZd5
        TJZb1mtIBSLUaZ96l8TF8Vn2F4y8+c1RmNJm/baLySgpzGvB9DsqzyHEU1mErQPf6zR0iK4b7DxGz
        9Sx6khyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIqXW-00EcX2-Vg; Mon, 10 Jul 2023 13:02:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v4 0/9] Create large folios in iomap buffered write path
Date:   Mon, 10 Jul 2023 14:02:44 +0100
Message-Id: <20230710130253.3484695-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit ebb7fb1557b1 limited the length of ioend chains to 4096 entries
to improve worst-case latency.  Unfortunately, this had the effect of
limiting the performance of:

fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 \
        -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 \
        -numjobs=4 -directory=/mnt/test

The problem ends up being lock contention on the i_pages spinlock as we
clear the writeback bit on each folio (and propagate that up through
the tree).  By using larger folios, we decrease the number of folios
to be processed by a factor of 256 for this benchmark, eliminating the
lock contention.

It's also the right thing to do.  This is a project that has been on
the back burner for years, it just hasn't been important enough to do
before now.

I think it's probably best if this goes through the iomap tree since
the changes outside iomap are either to the page cache or they're
trivial.

v4:
 - Rebase on v6.5-rc1
 - Add documentation for fgf_set_order()
 - Improve documentation for iomap_get_page()
 - Fix crash caused by shadow kaddr name in copy_page_from_iter_atomic()
 - Add copy_folio_from_iter_atomic()
 - Improve comment in iomap_release_folio()
 - Use __GFP_NORETRY | __GRP_NOWARN to allocate large folios
 - Change an 'unsigned long bytes' to 'size_t bytes' for consistency
 - Restructure iomap_write_iter() loop slightly

v3:
 - Fix the handling of compound highmem pages in copy_page_from_iter_atomic()
 - Rename fgp_t to fgf_t
 - Clarify some wording in the documentation

v2:
 - Fix misplaced semicolon
 - Rename fgp_order to fgp_set_order
 - Rename FGP_ORDER to FGP_GET_ORDER
 - Add fgp_t
 - Update the documentation for ->release_folio
 - Fix iomap_invalidate_folio()
 - Update iomap_release_folio()

Matthew Wilcox (Oracle) (9):
  iov_iter: Handle compound highmem pages in
    copy_page_from_iter_atomic()
  iov_iter: Add copy_folio_from_iter_atomic()
  iomap: Remove large folio handling in iomap_invalidate_folio()
  doc: Correct the description of ->release_folio
  iomap: Remove unnecessary test from iomap_release_folio()
  filemap: Add fgf_t typedef
  filemap: Allow __filemap_get_folio to allocate large folios
  iomap: Create large folios in the buffered write path
  iomap: Copy larger chunks from userspace

 Documentation/filesystems/locking.rst | 15 +++--
 fs/btrfs/file.c                       |  6 +-
 fs/f2fs/compress.c                    |  2 +-
 fs/f2fs/f2fs.h                        |  2 +-
 fs/gfs2/bmap.c                        |  2 +-
 fs/iomap/buffered-io.c                | 54 +++++++++---------
 include/linux/iomap.h                 |  2 +-
 include/linux/pagemap.h               | 82 +++++++++++++++++++++++----
 include/linux/uio.h                   |  9 ++-
 lib/iov_iter.c                        | 43 +++++++++-----
 mm/filemap.c                          | 65 +++++++++++----------
 mm/folio-compat.c                     |  2 +-
 mm/readahead.c                        | 13 -----
 13 files changed, 187 insertions(+), 110 deletions(-)

-- 
2.39.2

