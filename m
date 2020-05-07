Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB21C7EF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgEGAol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:44:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48176 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgEGAok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:44:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470d0Rc076188;
        Thu, 7 May 2020 00:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=J7Q+8SZ1gV5T2Of756nJv1YzUrvepjMeioLG71z3S9M=;
 b=ZyZVIh+MFM4KSfqsEhgzO46tDmQNFz765fTjdy+D4xU3ipcRB4RqVS3Ui8zi49/8Ap5m
 uxAO0SZOBdfYpSHGBGsUK9p6hQSzdgS+89nD1xz9fhavAyL7kDa4j1OR1SuUMBON8fbs
 PVxNXpO35dZqRxizwgRFvZ0lao4k0btp9BTTGY1o8N3OnCEDci+NxECx4IwJ+VzMCCzu
 irdnqptbP0eeiMXPTKaufoXZ92kCvw3vlQyKH2rWoyy+r3Amkwp//FBzsBUefmAR7hJM
 zZQWi7OuDr/0R7Lb3Ar6Mr3h4BfOX4xxQ1mDCXA9rWFiBnQOxo9XrkS4cm6Mo7VqGSP7 lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09rdf9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470alNK170704;
        Thu, 7 May 2020 00:43:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30us7p2n40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:46 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470hhja024556;
        Thu, 7 May 2020 00:43:43 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:42 -0700
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
Subject: [RFC 19/43] mm: PKRAM: allow preserved memory to be freed from userspace
Date:   Wed,  6 May 2020 17:41:45 -0700
Message-Id: <1588812129-8596-20-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To free all space utilized for preserved memory, one can write 0 to
/sys/kernel/pkram. This will destroy all PKRAM nodes that are not
currently being read or written.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 0aaaf9b79682..95e691382721 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -509,6 +509,32 @@ static void pkram_truncate_node(struct pkram_node *node)
 	node->obj_pfn = 0;
 }
 
+/*
+ * Free all nodes that are not under operation.
+ */
+static void pkram_truncate(void)
+{
+	struct page *page, *tmp;
+	struct pkram_node *node;
+	LIST_HEAD(dispose);
+
+	mutex_lock(&pkram_mutex);
+	list_for_each_entry_safe(page, tmp, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (!(node->flags & PKRAM_ACCMODE_MASK))
+			list_move(&page->lru, &dispose);
+	}
+	mutex_unlock(&pkram_mutex);
+
+	while (!list_empty(&dispose)) {
+		page = list_first_entry(&dispose, struct page, lru);
+		list_del(&page->lru);
+		node = page_address(page);
+		pkram_truncate_node(node);
+		pkram_free_page(node);
+	}
+}
+
 static void pkram_add_link(struct pkram_link *link, struct pkram_obj *obj)
 {
 	link->link_pfn = obj->link_pfn;
@@ -1141,8 +1167,19 @@ static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
 	return sprintf(buf, "%lx\n", pfn);
 }
 
+static ssize_t store_pkram_sb_pfn(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int val;
+
+	if (kstrtoint(buf, 0, &val) || val)
+		return -EINVAL;
+	pkram_truncate();
+	return count;
+}
+
 static struct kobj_attribute pkram_sb_pfn_attr =
-	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
+	__ATTR(pkram, 0644, show_pkram_sb_pfn, store_pkram_sb_pfn);
 
 static struct attribute *pkram_attrs[] = {
 	&pkram_sb_pfn_attr.attr,
-- 
2.13.3

