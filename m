Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA70CB3E48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfIPP7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 11:59:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfIPP7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:59:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GFrZTM133541;
        Mon, 16 Sep 2019 15:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=V1gPbP6UbJ4PMEyB24aM+fGZ+fgZF2bnAVOvShOZrpQ=;
 b=sCj2wf7DESace9qHuTtWkdVU4P2pJm8K8evCb4GvzKgHrCXegaVXsJ+EYBJbywTgGqvJ
 BpJJMXOmZ3uRowerlHR8TjwuuNEFxI7JzeMft4hJM8NZJZyZDKEUa6mpK/+zJgazGpC2
 PNGgHPsgcSdvH6hWZ5xcD+8HKyeQMHl4EklGWCMn72IkkPXQlbEIqeUkqenN1na2f8zh
 iN0A0lHlRtjlmapFyuPhHvTOXh2fJ4zl6IOqG1dvflByaY0n/UZ0xXdIsboC66N0XwUC
 nG+u/v6/kvftwZDQdntJKuKYjlZ3y5Jp+E6/Kc6QIm60DZ9TjgxfInqDrGPYexoO1SW4 XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v0ruqgfeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 15:58:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GFwKFw101029;
        Mon, 16 Sep 2019 15:58:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v0nb4x04q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 15:58:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GFwnGP006266;
        Mon, 16 Sep 2019 15:58:51 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 08:58:49 -0700
Date:   Mon, 16 Sep 2019 08:58:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        adilger@dilger.ca, jaegeuk@kernel.org, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190916155848.GW2229799@magnolia>
References: <20190808082744.31405-1-cmaiolino@redhat.com>
 <20190808082744.31405-9-cmaiolino@redhat.com>
 <20190814111837.GE1885@lst.de>
 <20190820130117.gcemlpfrkqlpaaiz@pegasus.maiolino.io>
 <20190829071555.GF11909@lst.de>
 <20190910122833.jsii3us7rhwc5l2p@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910122833.jsii3us7rhwc5l2p@pegasus.maiolino.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160163
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:28:35PM +0200, Carlos Maiolino wrote:
> Hey, thanks for the info.
> 
> Although..
> 
> On Thu, Aug 29, 2019 at 09:15:55AM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 20, 2019 at 03:01:18PM +0200, Carlos Maiolino wrote:
> > > On Wed, Aug 14, 2019 at 01:18:37PM +0200, Christoph Hellwig wrote:
> > > > The whole FIEMAP_KERNEL_FIBMAP thing looks very counter productive.
> > > > bmap() should be able to make the right decision based on the passed
> > > > in flags, no need to have a fake FIEMAP flag for that.
> > > 
> > > Using the FIEMAP_KERNEL_FIBMAP flag, is a way to tell filesystems from where the
> > > request came from, so filesystems can handle it differently. For example, we
> > > can't allow in XFS a FIBMAP request on a COW/RTIME inode, and we use the FIBMAP
> > > flag in such situations.
> > 
> > But the whole point is that the file system should not have to know
> > this.  It is not the file systems business in any way to now where the
> > call came from.  The file system just needs to provide enough information
> > so that the caller can make informed decisions.
> > 
> > And in this case that means if any of FIEMAP_EXTENT_DELALLOC,
> > FIEMAP_EXTENT_ENCODED, FIEMAP_EXTENT_DATA_ENCRYPTED,
> > FIEMAP_EXTENT_NOT_ALIGNED, FIEMAP_EXTENT_DATA_INLINE,
> > FIEMAP_EXTENT_DATA_TAIL, FIEMAP_EXTENT_UNWRITTEN or
> > FIEMAP_EXTENT_SHARED is present the caller should fail the
> > bmap request.
> 
> This seems doable, yes, but... Doing that essentially will make some
> filesystems, like BTRFS, to suddenly start to support fibmap, this was another
> reason why we opted in the first place to let filesystems know whom the caller
> was.
> 
> We could maybe add a new FIEMAP_EXTENT_* flag in the future to, let's say,
> specify a specific block may be split between more than one device, but, well.
> It's an idea, but it won't change the fact BTRFS for example will suddenly start
> to support FIBMAP.

...or burn another superblock sb_flag on "this fs supports FIBMAP";
have the in-kernel bmap() function bail out if it isn't set; and only
set it for the filesystems that used to supply ->bmap?

--D

> -- 
> Carlos
