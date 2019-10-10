Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9976D2D02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfJJOyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 10:54:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47856 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfJJOyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:54:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9AEiHih088078;
        Thu, 10 Oct 2019 14:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bORH0Miq3hDqwrars+0FXlb/1ZUkuZ0v0eG1+czJxqU=;
 b=cow4piG8v/qehJ0wZ6P2aE+e09aSuG/0ySBDmdB+ItEqjLWhZm0H1WeM/ngX1NaQgTFv
 M6kDxmD2myjTKnCyDtXsGzz7l6H/lAxwF+zncesmpbqfjDu9hR6TahYul8FW75wBSuH1
 cRzKDaTsFOgl16EpwIh6MvwkMCBtM9aykKyozmbvaBHl0fLZftvaLwK1sEmwDNSDBVCL
 PsdgD82Eyhag2YpUAHEZNVY9qtW4zl9FrKBnhzzyLe8GBb70wpiDnh4leFNL4PGMip1S
 9qXMnD03IRfKYqrp8/xBf0WrgCdjrQ0NpAsxFBl2A5qHdIoLKeQ6PvhVyBEJATtbWgFM Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejkuupe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 14:47:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9AEcUqA134826;
        Thu, 10 Oct 2019 14:47:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vh5cdd01e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 14:47:20 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9AElJYE031433;
        Thu, 10 Oct 2019 14:47:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 07:47:18 -0700
Date:   Thu, 10 Oct 2019 07:47:18 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 0/2] iomap: Waiting for IO in iomap_dio_rw()
Message-ID: <20191010144718.GI13108@magnolia>
References: <20191009202736.19227-1-jack@suse.cz>
 <20191009230227.GH16973@dread.disaster.area>
 <20191010075420.GA28344@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010075420.GA28344@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100140
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 10, 2019 at 12:54:20AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 10, 2019 at 10:02:27AM +1100, Dave Chinner wrote:
> > That would mean the callers need to do something like this by
> > default:
> > 
> > 	ret = iomap_dio_rw(iocb, iter, ops, dops, is_sync_kiocb(iocb));
> > 
> > And filesystems like XFS will need to do:
> > 
> > 	ret = iomap_dio_rw(iocb, iter, ops, dops,
> > 			is_sync_kiocb(iocb) || unaligned);
> > 
> > and ext4 will calculate the parameter in whatever way it needs to.
> 
> I defintively like that.
> 
> > 
> > In fact, it may be that a wrapper function is better for existing
> > callers:
> > 
> > static inline ssize_t iomap_dio_rw()
> > {
> > 	return iomap_dio_rw_wait(iocb, iter, ops, dops, is_sync_kiocb(iocb));
> > }
> > 
> > And XFS/ext4 writes call iomap_dio_rw_wait() directly. That way we
> > don't need to change the read code at all...
> 
> I have to say I really hated the way we were growing all these wrappers
> in the old direct I/O code, so I've been asked Jan to not add the
> wrapper in his old version.  But compared to the force_sync version it
> at least makes a little more sense here.  I'm just not sure if
> iomap_dio_rw_wait is the right name, but the __-prefix convention for
> non-trivial differences also sucks.  I can't think of a better name,
> though.

<shrug> I'd just add the 'bool wait' parameter at the end of
iomap_dio_rw() and leave it that way.  If we ever develop more than one
caller that passes in "is_sync_kiocb(iocb)" (or more than two lucky
callers screwing it up I guess?) for that parameter then maybe we can
re-evaluate.

--D
