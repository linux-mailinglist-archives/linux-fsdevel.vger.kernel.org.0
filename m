Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AA1C7EEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEGAnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:43:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgEGAnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:43:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bsEQ064662;
        Thu, 7 May 2020 00:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=SpL3oKOP1UxupMjs93me4aiFXOO1A2VSszu1s3lkQmE=;
 b=UrmNLP0/tNsOo2Ji29J5AZ9A7RkHNfzxRzF3rav8+hRASZW4Duvh8uT+pZDF6H3zWKU2
 /202rP9YThZNIHoKaOGQBIyfgkQEuU6tmMG1rYH38Of8YlNR2FX2ITHoSeQXbBsV2QRQ
 kXjPmaZxZXfdvPG7uqvUo0xNFd3P4DJR3CNhKsyWnrWT2q7/cheB+C/KWDV7ShneEy5u
 ZUgmUsqRPA1/e9u9Ab1oiHezM4HS/AjdypfYZ9nzyc0+usWobKBzF6fPWv9a247nmqB9
 1uq24OdbiUFFzA49N05/7YtGMk/afxEI0JU5tidZ970dhtUfzTYIDxMWQw2hWIWi0XmK AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09rdf6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bUYE098714;
        Thu, 7 May 2020 00:42:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30sjnma1gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:55 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470gsjj019822;
        Thu, 7 May 2020 00:42:54 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:53 -0700
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
Subject: [RFC 11/43] PKRAM: pass the preserved pages pagetable to the next kernel
Date:   Wed,  6 May 2020 17:41:37 -0700
Message-Id: <1588812129-8596-12-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
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

Add a pointer to the pagetable to the pkram_super_block page.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 5a7b8f61a55d..54b2779d0813 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -94,6 +94,7 @@ struct pkram_node {
  */
 struct pkram_super_block {
 	__u64	node_pfn;		/* first element of the node list */
+	__u64	pgd_pfn;
 };
 
 static unsigned long pkram_sb_pfn __initdata;
@@ -769,15 +770,20 @@ static void __pkram_reboot(void)
 	struct page *page;
 	struct pkram_node *node;
 	unsigned long node_pfn = 0;
-
-	list_for_each_entry_reverse(page, &pkram_nodes, lru) {
-		node = page_address(page);
-		if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
-			continue;
-		node->node_pfn = node_pfn;
-		node_pfn = page_to_pfn(page);
+	unsigned long pgd_pfn = 0;
+
+	if (pkram_pgd) {
+		list_for_each_entry_reverse(page, &pkram_nodes, lru) {
+			node = page_address(page);
+			if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
+				continue;
+			node->node_pfn = node_pfn;
+			node_pfn = page_to_pfn(page);
+		}
+		pgd_pfn = page_to_pfn(virt_to_page(pkram_pgd));
 	}
 	pkram_sb->node_pfn = node_pfn;
+	pkram_sb->pgd_pfn = pgd_pfn;
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
-- 
2.13.3

