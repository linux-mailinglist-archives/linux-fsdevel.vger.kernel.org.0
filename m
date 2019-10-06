Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDD0CD978
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfJFWax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 18:30:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39430 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfJFWax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 18:30:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x96MUiNB161920;
        Sun, 6 Oct 2019 22:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=oM/GyR1hBOmIFzMny+xn2QzNNTjQso5onJlUAmvUFbA=;
 b=F9V8lkjOHar+9wUdyh7qXMborr2AvHGeXZEmlRwjOvPpK+KQDqpvZhP0P5MZ+VGdhe7z
 eoMfg5vVGgKYklRVTm5rc6+wp+fG8cM1ytPZFZiJCXFRTirhsHDfWZxm3b3TOR1W0Aun
 lM2MKTfhP+Pz3f+7CYkBaKX36bX9plbrytwxLJ3sTex6f2eN2EwRCeX1SelffxLnWLFa
 Bv5GhomOVPksYeK42nGWoMcqcqkOP0q539T0nPhd0RjqkfOr0vkADlbD1pjyYXSQg/3m
 W5ZmiWCoyKjR709vpPfAhR9PiItdgp3gHhaZedCcFLWRQSwKE8EgjaQnxow44/KD24gg vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vek4q3w48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 22:30:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x96MRod0091857;
        Sun, 6 Oct 2019 22:30:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vf5aju13f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 22:30:43 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x96MUeZU017103;
        Sun, 6 Oct 2019 22:30:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 06 Oct 2019 15:30:39 -0700
Date:   Sun, 6 Oct 2019 15:30:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chris Mason <clm@fb.com>, Gao Xiang <hsiangkao@aol.com>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [5.4-rc1, regression] wb_workfn wakeup oops (was Re: frequent
 5.4-rc1 crash?)
Message-ID: <20191006223041.GQ13108@magnolia>
References: <20191003015247.GI13108@magnolia>
 <20191003064022.GX16973@dread.disaster.area>
 <20191003084149.GA16347@hsiangkao-HP-ZHAN-66-Pro-G1>
 <41B90CA7-E093-48FA-BDFD-73BE7EB81FB6@fb.com>
 <32f7c7d8-59d8-7657-4dcc-3741355bf63a@kernel.dk>
 <20191003183746.GK13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003183746.GK13108@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910060231
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910060231
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 03, 2019 at 11:37:46AM -0700, Darrick J. Wong wrote:
> On Thu, Oct 03, 2019 at 08:05:42AM -0600, Jens Axboe wrote:
> > On 10/3/19 8:01 AM, Chris Mason wrote:
> > > 
> > > 
> > > On 3 Oct 2019, at 4:41, Gao Xiang wrote:
> > > 
> > >> Hi,
> > >>
> > >> On Thu, Oct 03, 2019 at 04:40:22PM +1000, Dave Chinner wrote:
> > >>> [cc linux-fsdevel, linux-block, tejun ]
> > >>>
> > >>> On Wed, Oct 02, 2019 at 06:52:47PM -0700, Darrick J. Wong wrote:
> > >>>> Hi everyone,
> > >>>>
> > >>>> Does anyone /else/ see this crash in generic/299 on a V4 filesystem
> > >>>> (tho
> > >>>> afaict V5 configs crash too) and a 5.4-rc1 kernel?  It seems to pop
> > >>>> up
> > >>>> on generic/299 though only 80% of the time.
> > >>>>
> > >>
> > >> Just a quick glance, I guess there could is a race between (complete
> > >> guess):
> > >>
> > >>
> > >>   160 static void finish_writeback_work(struct bdi_writeback *wb,
> > >>   161                                   struct wb_writeback_work *work)
> > >>   162 {
> > >>   163         struct wb_completion *done = work->done;
> > >>   164
> > >>   165         if (work->auto_free)
> > >>   166                 kfree(work);
> > >>   167         if (done && atomic_dec_and_test(&done->cnt))
> > >>
> > >>   ^^^ here
> > >>
> > >>   168                 wake_up_all(done->waitq);
> > >>   169 }
> > >>
> > >> since new wake_up_all(done->waitq); is completely on-stack,
> > >>   	if (done && atomic_dec_and_test(&done->cnt))
> > >> -		wake_up_all(&wb->bdi->wb_waitq);
> > >> +		wake_up_all(done->waitq);
> > >>   }
> > >>
> > >> which could cause use after free if on-stack wb_completion is gone...
> > >> (however previous wb->bdi is solid since it is not on-stack)
> > >>
> > >> see generic on-stack completion which takes a wait_queue spin_lock
> > >> between
> > >> test and wake_up...
> > >>
> > >> If I am wrong, ignore me, hmm...
> > > 
> > > It's a good guess ;)  Jens should have this queued up already:
> > > 
> > > https://lkml.org/lkml/2019/9/23/972
> > 
> > Yes indeed, it'll go out today or tomorrow for -rc2.
> 
> The patch fixes the problems I've been seeing, so:
> Tested-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Thank you for taking care of this. :)

Hmm, I don't see this patch in -rc2; did it not go out in time, or were
there further complications?

--D

> --D
> 
> > -- 
> > Jens Axboe
> > 
