Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519644645FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 05:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbhLAEgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 23:36:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:57965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhLAEgQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638333153;
        bh=AKqwOapI/P1+DWQeKxnW+oEXUCmtI8Mg9I4HQaXQU7Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=UqkvJd2ahQIAuyl9j1YzgMG50sqR/5OpomlZmypMwqGiTP85NDvoqaNiUiBXWvMcP
         oOxyFJEodjklEnh1Tgmq10Z9aT9tc1LZty2e/w+RPyobq6RF6StEhz1pJuxeSE8RpQ
         43zKm1jPIRLT7y3elFCvFlUel/o2H98g3R4Zv1H4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.67]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1mer331C6q-00vNDD; Wed, 01
 Dec 2021 05:32:33 +0100
Message-ID: <b76e36115d202d5cb30dc29496bf5ecddc185fe8.camel@gmx.de>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Alexey Avramov <hakavlad@inbox.lv>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Dec 2021 05:32:31 +0100
In-Reply-To: <20211130130935.GR3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211129150117.GO3366@techsingularity.net>
         <a20f17c4b1b5fdfade3f48375d148e97bd162dd6.camel@gmx.de>
         <20211130112244.GQ3366@techsingularity.net>
         <b8f607c771a4f698fcb651379ca30d3bb6a83ccd.camel@gmx.de>
         <b966ccc578ac60d3684cff0c88c1b9046b408ea3.camel@gmx.de>
         <20211130130935.GR3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P3WByZj5IDN7qpCbMRUdgA/WTK8GizMAVsIN61yMDHaJW9Aq2Vz
 VhFrMz9er39O0JZqazAdxSygFPMsoyMR3PTvUx9VypiXulAqCVgzb9J7H7Htx8D1Etg3sLa
 bK3XbFZHps/IPIfH7yrllKNJF60EYe1nKInrlk3smXjFEiVCJ7yTDaoHjFHEEOBxIOkJoUn
 a1Eaa8x/hEaL9TpLNKabQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:chVfPrHgdZ4=:MJ0T8ADoYCth8LEO+meIi+
 ZN8JysXyiMCqpzeOVqZYC6dfK0v4Y891gd6DUwgcTwx0olADHGZALa8eEmEi95fON0vt+yjQ3
 LSq6PhdpcMCKIvhunYKWk4e7Fy1KmPGXrQ40FlqoiAHXT+udHMTRjSqciLG5mwcONHRJ4VKO7
 EIZfB63BSWr2LK8YpEWQ8VHRenUBhmMGg+nuVUsrys4qBBqFZGnCofltdmacE869mX6QSElnn
 7XalJKsfY7MK0f+ySzPfiJ04PFDQT3IRnIS2qsauYYOo2Hf7YemUQFrRc9sfHtKsX/cWrQvZh
 Y3U+iHBl05NThO93Ey2JeNJNkYnH/pNv/7K0ADDPr0eG1+2bmliwKEvda6eUL/uDj1HNcwm8W
 CbwVE4j/DBEX0bpfcVAS10TDpL6g3BN2Mn5trwne16XRjL81fPp7M67mp+SdZ/9NcuKJU7wMA
 +O1jKm8X+Tjb21uz9Jgp/586nnYQrCmLpy6Dckuqruda/j1oEWYOUysRs1pGxR5YX09SL38Q8
 vprLFMCvlpHcIpd1MdTCgC6/8oDwzFEokbzgubfphTKq2/QjPMD1i4C6IqVk3QqD6zme7eCLu
 JVOZEv8aIopvtBnpB9EiaWqFE/Pgof6HmuN7To/jowyL9gNBk0nwa/iOL0POhqTmEFb3L6oBO
 6qcX4UHLYjrzK/W7/WNJaDbeXn6YLUlDrzmQzEENH0nFNlP1H3c35TWGvCL2rxVYZ5mXY0Juf
 Su7p9LUtlZAxB9Hmh/tVzY+7cxbAWDGcaAaUd8XVRVY6FkxBM8FFp1OrKTo4c3EWcrh+FZBQx
 dOOtdj64MLAlrTMngMCyTQlNWqiHWEKk734q98lZdpsxQccVh+w+demR2enRbBEpUEWGqZXeS
 9jGfp7zV+zNPi6KFhFjGIdgBuYTi9EEXTizId2XOd7CMYYifcyC+4vlwligURhfl+hbGSnm2/
 RZ/f44sIas5T+dR9SItkN3hexqvATpuHAlWffhBVuBRAA+WDJacPekOCgDsnAkiNPKWLEpnKd
 XgX9mBD++xoOneEVMfrBlog7ijKOVRWPUyCh74MHvkYogPLM4jLKZjaekxsXFDpFY8HoGGokU
 aupIRr3fRJdugk=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-11-30 at 13:09 +0000, Mel Gorman wrote:
> On Tue, Nov 30, 2021 at 01:51:10PM +0100, Mike Galbraith wrote:
> > On Tue, 2021-11-30 at 13:00 +0100, Mike Galbraith wrote:
> > > On Tue, 2021-11-30 at 11:22 +0000, Mel Gorman wrote:
> > > > On Tue, Nov 30, 2021 at 11:14:32AM +0100, Mike Galbraith wrote:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (2 * write_pendi=
ng <=3D reclaimable)
> > > > >
> > > > > That is always true here...
> > > > >
> > > >
> > > > Always true for you or always true in general?
> > >
> > > "Here" as in the boxen located at my GPS coordinates :)
> > >
> > > > The intent of the check is "are a majority of reclaimable pages
> > > > marked WRITE_PENDING?". It's similar to the check that existed pri=
or
> > > > to 132b0d21d21f ("mm/page_alloc: remove the throttling logic from =
the
> > > > page allocator").
> > >
> > > I'll put my trace_printk() back and see if I can't bend-adjust it.
> >
> > As it sits, write_pending is always 0 with tail /dev/zero.
> >
>
> That is not a surprise for the test in question as it doesn't trigger
> a case where there are lots of page cache being marked dirty and write
> pending.

I found a way to make it go false, around 80% of the time on the way to
the first oom-kill in fact. Starting 2 memcg stress instances and a
memory sized bonnie did the trick.  'course getting those started was
the last thing my desktop did before taking up residence on spinning
rust and staying there for the 10 minute test duration, mouse pointer
didn't even manage to twitch :)

That's way worse than having box try to swallow /dev/zero, that gets
killed pretty quickly with your latest patch.  The grim reaper tried to
help with nutty overcommit, but two kills in 10 minutes wasn't enough.

	-Mike

