Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192A8312643
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 18:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBGRKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 12:10:41 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52559 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229720AbhBGRKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 12:10:38 -0500
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="104299368"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 01:09:32 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 641D84CE6F77;
        Mon,  8 Feb 2021 01:09:30 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 01:09:32 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 01:09:31 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/7] fsdax: Introduce dax_copy_edges() for CoW
Date:   Mon, 8 Feb 2021 01:09:19 +0800
Message-ID: <20210207170924.2933035-3-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 641D84CE6F77.ACBBD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dax_copy_edges() is a helper functions performs a copy from one part of
the device to another for data not page aligned.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index b012b2db7ba2..ea4e8a434900 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1038,6 +1038,47 @@ static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
 	return rc;
 }
 
+/*
+ * Copies the part of the pages not included in the write, but required for CoW
+ * because offset/offset+length are not page aligned.
+ */
+static int dax_copy_edges(loff_t pos, loff_t length, struct iomap *srcmap,
+			  void *daddr, bool pmd)
+{
+	size_t page_size = pmd ? PMD_SIZE : PAGE_SIZE;
+	loff_t offset = pos & (page_size - 1);
+	size_t size = ALIGN(offset + length, page_size);
+	loff_t end = pos + length;
+	loff_t pg_end = round_up(end, page_size);
+	void *saddr = 0;
+	int ret = 0;
+
+	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
+	if (ret)
+		return ret;
+	/*
+	 * Copy the first part of the page
+	 * Note: we pass offset as length
+	 */
+	if (offset) {
+		if (saddr)
+			ret = copy_mc_to_kernel(daddr, saddr, offset);
+		else
+			memset(daddr, 0, offset);
+	}
+
+	/* Copy the last part of the range */
+	if (end < pg_end) {
+		if (saddr)
+			ret = copy_mc_to_kernel(daddr + offset + length,
+			       saddr + offset + length,	pg_end - end);
+		else
+			memset(daddr + offset + length, 0, pg_end - end);
+	}
+
+	return ret;
+}
+
 /*
  * The user has performed a load from a hole in the file.  Allocating a new
  * page in the file would cause excessive storage usage for workloads with
-- 
2.30.0



