Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DCC1C7EBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgEGAoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:44:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38394 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgEGAoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:44:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bkGi092899;
        Thu, 7 May 2020 00:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Y+m+s4ZCNURBXj766gTT4gE1Fj6SOZhPn+YCjxoGrp4=;
 b=Osuou/V5BI3MblqKTJFUzzNZy5OpWrI3Z+5ocCwhhrXYW+JJzCx0NkO8086TAGBTLoYT
 s3fYplzuOKAnB5WqFvph6yEsPcA060kp2bvo4eNFLyiTYAFZ7ZUw63SqJFZoVX0Dl8h1
 dMwjlznlZQAijOgiMVgOoPPt7hnNh0xZfB+dxRn7N285j88JFRLnI3jeBeo9l1g2S41n
 AlJwLFakJc4Ic1WhMIhDiwJtwuOc0bYX90EdYdetzBpWkKcNwTSOgGJYDuqG/Vky1+GZ
 rvMIc9aZLxizoWSytjjXotor/lxxqCB9KUE5nSF+Zf7EAwKsQeT0gNJwbUTt9nDHf6t8 TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gnd8kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470auqu170921;
        Thu, 7 May 2020 00:43:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30us7p2ma0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470hB01025731;
        Thu, 7 May 2020 00:43:11 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:11 -0700
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
Subject: [RFC 16/43] kexec: PKRAM: prevent kexec clobbering preserved pages in some cases
Date:   Wed,  6 May 2020 17:41:42 -0700
Message-Id: <1588812129-8596-17-git-send-email-anthony.yznaga@oracle.com>
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

When loading a kernel for kexec, dynamically update the list of physical
ranges that are not to be used for storing preserved pages with the ranges
where kexec segments will be copied to on reboot. This ensures no pages
preserved after the new kernel has been loaded will reside in these ranges
on reboot.

Not yet handled is the case where pages have been preserved before a
kexec kernel is loaded.  This will be covered by a later patch.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/kexec.c      |  9 +++++++++
 kernel/kexec_file.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index f977786fe498..c44598fc42a1 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/pkram.h>
 
 #include "kexec_internal.h"
 
@@ -163,6 +164,14 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	for (i = 0; i < nr_segments; i++) {
+		unsigned long mem = image->segment[i].mem;
+		size_t memsz = image->segment[i].memsz;
+
+		if (memsz)
+			pkram_ban_region(PFN_DOWN(mem), PFN_UP(mem + memsz) - 1);
+	}
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index faa74d5f6941..f57f72237859 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -26,6 +26,8 @@
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
+#include <linux/pkram.h>
+
 #include "kexec_internal.h"
 
 static int kexec_calculate_store_digests(struct kimage *image);
@@ -445,6 +447,14 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (ret)
 		goto out;
 
+	for (i = 0; i < image->nr_segments; i++) {
+		unsigned long mem = image->segment[i].mem;
+		size_t memsz = image->segment[i].memsz;
+
+		if (memsz)
+			pkram_ban_region(PFN_DOWN(mem), PFN_UP(mem + memsz) - 1);
+	}
+
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
-- 
2.13.3

