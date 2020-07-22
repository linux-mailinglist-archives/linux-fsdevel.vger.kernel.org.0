Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23B229CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 18:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgGVQPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 12:15:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34916 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGVQPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:15:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MFuUmc190158;
        Wed, 22 Jul 2020 16:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wngYaeffss/ZqmZUl6rKo1fTpBJT6kVj81mnBoaEJkk=;
 b=tNfNeGvz1SSwZxRu9fuL4U85ibGGMw0IqTN16mViR+zPmIZ3snSn0UNYIExeUSQz7sWN
 c+Qw0iNhG1sFwBRadVu4Q1KZ1CRgsm/v7GoBgaWc0wwKzzlqbWYsFSFz0NLRYLkTHiKb
 DD9khdBj83kLpNL0l6UEqVxRBUhaGRRUWkk24RDeyDs58cIrEXrvLwO5yIvrXaE1ZZHU
 oOP5F/gDbOj7hlL0sCaUr5KbZqj3ve/JUgyRFFjFRVcC+4yzNMl0lgMA0cp9oQYZho/w
 wLIz8sBM0T9apd4/7RFzs+cnR/YJpWFYXzWVnn1kckJ+VgB3Rtdf5rMmJIe1ebDCDPJQ CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32brgrmaqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 16:15:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MFwB5L096647;
        Wed, 22 Jul 2020 16:15:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32erheh0mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 16:15:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06MGFQFN011293;
        Wed, 22 Jul 2020 16:15:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jul 2020 09:15:25 -0700
Date:   Wed, 22 Jul 2020 09:15:23 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/3] iomap: fall back to buffered writes for invalidation
 failures
Message-ID: <20200722153744.GN3151642@magnolia>
References: <20200721183157.202276-1-hch@lst.de>
 <20200721183157.202276-4-hch@lst.de>
 <20200721203749.GF3151642@magnolia>
 <20200722061850.GA24799@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722061850.GA24799@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=1
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=1 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220108
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 08:18:50AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 01:37:49PM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 21, 2020 at 08:31:57PM +0200, Christoph Hellwig wrote:
> > > Failing to invalid the page cache means data in incoherent, which is
> > > a very bad state for the system.  Always fall back to buffered I/O
> > > through the page cache if we can't invalidate mappings.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Acked-by: Dave Chinner <dchinner@redhat.com>
> > > Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > For the iomap and xfs parts,
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > But I'd still like acks from Ted, Andreas, and Damien for ext4, gfs2,
> > and zonefs, respectively.
> > 
> > (Particularly if anyone was harboring ideas about trying to get this in
> > before 5.10, though I've not yet heard anyone say that explicitly...)
> 
> Why would we want to wait another whole merge window?

Well it /is/ past -rc6, which is a tad late...

OTOH we've been talking about this for 2 months now and most of the
actual behavior change is in xfs land so maybe it's fine. :)

--D
