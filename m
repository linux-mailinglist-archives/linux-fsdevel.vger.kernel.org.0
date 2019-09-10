Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF14BAEEE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 17:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfIJPt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 11:49:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbfIJPtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:49:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8AFlhmP095873;
        Tue, 10 Sep 2019 11:49:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxe2b9vvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 11:49:43 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8AFmn9m106442;
        Tue, 10 Sep 2019 11:49:42 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxe2b9vv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 11:49:42 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8AFjOrQ009923;
        Tue, 10 Sep 2019 15:49:41 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2uv4672waf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 15:49:41 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8AFneaW53084670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 15:49:40 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70313112065;
        Tue, 10 Sep 2019 15:49:40 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61AEB112062;
        Tue, 10 Sep 2019 15:49:37 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.1.89])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 15:49:37 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, hch@infradead.org,
        chandanrlinux@gmail.com
Subject: [PATCH RESEND V5 1/7] buffer_head: Introduce BH_Read_Cb flag
Date:   Tue, 10 Sep 2019 21:21:09 +0530
Message-Id: <20190910155115.28550-2-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190910155115.28550-1-chandan@linux.ibm.com>
References: <20190910155115.28550-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100149
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Decryption of file content encrypted using fscrypt relies on
bio->bi_private holding a pointer to an encryption context
i.e. Decryption operation is not performed for bios having a NULL value
at bio->bi_private.

The same logic cannot be used on buffer heads because,
1. In Btrfs, write_dev_supers() sets bh->b_private to 'struct
   btrfs_device' pointer and submits the buffer head for a write
   operation.
   1. In btrfs/146 test, the write operation fails and hence the
      endio function clears the BH_Uptodate flag.
   2. A read operation initiated later will submit the buffer head to
      the block layer. During endio processing, bh_>b_private would have a
      non-NULL value.

2. Another instance is when an Ext4 metadata block with BH_Uptodate set and
   also part of the in-memory JBD list undergoes the following,
   1. A sync() syscall is invoked by the userspace and the write
      operation on the metadata block is initiated.
   2. Due to an I/O failure, the BH_Uptodate flag is cleared by
      end_buffer_async_write(). The bh->b_private member would be
      pointing to a journal head structure.
   3. In such a case, a read operation invoked on the block mapped by the
      buffer head will initiate a read from the disk since the buffer head is
      missing the BH_Uptodate flag.
   4. After the read I/O request is submitted, end_buffer_async_read()
      will find a non-NULL value at bh->b_private.
   This scenario was observed when executing generic/475 test case.

Hence this commit introduces a new buffer head flag to reliably check for
decryption of a buffer head's contents after the block has been read
from the disk.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 include/linux/buffer_head.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7b73ef7f902d..08f217ba8114 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -38,6 +38,7 @@ enum bh_state_bits {
 	BH_Meta,	/* Buffer contains metadata */
 	BH_Prio,	/* Buffer should be submitted with REQ_PRIO */
 	BH_Defer_Completion, /* Defer AIO completion to workqueue */
+	BH_Read_Cb,	     /* Block's contents needs to be decrypted */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -134,6 +135,7 @@ BUFFER_FNS(Unwritten, unwritten)
 BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
+BUFFER_FNS(Read_Cb, read_cb)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
-- 
2.19.1

