Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392419B0BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392620AbfHWNYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 09:24:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392194AbfHWNYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:24:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NDMmNI125094;
        Fri, 23 Aug 2019 09:24:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujg1j2s6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 09:24:30 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7NDN7vN126524;
        Fri, 23 Aug 2019 09:24:29 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujg1j2s68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 09:24:29 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7NDLKWJ031180;
        Fri, 23 Aug 2019 13:24:28 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 2ufye0qv2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 13:24:28 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7NDORhV50921800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 13:24:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2C8FAC060;
        Fri, 23 Aug 2019 13:24:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 767DCAC059;
        Fri, 23 Aug 2019 13:24:24 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.53.214])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 23 Aug 2019 13:24:24 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, hch@infradead.org,
        chandanrlinux@gmail.com
Subject: [PATCH V5 4/7] fs/buffer.c: add decryption support via read_callbacks
Date:   Fri, 23 Aug 2019 18:55:39 +0530
Message-Id: <20190823132542.13434-5-chandan@linux.ibm.com>
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

