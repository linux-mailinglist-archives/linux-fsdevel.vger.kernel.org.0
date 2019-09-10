Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB611AEEEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394003AbfIJPt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 11:49:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727024AbfIJPt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:49:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8AFlg4n081823;
        Tue, 10 Sep 2019 11:49:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uxduk2ar6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 11:49:50 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8AFlu4i083490;
        Tue, 10 Sep 2019 11:49:50 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uxduk2aqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 11:49:50 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8AFjNUO011679;
        Tue, 10 Sep 2019 15:49:49 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 2uv467aw1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 15:49:49 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8AFnmfi20709780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 15:49:48 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 539DF112067;
        Tue, 10 Sep 2019 15:49:48 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F117112062;
        Tue, 10 Sep 2019 15:49:45 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.1.89])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 15:49:44 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, hch@infradead.org,
        chandanrlinux@gmail.com
Subject: [PATCH RESEND V5 3/7] fs/mpage.c: Integrate read callbacks
Date:   Tue, 10 Sep 2019 21:21:11 +0530
Message-Id: <20190910155115.28550-4-chandan@linux.ibm.com>
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

This commit adds code to make do_mpage_readpage() to be "read callbacks"
aware i.e. for files requiring decryption, do_mpage_readpage() now
sets up the read callbacks state machine when allocating a bio and later
starts execution of the state machine after file data is read from the
underlying disk.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/mpage.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 3f19da75178b..65e7165644e2 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -30,6 +30,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/cleancache.h>
+#include <linux/read_callbacks.h>
 #include "internal.h"
 
 /*
@@ -44,7 +45,7 @@
  * status of that page is hard.  See end_buffer_async_read() for the details.
  * There is no point in duplicating all that complexity.
  */
-static void mpage_end_io(struct bio *bio)
+static void end_bio(struct bio *bio)
 {
 	struct bio_vec *bv;
 	int i;
@@ -52,13 +53,24 @@ static void mpage_end_io(struct bio *bio)
 
 	bio_for_each_segment_all(bv, bio, i, iter_all) {
 		struct page *page = bv->bv_page;
-		page_endio(page, bio_op(bio),
-			   blk_status_to_errno(bio->bi_status));
+		int err;
+
+		err = blk_status_to_errno(bio->bi_status);
+
+		if (!err && read_callbacks_failed(page))
+			err = -EIO;
+
+		page_endio(page, bio_op(bio), err);
 	}
 
 	bio_put(bio);
 }
 
+static void mpage_end_io(struct bio *bio)
+{
+	read_callbacks_endio_bio(bio, end_bio);
+}
+
 static struct bio *mpage_bio_submit(int op, int op_flags, struct bio *bio)
 {
 	bio->bi_end_io = mpage_end_io;
@@ -310,6 +322,12 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 					gfp);
 		if (args->bio == NULL)
 			goto confused;
+
+		if (read_callbacks_setup_bio(inode, args->bio)) {
+			bio_put(args->bio);
+			args->bio = NULL;
+			goto confused;
+		}
 	}
 
 	length = first_hole << blkbits;
-- 
2.19.1

