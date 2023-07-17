Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28E875690B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGQQXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 12:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGQQXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:23:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698001B6;
        Mon, 17 Jul 2023 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=duT/m3Hd3Z4Y2RKmKZpeJ99AKfX3MN9dkuBLS4jq2kg=; b=p7CvstCwXJSjBe/sv5P9ORiwfA
        CkL1ChzNrUtW1W5eOcMnAbQ5WcfRJm+pRsxpFOTd00w6NoQsj+EV0yrgqaYsWZ5cza0IH+Fkss3LI
        yrv2JCbeDcdHtXJF3ENMro/YNbwiHLUmzklSi4e3w6LgV/DeSyub/eF7TqcO8JmBsK5y/mdd6oH6n
        epHdnOD0Uc5kLpKYkDba9Ms3toVVuVbNya4oB07r5NpfzdKNJx3uTp0c1f4HC+9MbkSehz+8X7ltT
        h3k7fTKnP3wJOLWTsiAMV+q9NGh8sXe++2AIe6zzWRzNcZaBtAWsxsH9WBmdPVcjLzMSl8vmABYSW
        Eko0zZCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLR0k-0044au-6W; Mon, 17 Jul 2023 16:23:46 +0000
Date:   Mon, 17 Jul 2023 17:23:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Create large folios in iomap buffered write path
Message-ID: <ZLVrEkVU2YCneoXR@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 5b8d6e8539498e8b2fa67fbcce3fe87834d44a7a:

  Merge tag 'xtensa-20230716' of https://github.com/jcmvbkbc/linux-xtensa (2023-07-16 14:12:49 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/large-folio-writes

for you to fetch changes up to b684c2e69df4883c2d00045bdd159b6a94d28c98:

  iomap: Copy larger chunks from userspace (2023-07-16 17:53:18 -0400)
----------------------------------------------------------------

Compared to the last version I sent out by email, I split the
copy_page_from_iter_atomic() change into two pieces based on Luis &
Christoph's feedback.  There should be no other changes.  I also added
the Reviewed-by tags that were offered.

----------------------------------------------------------------
Create large folios in iomap buffered write path

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

Creating large folios in the buffered write path is also the right
thing to do.  It's a project that has been on the back burner for years,
it just hasn't been important enough to do before now.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (10):
      iov_iter: Map the page later in copy_page_from_iter_atomic()
      iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()
      iov_iter: Add copy_folio_from_iter_atomic()
      iomap: Remove large folio handling in iomap_invalidate_folio()
      doc: Correct the description of ->release_folio
      iomap: Remove unnecessary test from iomap_release_folio()
      filemap: Add fgf_t typedef
      filemap: Allow __filemap_get_folio to allocate large folios
      iomap: Create large folios in the buffered write path
      iomap: Copy larger chunks from userspace

 Documentation/filesystems/locking.rst | 15 +++++--
 fs/btrfs/file.c                       |  6 +--
 fs/f2fs/compress.c                    |  2 +-
 fs/f2fs/f2fs.h                        |  2 +-
 fs/gfs2/bmap.c                        |  2 +-
 fs/iomap/buffered-io.c                | 54 +++++++++++------------
 include/linux/iomap.h                 |  2 +-
 include/linux/pagemap.h               | 82 ++++++++++++++++++++++++++++++-----
 include/linux/uio.h                   |  9 +++-
 lib/iov_iter.c                        | 43 +++++++++++-------
 mm/filemap.c                          | 65 ++++++++++++++-------------
 mm/folio-compat.c                     |  2 +-
 mm/readahead.c                        | 13 ------
 13 files changed, 187 insertions(+), 110 deletions(-)

