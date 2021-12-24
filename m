Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A452D47EC04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbhLXGXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhLXGXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDAFC061401;
        Thu, 23 Dec 2021 22:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/K3wK83gm1vxGvQ2of6pgx0wWagBVp6MCfLQSf6er3g=; b=Ki0C8Up9yI82NGKofQWdL/i656
        66EJ/ZzqJkg/NMxKRDp3oozHV26+eo88/sLu+i3og65b171io2eRNIlpXNBLLMwQHVXQ/oNj4P9qv
        NzVvMVeKI5M97yvvPAyLgK2dhSppfq2dI0KC3Gmt+JfAhMyn6ZvapS/Jc1r16kdsOVrh1Srcw7Q5+
        f31b+VSwGvgRvNr16lky3gecLrmCeMhCqYgVJGPaqiD/pes5G18Lrm77W9kWnWDrYtWjAm2406hA9
        rNnFKH/mZcDc94hCI/fEIFR14NMCjRcJiBBsS7xZ4H4zdPx/J3bQZ6UozNSz8mxlCbnEtTirss1XG
        a35lnxsQ==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dyb-00Dmy6-DQ; Fri, 24 Dec 2021 06:22:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: remove Xen tmem leftovers
Date:   Fri, 24 Dec 2021 07:22:33 +0100
Message-Id: <20211224062246.1258487-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

since the remove of the Xen tmem driver in 2019, the cleancache hooks are
entirely unused, as are large parts of frontswap.  This series against
linux-next (with the folio changes included) removes cleancaches, and cuts
down frontswap to the bits actually used by zswap.

Diffstat:
 Documentation/vm/cleancache.rst        |  296 -------------------------------
 b/Documentation/vm/frontswap.rst       |   31 ---
 b/Documentation/vm/index.rst           |    1 
 b/MAINTAINERS                          |    7 
 b/arch/arm/configs/bcm2835_defconfig   |    1 
 b/arch/arm/configs/qcom_defconfig      |    1 
 b/arch/m68k/configs/amiga_defconfig    |    1 
 b/arch/m68k/configs/apollo_defconfig   |    1 
 b/arch/m68k/configs/atari_defconfig    |    1 
 b/arch/m68k/configs/bvme6000_defconfig |    1 
 b/arch/m68k/configs/hp300_defconfig    |    1 
 b/arch/m68k/configs/mac_defconfig      |    1 
 b/arch/m68k/configs/multi_defconfig    |    1 
 b/arch/m68k/configs/mvme147_defconfig  |    1 
 b/arch/m68k/configs/mvme16x_defconfig  |    1 
 b/arch/m68k/configs/q40_defconfig      |    1 
 b/arch/m68k/configs/sun3_defconfig     |    1 
 b/arch/m68k/configs/sun3x_defconfig    |    1 
 b/arch/s390/configs/debug_defconfig    |    1 
 b/arch/s390/configs/defconfig          |    1 
 b/block/bdev.c                         |    5 
 b/fs/btrfs/extent_io.c                 |   10 -
 b/fs/btrfs/super.c                     |    2 
 b/fs/ext4/readpage.c                   |    6 
 b/fs/ext4/super.c                      |    3 
 b/fs/f2fs/data.c                       |    7 
 b/fs/mpage.c                           |    7 
 b/fs/ntfs3/ntfs_fs.h                   |    1 
 b/fs/ocfs2/super.c                     |    2 
 b/fs/super.c                           |    3 
 b/include/linux/frontswap.h            |   35 ---
 b/include/linux/fs.h                   |    5 
 b/include/linux/shmem_fs.h             |    3 
 b/include/linux/swapfile.h             |    3 
 b/mm/Kconfig                           |   40 ----
 b/mm/Makefile                          |    1 
 b/mm/filemap.c                         |   11 -
 b/mm/frontswap.c                       |  259 +--------------------------
 b/mm/shmem.c                           |   33 ---
 b/mm/swapfile.c                        |   90 ++-------
 b/mm/truncate.c                        |   15 -
 b/mm/zswap.c                           |    8 
 include/linux/cleancache.h             |  124 ------------
 mm/cleancache.c                        |  315 ---------------------------------
 44 files changed, 65 insertions(+), 1274 deletions(-)
