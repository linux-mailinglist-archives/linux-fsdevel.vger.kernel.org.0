Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA13074A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 12:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhA1LWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 06:22:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43882 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhA1LV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:21:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SBIhWQ103838;
        Thu, 28 Jan 2021 11:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5XnYtNjfLwCxDEEu1MyK0MKlb4ykYdFBX2bnmXug3e8=;
 b=p9pz/qqDE76LblRc+JtVZiOBwy9sStLJ5e+XTaM2UIrwiDVoUlhb66E8Lvgpt+CLpoDg
 a8NxY4gvUxSNi3GNV+Dy3cIFOUPkhjOFU5dIFh1Uj2hKeqz52tvwpaTDPOq7lSZg66zD
 afTLidhzXu6/Z8xn4Lc/07YdrXiusQ7ZkJjwk0foWJ6pzupt/rfvrJ/jtleF7UFzsAF0
 UZZ3m4VFu9vEAz32PqQ8lfckw5FHoOe0/nWXDau61WpyIX4MnIacpWBrP7blHP62P1Lq
 kEnL6uh1XWzHngMbhQwnikVFxbaefLJSQgbGOEamrae0FEqLYjHb2k5OACzcDNAKP6uV yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 368brkujx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 11:21:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SBLCtJ001840;
        Thu, 28 Jan 2021 11:21:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 368wcqjmsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 11:21:13 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10SBL8aS009894;
        Thu, 28 Jan 2021 11:21:08 GMT
Received: from mwanda (/10.175.203.176)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jan 2021 03:21:07 -0800
Date:   Thu, 28 Jan 2021 14:21:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, lkp@intel.com, kbuild@lists.01.org
Subject: [bug report] attr: handle idmapped mounts
Message-ID: <YBKeHne9FZ42mich@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=800 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280057
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=742
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280057
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christian Brauner,

The patch 2f221d6f7b88: "attr: handle idmapped mounts" from Jan 21,
2021, leads to the following static checker warning:

	fs/attr.c:129 setattr_prepare()
	warn: inconsistent indenting

fs/attr.c
   124		/* Make sure a caller can chmod. */
   125		if (ia_valid & ATTR_MODE) {
   126			if (!inode_owner_or_capable(mnt_userns, inode))
   127				return -EPERM;
   128			/* Also check the setgid bit! */
   129	               if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
      ^^^^^^^^^^^^^^^^^
The patch accidentally swapped tabs for spaces.

The kbuild-bot is supposed to warn about these, but I searched on the
lore.kernel.org thread and didn't see a warning.
https://lore.kernel.org/containers/20210121131959.646623-8-christian.brauner@ubuntu.com/
Presumably it is coming soon.

   130	                                i_gid_into_mnt(mnt_userns, inode)) &&
   131	                    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
   132				attr->ia_mode &= ~S_ISGID;
   133		}

regards,
dan carpenter
