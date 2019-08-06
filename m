Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB1B82A95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 06:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfHFEuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 00:50:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfHFEug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 00:50:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x764kZUH076530;
        Tue, 6 Aug 2019 00:50:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u72j8rm35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 00:50:16 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x764kv8N077202;
        Tue, 6 Aug 2019 00:50:15 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u72j8rm2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 00:50:15 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x764iccY015806;
        Tue, 6 Aug 2019 04:50:14 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 2u51w6nwq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 04:50:14 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x764oCt426870128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 04:50:13 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBC037805C;
        Tue,  6 Aug 2019 04:50:12 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 147A27805F;
        Tue,  6 Aug 2019 04:50:08 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.207.254])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Aug 2019 04:50:07 +0000 (GMT)
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
Subject: [PATCH v4 6/6] s390/mm: Remove sev_active() function
Date:   Tue,  6 Aug 2019 01:49:19 -0300
Message-Id: <20190806044919.10622-7-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806044919.10622-1-bauerman@linux.ibm.com>
References: <20190806044919.10622-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060056
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All references to sev_active() were moved to arch/x86 so we don't need to
define it for s390 anymore.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h | 1 -
 arch/s390/mm/init.c                 | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index ff813a56bc30..2542cbf7e2d1 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -5,7 +5,6 @@
 #ifndef __ASSEMBLY__
 
 static inline bool mem_encrypt_active(void) { return false; }
-extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 20340a03ad90..a124f19f7b3c 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -156,14 +156,9 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 }
 
 /* are we a protected virtualization guest? */
-bool sev_active(void)
-{
-	return is_prot_virt_guest();
-}
-
 bool force_dma_unencrypted(struct device *dev)
 {
-	return sev_active();
+	return is_prot_virt_guest();
 }
 
 /* protected virtualization */
