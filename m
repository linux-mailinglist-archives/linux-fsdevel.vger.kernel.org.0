Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B5EF0BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 23:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfKDWtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 17:49:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43072 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfKDWtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:49:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4MmoVW023005;
        Mon, 4 Nov 2019 22:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=XihttW8iHtYgB3SkypFTop+qrKpNylzrgZ21w5VxPSg=;
 b=VhGbPN0m37/IM7Fbe88wZIalot5pvyEbpQ4Sntt3b4s+Vtkm0dJJP068gdrklpZVta+V
 bypQzhAqDRUygRQEy13OWqfRUOG0ZUDsHJ+JKrrA4z4fqVkV1a1Ovo1xMhNVkclx8Z2L
 27Z554USMEFvj04dcOm7iSLmDew3V98jcbXZrGeQBhv/7zFDp9N9A6tGvfFZSvv1V/gm
 YSXl6tlCy0InFDJDdjw7yNnU6B+FrH2mNHMWg5GdcW0QTcA2qU7zMWRm14uA3QgZsiHl
 huHFDbsOg79pLT+3w8jGwXECDlZmA+tu/uoVxYtPjtFkgGCNp0835ULwHrrEFsVce+c/ cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w12er2cc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 22:48:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4MmeeN189196;
        Mon, 4 Nov 2019 22:48:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w1k8vn85a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 22:48:48 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA4MmJgl017025;
        Mon, 4 Nov 2019 22:48:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 14:48:19 -0800
Date:   Mon, 4 Nov 2019 14:48:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/28] xfs: Throttle commits on delayed background CIL
 push
Message-ID: <20191104224818.GM4153244@magnolia>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-3-david@fromorbit.com>
 <20191101120426.GC59146@bfoster>
 <20191101214040.GX4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101214040.GX4614@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040216
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040216
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 02, 2019 at 08:40:40AM +1100, Dave Chinner wrote:
> On Fri, Nov 01, 2019 at 08:04:26AM -0400, Brian Foster wrote:
> > On Fri, Nov 01, 2019 at 10:45:52AM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > In certain situations the background CIL push can be indefinitely
> > > delayed. While we have workarounds from the obvious cases now, it
> > > doesn't solve the underlying issue. This issue is that there is no
> > > upper limit on the CIL where we will either force or wait for
> > > a background push to start, hence allowing the CIL to grow without
> > > bound until it consumes all log space.
> > > 
> > > To fix this, add a new wait queue to the CIL which allows background
> > > pushes to wait for the CIL context to be switched out. This happens
> > > when the push starts, so it will allow us to block incoming
> > > transaction commit completion until the push has started. This will
> > > only affect processes that are running modifications, and only when
> > > the CIL threshold has been significantly overrun.
> > > 
> > > This has no apparent impact on performance, and doesn't even trigger
> > > until over 45 million inodes had been created in a 16-way fsmark
> > > test on a 2GB log. That was limiting at 64MB of log space used, so
> > > the active CIL size is only about 3% of the total log in that case.
> > > The concurrent removal of those files did not trigger the background
> > > sleep at all.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > 
> > I don't recall posting an R-b tag for this one...
> 
> Argh, sorry. I must have screwed up transcribing them from the
> mailing list.
> 
> > That said, I think my only outstanding feedback (side discussion aside)
> > was the code factoring in xlog_cil_push_background().
> 
> I'll go back and look at that, 'cause clearly I was looking at the
> wrong patch when I screwed up the rvb tag...

I'll keep an eye on the list for a revised series.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
