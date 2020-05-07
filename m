Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166C51C7F1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgEGApm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38572 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgEGApl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470dEUJ097500;
        Thu, 7 May 2020 00:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=tOzDN5QRiW0NbdfQAY9h5DJPaKglehgjEjrdEdmx1f4=;
 b=lBRYYVjiwnboBLdsbCnfuIKuUvyV4Tb1PrnqIJzVMBtICdZ9jaFnmAsVtSqdufLw8Lkj
 R/rLVnwt21p57My0cE/rC/CpuNQ4Mzukt/dxNwn87fyXSXioV/8VV0X4ro8aZ60ZGB7x
 CS07279N98Ai7FAC4KfEWCksHQTXacRnj6rWSwdiGHc/dZ8N+XKy+sYelKE4Cy8d/1to
 FMWAPMfC1fvp/xhjRmQylo2gn9PzBstNHezUodSJte6uzxyt2tjCSrKc/4DPgyG6py+N
 qH/XacX69hs+noVnHM24ROyLnA8wJFKZcLGbbMgSIA76DkT9aK5lV+sxssGBjrJ03+js nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30usgq4h2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470am50170751;
        Thu, 7 May 2020 00:44:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30us7p2pjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:49 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470iksR026299;
        Thu, 7 May 2020 00:44:46 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:46 -0700
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
Subject: [RFC 37/43] shmem: PKRAM: enable bulk loading of preserved pages into shmem
Date:   Wed,  6 May 2020 17:42:03 -0700
Message-Id: <1588812129-8596-38-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make use of new interfaces for loading and inserting preserved pages
into a shmem file in bulk.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 4992b6c3e54e..435488368104 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -315,18 +315,29 @@ static inline void pkram_load_report_one_done(void)
 static int do_load_file_content(struct pkram_stream *ps)
 {
 	unsigned long index;
-	struct page *page;
-	int err = 0;
+	int i, err;
+
+	err = pkram_prepare_load_pages(ps);
+	if (err)
+		return err;
 
 	do {
-		page = pkram_load_page(ps, &index, NULL);
-		if (!page)
+		err = pkram_load_pages(ps, &index);
+		if (err) {
+			if (err == -ENODATA)
+				err = 0;
 			break;
+		}
 
-		err = shmem_insert_page(ps->mm, ps->mapping->host, index, page);
-		put_page(page);
+		err = shmem_insert_pages(ps->mm, ps->mapping->host, index,
+					 ps->pages, ps->nr_pages);
+
+		for (i = 0; i < ps->nr_pages; i++)
+			put_page(ps->pages[i]);
 	} while (!err);
 
+	pkram_finish_load_pages(ps);
+
 	return err;
 }
 
-- 
2.13.3

