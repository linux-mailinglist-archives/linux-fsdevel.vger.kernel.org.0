Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45714432E24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhJSG1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSG1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:27:53 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5ABC06161C;
        Mon, 18 Oct 2021 23:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=itvvQJMlOd0qMZWya439KMIYfs2Y4pBye3jHCRjN2vI=; b=0WK/Nr+5apW24kzj3x7xKVx7vx
        wHu3IfTt08GM2a8iZHSu/L7P2/ShdB2Ni0GtKL8fKLR3xR1YFpYEVR2yG283mViN4RS4WOtPE1AsY
        fI3Docjlmro2vJpJxZ7PBO2fBZ5/+JsjvnL3ZFE64BOG1RQdmSdpKP4G4/3gKfOHM6U9mh+vK1XJn
        97WTNBQbr2LqiyjavYVqnzoz6kb8iJJN4Lm8x7e+eXjXCuSAZJ5EBUYBr+4JM8DnWbQXqkRZinxII
        UKPWx44EsalOi7/NkkkU5iG9za0HK1FDaM4FdcAifoM+JFBCGcc/EQSWszLyWfS3L4P3982Y+LfCg
        0IFcnfNw==;
Received: from 089144192247.atnat0001.highway.a1.net ([89.144.192.247] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mciZ2-000HX0-PR; Tue, 19 Oct 2021 06:25:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev
Subject: cleanup block device inode syncing
Date:   Tue, 19 Oct 2021 08:25:23 +0200
Message-Id: <20211019062530.2174626-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series refactors parts of the sync code so that we have and always
use proper helpers for syncing data cached in the block device inode.

Diffstat:
 block/bdev.c                       |   28 +++++++++++-----
 drivers/block/xen-blkback/xenbus.c |    2 -
 fs/btrfs/volumes.c                 |    2 -
 fs/fat/inode.c                     |    6 +--
 fs/internal.h                      |   11 ------
 fs/ntfs3/inode.c                   |    2 -
 fs/sync.c                          |   62 +++++++++++++------------------------
 include/linux/blkdev.h             |    9 +++++
 8 files changed, 56 insertions(+), 66 deletions(-)
