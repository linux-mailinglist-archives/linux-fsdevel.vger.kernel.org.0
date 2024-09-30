Return-Path: <linux-fsdevel+bounces-30348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAF298A244
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C540E1F24528
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023018EFFB;
	Mon, 30 Sep 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a5D6Q9BM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B518CBF7;
	Mon, 30 Sep 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698889; cv=none; b=HSIPkEVj6KduxO113MJ4Ab3krWblYJGYMJ5oEbzXrdxXnVRaXK247zKSQLPsouR4c23HQU0x3NSRJAHJcppf53VXQVkIz3Fd8F7vUdLVDtbjYrdNQ7eOxsqGBAheVvs/nJOlTUSTwI871lT2r2ft1iu7KRPnbevBeFj/5j6XLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698889; c=relaxed/simple;
	bh=0Dypx4pAfpStEhGLYQ/y7T7JERCChhQRMtvM7jepOko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIvOSpuiE4e+yBHBwA3NsjXsivDK3MaigoDTbuqJ6VQSqQ04p9dMmJVLL4sY9UB19QUQkAv99a0nX9L7DBQgpFvAgGKEPUzYaB5WGlZ2zwRsfb+7JuxXmKH7cE7mWGI+UMtNhO1smAQYbhPh7StGDMnSkQiQkyIJfTpnzu1cIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a5D6Q9BM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U7SCLZ016139;
	Mon, 30 Sep 2024 12:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=2Iif2LLQbeGoowxFideHORcoji
	z4pEU4x0tCzl6hF2A=; b=a5D6Q9BMmkCkg94u+0dlO8PK/BRkE12w5qOlfEnTB2
	u/1CFbn29y0EupA6xNLL50iivSuqlQV4TM9+RhC4f6cgZWa474BQ+UOdmY3n8eno
	BWt3xgGH/i3cckBcknP9Q/sv9CJ7EQB2ioTkn3VlIb3vxdbZLDvJMD6/7f6aB10N
	uArICfXpy+zPrIrQonxDPNW1RX7uLDEFupw84eUhV/nKP65CoYcmGI4WMsWAI36i
	VQV2DmlZ+A8nZm2YKd7TC1HzSyyMthE9gPqBNl6P8w1xPop/lGpd/TRGH/AwxcG1
	NIafidfapPOPr43N+nPglcOuxom2YiCIBNqsfLMqCU5Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9ap9t1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 12:21:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCLGZB013047;
	Mon, 30 Sep 2024 12:21:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj66ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 12:21:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UCLKiS57737474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:21:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7337520043;
	Mon, 30 Sep 2024 12:21:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60B3820040;
	Mon, 30 Sep 2024 12:21:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Sep 2024 12:21:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id F2BB7E038D; Mon, 30 Sep 2024 14:21:19 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/kcore.c: Allow translation of physical memory addresses
Date: Mon, 30 Sep 2024 14:21:19 +0200
Message-ID: <20240930122119.1651546-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jB1B9-4O9rrP4LiwLFFzfDcImfAUc2lX
X-Proofpoint-GUID: jB1B9-4O9rrP4LiwLFFzfDcImfAUc2lX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=871 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300087

When /proc/kcore is read an attempt to read the first two pages
results in HW-specific page swap on s390 and another (so called
prefix) pages are accessed instead. That leads to a wrong read.

Allow architecture-specific translation of memory addresses
using kc_xlate_dev_mem_ptr() and kc_unxlate_dev_mem_ptr()
callbacks similarily to /dev/mem xlate_dev_mem_ptr() and
unxlate_dev_mem_ptr() callbacks. That way an architecture
can deal with specific physical memory ranges.

Re-use the existing /dev/mem callback implementation on s390,
which handles the described prefix pages swapping correctly.

For other architectures the default callback is basically NOP.
It is expected the condition (vaddr == __va(__pa(vaddr))) always
holds true for KCORE_RAM memory type.

Cc: stable@vger.kernel.org
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/io.h |  2 ++
 fs/proc/kcore.c            | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 0fbc992d7a5e..fc9933a743d6 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -16,8 +16,10 @@
 #include <asm/pci_io.h>
 
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
+#define kc_xlate_dev_mem_ptr xlate_dev_mem_ptr
 void *xlate_dev_mem_ptr(phys_addr_t phys);
 #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
+#define kc_unxlate_dev_mem_ptr unxlate_dev_mem_ptr
 void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
 #define IO_SPACE_LIMIT 0
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 8e08a9a1b7ed..13a041ef0c4e 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -50,6 +50,20 @@ static struct proc_dir_entry *proc_root_kcore;
 #define	kc_offset_to_vaddr(o) ((o) + PAGE_OFFSET)
 #endif
 
+#ifndef kc_xlate_dev_mem_ptr
+#define kc_xlate_dev_mem_ptr kc_xlate_dev_mem_ptr
+static inline void *kc_xlate_dev_mem_ptr(phys_addr_t phys)
+{
+	return __va(phys);
+}
+#endif
+#ifndef kc_unxlate_dev_mem_ptr
+#define kc_unxlate_dev_mem_ptr kc_unxlate_dev_mem_ptr
+static inline void kc_unxlate_dev_mem_ptr(phys_addr_t phys, void *virt)
+{
+}
+#endif
+
 static LIST_HEAD(kclist_head);
 static DECLARE_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
@@ -471,6 +485,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 	while (buflen) {
 		struct page *page;
 		unsigned long pfn;
+		phys_addr_t phys;
+		void *__start;
 
 		/*
 		 * If this is the first iteration or the address is not within
@@ -537,7 +553,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			}
 			break;
 		case KCORE_RAM:
-			pfn = __pa(start) >> PAGE_SHIFT;
+			phys = __pa(start);
+			pfn =  phys >> PAGE_SHIFT;
 			page = pfn_to_online_page(pfn);
 
 			/*
@@ -557,13 +574,28 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			fallthrough;
 		case KCORE_VMEMMAP:
 		case KCORE_TEXT:
+			if (m->type == KCORE_RAM) {
+				__start = kc_xlate_dev_mem_ptr(phys);
+				if (!__start) {
+					ret = -ENOMEM;
+					if (iov_iter_zero(tsz, iter) != tsz)
+						ret = -EFAULT;
+					goto out;
+				}
+			} else {
+				__start = (void *)start;
+			}
+
 			/*
 			 * Sadly we must use a bounce buffer here to be able to
 			 * make use of copy_from_kernel_nofault(), as these
 			 * memory regions might not always be mapped on all
 			 * architectures.
 			 */
-			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
+			ret = copy_from_kernel_nofault(buf, __start, tsz);
+			if (m->type == KCORE_RAM)
+				kc_unxlate_dev_mem_ptr(phys, __start);
+			if (ret) {
 				if (iov_iter_zero(tsz, iter) != tsz) {
 					ret = -EFAULT;
 					goto out;
-- 
2.43.0


