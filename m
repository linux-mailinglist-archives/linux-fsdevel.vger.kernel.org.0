Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36D543202
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiFHN5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbiFHN45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:56:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D3E1169
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 06:56:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x62so27198648ede.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wwE0unoP9gEwX3qZBuFgRBN3f+/T10rOo/LXy/ltz0=;
        b=dgmB/YghVdC+j53rz8r2eIa0oeMEY8/KltPUI1WjwDBxqkokN8JjMKLga6S4mXzkZn
         ztlWVXbeYZdI7SYyW38vlqCOBxLHUwnA5HJLIGk6IcDp2pSEwh+Xlj6co7q6xNvxZC0c
         hr6aw6Bv95BohHf0pFiIPbleJZDOZtmTHO3Te7mLx7oqkWvX0GZcB+ea1KXxP4/zeM2q
         UBdM73cCbLxgQXjVYo0To2ig5appLINxACwuKTgoSq1I9dQVRjpjSDniteBUb8sl6SnP
         ajl2wM8hnWio4ss59UZBICDX27KCx63VvolFRnCb+B9Tw7FQh+gQJnEJXf3yf5qy4/Ch
         SI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wwE0unoP9gEwX3qZBuFgRBN3f+/T10rOo/LXy/ltz0=;
        b=HIvY1SZixa7SN1pQmJ+qCs6bT+Mwfo1BgGDTGe3JJNqE29j7rtl68p8eC+fDfDDl6f
         9wYhC3MySQ4e/Pw46vyhqARKrHwP3afQ+PepEl5K+unX4aKUgB/QCRns1KscGX0w9rUs
         VKc2joHc9vWNL7LCQt1FBsNMvVWOGj1IhqO9gpGomXQDk94RbYGHTsbP++WkXbm0IFb+
         m8OUpWpqcc2vZ6KaLIHQLXjrAmZDjdJw2aiMedgvAmqgr+HmDSl7ZVLGwlfAz8AG2X0W
         ARm9eXDQNjETQLDI+TnnW9zyiVY7N73kJ44se3IBeSgsWAhIwF0rqJSmT18938D8haed
         Ct4g==
X-Gm-Message-State: AOAM533QC5eNPaMtwLkHiPpm46cjyd8C+ok2TDbxc6Y8JscjjBrL95mD
        uyI0SWejar00XL0baWw3o4enpz8mT6oDzlkQTBlY
X-Google-Smtp-Source: ABdhPJwkt/HypsvRlBngb2nAQwKKYF8P1puyc6PgoJKDG7MaO4efQ9clheHXv8MpjdmkFvGbusHMpKriZqAHesgscDc=
X-Received: by 2002:a05:6402:23a2:b0:42d:d5f1:d470 with SMTP id
 j34-20020a05640223a200b0042dd5f1d470mr26336851eda.365.1654696614164; Wed, 08
 Jun 2022 06:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220607110504.198-1-xieyongji@bytedance.com> <Yp+oEPGnisNx+Nzo@redhat.com>
 <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com> <YqCZt7tyEH50ktKq@redhat.com>
In-Reply-To: <YqCZt7tyEH50ktKq@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 8 Jun 2022 21:57:51 +0800
Message-ID: <CACycT3sMe8EdBWxZhT0HTwVB7mGPk=eV3jG-8EkNK+W-Y_RAiw@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 8, 2022 at 8:44 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jun 08, 2022 at 04:42:46PM +0800, Yongji Xie wrote:
> > On Wed, Jun 8, 2022 at 3:34 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> > > > The commit 15c8e72e88e0 ("fuse: allow skipping control
> > > > interface and forced unmount") tries to remove the control
> > > > interface for virtio-fs since it does not support aborting
> > > > requests which are being processed. But it doesn't work now.
> > >
> > > Aha.., so "no_control" basically has no effect? I was looking at
> > > the code and did not find anybody using "no_control" and I was
> > > wondering who is making use of "no_control" variable.
> > >
> > > I mounted virtiofs and noticed a directory named "40" showed up
> > > under /sys/fs/fuse/connections/. That must be belonging to
> > > virtiofs instance, I am assuming.
> > >
> >
> > I think so.
> >
> > > BTW, if there are multiple fuse connections, how will one figure
> > > out which directory belongs to which instance. Because without knowing
> > > that, one will be shooting in dark while trying to read/write any
> > > of the control files.
> > >
> >
> > We can use "stat $mountpoint" to get the device minor ID which is the
> > name of the corresponding control directory.
> >
> > > So I think a separate patch should be sent which just gets rid of
> > > "no_control" saying nobody uses. it.
> > >
> >
> > OK.
> >
> > > >
> > > > This commit fixes the bug, but only remove the abort interface
> > > > instead since other interfaces should be useful.
> > >
> > > Hmm.., so writing to "abort" file is bad as it ultimately does.
> > >
> > > fc->connected = 0;
> > >
> >
> > Another problem is that it might trigger UAF since
> > virtio_fs_request_complete() doesn't know the requests are aborted.
> >
> > > So getting rid of this file till we support aborting the pending
> > > requests properly, makes sense.
> > >
> > > I think this probably should be a separate patch which explains
> > > why adding "no_abort_control" is a good idea.
> > >
> >
> > OK.
>
> BTW, which particular knob you are finding useful in control filesystem
> for virtiofs. As you mentioned "abort" we will not implement. "waiting"
> might not have much significance as well because requests are handed
> over to virtiofs immidiately and if they can be sent to server (because
> virtqueue is full) these are queued internally and fuse layer will not
> have an idea.
>

Couldn't it be used to check the inflight I/O for virtiofs?

> That leaves us with "congestion_threshold" and "max_background".
> max_background seems to control how many background requests can be
> submitted at a time. That probably can be useful if server is overwhelemed
> and we want to slow down the client a bit.
>
> Not sure about congestion threshold.
>
> So have you found some knob useful for your use case?
>

Since it doesn't do harm to the system, I think it would be better to
just keep it as it is. Maybe some fuse users can make use of it.

Thanks,
Yongji
