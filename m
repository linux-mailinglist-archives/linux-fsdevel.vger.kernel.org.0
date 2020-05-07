Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687E61C7EE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEGAnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:43:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38068 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgEGAnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:43:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bkiG092912;
        Thu, 7 May 2020 00:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=qc+w0ITasi/mb3MmcnJ1ObIG7dFmjPsfgIFkmHA89sE=;
 b=x757WWreLpSB8OokJRHyKcsAINaoS+wAlmyXFSB5WEnR7/JytDBoYA7fVffl1/WaJZzM
 WTvFlN1X5a/646jzBQUqhGzpB9f0DZV2bi9G7kcHYqylAFS57UXN8/Sz4VqeTNwenOWO
 6f11GKt6IayaGa1ho5jyAdW8h5XY9zARuGZtvrmYfFT+Io56pR5TxYWKKzFCkfdWJt1H
 o9PItYjbOF0Z71naBcabV3cYuFQG6nIJb4V6Kkbb9mcoRU/PQzwi5dNe4OkNmepnwBD6
 WS+bIC1qLe1lJ057ydC4DAm0ogInMTJfg8eQ/jk7G+KtujXjrSrHf+EB2NHGa9ltZHZQ OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gnd8hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bUDY098699;
        Thu, 7 May 2020 00:42:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30sjnma12g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470gfnn019681;
        Thu, 7 May 2020 00:42:41 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:41 -0700
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
Subject: [RFC 07/43] mm: PKRAM: link nodes by pfn before reboot
Date:   Wed,  6 May 2020 17:41:33 -0700
Message-Id: <1588812129-8596-8-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since page structs are used for linking PKRAM nodes and cleared
on boot, organize all PKRAM nodes into a list singly-linked by pfns
before reboot to facilitate the node list restore in the new kernel.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index 06b471eea0b0..44fadb70acf6 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -2,12 +2,16 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/pkram.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -58,11 +62,15 @@ struct pkram_obj {
  * singly-linked list of PKRAM link structures (see above), the node has a
  * pointer to the head of.
  *
+ * To facilitate data restore in the new kernel, before reboot all PKRAM nodes
+ * are organized into a list singly-linked by pfn's (see pkram_reboot()).
+ *
  * The structure occupies a memory page.
  */
 struct pkram_node {
 	__u32	flags;
 	__u64	obj_pfn;	/* points to the first obj of the node */
+	__u64	node_pfn;	/* points to the next node in the node list */
 
 	__u8	name[PKRAM_NAME_MAX];
 };
@@ -71,6 +79,10 @@ struct pkram_node {
 #define PKRAM_LOAD		2
 #define PKRAM_ACCMODE_MASK	3
 
+/*
+ * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
+ * connected through the lru field of the page struct.
+ */
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
@@ -679,3 +691,41 @@ size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count)
 
 	return copy_count;
 }
+
+/*
+ * Build the list of PKRAM nodes.
+ */
+static void __pkram_reboot(void)
+{
+	struct page *page;
+	struct pkram_node *node;
+	unsigned long node_pfn = 0;
+
+	list_for_each_entry_reverse(page, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
+			continue;
+		node->node_pfn = node_pfn;
+		node_pfn = page_to_pfn(page);
+	}
+}
+
+static int pkram_reboot(struct notifier_block *notifier,
+		       unsigned long val, void *v)
+{
+	if (val != SYS_RESTART)
+		return NOTIFY_DONE;
+	__pkram_reboot();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pkram_reboot_notifier = {
+	.notifier_call = pkram_reboot,
+};
+
+static int __init pkram_init(void)
+{
+	register_reboot_notifier(&pkram_reboot_notifier);
+	return 0;
+}
+module_init(pkram_init);
-- 
2.13.3

