Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301C61752E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 05:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCBEvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 23:51:12 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34153 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgCBEvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:51:11 -0500
Received: by mail-il1-f194.google.com with SMTP id n11so3145025ild.1;
        Sun, 01 Mar 2020 20:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alTTveLKTo1elfmHPHzMWxdGHAT1S7u6JKso3Pkl1Tg=;
        b=bo6FxVVkuiQi2qqGiBTcsY5WIEzeaUkzfWe1ycgrelgG6CrmG4P0xHFu8Dzz3vWHHm
         sihKM0osjGRfph4Pou1nw/mMJdkE+s54Za0DjZpapvJXDrJ0F/KPGzEU/T7S7i0LeOGU
         TWujb6cRE13rIbohViCRvfIwZj/9iDjVJovveFUX5hN99TINU3L4ToaFyFhKUVV1ha+/
         ZYyaYtzul2ywZ4ourfUAGyYIkp9uDlHlUJJfVTfnmttJLpBhYxLNcEeFNImssOZyIMtk
         Za9QLLO8oS72jPpcK263FwYula9/47t9vGTQbx+W1RckMg55kevzGZbaG767uD+R7Lz8
         g/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alTTveLKTo1elfmHPHzMWxdGHAT1S7u6JKso3Pkl1Tg=;
        b=izjZ88WSHifieH+NAlZBrhiy2NVwcWCvgVpqt1ryKtcv6jCFxnkOtYzI7lSKgCuUSW
         TFna8+1+9B9pHljKjVTTb1MwBgfYiWJlmgYDFT/q7TS6B/ccv6hpZNUC+VDl90g6ul2P
         zX0Hs4S+ju2Z7JETAwbxmKku8h4sm3+4XTYsXMyYGz0BMDl5xaECpr/z1rQhOj26UKN4
         xCmJBPbuJWa6yDnoOYgxBn4G2BcWAbra3eIu8CKDwzybwTNeD27uIMtKBwk0iw6/jIMQ
         SFl8ZzmI/lcPTMCpmm6/Uwrer/Pw0gw9NAMev3jSjU7xVjCghGZ/Rj6AcBqs/IrZSLpb
         p+MQ==
X-Gm-Message-State: APjAAAUJYKGhlOTeEdsrvFNjh9I1dmClqe5VgWEC5dHtDKWUensOC0Zg
        0St2OlVj+P/VIH0wNHUlYyxqVYY/7wc+FmXxo6dsYMcY/Vs=
X-Google-Smtp-Source: APXvYqxtkZqTWghmGlHaI6suboZ+vFHyCwxVH29YA9XEB9zgnrHkTQ9/Aw28bLyE37Wz+pvOuUAzjnYI2+hTkjM80l0=
X-Received: by 2002:a92:489a:: with SMTP id j26mr15961954ilg.226.1583124671019;
 Sun, 01 Mar 2020 20:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20200229170825.GX8045@magnolia> <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia> <20200229200200.GA10970@dumbo> <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
From:   Marian Klein <mkleinsoft@gmail.com>
Date:   Mon, 2 Mar 2020 04:51:00 +0000
Message-ID: <CAA0DKYoFR6WhFLLCYO1GPYHGNZ_mi1773LXoXiC=aByvDF1e2w@mail.gmail.com>
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is active
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick

If security is a concern, maybe it should in kernel config
( CONFIG_ENABLE_HIBERNATION  =  Y/N )
For the security hardened server systems with no hibernation need you
simply configure it to N.

Also the concern the other process can hijack s2disk is unlikely. You
have to realized all processors except for one
are down (See dmesg bellow.) by the time the snapshot image is being  written.
So you can disable scheduler time sharing on this only one processor
when you get snapshot request and no other process can jump in.

I think you can allow (unlock) writing ONLY to  device specified in
kernel parameter
resume=/dev/<swap_device>  and
only when CONFIG_ENABLE_HIBERNATION  =  Y  and there is only one CPU
active (CPU0) and
time sharing scheduler is down and user group from another kernel
parameter snapshot_gid invoked snapshot.
For me secure enough. If any rogue  program pretended to be legitimate
user space hibernation
program it would have to go via actual hibernation cycle (powering off
computer) and that would be obvious to user if that was not triggered
by him
or configured by him to trigger automatically.
It is no way a program secretly could write to resume/swap device.

For normal users often the security is less of concern as they know
who works with their laptop , etc.


[ 1243.100159] Disabling non-boot CPUs ...
[ 1243.101448] smpboot: CPU 1 is now offline
[ 1243.103291] smpboot: CPU 2 is now offline
[ 1243.104851] smpboot: CPU 3 is now offline
[ 1243.106522] smpboot: CPU 4 is now offline
[ 1243.108200] smpboot: CPU 5 is now offline
[ 1243.109928] smpboot: CPU 6 is now offline
[ 1243.111501] smpboot: CPU 7 is now offline
[ 1243.113364] PM: Creating hibernation image:
[ 1243.597752] PM: Need to copy 161991 pages
[ 1243.597756] PM: Normal pages needed: 161991 + 1024, available pages: 3967507
[ 1244.202907] PM: Hibernation image created (161991 pages copied)

On Sun, 1 Mar 2020 at 21:35, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
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
>
> > Maybe user-space hibernation should be a separate option.
>
> That actually is not a bad idea at all in my view.
>
> Thanks!
