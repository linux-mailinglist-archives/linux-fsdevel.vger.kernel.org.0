Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19F28E97D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 02:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgJOAbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 20:31:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55984 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgJOAbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 20:31:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F0VIn2057469;
        Thu, 15 Oct 2020 00:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Y8qiMhy/TtMb2QqybxDtEswQihoXnMGkdNPr8ht3+QI=;
 b=c5JKROgL5I9Uys/T0AKfNyjlPFIob2PLlL42IJ931DvFIJ5uJl0JrDSW/RztEm5LotNT
 dnjzKXRmqM8oWvf/ztAWG5YE1NQOtZdv1nMjicovdD5e5X4TvsOvN+4PAdExAjnzlatb
 MleMyS7Of4leuhdXljneGoYwH88kMLuT4GqUpZQiaW2gTKxPdXWw++LWr0qptGrJJmhR
 sfdBSxVgtpTh6F7d6tGsr14BHCCYBeiWzMQwYpVhbEAnUcORCsKSKC3B9oQVHTBMih9I
 +gVyNUjrD/4GH5uusHjWJUEuowb4gKXdbGTQA3ZTW/vc0Hf5JBJil1cD+ZD99H7j0mpD WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 343vaegmrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 00:31:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F0TiwR123312;
        Thu, 15 Oct 2020 00:31:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 343phqb09a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 00:31:17 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09F0VGQU017266;
        Thu, 15 Oct 2020 00:31:16 GMT
Received: from localhost (/10.159.142.84)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 17:31:16 -0700
Subject: [PATCH 0/2] vfs: move the clone/dedupe/remap helpers to a single file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 14 Oct 2020 17:31:14 -0700
Message-ID: <160272187483.913987.4254237066433242737.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I would like to move the generic helper functions that support the file
remap range operations (aka clone and dedupe) to a separate file under
fs/.  For the moment, I have a few goals here: one is to declutter
fs/read_write.c and mm/filemap.c.  The second goal is to be able to
deselect all the remap code if no filesystems require it.

The third (and much more long term) goal is to have a place to land the
generic code for the atomic file extent swap functionality, since it
will reuse some of the functionality.  Someday.  Whenever I get around
to submitting that again.

AFAICT, nobody is attempting to land any major changes in any of the vfs
remap functions during the 5.10 window -- for-next showed conflicts only
in the Makefile, so it seems like a quiet enough time to do this.  There
are no functional changes here, it's just moving code blocks around.

So, I have a few questions, particularly for Al, Andrew, and Linus:

(1) Do you find this reorganizing acceptable?

(2) I was planning to rebase this series next Friday and try to throw it
in at the end of the merge window; is that ok?  (The current patches are
based on 5.9, and applying them manually to current master and for-next
didn't show any new conflicts.)

(3) Can I just grab the copyrights from mm/filemap.c?  Or fs/read_write.c?
Or something entirely different?

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=vfs-rearrange-remap-helpers
---
 fs/Makefile        |    3 
 fs/read_write.c    |  473 -------------------------------------------
 fs/remap_range.c   |  577 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    5 
 mm/filemap.c       |   81 -------
 5 files changed, 582 insertions(+), 557 deletions(-)
 create mode 100644 fs/remap_range.c

