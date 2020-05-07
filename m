Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83441C7F2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgEGAqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38868 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgEGAqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470dOG7097631;
        Thu, 7 May 2020 00:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=U5kSpS0/Dc5fgEe6X16U4eAHbnbPBtC/T/domT4TH8s=;
 b=vm1xGfzfTCm7LXxnLDJHzBg+kv+2Q3Gu1b70Z2+C7lDFsCCkSq2aF5KU4TaJWKovUTbm
 4ZCOEQ05F0FY1NqHr63zFBE+93CAKFygbJaDM38ipDP0MjM3ZnKCMwqPxeYsyU2jqMgs
 EBDvlOYXbwTwEFkmLSqhwG/YD/Rh/FaeX3jxgpBiaR2ZyrHOjnpcWNgOcb0XCceJeF1f
 BdYiGLFJmlbWo697vNbyzh7SOZaBzfqwlhp4wsjkyOoz34sQb6Ti3HK26oJnEH9zCczv
 olmk4xH+Sda92kPCQl7VvYBJq/Bv8KAwazzL+LEYXb1xcT74Gb7QSPUdgly1DKhBX9I6 XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30usgq4h2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470alL4170703;
        Thu, 7 May 2020 00:44:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30us7p2pnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:55 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470irBD020628;
        Thu, 7 May 2020 00:44:53 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:53 -0700
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
Subject: [RFC 39/43] shmem: optimize adding pages to the LRU in shmem_insert_pages()
Date:   Wed,  6 May 2020 17:42:05 -0700
Message-Id: <1588812129-8596-40-git-send-email-anthony.yznaga@oracle.com>
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

Reduce LRU lock contention when inserting shmem pages by staging pages
to be added to the same LRU and adding them en masse.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ca5edf580f24..678a396ba8d3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -789,9 +789,12 @@ int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	gfp_t gfp = mapping_gfp_mask(mapping);
 	struct mem_cgroup *memcg;
+	struct lru_splice splice;
 	int i, err;
 	int nr = 0;
 
+	memset(&splice, 0, sizeof(splice));
+
 	for (i = 0; i < npages; i++)
 		nr += compound_nr(pages[i]);
 
@@ -866,7 +869,7 @@ int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 		}
 
 		if (!PageLRU(pages[i]))
-			lru_cache_add_anon(pages[i]);
+			lru_splice_add_anon(pages[i], &splice);
 
 		flush_dcache_page(pages[i]);
 		SetPageUptodate(pages[i]);
@@ -875,6 +878,9 @@ int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 		unlock_page(pages[i]);
 	}
 
+	if (splice.pgdat)
+		add_splice_to_lru_list(&splice);
+
 	return 0;
 
 out_truncate:
-- 
2.13.3

