Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D224CAE5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbfJCSiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 14:38:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54610 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbfJCSiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:38:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93IF1kf098731;
        Thu, 3 Oct 2019 18:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=12iqZz4Iis9svz7CFKPbY1KkfRjc2LS2izYN7PduSpQ=;
 b=nWB9znK14Zy4ElhLgIMM/J3LYdDCRCnC74RWh4oj39DnwRu3wNBOZE+w2TQ/GNpcviAB
 S3C+zLMFPmlAP3oAIvpMnpA1IT/c/QhCoUPTWgZX9JWG61GrWpxbnPZvoEKMzLIthqKC
 eMdoCedVWv4QrJBX58ioLy5Phyvvb2nJyQBg/htShLT6R7nlEyiUpZpWHZN5R7H1cz3U
 oVabBJrmOl6cLGKKCUnHiHa3cIrh9mkgroA2WcILW/C7LFqVn+bXaXSVXxUy1LmfbOC+
 7nG/pF7PEI0RzwTzDDhjRhn82oFJQG215S6B+Y7cuAjHK6FsNG0FIflJZmweaM3K3RAV CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2va05s651r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 18:37:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93IJHbF185728;
        Thu, 3 Oct 2019 18:37:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vdn17w57b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 18:37:52 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x93Iboia029775;
        Thu, 3 Oct 2019 18:37:50 GMT
Received: from localhost (/10.145.178.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 11:37:50 -0700
Date:   Thu, 3 Oct 2019 11:37:46 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chris Mason <clm@fb.com>, Gao Xiang <hsiangkao@aol.com>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [5.4-rc1, regression] wb_workfn wakeup oops (was Re: frequent
 5.4-rc1 crash?)
Message-ID: <20191003183746.GK13108@magnolia>
References: <20191003015247.GI13108@magnolia>
 <20191003064022.GX16973@dread.disaster.area>
 <20191003084149.GA16347@hsiangkao-HP-ZHAN-66-Pro-G1>
 <41B90CA7-E093-48FA-BDFD-73BE7EB81FB6@fb.com>
 <32f7c7d8-59d8-7657-4dcc-3741355bf63a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f7c7d8-59d8-7657-4dcc-3741355bf63a@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030152
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 03, 2019 at 08:05:42AM -0600, Jens Axboe wrote:
> On 10/3/19 8:01 AM, Chris Mason wrote:
> > 
> > 
> > On 3 Oct 2019, at 4:41, Gao Xiang wrote:
> > 
> >> Hi,
> >>
> >> On Thu, Oct 03, 2019 at 04:40:22PM +1000, Dave Chinner wrote:
> >>> [cc linux-fsdevel, linux-block, tejun ]
> >>>
> >>> On Wed, Oct 02, 2019 at 06:52:47PM -0700, Darrick J. Wong wrote:
> >>>> Hi everyone,
> >>>>
> >>>> Does anyone /else/ see this crash in generic/299 on a V4 filesystem
> >>>> (tho
> >>>> afaict V5 configs crash too) and a 5.4-rc1 kernel?  It seems to pop
> >>>> up
> >>>> on generic/299 though only 80% of the time.
> >>>>
> >>
> >> Just a quick glance, I guess there could is a race between (complete
> >> guess):
> >>
> >>
> >>   160 static void finish_writeback_work(struct bdi_writeback *wb,
> >>   161                                   struct wb_writeback_work *work)
> >>   162 {
> >>   163         struct wb_completion *done = work->done;
> >>   164
> >>   165         if (work->auto_free)
> >>   166                 kfree(work);
> >>   167         if (done && atomic_dec_and_test(&done->cnt))
> >>
> >>   ^^^ here
> >>
> >>   168                 wake_up_all(done->waitq);
> >>   169 }
> >>
> >> since new wake_up_all(done->waitq); is completely on-stack,
> >>   	if (done && atomic_dec_and_test(&done->cnt))
> >> -		wake_up_all(&wb->bdi->wb_waitq);
> >> +		wake_up_all(done->waitq);
> >>   }
> >>
> >> which could cause use after free if on-stack wb_completion is gone...
> >> (however previous wb->bdi is solid since it is not on-stack)
> >>
> >> see generic on-stack completion which takes a wait_queue spin_lock
> >> between
> >> test and wake_up...
> >>
> >> If I am wrong, ignore me, hmm...
> > 
> > It's a good guess ;)  Jens should have this queued up already:
> > 
> > https://lkml.org/lkml/2019/9/23/972
> 
> Yes indeed, it'll go out today or tomorrow for -rc2.

The patch fixes the problems I've been seeing, so:
Tested-by: Darrick J. Wong <darrick.wong@oracle.com>

Thank you for taking care of this. :)

--D

> -- 
> Jens Axboe
> 
