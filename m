Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9373B5608
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 02:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhF1AFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 20:05:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54538 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231678AbhF1AFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 20:05:23 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGQqGlqmcPjC+AJqqUeStSZ1TRGzpDfLI3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fxl6iV8sjzsiWE7gr5OUtQ4OxoV5PhfZqxz/JICMwqTNKftWrdyQ?=
 =?us-ascii?q?yVxeNZnOjfKlTbckWUnINgPOVbAsxD4bbLbGSS4/yU3ODBKadD/DCYytHUuc7u?=
 =?us-ascii?q?i2dqURpxa7xtqyNwCgOgGEVwQwVcbKBJb6a0145WoSa6Y3QLYoCeDnkBZeLKoN?=
 =?us-ascii?q?rGj9bIehgDbiRXkjWmvHe57qLgCRiE0lM7WzNL+70r9m/IiEjYy8yYwomG9iM?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.83,304,1616428800"; 
   d="scan'208";a="110256322"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Jun 2021 08:02:57 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3EC014D0BA67;
        Mon, 28 Jun 2021 08:02:54 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 28 Jun 2021 08:02:55 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 28 Jun 2021 08:02:54 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>
Subject: [PATCH v5 1/9] pagemap: Introduce ->memory_failure()
Date:   Mon, 28 Jun 2021 08:02:10 +0800
Message-ID: <20210628000218.387833-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
References: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3EC014D0BA67.A1167
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When memory-failure occurs, we call this function which is implemented
by each kind of devices.  For the fsdax case, pmem device driver
implements it.  Pmem device driver will find out the filesystem in which
the corrupted page located in.  And finally call filesystem handler to
deal with this error.

The filesystem will try to recover the corrupted data if necessary.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 include/linux/memremap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 45a79da89c5f..d96da47cc249 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -87,6 +87,15 @@ struct dev_pagemap_ops {
 	 * the page back to a CPU accessible page.
 	 */
 	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
+
+	/*
+	 * Handle the memory failure happens on a range of pfns.  Notify the
+	 * processes who are using these pfns, and try to recover the data on
+	 * them if necessary.  The flag is finally passed to the recover
+	 * function through the whole notify routine.
+	 */
+	int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
+			      unsigned long nr_pfns, int flags);
 };

 #define PGMAP_ALTMAP_VALID	(1 << 0)
--
2.32.0



