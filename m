Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F3AEF10A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 00:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfKDXIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 18:08:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33720 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfKDXIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:08:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4N4ip4035088;
        Mon, 4 Nov 2019 23:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=gxLvXRVIvlC8t9cE+U/SR0EVM9phnCKbXLY8pGld1Qc=;
 b=Qa6IGwu44jbOnIGY850ICPyFANffc0JUxxSpyFaEcl1lj+zXGq+Pch1NQlK7Hx4zcJ6N
 A2l9BDyR9nEtdzfw52mPnjCyBw16v/n88lC9Fw3flS/e3QzZEMdyZqS48DZ86jbcdSrR
 7eFQ/GU7C/sW0ShI/y5LNJuJmBTCh7Y5eE/H59J9E7rhDAn8cIwyrMxbGhmpftqZNbBL
 Zmfr/wvXO4I1W6ZjAqWJfnAY/ZwQia3g8YDUw7tR8LWd/POvNPaz4i2Ob2fOTVLdXchk
 t/dzi3I/o0zsxJto3M4r24Q6KXRT6I/b8pxauxdm5YiNO/xxoXaYEbO4DTmtnkmtTRSf Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w12er2eg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:08:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4N4GkQ111801;
        Mon, 4 Nov 2019 23:08:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2w1kxe4nmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:08:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA4N825u011049;
        Mon, 4 Nov 2019 23:08:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 15:08:02 -0800
Date:   Mon, 4 Nov 2019 15:08:01 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191104230801.GO4153244@magnolia>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191030172517.GO15222@magnolia>
 <20191030214335.GQ4614@dread.disaster.area>
 <20191031030658.GW15222@magnolia>
 <20191031205049.GS4614@dread.disaster.area>
 <20191031210551.GK15221@magnolia>
 <20191103212650.GA4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103212650.GA4614@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040219
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040219
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 08:26:50AM +1100, Dave Chinner wrote:
> On Thu, Oct 31, 2019 at 02:05:51PM -0700, Darrick J. Wong wrote:
> > On Fri, Nov 01, 2019 at 07:50:49AM +1100, Dave Chinner wrote:
> > > On Wed, Oct 30, 2019 at 08:06:58PM -0700, Darrick J. Wong wrote:
> > > > > In the case of the xfs_bufs, I've been running workloads recently
> > > > > that cache several million xfs_bufs and only a handful of inodes
> > > > > rather than the other way around. If we spread inodes because
> > > > > caching millions on a single node can cause problems on large NUMA
> > > > > machines, then we also need to spread xfs_bufs...
> > > > 
> > > > Hmm, could we capture this as a comment somewhere?
> > > 
> > > Sure, but where? We're planning on getting rid of the KM_ZONE flags
> > > in the near future, and most of this is specific to the impacts on
> > > XFS. I could put it in xfs-super.c above where we initialise all the
> > > slabs, I guess. Probably a separate patch, though....
> > 
> > Sounds like a reasonable place (to me) to record the fact that we want
> > inodes and metadata buffers not to end up concentrating on a single node.
> 
> Ok. I'll add yet another patch to the preliminary part of the
> series. Any plans to take any of these first few patches in this
> cycle?

I think I have time to review patches this week. :)

(As it occurs to me that the most recent submission of this series
predates this reply, and that's why he couldn't find the patch with
a longer description...)

> > At least until we start having NUMA systems with a separate "IO node" in
> > which to confine all the IO threads and whatnot <shudder>. :P
> 
> Been there, done that, got the t-shirt and wore it out years ago.
> 
> IO-only nodes (either via software configuration, or real
> cpu/memory-less IO nodes) are one of the reasons we don't want
> node-local allocation behaviour for large NUMA configs...

Same, though purely by accident -- CPU mounting bracket cracks, CPU falls
out of machine, but the IO complex is still running, so when the machine
restarts it has a weird NUMA node containing IO but no CPU...

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
