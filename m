Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C5712101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbjEZHdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEZHdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 03:33:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D84B6;
        Fri, 26 May 2023 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=23YpyXCnG95trpP/pZ5n4GhJ2jHSbd6X9bDByt1pjCI=; b=1pmptwQdQfDrJXHTJIIak+p56N
        nZDFIQCxxcIxw0zUKarHhboTE6oY7rvTOgGfiswmsjC5CWW8lOGwJ9B5AeQkCpBGux3R65tB+k27i
        P0vmdsjYL3A3dM9V9slp2BqgHODGy/QH4BFYSeTt8omfsUwrWvOq2scl47MGO3EOySrYqMO7TXK3f
        mcggnMJmh8lWXyude7lxcrYzLdmf6LD5lAWFgWWQ97kY0Fr+9zfUTGxbeAVryzFYAmYle936W9M7+
        lbtmgWmxGlHTbwW0x4N0xCtJcJMISx+JewfMyrmz0ftBPLkT8DvX5h3pcFpy/B1olU2EFewhzzf1c
        At6yXbow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2RxA-001RdO-2w;
        Fri, 26 May 2023 07:33:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, hch@infradead.org,
        djwong@kernel.org, minchan@kernel.org, senozhatsky@chromium.org
Cc:     patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, kbusch@kernel.org, mcgrof@kernel.org
Subject: [PATCH v2 0/5] block: simplify with PAGE_SECTORS_SHIFT
Date:   Fri, 26 May 2023 00:33:31 -0700
Message-Id: <20230526073336.344543-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A bit of block drivers have their own incantations with
PAGE_SHIFT - SECTOR_SHIFT. Just simplfy and use PAGE_SECTORS_SHIFT
all over.
                                                                                                                                                                                              
Based on linux-next next-20230525.

Changes since v1:

 o keep iomap math visibly simple
 o Add tags for Reviews/acks
 o rebase onto next-20230525

Luis Chamberlain (5):
  block: annotate bdev_disk_changed() deprecation with a symbol
    namespace
  drbd: use PAGE_SECTORS_SHIFT and PAGE_SECTORS
  iomap: simplify iomap_init() with PAGE_SECTORS
  dm bufio: simplify by using PAGE_SECTORS_SHIFT
  zram: use generic PAGE_SECTORS and PAGE_SECTORS_SHIFT

 block/partitions/core.c          |  6 +-----
 drivers/block/drbd/drbd_bitmap.c |  4 ++--
 drivers/block/loop.c             |  2 ++
 drivers/block/zram/zram_drv.c    | 12 ++++++------
 drivers/block/zram/zram_drv.h    |  2 --
 drivers/md/dm-bufio.c            |  4 ++--
 drivers/s390/block/dasd_genhd.c  |  2 ++
 fs/iomap/buffered-io.c           |  2 +-
 8 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.39.2

