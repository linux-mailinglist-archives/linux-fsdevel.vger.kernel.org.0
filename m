Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C546C7DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 05:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbfGRD36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 23:29:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389773AbfGRD35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:29:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I3S3k3020823;
        Wed, 17 Jul 2019 23:29:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttd5fxwqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 23:29:36 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6I3TZ4g023661;
        Wed, 17 Jul 2019 23:29:35 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttd5fxwpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 23:29:35 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6I3QAfC014366;
        Thu, 18 Jul 2019 03:29:34 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 2tq6x6cjtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 03:29:34 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6I3TYeq49152454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 03:29:34 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AE38AE05F;
        Thu, 18 Jul 2019 03:29:34 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9695AE060;
        Thu, 18 Jul 2019 03:29:29 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.129.123])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 03:29:29 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     x86@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 4/6] x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header
Date:   Thu, 18 Jul 2019 00:28:56 -0300
Message-Id: <20190718032858.28744-5-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718032858.28744-1-bauerman@linux.ibm.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180037
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that generic code doesn't reference them, move sme_active() and
sme_me_mask to x86's <asm/mem_encrypt.h>.

Also remove the export for sme_active() since it's only used in files that
won't be built as modules. sme_me_mask on the other hand is used in
arch/x86/kvm/svm.c (via __sme_set() and __psp_pa()) which can be built as a
module so its export needs to stay.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h |  4 +---
 arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
 arch/x86/mm/mem_encrypt.c           |  1 -
 include/linux/mem_encrypt.h         | 14 +-------------
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index 3eb018508190..ff813a56bc30 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -4,9 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 0c196c47d621..848ce43b9040 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -92,6 +92,16 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
+static inline bool mem_encrypt_active(void)
+{
+	return sme_me_mask;
+}
+
+static inline u64 sme_get_me_mask(void)
+{
+	return sme_me_mask;
+}
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c805f0a5c16e..7139f2f43955 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -344,7 +344,6 @@ bool sme_active(void)
 {
 	return sme_me_mask && !sev_enabled;
 }
-EXPORT_SYMBOL(sme_active);
 
 bool sev_active(void)
 {
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 470bd53a89df..0c5b0ff9eb29 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -18,23 +18,11 @@
 
 #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-static inline bool mem_encrypt_active(void)
-{
-	return sme_me_mask;
-}
-
-static inline u64 sme_get_me_mask(void)
-{
-	return sme_me_mask;
-}
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * The __sme_set() and __sme_clr() macros are useful for adding or removing
