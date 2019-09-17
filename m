Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 733E8B5349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfIQQqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 12:46:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34156 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfIQQqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:46:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8HGiJ7u050105;
        Tue, 17 Sep 2019 16:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=KskEiAoxVJoFTpBoRSq+oSdCNNqw1hMh6nFtD0noqXs=;
 b=IWfqEIs5nYDKwBGQ+fpw8q/QN0UdprJ+QHmAAstNuoP6yVTh12pV5U/QslfbB++Un6tz
 L4YuhzKiPUMkNLYCFRlZS9ITPnlrqx66su1BnzHe2ChBVJ8KKXaLAGC1XVgNWFHnpVg6
 pUvgJZpBbP7Y0+26H8HYGivir1UFwLPSb+EW32HjHCye+51vVacPzlQjLc8kovhHz6x3
 TX/s3bGC30Ba8VR3KUhmaYPLzwNimb8X/VUPmL5dqFBc4UaBjcMHhX25f8GZ9seJfC9x
 H6mWhik0IAFD9AaoeklVdHp2i9H0qd7IVMsuRoMUSbMR8FJJYYwq0V/GKlgNMF5wPcv/ aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v2bx2yywp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 16:46:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8HGgmbo104524;
        Tue, 17 Sep 2019 16:46:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2v2tmt1dmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 16:46:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8HGk6lC000658;
        Tue, 17 Sep 2019 16:46:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Sep 2019 09:46:06 -0700
Date:   Tue, 17 Sep 2019 09:46:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] splice: only read in as much information as there is
 pipe buffer space
Message-ID: <20190917164605.GM5340@magnolia>
References: <20190829161155.GA5360@magnolia>
 <20190830210603.GB5340@magnolia>
 <20190905034244.GL5340@magnolia>
 <CAHpGcM+iYfqniKugC-enWnx+S3KT=8-YtY9RRcr4bVhG8GtkOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcM+iYfqniKugC-enWnx+S3KT=8-YtY9RRcr4bVhG8GtkOA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909170160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909170160
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:17:22PM +0200, Andreas Grünbacher wrote:
> Am Do., 5. Sept. 2019 um 05:42 Uhr schrieb Darrick J. Wong
> <darrick.wong@oracle.com>:
> > On Fri, Aug 30, 2019 at 02:06:03PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > >
> > > Andreas Grünbacher reports that on the two filesystems that support
> > > iomap directio, it's possible for splice() to return -EAGAIN (instead of
> > > a short splice) if the pipe being written to has less space available in
> > > its pipe buffers than the length supplied by the calling process.
> > >
> > > Months ago we fixed splice_direct_to_actor to clamp the length of the
> > > read request to the size of the splice pipe.  Do the same to do_splice.
> > >
> > > Fixes: 17614445576b6 ("splice: don't read more than available pipe space")
> > > Reported-by: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
> > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > ---
> > > v2: tidy up the other call site per Andreas' request
> >
> > Ping?  Anyone want to add a RVB to this?
> 
> You can add the following:
> 
> Reviewed-by: Andreas Grünbacher <agruenba@redhat.com>
> Tested-by: Andreas Grünbacher <agruenba@redhat.com>
> 
> And could you please update the email address in the reported-by tag as well?

Done.

> Is this going to go in via the xfs tree?

I'll let it soak in -next for a few days and send a single-patch pull
request for it.

(I'm sending out pull requests today for the things that have been
ready to go for the last couple of weeks.)

--D

> Thanks,
> Andreas
