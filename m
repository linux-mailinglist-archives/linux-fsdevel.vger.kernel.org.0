Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A233F25AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 03:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfKGC7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 21:59:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41656 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfKGC7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:59:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA72x6UZ049384;
        Thu, 7 Nov 2019 02:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=Izj90tLsaov/YorCLiqVxfHSCf1b5ZXNjF9FQRUQE9U=;
 b=ATYvOgcq0SmnbQ3xGkfR5tv1YLfbWBcUlc3KG5VBl19pFB0POhGQYKgMH2Zswed9nLnY
 zP4l0dgqHJ2qCSh/bw4Ee8cW8yjfE9gSaeGQbjhncRXVD7I1ECiYro50XE3/35u6yz3t
 MxZI7wHn7WgpMxA84cSTYO6VyouMXxOuYcvS+yEyOEg4o+cw2Z52lZzOE5EPsCOZcDp3
 dS4iPZUjYldRHa03clJzrGYb9JoD5eHpZsi9BFMgXSQ/k8fPq2Mu47NVeqW7ztq26Xme
 H8PrC9neS5dXb6k7/w7Ev7xNQK6iKrvohTYDV38F6IIRXXDAwGpR66l4dejV/AFqJPBD 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w41w13014-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 02:59:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA72wJB8052085;
        Thu, 7 Nov 2019 02:59:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w41wfs6ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 02:59:30 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA72xS7K026492;
        Thu, 7 Nov 2019 02:59:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 18:59:28 -0800
Date:   Wed, 6 Nov 2019 18:59:27 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: iomap_bmap should check iomap_apply return value
Message-ID: <20191107025927.GA6219@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070031
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Check the return value of iomap_apply and return 0 (i.e. error) if it
didn't succeed.

Coverity-id: 1437065
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/fiemap.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 690ef2d7c6c8..bccf305ea9ce 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -133,12 +133,16 @@ iomap_bmap(struct address_space *mapping, sector_t bno,
 	struct inode *inode = mapping->host;
 	loff_t pos = bno << inode->i_blkbits;
 	unsigned blocksize = i_blocksize(inode);
+	int ret;
 
 	if (filemap_write_and_wait(mapping))
 		return 0;
 
 	bno = 0;
-	iomap_apply(inode, pos, blocksize, 0, ops, &bno, iomap_bmap_actor);
+	ret = iomap_apply(inode, pos, blocksize, 0, ops, &bno,
+			  iomap_bmap_actor);
+	if (ret)
+		return 0;
 	return bno;
 }
 EXPORT_SYMBOL_GPL(iomap_bmap);
