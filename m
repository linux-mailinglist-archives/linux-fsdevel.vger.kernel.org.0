Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CEC2CC07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfE1Qbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:31:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55486 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1Qbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:31:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGSqjm182812;
        Tue, 28 May 2019 16:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hojCBGvGd49QPWjjv991gv8ncr/i5kwhr+SPu6Dmw54=;
 b=imeuKgXPtOHNJ6xNDaZ0plOjIReb3+ESVPRA4Mq/QbJtPW880Y57BLsPrDc5GNEhJcfA
 2OkKEh/SMdqvSSHSsNKXoBtzE8k8jQR5Js+J8wuomx14a9SYFbEGNMRJ1T2gJ5d9qTps
 FT2MwMzzu7z8fcZHSV5QRvld95YHIohVxC7rNCGamyLjATDVi+B/uVq2xyCBtnsPK0hn
 5VeWTvadX/5P+yN0UsRLQP/2bGjR91HLuTOqw2ZIhnuK6vAYdm9FTqotsAy1i9EgxJ6V
 LVlnarZEpIUVqWZLk22OcGGZ29gYEWhXCz7Z0ID1h5eroHD/r6x2v3y6Z+3cPGMuYqVe pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7dcn9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:31:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGTn2w135690;
        Tue, 28 May 2019 16:31:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2srbdww45j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:31:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SGVCO5014795;
        Tue, 28 May 2019 16:31:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 09:31:11 -0700
Date:   Tue, 28 May 2019 09:31:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 4/8] vfs: add missing checks to copy_file_range
Message-ID: <20190528163110.GG5221@magnolia>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-5-amir73il@gmail.com>
 <20190528161829.GD5221@magnolia>
 <CAOQ4uxjRJmiwM4L9ZFHi8rfjX87-xJ=+9HSeTgUyRyTUnkF6PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjRJmiwM4L9ZFHi8rfjX87-xJ=+9HSeTgUyRyTUnkF6PA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280105
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 07:26:29PM +0300, Amir Goldstein wrote:
> On Tue, May 28, 2019 at 7:18 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Sun, May 26, 2019 at 09:10:55AM +0300, Amir Goldstein wrote:
> > > Like the clone and dedupe interfaces we've recently fixed, the
> > > copy_file_range() implementation is missing basic sanity, limits and
> > > boundary condition tests on the parameters that are passed to it
> > > from userspace. Create a new "generic_copy_file_checks()" function
> > > modelled on the generic_remap_checks() function to provide this
> > > missing functionality.
> > >
> > > [Amir] Shorten copy length instead of checking pos_in limits
> > > because input file size already abides by the limits.
> > >
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/read_write.c    |  3 ++-
> > >  include/linux/fs.h |  3 +++
> > >  mm/filemap.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 58 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > index f1900bdb3127..b0fb1176b628 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -1626,7 +1626,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> > >       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > >               return -EXDEV;
> > >
> > > -     ret = generic_file_rw_checks(file_in, file_out);
> > > +     ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
> > > +                                    flags);
> > >       if (unlikely(ret))
> > >               return ret;
> > >
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 89b9b73eb581..e4d382c4342a 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -3050,6 +3050,9 @@ extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
> > >                               struct file *file_out, loff_t pos_out,
> > >                               loff_t *count, unsigned int remap_flags);
> > >  extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
> > > +extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> > > +                                 struct file *file_out, loff_t pos_out,
> > > +                                 size_t *count, unsigned int flags);
> > >  extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
> > >  extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
> > >  extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 798aac92cd76..1852fbf08eeb 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -3064,6 +3064,59 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
> > >       return 0;
> > >  }
> > >
> > > +/*
> > > + * Performs necessary checks before doing a file copy
> > > + *
> > > + * Can adjust amount of bytes to copy
> >
> > That's the @req_count parameter, correct?
> 
> Correct. Same as generic_remap_checks()

Ok.  Would you mind updating the comment?

> >
> > > + * Returns appropriate error code that caller should return or
> > > + * zero in case the copy should be allowed.
> > > + */
> > > +int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> > > +                          struct file *file_out, loff_t pos_out,
> > > +                          size_t *req_count, unsigned int flags)
> > > +{
> > > +     struct inode *inode_in = file_inode(file_in);
> > > +     struct inode *inode_out = file_inode(file_out);
> > > +     uint64_t count = *req_count;
> > > +     loff_t size_in;
> > > +     int ret;
> > > +
> > > +     ret = generic_file_rw_checks(file_in, file_out);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* Don't touch certain kinds of inodes */
> > > +     if (IS_IMMUTABLE(inode_out))
> > > +             return -EPERM;
> > > +
> > > +     if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
> > > +             return -ETXTBSY;
> > > +
> > > +     /* Ensure offsets don't wrap. */
> > > +     if (pos_in + count < pos_in || pos_out + count < pos_out)
> > > +             return -EOVERFLOW;
> > > +
> > > +     /* Shorten the copy to EOF */
> > > +     size_in = i_size_read(inode_in);
> > > +     if (pos_in >= size_in)
> > > +             count = 0;
> > > +     else
> > > +             count = min(count, size_in - (uint64_t)pos_in);
> >
> > Do we need a call to generic_access_check_limits(file_in...) here to
> > prevent copies from ranges that the page cache doesn't support?
> 
> No. Because i_size cannot be of an illegal size and we cap
> the read to i_size.
> I also removed generic_access_check_limits() from generic_remap_checks()
> for a similar reason in patch #8.

<nod>

--D

> Thanks,
> Amir.
