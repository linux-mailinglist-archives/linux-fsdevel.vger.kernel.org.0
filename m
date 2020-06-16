Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A1F1FBBA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 18:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgFPQZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 12:25:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35292 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgFPQZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:25:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GGLirp060906;
        Tue, 16 Jun 2020 16:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6tLUW1Q0tV/ol/immtHcQsYvkQwpHWrO4p6yajXsBrk=;
 b=lHnJZyv7mdi7nm6nAIgVWrt3JvNsQKwkXrB6KKOKe9yZyph/D12JhEnAP9FOhP38PPMb
 MwmJcghRV+xAG6qQDZiNjkil3IdabDusbFiSPqiqvBtaaFbJn+2E/XdxHn8paUKEDuVo
 WtQuTY3qvbBM9p9vWoO7oTp9we1SVm/Uk00BZEl7VaGYiPQWH/REthD7JepHU5eJGBIN
 O0pVSXcFDwLcEaCig37SMvzhQB6YkwRzYZvDs/lTDokcDTf+rGcidr9m+MAtlesJ56/O
 1MFSbCaTQJpZ1am2+payK67/Yi2sZprM+Quh/3jOm/Gq3RFFtxgxO341LX5qKPdegMei dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31p6s27qt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 16:25:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GGODmi075909;
        Tue, 16 Jun 2020 16:25:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31p6s7sbxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 16:25:42 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05GGPfm4012640;
        Tue, 16 Jun 2020 16:25:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 09:25:41 -0700
Date:   Tue, 16 Jun 2020 09:25:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200616162539.GN11245@magnolia>
References: <20200615160244.741244-1-agruenba@redhat.com>
 <20200615233239.GY2040@dread.disaster.area>
 <20200615234437.GX8681@bombadil.infradead.org>
 <20200616003903.GC2005@dread.disaster.area>
 <315900873.34076732.1592309848873.JavaMail.zimbra@redhat.com>
 <20200616132318.GZ8681@bombadil.infradead.org>
 <CAHc6FU7uU8rUMdkspqH+Zv_O5zi2eEyOYF4x4Je-eCNeM+7NHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7uU8rUMdkspqH+Zv_O5zi2eEyOYF4x4Je-eCNeM+7NHA@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=1 spamscore=0 cotscore=-2147483648 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:57:08PM +0200, Andreas Gruenbacher wrote:
> On Tue, Jun 16, 2020 at 3:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Jun 16, 2020 at 08:17:28AM -0400, Bob Peterson wrote:
> > > ----- Original Message -----
> > > > > I'd assume Andreas is looking at converting a filesystem to use iomap,
> > > > > since this problem only occurs for filesystems which have returned an
> > > > > invalid extent.
> > > >
> > > > Well, I can assume it's gfs2, but you know what happens when you
> > > > assume something....
> > >
> > > Yes, it's gfs2, which already has iomap. I found the bug while just browsing
> > > the code: gfs2 takes a lock in the begin code. If there's an error,
> > > however unlikely, the end code is never called, so we would never unlock.
> > > It doesn't matter to me whether the error is -EIO because it's very unlikely
> > > in the first place. I haven't looked back to see where the problem was
> > > introduced, but I suspect it should be ported back to stable releases.
> >
> > It shouldn't just be "unlikely", it should be impossible.  This is the
> > iomap code checking whether you've returned an extent which doesn't cover
> > the range asked for.  I don't think it needs to be backported, and I'm
> > pretty neutral on whether it needs to be applied.
> 
> Right, when these warnings trigger, the filesystem has already screwed
> up; this fix only makes things less bad. Those kinds of issues are
> very likely to be fixed long before the code hits users, so it
> shouldn't be backported.
> 
> This bug was in iomap_apply right from the start, so:
> 
> Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")

So... you found this through code inspection, and not because you
actually hit this on gfs2, or any of the other iomap users?

I generally think this looks ok, but I want to know if I should be
looking deeper. :)

--D

> Thanks,
> Andreas
> 
