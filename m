Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120BB24DF22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHUSLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 14:11:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbgHUSLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:11:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LI1dKk193635;
        Fri, 21 Aug 2020 14:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8yvEI0g2E8xG0SJMCtpKCuoNmNMpLdEw9u+yzYkMfTk=;
 b=VIJtt3CGuTG5sUiykNJVYhLxmszHb9Wdm6J2EYpLcqgQckwJbpZSCOXpbpZTT7qfDYek
 khVO23HbKGkVeXfY7yvjblSsk5ons8MFYnUE+xfiKmPxrpQy2O1Uzm3t5KljAQGAS3Bi
 JVDBAhSLcbgn8Q/8zPHOpshUdkZ+z1NKbejUMvQAwJmfqD5Cb+GA0p96cn0q/15zvROB
 kz1jz3TOeBsOPq4XU9WgyJQDHOHnllQQ5W6D/cbf6KeGIc+tarqDXE2nurzt4C1Xegzr
 zNxTx2jCdFLnGYmixgTjm89ER17TSvq+cH5qFnlKiQjfTRrfDAjs6hfREYhPvOx3uYJk 1Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3327xucbrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 14:11:31 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07LIB7c5003354;
        Fri, 21 Aug 2020 18:11:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3304bujubn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 18:11:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07LI9ucF56230152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 18:09:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 767124C044;
        Fri, 21 Aug 2020 18:11:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C639E4C04A;
        Fri, 21 Aug 2020 18:11:23 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 18:11:23 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: [PATCH 1/1] block: Set same_page to false in __bio_try_merge_page if ret is false
Date:   Fri, 21 Aug 2020 23:41:17 +0530
Message-Id: <e50582833c897c1a51a676d7726d1380a3e5a678.1598032711.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=981 lowpriorityscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210166
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

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
[prev discussion]:- https://patchwork.kernel.org/patch/11723453/

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

