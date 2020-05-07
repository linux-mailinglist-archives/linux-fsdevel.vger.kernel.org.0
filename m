Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C43D1C7F44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgEGAqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgEGAqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bkGp092899;
        Thu, 7 May 2020 00:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=DO62vjvZePhp7wYXZdhX/gUz6VFY4InjbCQaC+l5MmI=;
 b=QTLMQYBVlf732m4qafoDJtBSR4qykUyLHnFro/p7XnvylnJPd8Jc4j1qWmXFSPSx1R/G
 Vw8aYkCpDZiNN0DhG2fShGOBDYqfWq4BTMKXSgagCCiHi8SBEWK2xQSDRFmLpY4Ju0lA
 0FAXG7XhxY5FD6M1VNO5WE1vAjT+EdhE8f5E5VJ3rjoJE5lESCvB6WwAxP/hVilBA0k/
 CfMoBs0UcylgpewtUqXlvcvdhSNcxp0kkEUmKNeJxmCcOkrb68VTRbyVkBYOQ4RRrvmx
 s/gHtt6NFPuupKIZUgeOiVzuGotf2mzcA4Cfpgf/hJAiGLEE76ON3fDFbBYMT5Bfp/h6 hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gnd8te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470am3g170760;
        Thu, 7 May 2020 00:43:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30us7p2mtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:38 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470hak6029744;
        Thu, 7 May 2020 00:43:36 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:14 -0700
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
Subject: [RFC 17/43] PKRAM: provide a way to check if a memory range has preserved pages
Date:   Wed,  6 May 2020 17:41:43 -0700
Message-Id: <1588812129-8596-18-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a kernel is loaded for kexec the address ranges where the kexec
segments will be copied to may conflict with pages already set to be
preserved. Provide a way to determine if preserved pages exist in a
specified range.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 1ba48442ef8e..1cd518843d7a 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -70,11 +70,13 @@ extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
 void pkram_free_pgt(void);
 void pkram_ban_region(unsigned long start, unsigned long end);
+int pkram_has_preserved_pages(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_free_pgt(void) { }
 static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
+static inline int pkram_has_preserved_pages(unsigned long start, unsigned long end) { return 0; }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 60863c8ecbab..0aaaf9b79682 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1499,3 +1499,28 @@ phys_addr_t __init_memblock pkram_memblock_find_in_range(phys_addr_t start,
 
 	return st.retval;
 }
+
+static int pkram_has_preserved_pages_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
+{
+	st->retval = 1;
+	return 1;
+}
+
+/*
+ * Check whether the memory range [start, end) contains preserved pages.
+ */
+int pkram_has_preserved_pages(unsigned long start, unsigned long end)
+{
+	struct pkram_pg_state st = {
+		.range_cb = pkram_has_preserved_pages_cb,
+		.min_addr = start,
+		.max_addr = end,
+	};
+
+	if (!pkram_pgd)
+		return 0;
+
+	pkram_walk_pgt_rev(&st, pkram_pgd);
+
+	return st.retval;
+}
-- 
2.13.3

