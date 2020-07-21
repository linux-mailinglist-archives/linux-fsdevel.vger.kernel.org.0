Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5753228460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGUP7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:59:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37984 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGUP7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:59:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFhHgH017335;
        Tue, 21 Jul 2020 15:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+hJjl03dwyfhyAM7vvxyq6ko6TRAkniUFmQ4++wlE5g=;
 b=rpnCULCd1AkP1B+OA+5pMaIBNWGDaZ8AmkPc6oa4SpjJBKa60h9+UAi/zTLjrSbAqdP9
 BSsfsdpupViPWYwVS7bHwuSkNdBYVGYj0AuW3XFKIb6fjBS5LW8C7nKCdkFwCrsCQu2h
 qPiMQURxcl/pGgbHWwCK4OE2DlqA3AAhg/waOfDNgL6GlBcRSf3BSv0BSdlNLLuqCQ2N
 IjjQIcpH+cCgpH4dp4gxOns8bAemL+kgLY74aba63+wliHnhh/N5PFV59qw0MmsCt750
 teRn96WN48l/Zv8YeyvQmTwZHmbR3anLrc7lYrxxuCIjC9PwxHcuj3IaOG+y1f/let4G 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32bs1me47p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 15:59:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFi3A7005806;
        Tue, 21 Jul 2020 15:59:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32e2s92ddt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 15:59:29 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06LFxS58031514;
        Tue, 21 Jul 2020 15:59:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 08:59:27 -0700
Date:   Tue, 21 Jul 2020 08:59:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721155925.GB3151642@magnolia>
References: <20200713074633.875946-1-hch@lst.de>
 <20200720215125.bfz7geaftocy4r5l@fiona>
 <20200721145313.GA9217@lst.de>
 <20200721150432.GH15516@casper.infradead.org>
 <20200721150615.GA10330@lst.de>
 <20200721151437.GI15516@casper.infradead.org>
 <20200721151616.GA11074@lst.de>
 <20200721152754.GD7597@magnolia>
 <20200721154132.GA11652@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721154132.GA11652@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:41:32PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 08:27:54AM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 21, 2020 at 05:16:16PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 21, 2020 at 04:14:37PM +0100, Matthew Wilcox wrote:
> > > > On Tue, Jul 21, 2020 at 05:06:15PM +0200, Christoph Hellwig wrote:
> > > > > On Tue, Jul 21, 2020 at 04:04:32PM +0100, Matthew Wilcox wrote:
> > > > > > I thought you were going to respin this with EREMCHG changed to ENOTBLK?
> > > > > 
> > > > > Oh, true.  I'll do that ASAP.
> > > > 
> > > > Michael, could we add this to manpages?
> > > 
> > > Umm, no.  -ENOTBLK is internal - the file systems will retry using
> > > buffered I/O and the error shall never escape to userspace (or even the
> > > VFS for that matter).
> > 
> > It's worth dropping a comment somewhere that ENOTBLK is the desired
> > "fall back to buffered" errcode, seeing as Dave and I missed that in
> > XFS...
> 
> Sounds like a good idea, but what would a good place be?

In the comment that precedes iomap_dio_rw() for the iomap version,
and...

...ye $deity, the old direct-io.c file is a mess of wrappers.  Uh...  a
new comment preceding __blockdev_direct_IO?  Or blockdev_direct_IO?  Or
both?

Or I guess the direct_IO documentation in vfs.rst...?

``direct_IO``
	called by the generic read/write routines to perform direct_IO -
	that is IO requests which bypass the page cache and transfer
	data directly between the storage and the application's address
	space.  This function can return -ENOTBLK to signal that it is
	necessary to fallback to buffered IO.  Note that
	blockdev_direct_IO and variants can also return -ENOTBLK.

--D
