Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D312325B96B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 05:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgICDwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 23:52:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47026 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgICDwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:52:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0833obwd191914;
        Thu, 3 Sep 2020 03:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=plrQbRO5We9myfM1D8OZxb2JZVOMVYHNu9vACenTQ7o=;
 b=umACb64vTspKV52Xcc2OvTOzfLlTJiWJuHOTs9jzlD6zO3V9a3Xcr/kMBdzVreM+DChF
 9BKCQK5bYPHT6YHyz/U9aeuNLi4YES3Dq3NuGX/yHXn3+fq96EYCkjeN5JvHkmYjiqtc
 /x8QihfAhutP8U3M7Yki2WOt2sYSelCosgzJtVhoe41p47nEgTb5BB5tOuNCoaR9o5gd
 WSPsXdUbv154rNs8yrdoYmmELgCi50Pl/Z7/cOLWSd/QC4GOBJV4GH1ZzCEeGxgndvfJ
 KudpvhKniH9/J+3E+VWUdcKfafv74WBM/DGcJtFHcY/wTd5FXRUs8/NUpLDNWbbqFW3o Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eyme83a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 03:52:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0833nlUh078075;
        Thu, 3 Sep 2020 03:52:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3380y12x5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 03:52:35 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0833qYAW084111;
        Thu, 3 Sep 2020 03:52:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3380y12x5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 03:52:34 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0833qQ8V030386;
        Thu, 3 Sep 2020 03:52:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 20:52:26 -0700
Date:   Wed, 2 Sep 2020 20:52:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        ocfs2 list <ocfs2-devel@oss.oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Broken O_{D,}SYNC behavior with FICLONE*?
Message-ID: <20200903035225.GJ6090@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030035
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I have a question for everyone-- do FICLONE and FICLONERANGE count as a
"write operation" for the purposes of reasoning about O_SYNC and
O_DSYNC?  In other words, is it supposed to be the case that
(paraphrasing the open(2) manpage) "By the time ioctl(FICLONE) returns,
the output data and associated file metadata have been transferred to
the underlying hardware (i.e., as though each ioctl(FICLONE) was
followed by a call to fsync(2))."?

If I open a file with O_SYNC, call FICLONE to reflink some data blocks
into that file, and hit the reset button as soon as the ioctl call
returns, should I expect that I will always see the new file contents in
that file after the system comes back up?  Or am I required to fsync()
the file despite O_SYNC being set?

The reason I ask is that (a) reflinking can definitely change the file
contents which seems like a write operation; and (b) we wrote a test to
examine the copy_file_range() semantics wrt O_SYNC and discovered that
an unaligned c_f_r through the splice code does indeed honor the
documented O_SYNC semantics, but a block-aligned c_f_r that uses reflink
does *not* honor this.

So, that's inconsistent behavior and I want to know if remap_file_range
is broken or if we all just don't care about O_SYNC for these fancy
IO accelerators?

I tend to think reflink is broken on XFS, but I converted that O_SYNC
test into a fstest and discovered that none of XFS, btrfs, or ocfs2
actually force the fs to persist metadata changes after reflinking into
an O_SYNC file.  The manpages for the clone ioctls and copy_file_range
don't explicitly declare those calls to be "write operations".

FWIW I repeated the analysis with a file that had FS_XFLAG_SYNC or
FS_SYNC_FL set on the inode but O_SYNC was not set on the fd, and
observed the same results.

--D
