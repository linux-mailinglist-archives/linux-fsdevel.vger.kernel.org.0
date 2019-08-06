Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4382AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 06:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfHFEwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 00:52:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbfHFEwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 00:52:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x764kb91019442;
        Tue, 6 Aug 2019 00:50:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u72539d6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 00:50:10 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x764mGRk022956;
        Tue, 6 Aug 2019 00:50:10 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u72539d63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 00:50:10 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x764itIf029304;
        Tue, 6 Aug 2019 04:50:09 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 2u51w628n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 04:50:09 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x764o7kG9306394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 04:50:07 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A495B7805F;
        Tue,  6 Aug 2019 04:50:07 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1D3178060;
        Tue,  6 Aug 2019 04:50:02 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.207.254])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Aug 2019 04:50:02 +0000 (GMT)
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
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v4 5/6] fs/core/vmcore: Move sev_active() reference to x86 arch code
Date:   Tue,  6 Aug 2019 01:49:18 -0300
Message-Id: <20190806044919.10622-6-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806044919.10622-1-bauerman@linux.ibm.com>
References: <20190806044919.10622-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060056
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
appear in generic kernel code because it forces non-x86 architectures to
define the sev_active() function, which doesn't make a lot of sense.

To solve this problem, add an x86 elfcorehdr_read() function to override
the generic weak implementation. To do that, it's necessary to make
read_from_oldmem() public so that it can be used outside of vmcore.c.

Also, remove the export for sev_active() since it's only used in files that
won't be built as modules.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/crash_dump_64.c |  5 +++++
 arch/x86/mm/mem_encrypt.c       |  1 -
 fs/proc/vmcore.c                |  8 ++++----
 include/linux/crash_dump.h      | 14 ++++++++++++++
 include/linux/mem_encrypt.h     |  1 -
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 22369dd5de3b..045e82e8945b 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -70,3 +70,8 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 {
 	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
 }
+
+ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
+{
+	return read_from_oldmem(buf, count, ppos, 0, sev_active());
+}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 94da5a88abe6..9268c12458c8 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -349,7 +349,6 @@ bool sev_active(void)
 {
 	return sme_me_mask && sev_enabled;
 }
-EXPORT_SYMBOL(sev_active);
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7bcc92add72c..7b13988796e1 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -104,9 +104,9 @@ static int pfn_is_ram(unsigned long pfn)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-static ssize_t read_from_oldmem(char *buf, size_t count,
-				u64 *ppos, int userbuf,
-				bool encrypted)
+ssize_t read_from_oldmem(char *buf, size_t count,
+			 u64 *ppos, int userbuf,
+			 bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -170,7 +170,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sev_active());
+	return read_from_oldmem(buf, count, ppos, 0, false);
 }
 
 /*
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index f774c5eb9e3c..4664fc1871de 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -115,4 +115,18 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
 	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
+
+#ifdef CONFIG_PROC_VMCORE
+ssize_t read_from_oldmem(char *buf, size_t count,
+			 u64 *ppos, int userbuf,
+			 bool encrypted);
+#else
+static inline ssize_t read_from_oldmem(char *buf, size_t count,
+				       u64 *ppos, int userbuf,
+				       bool encrypted)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_PROC_VMCORE */
+
 #endif /* LINUX_CRASHDUMP_H */
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 0c5b0ff9eb29..5c4a18a91f89 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -19,7 +19,6 @@
 #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
 static inline bool mem_encrypt_active(void) { return false; }
-static inline bool sev_active(void) { return false; }
 
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
