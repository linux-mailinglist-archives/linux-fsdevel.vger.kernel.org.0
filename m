Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91D1BD28A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgD2CqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:46:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49428 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgD2CqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:46:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2j6kG074138;
        Wed, 29 Apr 2020 02:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=saTp9ZlztCwLxl5GJqatd7nexbzAftCe0NqyMIjna2U=;
 b=AXqykkB0QEllnEW3qUBevZ4oIoNKkMvD8SoZfyfTV58KAEK2c9JjstlBMjp2M5urFmKj
 9x9tT29joiTUPeYnka0vbgqucbcSJSydtCelfbnnljNqAoSAbpJbBsIwGQO9kKVnpyA0
 QERf23M1Won+RhA4IHjsO1OlTLfOkuwFlO5xDqp9Pt/nrVKK3IBKSAU24AkpcmXVMbqh
 Tby27uVRd4OBjyq0rSzDylIjPPKkCYtJNALdSit2ILZ8ihM+ZnEF22z1tSNv2sDZtq7i
 s+qWGaUgWvXhcMvOarXDC1SboIn2zShIDlx+TfYXcHCDqu+7QfkN3nRx5wrt8XnR367n Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucg39r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2g1jn096298;
        Wed, 29 Apr 2020 02:44:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30pvcytcgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:16 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2iFqM003255;
        Wed, 29 Apr 2020 02:44:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:44:15 -0700
Subject: [PATCH RFC 00/18] xfs: atomic file updates
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:44:14 -0700
Message-ID: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
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
