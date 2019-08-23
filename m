Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C649B0B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 15:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390373AbfHWNYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 09:24:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732332AbfHWNYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:24:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NDMoi2113729;
        Fri, 23 Aug 2019 09:24:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujfdvv7b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 09:24:18 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7NDNNjU115808;
        Fri, 23 Aug 2019 09:24:17 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujfdvv7af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 09:24:17 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7NDLKas022452;
        Fri, 23 Aug 2019 13:24:16 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2uj2eyd8kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 13:24:16 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7NDOGuV43778486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 13:24:16 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0B7DAC062;
        Fri, 23 Aug 2019 13:24:15 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 969FBAC05E;
        Fri, 23 Aug 2019 13:24:12 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.53.214])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 23 Aug 2019 13:24:12 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, hch@infradead.org,
        chandanrlinux@gmail.com
Subject: [PATCH V5 1/7] buffer_head: Introduce BH_Read_Cb flag
Date:   Fri, 23 Aug 2019 18:55:36 +0530
Message-Id: <20190823132542.13434-2-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190823132542.13434-1-chandan@linux.ibm.com>
References: <20190823132542.13434-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230138
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

