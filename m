Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0D430EFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhJREnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 00:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhJREnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:43:17 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D5C06161C;
        Sun, 17 Oct 2021 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5FVSqxmInxZpxLfquTYTWo3aHtcI6RxpSGZW6UNZj6o=; b=RWsnrEN/AN21+3N1QS/sVzo/pA
        KUprhD61JwCSOViB6cCzwYWYPy8xO6eWNrrG8XEt0LTqvix7ajoUiGCskUDEIh+XmHUnJyX/tgDJj
        Esl/uNdX1ly5Yy9ZBHbYr6yKuDS9X5SLz4ZAngrPtzD/0A2qwFx8g8P1chEP+4L6TG/G9DEqtaDJ6
        jW1vIyTNr2TebDqfs2jg2FxBFf/f/gWdoiabUqKvxpvOm2M2Nvc85QefHdxbJPv9Dys7AN5jmyANn
        iuh0ImYfAhQwPFWqmpyXU78hqF4KUrq+0TQ/4jRUyILMGOEhgr5OTDCogwtAbPD6vKEUBlPEk3aPn
        umppEHQg==;
Received: from 089144211028.atnat0020.highway.a1.net ([89.144.211.28] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcKSH-00E3Et-TF; Mon, 18 Oct 2021 04:40:58 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: futher decouple DAX from block devices
Date:   Mon, 18 Oct 2021 06:40:43 +0200
Message-Id: <20211018044054.1779424-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

this series cleans up and simplifies the association between DAX and block
devices in preparation of allowing to mount file systems directly on DAX
devices without a detour through block devices.

Diffstat:
 drivers/dax/Kconfig          |    4 
 drivers/dax/bus.c            |    2 
 drivers/dax/super.c          |  220 +++++--------------------------------------
 drivers/md/dm-linear.c       |   51 +++------
 drivers/md/dm-log-writes.c   |   44 +++-----
 drivers/md/dm-stripe.c       |   65 +++---------
 drivers/md/dm-table.c        |   22 ++--
 drivers/md/dm-writecache.c   |    2 
 drivers/md/dm.c              |   29 -----
 drivers/md/dm.h              |    4 
 drivers/nvdimm/Kconfig       |    2 
 drivers/nvdimm/pmem.c        |    9 -
 drivers/s390/block/Kconfig   |    2 
 drivers/s390/block/dcssblk.c |   12 +-
 fs/dax.c                     |   13 ++
 fs/erofs/super.c             |   11 +-
 fs/ext2/super.c              |    6 -
 fs/ext4/super.c              |    9 +
 fs/fuse/Kconfig              |    2 
 fs/fuse/virtio_fs.c          |    2 
 fs/xfs/xfs_super.c           |   54 +++++-----
 include/linux/dax.h          |   30 ++---
 22 files changed, 185 insertions(+), 410 deletions(-)
