Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74196D9F57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 19:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbjDFR4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 13:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjDFR4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:56:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8345A8F;
        Thu,  6 Apr 2023 10:56:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336F23Z6008734;
        Thu, 6 Apr 2023 17:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2022-7-12;
 bh=dCc98tc+K7B2gGLsHrMY6E1PPXTznWvSJ+whPGiSgG8=;
 b=SQIwOyX32c0hTROHGCovM5ewxfb3hTUmMswdw1uIBZrDn0PU0RYxW26NN8aWyHZ/1h59
 GKGEBeH9tIBlqStQAJnSQWea8HqcTDn1VUsKCVlTfKlVzcuKujx9/vnNXAyKmFHIzlGa
 HuZjfsL0o3KA7VqWF85Miw+15vDgPyNetb4okxZlvxww2hRIQfX21jNxdTRffNgotVKc
 vurKIwi8cCW9Ixal8miw/mCTSo3c7oZ7MpquLfWojWUBtHXmAfTNjwFn5mtmAfHtwUtr
 wi4Rj+HhPmg6reXJn0RIUpQ6KRecOKwo7ZNJQW13iDoihXvvDgHt2RxbvyZUHlAeM2mq 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5ukk5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 17:56:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336GrIHc036579;
        Thu, 6 Apr 2023 17:56:07 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptpam2pf-1;
        Thu, 06 Apr 2023 17:56:07 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] dax: enable dax fault handler to report VM_FAULT_HWPOISON
Date:   Thu,  6 Apr 2023 11:55:56 -0600
Message-Id: <20230406175556.452442-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060157
X-Proofpoint-ORIG-GUID: HI2WBJt73uxLrvuI0-OK0wIYHsoxP7Y3
X-Proofpoint-GUID: HI2WBJt73uxLrvuI0-OK0wIYHsoxP7Y3
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When dax fault handler fails to provision the fault page due to
hwpoison, it returns VM_FAULT_SIGBUS which lead to a sigbus delivered
to userspace with .si_code BUS_ADRERR.  Channel dax backend driver's
detection on hwpoison to the filesystem to provide the precise reason
for the fault.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c |  2 +-
 fs/dax.c              | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ceea55f621cc..46e094e56159 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long actual_nr;
 
 		if (mode != DAX_RECOVERY_WRITE)
-			return -EIO;
+			return -EHWPOISON;
 
 		/*
 		 * Set the recovery stride is set to kernel page size because
diff --git a/fs/dax.c b/fs/dax.c
index 3e457a16c7d1..3f22686abc88 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1456,7 +1456,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				DAX_ACCESS, &kaddr, NULL);
-		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
+		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
 			map_len = dax_direct_access(dax_dev, pgoff,
 					PHYS_PFN(size), DAX_RECOVERY_WRITE,
 					&kaddr, NULL);
@@ -1550,11 +1550,21 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(dax_iomap_rw);
 
+/*
+ * Concerning hwpoison triggered page fault: dax is THP, a pmd
+ * level fault handler will fallback (VM_FAULT_FALLBACK) before
+ * give up, hence return VM_FAULT_HWPOISON which implies
+ * corrupted range is PAGE_SIZE.
+ */
 static vm_fault_t dax_fault_return(int error)
 {
 	if (error == 0)
 		return VM_FAULT_NOPAGE;
-	return vmf_error(error);
+	else if (error == -ENOMEM)
+		return VM_FAULT_OOM;
+	else if (error == -EHWPOISON)
+		return VM_FAULT_HWPOISON;
+	return VM_FAULT_SIGBUS;
 }
 
 /*
-- 
2.18.4

