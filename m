Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF241D999B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436640AbfJPSzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 14:55:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbfJPSzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:55:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GIs1Pl164788;
        Wed, 16 Oct 2019 18:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=dq5ydZCzDs0WCrN8sqLZk/vjjiqakB5YHpdgLM741oM=;
 b=UCAJVZO1xsJj1uTdkX+l9p4Zvppxcb/TlQEYYswhmtIbBR/cKlLB6XeWga1W+NwlYK5x
 mVqtpEa9nynwcPoznJfDig1bqAmUSs4TD7wcHtR7rsd4+joeGiHPizIyp8F4/mCa30Kn
 Pk2hLGFuzLSCuszZ3Um5a/rdtzBJicLnAZNBUTQgYdW6wwXrLofFgAF8sCCB/BnBz/BH
 +NnhjovrydPBEQtzAMJxfYkiY4yn96yYjWGWZt7ureJld1xxhNX2sDd+zfGOf8KZiiV7
 5hXANABFU+WKM4PvrgDdVVwP2h5LzxeNVFgI340mVWChJCXOMfhXydtdREakWzquBL9o Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vk6sqs6dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 18:54:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GIrxFq035798;
        Wed, 16 Oct 2019 18:54:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vnxvaany2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 18:54:52 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9GIsplH016809;
        Wed, 16 Oct 2019 18:54:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 18:54:51 +0000
Date:   Wed, 16 Oct 2019 11:54:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH v3] splice: only read in as much information as there is
 pipe buffer space
Message-ID: <20191016185449.GI13098@magnolia>
References: <20191014220940.GF13098@magnolia>
 <20191016031259.GH15134@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016031259.GH15134@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 02:12:59PM +1100, Dave Chinner wrote:
> On Mon, Oct 14, 2019 at 03:09:40PM -0700, Darrick J. Wong wrote:
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
> > Reported-by: syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com
> > Reported-by: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  fs/splice.c |   14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/splice.c b/fs/splice.c
> > index 98412721f056..e509239d7e06 100644
> > --- a/fs/splice.c
> > +++ b/fs/splice.c
> > @@ -945,12 +945,13 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
> >  	WARN_ON_ONCE(pipe->nrbufs != 0);
> >  
> >  	while (len) {
> > +		unsigned int pipe_pages;
> 
> define this as a size_t...
> 
> >  		size_t read_len;
> >  		loff_t pos = sd->pos, prev_pos = pos;
> >  
> >  		/* Don't try to read more the pipe has space for. */
> > -		read_len = min_t(size_t, len,
> > -				 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
> > +		pipe_pages = pipe->buffers - pipe->nrbufs;
> > +		read_len = min(len, (size_t)pipe_pages << PAGE_SHIFT);
> 
> 		read_len = min_t(size_t, len, pipe_pages << PAGER_SHIFT);

If we make pipe_pages have type size_t then we don't need min_t here,
right?  Since len and read_len are already size_t.

--D

> >  		ret = do_splice_to(in, &pos, pipe, read_len, flags);
> >  		if (unlikely(ret <= 0))
> >  			goto out_release;
> > @@ -1180,8 +1181,15 @@ static long do_splice(struct file *in, loff_t __user *off_in,
> >  
> >  		pipe_lock(opipe);
> >  		ret = wait_for_space(opipe, flags);
> > -		if (!ret)
> > +		if (!ret) {
> > +			unsigned int pipe_pages;
> > +
> > +			/* Don't try to read more the pipe has space for. */
> > +			pipe_pages = opipe->buffers - opipe->nrbufs;
> > +			len = min(len, (size_t)pipe_pages << PAGE_SHIFT);
> 
> And same here...
> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
