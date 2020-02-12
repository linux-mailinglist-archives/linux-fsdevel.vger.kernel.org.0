Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27B15ACFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 17:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBLQQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 11:16:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40060 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLQQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:16:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CGCUaI130268;
        Wed, 12 Feb 2020 16:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=ZKviGbG6lw2iau5Hqm1fy3bel52R6i6RXmJNtHiASNs=;
 b=q5ZCTtO4hYeSba9O57u3LaJ2Pv525jWQJi0hjIGQH0vfQgnOkQuFrNOFLLI5PJ+h+yTR
 VXpvp1kfBidK839BuAkBfFFZoQzv2fyzJGEVFo17dfQ9VpHyBJlrVThJt+9X3OP73z/V
 /RvPend6q59q2SaXkXaT7yXt/L9btOEJUKwKzoGDKieVwEsNDyl9flbyPhP6Ii+ZNzCU
 1Qh6x3UUMpcjr8xBCoaeFiSJTxnqLV7M6SbXi1TlrUtlaeBdY+/Wc4s55jhBHNJ9TJNy
 Np7+s4gFPxBUFmEGjueytYHaov4BdEvxh6n8XNMCeUyyBFkhlxwbCEikVsnNye+7rilA 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y2jx6c7d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 16:16:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CGD7CO083542;
        Wed, 12 Feb 2020 16:16:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y4kagecjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 16:16:08 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CGG6w0031881;
        Wed, 12 Feb 2020 16:16:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 08:16:05 -0800
Date:   Wed, 12 Feb 2020 08:16:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200212161604.GP6870@magnolia>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kvwowke.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=2 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=2 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:48:49PM +0100, Florian Weimer wrote:
> In principle, Linux supports lchmod via O_PATH descriptors and chmod
> on /proc/self/fd.  (lchmod is the non-symbolic-link-following variant
> of chmod.)
> 
> This helper program can be used to do this:
> 
> #define _GNU_SOURCE
> #include <err.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/stat.h>
> #include <unistd.h>
> 
> int
> main (int argc, char **argv)
> {
>   if (argc != 3)
>     {
>       fprintf (stderr, "usage: %s MODE FILE\n", argv[0]);
>       return 2;
>     }
> 
>   unsigned int mode;
>   if (sscanf (argv[1], "%o", &mode) != 1
>       || mode != (mode_t) mode)
>     errx (1, "invalid mode: %s", argv[1]);
> 
>   int fd = open (argv[2], O_PATH | O_NOFOLLOW);
>   if (fd < 0)
>     err (1, "open");
> 
>   char *fd_path;
>   if (asprintf (&fd_path, "/proc/self/fd/%d", fd) < 0)
>     err (1, "asprintf");
> 
>   if (chmod (fd_path, mode) != 0)
>     err (1, "chmod");
> 
>   free (fd_path);
>   if (close (fd) != 0)
>     err (1, "close");
> 
>   return 0;
> }
> 
> When changing the permissions of on XFS in this way, the chmod
> operation fails:
> 
> $ ln -s does-not-exist /var/tmp/symlink
> $ ls -l /var/tmp/symlink 
> lrwxrwxrwx. 1 fweimer fweimer 14 Feb 12 12:41 /var/tmp/symlink -> does-not-exist
> $ strace ./lchmod 0 /var/tmp/symlink
> […]
> openat(AT_FDCWD, "/var/tmp/symlink", O_RDONLY|O_NOFOLLOW|O_PATH) = 3
> […]
> chmod("/proc/self/fd/3", 000)           = -1 EOPNOTSUPP (Operation not supported)
> write(2, "lchmod: ", 8lchmod: )                 = 8
> write(2, "chmod", 5chmod)                    = 5
> write(2, ": Operation not supported\n", 26: Operation not supported
> ) = 26
> exit_group(1)                           = ?
> 
> But the file system contents has changed nevertheless:
> 
> $ ls -l /var/tmp/symlink 
> l---------. 1 fweimer fweimer 14 Feb 12 12:41 /var/tmp/symlink -> does-not-exist
> $ echo 3 | sudo tee /proc/sys/vm/drop_caches 
> $ ls -l /var/tmp/symlink 
> l---------. 1 fweimer fweimer 14 Feb 12 12:41 /var/tmp/symlink -> does-not-exist
> 
> This looks like an XFS bug to me.  With tmpfs, the chmod succeeds and
> is reflected in the file system.
> 
> This bug also affects regular files, not just symbolic links.
> 
> It causes the io/tst-lchmod glibc test to fail (after it has been
> fixed, the in-tree version has another bug).

xfs_setattr_nonsize calls posix_acl_chmod which returns EOPNOTSUPP
because the xfs symlink inode_operations do not include a ->set_acl
pointer.

I /think/ that posix_acl_chmod code exists to enforce that the file mode
reflects any acl that might be set on the inode, but in this case the
inode is a symbolic link.

I don't remember off the top of my head if ACLs are supposed to apply to
symlinks, but what do you think about adding get_acl/set_acl pointers to
xfs_symlink_inode_operations and xfs_inline_symlink_inode_operations ?

--D
