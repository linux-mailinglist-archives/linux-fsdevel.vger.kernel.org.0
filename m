Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9CC332B18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhCIPzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 10:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhCIPyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:54:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5077C06175F;
        Tue,  9 Mar 2021 07:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KGWSD1qzjw8jWYcVTd5k5Vux/eD/dPBH9TiN6yLVseE=; b=UqioM+JOtMrCZY+99WNlohS+n6
        D8sXLpSvt07nrEhE9GYHmdMTmjw4DL1jAclk+Ci+jnYGdn+IEIwZ0S8fpKJ2whNwkyjmljxBPh47g
        cMsKfNPA0fujb0XrwseHmDs/2m816gk63sTddN9x9X9wgRohgavTvx8tm6KQtpAyIG7cxz0OK5MKP
        PgIH6/WtutbbPjhpmXZVF7C1m9jWVkHGrdDIIbgcgrxaJ3JqKKlPb7/Swf8vZxBO2cCE67ILF7rVn
        MmRlVgFU4oQqmQ/DBvwu33p+M9TPPMt61GrQMTQJl2w3aFf67m+MltPsTuxfefjtilLeB/ZfnOnxB
        lkLQIpmA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJegA-000lLy-1I; Tue, 09 Mar 2021 15:53:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: make alloc_anon_inode more useful
Date:   Tue,  9 Mar 2021 16:53:39 +0100
Message-Id: <20210309155348.974875-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series first renames the existing alloc_anon_inode to
alloc_anon_inode_sb to clearly mark it as requiring a superblock.

It then adds a new alloc_anon_inode that works on the anon_inode
file system super block, thus removing tons of boilerplate code.

The few remainig callers of alloc_anon_inode_sb all use alloc_file_pseudo
later, but might also be ripe for some cleanup.

Diffstat:
 arch/powerpc/platforms/pseries/cmm.c |   27 +-------------
 drivers/dma-buf/dma-buf.c            |    2 -
 drivers/gpu/drm/drm_drv.c            |   64 +----------------------------------
 drivers/misc/cxl/api.c               |    2 -
 drivers/misc/vmw_balloon.c           |   24 +------------
 drivers/scsi/cxlflash/ocxl_hw.c      |    2 -
 drivers/virtio/virtio_balloon.c      |   30 +---------------
 fs/aio.c                             |    2 -
 fs/anon_inodes.c                     |   15 +++++++-
 fs/libfs.c                           |    2 -
 include/linux/anon_inodes.h          |    1 
 include/linux/fs.h                   |    2 -
 kernel/resource.c                    |   30 ++--------------
 mm/z3fold.c                          |   38 +-------------------
 mm/zsmalloc.c                        |   48 +-------------------------
 15 files changed, 39 insertions(+), 250 deletions(-)
