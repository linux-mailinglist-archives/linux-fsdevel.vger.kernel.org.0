Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC818C019
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 20:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgCSTJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 15:09:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40914 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgCSTJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:09:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JJ2tb4140008;
        Thu, 19 Mar 2020 19:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3FSoltCov6zrprMIbgUNSertysTyKeZ/P3fyNFSf72Q=;
 b=JeCBuslRZ2y1xNbe+YXwlHlJuaynAG1tUG+RuVvpqyABBB6UVkkq88/MUcF1tBYcqC2t
 O1vNiQ0ShnfkCqQAKtbfO3k6RTRXFpgb3LTYOeVL5sBkgrPU4+IWXHjhZXUI/mwtrvQ/
 sri253MmPPHEzNgR9oIexHhLDr7oeMk8/4/rMolh1/LfNhL+ibfvL7Ef7DGa2HJIHg5c
 BcDSMt6YpjzQ7k59qmSpUgPUgPGOdVSgYXB8hVBkIxFq/y6cO7+HBscmunW8HHvradt/
 fcyOCyX2U51d8Zq2Wzx+9y/2YPtUqHLST5zUE0bCwSvEjKdce9eDUb2qbqTT79ipq6HW 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yrpprj8c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 19:08:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JJ2a2x099501;
        Thu, 19 Mar 2020 19:08:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ys904s78p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 19:08:49 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02JJ8mC9027948;
        Thu, 19 Mar 2020 19:08:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 12:08:48 -0700
Date:   Thu, 19 Mar 2020 12:08:46 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] iomap: Submit BIOs at the end of each extent
Message-ID: <20200319190846.GB1581085@magnolia>
References: <20200319150720.24622-1-willy@infradead.org>
 <20200319151819.GA1581085@magnolia>
 <20200319190646.GM22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319190646.GM22433@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190080
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:06:46PM -0700, Matthew Wilcox wrote:
> On Thu, Mar 19, 2020 at 08:18:19AM -0700, Darrick J. Wong wrote:
> > On Thu, Mar 19, 2020 at 08:07:20AM -0700, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > By definition, an extent covers a range of consecutive blocks, so
> > > it would be quite rare to be able to just add pages to the BIO from
> > > a previous range.  The only case we can think of is a mapped extent
> > > followed by a hole extent, followed by another mapped extent which has
> > > been allocated immediately after the first extent.  We believe this to
> > 
> > Well... userspace can induce that with fallocate(INSERT_RANGE). :)
> 
> It's not impossible, of course ... just unlikely.  Nobody actually uses
> INSERT_RANGE anyway.
> 
> > > be an unlikely layout for a filesystem to choose and, since the queue
> > > is plugged, those two BIOs would be merged by the block layer.
> > > 
> > > The reason we care is that ext2/ext4 choose to lay out blocks 0-11
> > > consecutively, followed by the indirect block, and we want to merge those
> > > two BIOs.  If we don't submit the data BIO before asking the filesystem
> > > for the next extent, then the indirect BIO will be submitted first,
> > > and waited for, leading to inefficient I/O patterns.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  fs/iomap/buffered-io.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 83438b3257de..8d26920ddf00 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -388,6 +388,11 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
> > >  				ctx, iomap, srcmap);
> > >  	}
> > >  
> > > +	if (ctx->bio) {
> > > +		submit_bio(ctx->bio);
> > > +		ctx->bio = NULL;
> > > +	}
> > 
> > Makes sense, but could we have a quick comment here to capture why we're
> > submitting the bio here?
> > 
> > /*
> >  * Submit the bio now so that we neither combine IO requests for
> >  * non-adjacent ranges nor interleave data and metadata requests.
> >  */
> 
> How about:
> 
>          * Submitting the bio here leads to better I/O patterns for
>          * filesystems which need to do metadata reads to find the
>          * next range.

Oooh I like your version better.

> I also realised we can add:
> 
> @@ -454,8 +459,6 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>         }
>         ret = 0;
>  done:
> -       if (ctx.bio)
> -               submit_bio(ctx.bio);
>         if (ctx.cur_page) {
>                 if (!ctx.cur_page_in_bio)
>                         unlock_page(ctx.cur_page);
> 
> since we always subit the bio in readpages_actor.

<nod> I'll keep an eye out for v2. :)

--D
