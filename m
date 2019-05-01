Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE90108FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfEAOYg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 1 May 2019 10:24:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbfEAOYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 10:24:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41EMQpu143920
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 May 2019 10:24:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7a176u09-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 10:24:34 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Wed, 1 May 2019 15:24:32 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 15:24:28 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41EOREu48824320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 14:24:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0E6B52054;
        Wed,  1 May 2019 14:24:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A9BF852051;
        Wed,  1 May 2019 14:24:25 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 02/13] Consolidate "read callbacks" into a new file
Date:   Wed, 01 May 2019 18:02:39 +0530
Organization: IBM
In-Reply-To: <20190430180507.GD48973@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com> <20190428043121.30925-3-chandan@linux.ibm.com> <20190430180507.GD48973@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-TM-AS-GCONF: 00
x-cbid: 19050114-4275-0000-0000-000003304E9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050114-4276-0000-0000-0000383FAAE7
Message-Id: <8267479.irDUbO2F3m@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, April 30, 2019 11:35:08 PM IST Eric Biggers wrote:
> On Sun, Apr 28, 2019 at 10:01:10AM +0530, Chandan Rajendra wrote:
> > The "read callbacks" code is used by both Ext4 and F2FS. Hence to
> > remove duplicity, this commit moves the code into
> > include/linux/read_callbacks.h and fs/read_callbacks.c.
> > 
> > The corresponding decrypt and verity "work" functions have been moved
> > inside fscrypt and fsverity sources. With these in place, the read
> > callbacks code now has to just invoke enqueue functions provided by
> > fscrypt and fsverity.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/Kconfig                     |   4 +
> >  fs/Makefile                    |   4 +
> >  fs/crypto/Kconfig              |   1 +
> >  fs/crypto/bio.c                |  23 ++---
> >  fs/crypto/crypto.c             |  17 +--
> >  fs/crypto/fscrypt_private.h    |   3 +
> >  fs/ext4/ext4.h                 |   2 -
> >  fs/ext4/readpage.c             | 183 +++++----------------------------
> >  fs/ext4/super.c                |   9 +-
> >  fs/f2fs/data.c                 | 148 ++++----------------------
> >  fs/f2fs/super.c                |   9 +-
> >  fs/read_callbacks.c            | 136 ++++++++++++++++++++++++
> >  fs/verity/Kconfig              |   1 +
> >  fs/verity/verify.c             |  12 +++
> >  include/linux/fscrypt.h        |  20 +---
> >  include/linux/read_callbacks.h |  21 ++++
> >  16 files changed, 251 insertions(+), 342 deletions(-)
> >  create mode 100644 fs/read_callbacks.c
> >  create mode 100644 include/linux/read_callbacks.h
> > 
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 97f9eb8df713..03084f2dbeaf 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -308,6 +308,10 @@ config NFS_COMMON
> >  	depends on NFSD || NFS_FS || LOCKD
> >  	default y
> >  
> > +config FS_READ_CALLBACKS
> > +       bool
> > +       default n
> > +
> >  source "net/sunrpc/Kconfig"
> >  source "fs/ceph/Kconfig"
> >  source "fs/cifs/Kconfig"
> 
> This shouldn't be under the 'if NETWORK_FILESYSTEMS' block, since it has nothing
> to do with network filesystems.  When trying to compile this I got:
> 
> 	WARNING: unmet direct dependencies detected for FS_READ_CALLBACKS
> 	  Depends on [n]: NETWORK_FILESYSTEMS [=n]
> 	  Selected by [y]:
> 	  - FS_ENCRYPTION [=y]
> 	  - FS_VERITY [=y]
> 
> Perhaps put it just below FS_IOMAP?
> 
> > diff --git a/fs/Makefile b/fs/Makefile
> > index 9dd2186e74b5..e0c0fce8cf40 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -21,6 +21,10 @@ else
> >  obj-y +=	no-block.o
> >  endif
> >  
> > +ifeq ($(CONFIG_FS_READ_CALLBACKS),y)
> > +obj-y +=	read_callbacks.o
> > +endif
> > +
> >  obj-$(CONFIG_PROC_FS) += proc_namespace.o
> >  
> >  obj-y				+= notify/
> > diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
> > index f0de238000c0..163c328bcbd4 100644
> > --- a/fs/crypto/Kconfig
> > +++ b/fs/crypto/Kconfig
> > @@ -8,6 +8,7 @@ config FS_ENCRYPTION
> >  	select CRYPTO_CTS
> >  	select CRYPTO_SHA256
> >  	select KEYS
> > +	select FS_READ_CALLBACKS
> >  	help
> >  	  Enable encryption of files and directories.  This
> >  	  feature is similar to ecryptfs, but it is more memory
> 
> This selection needs to be conditional on BLOCK.
> 
> 	select FS_READ_CALLBACKS if BLOCK
> 
> Otherwise, building without BLOCK and with UBIFS encryption support fails.
> 
> 	fs/read_callbacks.c: In function ‘end_read_callbacks’:
> 	fs/read_callbacks.c:34:23: error: storage size of ‘iter_all’ isn’t known
> 	  struct bvec_iter_all iter_all;
> 			       ^~~~~~~~
> 	fs/read_callbacks.c:37:20: error: dereferencing pointer to incomplete type ‘struct buffer_head’
> 	   if (!PageError(bh->b_page))
> 
> 	[...]
>

I will fix this in the next version of this patchset.

-- 
chandan



