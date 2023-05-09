Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E346FBEDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 07:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjEIFr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 01:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjEIFr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 01:47:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110C29EE9;
        Mon,  8 May 2023 22:47:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348Nx5l3023288;
        Tue, 9 May 2023 05:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=M2vOL7hFnbsL6PlSivS6BJ8zQTQm0nrYjstUJCp2KF0=;
 b=PtVkKWjRJUtgTjkfRSEO/cpQ+E7f62NyrmoM8bv0jqMZ+8IH8oZkXyG76W+Pd35wWwx+
 v6UiitWqI+8VcvW+0kvmlL5rrNIPCXPN1I+PDxfOTYbJqg0rcf/j8qF/htwjtXLFKnGy
 xS6memgCAkM2ETQDhBU1S0mtT7YGR1bKwWaxfv3qiEqXMw3s/WdtMMqlpdQgVQ2ABgjl
 OPWIJ2c/k4rm14s0WGYJNwAOHbjwSLl7xALl7+eECKhXTr9ZpNlnb27Evpri/fBPB5QP
 0qeenh+CAXDl5oj+EreV0cvMH5gURKCCQI+GUiYANqyMtLkpyt/IJl3ZG7pLmDcsU3fV GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7770v20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 05:47:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3495JB4U001645;
        Tue, 9 May 2023 05:47:29 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qf82v5m4u-2;
        Tue, 09 May 2023 05:47:29 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 1/1] dax: enable dax fault handler to report VM_FAULT_HWPOISON
Date:   Mon,  8 May 2023 23:47:14 -0600
Message-Id: <20230509054714.1746956-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20230509054714.1746956-1-jane.chu@oracle.com>
References: <20230509054714.1746956-1-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090043
X-Proofpoint-GUID: -SQGS-ooAgKmbzfQX93G0yPUydxBTmyS
X-Proofpoint-ORIG-GUID: -SQGS-ooAgKmbzfQX93G0yPUydxBTmyS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When multiple processes mmap() a dax file, then at some point,
a process issues a 'load' and consumes a hwpoison, the process
receives a SIGBUS with si_code = BUS_MCEERR_AR and with si_lsb
set for the poison scope. Soon after, any other process issues
a 'load' to the poisoned page (that is unmapped from the kernel
side by memory_failure), it receives a SIGBUS with
si_code = BUS_ADRERR and without valid si_lsb.

This is confusing to user, and is different from page fault due
to poison in RAM memory, also some helpful information is lost.

Channel dax backend driver's poison detection to the filesystem
such that instead of reporting VM_FAULT_SIGBUS, it could report
VM_FAULT_HWPOISON.

If user level block IO syscalls fail due to poison, the errno will
be converted to EIO to maintain block API consistency.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c          |  5 ++++-
 drivers/nvdimm/pmem.c        |  2 +-
 drivers/s390/block/dcssblk.c |  3 ++-
 fs/dax.c                     | 11 ++++++-----
 fs/fuse/virtio_fs.c          |  3 ++-
 include/linux/dax.h          |  5 +++++
 include/linux/mm.h           |  2 ++
 7 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c4c4728a36e4..0da9232ea175 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -203,6 +203,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages)
 {
+	int ret;
+
 	if (!dax_alive(dax_dev))
 		return -ENXIO;
 	/*
@@ -213,7 +215,8 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (nr_pages != 1)
 		return -EIO;
 
-	return dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
+	ret = dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
+	return dax_mem2blk_err(ret);
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
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
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index c09f2e053bf8..ee47ac520cd4 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -54,7 +54,8 @@ static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
 	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS,
 			&kaddr, NULL);
 	if (rc < 0)
-		return rc;
+		return dax_mem2blk_err(rc);
+
 	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
 	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
 	return 0;
diff --git a/fs/dax.c b/fs/dax.c
index 2ababb89918d..a26eb5abfdc0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1148,7 +1148,7 @@ static int dax_iomap_copy_around(loff_t pos, uint64_t length, size_t align_size,
 	if (!zero_edge) {
 		ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
 		if (ret)
-			return ret;
+			return dax_mem2blk_err(ret);
 	}
 
 	if (copy_all) {
@@ -1310,7 +1310,7 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 
 out_unlock:
 	dax_read_unlock(id);
-	return ret;
+	return dax_mem2blk_err(ret);
 }
 
 int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
@@ -1342,7 +1342,8 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
 	ret = dax_direct_access(iomap->dax_dev, pgoff, 1, DAX_ACCESS, &kaddr,
 				NULL);
 	if (ret < 0)
-		return ret;
+		return dax_mem2blk_err(ret);
+
 	memset(kaddr + offset, 0, size);
 	if (iomap->flags & IOMAP_F_SHARED)
 		ret = dax_iomap_copy_around(pos, size, PAGE_SIZE, srcmap,
@@ -1498,7 +1499,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				DAX_ACCESS, &kaddr, NULL);
-		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
+		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
 			map_len = dax_direct_access(dax_dev, pgoff,
 					PHYS_PFN(size), DAX_RECOVERY_WRITE,
 					&kaddr, NULL);
@@ -1506,7 +1507,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 				recovery = true;
 		}
 		if (map_len < 0) {
-			ret = map_len;
+			ret = dax_mem2blk_err(map_len);
 			break;
 		}
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c727..5f1be1da92ce 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -775,7 +775,8 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
 	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS, &kaddr,
 			       NULL);
 	if (rc < 0)
-		return rc;
+		return dax_mem2blk_err(rc);
+
 	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
 	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
 	return 0;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index bf6258472e49..a4e97acf60f5 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -261,6 +261,11 @@ static inline bool dax_mapping(struct address_space *mapping)
 	return mapping->host && IS_DAX(mapping->host);
 }
 
+static inline int dax_mem2blk_err(int err)
+{
+	return (err == -EHWPOISON) ? -EIO : err;
+}
+
 #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
 void hmem_register_resource(int target_nid, struct resource *r);
 #else
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..e4c974587659 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3217,6 +3217,8 @@ static inline vm_fault_t vmf_error(int err)
 {
 	if (err == -ENOMEM)
 		return VM_FAULT_OOM;
+	else if (err == -EHWPOISON)
+		return VM_FAULT_HWPOISON;
 	return VM_FAULT_SIGBUS;
 }
 
-- 
2.18.4

