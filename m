Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20524CE01D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 23:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiCDWNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 17:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCDWNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:13:49 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10B85103F;
        Fri,  4 Mar 2022 14:12:59 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A7D2D52FBC4;
        Sat,  5 Mar 2022 09:12:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nQGAR-001Zvp-Ep; Sat, 05 Mar 2022 09:12:55 +1100
Date:   Sat, 5 Mar 2022 09:12:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, sagi@grimberg.me, kbusch@kernel.org,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220304221255.GL3927073@dread.disaster.area>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304175556.407719-2-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62228eea
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=pB72X_AyP2OfXCB9ywQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 06:55:56PM +0100, Christoph Hellwig wrote:
> With the NVMe support for this gone, there are no consumers of these hints
> left, so remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c                 |  2 --
>  block/blk-crypto-fallback.c |  1 -
>  block/blk-merge.c           | 14 --------------
>  block/blk-mq-debugfs.c      | 24 ------------------------
>  block/blk-mq.c              |  1 -
>  block/bounce.c              |  1 -
>  block/fops.c                |  3 ---
>  drivers/md/raid1.c          |  2 --
>  drivers/md/raid5-ppl.c      | 28 +++-------------------------
>  drivers/md/raid5.c          |  6 ------
>  fs/btrfs/extent_io.c        |  1 -
>  fs/buffer.c                 | 13 +++++--------
>  fs/direct-io.c              |  3 ---
>  fs/ext4/page-io.c           |  5 +----
>  fs/f2fs/data.c              |  2 --
>  fs/gfs2/lops.c              |  1 -
>  fs/iomap/buffered-io.c      |  2 --
>  fs/iomap/direct-io.c        |  1 -
>  fs/mpage.c                  |  1 -
>  fs/zonefs/super.c           |  1 -
>  include/linux/blk_types.h   |  1 -
>  include/linux/blkdev.h      |  3 ---
>  22 files changed, 9 insertions(+), 107 deletions(-)

AFAICT, all the filesystem/IO path passthrough plumbing for hints is
now gone, and no hardware will ever receive hints.  Doesn't this
mean that file_write_hint(), file->f_write_hint and iocb->ki_hint
are now completely unused, too?  That also means the fcntl()s for
F_{G,S}ET_FILE_RW_HINT now have zero effect on IO, so should they be
neutered, too?

AFAICT, this patch leaves just the f2fs allocator usage of
inode->i_rw_hint to select a segment to allocate from as the
remaining consumer of this entire plumbing and user API. Is that
used by applications anywhere, or can that be removed and so the
rest of the infrastructure get removed and the fcntl()s no-op'd or
-EOPNOTSUPP?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
