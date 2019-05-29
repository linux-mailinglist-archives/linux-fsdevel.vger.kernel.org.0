Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F52E527
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfE2TQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:16:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35380 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfE2TQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:16:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TJ8moq099574;
        Wed, 29 May 2019 19:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wwQABkI9nKmMmmCmt7tYSKfQl8Xv+2adwjPE+toPvZc=;
 b=G5M3zZ+4WIGkIOG2z3ASoQ9GjcUwME+rl1ddhJ0c3W98SckWDvPQKkK5NKUIIf2htBeT
 esVGarSGWwPpBD70e5aygN5PmJz4uFo+C6Z2PIDWIB6I2lb9RUyUUWIv763fnWjw33Io
 qJK6dJBl8vDua/fCRwLsSxTlyIUTGj5rVoyE1ZhulY2oH51dUnasfrn6S/zmZtuIJKgn
 Mtd3sqItvSoOv2CIZzrwuhkuQ8NmooahGwlqMpRUK2AoCcjSNbH43s/mKJ4BjWXMqh7p
 P2usmRDbP/4mLAYvJwbl7vIBdeAdMWwKMXsCSSjBtjy1ENeRcHHOp8GKmdvAbJR9v5X6 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7dm7rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 19:16:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TJDqKo117514;
        Wed, 29 May 2019 19:14:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2srbdxk13r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 19:14:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TJE1oA028073;
        Wed, 29 May 2019 19:14:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 12:14:00 -0700
Date:   Wed, 29 May 2019 12:13:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH v3 07/13] xfs: use file_modified() helper
Message-ID: <20190529191359.GI5231@magnolia>
References: <20190529174318.22424-1-amir73il@gmail.com>
 <20190529174318.22424-8-amir73il@gmail.com>
 <20190529183149.GG5231@magnolia>
 <CAOQ4uxg0Z8Ne8kadPzsushW43t3Sijy+9WQbGRRO=CtmMAbtuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg0Z8Ne8kadPzsushW43t3Sijy+9WQbGRRO=CtmMAbtuA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=896
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=926 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 10:10:37PM +0300, Amir Goldstein wrote:
> On Wed, May 29, 2019 at 9:31 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Wed, May 29, 2019 at 08:43:11PM +0300, Amir Goldstein wrote:
> > > Note that by using the helper, the order of calling file_remove_privs()
> > > after file_update_mtime() in xfs_file_aio_write_checks() has changed.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 15 +--------------
> > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > >
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 76748255f843..916a35cae5e9 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -367,20 +367,7 @@ xfs_file_aio_write_checks(
> > >        * lock above.  Eventually we should look into a way to avoid
> > >        * the pointless lock roundtrip.
> > >        */
> > > -     if (likely(!(file->f_mode & FMODE_NOCMTIME))) {
> >
> > ...especially since here we think NOCMTIME is likely /not/ to be set.
> >
> > > -             error = file_update_time(file);
> > > -             if (error)
> > > -                     return error;
> > > -     }
> > > -
> > > -     /*
> > > -      * If we're writing the file then make sure to clear the setuid and
> > > -      * setgid bits if the process is not being run by root.  This keeps
> > > -      * people from modifying setuid and setgid binaries.
> > > -      */
> > > -     if (!IS_NOSEC(inode))
> > > -             return file_remove_privs(file);
> >
> > Hm, file_modified doesn't have the !IS_NOSEC check guarding
> > file_remove_privs, are you sure it's ok to remove the suid bits
> > unconditionally?  Even if SB_NOSEC (and therefore S_NOSEC) are set?
> >
> 
> file_remove_privs() has its own IS_NOSEC() check.

Ah, ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> Thanks,
> Amir.
