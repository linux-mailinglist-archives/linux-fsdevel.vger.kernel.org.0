Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0DD1785F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 23:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgCCWvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 17:51:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34402 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgCCWv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:51:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id i10so3395058wmd.1;
        Tue, 03 Mar 2020 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=laP7MxKBVV8c2S6Jis3XJOTsg2fYmzkinHKDY5LAHSk=;
        b=JD1txqd3IOGqSsEqt8swCfUFgbBgrPmhiSEutbN0R9gWxPYPjvJGz7I+lufHRQFhzZ
         230hUW4irIpjhepNk5MHpNvzC6Azn0NKKId0AZFSs0Ud1yYc/aa3rot6w4szQi3ZQ+bn
         dAQuZ0cG/rz4//MiUtHKdS1qOimj5UeSOopTeBh+9H/hRnOmQbfrDrQcp5SXA+a9hHz2
         hGJicNpF0L+lw3V2XqXAE9wihOueNXKNIcc+e/QIiiIvWks2YVgN0t0uZ4N4l50EI41k
         E+/8GhLa/rGjLL0eHS/PgQyT6uRHxHncWOG8qbQeWVkM1U/+D04dGuDJ73YI1bN8E1l6
         iCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=laP7MxKBVV8c2S6Jis3XJOTsg2fYmzkinHKDY5LAHSk=;
        b=b2LIvOzy/AzKgNs5I0Lq0wnxoDywEV7oc/JHEhnIJaIycOIqZX0JKR/lbHxi4YzQAq
         2YzxeH2fR2/szqIcwX7MSKhVVPyC7qXaE/6d7Y5FLphIN4h06BkC+Vf6AMYhk/5j/JLB
         WP1Vq/aF6YRvgjhU/hm2rBIFGmrtSmoop2GCeMDac9i8169pE8oPMf88C52hNzVJGeuL
         eyRTBIVH09SysDpwMvI4eng7n/4QXgCRd0+FTydmq7icvFyeVMQWP5aUDPSFm2xW4F3K
         8iRhQVaXHajl7E2849Re4QAiF8DJiLiian6yZbeFYdWS2QtQ3tAUIw2ln8BYXpTernRj
         VKDA==
X-Gm-Message-State: ANhLgQ0A1PBn3HSbdhPfyXAaXvyG9NDJIHZj99WWHIfGOgQquBtrOCXQ
        6QH3GIhpwkj8tV6svzzeQg0=
X-Google-Smtp-Source: ADFU+vsxB4sIIDqZMMAXSkE88XTGtmj3FYVjpd4o7rClO/ylj6m4q6JJ2hinEfE1z/DBpSVtYkgMvg==
X-Received: by 2002:a1c:7ed0:: with SMTP id z199mr760362wmc.52.1583275886930;
        Tue, 03 Mar 2020 14:51:26 -0800 (PST)
Received: from localhost ([185.220.101.77])
        by smtp.gmail.com with ESMTPSA id b18sm36280260wrm.86.2020.03.03.14.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 14:51:26 -0800 (PST)
