Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597DA2AC376
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 19:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgKISQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 13:16:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54958 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKISQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:16:54 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9I9pZo120449;
        Mon, 9 Nov 2020 18:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=DrY95ZEYCvkKcuGJulq2EUOjlqD79ffG/X3fYNYMaBg=;
 b=OFiMZ2Y9J07gF3lRLQqZamXSP/vjxqCfPkecne9lBAlTY1m/q68vcoF309a5MTCe9EME
 mNpFXY+86XsaWXNIie8a5nlzq7IAjo/AGQfIlYlO1NZW1Dhd79H7vtBx0U6hJbrWO1UZ
 vHYlJrn4rWOGgFNOCNAAn6XOIKtoOnbnpqDZYYCa6pI/KLl2HUM3XHKSH98JO6Q+BQyx
 3N2P7Hoew7Lm+kN9bhtGcFyTewEQi3TEAaW/8eW8G8/aLbS9/zli+PKu0zoI8eTZQ/GP
 XJseGSGGLkfwPYjERmc8/A3SUEjJOXZm4DolHo71C/C5XT/CM6C8WEs8lw65y4BVmcJ3 bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3aqn4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 18:16:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9IB9Cq195309;
        Mon, 9 Nov 2020 18:16:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34p55m9mt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 18:16:46 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9IGjfr009811;
        Mon, 9 Nov 2020 18:16:45 GMT
Received: from localhost (/10.159.239.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 10:16:45 -0800
Subject: [PATCH v3 0/3] vfs: remove lockdep fs freeze weirdness
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, fdmanana@kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 09 Nov 2020 10:16:44 -0800
Message-ID: <160494580419.772573.9286165021627298770.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090126
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

v2: refactor helpers to be more cohesive
v3: move more cohesive helpers to header files

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
 fs/super.c         |   49 -------------------------------------------------
 include/linux/fs.h |   38 +++++++++++++++++++++++++++-----------
 4 files changed, 29 insertions(+), 63 deletions(-)

