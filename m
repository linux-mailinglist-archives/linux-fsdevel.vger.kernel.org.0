Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE0178783
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 02:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgCDBTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 20:19:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39166 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgCDBTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:19:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0241ISxD160798;
        Wed, 4 Mar 2020 01:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=grLuKDPTTFY0CmV/uGsgmrfHgzipPlLVNFedH9mbqOQ=;
 b=ny4V7bm43w4QYIt4xeIHCfBvGatAsW5PxgHRmTdnAu1Kt0nf3PMa6IvlW65OrPLJFapd
 JEYHWJ3oMFIjw+mHTnyocSvyk6C+7C+RQg8T1v9LPRPniRn4sph88SGchJdHG94k0CwD
 07xkaCxu94IicIqzNEvYqWVxUxbLGDy5abjcWqKzaurvZRFqqu1UjRBsqo+MwXJDlJja
 oFeh1dPEQsZGp3wntMtn0cy32NnvpmHLVtlBQGGFJ0gu5WG6k4hJ8uQWso5CfxAIz/oJ
 YyNbOuSKwWSk0ZHwlXigcdzEoVBnv7DAqV/ZGlHc72umcfXA6IYh7+3cEeGlTeLEglpw mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yffwqty8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 01:18:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0241GcLM177298;
        Wed, 4 Mar 2020 01:18:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yg1en9r3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 01:18:46 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0241IgMb000659;
        Wed, 4 Mar 2020 01:18:42 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 01:18:42 +0000
Date:   Tue, 3 Mar 2020 17:18:40 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Domenico Andreoli <domenico.andreoli.it@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200304011840.GD1752567@magnolia>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
 <20200229200200.GA10970@dumbo>
 <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
 <20200303190212.GC8037@magnolia>
 <9E4A0457-39B1-45E2-AEA2-22C730BF2C4F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9E4A0457-39B1-45E2-AEA2-22C730BF2C4F@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040007
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:51:22PM +0000, Domenico Andreoli wrote:
> 
> 
> On March 3, 2020 7:02:12 PM UTC, "Darrick J. Wong" <darrick.wong@oracle.com> wrote:
> >On Sun, Mar 01, 2020 at 10:35:36PM +0100, Rafael J. Wysocki wrote:
> >> On Sat, Feb 29, 2020 at 9:02 PM Domenico Andreoli
> >> <domenico.andreoli@linux.com> wrote:
> >> >
> >> > On Sat, Feb 29, 2020 at 10:38:20AM -0800, Darrick J. Wong wrote:
> >> > > On Sat, Feb 29, 2020 at 07:07:16PM +0100, Domenico Andreoli
> >wrote:
> >> > > > On Sat, Feb 29, 2020 at 09:08:25AM -0800, Darrick J. Wong
> >wrote:
> >> > > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> >> > > > >
> >> > > > > It turns out that there /is/ one use case for programs being
> >able to
> >> > > > > write to swap devices, and that is the userspace hibernation
> >code.  The
> >> > > > > uswsusp ioctls allow userspace to lease parts of swap
> >devices, so turn
> >> > > > > S_SWAPFILE off when invoking suspend.
> >> > > > >
> >> > > > > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap
> >devices")
> >> > > > > Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> >> > > > > Reported-by: Marian Klein <mkleinsoft@gmail.com>
> >> > > >
> >> > > > I also tested it yesterday but was not satisfied, unfortunately
> >I did
> >> > > > not come with my comment in time.
> >> > > >
> >> > > > Yes, I confirm that the uswsusp works again but also checked
> >that
> >> > > > swap_relockall() is not triggered at all and therefore after
> >the first
> >> > > > hibernation cycle the S_SWAPFILE bit remains cleared and the
> >whole
> >> > > > swap_relockall() is useless.
> >> > > >
> >> > > > I'm not sure this patch should be merged in the current form.
> >> > >
> >> > > NNGGHHGGHGH /me is rapidly losing his sanity and will soon just
> >revert
> >> > > the whole security feature because I'm getting fed up with people
> >> > > yelling at me *while I'm on vacation* trying to *restore* my
> >sanity.  I
> >> > > really don't want to be QAing userspace-directed hibernation
> >right now.
> >> >
> >> > Maybe we could proceed with the first patch to amend the regression
> >and
> >> > postpone the improved fix to a later patch? Don't loose sanity for
> >this.
> >> 
> >> I would concur here.
> >> 
> >> > > ...right, the patch is broken because we have to relock the
> >swapfiles in
> >> > > whatever code executes after we jump back to the restored kernel,
> >not in
> >> > > the one that's doing the restoring.  Does this help?
> >> >
> >> > I made a few unsuccessful attempts in kernel/power/hibernate.c and
> >> > eventually I'm switching to qemu to speed up the test cycle.
> >> >
> >> > > OTOH, maybe we should just leave the swapfiles unlocked after
> >resume.
> >> > > Userspace has clearly demonstrated the one usecase for writing to
> >the
> >> > > swapfile, which means anyone could have jumped in while uswsusp
> >was
> >> > > running and written whatever crap they wanted to the parts of the
> >swap
> >> > > file that weren't leased for the hibernate image.
> >> >
> >> > Essentially, if the hibernation is supported the swapfile is not
> >totally
> >> > safe.
> >> 
> >> But that's only the case with the userspace variant, isn't it?
> >
> >Yes.
> >
> >> > Maybe user-space hibernation should be a separate option.
> >> 
> >> That actually is not a bad idea at all in my view.
> >
> >The trouble with kconfig options is that the distros will be pressued
> >into setting CONFIG_HIBERNATE_USERSPACE=y to avoid regressing their
> >uswsusp users, which makes the added security code pointless.  As this
> 
> True but there are not only distros otherwise the kernel would not
> have any option at all.
> 
> It's actually very nice that if hibernation is disabled no userspace
> is ever allowed to write to the swap.
> 
> >has clearly sucked me into a conflict that I don't have the resources
> >to
> >pursue, I'm going to revert the write patch checks and move on with
> >life.
> 
> I don't see the need of reverting anything, I can deal with these
> issues if you are busy on something else.

If you want to work on the patch, please do!  Starting from the revert
patch I sent earlier, I /think/ only the first chunk (the one that
touches blkdev_write_iter) of that patch actually has to be applied to
re-enable uswsusp.  That could probably be turned into:

	if (IS_SWAPFILE(...) && !IS_ENABLED(HIBERNATION))
		return -ETXTBSY;

Though perhaps a better thing to check here rather than the Kconfig
option is whether or not the system is locked out against hibernation?
e.g.,

	if (IS_SWAPFILE(...) && !hibernation_available())
		return -EXTBSY;

--D

> >
> >--D
> >
> >> Thanks!
