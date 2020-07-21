Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A812284D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgGUQGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:06:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52130 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbgGUQGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:06:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LG3SUe077647;
        Tue, 21 Jul 2020 16:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=a7wjNPBX2VLwbGesoL6VTOkK6uEZ/3z/Ep3iy3hAJVE=;
 b=VUBjEX1Cb89azRfaE3KbHUUU97n75z1WMfoYZp/DbnK3PV+9qzitcv8lHl2/G6fqBI7s
 IxU1tTnUGxLuJN7Omi1t6JLOk9fbOEekBiO6fKxlWB7ZRo6TUSqHD7ZPHLVpiQfLdT72
 F4/NHGZuypLDlTw6FFjrkkx6WY7tqxQNKoQWuZKl6fENTktbPLoMfZXNXS1dgiMhKWqh
 tqdiwcTiumSNDuHSzA6kEF8t/h8HA4tzB5g0pvJQdpUhz9UEcMsXCQvj/2rrsBWTNDqH
 uUOt+4BlArHi5n+pmYQn3Aez/GHwOtSw+k/fPcffQLpBR8B1VxOcelHC0Hska7zYtgdz DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32d6ksjdcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 16:05:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LG4A4i054834;
        Tue, 21 Jul 2020 16:05:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32e3j403mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 16:05:46 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06LG5iAF015966;
        Tue, 21 Jul 2020 16:05:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 16:05:44 +0000
Date:   Tue, 21 Jul 2020 09:05:42 -0700
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
Message-ID: <20200721160542.GD3151642@magnolia>
References: <20200720215125.bfz7geaftocy4r5l@fiona>
 <20200721145313.GA9217@lst.de>
 <20200721150432.GH15516@casper.infradead.org>
 <20200721150615.GA10330@lst.de>
 <20200721151437.GI15516@casper.infradead.org>
 <20200721151616.GA11074@lst.de>
 <20200721152754.GD7597@magnolia>
 <20200721154132.GA11652@lst.de>
 <20200721155925.GB3151642@magnolia>
 <20200721160143.GA12046@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721160143.GA12046@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 06:01:43PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 08:59:25AM -0700, Darrick J. Wong wrote:
> > In the comment that precedes iomap_dio_rw() for the iomap version,
> 
> maybe let's just do that..
> 
> > ``direct_IO``
> > 	called by the generic read/write routines to perform direct_IO -
> > 	that is IO requests which bypass the page cache and transfer
> > 	data directly between the storage and the application's address
> > 	space.  This function can return -ENOTBLK to signal that it is
> > 	necessary to fallback to buffered IO.  Note that
> > 	blockdev_direct_IO and variants can also return -ENOTBLK.
> 
> ->direct_IO is not used for iomap and various other implementations.
> In fact it is a horrible hack that I've been trying to get rid of
> for a while.

Agreed, but for now there are still a number of fses who are still on
the old directio code; let's try to keep the drainbamage/confusion
potential to a minimum so it doesn't spread to our iomap shinyness. :)

--D
