Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA2D44F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfJKQF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 12:05:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45612 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfJKQF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:05:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BG4k5f134580;
        Fri, 11 Oct 2019 16:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=SSlpTZMvOaJILGFHqYWksiEw/n7lv08UA08VQdMxybc=;
 b=Kbi3oCzHTZmAynqziISo/szs+Jt0cKk20JrIJJN0k5EbZ5RZt7ZPwycVTfVZrMlMK94n
 1z/4qRB4LPMC+KCrK8/DGAzud1kOFscFxUbqzHaoh1gl9tmygg5+bz8gz4Q3UElmzEFd
 BI5DV//piaKowvZpQgZhGSpHI90r7AEUdGWoDasN7RZQmwO3h9fBU72X6WE2A/rE/1wN
 pEuphJimKyirbTTpZzhTSIL1NahxbOKQeWeMz4yKShsyq97e+ON8NKn73e633sTm2Qdt
 HqyFHKwwqbKhiuGjGi1auwdlN7O6T0gHB2u7QALLmgvCBDWh0lMaty7KH5XzxB4PRpJv qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejkv2q0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 16:05:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BG49eZ042306;
        Fri, 11 Oct 2019 16:05:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vj9qv6peh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 16:05:49 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9BG5lfB019222;
        Fri, 11 Oct 2019 16:05:47 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 09:05:46 -0700
Date:   Fri, 11 Oct 2019 09:05:45 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH v2] loop: fix no-unmap write-zeroes request behavior
Message-ID: <20191011160545.GD13098@magnolia>
References: <20191010170239.GC13098@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010170239.GC13098@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110145
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Currently, if the loop device receives a WRITE_ZEROES request, it asks
the underlying filesystem to punch out the range.  This behavior is
correct if unmapping is allowed.  However, a NOUNMAP request means that
the caller forbids us from freeing the storage backing the range, so
punching out the range is incorrect behavior.

To satisfy a NOUNMAP | WRITE_ZEROES request, loop should ask the
underlying filesystem to FALLOC_FL_ZERO_RANGE, which is (according to
the fallocate documentation) required to ensure that the entire range is
backed by real storage, which suffices for our purposes.

Fixes: 19372e2769179dd ("loop: implement REQ_OP_WRITE_ZEROES")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
v2: reorganize a little according to hch feedback
---
 drivers/block/loop.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6f77eaa7217..4943d0c5c61c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -441,6 +441,28 @@ static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
 	return ret;
 }
 
+static int lo_zeroout(struct loop_device *lo, struct request *rq, loff_t pos)
+{
+	struct file *file = lo->lo_backing_file;
+	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+	int ret;
+
+	/*
+	 * Ask the fs to zero out the blocks, which is supposed to result in
+	 * space being allocated to the file.
+	 */
+	if (!file->f_op->fallocate) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
+	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
+		ret = -EIO;
+ out:
+	return ret;
+}
+
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
 	struct file *file = lo->lo_backing_file;
@@ -596,8 +618,15 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	switch (req_op(rq)) {
 	case REQ_OP_FLUSH:
 		return lo_req_flush(lo, rq);
-	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+		/*
+		 * If the caller doesn't want deallocation, call zeroout to
+		 * write zeroes the range.  Otherwise, punch them out.
+		 */
+		if (rq->cmd_flags & REQ_NOUNMAP)
+			return lo_zeroout(lo, rq, pos);
+		/* fall through */
+	case REQ_OP_DISCARD:
 		return lo_discard(lo, rq, pos);
 	case REQ_OP_WRITE:
 		if (lo->transfer)
