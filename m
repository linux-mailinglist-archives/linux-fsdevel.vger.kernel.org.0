Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5B1C7F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgEGAqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49504 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbgEGAqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470befJ064522;
        Thu, 7 May 2020 00:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=cg4oKTlkz7COgexHCFzVJnE42b7eeQownh5JuIB+IVo=;
 b=H1det3gMfdv8Nw3uK+9bx7D1A8RL3637W4FILQ5ULMPvVpbUEtQITqpXr4+XhPK9zRiK
 tN+YtTCWcgh/a2asuQqUOQhmNLxg90x07tg/FXahQhekcuk1eJaJfZsrxHNSJmE+RhkY
 5+aPjy98gm4Vsqu++p0KOgzDfqxT7HtS3ieI8FuYttljU0J4BqilSgeWNUrVO803/Igm
 pLPSqbMCekuQJXTezhoBDdwyWLzQc0AWcg7Jdu4cH12b4Nw88bHSlV+wFvoZVsfqfzy2
 TcwOgt0ZwUNcd9sLaRDnyfiMreokb+K23IwOHa0KXvhozdKyJMLhzgtCZU+LtD4ZoVOi GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09rdfd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bmIF131679;
        Thu, 7 May 2020 00:42:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30t1r958af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:52 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470go88019800;
        Thu, 7 May 2020 00:42:50 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:50 -0700
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, hannes@cmpxchg.org, minchan@kernel.org,
        mhocko@kernel.org, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, gustavo@embeddedor.com,
        ziqian.lzq@antfin.com, vdavydov.dev@gmail.com,
        jason.zeng@intel.com, kevin.tian@intel.com, zhiyuan.lv@intel.com,
        lei.l.li@intel.com, paul.c.lai@intel.com, ashok.raj@intel.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [RFC 10/43] PKRAM: add code for walking the preserved pages pagetable
Date:   Wed,  6 May 2020 17:41:36 -0700
Message-Id: <1588812129-8596-11-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the ability to walk the pkram pagetable from high to low addresses
and execute a callback for each contiguous range of preserved or not
preserved memory found.  The reason for walking high to low is to align
with high to low memblock allocation when finding holes that memblocks
can safely be allocated from as will be seen in a later patch.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  15 +++++
 mm/Makefile           |   2 +-
 mm/pkram_pagetable.c  | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 mm/pkram_pagetable.c

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index a58dd2ea835a..b6fa973d37cc 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -25,6 +25,21 @@ struct pkram_stream {
 
 #define PKRAM_NAME_MAX		256	/* including nul */
 
+struct pkram_pg_state {
+	int (*range_cb)(struct pkram_pg_state *state, unsigned long base,
+			unsigned long size);
+	unsigned long curr_addr;
+	unsigned long end_addr;
+	unsigned long min_addr;
+	unsigned long max_addr;
+	unsigned long min_size;
+	bool tracking;
+	bool find_holes;
+	unsigned long retval;
+};
+
+void pkram_walk_pgt_rev(struct pkram_pg_state *st, pgd_t *pgd);
+
 int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 		       gfp_t gfp_mask);
 int pkram_prepare_save_obj(struct pkram_stream *ps);
