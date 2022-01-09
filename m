Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74E488985
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 14:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiAINPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 08:15:18 -0500
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:53314 "EHLO
        pv50p00im-hyfv10011601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233352AbiAINPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641733553; bh=9XqLQAg2WYNjySdUZ9g0g99XYS7qmt4n0TDjaRPnSgk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=PUyV3NOZj+akieY/PAdt+rSI2U4GS49Lg2zTR292RohKAonX1oUma986j+2IY+9CC
         NancyU0X6guoMLp/6igw8BEHiLrdpC4PXMiWPm1r3SNwl/T5tV2JLltMuOpKOD7R4m
         cfXYhDnjXVAK/7xAcTCUrps5hsiGzBhTlqle+PJrYK/1mQqguJk4kbZ+Fi/hVFH9k0
         DwOV+Z9yV6HbQkoLxxa62BwkYTi6XR94zaAkmEpVmEhBsuL3HZU5cvmvQI8UYBWA95
         DDn6iV2j3dJYe3UQnXxq3WWruV5dU0gKpRuvFCKD1GXtMCKigoTKk6+WAE5qjh91NF
         c2nsQ11po2ubg==
Received: from xiongwei.. (unknown [120.245.2.119])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 9219E960270;
        Sun,  9 Jan 2022 13:05:48 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 2/2] proc: Add getting pages info of ZONE_DEVICE support
Date:   Sun,  9 Jan 2022 21:05:15 +0800
Message-Id: <20220109130515.140092-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109130515.140092-1-sxwjean@me.com>
References: <20220109130515.140092-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2022-01-09_04:2022-01-06,2022-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=798 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2201090096
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

When requesting pages info by /proc/kpage*, the pages in ZONE_DEVICE were
missed.

The pfn_to_devmap_page() function can help to get page that belongs to
ZONE_DEVICE.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 fs/proc/page.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 9f1077d94cde..2cdc2b315ff8 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -15,6 +15,7 @@
 #include <linux/page_idle.h>
 #include <linux/kernel-page-flags.h>
 #include <linux/uaccess.h>
+#include <linux/memremap.h>
 #include "internal.h"
 
 #define KPMSIZE sizeof(u64)
@@ -46,6 +47,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 {
 	const unsigned long max_dump_pfn = get_max_dump_pfn();
 	u64 __user *out = (u64 __user *)buf;
+	struct dev_pagemap *pgmap = NULL;
 	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
@@ -60,17 +62,18 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
 
 	while (count > 0) {
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
 		ppage = pfn_to_online_page(pfn);
+		if (!ppage)
+			ppage = pfn_to_devmap_page(pfn, &pgmap);
 
 		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
 			pcount = 0;
 		else
 			pcount = page_mapcount(ppage);
 
+		if (pgmap)
+			put_dev_pagemap(pgmap);
+
 		if (put_user(pcount, out)) {
 			ret = -EFAULT;
 			break;
@@ -229,10 +232,12 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
 {
 	const unsigned long max_dump_pfn = get_max_dump_pfn();
 	u64 __user *out = (u64 __user *)buf;
+	struct dev_pagemap *pgmap = NULL;
 	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
 	ssize_t ret = 0;
+	u64 flags;
 
 	pfn = src / KPMSIZE;
 	if (src & KPMMASK || count & KPMMASK)
@@ -242,13 +247,15 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
 	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
 
 	while (count > 0) {
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
 		ppage = pfn_to_online_page(pfn);
+		if (!ppage)
+			ppage = pfn_to_devmap_page(pfn, &pgmap);
+
+		flags = stable_page_flags(ppage);
+		if (pgmap)
+			put_dev_pagemap(pgmap);
 
-		if (put_user(stable_page_flags(ppage), out)) {
+		if (put_user(flags, out)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -277,6 +284,7 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
 {
 	const unsigned long max_dump_pfn = get_max_dump_pfn();
 	u64 __user *out = (u64 __user *)buf;
+	struct dev_pagemap *pgmap = NULL;
 	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
@@ -291,17 +299,18 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
 	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
 
 	while (count > 0) {
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
 		ppage = pfn_to_online_page(pfn);
+		if (!ppage)
+			ppage = pfn_to_devmap_page(pfn, &pgmap);
 
 		if (ppage)
 			ino = page_cgroup_ino(ppage);
 		else
 			ino = 0;
 
+		if (pgmap)
+			put_dev_pagemap(pgmap);
+
 		if (put_user(ino, out)) {
 			ret = -EFAULT;
 			break;
-- 
2.30.2

