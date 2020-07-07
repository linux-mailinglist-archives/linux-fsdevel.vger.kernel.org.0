Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D93216E4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGGOBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 10:01:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgGGOBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:01:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067DucOv160138;
        Tue, 7 Jul 2020 14:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BMf3w9y2XYDkAXSYrmlZg/6buyynJndzKMKgvqKG3FE=;
 b=LZpIUhOF9v6c/39UpI3ntvKZQN0wiZ0wSfnxpbcL6XFK24yuqM3/E5AQG3zMe64a6F+o
 R+wnaR8CDr3AYlZe3bAXGx9clQ90yD4HBv8OGA5vw/qO1O1gPaQyfGKN7gTHDt5KRsm8
 MjKdA1kuqQtkE9AEAmAmSyokH09lg1XOD1UqWCgY+HIzOZTojY/zNcOvHhMLFprT4rQ4
 gJ6MWWzkdVcaabAtiHDKuTyb29toi8dSgQMPRNAzlaq7vCaDmSXRwpLEp5tDVdvA+P5V
 bdmg6ZQR/FQan6m0ZW8SeSJtUW7GY9v3lwVaG48OBQCQs8usivhrkXFTYtopEtvbHQ8N nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 323sxxrx52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 07 Jul 2020 14:01:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067DwEhL040674;
        Tue, 7 Jul 2020 14:01:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3233px70st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 14:01:30 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 067E1NQe022252;
        Tue, 7 Jul 2020 14:01:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jul 2020 07:01:23 -0700
Date:   Tue, 7 Jul 2020 07:01:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, fdmanana@gmail.com, dsterba@suse.cz,
        david@fromorbit.com, cluster-devel@redhat.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200707140120.GJ7606@magnolia>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de>
 <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org>
 <20200707134952.3niqhxngwh3gus54@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707134952.3niqhxngwh3gus54@fiona>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 adultscore=0 cotscore=-2147483648 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 suspectscore=1 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070104
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 08:49:52AM -0500, Goldwyn Rodrigues wrote:
> On 13:57 07/07, Matthew Wilcox wrote:
> > On Tue, Jul 07, 2020 at 07:43:46AM -0500, Goldwyn Rodrigues wrote:
> > > On  9:53 01/07, Christoph Hellwig wrote:
> > > > On Mon, Jun 29, 2020 at 02:23:49PM -0500, Goldwyn Rodrigues wrote:
> > > > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > > 
> > > > > For direct I/O, add the flag IOMAP_DIO_RWF_NO_STALE_PAGECACHE to indicate
> > > > > that if the page invalidation fails, return back control to the
> > > > > filesystem so it may fallback to buffered mode.
> > > > > 
> > > > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > 
> > > > I'd like to start a discussion of this shouldn't really be the
> > > > default behavior.  If we have page cache that can't be invalidated it
> > > > actually makes a whole lot of sense to not do direct I/O, avoid the
> > > > warnings, etc.
> > > > 
> > > > Adding all the relevant lists.
> > > 
> > > Since no one responded so far, let me see if I can stir the cauldron :)
> > > 
> > > What error should be returned in case of such an error? I think the
> > 
> > Christoph's message is ambiguous.  I don't know if he means "fail the
> > I/O with an error" or "satisfy the I/O through the page cache".  I'm
> > strongly in favour of the latter.  Indeed, I'm in favour of not invalidating
> > the page cache at all for direct I/O.  For reads, I think the page cache
> > should be used to satisfy any portion of the read which is currently
> 
> That indeed would make reads faster. How about if the pages are dirty
> during DIO reads?
> Should a direct I/O read be responsible for making sure that the dirty
> pages are written back. Technically direct I/O reads is that we are
> reading from the device.

The filemap_write_and_wait_range should persist that data, right?

> > cached.  For writes, I think we should write into the page cache pages
> > which currently exist, and then force those pages to be written back,
> > but left in cache.
> 
> Yes, that makes sense.
> If this is implemented, what would be the difference between O_DIRECT
> and O_DSYNC, if any?

Presumably a direct write would proceed as it does today if there's no
pagecache at all?

--D

> -- 
> Goldwyn
