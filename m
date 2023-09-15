Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4EC7A2AAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 00:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbjIOWoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 18:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbjIOWn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:43:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB5E2716;
        Fri, 15 Sep 2023 15:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7Au7GQlleAmj5M8e5CX+OM2MfEjyMcPNx8bLn2lT0zk=; b=i0rFTNFIrhpMybyhkJGOmDs4xP
        oBHzLbvVUXzpm9ZTd/EcCT2Iw9SuWQ79s/UnmZ4WPBsOAOwEYHTSyLdvf6kcvui4XpKnR82hw/5XY
        t67KZYZUm1S0b104aYYCMFlC5dSPvzaBnDgKSKHBb9OmFUFlBRRTFM1OnoT+BjuYEqFWJzEYaGIKF
        XiejQ/wmAcDv5FV8u7wNAlc1idUDBYvGEDs4c+Y8af5dUGeSRk0jMFCkWjGP+dXMaBm4U9gV+y0W9
        UFnqi+X2sRQRqRrJxB6k88JcyoS1qMrCd/M4F8O96+1kXBnPhSWFunceDmRB7FW4H/UWEZi7sFiCF
        XhmBZLQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhHXM-00BUtK-2O;
        Fri, 15 Sep 2023 22:43:44 +0000
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
Subject: [PATCH v3 0/4] block: simplify with PAGE_SECTORS_SHIFT
Date:   Fri, 15 Sep 2023 15:43:39 -0700
Message-Id: <20230915224343.2740317-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just spinning these low hanging fruit patches I forgot about.

Changes on v3:

 o Add tags for Reviews/acks
 o rebase onto next-20230914
 o Fixes as suggested by Johannes Thumshirn:
   - drop not-needed parens on dm bufio
   - use SECTOR_MASK instead of PAGE_SECTORS - 1 for the zram driver
 o Drop shmem patches as they are already merged / modified

Changes on v2:
                                                                                                                                                                                              
 o keep iomap math visibly simple                                                                                                                                                             
 o Add tags for Reviews/acks                                                                                                                                                                  
 o rebase onto next-20230525 

Luis Chamberlain (4):
  drbd: use PAGE_SECTORS_SHIFT and PAGE_SECTORS
  iomap: simplify iomap_init() with PAGE_SECTORS
  dm bufio: simplify by using PAGE_SECTORS_SHIFT
  zram: use generic PAGE_SECTORS and PAGE_SECTORS_SHIFT

 drivers/block/drbd/drbd_bitmap.c |  4 ++--
 drivers/block/zram/zram_drv.c    | 15 ++++++---------
 drivers/block/zram/zram_drv.h    |  2 --
 drivers/md/dm-bufio.c            |  4 ++--
 fs/iomap/buffered-io.c           |  2 +-
 5 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.39.2

