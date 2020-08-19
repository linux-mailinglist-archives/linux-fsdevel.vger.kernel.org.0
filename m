Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E248249A61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 12:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgHSK3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 06:29:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgHSK3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:29:00 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JA1a06146945;
        Wed, 19 Aug 2020 06:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vAVx19PN5evAuL1yft8QctVm3MEbjgVTzM0AEmd3lu8=;
 b=lRjpuSCp10DoMysfqOcmcU5aufeygLjPEgxdiJ8jV5YUS4CgcCkxwzVaSaLD/9UtEnnI
 VDpJ73Npda2qV4zp9hHT+04djr14hFHB42sM+CPXjCfPc77mOSMf7ueX6Xuj5EBr6ZTP
 YCoJhjDzDVdaNSgbfYnKc2JSjqDCPiU89jnjxWTf/5WKD6MiebeDLiBgSXXKbbm0qljL
 DK9gnm6nA8LHUxfSTUtGTYOUtQa18Xm6jY3W3+0HLPMj8M1yTkZWwdTetIEnz2Xh/Bp0
 MNmUhiz19X5EGHEvAgZzmtjGCg/MTf6xzWEqtHmikvYkSeLRDKkZxP1yAYXq7w0rDMpN pg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304ru5fny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 06:28:51 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JAPIms005141;
        Wed, 19 Aug 2020 10:28:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3304um1q59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 10:28:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07JASkkB21365094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 10:28:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0BBA42064;
        Wed, 19 Aug 2020 10:28:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0409242041;
        Wed, 19 Aug 2020 10:28:45 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.116.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Aug 2020 10:28:44 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        riteshh@linux.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Date:   Wed, 19 Aug 2020 15:58:41 +0530
Message-Id: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_04:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=708 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190082
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

__bio_try_merge_page() may return same_page = 1 and merged = 0. 
This could happen when bio->bi_iter.bi_size + len > UINT_MAX. 
Handle this case in iomap_add_to_ioend() by incrementing write_count.
This scenario mostly happens where we have too much dirty data accumulated. 

w/o the patch we hit below kernel warning,
 
 WARNING: CPU: 18 PID: 5130 at fs/iomap/buffered-io.c:74 iomap_page_release+0x120/0x150
 CPU: 18 PID: 5130 Comm: fio Kdump: loaded Tainted: G        W         5.8.0-rc3 #6
 Call Trace:
  __remove_mapping+0x154/0x320 (unreliable)
  iomap_releasepage+0x80/0x180
  try_to_release_page+0x94/0xe0
  invalidate_inode_page+0xc8/0x110
  invalidate_mapping_pages+0x1dc/0x540
  generic_fadvise+0x3c8/0x450
  xfs_file_fadvise+0x2c/0xe0 [xfs]
  vfs_fadvise+0x3c/0x60
  ksys_fadvise64_64+0x68/0xe0
  sys_fadvise64+0x28/0x40
  system_call_exception+0xf8/0x1c0
  system_call_common+0xf0/0x278

Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 fs/iomap/buffered-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..4e8062279e66 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1332,10 +1332,12 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 
 	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
 			&same_page);
-	if (iop && !same_page)
+	if (iop && merged && !same_page)
 		atomic_inc(&iop->write_count);
 
 	if (!merged) {
+		if (iop)
+			atomic_inc(&iop->write_count);
 		if (bio_full(wpc->ioend->io_bio, len)) {
 			wpc->ioend->io_bio =
 				iomap_chain_bio(wpc->ioend->io_bio);
-- 
2.25.4

