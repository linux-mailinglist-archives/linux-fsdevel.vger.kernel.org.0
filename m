Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41B6C5896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 22:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCVVMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCVVMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:12:31 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F2C244AE
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 14:12:30 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id m5so13615618uae.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679519550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzYY5Axlim88H2rD6G7EB68PGEUOgmOczSgkr/nUAj0=;
        b=NAgLYOqE5H21G7YenrkCvmNn11Iiw3uLjwnhrBQqGymwI1Xi4Ei1vBkE65YDJEf1tO
         0/RczkTi/nTJyl4tNsMFRxJwRoupX6Nu1c3dCbI0i1UjJcPu9Zw3w5HDp4luHBJ+bZWv
         pqslVAAx5PObnR2grAolTCo90aLCIsyztRpiebe0ItSd/3GC23dwsrCY1sU7JkfKQs8f
         4pi6ZP9uFThRX+zsb+qr6mYreAneC2o7KwzT7Cjt21ulSsyMZEaJ8rIYxVNFcuByiuxE
         UtETrXNaz5ezuYDEBZ8Y5L8kEqmRHQwu1xHMs+nsrIoG/HlsWhTMClOtoSI0vcYjBXwn
         VBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679519550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzYY5Axlim88H2rD6G7EB68PGEUOgmOczSgkr/nUAj0=;
        b=GZvCAcd/xZSaoBnu6PveqAic1pYShqkKjiLNRac1/RcOg/rYpMWldt2TVvE8pAmm+w
         UafEDfhm3uIlqIFrF6OQ/MaT2EoVdCdW0iv7Ggghqy3onQz0+ETFakrmqDfSepTd0emf
         FzfQKAo9KbokWIxwVHqNlISVYTV3azjnpQ5ftVww9rGML2pzr0Lkoh2eUG1sFM6i7YKS
         A5fTY/Yh18OgU9Sl4oI/CnDe7jt3t/FBtVjNiv4W30zBUma0LUTTDspwrEDP5uzTX9gR
         cgbMfwKY+IJanjzXIY9gH/m+Rum89YRWq7f40jjBukbfvhS3f4h9nuwUp7RO0tasdSaj
         WReg==
X-Gm-Message-State: AAQBX9eQyRynhTpqdBz2rDrJod5LOfJwnSzH73SFy2GK/cMPFaj+B83z
        ZejxuVf1iidhnG680U1qqQIYO9YgdSsvt0MiXZPPAMqisNQ=
X-Google-Smtp-Source: AKy350ZaYq2oqf4/mf7+Uw5JC4ADh+6v99iZAIdQGu97pw3rjoCS4ThdqyIesuOR3ZdaljC6vUu3qKh9i7ccHyiT37s=
X-Received: by 2002:a05:6130:290:b0:73f:f15b:d9e3 with SMTP id
 q16-20020a056130029000b0073ff15bd9e3mr3177973uac.0.1679519549666; Wed, 22 Mar
 2023 14:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
 <CAOQ4uxjF=oTm8wTJvVd0swfcDP0bRUmHSwq5GATYLzvUOsQfXg@mail.gmail.com> <CADNhMOvp3k7fuodMiSzaP-mpf5j1Z7g-_wB5gpJc9p2en6szoA@mail.gmail.com>
In-Reply-To: <CADNhMOvp3k7fuodMiSzaP-mpf5j1Z7g-_wB5gpJc9p2en6szoA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Mar 2023 23:12:18 +0200
Message-ID: <CAOQ4uxhjMfBKYmnvpX29JQkiw+ihFUo5E2RAsoOSxiW+fpzU_w@mail.gmail.com>
Subject: Re: inotify on mmap writes
To:     Amol Dixit <amoldd@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 9:43 PM Amol Dixit <amoldd@gmail.com> wrote:
>
> On Wed, Mar 22, 2023 at 12:16=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > On Wed, Mar 22, 2023 at 4:13=E2=80=AFAM Amol Dixit <amoldd@gmail.com> w=
rote:
> > >
> > > Hello,
> > > Apologies if this has been discussed or clarified in the past.
> > >
> > > The lack of file modification notification events (inotify, fanotify)
> > > for mmap() regions is a big hole to anybody watching file changes fro=
m
> > > userspace. I can imagine atleast 2 reasons why that support may be
> > > lacking, perhaps there are more:
> > >
> > > 1. mmap() writeback is async (unless msync/fsync triggered) driven by
> > > file IO and page cache writeback mechanims, unlike write system calls
> > > that get funneled via the vfs layer, whih is a convenient common plac=
e
> > > to issue notifications. Now mm code would have to find a common groun=
d
> > > with filesystem/vfs, which is messy.
> > >
> > > 2. writepages, being an address-space op is treated by each file
> > > system independently. If mm did not want to get involved, onus would
> > > be on each filesystem to make their .writepages handlers notification
> > > aware. This is probably also considered not worth the trouble.
> > >
> > > So my question is, notwithstanding minor hurdles (like lost events,
> > > hardlinks etc.), would the community like to extend inotify support
> > > for mmap'ed writes to files? Under configs options, would a fix on a
> > > per filesystem basis be an acceptable solution (I can start with say
> > > ext4 writepages linking back to inode/dentry and firing a
> > > notification)?
> > >
> > > Eventually we will have larger support across the board and
> > > inotify/fanotify can be a reliable tracking mechanism for
> > > modifications to files.
> > >
> >
> > What is the use case?
> > Would it be sufficient if you had an OPEN_WRITE event?
> > or if OPEN event had the O_ flags as an extra info to the event?
> > I have a patch for the above and I personally find this information
> > missing from OPEN events.
> >
> > Are you trying to monitor mmap() calls? write to an mmaped area?
> > because writepages() will get you neither of these.
>
> OPEN events are not useful to track file modifications in real time,
> although I can do see the usefulness of OPEN_WRITE events to track
> files that can change.
>
> I am trying to track writes to mmaped area (as these are not notified
> using inotify events). I wanted to ask the community of the
> feasibility and usefulness of this. I had some design ideas of
> tracking writes (using jbd commit callbacks for instance) in the
> kernel, but to make it generic sprucing up the inotify interface is a
> much better approach.
>
> Hope that provides some context.

Not enough.

For a given file mmaped writable by a process that is writing
to that mapped memory all the time for a long time.

What do you expect to happen?
How many events?
On first time write to a page? To the memory region?
When dirty memory is written back to disk?

You have mixed a lot of different things in your question.
You need to be more specific about what the purpose
of this monitoring is.

From all of the above, only MODIFY on mmap() call
seems reasonable to me and MODIFY on first write to
an mmaped area is something that we can consider if
there is very good justification.

FYI, the existing MODIFY events are from after the
write system call modified the page cache and there is
no guarantee about when writeback to disk is done.

Thanks,
Amir.
