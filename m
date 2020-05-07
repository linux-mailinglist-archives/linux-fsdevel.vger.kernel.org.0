Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E350D1C7F0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgEGAp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49036 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgEGAp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470c16X064684;
        Thu, 7 May 2020 00:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=o4VeZakxk7q/YukxMsyh8pVT0eR9oJkktza+0HTryhw=;
 b=F258v4CUKrVK7T6Q6EY2mRI9P9FAoQwDZIKnDCnu7ShoFjdjhIj3PVgoaI8w7b9nGTfD
 lsGI5U37QGPAW6648U/DlMs/4F0V+w18oLcSdcdJoLSxjlG1IPYnd+w0fwscwvhQxBIE
 LLv6ILBDZYp2qCb5JeNRfBA2J9mONHUseYdPwtJXgRxzkymZYNWzAXgd8qtTcTe+3p0d
 FIwoPNTiAAseFe5DM1z52GJKzVVP0qA0zuu7NIzSR+jImjxIUypqBj2xvd5tjd4aW7V5
 gGsYVMmFxFiqqvyJBiBh7PupIgVskESG+K/go7bQWgc9UsKPJzDHFrSlO8pNUHee6Equ 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09rdfbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bhYE098923;
        Thu, 7 May 2020 00:44:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30sjnma4vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470iCZR029965;
        Thu, 7 May 2020 00:44:12 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:12 -0700
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
Subject: [RFC 28/43] PKRAM: ensure memblocks with preserved pages init'd for numa
Date:   Wed,  6 May 2020 17:41:54 -0700
Message-Id: <1588812129-8596-29-git-send-email-anthony.yznaga@oracle.com>
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

In order to facilitate fast initialization of page structs for
preserved pages, memblocks with preserved pages must not cross
numa node boundaries and must have a node id assigned to them.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index a5e539052af6..97a7dd0a5b7d 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -21,6 +21,7 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
+#include <asm/numa.h>
 #include "internal.h"
 
 
@@ -242,6 +243,15 @@ void __init pkram_reserve(void)
 		return;
 	}
 
+	/*
+	 * Fix up the reserved memblock list to ensure the
+	 * memblock regions are split along node boundaries
+	 * and have a node ID set.  This will allow the page
+	 * structs for the preserved pages to be initialized
+	 * more efficiently.
+	 */
+	numa_isolate_memblocks();
+
 done:
 	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
 }
-- 
2.13.3

