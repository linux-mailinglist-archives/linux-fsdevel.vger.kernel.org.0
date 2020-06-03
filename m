Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A91ED676
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFCTDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 15:03:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52426 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:03:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053J2UA9103435;
        Wed, 3 Jun 2020 19:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=o7+fler5zTGTJ+y6IwAfjprQ49fo/OV69viq3ZJ03Z8=;
 b=exHuLHlPmoKUl/g6Df8m0R4b/kBt8w5qmGL8h1QMwiMg4ZJn5xh6zcI5uOWJ/QAJteae
 9sjTEPNflDCgZI3NXnLOAEh/X3kLauv5JLGXp9gwjq8hmCpEIkC2Lviuyidsdcu7vMNR
 oaUEBDAzUQgZfI7/4o74jbMclbCkLURv3vSvr10zj8qaVL7uFG8LAIllmvVg35oH3IIG
 MGeJL/9J1nb3Ze5OypiWemywiczFIDUoa0mZKKrMllvKhdkq1rhwH1L4Zpwa/jeeroq7
 0xKmeGl6hioq9o3uLi9ASYFLvD1+WpUdHjI1lJz9vNFBGq85w73HBBq2wG70yXOnwkLz oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31bfemawu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 19:02:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053IvTIL093545;
        Wed, 3 Jun 2020 19:02:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31c12rb6bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 19:02:57 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 053J2tJM023799;
        Wed, 3 Jun 2020 19:02:55 GMT
Received: from localhost (/10.159.239.239)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 12:02:55 -0700
Date:   Wed, 3 Jun 2020 12:02:52 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200603190252.GG8204@magnolia>
References: <20200528192103.xm45qoxqmkw7i5yl@fiona>
 <20200529002319.GQ252930@magnolia>
 <20200601151614.pxy7in4jrvuuy7nx@fiona>
 <CAL3q7H60xa0qW4XdneDdeQyNcJZx7DxtwDiYkuWB5NoUVPYdwQ@mail.gmail.com>
 <CAL3q7H4=N2pfnBSiJ+TApy9kwvcPE5sB92sxcVZN10bxZqQpaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4=N2pfnBSiJ+TApy9kwvcPE5sB92sxcVZN10bxZqQpaA@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=5 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=5
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030147
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:32:15PM +0100, Filipe Manana wrote:
> On Wed, Jun 3, 2020 at 12:23 PM Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > On Mon, Jun 1, 2020 at 4:16 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > >
> > > On 17:23 28/05, Darrick J. Wong wrote:
> > > > On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> > > > >
> > > > > Filesystems such as btrfs are unable to guarantee page invalidation
> > > > > because pages could be locked as a part of the extent. Return zero
> > > >
> > > > Locked for what?  filemap_write_and_wait_range should have just cleaned
> > > > them off.
> > > >
> > > > > in case a page cache invalidation is unsuccessful so filesystems can
> > > > > fallback to buffered I/O. This is similar to
> > > > > generic_file_direct_write().
> > > > >
> > > > > This takes care of the following invalidation warning during btrfs
> > > > > mixed buffered and direct I/O using iomap_dio_rw():
> > > > >
> > > > > Page cache invalidation failure on direct I/O.  Possible data
> > > > > corruption due to collision with buffered I/O!
> > > > >
> > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > >
> > > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > > index e4addfc58107..215315be6233 100644
> > > > > --- a/fs/iomap/direct-io.c
> > > > > +++ b/fs/iomap/direct-io.c
> > > > > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > > > >      */
> > > > >     ret = invalidate_inode_pages2_range(mapping,
> > > > >                     pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > > -   if (ret)
> > > > > -           dio_warn_stale_pagecache(iocb->ki_filp);
> > > > > -   ret = 0;
> > > > > +   /*
> > > > > +    * If a page can not be invalidated, return 0 to fall back
> > > > > +    * to buffered write.
> > > > > +    */
> > > > > +   if (ret) {
> > > > > +           if (ret == -EBUSY)
> > > > > +                   ret = 0;
> > > > > +           goto out_free_dio;
> > > >
> > > > XFS doesn't fall back to buffered io when directio fails, which means
> > > > this will cause a regression there.
> > > >
> > > > Granted mixing write types is bogus...
> > > >
> > >
> > > I have not seen page invalidation failure errors on XFS, but what should

What happens if you try to dirty an mmap page at the same time as
issuing a directio?

> > > happen hypothetically if they do occur? Carry on with the direct I/O?
> > > Would an error return like -ENOTBLK be better?

In the old days, we would only WARN when we encountered collisions like
this.  How about only setting EIO in the mapping if we fail the
pagecache invalidation in directio completion?  If a buffered write
dirties the page after the direct write thread flushes the dirty pages
but before invalidation, we can argue that we didn't lose anything; the
direct write simply happened after the buffered write.

XFS doesn't implement buffered write fallback, and it never has.  Either
the entire directio succeeds, or it returns a negative error code.  Some
of the iomap_dio_rw callers (ext4, jfs2) will notice a short direct
write and try to finish the rest with buffered io, but xfs and zonefs do
not.

The net effect of this (on xfs anyway) is that when buffered and direct
writes collide, before we'd make the buffered writer lose, now we make
the direct writer lose.

You also /could/ propose teaching xfs how to fall back to an
invalidating synchronous buffered write like ext4 does, but that's not
part of this patch set, and that's not a behavior I want to introduce
suddenly during the merge window.

> > It doesn't make much to me to emit the warning and then proceed to the
> > direct IO write path anyway, as if nothing happened.
> > If we are concerned about possible corruption, we should either return
> > an error or fallback to buffered IO just like
> > generic_file_direct_write() did, and not allow the possibility for
> > corruptions.
> >
> > Btw, this is causing a regression in Btrfs now. The problem is that
> > dio_warn_stale_pagecache() sets an EIO error in the inode's mapping:
> >
> > errseq_set(&inode->i_mapping->wb_err, -EIO);
> >
> > So the next fsync on the file will return that error, despite the
> > fsync having completed successfully with any errors.
> >
> > Since patchset to make btrfs direct IO use iomap is already in Linus'
> > tree, we need to fix this somehow.

Y'all /just/ sent the pull request containing that conversion 2 days
ago.  Why did you move forward with that when you knew there were
unresolved fstests failures?

> > This makes generic/547 fail often for example - buffered write against
> > file + direct IO write + fsync - the later returns -EIO.
> 
> Just to make it clear, despite the -EIO error, there was actually no
> data loss or corruption (generic/547 checks that),
> since the direct IO write path in btrfs figures out there's a buffered
> write still ongoing and waits for it to complete before proceeding
> with the dio write.
> 
> Nevertheless, it's still a regression, -EIO shouldn't be returned as
> everything went fine.

Now I'm annoyed because I feel like you're trying to strong-arm me into
making last minute changes to iomap when you could have held off for
another cycle.

While I'm pretty sure your analysis is correct that we could /probably/
get away with only setting EIO if we can't invalidate the cache after
we've already written the disk blocks directly (because then we really
did lose something), I /really/ want these kinds of behavioral changes
to shared code to soak in for-next for long enough that we can work out
the kinks without exposing the upstream kernel to unnecessary risk.

This conversation would be /much/ different had you not just merged the
btrfs directio iomap conversion yesterday.

--D

> 
> >
> > Thanks.
> >
> > >
> > > --
> > > Goldwyn
> >
> >
> >
> > --
> > Filipe David Manana,
> >
> > “Whether you think you can, or you think you can't — you're right.”
> 
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
