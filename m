Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1D1D4D71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEOMJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 08:09:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOMJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 08:09:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FC7fpX171402;
        Fri, 15 May 2020 12:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=YG59WWrOXkSM7KZ6vsbZULXPJjele+2syPNjd4BAXlI=;
 b=MjDpntIKqRLcyBuGq5sqsI8NVaNV/jHLyhmoWgjnD87rhy6J3HBj79y5syxCQSPDZJ/K
 ++2LOSemBVGRRyu4EplnqNuhMTUxIAlgbBSGicEcxpRjMW+8rd+kULrWVM+HDqWhzAg8
 VpyEQFX+58dUmKmW4Xt75HNTu5ZIFf7JjB1Ov+z1pbn+xVuvs39KU/uWl6m7qA9lHHc4
 XQgws7xPqKfRVH+WGKLjX5zNHKI/lR0gdVRr44bFyPMj+OUOmvDYpmt9KpsS96fWVnYa
 zudUeS3eeyQ27Zlj1r/PCaFc2oST+DhLlVAitgS3h7hSjZHGF465+ml78cccUd7V7BPf 0A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3100xwtja9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 12:09:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FC8m2i102907;
        Fri, 15 May 2020 12:09:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3100yrfbhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 12:09:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04FC9EJM002764;
        Fri, 15 May 2020 12:09:14 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 May 2020 05:09:13 -0700
Date:   Fri, 15 May 2020 15:09:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fsinfo: Fix uninitialized variable in
 fsinfo_generic_mount_all()
Message-ID: <20200515120908.GB575846@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005150105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150105
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The "conn" variable is never set to false.

Fixes: f2494de388bd ("fsinfo: Add an attribute that lists all the visible mounts in a namespace")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The buggy commit looks like preliminary stuff not pushed to anywhere so
probably this can just be folded in.

 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3fd24575756b..ae489cbac467 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4433,7 +4433,7 @@ int fsinfo_generic_mount_all(struct path *path, struct fsinfo_context *ctx)
 	struct mnt_namespace *ns;
 	struct mount *m, *p;
 	struct path chroot;
-	bool conn;
+	bool conn = false;
 
 	m = real_mount(path->mnt);
 	ns = m->mnt_ns;
-- 
2.26.2

