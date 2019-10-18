Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2950DBB2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 03:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438997AbfJRBCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 21:02:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56840 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438932AbfJRBCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:02:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I0xAZ8061631;
        Fri, 18 Oct 2019 01:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=KIdZhhQ2Vqp+kaZOoHPRxHGK+Q3KpMgoj0WvJXugb7k=;
 b=AYIORJ8GdoR18Y4ft0wcHXHCL80szwV8y6pzady+EXQsc7nLsV3bCSsFr5VWmoaOkkcT
 VRjlP6lcTTn1RST7AuNAhJwi9oD6CzRhk/49c6AgesUsiLbWe2deK3yyYDzX38PywQ61
 EPyJw4k/PSFPBNS890RxzCz15Y0LmPhx6RpXHTapc+XaZpwP85iYFeBmPc53o1aYYY/j
 KaCGxlwzm3Nc8roHGijbAPV1TkI3c+jfvaQU/LhQOivlKfof1imzTeKjpjcikmtqxy3+
 EWC4/grWYXdocz0j9oV3ix9bGmGVw5vCeAxRaBR2Lkaq8/dTrde4fBR4s2ZVQfbejV2k mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vq0q40hsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 01:02:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I0wCP7053445;
        Fri, 18 Oct 2019 01:02:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vq0ed0fvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 01:02:24 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9I12Mac003521;
        Fri, 18 Oct 2019 01:02:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 01:02:21 +0000
Date:   Thu, 17 Oct 2019 18:02:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 01/14] iomap: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <20191018010220.GR13108@magnolia>
References: <20191017175624.30305-1-hch@lst.de>
 <20191017175624.30305-2-hch@lst.de>
 <20191017183917.GL13108@magnolia>
 <20191017215613.GN16973@dread.disaster.area>
 <20191017230814.GB31874@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017230814.GB31874@bobrowski>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180007
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:08:14AM +1100, Matthew Bobrowski wrote:
> On Fri, Oct 18, 2019 at 08:56:13AM +1100, Dave Chinner wrote:
> > On Thu, Oct 17, 2019 at 11:39:17AM -0700, Darrick J. Wong wrote:
> > > On Thu, Oct 17, 2019 at 07:56:11PM +0200, Christoph Hellwig wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > When doing a direct IO that spans the current EOF, and there are
> > > > written blocks beyond EOF that extend beyond the current write, the
> > > > only metadata update that needs to be done is a file size extension.
> > > > 
> > > > However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> > > > there is IO completion metadata updates required, and hence we may
> > > > fail to correctly sync file size extensions made in IO completion
> > > > when O_DSYNC writes are being used and the hardware supports FUA.
> > > > 
> > > > Hence when setting IOMAP_F_DIRTY, we need to also take into account
> > > > whether the iomap spans the current EOF. If it does, then we need to
> > > > mark it dirty so that IO completion will call generic_write_sync()
> > > > to flush the inode size update to stable storage correctly.
> > > > 
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > Looks ok, but need fixes tag.  Also, might it be wise to split off the
> > > ext4 section into a separate patch so that it can be backported
> > > separately?
> > 
> > I 've done a bit more digging on this, and the ext4 part is not
> > needed for DAX as IOMAP_F_DIRTY is only used in the page fault path
> > and hence can't change the file size. As such, this only affects
> > direct IO. Hence the ext4 hunk can be added to the ext4 iomap-dio
> > patchset that is being developed rather than being in this patch.
> 
> Noted, thanks Dave. I've incorporated the ext4 related change into my patch
> series.

Ok, I've dropped the ext4 hunk from my branch.

--D

> --<M>--
