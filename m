Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65A1174FF1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCAVfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:35:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45351 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgCAVfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:35:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so8372591oic.12;
        Sun, 01 Mar 2020 13:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyE5Vq1uGiCQC0izukDlQ84tv/Yn0CZvAVoYGB9H9JA=;
        b=GBPBjI47d9t/tivEhqGG9+sADGiJNuAua35AxK2W6WivFNcMrmnRBhEu580hwKj0bL
         RC0B6u8UUAU+J+Ev/5ec2YSC0fVVLA2cabHjtGcidcXzWicL2TCOmDbii0lWl+/w2tQ9
         DwoEvbYl+Tzy1OfOsuxxJY/6EJEe+o8wwQftr6056rPJqMu1FgVL6/QjJgXoiEjEQU5h
         OXrdvpUg5qklJLBm8P82c76s3xm3z4Cq3UT/zCryf19PQLtu/E+i2Yvc09Tv6EsK37dC
         +lunhe/uuwKzymlcvuXBOITnq+ksHbffu3Oll/ANeX5efJBDvF90y7zppeJ0Srfdzo2x
         0Dhg==
X-Gm-Message-State: APjAAAU0d1J/4T++CRMfw4Y5JOCwblkGO9CDN62HCeaw7o0F9oAOtTO7
        WJrigfc/SP2vgQtUkqX63dQgRiuGaU4Rt3/r0Pk=
X-Google-Smtp-Source: APXvYqwc36SK4tls9i2nd0gdJfBh8IhAkEVLekPBpOVDM5r7DGtogpYivNmpwoiVXWcwTZcRq+oniU0slts/j2CITUc=
X-Received: by 2002:aca:4d82:: with SMTP id a124mr10088079oib.103.1583098547283;
 Sun, 01 Mar 2020 13:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20200229170825.GX8045@magnolia> <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia> <20200229200200.GA10970@dumbo>
In-Reply-To: <20200229200200.GA10970@dumbo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 1 Mar 2020 22:35:36 +0100
Message-ID: <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is active
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 9:02 PM Domenico Andreoli
<domenico.andreoli@linux.com> wrote:
>
> On Sat, Feb 29, 2020 at 10:38:20AM -0800, Darrick J. Wong wrote:
> > On Sat, Feb 29, 2020 at 07:07:16PM +0100, Domenico Andreoli wrote:
> > > On Sat, Feb 29, 2020 at 09:08:25AM -0800, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > >
> > > > It turns out that there /is/ one use case for programs being able to
> > > > write to swap devices, and that is the userspace hibernation code.  The
> > > > uswsusp ioctls allow userspace to lease parts of swap devices, so turn
> > > > S_SWAPFILE off when invoking suspend.
> > > >
> > > > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> > > > Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > > > Reported-by: Marian Klein <mkleinsoft@gmail.com>
> > >
> > > I also tested it yesterday but was not satisfied, unfortunately I did
> > > not come with my comment in time.
> > >
> > > Yes, I confirm that the uswsusp works again but also checked that
> > > swap_relockall() is not triggered at all and therefore after the first
> > > hibernation cycle the S_SWAPFILE bit remains cleared and the whole
> > > swap_relockall() is useless.
> > >
> > > I'm not sure this patch should be merged in the current form.
> >
> > NNGGHHGGHGH /me is rapidly losing his sanity and will soon just revert
> > the whole security feature because I'm getting fed up with people
> > yelling at me *while I'm on vacation* trying to *restore* my sanity.  I
> > really don't want to be QAing userspace-directed hibernation right now.
>
> Maybe we could proceed with the first patch to amend the regression and
> postpone the improved fix to a later patch? Don't loose sanity for this.

I would concur here.

> > ...right, the patch is broken because we have to relock the swapfiles in
> > whatever code executes after we jump back to the restored kernel, not in
> > the one that's doing the restoring.  Does this help?
>
> I made a few unsuccessful attempts in kernel/power/hibernate.c and
> eventually I'm switching to qemu to speed up the test cycle.
>
> > OTOH, maybe we should just leave the swapfiles unlocked after resume.
> > Userspace has clearly demonstrated the one usecase for writing to the
> > swapfile, which means anyone could have jumped in while uswsusp was
> > running and written whatever crap they wanted to the parts of the swap
> > file that weren't leased for the hibernate image.
>
> Essentially, if the hibernation is supported the swapfile is not totally
> safe.

But that's only the case with the userspace variant, isn't it?

> Maybe user-space hibernation should be a separate option.

That actually is not a bad idea at all in my view.

Thanks!
