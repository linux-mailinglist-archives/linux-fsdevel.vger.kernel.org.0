Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC62E8263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Dec 2020 23:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgLaWrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Dec 2020 17:47:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56728 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgLaWrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Dec 2020 17:47:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BVMkYAn155738;
        Thu, 31 Dec 2020 22:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JZ8Z+sm8Eudng8cVlf0zvfSiZVA50AxrbzPmNsHsRPE=;
 b=aXPkwbatFpAWxsTIYnvP4xi/OLiVsH+8smRt1f0fAxQn1bGU14hCgAKhTxbz7tdzQfr0
 21PPdrkqRULZEfht9mSB6AmQGm2BIBVelKa49HTRQASGy8EJFckHNZjh6lSOMEUbK27y
 U7flZMQfx+LnmDnx6U6O5gdeigXfEPANPchG96fbe1FnhVjteTrMw3a2F2lMDFPAJ4Jt
 W+EqpDikdtes6rgYOYZFbIXgyOoF+YC8kTjR0mphOE05gYBR/X4AN2Wf0xpS2SM5ocrS
 X8S797qfKvMA6CBr1cM32PDa4b25OHM2YJRd0u0qYjmoYPtjHUZACZEpowGsEqLrDuJ9 +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35rk3bv3q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Dec 2020 22:46:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BVMeUWf083414;
        Thu, 31 Dec 2020 22:44:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35pf307m0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Dec 2020 22:44:33 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BVMiXNY024956;
        Thu, 31 Dec 2020 22:44:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Dec 2020 14:44:33 -0800
Subject: [PATCHSET RFC v2 00/17] xfs: atomic file updates
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Thu, 31 Dec 2020 14:44:32 -0800
Message-ID: <160945467182.2830865.6578267403605057347.stgit@magnolia>
In-Reply-To: <20201231223847.GI6918@magnolia>
References: <20201231223847.GI6918@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9851 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012310134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9851 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012310135
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series creates a new log incompat feature and log intent items to
track high level progress of swapping ranges of two files and finish
interrupted work if the system goes down.  It then adds a new
FISWAPRANGE ioctl so that userspace can access the atomic extent
swapping feature.  With this feature, user programs will be able to
update files atomically by opening an O_TMPFILE, reflinking the source
file to it, making whatever updates they want to make, and then
atomically swap the changed bits back to the source file.  It even has
an optional ability to detect a changed source file and reject the
update.

The intent behind this new userspace functionality is to enable atomic
rewrites of arbitrary parts of individual files.  For years, application
programmers wanting to ensure the atomicity of a file update had to
write the changes to a new file in the same directory, fsync the new
file, rename the new file on top of the old filename, and then fsync the
directory.  People get it wrong all the time, and $fs hacks abound.

With atomic file updates, this is no longer necessary.  Programmers
create an O_TMPFILE, optionally FICLONE the file contents into the
temporary file, make whatever changes they want to the tempfile, and
FISWAPRANGE the contents from the tempfile into the regular file.  The
interface can optionally check the original file's [cm]time to reject
the swap operation if the file has been modified by.  There are no
fsyncs to take care of; no directory operations at all; and the fs will
take care of finishing the swap operation if the system goes down in the
middle of the swap.  Sample code can be found in the corresponding
changes to xfs_io to exercise the use case mentioned above.

Note that this function is /not/ the O_DIRECT atomic file writes concept
that has been floating around for years.  This is constructed entirely
in software, which means that there are no limitations other than the
regular filesystem limits.

As a side note, there's an extra motivation behind the kernel
functionality: online repair of file-based metadata.  The atomic file
swap is implemented as an atomic inode fork swap, which means that we
can implement online reconstruction of extended attributes and
directories by building a new one in another inode and atomically
swap the contents.

Next, we adapt the online filesystem repair code to use atomic extent
swapping.  This enables repair functions to construct a clean copy of a
directory, xattr information, realtime bitmaps, and realtime summary
information in a temporary inode.  If this completes successfully, the
new contents can be swapped atomically into the inode being repaired.
This is essential to avoid making corruption problems worse if the
system goes down in the middle of running repair.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=atomic-file-updates

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=atomic-file-updates

xfsdocs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-documentation.git/log/?h=atomic-file-updates
---
 Documentation/filesystems/vfs.rst |   16 +
 fs/ioctl.c                        |   42 ++
 fs/remap_range.c                  |  283 +++++++++++++
 fs/xfs/Makefile                   |    3 
 fs/xfs/libxfs/xfs_defer.c         |   49 ++
 fs/xfs/libxfs/xfs_defer.h         |   11 -
 fs/xfs/libxfs/xfs_errortag.h      |    4 
 fs/xfs/libxfs/xfs_format.h        |   38 ++
 fs/xfs/libxfs/xfs_fs.h            |    2 
 fs/xfs/libxfs/xfs_log_format.h    |   63 +++
 fs/xfs/libxfs/xfs_log_recover.h   |    4 
 fs/xfs/libxfs/xfs_sb.c            |    2 
 fs/xfs/libxfs/xfs_swapext.c       |  793 +++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_swapext.h       |   89 ++++
 fs/xfs/xfs_bmap_item.c            |   13 -
 fs/xfs/xfs_bmap_util.c            |  595 ----------------------------
 fs/xfs/xfs_bmap_util.h            |    3 
 fs/xfs/xfs_error.c                |    3 
 fs/xfs/xfs_extfree_item.c         |    2 
 fs/xfs/xfs_file.c                 |   49 ++
 fs/xfs/xfs_inode.c                |   13 +
 fs/xfs/xfs_inode.h                |    1 
 fs/xfs/xfs_ioctl.c                |  102 +----
 fs/xfs/xfs_ioctl.h                |    4 
 fs/xfs/xfs_ioctl32.c              |    8 
 fs/xfs/xfs_log.c                  |   10 
 fs/xfs/xfs_log_recover.c          |   41 ++
 fs/xfs/xfs_mount.c                |  119 ++++++
 fs/xfs/xfs_mount.h                |    2 
 fs/xfs/xfs_refcount_item.c        |    2 
 fs/xfs/xfs_rmap_item.c            |    2 
 fs/xfs/xfs_super.c                |   26 +
 fs/xfs/xfs_swapext_item.c         |  649 ++++++++++++++++++++++++++++++
 fs/xfs/xfs_swapext_item.h         |   61 +++
 fs/xfs/xfs_trace.c                |    1 
 fs/xfs/xfs_trace.h                |  116 +++++
 fs/xfs/xfs_xchgrange.c            |  721 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_xchgrange.h            |   30 +
 include/linux/fs.h                |   14 +
 include/uapi/linux/fiexchange.h   |  101 +++++
 40 files changed, 3363 insertions(+), 724 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_swapext.c
 create mode 100644 fs/xfs/libxfs/xfs_swapext.h
 create mode 100644 fs/xfs/xfs_swapext_item.c
 create mode 100644 fs/xfs/xfs_swapext_item.h
 create mode 100644 fs/xfs/xfs_xchgrange.c
 create mode 100644 fs/xfs/xfs_xchgrange.h
 create mode 100644 include/uapi/linux/fiexchange.h

