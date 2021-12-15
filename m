Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6739647547F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 09:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbhLOIpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 03:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbhLOIpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:45:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A5C06173E;
        Wed, 15 Dec 2021 00:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TKJygkCD6i9SjC3HkwXVo+dmvz/uErdKZKvPVPgQELM=; b=n2HQ4C/d80526yWA5sVabytvLf
        jh39xpBBTyM1qRHFFuh6rim5A5NmqDEgwM1CR2J7xdCHmS6i6AsjL3u3VRE7dMvPH6BWr6WdHBO/p
        88xkwad8QTjkDdDe0hPvt9zlB2U87G5hKpE+H7fZ66WD4+tS0rkWGEHeGJXonl05HlK/Izcla5HSA
        vpP+/q+D/O2DaDX0NvdHPi0fp8sba9Q54MvSjXmoORufvpAg9psZWxXYZdY45T9Rhfmrx8JS7TYtr
        +77suJvIYUYQ6ciQDSGp4Yf1NS/YaiZywapyZB1RHToXZ4+P7CtfUzSAAhCILux9uHRuY26x1eVWR
        4LCgR19Q==;
Received: from [2001:4bb8:184:5c65:c56:ed89:c020:6100] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxPuP-00ETyf-0H; Wed, 15 Dec 2021 08:45:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: devirtualize kernel access to DAX v2
Date:   Wed, 15 Dec 2021 09:45:04 +0100
Message-Id: <20211215084508.435401-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

this series cleans up a few loose end ends and then removes the
copy_from_iter and copy_to_iter dax_operations methods in favor of
straight calls.

Changes since v1:
 - reword a 'no check' comment
 - clean up the flags for the copy routine variants
 - drop the last patch

Diffstat:
 drivers/dax/bus.c             |    5 ++
 drivers/dax/super.c           |   50 +++++++++++++++++++-------
 drivers/md/dm-linear.c        |   20 ----------
 drivers/md/dm-log-writes.c    |   80 ------------------------------------------
 drivers/md/dm-stripe.c        |   20 ----------
 drivers/md/dm.c               |   54 +---------------------------
 drivers/nvdimm/pmem.c         |   29 ++-------------
 drivers/s390/block/dcssblk.c  |   18 +--------
 fs/dax.c                      |    5 --
 fs/fuse/virtio_fs.c           |   19 ---------
 include/linux/dax.h           |   29 +++------------
 include/linux/device-mapper.h |    4 --
 include/linux/uio.h           |   20 ----------
 13 files changed, 60 insertions(+), 293 deletions(-)
