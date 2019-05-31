Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4C31665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 23:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfEaVGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 17:06:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41574 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfEaVGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 17:06:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VL3bqp051634;
        Fri, 31 May 2019 21:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=xeSRW3D8U1fPvu73DjNMkhW51M5eX50iQzGLjyvUe8I=;
 b=Hp2/1r6K52gYO3LO7Vuk6P5VaR2wsMxJ8Kjq20/yiaiyHKCdKFR1RU4Em8IP4fqcW17d
 N5G/UfIBAtAkETwxqWvK3TP9Y/8DwLgBEU9SkV/b4pi0/BByowO4JQjX9vQung4f+Q6D
 L0iqnd2mPMjyIKsQeNlO0S7HFOzTF74hg8DR7uOZNuXXmzD3sfkHIsPVF1G5C55dM3rU
 xopWoQJyHRFEjQW1W9vZ3LanTKgsrfrLywEmbhElhvKSCY7ey6Jhu7ZPZ3awXhKWdbZu
 2esgw2euVJPfHE8xqv1A3+kRk3IjTOKKAI4gn7pNlPFFN8/W4Veui135n33pQ9MQIqLE ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2spxbqrnc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 21:06:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VL5SWY109080;
        Fri, 31 May 2019 21:06:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ss1fpvgs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 21:06:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4VL66Q4030638;
        Fri, 31 May 2019 21:06:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 14:06:06 -0700
Date:   Fri, 31 May 2019 14:06:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     fstests@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>,
        linux-nfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fengxiaoli0714@gmail.com
Subject: [PATCH] nfs: disable client side deduplication
Message-ID: <20190531210605.GA5381@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9274 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=778
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9274 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=813 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310128
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

The NFS protocol doesn't support deduplication, so turn it off again.

Fixes: ce96e888fe48e ("Fix nfs4.2 return -EINVAL when do dedupe operation")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/nfs/nfs4file.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index cf42a8b939e3..1915f24bba85 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -187,7 +187,11 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 	bool same_inode = false;
 	int ret;
 
-	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
+	/* NFS does not support deduplication. */
+	if (remap_flags & REMAP_FILE_DEDUP)
+		return -EOPNOTSUPP;
+
+	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
 	/* check alignment w.r.t. clone_blksize */
