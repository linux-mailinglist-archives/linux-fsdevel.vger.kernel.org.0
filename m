Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD35B6E666F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjDRN4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDRN4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:56:53 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED82698;
        Tue, 18 Apr 2023 06:56:52 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id g187so10788285vsc.10;
        Tue, 18 Apr 2023 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681826211; x=1684418211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrNw7G8x7hVbbtXQiWzjtLEAm6GntFprdxk4GPd9XtQ=;
        b=o2skIU0wL0EU3wqYXCBURZ/oXS9Yefx9x6qzIb73NCqDLy3GBucvbm7yuv1gY3+M4i
         PAjmPCUnSMXBWAggWhLLALCy1K0RGEVsGWi6UBLAjbRD0hAHGU0uQrYRGyhZevOXB/HZ
         /cQj1B6Wdzro/I5Dc/Mg5/BDA13LSVkW3j6fKSdaWqVTnn3z0Rld1TS6Xkmn4LAVm0C9
         dwcbqzE+2va5bAsDarUKsVGXuZxm4SQF0uoloj8yyjt0iEH/jmiPkHg2D31YeVJ+rf7c
         xAwudCnuTQHmkChVTlGxjvfS1isN1O49+/JXl86DRlEHdOrDoJLYOiegt01qTuuB8bxx
         HRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681826211; x=1684418211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrNw7G8x7hVbbtXQiWzjtLEAm6GntFprdxk4GPd9XtQ=;
        b=FYTXIw3zmNJR7ZjwRxx1cBuyRO54z7MJrLBg7vLCA/QYU3GOIGlt1vlgpLwh9RhBPB
         fweufabmJaTmN9PaLdCXwiocQaV7ghRFaiy1mVluKfdsYF77goUoHmO3je1THAqVZ7eR
         LdHMn2d5Y4EcPeiHxRiRtBn09ri4vh/gZ+v6siDBRIE43mrFBqWs2xGTkXSfLTQ+aoMD
         6JjRyqsc8Ne7BgmYqxPBIr01ClZ16iVIPfhquSJI8mB3VGAFvGmLwFvNpLUt2dYGT2nX
         F20TO18kJewpdLdq4AGfqiFbhsddGZOg6vtgzkmE+Z6KK36aeivsUuc0VAkva+x2x9/4
         o00g==
X-Gm-Message-State: AAQBX9eUIlL8zixzDwoN4EwHFtAN7pvn3001JY5gEfVU5l/g54s4Bqx8
        2EmJj+m45Qvf9dfXF80ZJJlZBRlPD2r2zqqsWgE=
X-Google-Smtp-Source: AKy350aUCBqsgDIwP3i3BrAr5U1J52cxBaITLLd3uvw+MJmzUgH6fyq9FZd2caImzUBCdJtpDynfcAK6lG9vGyyxidk=
X-Received: by 2002:a67:d719:0:b0:42c:9397:429 with SMTP id
 p25-20020a67d719000000b0042c93970429mr10908587vsj.0.1681826211278; Tue, 18
 Apr 2023 06:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230414182903.1852019-1-amir73il@gmail.com> <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
In-Reply-To: <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Apr 2023 16:56:40 +0300
Message-ID: <CAOQ4uxj5UwDhV7XxWZ-Os+fzM=_N1DDWHpjmt6UnHr96EDriMw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 4:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Apr 14, 2023 at 09:29:01PM +0300, Amir Goldstein wrote:
> > Jan,
> >
> > Followup on my quest to close the gap with inotify functionality,
> > here is a proposal for FAN_UNMOUNT event.
> >
> > I have had many design questions about this:
>
> I'm going to humbly express what I feel makes sense to me when looking
> at this from a user perspective:
>
> > 1) Should we also report FAN_UNMOUNT for marked inodes and sb
> >    on sb shutdown (same as IN_UNMOUNT)?
>
> My preference would be if this would be a separate event type.
> FAN_SB_SHUTDOWN or something.

If we implement an event for this at all, I would suggest FAN_IGNORED
or FAN_EVICTED, which has the same meaning as IN_IGNORED.
When you get an event that the watch went away, it could be because of:
1. watch removed by user
2. watch removed because inode was evicted (with FAN_MARK_EVICTABLE)
3. inode deleted
4. sb shutdown

IN_IGNORED is generated in all of the above except for inode evict
that is not possible with inotify.

User can figure out on his own if the inode was deleted or if fs was unmoun=
ted,
so there is not really a need for FAN_SB_SHUTDOWN IMO.

Actually, I think that FAN_IGNORED would be quite useful for the
FAN_MARK_EVICTABLE case, but it is a bit less trivial to implement
than FAN_UNMOUNT was.

>
> > 2) Should we also report FAN_UNMOUNT on sb mark for any unmounts
> >    of that sb?
>
> I don't think so. It feels to me that if you watch an sb you don't
> necessarily want to watch bind mounts of that sb.
>
> > 3) Should we report also the fid of the mount root? and if we do...
> > 4) Should we report/consider FAN_ONDIR filter?
> >
> > All of the questions above I answered "not unless somebody requests"
> > in this first RFC.
>
> Fwiw, I agree.
>
> >
> > Specifically, I did get a request for an unmount event for containers
> > use case.
> >
> > I have also had doubts regarding the info records.
> > I decided that reporting fsid and mntid is minimum, but couldn't
> > decide if they were better of in a single MNTID record or seprate
> > records.
> >
> > I went with separate records, because:
> > a) FAN_FS_ERROR has set a precendent of separate fid record with
> >    fsid and empty fid, so I followed this precendent
> > b) MNTID record we may want to add later with FAN_REPORT_MNTID
> >    to all the path events, so better that it is independent
>

Just thought of another reason:
 c) FAN_UNMOUNT does not need to require FAN_REPORT_FID
     so it does not depend on filesystem having a valid f_fsid nor
     exports_ops. In case of "pseudo" fs, FAN_UNMOUNT can report
     only MNTID record (I will amend the patch with this minor change).

> I agree.
>
> >
> > There is test for the proposed API extention [1].
> >
> > Thoughts?
>
> I think this is a rather useful extension!

Thanks for the API review!

Amir.
