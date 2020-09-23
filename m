Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C343527504D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 07:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgIWFcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 01:32:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39150 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgIWFcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:32:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N5TiWs139983;
        Wed, 23 Sep 2020 05:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=G5hXmeBriPuvczawrrJxaR7HYulLW2BrXEMOZUOBMKE=;
 b=kmPZlxztsfft1DsIpsyb8UYp/Q4gtet0X3LJfmHK1U0+b9CARONekFzklitm7d1Bz++l
 o6q/w3RmgM5beXvq1wgBR+opbRoIdQKrgLlN8+VOUVSP6PcIBaAED7XgpjKrkxNMYcTK
 uGNZ9IMcZyDa41fy0qP99S2IqQbAKbnCMH5tmznp8CM3Cs/5n6RD67VD9TV4KoDrb8pJ
 QhLJGzRsk2BFzOWQeTUuh8BX/XI/zwNrdPwxPz0qCVn49myw0YkJJ0kVUmHgGIqUPc/x
 XXxiMd1DFlA8vpQCHVUN18yTzMTxaVTIeVhKTANOIxzd9NA7fRqycLufWnq6m5EfHeEq Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33qcptw7ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 05:31:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N5U2xm138095;
        Wed, 23 Sep 2020 05:31:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33nuw5xfbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 05:31:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08N5VpDJ006469;
        Wed, 23 Sep 2020 05:31:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 22:31:51 -0700
Date:   Tue, 22 Sep 2020 22:31:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200923053149.GK7964@magnolia>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-5-rgoldwyn@suse.de>
 <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com>
 <20200922163156.GD7949@magnolia>
 <20200922214934.GC12096@dread.disaster.area>
 <20200923051658.GA14957@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923051658.GA14957@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 adultscore=0 mlxlogscore=899 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=918
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230043
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 07:16:58AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 23, 2020 at 07:49:34AM +1000, Dave Chinner wrote:
> > I did point out in the previous thread that this actually means that
> > inode_dio_wait() now has inconsistent wait semantics for O_DSYNC
> > writes. If it's a pure overwrite and we hit the FUA path, the
> > O_DSYNC write will be complete and guaranteed to be on stable storage
> > before the IO completes. If the inode is metadata dirty, then the IO
> > will now be signalled complete *before* the data and metadata are
> > flushed to stable storage.
> > 
> > Hence, from the perspective of writes to *stable* storage, this
> > makes the ordering of O_DSYNC DIO against anything waiting for it to
> > complete to be potentially inconsistent at the stable storage level.
> > 
> > That's an extremely subtle change of behaviour, and something that
> > would be largely impossible to test or reproduce. And, really, I
> > don't like having this sort of "oh, it should be fine" handwavy
> > justification when we are talking about data integrity operations...
> 
> ... and I replied with a detailed analysis of what it is fine, and
> how this just restores the behavior we historically had before
> switching to the iomap direct I/O code.  Although if we want to go
> into the fine details we did not have the REQ_FUA path back then,
> but that does not change the analysis.

You did?  Got a link?  Not sure if vger/oraclemail are still delaying
messages for me.... :/

--D
