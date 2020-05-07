Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BFF1C7F4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgEGArN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:47:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41162 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbgEGArL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:47:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470c5BT093096;
        Thu, 7 May 2020 00:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=xGbfAvtj4sdRqUcckGpXoks3Z0mla/qk9EywXv5xu4U=;
 b=ZbRXCCwD3zJvBSBtHjKnv3vKD/s9Qh7+x7uXjU+8pHxhQY/Sl+24VJ/XFTNx/s+Fx2UB
 Ixyz374M5ijuqSxj59zlH7kueEtpWqdvI9M/gcgjekxtAX75lAYkYnoqRS9TdHJavfKM
 1SHz3fPIA+JwP4nxyYOFp9gC4mslfLfsGeMNtghQMnwhqT2K6s6h1fr0G528Yj5+NXLp
 VIIVwUXjKRB4fgVXtBSeX8n89zutroqtjC8vVH6Csgt1fIHLY8S8bCCuOTCKfChAu5bF
 GSKHMacUI76DMGWYW30lTPhXj0kBzBh9hsGqqQHGejk6kRr7kTcf0FlJRlkLh9R3do1h lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gnd8uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:46:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bUPP098663;
        Thu, 7 May 2020 00:44:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30sjnma4qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:10 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470i9tL020333;
        Thu, 7 May 2020 00:44:09 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:09 -0700
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
Subject: [RFC 27/43] x86/mm/numa: add numa_isolate_memblocks()
Date:   Wed,  6 May 2020 17:41:53 -0700
Message-Id: <1588812129-8596-28-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
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

Provide a way for a caller external to numa to ensure memblocks in the
memblock reserved list do not cross node boundaries and have a node id
assigned to them.  This will be used by PKRAM to ensure initialization of
page structs for preserved pages can be deferred and multithreaded
efficiently.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/include/asm/numa.h |  4 ++++
 arch/x86/mm/numa.c          | 32 ++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index bbfde3d2662f..f9e05f4eb1c6 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -40,6 +40,7 @@ static inline void set_apicid_to_node(int apicid, s16 node)
 }
 
 extern int numa_cpu_node(int cpu);
+extern void __init numa_isolate_memblocks(void);
 
 #else	/* CONFIG_NUMA */
 static inline void set_apicid_to_node(int apicid, s16 node)
@@ -50,6 +51,9 @@ static inline int numa_cpu_node(int cpu)
 {
 	return NUMA_NO_NODE;
 }
+static inline void numa_isolate_memblocks(void)
+{
+}
 #endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..df0065e24ea5 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -475,6 +475,25 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
 	return true;
 }
 
+void __init numa_isolate_memblocks(void)
+{
+	int i;
+
+	/*
+	 * Iterate over all memory known to the x86 architecture,
+	 * and use those ranges to set the nid in memblock.reserved.
+	 * This will split up the memblock regions along node
+	 * boundaries and will set the node IDs as well.
+	 */
+	for (i = 0; i < numa_meminfo.nr_blks; i++) {
+		struct numa_memblk *mb = numa_meminfo.blk + i;
+		int ret;
+
+		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
+		WARN_ON_ONCE(ret);
+	}
+}
+
 /*
  * Mark all currently memblock-reserved physical memory (which covers the
  * kernel's own memory ranges) as hot-unswappable.
@@ -493,19 +512,8 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	 * used by the kernel, but those regions are not split up
 	 * along node boundaries yet, and don't necessarily have their
 	 * node ID set yet either.
-	 *
-	 * So iterate over all memory known to the x86 architecture,
-	 * and use those ranges to set the nid in memblock.reserved.
-	 * This will split up the memblock regions along node
-	 * boundaries and will set the node IDs as well.
 	 */
-	for (i = 0; i < numa_meminfo.nr_blks; i++) {
-		struct numa_memblk *mb = numa_meminfo.blk + i;
-		int ret;
-
-		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
-		WARN_ON_ONCE(ret);
-	}
+	numa_isolate_memblocks();
 
 	/*
 	 * Now go over all reserved memblock regions, to construct a
-- 
2.13.3

