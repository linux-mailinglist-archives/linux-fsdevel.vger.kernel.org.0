Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73C72D46B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 06:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfE2EIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 00:08:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41560 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfE2EIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 00:08:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4T43PgD098880;
        Wed, 29 May 2019 04:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YsXuvaLoP8CkEmP3grNPfmY1dTu7LJuDRNCQ8nz3iWM=;
 b=wsM/VhqepqVWR4FdyQrr91HiIwr9M+UO6w6JmoXfgm3yDQnMb8KBHlE+qM3nMb3OYViB
 NuxuTWZZIn4ap+vbhZvuojDb2WRQNUXhWpieMW4LbaM603OnndhRsQlWTrrlV8BEK5mc
 Fb1S0/aVsFTWZQ7ettipA5stC1ChxjrXm/joeedruc50jW3SrWDlffMn5Irmo4QCftpx
 X90U8soEpNGFUg/LF5GH8LICae5d2KDqsQAFvgkpGUI5im2lmdhcS8e2SPB21XN+WUAN
 Ggr/yt2tKvskKMJ5WCkRjKF5Bd8519OfBuMK+xaKpg5cgLGyLDgoLuXmzimq/zjsL7rb FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2spxbq6wx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 04:07:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4T46Ru3047228;
        Wed, 29 May 2019 04:07:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2sqh73fe3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 04:07:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4T47K8N025354;
        Wed, 29 May 2019 04:07:21 GMT
Received: from localhost (/10.159.236.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 21:07:20 -0700
Date:   Tue, 28 May 2019 21:07:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190529040719.GL5221@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-5-rgoldwyn@suse.de>
 <20190521165158.GB5125@magnolia>
 <1e9951c1-d320-e480-3130-dc1f4b81ef2c@cn.fujitsu.com>
 <20190523115109.2o4txdjq2ft7fzzc@fiona>
 <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
 <20190528091729.GD9607@quack2.suse.cz>
 <a3a919e6-ecad-bdf6-423c-fc01f9cfa661@cn.fujitsu.com>
 <20190529024749.GC16786@dread.disaster.area>
 <376256fd-dee4-5561-eb4e-546e227303cd@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376256fd-dee4-5561-eb4e-546e227303cd@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290025
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 12:02:40PM +0800, Shiyang Ruan wrote:
> 
> 
> On 5/29/19 10:47 AM, Dave Chinner wrote:
> > On Wed, May 29, 2019 at 10:01:58AM +0800, Shiyang Ruan wrote:
> > > 
> > > On 5/28/19 5:17 PM, Jan Kara wrote:
> > > > On Mon 27-05-19 16:25:41, Shiyang Ruan wrote:
> > > > > On 5/23/19 7:51 PM, Goldwyn Rodrigues wrote:
> > > > > > > 
> > > > > > > Hi,
> > > > > > > 
> > > > > > > I'm working on reflink & dax in XFS, here are some thoughts on this:
> > > > > > > 
> > > > > > > As mentioned above: the second iomap's offset and length must match the
> > > > > > > first.  I thought so at the beginning, but later found that the only
> > > > > > > difference between these two iomaps is @addr.  So, what about adding a
> > > > > > > @saddr, which means the source address of COW extent, into the struct iomap.
> > > > > > > The ->iomap_begin() fills @saddr if the extent is COW, and 0 if not.  Then
> > > > > > > handle this @saddr in each ->actor().  No more modifications in other
> > > > > > > functions.
> > > > > > 
> > > > > > Yes, I started of with the exact idea before being recommended this by Dave.
> > > > > > I used two fields instead of one namely cow_pos and cow_addr which defined
> > > > > > the source details. I had put it as a iomap flag as opposed to a type
> > > > > > which of course did not appeal well.
> > > > > > 
> > > > > > We may want to use iomaps for cases where two inodes are involved.
> > > > > > An example of the other scenario where offset may be different is file
> > > > > > comparison for dedup: vfs_dedup_file_range_compare(). However, it would
> > > > > > need two inodes in iomap as well.
> > > > > > 
> > > > > Yes, it is reasonable.  Thanks for your explanation.
> > > > > 
> > > > > One more thing RFC:
> > > > > I'd like to add an end-io callback argument in ->dax_iomap_actor() to update
> > > > > the metadata after one whole COW operation is completed.  The end-io can
> > > > > also be called in ->iomap_end().  But one COW operation may call
> > > > > ->iomap_apply() many times, and so does the end-io.  Thus, I think it would
> > > > > be nice to move it to the bottom of ->dax_iomap_actor(), called just once in
> > > > > each COW operation.
> > > > 
> > > > I'm sorry but I don't follow what you suggest. One COW operation is a call
> > > > to dax_iomap_rw(), isn't it? That may call iomap_apply() several times,
> > > > each invocation calls ->iomap_begin(), ->actor() (dax_iomap_actor()),
> > > > ->iomap_end() once. So I don't see a difference between doing something in
> > > > ->actor() and ->iomap_end() (besides the passed arguments but that does not
> > > > seem to be your concern). So what do you exactly want to do?
> > > 
> > > Hi Jan,
> > > 
> > > Thanks for pointing out, and I'm sorry for my mistake.  It's
> > > ->dax_iomap_rw(), not ->dax_iomap_actor().
> > > 
> > > I want to call the callback function at the end of ->dax_iomap_rw().
> > > 
> > > Like this:
> > > dax_iomap_rw(..., callback) {
> > > 
> > >      ...
> > >      while (...) {
> > >          iomap_apply(...);
> > >      }
> > > 
> > >      if (callback != null) {
> > >          callback();
> > >      }
> > >      return ...;
> > > }
> > 
> > Why does this need to be in dax_iomap_rw()?
> > 
> > We already do post-dax_iomap_rw() "io-end callbacks" directly in
> > xfs_file_dax_write() to update the file size....
> 
> Yes, but we also need to call ->xfs_reflink_end_cow() after a COW operation.
> And an is-cow flag(from iomap) is also needed to determine if we call it.  I
> think it would be better to put this into ->dax_iomap_rw() as a callback
> function.

Sort of like how iomap_dio_rw takes a write endio function?

--D

> So sorry for my poor expression.
> 
> > 
> > Cheers,
> > 
> > Dave.
> > 
> 
> -- 
> Thanks,
> Shiyang Ruan.
> 
> 
