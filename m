Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C11C7F59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgEGArK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:47:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49170 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgEGApf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470c16Z064684;
        Thu, 7 May 2020 00:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=9f3UmDwL/aqxnXqEfybd2gNvyfWYGqkBvYGTXbV7Xmo=;
 b=TW6ZzRePDXfEU0ecjZeUmFlqbW9LoXtCpaOl0HlyOXm1Me6fsnBFHZrpCPNhhq7ttnTD
 t0TBEzgUoxr/3lONrETFdIlI09RlNdX6CuSHn+9A4e8QgDsUeJm5++2u9tADLBJOux+l
 fgkHDqoJN12o0sMaicYlau4KG5phGGI5rWDkH8NacH8Y8SoN93PvuLYdTLSasJpFpBPb
 H9tdopuB1vR10FMfJJfkGY8Jg0pg2/Rby/r4PfyL1DVWfdh0qJhobQRNlO71jjzfD6a4
 bSYCi7CY/aShuBoGMuZ3DeCkUgAJQB4pNmxUE9lUJ6bQQjGuF4GDadaKs6PgPQoarjlj BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09rdfc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bm9X131707;
        Thu, 7 May 2020 00:44:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30t1r95cpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:37 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470iX0S026145;
        Thu, 7 May 2020 00:44:34 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:33 -0700
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
Subject: [RFC 33/43] PKRAM: atomically add and remove link pages
Date:   Wed,  6 May 2020 17:41:59 -0700
Message-Id: <1588812129-8596-34-git-send-email-anthony.yznaga@oracle.com>
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

Add and remove pkram_link pages from a pkram_obj atomically to prepare
for multithreading.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 5f4e4d12865f..042c14dedc25 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -551,22 +551,31 @@ static void pkram_truncate(void)
 
 static void pkram_add_link(struct pkram_link *link, struct pkram_obj *obj)
 {
-	link->link_pfn = obj->link_pfn;
-	obj->link_pfn = page_to_pfn(virt_to_page(link));
+	__u64 link_pfn = page_to_pfn(virt_to_page(link));
+	__u64 *head = &obj->link_pfn;
+
+	do {
+		link->link_pfn = *head;
+	} while (cmpxchg64(head, link->link_pfn, link_pfn) != link->link_pfn);
 }
 
 static struct pkram_link *pkram_remove_link(struct pkram_obj *obj)
 {
 	struct pkram_link *current_link;
+	__u64 *head = &obj->link_pfn;
+	__u64 head_pfn = *head;
+
+	while (head_pfn) {
+		current_link = pfn_to_kaddr(head_pfn);
+		if (cmpxchg64(head, head_pfn, current_link->link_pfn) == head_pfn) {
+			current_link->link_pfn = 0;
+			return current_link;
+		}
 
-	if (!obj->link_pfn)
-		return NULL;
-
-	current_link = pfn_to_kaddr(obj->link_pfn);
-	obj->link_pfn = current_link->link_pfn;
-	current_link->link_pfn = 0;
+		head_pfn = *head;
+	}
 
-	return current_link;
+	return NULL;
 }
 
 static void pkram_stream_init(struct pkram_stream *ps,
-- 
2.13.3

