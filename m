Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C01C7EF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgEGAon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:44:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37548 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgEGAom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:44:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470dCV4097456;
        Thu, 7 May 2020 00:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=w6gOhqdHP7hbtdLBjCjLiDcomUNMD9tvJtFBbgdcHPI=;
 b=Lv++/U9G1thp1Jx477m45dEIdSTTpOl/IZTc1/2RMGCUioiWeeoVm7oSSB6ITBLuLy3E
 hb4PEu9jOPp5h43qH3/TWELHqYV83F6pWkutzNXpCvrrUAGx6RKuzZoitB9sZME1+Dpn
 yxpBGXG0EmRLkPCfwp52kSGt+cSAm6nJscyd6ST/1t9CehBtFlDtztZ/e6QJPuixX++d
 yTrGU6b11vzjTeFJyjloX0w+wJrLi0Tph93RVY2loNtSnbBGClJBO2D8eqPCitU1WyS2
 qMfxR55riNPEtqH+5Lszl9DKwQAyK/+tbaauixpximYhHRrI5FXZfvC0GwvWPe4vWRWU bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30usgq4gyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470an8G136067;
        Thu, 7 May 2020 00:43:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdwrr7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:47 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470hkb0029778;
        Thu, 7 May 2020 00:43:46 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:46 -0700
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
Subject: [RFC 20/43] PKRAM: disable feature when running the kdump kernel
Date:   Wed,  6 May 2020 17:41:46 -0700
Message-Id: <1588812129-8596-21-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
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

The kdump kernel should not preserve or restore pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 95e691382721..4d4d836fea53 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/crash_dump.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
@@ -193,7 +194,7 @@ void __init pkram_reserve(void)
 {
 	int err = 0;
 
-	if (!pkram_sb_pfn)
+	if (!pkram_sb_pfn || is_kdump_kernel())
 		return;
 
 	pr_info("PKRAM: Examining preserved memory...\n");
@@ -305,6 +306,9 @@ static void pkram_show_banned(void)
 	int i;
 	unsigned long n, total = 0;
 
+	if (is_kdump_kernel())
+		return;
+
 	pr_info("PKRAM: banned regions:\n");
 	for (i = 0; i < nr_banned; i++) {
 		n = banned[i].end - banned[i].start + 1;
@@ -1223,7 +1227,7 @@ static int __init pkram_init_sb(void)
 
 static int __init pkram_init(void)
 {
-	if (pkram_init_sb()) {
+	if (!is_kdump_kernel() && pkram_init_sb()) {
 		register_reboot_notifier(&pkram_reboot_notifier);
 		register_shrinker(&banned_pages_shrinker);
 		sysfs_update_group(kernel_kobj, &pkram_attr_group);
-- 
2.13.3

