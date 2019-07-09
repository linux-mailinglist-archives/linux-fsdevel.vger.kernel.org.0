Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83A6398A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfGIQj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 12:39:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44810 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIQj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:39:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69GdE6s161171;
        Tue, 9 Jul 2019 16:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=mWNNIxC852F1T0hY0S7in0tupX7SXeFAcfZFVC9JuHc=;
 b=e9bxnDLdWmEv4iyK7fRYTvsxKk8R/ME6bb5u6O7S9N7U6vXWCvcixpyJ3dnWdGbOgJYO
 QNpskiCWabU4aof3LdgDKZ0Oh4+s+xDlD4mwN31VCpUwYEbrUaatMrojVAYXHJnrmKJx
 Jq+45JPmTksPZyrFDyp1WMg4J8PQdGwWWFuZNMdYffe5G8HgnNJl5EZMBAs03fsf3/Dy
 GtEHDqeRkB64/yVPawheMP7ZJfc8WmejyT7ZVQC6UFw+ZOAvF4NgA0gLmPUzYeHs6iHn
 3poPhq/2k4/oHDMM767sIDMhiZeZXVO+QN+c/UKLu+tL77SovjP4B8GrDNvdwIPGM6I3 Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tjkkpnfhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 16:39:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69GcNrl128049;
        Tue, 9 Jul 2019 16:39:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tjjykwjr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 16:39:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x69GdnRm028412;
        Tue, 9 Jul 2019 16:39:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jul 2019 09:39:49 -0700
Date:   Tue, 9 Jul 2019 09:39:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: [GIT PULL] vfs: fix copy_file_range bad behavior
Message-ID: <20190709163947.GE5164@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090195
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this series to fix numerous parameter checking problems and
inconsistent behaviors in the new(ish) copy_file_range system call.  Now
the system call will actually check its range parameters correctly;
refuse to copy into files for which the caller does not have sufficient
privileges; update mtime and strip setuid like file writes are supposed
to do; and allows copying up to the EOF of the source file instead of
failing the call like we used to.

The branch merges cleanly against this morning's HEAD and survived an
overnight run of xfstests.  The merge was completely straightforward, so
please let me know if you run into anything weird.

--D

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/copy-file-range-fixes-1

for you to fetch changes up to fe0da9c09b2dc448ff781d1426ecb36d145ce51b:

  fuse: copy_file_range needs to strip setuid bits and update timestamps (2019-06-09 10:07:07 -0700)

----------------------------------------------------------------
Changes to copy_file_range for 5.3 from Dave and Amir:
- Create a generic copy_file_range handler and make individual
  filesystems responsible for calling it (i.e. no more assuming that
  do_splice_direct will work or is appropriate)
- Refactor copy_file_range and remap_range parameter checking where they
  are the same
- Install missing copy_file_range parameter checking(!)
- Remove suid/sgid and update mtime like any other file write
- Change the behavior so that a copy range crossing the source file's
  eof will result in a short copy to the source file's eof instead of
  EINVAL
- Permit filesystems to decide if they want to handle cross-superblock
  copy_file_range in their local handlers.

----------------------------------------------------------------
Amir Goldstein (7):
      vfs: introduce generic_file_rw_checks()
      vfs: remove redundant checks from generic_remap_checks()
      vfs: add missing checks to copy_file_range
      vfs: introduce file_modified() helper
      xfs: use file_modified() helper
      vfs: allow copy_file_range to copy across devices
      fuse: copy_file_range needs to strip setuid bits and update timestamps

Dave Chinner (2):
      vfs: introduce generic_copy_file_range()
      vfs: no fallback for ->copy_file_range

 fs/ceph/file.c     |  23 ++++++++--
 fs/cifs/cifsfs.c   |   4 ++
 fs/fuse/file.c     |  29 +++++++++++--
 fs/inode.c         |  20 +++++++++
 fs/nfs/nfs4file.c  |  23 ++++++++--
 fs/read_write.c    | 124 +++++++++++++++++++++++++++++------------------------
 fs/xfs/xfs_file.c  |  15 +------
 include/linux/fs.h |   9 ++++
 mm/filemap.c       | 110 ++++++++++++++++++++++++++++++++++++++---------
 9 files changed, 257 insertions(+), 100 deletions(-)
