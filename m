Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682D21C7EEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEGAof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:44:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38058 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgEGAnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:43:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470cCJC093122;
        Thu, 7 May 2020 00:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=+WPbVUdq2a+8AXzyuFHH+zc6fkEarucWFmgHtGOMk2w=;
 b=CSeBKpK4zvdmqSkTF0tlgWIOpn7jRko9AOMasFemQyaE9+E4hFUwm+mX7lt5LncGf9QZ
 0jvl43zyP1+ic+Y/8Vvm0O1GbSb50qgoiQH+TUKvGMUeWhAYvhIttvAXX7tPJ8RzI3cP
 V+8AxyCE7Z5Hv/EeHjrIda+SkSL3ZlGRFUqf7kKBLdJLriITLbHXHyKHyKPPztgkguTU
 9twByuLCBpN+txYHjg0y4e6qEJxsSGryn+nr1c596S9ZddA3OZ3Cqw7RkhBBhYOys0gL
 yDVWPbB4N/A9X9jmbxWLlOcaMYUg0IiItlcNRaY9KUfuIU09QsfGvH2pBpc/0zjiW2Js Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gnd8j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470b2P0171067;
        Thu, 7 May 2020 00:42:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30us7p2kt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:47 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470giro025509;
        Thu, 7 May 2020 00:42:44 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:44 -0700
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
Subject: [RFC 08/43] mm: PKRAM: introduce super block
Date:   Wed,  6 May 2020 17:41:34 -0700
Message-Id: <1588812129-8596-9-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
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

The PKRAM super block is the starting point for restoring preserved
memory. By providing the super block to the new kernel at boot time,
preserved memory can be reserved and made available to be restored.
To point the kernel to the location of the super block, one passes
its pfn via the 'pkram' boot param. For that purpose, the pkram super
block pfn is exported via /sys/kernel/pkram. If none is passed, any
preserved memory will not be kept, and a new super block will be
allocated.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 44fadb70acf6..70f2219e6218 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -5,15 +5,18 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/pfn.h>
 #include <linux/pkram.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 
 #include "internal.h"
@@ -80,12 +83,38 @@ struct pkram_node {
 #define PKRAM_ACCMODE_MASK	3
 
 /*
+ * The PKRAM super block contains data needed to restore the preserved memory
+ * structure on boot. The pointer to it (pfn) should be passed via the 'pkram'
+ * boot param if one wants to restore preserved data saved by the previously
+ * executing kernel. For that purpose the kernel exports the pfn via
+ * /sys/kernel/pkram. If none is passed, preserved memory if any will not be
+ * preserved and a new clean page will be allocated for the super block.
+ *
+ * The structure occupies a memory page.
+ */
+struct pkram_super_block {
+	__u64	node_pfn;		/* first element of the node list */
+};
+
+static unsigned long pkram_sb_pfn __initdata;
+static struct pkram_super_block *pkram_sb;
+
+/*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
  * connected through the lru field of the page struct.
  */
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
+/*
+ * The PKRAM super block pfn, see above.
+ */
+static int __init parse_pkram_sb_pfn(char *arg)
+{
+	return kstrtoul(arg, 16, &pkram_sb_pfn);
+}
+early_param("pkram", parse_pkram_sb_pfn);
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	return alloc_page(gfp_mask);
@@ -209,6 +238,7 @@ static void pkram_stream_init_obj(struct pkram_stream *ps, struct pkram_obj *obj
  * @gfp_mask specifies the memory allocation mask to be used when saving data.
  *
  * Error values:
+ *	%ENODEV: PKRAM not available
  *	%ENAMETOOLONG: name len >= PKRAM_NAME_MAX
  *	%ENOMEM: insufficient memory available
  *	%EEXIST: node with specified name already exists
@@ -224,6 +254,9 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
 	struct pkram_node *node;
 	int err = 0;
 
+	if (!pkram_sb)
+		return -ENODEV;
+
 	if (strlen(name) >= PKRAM_NAME_MAX)
 		return -ENAMETOOLONG;
 
@@ -333,6 +366,7 @@ void pkram_discard_save(struct pkram_stream *ps)
  * Returns 0 on success, -errno on failure.
  *
  * Error values:
+ *	%ENODEV: PKRAM not available
  *	%ENOENT: node with specified name does not exist
  *	%EBUSY: save to required node has not finished yet
  *
@@ -343,6 +377,9 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
 	struct pkram_node *node;
 	int err = 0;
 
+	if (!pkram_sb)
+		return -ENODEV;
+
 	mutex_lock(&pkram_mutex);
 	node = pkram_find_node(name);
 	if (!node) {
@@ -708,6 +745,7 @@ static void __pkram_reboot(void)
 		node->node_pfn = node_pfn;
 		node_pfn = page_to_pfn(page);
 	}
+	pkram_sb->node_pfn = node_pfn;
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
@@ -715,7 +753,8 @@ static int pkram_reboot(struct notifier_block *notifier,
 {
 	if (val != SYS_RESTART)
 		return NOTIFY_DONE;
-	__pkram_reboot();
+	if (pkram_sb)
+		__pkram_reboot();
 	return NOTIFY_OK;
 }
 
@@ -723,9 +762,62 @@ static struct notifier_block pkram_reboot_notifier = {
 	.notifier_call = pkram_reboot,
 };
 
+static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	unsigned long pfn = pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
+
+	return sprintf(buf, "%lx\n", pfn);
+}
+
+static struct kobj_attribute pkram_sb_pfn_attr =
+	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
+
+static struct attribute *pkram_attrs[] = {
+	&pkram_sb_pfn_attr.attr,
+	NULL,
+};
+
+static struct attribute_group pkram_attr_group = {
+	.attrs = pkram_attrs,
+};
+
+/* returns non-zero on success */
+static int __init pkram_init_sb(void)
+{
+	unsigned long pfn;
+	struct pkram_node *node;
+
+	if (!pkram_sb) {
+		struct page *page;
+
+		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page) {
+			pr_err("PKRAM: Failed to allocate super block\n");
+			return 0;
+		}
+		pkram_sb = page_address(page);
+	}
+
+	/*
+	 * Build auxiliary doubly-linked list of nodes connected through
+	 * page::lru for convenience sake.
+	 */
+	pfn = pkram_sb->node_pfn;
+	while (pfn) {
+		node = pfn_to_kaddr(pfn);
+		pkram_insert_node(node);
+		pfn = node->node_pfn;
+	}
+	return 1;
+}
+
 static int __init pkram_init(void)
 {
-	register_reboot_notifier(&pkram_reboot_notifier);
+	if (pkram_init_sb()) {
+		register_reboot_notifier(&pkram_reboot_notifier);
+		sysfs_update_group(kernel_kobj, &pkram_attr_group);
+	}
 	return 0;
 }
 module_init(pkram_init);
-- 
2.13.3

