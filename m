Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F33F8977
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbhHZN5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhHZN5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:57:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52BC061757;
        Thu, 26 Aug 2021 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ARgc5BTNEQt9FG8904QxPv30VGpYKOfYo9r3bA9lDKg=; b=sJcv+fRhJ8wMQ1h4dYWzAjuxP4
        a2W6/6f0CbTXS8adqHIIO+TZwOii8PY1HhPlRupHAjSorxQy7BaG9b/UKABzt9lP9mLnrXon/FsYK
        xNPwIYNqIjGU62SSu7X5dg1mHvYU3dxhARShm6jxkokd3Axzst3u57Ub7xu63PeaInhNUSoNQrZa5
        tOICHTwtZtC5jr6DuVb1fdPUmRcytQhPuPHsV3NPQpK+BuTbIBPfDfHvgeLkzd49XJ+B2y/BfzDWn
        PrCQ2QL6//R3GVtJUozgGCdfQz69TLJJVL4qQftgYNYDdQBsHlqUYCH4F7+daSksRLeagRV0IKXK6
        +FhoZ+nw==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFqZ-00DM13-72; Thu, 26 Aug 2021 13:55:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: dax_supported() related cleanups v2
Date:   Thu, 26 Aug 2021 15:55:01 +0200
Message-Id: <20210826135510.6293-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series first clarifies how to use fsdax in the Kconfig help a bit,
and then untangles the code path that checks if fsdax is supported.

Changes since v1:
 - improve the FS_DAX Kconfig help text further
 - write a proper commit log for a patch missing it

Diffstat
 drivers/dax/super.c   |  191 +++++++++++++++++++-------------------------------
 drivers/md/dm-table.c |    9 --
 drivers/md/dm.c       |    2 
 fs/Kconfig            |   21 ++++-
 fs/ext2/super.c       |    3 
 fs/ext4/super.c       |    3 
 fs/xfs/xfs_super.c    |   16 +++-
 include/linux/dax.h   |   41 +---------
 8 files changed, 117 insertions(+), 169 deletions(-)
