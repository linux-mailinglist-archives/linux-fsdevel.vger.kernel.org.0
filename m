Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B32105E1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKVBXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 20:23:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42006 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVBXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:23:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1JAJv098566;
        Fri, 22 Nov 2019 01:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=W7Z0/78KkuLGOt8nvVnlz5n4XqpDduln29tQLHywO7Y=;
 b=Ww/XfdGsaN0GfvC0jNmg+NJ4PK+fwdhF1CTaoxSsbbQCt9eswyq05KLTzXAjQLkNlS41
 EnRMjW0x+FoWi3J15wtVDCW9jpBQxKcsP0o5nJc3utoToIOnUNnwXOrTPJEyr57171zV
 2lOkN2DrGbrBcfIhscheoSu1sJb1YwIiWalTou7+HXm/Z8v8HbYAXZp7lsu5LKU6NkTK
 b7WEJwoM+MLc6sP7c0o21GweF/kHiojUEa73uQ+NgaeQ0IyPEmhBwwZ105+MMRwFN1R9
 Dc/c6ETYHTBMVsLYLXjQDFQP4h1nwpYyoVrhIjBoLuiJMNBagN124sy13Tf52i/P97QF ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wa92q7rkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:22:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1J9bg142041;
        Fri, 22 Nov 2019 01:20:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wda071951-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:20:57 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAM1Ktlg004305;
        Fri, 22 Nov 2019 01:20:56 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 17:20:55 -0800
Date:   Thu, 21 Nov 2019 17:20:54 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>, ebiggers@kernel.org,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v4] splice: only read in as much information as there is
 pipe buffer space
Message-ID: <20191122012054.GB2981917@magnolia>
References: <20191019161138.GA6726@magnolia>
 <CAHc6FU57p6p7FXoYCe1AQNz54Fg2BZ5UsEW3BBUnhLaGq2SmsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU57p6p7FXoYCe1AQNz54Fg2BZ5UsEW3BBUnhLaGq2SmsQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220009
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 06:57:55PM +0100, Andreas Gruenbacher wrote:
> On Sat, Oct 19, 2019 at 6:14 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> >
> > Andreas Grünbacher reports that on the two filesystems that support
> > iomap directio, it's possible for splice() to return -EAGAIN (instead of
> > a short splice) if the pipe being written to has less space available in
> > its pipe buffers than the length supplied by the calling process.
> >
> > Months ago we fixed splice_direct_to_actor to clamp the length of the
> > read request to the size of the splice pipe.  Do the same to do_splice.
> >
> > Fixes: 17614445576b6 ("splice: don't read more than available pipe space")
> > Reported-by: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
> 
> Reviewed-by: Andreas Grünbacher <andreas.gruenbacher@gmail.com>

Cool, thanks.  I'll try to push this to Linus next week.

--D

> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> > v4: use size_t for pipe_pages
> > ---
> >  fs/splice.c |   14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/splice.c b/fs/splice.c
> > index 98412721f056..9b9b22d2215a 100644
> > --- a/fs/splice.c
> > +++ b/fs/splice.c
> > @@ -945,12 +945,13 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
> >         WARN_ON_ONCE(pipe->nrbufs != 0);
> >
> >         while (len) {
> > +               size_t pipe_pages;
> >                 size_t read_len;
> >                 loff_t pos = sd->pos, prev_pos = pos;
> >
> >                 /* Don't try to read more the pipe has space for. */
> > -               read_len = min_t(size_t, len,
> > -                                (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
> > +               pipe_pages = pipe->buffers - pipe->nrbufs;
> > +               read_len = min(len, pipe_pages << PAGE_SHIFT);
> >                 ret = do_splice_to(in, &pos, pipe, read_len, flags);
> >                 if (unlikely(ret <= 0))
> >                         goto out_release;
> > @@ -1180,8 +1181,15 @@ static long do_splice(struct file *in, loff_t __user *off_in,
> >
> >                 pipe_lock(opipe);
> >                 ret = wait_for_space(opipe, flags);
> > -               if (!ret)
> > +               if (!ret) {
> > +                       size_t pipe_pages;
> > +
> > +                       /* Don't try to read more the pipe has space for. */
> > +                       pipe_pages = opipe->buffers - opipe->nrbufs;
> > +                       len = min(len, pipe_pages << PAGE_SHIFT);
> > +
> >                         ret = do_splice_to(in, &offset, opipe, len, flags);
> > +               }
> >                 pipe_unlock(opipe);
> >                 if (ret > 0)
> >                         wakeup_pipe_readers(opipe);
> 