diff --git a/mm/Makefile b/mm/Makefile
index 59cd381194af..c4ad1c56e237 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,4 +112,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_PKRAM) += pkram.o
+obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o
diff --git a/mm/pkram_pagetable.c b/mm/pkram_pagetable.c
new file mode 100644
index 000000000000..d31aa36207ba
--- /dev/null
+++ b/mm/pkram_pagetable.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
+#include <asm/pgtable.h>
+#include <linux/pkram.h>
+
+#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
+
+static int note_page_rev(struct pkram_pg_state *st, unsigned long curr_size, bool present)
+{
+	unsigned long curr_addr = st->curr_addr;
+	bool track_page = present ^ st->find_holes;
+
+	if (!st->tracking && track_page) {
+		unsigned long end_addr = curr_addr + curr_size;
+
+		if (end_addr <= st->min_addr)
+			return 1;
+
+		st->end_addr = min(end_addr, st->max_addr);
+		st->tracking = true;
+	} else if (st->tracking) {
+		unsigned long base, size;
+
+		/* Continue tracking if lower bound has not been reached */
+		if (track_page && curr_addr && curr_addr >= st->min_addr)
+			return 0;
+
+		if (!track_page)
+			base = max(curr_addr + curr_size, st->min_addr);
+		else
+			base = st->min_addr;
+
+		size = st->end_addr - base;
+		st->tracking = false;
+
+		return st->range_cb(st, base, size);
+	}
+
+	return 0;
+}
+
+static int walk_pte_level_rev(struct pkram_pg_state *st, pmd_t addr, unsigned long P)
+{
+	unsigned long *bitmap;
+	int present;
+	int i, ret;
+
+	bitmap = __va(pmd_val(addr));
+	for (i = PTRS_PER_PTE - 1; i >= 0; i--) {
+		unsigned long curr_addr = P + i * PAGE_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		present = test_bit(i, bitmap);
+		ret = note_page_rev(st, PAGE_SIZE, present);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pmd_level_rev(struct pkram_pg_state *st, pud_t addr, unsigned long P)
+{
+	pmd_t *start;
+	int i, ret;
+
+	start = (pmd_t *)pud_page_vaddr(addr) + PTRS_PER_PMD - 1;
+	for (i = PTRS_PER_PMD - 1; i >= 0; i--, start--) {
+		unsigned long curr_addr = P + i * PMD_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		if (!pmd_none(*start)) {
+			if (pmd_large(*start))
+				ret = note_page_rev(st, PMD_SIZE, true);
+			else
+				ret = walk_pte_level_rev(st, *start, curr_addr);
+		} else
+			ret = note_page_rev(st, PMD_SIZE, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pud_level_rev(struct pkram_pg_state *st, p4d_t addr, unsigned long P)
+{
+	pud_t *start;
+	int i, ret;
+
+	start = (pud_t *)p4d_page_vaddr(addr) + PTRS_PER_PUD - 1;
+	for (i = PTRS_PER_PUD - 1; i >= 0 ; i--, start--) {
+		unsigned long curr_addr = P + i * PUD_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		if (!pud_none(*start)) {
+			if (pud_large(*start))
+				ret = note_page_rev(st, PUD_SIZE, true);
+			else
+				ret = walk_pmd_level_rev(st, *start, curr_addr);
+		} else
+			ret = note_page_rev(st, PUD_SIZE, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_p4d_level_rev(struct pkram_pg_state *st, pgd_t addr, unsigned long P)
+{
+	p4d_t *start;
+	int i, ret;
+
+	if (PTRS_PER_P4D == 1)
+		return walk_pud_level_rev(st, __p4d(pgd_val(addr)), P);
+
+	start = (p4d_t *)pgd_page_vaddr(addr) + PTRS_PER_P4D - 1;
+	for (i = PTRS_PER_P4D - 1; i >= 0; i--, start--) {
+		unsigned long curr_addr = P + i * P4D_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		if (!p4d_none(*start)) {
+			if (p4d_large(*start))
+				ret = note_page_rev(st, P4D_SIZE, true);
+			else
+				ret = walk_pud_level_rev(st, *start, curr_addr);
+		} else
+			ret = note_page_rev(st, P4D_SIZE, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+void pkram_walk_pgt_rev(struct pkram_pg_state *st, pgd_t *pgd)
+{
+	pgd_t *start;
+	int i, ret;
+
+	start = pgd + PTRS_PER_PGD - 1;
+	for (i = PTRS_PER_PGD - 1; i >= 0; i--, start--) {
+		unsigned long curr_addr = i * PGDIR_SIZE;
+
+		if (curr_addr >= st->max_addr)
+			continue;
+		st->curr_addr = curr_addr;
+
+		if (!pgd_none(*start))
+			ret = walk_p4d_level_rev(st, *start, curr_addr);
+		else
+			ret = note_page_rev(st, PGDIR_SIZE, false);
+		if (ret)
+			break;
+	}
+}
-- 
2.13.3

