Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBC2625BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIIDO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 23:14:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgIIDO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:14:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08933O7V004243;
        Tue, 8 Sep 2020 23:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fPQ2hLtSSqn4qp3cZqEnFdUV2+VkBJNtU2UrwwB3KOY=;
 b=F8bvDBFSkNwtkMvAPa/Qae2yYGT4hMNgVpsgM8zb9pK6ap/XJEZH0ab9oKZ7cou2o2W2
 P2ubeX19DUoCdYwgCpfe0FihxDYIE6RBKqahVdSD6RUFjluhpMRrX08RkIdO0oS8Xka+
 qiFrnkiWMRo7icjjrOt295sVb5kaY/cyHhe3bXSwJM2b6auXFIaQbHcu+A5XeTt+qQLY
 cWmZWf7wGJJoy56weVEL0hkib15gPvO21qd90CUOdzJwd9E4NdUkHSR5yf7Y2HcrQAMD
 gmF07jIWrI4RTiU8GMjVsbidn/JxC6cXQHNEpOM3B3XVcN0+wYueo7p969fzN8O6vupm 9A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33eph2rrse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 23:14:48 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08939NiI019409;
        Wed, 9 Sep 2020 03:14:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 33c2a80cb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 03:14:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0893Ehgn32834012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 03:14:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37ED4A4051;
        Wed,  9 Sep 2020 03:14:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9612BA4040;
        Wed,  9 Sep 2020 03:14:41 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.46.123])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 03:14:41 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: [RESEND PATCH 1/1] block: Set same_page to false in __bio_try_merge_page if ret is false
Date:   Wed,  9 Sep 2020 08:44:25 +0530
Message-Id: <bfee107c7d1075cab6ec297afbd3ace68955b836.1599620898.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_02:2020-09-08,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=925 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090026
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we hit the UINT_MAX limit of bio->bi_iter.bi_size and so we are anyway
not merging this page in this bio, then it make sense to make same_page
also as false before returning.

Without this patch, we hit below WARNING in iomap.
This mostly happens with very large memory system and / or after tweaking
vm dirty threshold params to delay writeback of dirty data.

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

Fixes: cc90bc68422 ("block: fix "check bi_size overflow before merge"")
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
RESEND: added "fixes" tag

 block/bio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a7366c02c9b5..675ecd81047b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -877,8 +877,10 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len)
+			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+				*same_page = false;
 				return false;
+			}
 			bv->bv_len += len;
 			bio->bi_iter.bi_size += len;
 			return true;
-- 
2.25.4