Date:   Tue, 03 Mar 2020 22:51:22 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <20200303190212.GC8037@magnolia>
References: <20200229170825.GX8045@magnolia> <20200229180716.GA31323@dumbo> <20200229183820.GA8037@magnolia> <20200229200200.GA10970@dumbo> <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com> <20200303190212.GC8037@magnolia>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is active
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
From:   Domenico Andreoli <domenico.andreoli.it@gmail.com>
Message-ID: <9E4A0457-39B1-45E2-AEA2-22C730BF2C4F@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On March 3, 2020 7:02:12 PM UTC, "Darrick J=2E Wong" <darrick=2Ewong@oracl=
e=2Ecom> wrote:
>On Sun, Mar 01, 2020 at 10:35:36PM +0100, Rafael J=2E Wysocki wrote:
>> On Sat, Feb 29, 2020 at 9:02 PM Domenico Andreoli
>> <domenico=2Eandreoli@linux=2Ecom> wrote:
>> >
>> > On Sat, Feb 29, 2020 at 10:38:20AM -0800, Darrick J=2E Wong wrote:
>> > > On Sat, Feb 29, 2020 at 07:07:16PM +0100, Domenico Andreoli
>wrote:
>> > > > On Sat, Feb 29, 2020 at 09:08:25AM -0800, Darrick J=2E Wong
>wrote:
>> > > > > From: Darrick J=2E Wong <darrick=2Ewong@oracle=2Ecom>
>> > > > >
>> > > > > It turns out that there /is/ one use case for programs being
>able to
>> > > > > write to swap devices, and that is the userspace hibernation
>code=2E  The
>> > > > > uswsusp ioctls allow userspace to lease parts of swap
>devices, so turn
>> > > > > S_SWAPFILE off when invoking suspend=2E
>> > > > >
>> > > > > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap
>devices")
>> > > > > Reported-by: Domenico Andreoli <domenico=2Eandreoli@linux=2Ecom=
>
>> > > > > Reported-by: Marian Klein <mkleinsoft@gmail=2Ecom>
>> > > >
>> > > > I also tested it yesterday but was not satisfied, unfortunately
>I did
>> > > > not come with my comment in time=2E
>> > > >
>> > > > Yes, I confirm that the uswsusp works again but also checked
>that
>> > > > swap_relockall() is not triggered at all and therefore after
>the first
>> > > > hibernation cycle the S_SWAPFILE bit remains cleared and the
>whole
>> > > > swap_relockall() is useless=2E
>> > > >
>> > > > I'm not sure this patch should be merged in the current form=2E
>> > >
>> > > NNGGHHGGHGH /me is rapidly losing his sanity and will soon just
>revert
>> > > the whole security feature because I'm getting fed up with people
>> > > yelling at me *while I'm on vacation* trying to *restore* my
>sanity=2E  I
>> > > really don't want to be QAing userspace-directed hibernation
>right now=2E
>> >
>> > Maybe we could proceed with the first patch to amend the regression
>and
>> > postpone the improved fix to a later patch? Don't loose sanity for
>this=2E
>>=20
>> I would concur here=2E
>>=20
>> > > =2E=2E=2Eright, the patch is broken because we have to relock the
>swapfiles in
>> > > whatever code executes after we jump back to the restored kernel,
>not in
>> > > the one that's doing the restoring=2E  Does this help?
>> >
>> > I made a few unsuccessful attempts in kernel/power/hibernate=2Ec and
>> > eventually I'm switching to qemu to speed up the test cycle=2E
>> >
>> > > OTOH, maybe we should just leave the swapfiles unlocked after
>resume=2E
>> > > Userspace has clearly demonstrated the one usecase for writing to
>the
>> > > swapfile, which means anyone could have jumped in while uswsusp
>was
>> > > running and written whatever crap they wanted to the parts of the
>swap
>> > > file that weren't leased for the hibernate image=2E
>> >
>> > Essentially, if the hibernation is supported the swapfile is not
>totally
>> > safe=2E
>>=20
>> But that's only the case with the userspace variant, isn't it?
>
>Yes=2E
>
>> > Maybe user-space hibernation should be a separate option=2E
>>=20
>> That actually is not a bad idea at all in my view=2E
>
>The trouble with kconfig options is that the distros will be pressued
>into setting CONFIG_HIBERNATE_USERSPACE=3Dy to avoid regressing their
>uswsusp users, which makes the added security code pointless=2E  As this

True but there are not only distros otherwise the kernel would not have an=
y option at all=2E

It's actually very nice that if hibernation is disabled no userspace is ev=
er allowed to write to the swap=2E

>has clearly sucked me into a conflict that I don't have the resources
>to
>pursue, I'm going to revert the write patch checks and move on with
>life=2E

I don't see the need of reverting anything, I can deal with these issues i=
f you are busy on something else=2E

>
>--D
>
>> Thanks!
