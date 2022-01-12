Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7648C660
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354249AbiALOqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:46:34 -0500
Received: from mr85p00im-zteg06011501.me.com ([17.58.23.182]:47702 "EHLO
        mr85p00im-zteg06011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243573AbiALOq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641998216; bh=d0cZDTdkbq2OLCsejXnziUbJRkiUwF2JPM28YjzJMvc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=wrc8VTVY5uaQ+01UGn4ZudroMr5Ch1kUZ1i8CPrKIvjrG2J0jI9gb2TOWLI11acsI
         UKF6omEoaKN9lyqhwOtCkbP9qPzh8Qf3E85Ym/EEdpJy7ww+yEhveam9fI1NyjU9bK
         SQ1VF8Id8nIiTA5ZYBob+8ZPIi74gupc6+vf65GRsExcWuV1BGARkXA5M7WuVUTeof
         yq5nbH+Fg37LPN0AYCmJ4OL76HmYgAtVDmQgI1x+K6Luvzf6EtmJlcSB4WcIP7VTwA
         5c/zq1MBCyxcG0y2mMS5/J6LzELELtWHGv/ajTcZNOwP5+PhzbxfyweTMhp6omEh2H
         WG3dUFUms6iPQ==
Received: from xiongwei.. (unknown [120.245.2.88])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id C8C51480823;
        Wed, 12 Jan 2022 14:36:42 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v3 2/2] proc: Add getting pages info of ZONE_DEVICE support
Date:   Wed, 12 Jan 2022 22:35:17 +0800
Message-Id: <20220112143517.262143-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112143517.262143-1-sxwjean@me.com>
References: <20220112143517.262143-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F04:2022-01-11=5F01,2022-01-12=5F04,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=922 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2201120095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

When requesting pages info by /proc/kpage*, the pages in ZONE_DEVICE were
ignored.

The pfn_to_devmap_page() function can help to get page that belongs to
ZONE_DEVICE.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
V3: Reset pgmap to NULL after putting dev_pagemap to prevent false non-NULL.
---
 fs/proc/page.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 9f1077d94cde..d4fc308765f5 100644
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
@@ -60,17 +62,20 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
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
 
+		if (pgmap) {
+			put_dev_pagemap(pgmap);
+			pgmap = NULL;
+		}
+
 		if (put_user(pcount, out)) {
 			ret = -EFAULT;
 			break;
@@ -229,10 +234,12 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
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
@@ -242,13 +249,17 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
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
+		if (pgmap) {
+			put_dev_pagemap(pgmap);
+			pgmap = NULL;
+		}
 
-		if (put_user(stable_page_flags(ppage), out)) {
+		if (put_user(flags, out)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -277,6 +288,7 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
 {
 	const unsigned long max_dump_pfn = get_max_dump_pfn();
 	u64 __user *out = (u64 __user *)buf;
+	struct dev_pagemap *pgmap = NULL;
 	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
@@ -291,17 +303,20 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
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
 
+		if (pgmap) {
+			put_dev_pagemap(pgmap);
+			pgmap = NULL;
+		}
+
 		if (put_user(ino, out)) {
 			ret = -EFAULT;
 			break;
-- 
2.30.2

