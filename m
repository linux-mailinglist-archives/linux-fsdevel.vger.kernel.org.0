Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE17382B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 14:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjFUMDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjFUMDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:03:24 -0400
Received: from out28-67.mail.aliyun.com (out28-67.mail.aliyun.com [115.124.28.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880EA1731;
        Wed, 21 Jun 2023 05:03:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05035161|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0594308-0.000475321-0.940094;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.TaOR52l_1687348985;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.TaOR52l_1687348985)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 20:03:11 +0800
Date:   Wed, 21 Jun 2023 20:03:13 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v3 0/8] Create large folios in iomap buffered write path
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
In-Reply-To: <20230612203910.724378-1-willy@infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
Message-Id: <20230621200305.23CB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> Commit ebb7fb1557b1 limited the length of ioend chains to 4096 entries
> to improve worst-case latency.  Unfortunately, this had the effect of
> limiting the performance of:
> 
> fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 \
>         -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 \
>         -numjobs=4 -directory=/mnt/test
> 
> The problem ends up being lock contention on the i_pages spinlock as we
> clear the writeback bit on each folio (and propagate that up through
> the tree).  By using larger folios, we decrease the number of folios
> to be processed by a factor of 256 for this benchmark, eliminating the
> lock contention.
> 
> It's also the right thing to do.  This is a project that has been on
> the back burner for years, it just hasn't been important enough to do
> before now.
> 
> I think it's probably best if this goes through the iomap tree since
> the changes outside iomap are either to the page cache or they're
> trivial.
> 
> v3:
>  - Fix the handling of compound highmem pages in copy_page_from_iter_atomic()
>  - Rename fgp_t to fgf_t
>  - Clarify some wording in the documentation

This v3 patches broken linux 6.4-rc7.

fstests(btrfs/007 and more) will fail with the v3 patches .
but it works well without the v3 patches.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/06/21

> v2:
>  - Fix misplaced semicolon
>  - Rename fgp_order to fgp_set_order
>  - Rename FGP_ORDER to FGP_GET_ORDER
>  - Add fgp_t
>  - Update the documentation for ->release_folio
>  - Fix iomap_invalidate_folio()
>  - Update iomap_release_folio()
> 
> Matthew Wilcox (Oracle) (8):
>   iov_iter: Handle compound highmem pages in
>     copy_page_from_iter_atomic()
>   iomap: Remove large folio handling in iomap_invalidate_folio()
>   doc: Correct the description of ->release_folio
>   iomap: Remove unnecessary test from iomap_release_folio()
>   filemap: Add fgf_t typedef
>   filemap: Allow __filemap_get_folio to allocate large folios
>   iomap: Create large folios in the buffered write path
>   iomap: Copy larger chunks from userspace
> 
>  Documentation/filesystems/locking.rst | 15 ++++--
>  fs/btrfs/file.c                       |  6 +--
>  fs/f2fs/compress.c                    |  2 +-
>  fs/f2fs/f2fs.h                        |  2 +-
>  fs/gfs2/bmap.c                        |  2 +-
>  fs/iomap/buffered-io.c                | 43 ++++++++--------
>  include/linux/iomap.h                 |  2 +-
>  include/linux/pagemap.h               | 71 ++++++++++++++++++++++-----
>  lib/iov_iter.c                        | 43 ++++++++++------
>  mm/filemap.c                          | 61 ++++++++++++-----------
>  mm/folio-compat.c                     |  2 +-
>  mm/readahead.c                        | 13 -----
>  12 files changed, 159 insertions(+), 103 deletions(-)
> 
> -- 
> 2.39.2


