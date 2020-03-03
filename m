Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27D11782B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 20:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgCCTCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 14:02:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgCCTCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:02:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023Ism57023677;
        Tue, 3 Mar 2020 19:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oTkPNBpAzjaa07bjjcQ0CyjgwQohmsclEvvqNhFVktI=;
 b=XCq6bFWgzAXgkdEpmxiuLWO77fbh4sQWOF3n0sGzC+bWNPpl1z5g2RnT6c7LJ9mrdE5C
 GjrhU3hPIra10/NPPy88SYEv8dbdb+pgyldYyDUYh5SzyZTH5/tHVubymyu55NLNdYBq
 K6GsdkkAkF2CaQt6iKaI9pl39aDfWPm/KFqH0Qr8shgqynX9Qaavyoze6VLEEnTI5umg
 VOlNVhop/psdnnwVIeer+faw2ufPhyrhIwB8bvaLVkC9/O++707pYJ3bEVtPD/6FEQdq
 ZVN5SBwgG0CvFkMjiW4zJLMjoFZpDbOeXf4682R62Zv44vS9c0BRkEMd7M6WsPKR7jLE CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yffcuhe6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 19:02:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023IqRNn071830;
        Tue, 3 Mar 2020 19:02:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yg1p55ham-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 19:02:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 023J2Eh3013290;
        Tue, 3 Mar 2020 19:02:14 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 11:02:13 -0800
Date:   Tue, 3 Mar 2020 11:02:12 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200303190212.GC8037@magnolia>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
 <20200229200200.GA10970@dumbo>
 <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 01, 2020 at 10:35:36PM +0100, Rafael J. Wysocki wrote:
> On Sat, Feb 29, 2020 at 9:02 PM Domenico Andreoli
> <domenico.andreoli@linux.com> wrote:
> >
> > On Sat, Feb 29, 2020 at 10:38:20AM -0800, Darrick J. Wong wrote:
> > > On Sat, Feb 29, 2020 at 07:07:16PM +0100, Domenico Andreoli wrote:
> > > > On Sat, Feb 29, 2020 at 09:08:25AM -0800, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > > >
> > > > > It turns out that there /is/ one use case for programs being able to
> > > > > write to swap devices, and that is the userspace hibernation code.  The
> > > > > uswsusp ioctls allow userspace to lease parts of swap devices, so turn
> > > > > S_SWAPFILE off when invoking suspend.
> > > > >
> > > > > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> > > > > Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > > > > Reported-by: Marian Klein <mkleinsoft@gmail.com>
> > > >
> > > > I also tested it yesterday but was not satisfied, unfortunately I did
> > > > not come with my comment in time.
> > > >
> > > > Yes, I confirm that the uswsusp works again but also checked that
> > > > swap_relockall() is not triggered at all and therefore after the first
> > > > hibernation cycle the S_SWAPFILE bit remains cleared and the whole
> > > > swap_relockall() is useless.
> > > >
> > > > I'm not sure this patch should be merged in the current form.
> > >
> > > NNGGHHGGHGH /me is rapidly losing his sanity and will soon just revert
> > > the whole security feature because I'm getting fed up with people
> > > yelling at me *while I'm on vacation* trying to *restore* my sanity.  I
> > > really don't want to be QAing userspace-directed hibernation right now.
> >
> > Maybe we could proceed with the first patch to amend the regression and
> > postpone the improved fix to a later patch? Don't loose sanity for this.
> 
> I would concur here.
> 
> > > ...right, the patch is broken because we have to relock the swapfiles in
> > > whatever code executes after we jump back to the restored kernel, not in
> > > the one that's doing the restoring.  Does this help?
> >
> > I made a few unsuccessful attempts in kernel/power/hibernate.c and
> > eventually I'm switching to qemu to speed up the test cycle.
> >
> > > OTOH, maybe we should just leave the swapfiles unlocked after resume.
> > > Userspace has clearly demonstrated the one usecase for writing to the
> > > swapfile, which means anyone could have jumped in while uswsusp was
> > > running and written whatever crap they wanted to the parts of the swap
> > > file that weren't leased for the hibernate image.
> >
> > Essentially, if the hibernation is supported the swapfile is not totally
> > safe.
> 
> But that's only the case with the userspace variant, isn't it?

Yes.

> > Maybe user-space hibernation should be a separate option.
> 
> That actually is not a bad idea at all in my view.

The trouble with kconfig options is that the distros will be pressued
into setting CONFIG_HIBERNATE_USERSPACE=y to avoid regressing their
uswsusp users, which makes the added security code pointless.  As this
has clearly sucked me into a conflict that I don't have the resources to
pursue, I'm going to revert the write patch checks and move on with
life.

--D

> Thanks!
