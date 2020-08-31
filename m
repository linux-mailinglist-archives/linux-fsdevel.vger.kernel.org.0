Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB7F257E10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHaP5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 11:57:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHaP5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:57:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VFsTIx169794;
        Mon, 31 Aug 2020 15:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=w0ybiQv8WIpsYvaV51tcFUcekNOZ33RmqzGhKVFiRIg=;
 b=OlmjLQukA67uA8TxKMXk/ALXtcWV/qxeCFp3WMz1p1kCjQKu11Cqp1BosWduRFzW2sdq
 Jed67BxgowpEV12ckY+hL2KlyKSE/+H/Gw97RCowzV/wymZLnCOL8+t/eYqZHNVnb8hy
 vRYT+K5Lytjsiaun+K3FObRAqHB1BJmvkpBA5WOdrc+zCbnme7gA7P6kOy40JwS6oPuU
 88/S+u56oLwhELWkpnKp4Rjz6EMnReciVaD8rCJ5GgzhGEluVAcTYRrbwDynjjsJJtyJ
 M/x12KS5Ll5AZ8UjMA63Oc8rx4A50KINHsg6HODhXApLuXkiX0GsZurczA4cHY+Mrjd8 Kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eyky1jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 15:56:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VFsu5q182897;
        Mon, 31 Aug 2020 15:56:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380sq6m0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 15:56:53 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07VFunaa023523;
        Mon, 31 Aug 2020 15:56:49 GMT
Received: from localhost (/10.159.252.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 08:56:49 -0700
Date:   Mon, 31 Aug 2020 08:56:52 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Qian Cai <cai@lca.pw>, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: Fix WARN_ON_ONCE() from unprivileged users
Message-ID: <20200831155652.GE6096@magnolia>
References: <20200831014511.17174-1-cai@lca.pw>
 <d34753a2-57bf-8013-015a-adeb3fe9447c@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34753a2-57bf-8013-015a-adeb3fe9447c@sandeen.net>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=56 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=56 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310094
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:48:59AM -0500, Eric Sandeen wrote:
> On 8/30/20 8:45 PM, Qian Cai wrote:
> > It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
> > unprivileged users which would taint the kernel, or worse - panic if
> > panic_on_warn or panic_on_taint is set. Hence, just convert it to
> > pr_warn_ratelimited() to let users know their workloads are racing.
> > Thanks Dave Chinner for the initial analysis of the racing reproducers.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: Record the path, pid and command as well.
> > 
> >  fs/iomap/direct-io.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index c1aafb2ab990..66a4502ef675 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -374,6 +374,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct iomap_dio *dio = data;
> > +	char pathname[128], *path;
> >  
> >  	switch (iomap->type) {
> >  	case IOMAP_HOLE:
> > @@ -389,7 +390,21 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  	case IOMAP_INLINE:
> >  		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> >  	default:
> > -		WARN_ON_ONCE(1);
> 
> It seems like we should explicitly catch IOMAP_DELALLOC for this case, and leave the
> default: as a WARN_ON that is not user-triggerable? i.e.
> 
> case IOMAP_DELALLOC:
> 	<all the fancy warnings>
> 	return -EIO;
> default:
> 	WARN_ON_ONCE(1);
> 	return -EIO;
> 
> > +		/*
> > +		 * DIO is not serialised against mmap() access at all, and so
> > +		 * if the page_mkwrite occurs between the writeback and the
> > +		 * iomap_apply() call in the DIO path, then it will see the
> > +		 * DELALLOC block that the page-mkwrite allocated.
> > +		 */
> > +		path = file_path(dio->iocb->ki_filp, pathname,
> > +				 sizeof(pathname));
> > +		if (IS_ERR(path))
> > +			path = "(unknown)";
> > +
> > +		pr_warn_ratelimited("page_mkwrite() is racing with DIO read (iomap->type = %u).\n"
> > +				    "File: %s PID: %d Comm: %.20s\n",
> > +				    iomap->type, path, current->pid,
> > +				    current->comm);
> 
> This is very specific ...
> 
> Do we know that mmap/page_mkwrite is (and will always be) the only way to reach this
> point?
> 
> It seems to me that this message won't be very useful for the admin; "pg_mkwrite" may
> mean something to us, but doubtful for the general public.  And "type = 1" won't mean
> much to the reader, either.
> 
> Maybe something like:
> 
> "DIO encountered delayed allocation block, racing buffered+direct? File: %s Comm: %.20s\n"
> 
> It just seems that a user-facing warning should be something the admin has a chance of
> acting on without needing to file a bug for analysis by the developers.
> 
> (though TBH "delayed allocation" probably doesn't mean much to the admin, either)

/me suggests

"Direct I/O collision with buffered write!  File: %s..."?

I concede that we ought to leave the nastier WARN for the default
case since there are no other IOMAP_ types and so any other code is
a sign of a serious screwup.

--D

> 
> -Eric
> 
> >  		return -EIO;
> >  	}
> >  }
> > 
