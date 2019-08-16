Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869E38FAC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 08:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfHPGR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 02:17:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726591AbfHPGR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:17:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G64EuM000639;
        Fri, 16 Aug 2019 02:17:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udpw78cu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 02:17:03 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7G65cLF004717;
        Fri, 16 Aug 2019 02:17:03 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udpw78cp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 02:17:03 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7G6Grhn028813;
        Fri, 16 Aug 2019 06:16:53 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 2udbc48mq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 06:16:53 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7G6GqhD49152356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 06:16:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F61A112061;
        Fri, 16 Aug 2019 06:16:52 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90FC9112064;
        Fri, 16 Aug 2019 06:16:49 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.23])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 06:16:49 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, chandanrmail@gmail.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, ebiggers@kernel.org,
        jaegeuk@kernel.org, yuchao0@huawei.com, hch@infradead.org
Subject: [PATCH V4 4/8] fs/buffer.c: add decryption support via read_callbacks
Date:   Fri, 16 Aug 2019 11:48:00 +0530
Message-Id: <20190816061804.14840-5-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190816061804.14840-1-chandan@linux.ibm.com>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160066
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit sets up read_callbacks context for buffer heads whose
contents need to be decrypted on endio.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/buffer.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ce357602f471..96c4c9840746 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -45,6 +45,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/pagevec.h>
 #include <linux/sched/mm.h>
+#include <linux/read_callbacks.h>
 #include <trace/events/block.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
@@ -245,11 +246,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	return ret;
 }
 
-/*
- * I/O completion handler for block_read_full_page() - pages
- * which come unlocked at the end of I/O.
- */
-static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
+void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
 	unsigned long flags;
 	struct buffer_head *first;
@@ -257,8 +254,6 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	struct page *page;
 	int page_uptodate = 1;
 
-	BUG_ON(!buffer_async_read(bh));
-
 	page = bh->b_page;
 	if (uptodate) {
 		set_buffer_uptodate(bh);
@@ -306,6 +301,17 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	return;
 }
 
+/*
+ * I/O completion handler for block_read_full_page().  Pages are unlocked
+ * after the I/O completes and the read callbacks (if any) have executed.
+ */
+static void __end_buffer_async_read(struct buffer_head *bh, int uptodate)
+{
+	BUG_ON(!buffer_async_read(bh));
+
+	read_callbacks_endio_bh(bh, uptodate, end_buffer_async_read);
+}
+
 /*
  * Completion handler for block_write_full_page() - pages which are unlocked
  * during I/O, and which have PageWriteback cleared upon I/O completion.
@@ -378,7 +384,7 @@ EXPORT_SYMBOL(end_buffer_async_write);
  */
 static void mark_buffer_async_read(struct buffer_head *bh)
 {
-	bh->b_end_io = end_buffer_async_read;
+	bh->b_end_io = __end_buffer_async_read;
 	set_buffer_async_read(bh);
 }
 
@@ -2293,10 +2299,15 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 	 */
 	for (i = 0; i < nr; i++) {
 		bh = arr[i];
-		if (buffer_uptodate(bh))
-			end_buffer_async_read(bh, 1);
-		else
+		if (buffer_uptodate(bh)) {
+			__end_buffer_async_read(bh, 1);
+		} else {
+			if (WARN_ON(read_callbacks_setup_bh(inode, bh))) {
+				__end_buffer_async_read(bh, 0);
+				continue;
+			}
 			submit_bh(REQ_OP_READ, 0, bh);
+		}
 	}
 	return 0;
 }
-- 
2.19.1

