Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF01C7F38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgEGAqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40334 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgEGAqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bjvQ092893;
        Thu, 7 May 2020 00:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=sXz+5MX/e43ODGutAI7Eoi78pN72CvHNRozhR5OcLiY=;
 b=JpV7XO6RwQPucJ1rzxFOrsUoGfS6PaZu4Xq59fbTr7D8gnurRyXVepNkiKrUY7ZWdWuE
 FYeu8glZtcMNsarunOq7+eS23s7Grd371BkO8UvWf6hmDlnYU0BmdCDtAUPCfpzLMU2Z
 oeHzKLxttnshWsKX5tF9pbl/opBNAylWQ5ags9r7Cd5eMsMDy+lwlbODzH9+jE1pE2e5
 OXzO8JyJy8+aoI+pYt1R4fe7cwE3cX9/TpBvxJnvozO0ov0IrK7M8483f84Le4WlP4ot
 fVHYkurQo2RH3pmEkEgSB5l3vGC/x4CImxxdoGFnkDifY5a4l1ye4OafH3qm6fqBMYMX 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gnd8pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470aqPn170885;
        Thu, 7 May 2020 00:44:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30us7p2np8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470i6Ko029955;
        Thu, 7 May 2020 00:44:06 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:05 -0700
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
Subject: [RFC 26/43] mm: shmem: when inserting, handle pages already charged to a memcg
Date:   Wed,  6 May 2020 17:41:52 -0700
Message-Id: <1588812129-8596-27-git-send-email-anthony.yznaga@oracle.com>
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

If shmem_insert_page() is called to insert a page that was preserved
using PKRAM on the current boot (i.e. preserved page is restored without
an intervening kexec boot), the page will still be charged to a memory
cgroup because it is never freed. Don't try to charge it again.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 13475073fb52..1f3b43b8fa34 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -693,6 +693,7 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	struct mem_cgroup *memcg;
 	pgoff_t hindex = index;
 	bool on_lru = PageLRU(page);
+	bool has_memcg = page->mem_cgroup ? true : false;
 
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
@@ -738,20 +739,24 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 
 	__SetPageReferenced(page);
 
-	err = mem_cgroup_try_charge_delay(page, mm, gfp, &memcg,
-					PageTransHuge(page));
-	if (err)
-		goto out_unlock;
+	if (!has_memcg) {
+		err = mem_cgroup_try_charge_delay(page, mm, gfp, &memcg,
+						PageTransHuge(page));
+		if (err)
+			goto out_unlock;
+	}
 
 	err = shmem_add_to_page_cache(page, mapping, hindex,
 					NULL, gfp & GFP_RECLAIM_MASK);
 	if (err) {
-		mem_cgroup_cancel_charge(page, memcg,
-			PageTransHuge(page));
+		if (!has_memcg)
+			mem_cgroup_cancel_charge(page, memcg,
+						PageTransHuge(page));
 		goto out_unlock;
 	}
-	mem_cgroup_commit_charge(page, memcg, on_lru,
-			PageTransHuge(page));
+	if (!has_memcg)
+		mem_cgroup_commit_charge(page, memcg, on_lru,
+					PageTransHuge(page));
 
 	if (!on_lru)
 		lru_cache_add_anon(page);
-- 
2.13.3

