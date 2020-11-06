Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D071E2A8E14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 05:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKFEKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 23:10:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39860 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFEKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:10:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A643uA5017936;
        Fri, 6 Nov 2020 04:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=pgvQYCLalddNOo+GLs4x1pKNzRl7IWtapQb1qld2a/Y=;
 b=g+hd3o9qVaxUEjXxcMhk296Japo7OTbVJEakencu2+5XxAsI09+cWEuUARdHcO9nTMns
 cU62wgCnhKBxE2YbL9nsnx3/skeLfPnQNfar0T7ZnpQgMaW4pp/AGbktJ9Vz+/3Iv57n
 GfGQbcDLR9M2iRZNmfirGD9QcApJmp1feEodZRAow+6fHUGGS5YZ55c2vBs4PsTjBt4x
 I6H+YI+1ofFxtR6bBlchhlPHPy9UE015V7ypG4XOkIlqv49TPyeIp83urgHLHVjKUFnn
 L2pQYvrmk6XtLmAGnPEQitd1foirz+cQqwzsdYat4azxLS/xa7L36rX5F7b9iROUgxyA Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34hhvcq61t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 04:10:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A645rK8121033;
        Fri, 6 Nov 2020 04:10:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34hvs1tnsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 04:10:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A64ANsf024488;
        Fri, 6 Nov 2020 04:10:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Nov 2020 20:10:22 -0800
Subject: [PATCH 0/2] vfs: remove lockdep fs freeze weirdness
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 05 Nov 2020 20:10:21 -0800
Message-ID: <160463582157.1669281.13010940328517200152.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060026
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

A long time ago, XFS got tangled up with lockdep because the last thing
it does during a fs freeze is use a transaction to flush the superblock
to disk.  Transactions require int(ernal) write freeze protection, which
implies a recursive grab of the intwrite lock and makes lockdep all sad.

This was "solved" in lockdep back in 2012 as commit 5accdf82ba25c by
adding a "convert XFS' blocking fsfreeze lock attempts into a trylock"
behavior in v6 of a patch[1] that Jan Kara sent to try to fix fs freeze
handling.  The behavior was not in the v5[0] patch, nor was there any
discussion for any of the v5 patches that would suggest why things
changed from v5 to v6.

Commit f4b554af9931 in 2015 created the current weird logic in
__sb_start_write, which converts recursive freeze lock grabs into
trylocks whose return values are ignored(!!!).  XFS solved the problem
by creating a variant of transactions (XFS_TRANS_NO_WRITECOUNT) that
don't grab intwrite freeze protection, thus making lockdep's solution
unnecessary.  The commit claims that Dave Chinner explained that the
trylock hack + comment could be removed, but the patch author never did
that, and lore doesn't seem to know where or when Dave actually said
that?

Now it's 2020, and still nobody removed this from __sb_start_write.
Worse yet, nowadays lock_is_held returns 1 if lockdep is built-in but
offline.  This causes attempts to grab the pagefaults freeze lock
synchronously to turn into unchecked trylocks!  Hilarity ensues if a
page fault races with fsfreeze and loses, which causes us to break the
locking model.

This finally came to a head in 5.10-rc1 because the new lockdep bugs
introduced during the merge window caused this maintainer to hit the
weird case where sb_start_pagefault can return without having taken the
freeze lock, leading to test failures and memory corruption.

Since this insanity is dangerous and hasn't been needed by xfs since the
late 2.6(???) days, kill it with fire.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=remove-freeze-weirdness-5.11
---
 fs/aio.c           |    2 +-
 fs/io_uring.c      |    3 +--
 fs/super.c         |   43 ++++++++++++-------------------------------
 include/linux/fs.h |   21 +++++++++++----------
 4 files changed, 25 insertions(+), 44 deletions(-)

