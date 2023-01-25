Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E32067B35B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjAYNeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjAYNes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:34:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FA366B1;
        Wed, 25 Jan 2023 05:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ub/NqoO4nrj7/CmhK+7Df7o2NLjdTjVuu2uglnNK6zU=; b=igUi7tuNh2ZEVpsTLWJ2mUfsso
        /agiH9BlTOdVnjHdC5CP7jvaMLnN0yMuR0L/cUS8cCaVotLH6KMLpU9wMqUK9tg5fLresZQ0ResoO
        qhgIVJenDLh9+Hq/MxySQTD8U38ChmdA0/wpZjAGnJU+nV/2vA9fQ5kC6DVa50/8eImse5I4lmsjK
        RvGEtZsA6SjM24gurJTX3ltM16oJEuw2PjJ37+MpvrMzbNTs1nxC+zue1HISRBXKVaQyOFmELIyvL
        naCxtOCKlEygyT4OQWCOKsE6keEVzXnJ9aD9SVX5/tcHsnVaIVSHzUuR3a9N4FskdJDJPYw7eZijX
        mpcvweBA==;
Received: from [2001:4bb8:19a:27af:c78f:9b0d:b95c:d248] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKfvD-007P0o-SE; Wed, 25 Jan 2023 13:34:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: remove ->rw_page
Date:   Wed, 25 Jan 2023 14:34:29 +0100
Message-Id: <20230125133436.447864-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes the ->rw_page block_device_operation, which is an old
and clumsy attempt at a simple read/write fast path for the block layer.
It isn't actually used by the fastest block layer operations that we
support (polled I/O through io_uring), but only used by the mpage buffered
I/O helpers which are some of the slowest I/O we have and do not make any
difference there at all, and zram which is a block device abused to
duplicate the zram functionality.  Given that zram is heavily used we
need to make sure there is a good replacement for synchronous I/O, so
this series adds a new flag for drivers that complete I/O synchronously
and uses that flag to use on-stack bios and synchronous submission for
them in the swap code.

Diffstat:
 block/bdev.c                  |   78 ------------------
 drivers/block/brd.c           |   15 ---
 drivers/block/zram/zram_drv.c |   61 --------------
 drivers/nvdimm/btt.c          |   16 ---
 drivers/nvdimm/pmem.c         |   24 -----
 fs/mpage.c                    |   10 --
 include/linux/blkdev.h        |   12 +-
 mm/page_io.c                  |  182 ++++++++++++++++++++++--------------------
 mm/swap.h                     |    9 --
 mm/swapfile.c                 |    2 
 10 files changed, 114 insertions(+), 295 deletions(-)
