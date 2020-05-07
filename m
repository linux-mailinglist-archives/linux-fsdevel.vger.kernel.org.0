Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A443C1C7F07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgEGApH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39276 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgEGApF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470c5BP093096;
        Thu, 7 May 2020 00:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ALhXxW63LGZoM6V1NGaT+SnLTVsGEByBjEn2ykRFtnU=;
 b=WcY7ARrycjOtSErtWFAU7jEvJCDzYLSMBBQdEfiSz+VYmm+P1vsiQipFRaHJUKefDQGP
 6SpWpJBVSg9v6poZtOhM+2hrCsnxl4pzn6zYo4RjyJ4+qFdAymPEnFqh+BblrFOCjNA0
 XyKWvLvG7vKezc7rF7JYRpliViNaHZR8KW1i1GGsXAXequif8VvZ+tkVIKDcugDuYbBH
 YuryJoR0X2xYHmHfLo+CWApOuQEpt2LzEmBRNoO7V72Rr1m6OLrd+fh37MBvbvhCdP1e
 kocUdOrK1sim2WztAHrtjy2lA9VQ/tMfFjN2zEdc7hlmRCU+CQRP/xvQDIkwglOkuSz6 pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gnd8pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470alNS170704;
        Thu, 7 May 2020 00:44:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30us7p2nm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:05 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470i20o025972;
        Thu, 7 May 2020 00:44:02 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:02 -0700
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
Subject: [RFC 25/43] mm: shmem: specify the mm to use when inserting pages
Date:   Wed,  6 May 2020 17:41:51 -0700
Message-Id: <1588812129-8596-26-git-send-email-anthony.yznaga@oracle.com>
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

Explicitly specify the mm to pass to shmem_insert_page() when
the pkram_stream is initialized rather than use the mm of the
current thread.  This will allow for multiple kernel threads to
target the same mm when inserting pages in parallel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h | 1 +
 mm/pkram.c            | 1 +
 mm/shmem_pkram.c      | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index b47b3aef16e3..cbb79d2803c0 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -18,6 +18,7 @@ struct pkram_stream {
 
 	unsigned long next_index;
 	struct address_space *mapping;
+	struct mm_struct *mm;
 
 	/* byte data */
 	struct page *data_page;
diff --git a/mm/pkram.c b/mm/pkram.c
index 4d4d836fea53..a5e539052af6 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -565,6 +565,7 @@ static void pkram_stream_init(struct pkram_stream *ps,
 	memset(ps, 0, sizeof(*ps));
 	ps->gfp_mask = gfp_mask;
 	ps->node = node;
+	ps->mm = current->mm;
 }
 
 static void pkram_stream_init_obj(struct pkram_stream *ps, struct pkram_obj *obj)
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 3fa9cfbe0003..c97d64393822 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -236,7 +236,7 @@ static int load_file_content(struct pkram_stream *ps)
 		if (!page)
 			break;
 
-		err = shmem_insert_page(current->mm, ps->mapping->host, index, page);
+		err = shmem_insert_page(ps->mm, ps->mapping->host, index, page);
 		put_page(page);
 	} while (!err);
 
-- 
2.13.3

