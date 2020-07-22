Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1122A322
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 01:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbgGVXdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 19:33:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36774 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVXdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:33:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MNWDup102917;
        Wed, 22 Jul 2020 23:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=fWpKHgNPZOAzReYr9aant2+0a0UeEh3JZp16QVU89XY=;
 b=vdr4txccZwuqQb8Tv6CDYoYysjRLXjznmFk2R5DukOPaE6xrhaVV1qrXEnKcB+30c5vb
 /K6F+pXY9O0Z1xLuxUUj6I1vcXvDf825U53YqS6zhUNzJDVmMHqDWUWhkGdVpq6cbbyJ
 3wjIfv2+REUS6HTYDp/GlGBFAwSeMan4HyDcyJNNsco7oIPvE66mFYnvC8nSD7zkmvtG
 G5I6/U0DbCMhztLf/1UYFtWPNfFQlPlZCGQH97w5I4o4p5ZY8x2HDWIVkgVhJOYPTqPZ
 KpoO6T7pbNc6t/PNk1ujmxlhl0p2KJ5HrxUldLiUomEbo0b5r6Wj9GBlr7sXMpXOQo5c RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32d6kstfje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 23:32:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MNSHd3141631;
        Wed, 22 Jul 2020 23:32:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32exwvs14e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 23:32:51 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06MNWnxQ030536;
        Wed, 22 Jul 2020 23:32:49 GMT
Received: from localhost (/10.159.241.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jul 2020 23:32:48 +0000
Date:   Wed, 22 Jul 2020 16:32:47 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Satya Tangirala <satyat@google.com>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200722233247.GO3151642@magnolia>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
 <20200722232625.GB83434@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722232625.GB83434@sol.localdomain>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=1
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220146
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 04:26:25PM -0700, Eric Biggers wrote:
> On Wed, Jul 22, 2020 at 03:34:04PM -0700, Eric Biggers wrote:
> > So, something like this:
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 44bad4bb8831..2816194db46c 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3437,6 +3437,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> >  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> >  
> > +	/*
> > +	 * When inline encryption is enabled, sometimes I/O to an encrypted file
> > +	 * has to be broken up to guarantee DUN contiguity.  Handle this by
> > +	 * limiting the length of the mapping returned.
> > +	 */
> > +	if (!(flags & IOMAP_REPORT))
> > +		map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk,
> > +						    map.m_len);
> > +
> >  	if (flags & IOMAP_WRITE)
> >  		ret = ext4_iomap_alloc(inode, &map, flags);
> >  	else
> > 
> > 
> > That also avoids any confusion between pages and blocks, which is nice.
> 
> Correction: for fiemap, ext4 actually uses ext4_iomap_begin_report() instead of
> ext4_iomap_begin().  So we don't need to check for !IOMAP_REPORT.
> 
> Also it could make sense to limit map.m_len after ext4_iomap_alloc() rather than
> before, so that we don't limit the length of the extent that gets allocated but
> rather just the length that gets returned to iomap.

Naïve question here -- if the decision to truncate the bio depends on
the file block offset, can you achieve the same thing by capping the
length of the iovec prior to iomap_dio_rw?

Granted that probably only makes sense if the LBLK IV thing is only
supposed to be used infrequently, and having to opencode a silly loop
might be more hassle than it's worth...

--D

> - Eric
