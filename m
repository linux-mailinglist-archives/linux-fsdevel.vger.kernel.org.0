Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1BED4727
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfJKSEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 14:04:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfJKSEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:04:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BHrxDS026919;
        Fri, 11 Oct 2019 18:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=r/nL2uivdPhg1qew1vX3qRqEHtUVyf8OXbkjXR1ebqs=;
 b=UR/iCawyh+EEF0jT02vJopxkZaLs8p1NEfAm/7P1cweUDFkURyfy3yEHvqY1w0WuPh3K
 Nq0EsNyZI05tZVbCZc2WtSYC+VYK2uksO85VUqh6cdP5PxMQSBfn9O8S0wEpHO/PlY0k
 05/O3+FmH7ctASYUebqs1C75sKbV3rBpillxGll15HozRD1Zk4324n7ImpJ6U9ay/mZ+
 neqOyJNbGJWNKIrBzZ9Q4Vk2nkEbOXnovMoLYn9MG1YjOSHGmFpm3dICDwd4WOKyP6j+
 o2VKKS2AJaQnSAfgD84FqOfI3nxMNjdIJcpIDteVhabk7niNXJwNThyocTnVrlOKp62w 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vejkv398x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 18:04:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BHr0rG066185;
        Fri, 11 Oct 2019 18:04:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vje2yfrnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 18:04:17 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9BI4EIn032296;
        Fri, 11 Oct 2019 18:04:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 11:04:14 -0700
Date:   Fri, 11 Oct 2019 11:04:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 1/2] iomap: Allow forcing of waiting for running DIO in
 iomap_dio_rw()
Message-ID: <20191011180412.GE13098@magnolia>
References: <20191011125520.11697-1-jack@suse.cz>
 <20191011141433.18354-1-jack@suse.cz>
 <20191011152821.GJ13108@magnolia>
 <20191011163127.GA22122@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011163127.GA22122@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 06:31:27PM +0200, Jan Kara wrote:
> On Fri 11-10-19 08:28:21, Darrick J. Wong wrote:
> > On Fri, Oct 11, 2019 at 04:14:31PM +0200, Jan Kara wrote:
> > > Filesystems do not support doing IO as asynchronous in some cases. For
> > > example in case of unaligned writes or in case file size needs to be
> > > extended (e.g. for ext4). Instead of forcing filesystem to wait for AIO
> > > in such cases, add argument to iomap_dio_rw() which makes the function
> > > wait for IO completion. This also results in executing
> > > iomap_dio_complete() inline in iomap_dio_rw() providing its return value
> > > to the caller as for ordinary sync IO.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> ...
> 
> > > @@ -409,6 +409,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >  	if (!count)
> > >  		return 0;
> > >  
> > > +	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
> > > +		return -EINVAL;
> > 
> > So far in iomap we've been returning EIO when someone internal screws
> > up, which (AFAICT) is the case here.
> 
> Yes. Should I resend with -EIO or will you tweak that on commit?

Yes, please. :)

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
