Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD9163889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 01:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBSA3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 19:29:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48734 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgBSA3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:29:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J0S1ae057927;
        Wed, 19 Feb 2020 00:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sqwF7YxyL7cLyFhkdS9jnzi78bvnBC3UnJX6iZdJn2g=;
 b=qUzYrzF7wT/oRSOtPX99I9MkJeY82vF+p/zWSCVcnl3INom39+wHW4L28GA8iOU3nIvm
 eqnDYNSR8I1PrJTAWcmK7o8bGQjycA2L92vHpHMKhwN0S0q80cykmwtRsHajHf1ETvoM
 GCLcD/sDj5zVZiMPRyMGHQVaw2roDvGgeTRrLpZk2kaKLMhz1QJsCvbW2dSfdFo+4gPE
 0U37gX2hOzCU3qcd0YvyMfThIMbt9kyKqfUnfF/LpOXMSnDwVnpaHRC5nQqK19cUiID+
 ihw4rqADgKV/UItIGrhlmr3Ta6TGbEfCtXAeGBhBKSJfxk8SmNG7ZLyt0936z462pJGK pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y699rsq54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 00:29:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J0RflB058003;
        Wed, 19 Feb 2020 00:29:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y6tc3dg5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 00:29:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01J0THAo016454;
        Wed, 19 Feb 2020 00:29:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 16:29:17 -0800
Date:   Tue, 18 Feb 2020 16:29:16 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200219002916.GB9506@magnolia>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <20200212220600.GS6870@magnolia>
 <20200213151100.GC6548@bfoster>
 <20200213154632.GN7778@bombadil.infradead.org>
 <20200216215556.GZ10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216215556.GZ10776@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 08:55:56AM +1100, Dave Chinner wrote:
> On Thu, Feb 13, 2020 at 07:46:32AM -0800, Matthew Wilcox wrote:
> > On Thu, Feb 13, 2020 at 10:11:00AM -0500, Brian Foster wrote:
> > > With regard to the burnout thing, ISTM the core functionality of the
> > > maintainer is to maintain the integrity of the subtree. That involves
> > > things like enforcing development process (i.e., requiring r-b tags on
> > > all patches to merge), but not necessarily being obligated to resolve
> > > conflicts or to review every patch that comes through in detail, or
> > > guarantee that everything sent to the list makes it into the next
> > > release, etc. If certain things aren't being reviewed in time or making
> > > progress and that somehow results in additional pressure on the
> > > maintainer, ISTM that something is wrong there..?
> > > 
> > > On a more logistical note, didn't we (XFS) discuss the idea of a
> > > rotating maintainership at one point? I know Dave had dealt with burnout
> > > after doing this job for quite some time, Darrick stepped in and it
> > > sounds like he is now feeling it as well (and maybe Eric, having to hold
> > > down the xfsprogs fort). I'm not maintainer nor do I really want to be,
> > > but I'd be willing to contribute to maintainer like duties on a limited
> > > basis if there's a need. For example, if we had a per-release rotation
> > > of 3+ people willing to contribute, perhaps that could spread the pain
> > > around sufficiently..? Just a thought, and of course not being a
> > > maintainer I have no idea how realistic something like that might be..
> > 
> > Not being an XFS person, I don't want to impose anything, but have
> > you read/seen Dan Vetter's talk on this subject?
> > https://blog.ffwll.ch/2017/01/maintainers-dont-scale.html (plenty of
> > links to follow, including particularly https://lwn.net/Articles/705228/ )
> 
> Yes, and I've talked to Dan in great detail about it over several
> past LCAs... :)
> 
> > It seems like the XFS development community might benefit from a
> > group maintainer model.
> 
> Yes, it may well do. The problem is the pool of XFS developers is
> *much smaller* than the graphics subsystem and so a "group
> maintainership" if kinda what we do already. I mean, I do have
> commit rights to the XFS trees kernel.org, even though I'm not a
> maintainer. I'm essentially the backup at this point - if someone
> needs to take time off, I'll take over.
> 
> I think the biggest barrier to maintaining the XFS tree is the
> amount of integration testing that the maintainer does on the merged
> tree.  That's non-trivial, especially with how long it takes to run
> fstests these days. If you're not set up to run QA 24x7 across a
> bunch of different configs, then you need to get that into place
> before being able to do the job of maintaining the XFS kernel
> tree...
> 
> If everyone had that capability and resources at their disposal, then
> rotating the tree maintenance responsibilities would be much
> easier...

I kinda wish the LF or someone would open such a program to the kernel
maintainers.  I never liked that old maxim, "The maintainer is [the
stuckee] with the most testing resources" -- there shouldn't really have
to be a djwong cloud and a dchinner cloud. :/

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
