Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873872DAD1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgLOMQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:16:05 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22826 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728632AbgLOMQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:16:03 -0500
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="102420180"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:14:36 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B204E4CE5CCA;
        Tue, 15 Dec 2020 20:14:31 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Dec 2020 20:14:30 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 20:14:30 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH v3 2/9] blk: Introduce ->corrupted_range() for block device
Date:   Tue, 15 Dec 2020 20:14:07 +0800
Message-ID: <20201215121414.253660-3-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B204E4CE5CCA.ADEE6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fsdax mode, the memory failure happens on block device.  So, it is
needed to introduce an interface for block devices.  Each kind of block
device can handle the memory failure in ther own ways.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 033eb5f73b65..45256fe84fa7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1858,6 +1858,8 @@ struct block_device_operations {
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
+	int (*corrupted_range)(struct gendisk *disk, struct block_device *bdev,
+			       loff_t offset, size_t len, void *data);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 };
-- 
2.29.2



