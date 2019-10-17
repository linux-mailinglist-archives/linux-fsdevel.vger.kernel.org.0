Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729D1DB8C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 23:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394663AbfJQVDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 17:03:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46972 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJQVDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:03:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HKx5bl109889;
        Thu, 17 Oct 2019 21:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=sbk3uYASgfGn6mC7GO0Qtd9YHQRLQETkDSIDaMi8VX0=;
 b=j0x+9iUBo58N51IG9fdmDVbpWwXs4wLqy/5vTJ1GZUnyTYdfEBo55UtlO0qENpI1qSpL
 NzmKo5GzhsF9dOMgtH0yX3TQbgJ1vsRM3h44V7MokZ4e6VUQLk0chP9GJqU7bxYH72N+
 zu2//JLhzCOhXwF/rIcb7ahthO7bcfHlgsCqxAkImiugk7vwD71kppA05xqxWULTFRkv
 Pu6QvDzEbg7dLNBSakLYpGgzHoj5EkudepGwbOXjC1gSOo4XByddZ2nWYFrl4ysY3Ikh
 Z49vJhnsHQ2KF4zTX49JNLmu6gzYHe4ydd7iWxcijZju1cIseRgBqvxWaLbxyoNIiHMQ sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68v10w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 21:03:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HKwDgS048486;
        Thu, 17 Oct 2019 21:01:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vpvtmbh42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 21:01:13 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HL1COR017977;
        Thu, 17 Oct 2019 21:01:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 21:01:12 +0000
Date:   Thu, 17 Oct 2019 14:01:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: enhance writeback error message
Message-ID: <20191017210110.GP13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170187
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

If we encounter an IO error during writeback, log the inode, offset, and
sector number of the failure, instead of forcing the user to do some
sort of reverse mapping to figure out which file is affected.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0fd58adcdeaa..55d7efa4fb8c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1162,8 +1162,9 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 	if (unlikely(error && !quiet)) {
 		printk_ratelimited(KERN_ERR
-			"%s: writeback error on sector %llu",
-			inode->i_sb->s_id, start);
+"%s: writeback error on inode %lu, offset %lld, sector %llu",
+			inode->i_sb->s_id, inode->i_ino, ioend->io_offset,
+			start);
 	}
 }
 
