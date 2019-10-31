Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2FB3EA98B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 04:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJaDaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 23:30:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJaDaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 23:30:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V3TCaR024791;
        Thu, 31 Oct 2019 03:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=XDUxscILsJ13tPTDg3J62ds2i/L80cksUFSZ1N7K4OQ=;
 b=MGKb6w0an2ZK4Jt9N4Zo6+jDTSUaP3qxwplSI55jx0Vs49EEqIAmJWu9JHJPqCoWNquf
 jepFpe3XcpLjMZ0GoEyGOq3ZPB2DQjpkfYiaGBAfj0l9Fa9ESFf71gYOt7gI6BFudbjt
 /42BV7CEJiT4HBD1QpM74/fiXbvmbmwFBhXbzlexHnHc43hqZ316n1Z2ZhadsN0UIGxZ
 toV3elyEcegfSM2Q1eUZp55vuPCcQUVq3PGqKxF+uJ6GMeK9PdlmCnDRql3QU+SwKeed
 9rJ7n/X9tnPxetRUpl08UlS2lseoP+psXwfjbeump163UyZ1Pv1xF6ar+bhfytNVX8ig IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vxwhfr77n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:29:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V3Nr20125950;
        Thu, 31 Oct 2019 03:29:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vykw0h5km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:29:50 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9V3TnFu021188;
        Thu, 31 Oct 2019 03:29:49 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 20:29:49 -0700
Date:   Wed, 30 Oct 2019 20:29:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH v4] loop: fix no-unmap write-zeroes request behavior
Message-ID: <20191031032948.GA15212@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310032
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Currently, if the loop device receives a WRITE_ZEROES request, it asks
the underlying filesystem to punch out the range.  This behavior is
correct if unmapping is allowed.  However, a NOUNMAP request means that
the caller doesn't want us to free the storage backing the range, so
punching out the range is incorrect behavior.

To satisfy a NOUNMAP | WRITE_ZEROES request, loop should ask the
underlying filesystem to FALLOC_FL_ZERO_RANGE, which is (according to
the fallocate documentation) required to ensure that the entire range is
backed by real storage, which suffices for our purposes.

Fixes: 19372e2769179dd ("loop: implement REQ_OP_WRITE_ZEROES")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v4: add review tags
v3: refactor into a single fallocate function
v2: reorganize a little according to hch feedback
---
 drivers/block/loop.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6f77eaa7217..ef6e251857c8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -417,18 +417,20 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 	return ret;
 }
 
-static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
+static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
+			int mode)
 {
 	/*
-	 * We use punch hole to reclaim the free space used by the
-	 * image a.k.a. discard. However we do not support discard if
-	 * encryption is enabled, because it may give an attacker
-	 * useful information.
+	 * We use fallocate to manipulate the space mappings used by the image
+	 * a.k.a. discard/zerorange. However we do not support this if
+	 * encryption is enabled, because it may give an attacker useful
+	 * information.
 	 */
 	struct file *file = lo->lo_backing_file;
-	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	int ret;
 
+	mode |= FALLOC_FL_KEEP_SIZE;
+
 	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
 		ret = -EOPNOTSUPP;
 		goto out;
@@ -596,9 +598,17 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	switch (req_op(rq)) {
 	case REQ_OP_FLUSH:
 		return lo_req_flush(lo, rq);
-	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
-		return lo_discard(lo, rq, pos);
+		/*
+		 * If the caller doesn't want deallocation, call zeroout to
+		 * write zeroes the range.  Otherwise, punch them out.
+		 */
+		return lo_fallocate(lo, rq, pos,
+			(rq->cmd_flags & REQ_NOUNMAP) ?
+				FALLOC_FL_ZERO_RANGE :
+				FALLOC_FL_PUNCH_HOLE);
+	case REQ_OP_DISCARD:
+		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
