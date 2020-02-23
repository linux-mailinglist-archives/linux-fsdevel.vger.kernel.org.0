Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCB169941
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBWR6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 12:58:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWR6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:58:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01NHvWju073441;
        Sun, 23 Feb 2020 17:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LL53eGqGjRhh2FS0FiyzWSm5OLgF8ml4hem9pzFTyEA=;
 b=PakxXawgs/LSVhmYsY1+zuFHltffRjwbw3lP6hwl72y2PLEa8jNl5Ujy9gt6xfZOb6Mz
 pZe861TUQ4w4vRL9H8BDN/Ft61yUxW8ZBT4mCp1Nsu1+ZVxqNgCaBMfkolgljQ/nzIEm
 VO3l937hvjq7rdJRQatg9AN9IDP9fTPQ6OaBJMyOSZbxjNXA0Pa3NCTlr7d5UixoLlJV
 YrAW+AhpE2AJpG3fsJITXVfY9m9jcm9agVJeDdzcJ59kdJlQYXV/vdxaxGBdHC43mQUa
 BqvSk6611lS95oLYQySLRzScVf7fgUh60vjQJvd694prMF7sLeHaJsUvpLosCClFBjqK OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yavxrbtp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Feb 2020 17:57:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01NHq2br019936;
        Sun, 23 Feb 2020 17:55:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 2ybe3cnq93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Feb 2020 17:55:31 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01NHtVwC036442;
        Sun, 23 Feb 2020 17:55:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ybe3cnq8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Feb 2020 17:55:31 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01NHtP55027269;
        Sun, 23 Feb 2020 17:55:25 GMT
Received: from localhost (/10.159.228.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 09:55:25 -0800
Date:   Sun, 23 Feb 2020 09:55:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200223175523.GK9506@magnolia>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
 <20200222004425.GG9506@magnolia>
 <20200222015435.GH24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222015435.GH24185@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002230148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:54:35PM -0800, Matthew Wilcox wrote:
> On Fri, Feb 21, 2020 at 04:44:25PM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > By putting the 'have we reached the end of the page' condition at the end
> > > of the loop instead of the beginning, we can remove the 'submit the last
> > > page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> > > didn't return 0, which would lead to an endless loop.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  fs/iomap/buffered-io.c | 32 ++++++++++++++++++--------------
> > >  1 file changed, 18 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index cb3511eb152a..31899e6cb0f8 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -400,15 +400,9 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> > >  		void *data, struct iomap *iomap, struct iomap *srcmap)
> > >  {
> > >  	struct iomap_readpage_ctx *ctx = data;
> > > -	loff_t done, ret;
> > > -
> > > -	for (done = 0; done < length; done += ret) {
> > > -		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
> > > -			if (!ctx->cur_page_in_bio)
> > > -				unlock_page(ctx->cur_page);
> > > -			put_page(ctx->cur_page);
> > > -			ctx->cur_page = NULL;
> > > -		}
> > > +	loff_t ret, done = 0;
> > > +
> > > +	while (done < length) {
> > >  		if (!ctx->cur_page) {
> > >  			ctx->cur_page = iomap_next_page(inode, ctx->pages,
> > >  					pos, length, &done);
> > > @@ -418,6 +412,20 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> > >  		}
> > >  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> > >  				ctx, iomap, srcmap);
> > > +		done += ret;
> > > +
> > > +		/* Keep working on a partial page */
> > > +		if (ret && offset_in_page(pos + done))
> > > +			continue;
> > > +
> > > +		if (!ctx->cur_page_in_bio)
> > > +			unlock_page(ctx->cur_page);
> > > +		put_page(ctx->cur_page);
> > > +		ctx->cur_page = NULL;
> > > +
> > > +		/* Don't loop forever if we made no progress */
> > > +		if (WARN_ON(!ret))
> > > +			break;
> > >  	}
> > >  
> > >  	return done;
> > > @@ -451,11 +459,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
> > >  done:
> > >  	if (ctx.bio)
> > >  		submit_bio(ctx.bio);
> > > -	if (ctx.cur_page) {
> > > -		if (!ctx.cur_page_in_bio)
> > > -			unlock_page(ctx.cur_page);
> > > -		put_page(ctx.cur_page);
> > > -	}
> > > +	BUG_ON(ctx.cur_page);
> > 
> > Whoah, is the system totally unrecoverably hosed at this point?
> > 
> > I get that this /shouldn't/ happen, but should we somehow end up with a
> > page here, are we unable either to release it or even just leak it?  I'd
> > have thought a WARN_ON would be just fine here.
> 
> If we do find a page here, we don't actually know what to do with it.
> It might be (currently) locked, it might have the wrong refcount.
> Whatever is going on, it's probably better that we stop everything right
> here rather than allow things to go further and possibly present bad
> data to the application.  I mean, we could even be leaking the previous
> contents of this page to userspace.  Or maybe the future contents of a
> page which shouldn't be in the page cache any more, but userspace gets
> a mapping to it.
> 
> I'm not enthusiastic about putting in some code here to try to handle
> a "can't happen" case, since it's never going to be tested, and might
> end up causing more problems than it tries to solve.  Let's just stop.

Seeing how Linus (and others like myself) are a bit allergic to BUG
these days, could you add the first paragraph of the above justification
as a comment adjacent to the BUG_ON(), please? :)

--D
